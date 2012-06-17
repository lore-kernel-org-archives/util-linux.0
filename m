Return-Path: dave@gnu.org
Subject: [PATCH 9/9] fdisk: API: add geometry
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 17 Jun 2012 18:10:33 +0200
Message-ID: <1339949433.2668.21.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Add device geometry to the fdisk API. While it maintains traditional behaviour, the cylinders
are changed to sector_t instead of unsigned int in order to avoid dealing with truncated cylinders.
A new helper is added to compute the amount of cylinders based on the heads and sectors - if a user passed
-H or -S to the program, it must call this function to update the corresponding values.

This patch passes regression tests.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
I've left get_partition_table_geometry() as the first choice for geometry discovery - this is very DOS.
What about removing this call and only relying on what the bios/kernel says?

 fdisk/fdisk.c         |  185 +++++++++++++++++++++---------------------------
 fdisk/fdisk.h         |   26 +++++---
 fdisk/fdiskaixlabel.c |    2 +-
 fdisk/fdiskbsdlabel.c |   14 ++--
 fdisk/fdiskdoslabel.c |   24 +++---
 fdisk/fdiskmaclabel.c |    2 +-
 fdisk/fdisksgilabel.c |   42 ++++++------
 fdisk/fdisksunlabel.c |   90 ++++++++++++------------
 fdisk/utils.c         |   37 ++++++++++
 9 files changed, 221 insertions(+), 201 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 6f9e412..5393d7e 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -135,15 +135,8 @@ int	nowarn = 0,			/* no warnings for fdisk -l/-s */
 	partitions = 4;			/* maximum partition + 1 */
 
 unsigned int	user_cylinders, user_heads, user_sectors;
-unsigned int   pt_heads, pt_sectors;
-
-sector_t sector_offset = 1, sectors;
-
-unsigned int	heads,
-	cylinders,
-	units_per_sector = 1,
-	display_in_cyl_units = 0;
-
+sector_t sector_offset = 1;
+unsigned int units_per_sector = 1, display_in_cyl_units = 0;
 unsigned long grain = DEFAULT_SECTOR_SIZE;
 enum labeltype disklabel;	/* Current disklabel */
 
@@ -365,18 +358,18 @@ sector_t align_lba(struct fdisk_context *cxt, sector_t lba, int direction)
 	return res;
 }
 
-int warn_geometry(void)
+int warn_geometry(struct fdisk_context *cxt)
 {
 	char *m = NULL;
 	int prev = 0;
 
 	if (disklabel == SGI_LABEL)	/* cannot set cylinders etc anyway */
 		return 0;
-	if (!heads)
+	if (!cxt->geom.heads)
 		prev = test_c(&m, _("heads"));
-	if (!sectors)
+	if (!cxt->geom.sectors)
 		prev = test_c(&m, _("sectors"));
-	if (!cylinders)
+	if (!cxt->geom.cylinders)
 		prev = test_c(&m, _("cylinders"));
 	if (!m)
 		return 0;
@@ -386,9 +379,9 @@ int warn_geometry(void)
 	return 1;
 }
 
-void update_units(void)
+void update_units(struct fdisk_context *cxt)
 {
-	int cyl_units = heads * sectors;
+	int cyl_units = cxt->geom.heads * cxt->geom.sectors;
 
 	if (display_in_cyl_units && cyl_units)
 		units_per_sector = cyl_units;
@@ -438,8 +431,8 @@ void warn_alignment(struct fdisk_context *cxt)
 
 }
 
-static void
-get_partition_table_geometry(struct fdisk_context *cxt) {
+void
+get_partition_table_geometry(struct fdisk_context *cxt, unsigned int *ph, unsigned int *ps) {
 	unsigned char *bufp = cxt->mbr;
 	struct partition *p;
 	int i, h, s, hh, ss;
@@ -465,8 +458,8 @@ get_partition_table_geometry(struct fdisk_context *cxt) {
 	}
 
 	if (!first && !bad) {
-		pt_heads = hh;
-		pt_sectors = ss;
+		*ph = hh;
+		*ps = ss;
 	}
 }
 
@@ -479,7 +472,7 @@ update_sector_offset(struct fdisk_context *cxt)
 	grain = cxt->io_size;
 
 	if (dos_compatible_flag)
-		sector_offset = sectors;	/* usually 63 sectors */
+		sector_offset = cxt->geom.sectors;	/* usually 63 sectors */
 	else {
 		/*
 		 * Align the begin of partitions to:
@@ -520,41 +513,6 @@ update_sector_offset(struct fdisk_context *cxt)
 	}
 }
 
-void
-get_geometry(struct fdisk_context *cxt, struct geom *g)
-{
-	sector_t llcyls;
-	unsigned int kern_heads = 0, kern_sectors = 0;
-
-	heads = cylinders = sectors = 0;
-	pt_heads = pt_sectors = 0;
-
-	blkdev_get_geometry(cxt->dev_fd, &kern_heads, &kern_sectors);
-	get_partition_table_geometry(cxt);
-
-	heads = user_heads ? user_heads :
-		pt_heads ? pt_heads :
-		kern_heads ? kern_heads : 255;
-	sectors = user_sectors ? user_sectors :
-		pt_sectors ? pt_sectors :
-		kern_sectors ? kern_sectors : 63;
-
-	update_sector_offset(cxt);
-
-	llcyls = cxt->total_sectors / (heads * sectors);
-	cylinders = llcyls;
-	if (cylinders != llcyls)	/* truncated? */
-		cylinders = ~0;
-	if (!cylinders)
-		cylinders = user_cylinders;
-
-	if (g) {
-		g->heads = heads;
-		g->sectors = sectors;
-		g->cylinders = cylinders;
-	}
-}
-
 /*
  * Read MBR.  Returns:
  *   -1: no 0xaa55 flag present (possibly entire disk BSD)
@@ -564,9 +522,7 @@ get_geometry(struct fdisk_context *cxt, struct geom *g)
 static int get_boot(struct fdisk_context *cxt, int try_only) {
 
 	disklabel = ANY_LABEL;
-
-	get_geometry(cxt, NULL);
-	update_units();
+	update_units(cxt);
 
 	if (!check_dos_label(cxt))
 		if (check_sun_label(cxt) || check_sgi_label(cxt) || check_aix_label(cxt) 
@@ -752,7 +708,7 @@ read_int_with_suffix(struct fdisk_context *cxt,
 				 * Cylinders
 				 */
 				if (!display_in_cyl_units)
-					res *= heads * sectors;
+					res *= cxt->geom.heads * cxt->geom.sectors;
 			} else if (*line_ptr &&
 				   *(line_ptr + 1) == 'B' &&
 				   *(line_ptr + 2) == '\0') {
@@ -907,10 +863,10 @@ str_units(int n)
 	return P_("sector", "sectors", n);
 }
 
