Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcahe.dreamhost.com ([208.97.132.74]:41190 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752332Ab2KNIEq (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 14 Nov 2012 03:04:46 -0500
Message-ID: <1352880280.2577.4.camel@offbook>
Subject: [PATCH 2/3] fdisk: api: move disklabel type to cxt
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Date: Wed, 14 Nov 2012 00:04:40 -0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Get rid of it as a global variable as it belongs in the context.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/fdisk.c         |  101 +++++++++++++++++++++++++-----------------------
 fdisks/fdisk.h         |   33 ++++++++--------
 fdisks/fdiskaixlabel.c |    2 +-
 fdisks/fdiskbsdlabel.c |    2 +-
 fdisks/fdiskdoslabel.c |    2 +-
 fdisks/fdiskmaclabel.c |    2 +-
 fdisks/fdisksgilabel.c |    4 +-
 fdisks/fdisksunlabel.c |    8 ++--
 fdisks/gpt.c           |   14 +++----
 fdisks/utils.c         |    4 +-
 10 files changed, 88 insertions(+), 84 deletions(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index a3ac087..7db25af 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -134,7 +134,6 @@ int	nowarn = 0,			/* no warnings for fdisk -l/-s */
 unsigned int	user_cylinders, user_heads, user_sectors;
 sector_t sector_offset = 1;
 unsigned int units_per_sector = 1, display_in_cyl_units = 0;
-enum fdisk_labeltype disklabel;	/* Current disklabel */
 
 static void __attribute__ ((__noreturn__)) usage(FILE *out)
 {
@@ -209,14 +208,14 @@ is_garbage_table(void) {
 	return 0;
 }
 
-void print_menu(enum menutype menu)
+void print_menu(struct fdisk_context *cxt, enum menutype menu)
 {
 	size_t i;
 
 	puts(_("Command action"));
 
 	for (i = 0; i < ARRAY_SIZE(menulist); i++)
-		if (menulist[i].label[menu] & disklabel)
+		if (menulist[i].label[menu] & cxt->disklabel)
 			printf("   %c   %s\n", menulist[i].command, menulist[i].description);
 }
 
@@ -369,7 +368,7 @@ int warn_geometry(struct fdisk_context *cxt)
 	char *m = NULL;
 	int prev = 0;
 
-	if (disklabel == SGI_LABEL)	/* cannot set cylinders etc anyway */
+	if (cxt->disklabel == SGI_LABEL)	/* cannot set cylinders etc anyway */
 		return 0;
 	if (!cxt->geom.heads)
 		prev = test_c(&m, _("heads"));
@@ -741,13 +740,14 @@ get_partition_dflt(struct fdisk_context *cxt, int warn, int max, int dflt) {
 	i = read_int(cxt, 1, dflt, max, 0, _("Partition number")) - 1;
 	pe = &ptes[i];
 
-	if (warn && disklabel != GPT_LABEL) {
-		if ((disklabel != SUN_LABEL && disklabel != SGI_LABEL && !pe->part_table->sys_ind)
-		    || (disklabel == SUN_LABEL &&
+	if (warn && cxt->disklabel != GPT_LABEL) {
+		if ((cxt->disklabel != SUN_LABEL &&
+		     cxt->disklabel != SGI_LABEL && !pe->part_table->sys_ind)
+		    || (cxt->disklabel == SUN_LABEL &&
 			(!sunlabel->partitions[i].num_sectors ||
 			 !sunlabel->part_tags[i].tag))
-		    || (disklabel == SGI_LABEL && (!sgi_get_num_sectors(cxt, i)))
-		   )
+		    || (cxt->disklabel == SGI_LABEL &&
+			(!sgi_get_num_sectors(cxt, i))))
 			fprintf(stderr,
 				_("Warning: partition %d has empty type\n"),
 				i+1);
@@ -767,7 +767,7 @@ get_existing_partition(struct fdisk_context *cxt, int warn, int max) {
 	int pno = -1;
 	int i;
 
-	if (disklabel != DOS_LABEL)
+	if (cxt->disklabel != DOS_LABEL)
 		goto not_implemented;
 
 	for (i = 0; i < max; i++) {
@@ -985,7 +985,7 @@ list_disk_geometry(struct fdisk_context *cxt) {
 				cxt->min_io_size, cxt->io_size);
 	if (cxt->alignment_offset)
 		printf(_("Alignment offset: %lu bytes\n"), cxt->alignment_offset);
-	if (disklabel == DOS_LABEL)
+	if (cxt->disklabel == DOS_LABEL)
 		dos_print_mbr_id(cxt);
 	printf("\n");
 }
@@ -1130,24 +1130,24 @@ static void list_table(struct fdisk_context *cxt, int xtra)
 	struct partition *p;
 	int i, w;
 
-	if (disklabel == SUN_LABEL) {
+	if (cxt->disklabel == SUN_LABEL) {
 		sun_list_table(cxt, xtra);
 		return;
 	}
 
-	if (disklabel == SGI_LABEL) {
+	if (cxt->disklabel == SGI_LABEL) {
 		sgi_list_table(cxt, xtra);
 		return;
 	}
 
 	list_disk_geometry(cxt);
 
-	if (disklabel == GPT_LABEL) {
+	if (cxt->disklabel == GPT_LABEL) {
 		gpt_list_table(cxt, xtra);
 		return;
 	}
 
-	if (disklabel == OSF_LABEL) {
+	if (cxt->disklabel == OSF_LABEL) {
 		xbsd_print_disklabel(cxt, xtra);
 		return;
 	}
@@ -1205,7 +1205,7 @@ static void list_table(struct fdisk_context *cxt, int xtra)
 	/* Is partition table in disk order? It need not be, but... */
 	/* partition table entries are not checked for correct order if this
 	   is a sgi, sun or aix labeled disk... */
-	if (disklabel == DOS_LABEL && wrong_p_order(NULL)) {
+	if (cxt->disklabel == DOS_LABEL && wrong_p_order(NULL)) {
 		printf(_("\nPartition table entries are not in disk order\n"));
 	}
 }
@@ -1311,8 +1311,9 @@ static void new_partition(struct fdisk_context *cxt)
 	if (warn_geometry(cxt))
 		return;
 
-	if (disklabel == SUN_LABEL || disklabel == SGI_LABEL
-		|| disklabel == GPT_LABEL)
+	if (cxt->disklabel == SUN_LABEL ||
+	    cxt->disklabel == SGI_LABEL ||
+	    cxt->disklabel == GPT_LABEL)
 		partnum = get_partition(cxt, 0, partitions);
 
 	fdisk_add_partition(cxt, partnum, NULL);
@@ -1390,8 +1391,9 @@ static void print_raw(struct fdisk_context *cxt)
 	int i;
 
 	printf(_("Device: %s\n"), cxt->dev_path);
-	if (disklabel == SUN_LABEL || disklabel == SGI_LABEL ||
-	    disklabel == GPT_LABEL)
+	if (cxt->disklabel == SUN_LABEL ||
+	    cxt->disklabel == SGI_LABEL ||
+	    cxt->disklabel == GPT_LABEL)
 		print_buffer(cxt, cxt->firstsector);
 	else for (i = 3; i < partitions; i++)
 		     print_buffer(cxt, ptes[i].sectorbuffer);
@@ -1463,34 +1465,34 @@ expert_command_prompt(struct fdisk_context *cxt)
 		c = tolower(read_char(_("Expert command (m for help): ")));
 		switch (c) {
 		case 'a':
-			if (disklabel == SUN_LABEL)
+			if (cxt->disklabel == SUN_LABEL)
 				sun_set_alt_cyl(cxt);
 			break;
 		case 'b':
-			if (disklabel == DOS_LABEL)
+			if (cxt->disklabel == DOS_LABEL)
 				move_begin(cxt, get_partition(cxt, 0, partitions));
 			break;
 		case 'c':
 			user_cylinders = cxt->geom.cylinders =
 				read_int(cxt, 1, cxt->geom.cylinders, 1048576, 0,
 					 _("Number of cylinders"));
-			if (disklabel == SUN_LABEL)
+			if (cxt->disklabel == SUN_LABEL)
 				sun_set_ncyl(cxt, cxt->geom.cylinders);
 			break;
 		case 'd':
 			print_raw(cxt);
 			break;
 		case 'e':
-			if (disklabel == SGI_LABEL)
+			if (cxt->disklabel == SGI_LABEL)
 				sgi_set_xcyl();
-			else if (disklabel == SUN_LABEL)
+			else if (cxt->disklabel == SUN_LABEL)
 				sun_set_xcyl(cxt);
 			else
-			if (disklabel == DOS_LABEL)
+			if (cxt->disklabel == DOS_LABEL)
 				x_list_table(cxt, 1);
 			break;
 		case 'f':
-			if (disklabel == DOS_LABEL)
+			if (cxt->disklabel == DOS_LABEL)
 				fix_partition_table_order();
 			break;
 		case 'g':
@@ -1502,17 +1504,17 @@ expert_command_prompt(struct fdisk_context *cxt)
 			update_units(cxt);
 			break;
 		case 'i':
-			if (disklabel == SUN_LABEL)
+			if (cxt->disklabel == SUN_LABEL)
 				sun_set_ilfact(cxt);
-			else if (disklabel == DOS_LABEL)
+			else if (cxt->disklabel == DOS_LABEL)
 				dos_set_mbr_id(cxt);
 			break;
 		case 'o':
-			if (disklabel == SUN_LABEL)
+			if (cxt->disklabel == SUN_LABEL)
 				sun_set_rspeed(cxt);
 			break;
 		case 'p':
-			if (disklabel == SUN_LABEL)
+			if (cxt->disklabel == SUN_LABEL)
 				list_table(cxt, 1);
 			else
 				x_list_table(cxt, 0);
@@ -1538,11 +1540,11 @@ expert_command_prompt(struct fdisk_context *cxt)
 			write_table(cxt);
 			break;
 		case 'y':
-			if (disklabel == SUN_LABEL)
+			if (cxt->disklabel == SUN_LABEL)
 				sun_set_pcylcount(cxt);
 			break;
 		default:
-			print_menu(EXPERT_MENU);
+			print_menu(cxt, EXPERT_MENU);
 		}
 	}
 }
@@ -1580,7 +1582,8 @@ static void print_partition_table_from_option(char *device, unsigned long sector
 		 * Try BSD -- TODO: move to list_table() too
 		 */
 		list_disk_geometry(cxt);
-		if (disklabel != AIX_LABEL && disklabel != MAC_LABEL)
+		if (cxt->disklabel != AIX_LABEL &&
+		    cxt->disklabel != MAC_LABEL)
 			btrydev(cxt);
 	}
 	else
@@ -1643,7 +1646,7 @@ static void command_prompt(struct fdisk_context *cxt)
 {
 	int c;
 
-	if (disklabel == OSF_LABEL) {
+	if (cxt->disklabel == OSF_LABEL) {
 		putchar('\n');
 		/* OSF label, and no DOS label */
 		printf(_("Detected an OSF/1 disklabel on %s, entering "
@@ -1651,7 +1654,7 @@ static void command_prompt(struct fdisk_context *cxt)
 		       cxt->dev_path);
 		bsd_command_prompt(cxt);
 		/* If we return we may want to make an empty DOS label? */
-		disklabel = DOS_LABEL;
+		cxt->disklabel = DOS_LABEL;
 	}
 
 	while (1) {
@@ -1659,34 +1662,34 @@ static void command_prompt(struct fdisk_context *cxt)
 		c = tolower(read_char(_("Command (m for help): ")));
 		switch (c) {
 		case 'a':
-			if (disklabel == DOS_LABEL)
+			if (cxt->disklabel == DOS_LABEL)
 				toggle_active(get_partition(cxt, 1, partitions));
-			else if (disklabel == SUN_LABEL)
+			else if (cxt->disklabel == SUN_LABEL)
 				toggle_sunflags(cxt, get_partition(cxt, 1, partitions),
 						SUN_FLAG_UNMNT);
-			else if (disklabel == SGI_LABEL)
+			else if (cxt->disklabel == SGI_LABEL)
 				sgi_set_bootpartition(cxt,
 					get_partition(cxt, 1, partitions));
 			else
 				unknown_command(c);
 			break;
 		case 'b':
-			if (disklabel == SGI_LABEL)
+			if (cxt->disklabel == SGI_LABEL)
 				sgi_set_bootfile(cxt);
-			else if (disklabel == DOS_LABEL) {
-				disklabel = OSF_LABEL;
+			else if (cxt->disklabel == DOS_LABEL) {
+				cxt->disklabel = OSF_LABEL;
 				bsd_command_prompt(cxt);
-				disklabel = DOS_LABEL;
+				cxt->disklabel = DOS_LABEL;
 			} else
 				unknown_command(c);
 			break;
 		case 'c':
-			if (disklabel == DOS_LABEL)
+			if (cxt->disklabel == DOS_LABEL)
 				toggle_dos_compatibility_flag(cxt);
-			else if (disklabel == SUN_LABEL)
+			else if (cxt->disklabel == SUN_LABEL)
 				toggle_sunflags(cxt, get_partition(cxt, 1, partitions),
 						SUN_FLAG_RONLY);
-			else if (disklabel == SGI_LABEL)
+			else if (cxt->disklabel == SGI_LABEL)
 				sgi_set_swappartition(cxt,
 					get_partition(cxt, 1, partitions));
 			else
@@ -1699,7 +1702,7 @@ static void command_prompt(struct fdisk_context *cxt)
 			fdisk_create_disklabel(cxt, "gpt");
 			break;
 		case 'i':
-			if (disklabel == SGI_LABEL)
+			if (cxt->disklabel == SGI_LABEL)
 				create_sgiinfo(cxt);
 			else
 				unknown_command(c);
@@ -1708,7 +1711,7 @@ static void command_prompt(struct fdisk_context *cxt)
 			list_partition_types(cxt);
 			break;
 		case 'm':
-			print_menu(MAIN_MENU);
+			print_menu(cxt, MAIN_MENU);
 			break;
 		case 'n':
 			new_partition(cxt);
@@ -1741,7 +1744,7 @@ static void command_prompt(struct fdisk_context *cxt)
 			break;
 		default:
 			unknown_command(c);
-			print_menu(MAIN_MENU);
+			print_menu(cxt, MAIN_MENU);
 		}
 	}
 }
diff --git a/fdisks/fdisk.h b/fdisks/fdisk.h
index 90ebb62..53ef6bc 100644
--- a/fdisks/fdisk.h
+++ b/fdisks/fdisk.h
@@ -100,6 +100,20 @@ enum failure {
 typedef unsigned long long sector_t;
 
 /*
+ * Supported partition table types (labels)
+ */
+enum fdisk_labeltype {
+	DOS_LABEL = 1,
+	SUN_LABEL = 2,
+	SGI_LABEL = 4,
+	AIX_LABEL = 8,
+	OSF_LABEL = 16,
+	MAC_LABEL = 32,
+	GPT_LABEL = 64,
+	ANY_LABEL = -1
+};
+
+/*
  * Partition types
  */
 struct fdisk_parttype {
@@ -142,6 +156,8 @@ struct fdisk_context {
 	unsigned long sector_size;	/* logical size */
 	unsigned long alignment_offset;
 
+	enum fdisk_labeltype disklabel;	/* current disklabel */
+
 	unsigned long grain;		/* alignment unit */
 
 	/* geometry */
@@ -241,7 +257,7 @@ extern struct partition *get_part_table(int);
 extern unsigned int read_int(struct fdisk_context *cxt,
 			     unsigned int low, unsigned int dflt,
 			     unsigned int high, unsigned int base, char *mesg);
-extern void print_menu(enum menutype);
+extern void print_menu(struct fdisk_context *cxt, enum menutype menu);
 extern void print_partition_size(struct fdisk_context *cxt, int num, sector_t start, sector_t stop, int sysid);
 
 extern void fill_bounds(sector_t *first, sector_t *last);
@@ -267,21 +283,6 @@ extern const char * str_units(int);
 
 extern sector_t get_nr_sects(struct partition *p);
 
-/*
- * Supported partition table types (labels)
- */
-enum fdisk_labeltype {
-	DOS_LABEL = 1,
-	SUN_LABEL = 2,
-	SGI_LABEL = 4,
-	AIX_LABEL = 8,
-	OSF_LABEL = 16,
-	MAC_LABEL = 32,
-	GPT_LABEL = 64,
-	ANY_LABEL = -1
-};
-
-extern enum fdisk_labeltype disklabel;
 extern int MBRbuffer_changed;
 
 /* start_sect and nr_sects are stored little endian on all machines */
diff --git a/fdisks/fdiskaixlabel.c b/fdisks/fdiskaixlabel.c
index 3ee37cb..f641dce 100644
--- a/fdisks/fdiskaixlabel.c
+++ b/fdisks/fdiskaixlabel.c
@@ -58,7 +58,7 @@ static int aix_probe_label(struct fdisk_context *cxt)
 	return 0;
     }
     other_endian = (aixlabel->magic == AIX_LABEL_MAGIC_SWAPPED);
-    disklabel = AIX_LABEL;
+    cxt->disklabel = AIX_LABEL;
     partitions= 1016;
     volumes = 15;
     aix_info();
diff --git a/fdisks/fdiskbsdlabel.c b/fdisks/fdiskbsdlabel.c
index e8bd788..9fd658e 100644
--- a/fdisks/fdiskbsdlabel.c
+++ b/fdisks/fdiskbsdlabel.c
@@ -305,7 +305,7 @@ bsd_command_prompt (struct fdisk_context *cxt)
 	break;
 #endif
       default:
-	print_menu(MAIN_MENU);
+	print_menu(cxt, MAIN_MENU);
 	break;
     }
   }
diff --git a/fdisks/fdiskdoslabel.c b/fdisks/fdiskdoslabel.c
index 3e56e38..e813a21 100644
--- a/fdisks/fdiskdoslabel.c
+++ b/fdisks/fdiskdoslabel.c
@@ -115,7 +115,7 @@ void dos_init(struct fdisk_context *cxt)
 {
 	int i;
 
-	disklabel = DOS_LABEL;
+	cxt->disklabel = DOS_LABEL;
 	partitions = 4;
 	ext_index = 0;
 	extended_offset = 0;
diff --git a/fdisks/fdiskmaclabel.c b/fdisks/fdiskmaclabel.c
index e09d5e4..27320d1 100644
--- a/fdisks/fdiskmaclabel.c
+++ b/fdisks/fdiskmaclabel.c
@@ -76,7 +76,7 @@ mac_probe_label(struct fdisk_context *cxt)
 
 IS_MAC:
     other_endian = (maclabel->magic == MAC_LABEL_MAGIC_SWAPPED); // =?
-    disklabel = MAC_LABEL;
+    cxt->disklabel = MAC_LABEL;
     partitions= 1016; // =?
     volumes = 15;	// =?
     mac_info();
diff --git a/fdisks/fdisksgilabel.c b/fdisks/fdisksgilabel.c
index 7931362..41b05b9 100644
--- a/fdisks/fdisksgilabel.c
+++ b/fdisks/fdisksgilabel.c
@@ -154,7 +154,7 @@ sgi_probe_label(struct fdisk_context *cxt) {
 		fprintf(stderr,
 			_("Detected sgi disklabel with wrong checksum.\n"));
 	}
-	disklabel = SGI_LABEL;
+	cxt->disklabel = SGI_LABEL;
 	partitions= 16;
 	volumes = 15;
 	return 1;
@@ -818,7 +818,7 @@ static int sgi_create_disklabel(struct fdisk_context *cxt)
 	sgilabel->devparam.xylogics_writecont	= SSWAP16(0);
 	memset(&(sgilabel->directory), 0, sizeof(struct volume_directory)*15);
 	memset(&(sgilabel->partitions), 0, sizeof(struct sgi_partition)*16);
-	disklabel  = SGI_LABEL;
+	cxt->disklabel  = SGI_LABEL;
 	partitions = 16;
 	volumes    = 15;
 	sgi_set_entire(cxt);
diff --git a/fdisks/fdisksunlabel.c b/fdisks/fdisksunlabel.c
index f272f65..8da1757 100644
--- a/fdisks/fdisksunlabel.c
+++ b/fdisks/fdisksunlabel.c
@@ -72,9 +72,9 @@ static void set_sun_partition(struct fdisk_context *cxt,
 	print_partition_size(cxt, i + 1, start, stop, sysid);
 }
 
-static void init(void)
+static void init(struct fdisk_context *cxt)
 {
-	disklabel = SUN_LABEL;
+	cxt->disklabel = SUN_LABEL;
 	partitions = SUN_NUM_PARTITIONS;
 }
 
@@ -89,7 +89,7 @@ static int sun_probe_label(struct fdisk_context *cxt)
 		return 0;
 	}
 
-	init();
+	init(cxt);
 	other_endian = (sunlabel->magic == SUN_LABEL_MAGIC_SWAPPED);
 
 	ush = ((unsigned short *) (sunlabel + 1)) - 1;
@@ -159,7 +159,7 @@ static int sun_create_disklabel(struct fdisk_context *cxt)
 	other_endian = 0;
 #endif
 
-	init();
+	init(cxt);
 	fdisk_zeroize_firstsector(cxt);
 
 	sunlabel->magic = SSWAP16(SUN_LABEL_MAGIC);
diff --git a/fdisks/gpt.c b/fdisks/gpt.c
index df26696..54c3ade 100644
--- a/fdisks/gpt.c
+++ b/fdisks/gpt.c
@@ -970,16 +970,16 @@ done:
 /*
  * Initialize fdisk-specific variables - call once probing passes!
  */
-static void gpt_init(void)
+static void gpt_init(struct fdisk_context *cxt)
 {
-	disklabel = GPT_LABEL;
+	cxt->disklabel = GPT_LABEL;
 	partitions = le32_to_cpu(pheader->npartition_entries);
 }
 
 /*
  * Deinitialize fdisk-specific variables
  */
-static void gpt_deinit(void)
+static void gpt_deinit(struct fdisk_context *cxt)
 {
 	free(ents);
 	free(pheader);
@@ -988,7 +988,7 @@ static void gpt_deinit(void)
 	pheader = NULL;
 	bheader = NULL;
 
-	disklabel = ANY_LABEL;
+	cxt->disklabel = ANY_LABEL;
 	partitions = 0;
 }
 
@@ -1022,7 +1022,7 @@ static int gpt_probe_label(struct fdisk_context *cxt)
 
 	/* OK, probing passed, now initialize backup header and fdisk variables. */
 	bheader = gpt_get_bheader(cxt);
-	gpt_init();
+	gpt_init(cxt);
 
 	printf(_("\nWARNING: fdisk GPT support is currently new, and therefore "
 		 "in an experimental phase. Use at your own discretion.\n\n"));
@@ -1523,7 +1523,7 @@ static int gpt_create_disklabel(struct fdisk_context *cxt)
 	 * dealing with a new, empty disk - so always allocate memory
 	 * to deal with the data structures whatever the case is.
 	 */
-	gpt_deinit();
+	gpt_deinit(cxt);
 
 	rc = gpt_mknew_pmbr(cxt);
 	if (rc < 0)
@@ -1546,7 +1546,7 @@ static int gpt_create_disklabel(struct fdisk_context *cxt)
 	gpt_recompute_crc(pheader, ents);
 	gpt_recompute_crc(bheader, ents);
 
-	gpt_init();
+	gpt_init(cxt);
 	DBG(LABEL, dbgprint("created new empty GPT disklabel "
 			    "(GUID: %08X-%04X-%04X-%02X%02X-%02X%02X%02X%02X%02X%02X)",
 			    pheader->disk_guid.time_low, pheader->disk_guid.time_mid,
diff --git a/fdisks/utils.c b/fdisks/utils.c
index cf4f643..ddb0da3 100644
--- a/fdisks/utils.c
+++ b/fdisks/utils.c
@@ -133,7 +133,7 @@ static int __probe_labels(struct fdisk_context *cxt)
 {
 	size_t i;
 
-	disklabel = ANY_LABEL;
+	cxt->disklabel = ANY_LABEL;
 	update_units(cxt);
 
 	for (i = 0; i < ARRAY_SIZE(labels); i++) {
@@ -376,7 +376,7 @@ int fdisk_dev_has_topology(struct fdisk_context *cxt)
  */
 int fdisk_dev_has_disklabel(struct fdisk_context *cxt)
 {
-	return cxt && disklabel != ANY_LABEL;
+	return cxt && cxt->disklabel != ANY_LABEL;
 }
 
 /**
-- 
1.7.9.5