-void change_units(void)
+void change_units(struct fdisk_context *cxt)
 {
 	display_in_cyl_units = !display_in_cyl_units;
-	update_units();
+	update_units(cxt);
 
 	if (display_in_cyl_units)
 		printf(_("Changing display/entry units to cylinders (DEPRECATED!)\n"));
@@ -948,7 +904,7 @@ delete_partition(struct fdisk_context *cxt, int i)
 	if (i < 0)
 		return;
 
-	if (warn_geometry())
+	if (warn_geometry(cxt))
 		return;		/* C/H/S not set */
 
 	ptes[i].changed = 1;
@@ -1044,16 +1000,17 @@ static void change_sysid(struct fdisk_context *cxt)
  * Lubkin Oct.  1991). */
 
 static void
-long2chs(unsigned long ls, unsigned int *c, unsigned int *h, unsigned int *s) {
-	int spc = heads * sectors;
+long2chs(struct fdisk_context *cxt, unsigned long ls, 
+	 unsigned int *c, unsigned int *h, unsigned int *s) {
+	int spc = cxt->geom.heads * cxt->geom.sectors;
 
 	*c = ls / spc;
 	ls = ls % spc;
-	*h = ls / sectors;
-	*s = ls % sectors + 1;	/* sectors count from 1 */
+	*h = ls / cxt->geom.sectors;
+	*s = ls % cxt->geom.sectors + 1;	/* sectors count from 1 */
 }
 
-static void check_consistency(struct partition *p, int partition) {
+static void check_consistency(struct fdisk_context *cxt, struct partition *p, int partition) {
 	unsigned int pbc, pbh, pbs;	/* physical beginning c, h, s */
 	unsigned int pec, peh, pes;	/* physical ending c, h, s */
 	unsigned int lbc, lbh, lbs;	/* logical beginning c, h, s */
@@ -1062,7 +1019,7 @@ static void check_consistency(struct partition *p, int partition) {
 	if (!dos_compatible_flag)
 		return;
 
-	if (!heads || !sectors || (partition >= 4))
+	if (!cxt->geom.heads || !cxt->geom.sectors || (partition >= 4))
 		return;		/* do not check extended partitions */
 
 /* physical beginning c, h, s */
@@ -1076,13 +1033,13 @@ static void check_consistency(struct partition *p, int partition) {
 	pes = p->end_sector & 0x3f;
 
 /* compute logical beginning (c, h, s) */
-	long2chs(get_start_sect(p), &lbc, &lbh, &lbs);
+	long2chs(cxt, get_start_sect(p), &lbc, &lbh, &lbs);
 
 /* compute logical ending (c, h, s) */
-	long2chs(get_start_sect(p) + get_nr_sects(p) - 1, &lec, &leh, &les);
+	long2chs(cxt, get_start_sect(p) + get_nr_sects(p) - 1, &lec, &leh, &les);
 
 /* Same physical / logical beginning? */
-	if (cylinders <= 1024 && (pbc != lbc || pbh != lbh || pbs != lbs)) {
+	if (cxt->geom.cylinders <= 1024 && (pbc != lbc || pbh != lbh || pbs != lbs)) {
 		printf(_("Partition %d has different physical/logical "
 			"beginnings (non-Linux?):\n"), partition + 1);
 		printf(_("     phys=(%d, %d, %d) "), pbc, pbh, pbs);
@@ -1090,7 +1047,7 @@ static void check_consistency(struct partition *p, int partition) {
 	}
 
 /* Same physical / logical ending? */
-	if (cylinders <= 1024 && (pec != lec || peh != leh || pes != les)) {
+	if (cxt->geom.cylinders <= 1024 && (pec != lec || peh != leh || pes != les)) {
 		printf(_("Partition %d has different physical/logical "
 			"endings:\n"), partition + 1);
 		printf(_("     phys=(%d, %d, %d) "), pec, peh, pes);
@@ -1098,7 +1055,7 @@ static void check_consistency(struct partition *p, int partition) {
 	}
 
 /* Ending on cylinder boundary? */
-	if (peh != (heads - 1) || pes != sectors) {
+	if (peh != (cxt->geom.heads - 1) || pes != cxt->geom.sectors) {
 		printf(_("Partition %i does not end on cylinder boundary.\n"),
 			partition + 1);
 	}
@@ -1125,8 +1082,8 @@ list_disk_geometry(struct fdisk_context *cxt) {
 		printf(_("\nDisk %s: %ld.%ld GB, %llu bytes\n"),
 		       cxt->dev_path, hectomega / 10, hectomega % 10, bytes);
 	}
-	printf(_("%d heads, %llu sectors/track, %d cylinders"),
-	       heads, sectors, cylinders);
+	printf(_("%d heads, %llu sectors/track, %llu cylinders"),
+	       cxt->geom.heads, cxt->geom.sectors, cxt->geom.cylinders);
 	if (units_per_sector == 1)
 		printf(_(", total %llu sectors"), cxt->total_sectors);
 	printf("\n");
@@ -1347,7 +1304,7 @@ list_table(struct fdisk_context *cxt, int xtra) {
 /* type id */		p->sys_ind,
 /* type name */		(type = partition_type(p->sys_ind)) ?
 			type : _("Unknown"));
-			check_consistency(p, i);
+			check_consistency(cxt, p, i);
 			check_alignment(cxt, get_partition_start(pe), i);
 		}
 	}
@@ -1366,8 +1323,8 @@ x_list_table(struct fdisk_context *cxt, int extend) {
 	struct partition *p;
 	int i;
 
-	printf(_("\nDisk %s: %d heads, %llu sectors, %d cylinders\n\n"),
-		cxt->dev_path, heads, sectors, cylinders);
+	printf(_("\nDisk %s: %d heads, %llu sectors, %llu cylinders\n\n"),
+		cxt->dev_path, cxt->geom.heads, cxt->geom.sectors, cxt->geom.cylinders);
         printf(_("Nr AF  Hd Sec  Cyl  Hd Sec  Cyl     Start      Size ID\n"));
 	for (i = 0 ; i < partitions; i++) {
 		pe = &ptes[i];
@@ -1382,7 +1339,7 @@ x_list_table(struct fdisk_context *cxt, int extend) {
 				(unsigned long) get_start_sect(p),
 				(unsigned long) get_nr_sects(p), p->sys_ind);
 			if (p->sys_ind) {
-				check_consistency(p, i);
+				check_consistency(cxt, p, i);
 				check_alignment(cxt, get_partition_start(pe), i);
 			}
 		}
@@ -1408,26 +1365,26 @@ void fill_bounds(sector_t *first, sector_t *last)
 }
 
 static void
-check(int n, unsigned int h, unsigned int s, unsigned int c,
+check(struct fdisk_context *cxt, int n, unsigned int h, unsigned int s, unsigned int c,
       unsigned int start) {
 	unsigned int total, real_s, real_c;
 
 	real_s = sector(s) - 1;
 	real_c = cylinder(s, c);
-	total = (real_c * sectors + real_s) * heads + h;
+	total = (real_c * cxt->geom.sectors + real_s) * cxt->geom.heads + h;
 	if (!total)
 		fprintf(stderr, _("Warning: partition %d contains sector 0\n"), n);
-	if (h >= heads)
+	if (h >= cxt->geom.heads)
 		fprintf(stderr,
 			_("Partition %d: head %d greater than maximum %d\n"),
-			n, h + 1, heads);
-	if (real_s >= sectors)
+			n, h + 1, cxt->geom.heads);
+	if (real_s >= cxt->geom.sectors)
 		fprintf(stderr, _("Partition %d: sector %d greater than "
-			"maximum %llu\n"), n, s, sectors);
-	if (real_c >= cylinders)
+			"maximum %llu\n"), n, s, cxt->geom.sectors);
+	if (real_c >= cxt->geom.cylinders)
 		fprintf(stderr, _("Partitions %d: cylinder %d greater than "
-			"maximum %d\n"), n, real_c + 1, cylinders);
-	if (cylinders <= 1024 && start != total)
+			"maximum %llu\n"), n, real_c + 1, cxt->geom.cylinders);
+	if (cxt->geom.cylinders <= 1024 && start != total)
 		fprintf(stderr,
 			_("Partition %d: previous sectors %d disagrees with "
 			"total %d\n"), n, start, total);
@@ -1440,7 +1397,7 @@ verify(struct fdisk_context *cxt) {
 	unsigned long long first[partitions], last[partitions];
 	struct partition *p;
 
-	if (warn_geometry())
+	if (warn_geometry(cxt))
 		return;
 
 	if (disklabel == SUN_LABEL) {
@@ -1459,13 +1416,13 @@ verify(struct fdisk_context *cxt) {
 
 		p = pe->part_table;
 		if (p->sys_ind && !IS_EXTENDED (p->sys_ind)) {
-			check_consistency(p, i);
+			check_consistency(cxt, p, i);
 			check_alignment(cxt, get_partition_start(pe), i);
 			if (get_partition_start(pe) < first[i])
 				printf(_("Warning: bad start-of-data in "
 					"partition %d\n"), i + 1);
-			check(i + 1, p->end_head, p->end_sector, p->end_cyl,
-				last[i]);
+			check(cxt, i + 1, p->end_head, p->end_sector, p->end_cyl,
+			      last[i]);
 			total += last[i] + 1 - first[i];
 			for (j = 0; j < i; j++)
 			if ((first[i] >= first[j] && first[i] <= last[j])
@@ -1519,7 +1476,7 @@ void print_partition_size(struct fdisk_context *cxt,
 
 static void new_partition(struct fdisk_context *cxt)
 {
-	if (warn_geometry())
+	if (warn_geometry(cxt))
 		return;
 
 	if (disklabel == SUN_LABEL) {
@@ -1656,7 +1613,7 @@ move_begin(struct fdisk_context *cxt, int i) {
 	unsigned int new, free_start, curr_start, last;
 	int x;
 
-	if (warn_geometry())
+	if (warn_geometry(cxt))
 		return;
 	if (!p->sys_ind || !get_nr_sects(p) || IS_EXTENDED (p->sys_ind)) {
 		printf(_("Partition %d has no data area\n"), i + 1);
@@ -1723,11 +1680,11 @@ expert_command_prompt(struct fdisk_context *cxt)
 				move_begin(cxt, get_partition(cxt, 0, partitions));
 			break;
 		case 'c':
-			user_cylinders = cylinders =
-				read_int(cxt, 1, cylinders, 1048576, 0,
+			user_cylinders = cxt->geom.cylinders =
+				read_int(cxt, 1, cxt->geom.cylinders, 1048576, 0,
 					 _("Number of cylinders"));
 			if (disklabel == SUN_LABEL)
-				sun_set_ncyl(cxt, cylinders);
+				sun_set_ncyl(cxt, cxt->geom.cylinders);
 			break;
 		case 'd':
 			print_raw(cxt);
@@ -1749,9 +1706,9 @@ expert_command_prompt(struct fdisk_context *cxt)
 			create_sgilabel(cxt);
 			break;
 		case 'h':
-			user_heads = heads = read_int(cxt, 1, heads, 256, 0,
+			user_heads = cxt->geom.heads = read_int(cxt, 1, cxt->geom.heads, 256, 0,
 					 _("Number of heads"));
-			update_units();
+			update_units(cxt);
 			break;
 		case 'i':
 			if (disklabel == SUN_LABEL)
@@ -1774,14 +1731,14 @@ expert_command_prompt(struct fdisk_context *cxt)
 		case 'r':
 			return;
 		case 's':
-			user_sectors = sectors = read_int(cxt, 1, sectors, 63, 0,
+			user_sectors = cxt->geom.sectors = read_int(cxt, 1, cxt->geom.sectors, 63, 0,
 					   _("Number of sectors"));
 			if (dos_compatible_flag)
 				fprintf(stderr, _("Warning: setting "
 					"sector offset for DOS "
 					"compatiblity\n"));
 			update_sector_offset(cxt);
-			update_units();
+			update_units(cxt);
 			break;
 		case 'v':
 			verify(cxt);
@@ -1829,6 +1786,17 @@ static void print_partition_table_from_option(char *device, unsigned long sector
 		err(EXIT_FAILURE, _("unable to open %s"), device);
 	if (sector_size)  /* passed -b option, override autodiscovery */
 		cxt->phy_sector_size = cxt->sector_size = sector_size;
+	/* passed CHS option(s), override autodiscovery */
+	if (user_cylinders)
+		cxt->geom.cylinders = user_cylinders;
+	if (user_heads) {
+		cxt->geom.heads = user_heads;
+		fdisk_geom_set_cyls(cxt);
+	}
+	if (user_sectors) {
+		cxt->geom.sectors = user_sectors;
+		fdisk_geom_set_cyls(cxt);
+	}
 
 	gpt_warning(device);
 	gb = get_boot(cxt, 1);
@@ -1978,7 +1946,7 @@ static void command_prompt(struct fdisk_context *cxt)
 			change_sysid(cxt);
 			break;
 		case 'u':
-			change_units();
+			change_units(cxt);
 			break;
 		case 'v':
 			verify(cxt);
@@ -2086,8 +2054,6 @@ int main(int argc, char **argv)
 		printf(_("Warning: the -b (set sector size) option should"
 			 " be used with one specified device\n"));
 
-	/* init_mbr_buffer(); */
-
 	if (optl) {
 		nowarn = 1;
 		if (argc > optind) {
@@ -2120,6 +2086,17 @@ int main(int argc, char **argv)
 			err(EXIT_FAILURE, _("unable to open %s"), argv[optind]);
 		if (sector_size) /* passed -b option, override autodiscovery */
 			cxt->phy_sector_size = cxt->sector_size = sector_size;
+		/* passed CHS option(s), override autodiscovery */
+		if (user_cylinders)
+			cxt->geom.cylinders = user_cylinders;
+		if (user_heads) {
+			cxt->geom.heads = user_heads;
+			fdisk_geom_set_cyls(cxt);
+		}
+		if (user_sectors) {
+			cxt->geom.sectors = user_sectors;
+			fdisk_geom_set_cyls(cxt);
+		}
 	}
 	else
 		usage(stderr);
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index b4f2814..5b57953 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -36,6 +36,7 @@
 #define FDISK_DEBUG_INIT	(1 << 1)
 #define FDISK_DEBUG_CONTEXT	(1 << 2)
 #define FDISK_DEBUG_TOPOLOGY    (1 << 3)
+#define FDISK_DEBUG_GEOMETRY    (1 << 4)
 #define FDISK_DEBUG_ALL		0xFFFF
 
 # define ON_DBG(m, x)	do { \
@@ -95,14 +96,17 @@ enum failure {
 	unable_to_write
 };
 
-struct geom {
+typedef unsigned long long sector_t;
+
+/*
+ * Legacy CHS based geometry
+ */
+struct fdisk_geometry {
 	unsigned int heads;
-	unsigned int sectors;
-	unsigned int cylinders;
+	sector_t sectors;
+	sector_t cylinders;
 };
 
-typedef unsigned long long sector_t;
-
 struct fdisk_context {
 	int dev_fd;         /* device descriptor */
 	char *dev_path;     /* device path */
@@ -118,6 +122,7 @@ struct fdisk_context {
 
 	/* geometry */
 	sector_t total_sectors; /* in logical sectors */
+	struct fdisk_geometry geom;
 };
 
 extern struct fdisk_context *fdisk_new_context_from_filename(const char *fname, int readonly);
@@ -125,14 +130,14 @@ extern int fdisk_dev_has_topology(struct fdisk_context *cxt);
 extern int fdisk_dev_sectsz_is_default(struct fdisk_context *cxt);
 extern void fdisk_free_context(struct fdisk_context *cxt);
 extern void fdisk_mbr_zeroize(struct fdisk_context *cxt);
+extern void fdisk_geom_set_cyls(struct fdisk_context *cxt);
 
 /* prototypes for fdisk.c */
 extern char *disk_device, *line_ptr;
 extern int fd, partitions;
 extern unsigned int display_in_cyl_units, units_per_sector;
-extern void change_units(void);
+extern void change_units(struct fdisk_context *cxt);
 extern void fatal(struct fdisk_context *cxt, enum failure why);
-extern void get_geometry(struct fdisk_context *, struct geom *);
 extern int  get_partition(struct fdisk_context *cxt, int warn, int max);
 extern void list_types(struct systypes *sys);
 extern int read_line (int *asked);
@@ -151,11 +156,11 @@ extern void fill_bounds(sector_t *first, sector_t *last);
 extern unsigned int heads, cylinders;
 extern sector_t sectors;
 extern char *partition_type(unsigned char type);
-extern void update_units(void);
+extern void update_units(struct fdisk_context *cxt);
 extern char read_chars(char *mesg);
 extern void set_changed(int);
 extern void set_all_unchanged(void);
-extern int warn_geometry(void);
+extern int warn_geometry(struct fdisk_context *cxt);
 extern void warn_limits(struct fdisk_context *cxt);
 extern void warn_alignment(struct fdisk_context *cxt);
 extern unsigned int read_int_with_suffix(struct fdisk_context *cxt,
@@ -163,6 +168,9 @@ extern unsigned int read_int_with_suffix(struct fdisk_context *cxt,
 				  unsigned int base, char *mesg, int *is_suffix_used);
 extern sector_t align_lba(struct fdisk_context *cxt, sector_t lba, int direction);
 extern int get_partition_dflt(struct fdisk_context *cxt, int warn, int max, int dflt);
+extern void update_sector_offset(struct fdisk_context *cxt);
+extern void get_partition_table_geometry(struct fdisk_context *cxt, 
+					 unsigned int *ph, unsigned int *ps);
 
 #define PLURAL	0
 #define SINGULAR 1
diff --git a/fdisk/fdiskaixlabel.c b/fdisk/fdiskaixlabel.c
index c15ab74..fb36489 100644
--- a/fdisk/fdiskaixlabel.c
+++ b/fdisk/fdiskaixlabel.c
@@ -57,7 +57,7 @@ int check_aix_label(struct fdisk_context *cxt)
 	return 0;
     }
     other_endian = (aixlabel->magic == AIX_LABEL_MAGIC_SWAPPED);
-    update_units();
+    update_units(cxt);
     disklabel = AIX_LABEL;
     partitions= 1016;
     volumes = 15;
diff --git a/fdisk/fdiskbsdlabel.c b/fdisk/fdiskbsdlabel.c
index b92530f..dc14581 100644
--- a/fdisk/fdiskbsdlabel.c
+++ b/fdisk/fdiskbsdlabel.c
@@ -213,7 +213,7 @@ bsd_command_prompt (struct fdisk_context *cxt)
 	xbsd_change_fstype ();
 	break;
       case 'u':
-	change_units();
+	change_units(cxt);
 	break;
       case 'w':
 	xbsd_write_disklabel (cxt);
@@ -636,9 +636,7 @@ static int
 xbsd_initlabel (struct fdisk_context *cxt, struct partition *p, struct xbsd_disklabel *d,
 		int pindex __attribute__((__unused__))) {
 	struct xbsd_partition *pp;
-	struct geom g;
-
-	get_geometry (cxt, &g);
+	
 	memset (d, 0, sizeof (struct xbsd_disklabel));
 
 	d -> d_magic = BSD_DISKMAGIC;
@@ -658,10 +656,10 @@ xbsd_initlabel (struct fdisk_context *cxt, struct partition *p, struct xbsd_disk
 	d -> d_flags = 0;
 #endif
 	d -> d_secsize = SECTOR_SIZE;		/* bytes/sector  */
-	d -> d_nsectors = g.sectors;		/* sectors/track */
-	d -> d_ntracks = g.heads;		/* tracks/cylinder (heads) */
-	d -> d_ncylinders = g.cylinders;
-	d -> d_secpercyl  = g.sectors * g.heads;/* sectors/cylinder */
+	d -> d_nsectors = cxt->geom.sectors;		/* sectors/track */
+	d -> d_ntracks = cxt->geom.heads;		/* tracks/cylinder (heads) */
+	d -> d_ncylinders = cxt->geom.cylinders;
+	d -> d_secpercyl  = cxt->geom.sectors * cxt->geom.heads;/* sectors/cylinder */
 	if (d -> d_secpercyl == 0)
 		d -> d_secpercyl = 1;		/* avoid segfaults */
 	d -> d_secperunit = d -> d_secpercyl * d -> d_ncylinders;
diff --git a/fdisk/fdiskdoslabel.c b/fdisk/fdiskdoslabel.c
index abf101b..a72a432 100644
--- a/fdisk/fdiskdoslabel.c
+++ b/fdisk/fdiskdoslabel.c
@@ -14,12 +14,12 @@
 #include "fdiskdoslabel.h"
 
 #define set_hsc(h,s,c,sector) { \
-		s = sector % sectors + 1;			\
-		sector /= sectors;				\
-		h = sector % heads;				\
-		sector /= heads;				\
-		c = sector & 0xff;				\
-		s |= (sector >> 2) & 0xc0;			\
+		s = sector % cxt->geom.sectors + 1;			\
+		sector /= cxt->geom.sectors;				\
+		h = sector % cxt->geom.heads;				\
+		sector /= cxt->geom.heads;				\
+		c = sector & 0xff;					\
+		s |= (sector >> 2) & 0xc0;				\
 	}
 
 #define alignment_required	(grain != cxt->sector_size)
@@ -115,7 +115,7 @@ void dos_init(struct fdisk_context *cxt)
 		pe->changed = 0;
 	}
 
-	warn_geometry();
+	warn_geometry(cxt);
 	warn_limits(cxt);
 	warn_alignment(cxt);
 }
@@ -389,11 +389,11 @@ static void set_partition(struct fdisk_context *cxt,
 	if (!doext)
 		print_partition_size(cxt, i + 1, start, stop, sysid);
 
-	if (dos_compatible_flag && (start/(sectors*heads) > 1023))
-		start = heads*sectors*1024 - 1;
+	if (dos_compatible_flag && (start/(cxt->geom.sectors*cxt->geom.heads) > 1023))
+		start = cxt->geom.heads*cxt->geom.sectors*1024 - 1;
 	set_hsc(p->head, p->sector, p->cyl, start);
-	if (dos_compatible_flag && (stop/(sectors*heads) > 1023))
-		stop = heads*sectors*1024 - 1;
+	if (dos_compatible_flag && (stop/(cxt->geom.sectors*cxt->geom.heads) > 1023))
+		stop = cxt->geom.heads*cxt->geom.sectors*1024 - 1;
 	set_hsc(p->end_head, p->end_sector, p->end_cyl, stop);
 	ptes[i].changed = 1;
 }
@@ -449,7 +449,7 @@ void dos_add_partition(struct fdisk_context *cxt, int n, int sys)
 	if (n < 4) {
 		start = sector_offset;
 		if (display_in_cyl_units || !cxt->total_sectors)
-			limit = heads * sectors * cylinders - 1;
+			limit = cxt->geom.heads * cxt->geom.sectors * cxt->geom.cylinders - 1;
 		else
 			limit = cxt->total_sectors - 1;
 
diff --git a/fdisk/fdiskmaclabel.c b/fdisk/fdiskmaclabel.c
index 1c2e403..96fc712 100644
--- a/fdisk/fdiskmaclabel.c
+++ b/fdisk/fdiskmaclabel.c
@@ -72,7 +72,7 @@ check_mac_label(struct fdisk_context *cxt)
 
 IS_MAC:
     other_endian = (maclabel->magic == MAC_LABEL_MAGIC_SWAPPED); // =?
-    update_units();
+    update_units(cxt);
     disklabel = MAC_LABEL;
     partitions= 1016; // =?
     volumes = 15;	// =?
diff --git a/fdisk/fdisksgilabel.c b/fdisk/fdisksgilabel.c
index b7c1db2..c723403 100644
--- a/fdisk/fdisksgilabel.c
+++ b/fdisk/fdisksgilabel.c
@@ -151,7 +151,7 @@ check_sgi_label(struct fdisk_context *cxt) {
 		fprintf(stderr,
 			_("Detected sgi disklabel with wrong checksum.\n"));
 	}
-	update_units();
+	update_units(cxt);
 	disklabel = SGI_LABEL;
 	partitions= 16;
 	volumes = 15;
@@ -168,11 +168,11 @@ sgi_list_table(struct fdisk_context *cxt, int xtra) {
 
 	if (xtra) {
 		printf(_("\nDisk %s (SGI disk label): %d heads, %llu sectors\n"
-			 "%d cylinders, %d physical cylinders\n"
+			 "%llu cylinders, %d physical cylinders\n"
 			 "%d extra sects/cyl, interleave %d:1\n"
 			 "%s\n"
 			 "Units = %s of %d * %ld bytes\n\n"),
-		       cxt->dev_path, heads, sectors, cylinders,
+		       cxt->dev_path, cxt->geom.heads, cxt->geom.sectors, cxt->geom.cylinders,
 		       SSWAP16(sgiparam.pcylcount),
 		       (int) sgiparam.sparecyl, SSWAP16(sgiparam.ilfact),
 		       (char *)sgilabel,
@@ -180,9 +180,9 @@ sgi_list_table(struct fdisk_context *cxt, int xtra) {
                        cxt->sector_size);
 	} else {
 		printf(_("\nDisk %s (SGI disk label): "
-			 "%d heads, %llu sectors, %d cylinders\n"
+			 "%d heads, %llu sectors, %llu cylinders\n"
 			 "Units = %s of %d * %ld bytes\n\n"),
-		       cxt->dev_path, heads, sectors, cylinders,
+		       cxt->dev_path, cxt->geom.heads, cxt->geom.sectors, cxt->geom.cylinders,
 		       str_units(PLURAL), units_per_sector,
                        cxt->sector_size);
 	}
@@ -258,8 +258,8 @@ sgi_set_bootpartition(struct fdisk_context *cxt, int i)
 }
 
 static unsigned int
-sgi_get_lastblock(void) {
-	return heads * sectors * cylinders;
+sgi_get_lastblock(struct fdisk_context *cxt) {
+	return cxt->geom.heads * cxt->geom.sectors * cxt->geom.cylinders;
 }
 
 void
@@ -445,7 +445,7 @@ verify_sgi(struct fdisk_context *cxt, int verbose)
 	int entire = 0, i = 0;
 	unsigned int start = 0;
 	long long gap = 0;	/* count unused blocks */
-	unsigned int lastblock = sgi_get_lastblock();
+	unsigned int lastblock = sgi_get_lastblock(cxt);
 
 	clearfreelist();
 	for (i=0; i<16; i++) {
@@ -613,7 +613,7 @@ sgi_set_entire(struct fdisk_context *cxt) {
 
 	for (n=10; n<partitions; n++) {
 		if (!sgi_get_num_sectors(cxt, n)) {
-			sgi_set_partition(cxt, n, 0, sgi_get_lastblock(), SGI_VOLUME);
+			sgi_set_partition(cxt, n, 0, sgi_get_lastblock(cxt), SGI_VOLUME);
 			break;
 		}
 	}
@@ -631,7 +631,7 @@ sgi_set_volhdr(struct fdisk_context *cxt)
 			 * Choose same default volume header size
 			 * as IRIX fx uses.
 			 */
-			if (4096 < sgi_get_lastblock())
+			if (4096 < sgi_get_lastblock(cxt))
 				sgi_set_partition(cxt, n, 0, 4096, SGI_VOLHDR);
 			break;
 		}
@@ -677,7 +677,7 @@ sgi_add_partition(struct fdisk_context *cxt, int n, int sys)
 	snprintf(mesg, sizeof(mesg), _("First %s"), str_units(SINGULAR));
 	for (;;) {
 		if (sys == SGI_VOLUME) {
-			last = sgi_get_lastblock();
+			last = sgi_get_lastblock(cxt);
 			first = read_int(cxt, 0, 0, last-1, 0, mesg);
 			if (first != 0) {
 				printf(_("It is highly recommended that eleventh partition\n"
@@ -708,7 +708,7 @@ sgi_add_partition(struct fdisk_context *cxt, int n, int sys)
 		last *= units_per_sector;                                     
 	/*else                                                             
 		last = last; * align to cylinder if You know how ... */
-	if ((sys == SGI_VOLUME) && (first != 0 || last != sgi_get_lastblock()))
+	if ((sys == SGI_VOLUME) && (first != 0 || last != sgi_get_lastblock(cxt)))
 		printf(_("It is highly recommended that eleventh partition\n"
 			 "covers the entire disk and is of type `SGI volume'\n"));
 	sgi_set_partition(cxt, n, first, last-first, sys);
@@ -741,23 +741,23 @@ create_sgilabel(struct fdisk_context *cxt)
 	if (ioctl(cxt->dev_fd, HDIO_GETGEO, &geometry) < 0)
 		err(EXIT_FAILURE, _("HDIO_GETGEO ioctl failed on %s"), cxt->dev_path);
 
-	heads = geometry.heads;
-	sectors = geometry.sectors;
+	cxt->geom.heads = geometry.heads;
+	cxt->geom.sectors = geometry.sectors;
 	if (res == 0) {
 		/* the get device size ioctl was successful */
 	        sector_t llcyls;
-		llcyls = llsectors / (heads * sectors * sec_fac);
-		cylinders = llcyls;
-		if (cylinders != llcyls)	/* truncated? */
-			cylinders = ~0;
+		llcyls = llsectors / (cxt->geom.heads * cxt->geom.sectors * sec_fac);
+		cxt->geom.cylinders = llcyls;
+		if (cxt->geom.cylinders != llcyls)	/* truncated? */
+			cxt->geom.cylinders = ~0;
 	} else {
 		/* otherwise print error and use truncated version */
-		cylinders = geometry.cylinders;
+		cxt->geom.cylinders = geometry.cylinders;
 		fprintf(stderr,
 			_("Warning:  BLKGETSIZE ioctl failed on %s.  "
-			  "Using geometry cylinder value of %d.\n"
+			  "Using geometry cylinder value of %llu.\n"
 			  "This value may be truncated for devices"
-			  " > 33.8 GB.\n"), cxt->dev_path, cylinders);
+			  " > 33.8 GB.\n"), cxt->dev_path, cxt->geom.cylinders);
 	}
 #endif
 	for (i = 0; i < 4; i++) {
diff --git a/fdisk/fdisksunlabel.c b/fdisk/fdisksunlabel.c
index 5dbcef4..ecfaa1e 100644
--- a/fdisk/fdisksunlabel.c
+++ b/fdisk/fdisksunlabel.c
@@ -65,7 +65,7 @@ static void set_sun_partition(struct fdisk_context *cxt,
 	sunlabel->part_tags[i].tag = SSWAP16(sysid);
 	sunlabel->part_tags[i].flag = SSWAP16(0);
 	sunlabel->partitions[i].start_cylinder =
-		SSWAP32(start / (heads * sectors));
+		SSWAP32(start / (cxt->geom.heads * cxt->geom.sectors));
 	sunlabel->partitions[i].num_sectors =
 		SSWAP32(stop - start);
 	set_changed(i);
@@ -104,9 +104,9 @@ int check_sun_label(struct fdisk_context *cxt)
 	} else {
 		int need_fixing = 0;
 
-		heads = SSWAP16(sunlabel->nhead);
-		cylinders = SSWAP16(sunlabel->ncyl);
-		sectors = SSWAP16(sunlabel->nsect);
+		cxt->geom.heads = SSWAP16(sunlabel->nhead);
+		cxt->geom.cylinders = SSWAP16(sunlabel->ncyl);
+		cxt->geom.sectors = SSWAP16(sunlabel->nsect);
 
 		if (sunlabel->version != SSWAP32(SUN_LABEL_VERSION)) {
 			fprintf(stderr,_("Detected sun disklabel with wrong version [0x%08x].\n"),
@@ -140,7 +140,7 @@ int check_sun_label(struct fdisk_context *cxt)
 			set_changed(0);
 		}
 	}
-	update_units();
+	update_units(cxt);
 	return 1;
 }
 
@@ -172,57 +172,57 @@ void create_sunlabel(struct fdisk_context *cxt)
 
 #ifdef HDIO_GETGEO
 	if (!ioctl(cxt->dev_fd, HDIO_GETGEO, &geometry)) {
-	        heads = geometry.heads;
-	        sectors = geometry.sectors;
+	        cxt->geom.heads = geometry.heads;
+	        cxt->geom.sectors = geometry.sectors;
 		if (res == 0) {
-			llcyls = llsectors / (heads * sectors * sec_fac);
-			cylinders = llcyls;
-			if (cylinders != llcyls)
-				cylinders = ~0;
+			llcyls = llsectors / (cxt->geom.heads * cxt->geom.sectors * sec_fac);
+			cxt->geom.cylinders = llcyls;
+			if (cxt->geom.cylinders != llcyls)
+				cxt->geom.cylinders = ~0;
 		} else {
-			cylinders = geometry.cylinders;
+			cxt->geom.cylinders = geometry.cylinders;
 			fprintf(stderr,
 				_("Warning:  BLKGETSIZE ioctl failed on %s.  "
-				  "Using geometry cylinder value of %d.\n"
+				  "Using geometry cylinder value of %llu.\n"
 				  "This value may be truncated for devices"
-				  " > 33.8 GB.\n"), cxt->dev_path, cylinders);
+				  " > 33.8 GB.\n"), cxt->dev_path, cxt->geom.cylinders);
 		}
 	} else
 #endif
 	{
-	        heads = read_int(cxt, 1,1,1024,0,_("Heads"));
-		sectors = read_int(cxt, 1,1,1024,0,_("Sectors/track"));
-		cylinders = read_int(cxt, 1,1,65535,0,_("Cylinders"));
+	        cxt->geom.heads = read_int(cxt, 1,1,1024,0,_("Heads"));
+		cxt->geom.sectors = read_int(cxt, 1,1,1024,0,_("Sectors/track"));
+		cxt->geom.cylinders = read_int(cxt, 1,1,65535,0,_("Cylinders"));
 	}
 
 	sunlabel->acyl   = SSWAP16(2);
-	sunlabel->pcyl   = SSWAP16(cylinders);
-	sunlabel->ncyl   = SSWAP16(cylinders - 2);
+	sunlabel->pcyl   = SSWAP16(cxt->geom.cylinders);
+	sunlabel->ncyl   = SSWAP16(cxt->geom.cylinders - 2);
 	sunlabel->rpm    = SSWAP16(5400);
 	sunlabel->intrlv = SSWAP16(1);
 	sunlabel->apc    = SSWAP16(0);
 
-	sunlabel->nhead = SSWAP16(heads);
-	sunlabel->nsect = SSWAP16(sectors);
-	sunlabel->ncyl = SSWAP16(cylinders);
+	sunlabel->nhead = SSWAP16(cxt->geom.heads);
+	sunlabel->nsect = SSWAP16(cxt->geom.sectors);
+	sunlabel->ncyl = SSWAP16(cxt->geom.cylinders);
 
 	snprintf(sunlabel->label_id, sizeof(sunlabel->label_id),
-		 "Linux cyl %d alt %d hd %d sec %llu",
-		 cylinders, SSWAP16(sunlabel->acyl), heads, sectors);
+		 "Linux cyl %llu alt %d hd %d sec %llu",
+		 cxt->geom.cylinders, SSWAP16(sunlabel->acyl), cxt->geom.heads, cxt->geom.sectors);
 
-	if (cylinders * heads * sectors >= 150 * 2048) {
-	        ndiv = cylinders - (50 * 2048 / (heads * sectors)); /* 50M swap */
+	if (cxt->geom.cylinders * cxt->geom.heads * cxt->geom.sectors >= 150 * 2048) {
+	        ndiv = cxt->geom.cylinders - (50 * 2048 / (cxt->geom.heads * cxt->geom.sectors)); /* 50M swap */
 	} else
-	        ndiv = cylinders * 2 / 3;
+	        ndiv = cxt->geom.cylinders * 2 / 3;
 
-	set_sun_partition(cxt, 0, 0, ndiv * heads * sectors,
+	set_sun_partition(cxt, 0, 0, ndiv * cxt->geom.heads * cxt->geom.sectors,
 			  SUN_TAG_LINUX_NATIVE);
-	set_sun_partition(cxt, 1, ndiv * heads * sectors,
-			  cylinders * heads * sectors,
+	set_sun_partition(cxt, 1, ndiv * cxt->geom.heads * cxt->geom.sectors,
+			  cxt->geom.cylinders * cxt->geom.heads * cxt->geom.sectors,
 			  SUN_TAG_LINUX_SWAP);
 	sunlabel->part_tags[1].flag |= SSWAP16(SUN_FLAG_UNMNT);
 
-	set_sun_partition(cxt, 2, 0, cylinders * heads * sectors, SUN_TAG_BACKUP);
+	set_sun_partition(cxt, 2, 0, cxt->geom.cylinders * cxt->geom.heads * cxt->geom.sectors, SUN_TAG_BACKUP);
 
 	{
 		unsigned short *ush = (unsigned short *)sunlabel;
@@ -251,7 +251,7 @@ static void fetch_sun(struct fdisk_context *cxt, uint32_t *starts,
 	int i, continuous = 1;
 
 	*start = 0;
-	*stop = cylinders * heads * sectors;
+	*stop = cxt->geom.cylinders * cxt->geom.heads * cxt->geom.sectors;
 
 	for (i = 0; i < partitions; i++) {
 		struct sun_partition *part = &sunlabel->partitions[i];
@@ -261,7 +261,7 @@ static void fetch_sun(struct fdisk_context *cxt, uint32_t *starts,
 		    tag->tag != SSWAP16(SUN_TAG_UNASSIGNED) &&
 		    tag->tag != SSWAP16(SUN_TAG_BACKUP)) {
 			starts[i] = (SSWAP32(part->start_cylinder) *
-				     heads * sectors);
+				     cxt->geom.heads * cxt->geom.sectors);
 			lens[i] = SSWAP32(part->num_sectors);
 			if (continuous) {
 				if (starts[i] == *start)
@@ -305,7 +305,7 @@ void verify_sun(struct fdisk_context *cxt)
 
     for (k = 0; k < 7; k++) {
 	for (i = 0; i < SUN_NUM_PARTITIONS; i++) {
-	    if (k && (lens[i] % (heads * sectors))) {
+	    if (k && (lens[i] % (cxt->geom.heads * cxt->geom.sectors))) {
 	        printf(_("Partition %d doesn't end on cylinder boundary\n"), i+1);
 	    }
 	    if (lens[i]) {
@@ -347,7 +347,7 @@ void verify_sun(struct fdisk_context *cxt)
     	printf(_("No partitions defined\n"));
     	return;
     }
-    stop = cylinders * heads * sectors;
+    stop = cxt->geom.cylinders * cxt->geom.heads * cxt->geom.sectors;
     if (starts[array[0]])
         printf(_("Unused gap - sectors 0-%d\n"), starts[array[0]]);
     for (i = 0; i < 7 && array[i+1] != -1; i++) {
@@ -399,7 +399,7 @@ void add_sun_partition(struct fdisk_context *cxt, int n, int sys)
 			first *= units_per_sector;
 		else {
 			/* Starting sector has to be properly aligned */
-			int cs = heads * sectors;
+			int cs = cxt->geom.heads * cxt->geom.sectors;
 			int x = first % cs;
 
 			if (x)
@@ -438,7 +438,7 @@ and is of type `Whole disk'\n"));
 		} else
 			break;
 	}
-	stop = cylinders * heads * sectors;	/* ancient */
+	stop = cxt->geom.cylinders * cxt->geom.heads * cxt->geom.sectors;	/* ancient */
 	stop2 = stop;
 	for (i = 0; i < partitions; i++) {
 		if (starts[i] > first && starts[i] < stop)
@@ -490,7 +490,7 @@ void sun_delete_partition(struct fdisk_context *cxt, int i)
 	    tag->tag == SSWAP16(SUN_TAG_BACKUP) &&
 	    !part->start_cylinder &&
 	    (nsec = SSWAP32(part->num_sectors))
-	      == heads * sectors * cylinders)
+	      == cxt->geom.heads * cxt->geom.sectors * cxt->geom.cylinders)
 		printf(_("If you want to maintain SunOS/Solaris compatibility, "
 		       "consider leaving this\n"
 		       "partition as Whole disk (5), starting at 0, with %u "
@@ -539,13 +539,13 @@ void sun_list_table(struct fdisk_context *cxt, int xtra)
 	if (xtra)
 		printf(
 		_("\nDisk %s (Sun disk label): %u heads, %llu sectors, %d rpm\n"
-		"%u cylinders, %d alternate cylinders, %d physical cylinders\n"
+		"%llu cylinders, %d alternate cylinders, %d physical cylinders\n"
 		"%d extra sects/cyl, interleave %d:1\n"
 		"Label ID: %s\n"
 		"Volume ID: %s\n"
 		"Units = %s of %d * 512 bytes\n\n"),
-		       cxt->dev_path, heads, sectors, SSWAP16(sunlabel->rpm),
-		       cylinders, SSWAP16(sunlabel->acyl),
+		       cxt->dev_path, cxt->geom.heads, cxt->geom.sectors, SSWAP16(sunlabel->rpm),
+		       cxt->geom.cylinders, SSWAP16(sunlabel->acyl),
 		       SSWAP16(sunlabel->pcyl),
 		       SSWAP16(sunlabel->apc),
 		       SSWAP16(sunlabel->intrlv),
@@ -554,9 +554,9 @@ void sun_list_table(struct fdisk_context *cxt, int xtra)
 		       str_units(PLURAL), units_per_sector);
 	else
 		printf(
-	_("\nDisk %s (Sun disk label): %u heads, %llu sectors, %u cylinders\n"
+	_("\nDisk %s (Sun disk label): %u heads, %llu sectors, %llu cylinders\n"
 	"Units = %s of %d * 512 bytes\n\n"),
-		       cxt->dev_path, heads, sectors, cylinders,
+		       cxt->dev_path, cxt->geom.heads, cxt->geom.sectors, cxt->geom.cylinders,
 		       str_units(PLURAL), units_per_sector);
 
 	printf(_("%*s Flag    Start       End    Blocks   Id  System\n"),
@@ -566,7 +566,7 @@ void sun_list_table(struct fdisk_context *cxt, int xtra)
 		struct sun_tag_flag *tag = &sunlabel->part_tags[i];
 
 		if (part->num_sectors) {
-			uint32_t start = SSWAP32(part->start_cylinder) * heads * sectors;
+			uint32_t start = SSWAP32(part->start_cylinder) * cxt->geom.heads * cxt->geom.sectors;
 			uint32_t len = SSWAP32(part->num_sectors);
 			printf(
 			    "%s %c%c %9lu %9lu %9lu%c  %2x  %s\n",
@@ -598,7 +598,7 @@ void sun_set_ncyl(struct fdisk_context *cxt, int cyl)
 void sun_set_xcyl(struct fdisk_context *cxt)
 {
 	sunlabel->apc =
-		SSWAP16(read_int(cxt, 0, SSWAP16(sunlabel->apc), sectors, 0,
+		SSWAP16(read_int(cxt, 0, SSWAP16(sunlabel->apc), cxt->geom.sectors, 0,
 				 _("Extra sectors per cylinder")));
 }
 
diff --git a/fdisk/utils.c b/fdisk/utils.c
index 616fcc0..57f3355 100644
--- a/fdisk/utils.c
+++ b/fdisk/utils.c
@@ -55,13 +55,50 @@ static unsigned long __get_sector_size(int fd)
 	return DEFAULT_SECTOR_SIZE;
 }
 
+/**
+ * fdisk_geom_set_cyls
+ * @cxt: fdisk context
+ *
+ * Sets the cylinders based on sectors and heads
+ */
+void fdisk_geom_set_cyls(struct fdisk_context *cxt)
+{
+	cxt->geom.cylinders = cxt->total_sectors /
+		(cxt->geom.heads * cxt->geom.sectors);
+}
+
 static int __discover_geometry(struct fdisk_context *cxt)
 {
 	sector_t nsects;
+	unsigned int h = 0, s = 0;
 
 	/* get number of 512-byte sectors, and convert it the real sectors */
 	if (!blkdev_get_sectors(cxt->dev_fd, &nsects))
 		cxt->total_sectors = (nsects / (cxt->sector_size >> 9));
+
+	get_partition_table_geometry(cxt, &h, &s);
+	if (h && s)
+		goto hs_ok;
+
+	/* what the kernel/bios thinks the geometry is */
+	blkdev_get_geometry(cxt->dev_fd, &h, &s);
+	if (h && s)
+		goto hs_ok;
+
+	/* unable to discover geometry, use default values */
+	s = 63;
+	h = 255;
+	
+hs_ok: /* obtained heads and sectors */
+	cxt->geom.heads = h;
+	cxt->geom.sectors = s;
+	fdisk_geom_set_cyls(cxt);
+	update_sector_offset(cxt);
+
+	DBG(GEOMETRY, dbgprint("geometry discovered for %s: C/H/S: %lld/%d/%lld",
+			       cxt->dev_path, cxt->geom.cylinders,
+			       cxt->geom.heads, cxt->geom.sectors));
+
 	return 0;
 }
 
-- 
1.7.4.1
