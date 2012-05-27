Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcahe.dreamhost.com ([208.97.132.74]:38575 "EHLO
	homiemail-a61.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752160Ab2E0ToI (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 27 May 2012 15:44:08 -0400
Subject: [PATCH 2/7] fdisk: use context as a parameter
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 27 May 2012 21:44:04 +0200
Message-ID: <1338147844.22474.1.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

This program heavily uses global variables, which isn't very elegant and can lead to nasty bugs. Modify functions that use fdisk's context current features (descriptor and path),
to receive the context as a parameter instead of globally. This includes DOS, SUN, SGI and BSD label code. Another benefit that comes with this is that as the API grows all the information
regarding fdisk will be accessible from this structure so we can reduce even more global variables and simply code.

This patch passed:
 - building
 - regression tests
 - local dos/sun/bsd partition changes

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c         |  104 +++++++++++++++++++++++++------------------------
 fdisk/fdisk.h         |   30 +++++++-------
 fdisk/fdiskbsdlabel.c |   86 +++++++++++++++++++++--------------------
 fdisk/fdiskbsdlabel.h |    8 ++--
 fdisk/fdiskdoslabel.c |   18 ++++----
 fdisk/fdiskdoslabel.h |    4 +-
 fdisk/fdisksgilabel.c |   14 +++---
 fdisk/fdisksgilabel.h |    6 +-
 fdisk/fdisksunlabel.c |   10 ++--
 fdisk/fdisksunlabel.h |    6 +-
 10 files changed, 144 insertions(+), 142 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 084253d..b304fe3 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -55,7 +55,6 @@
 
 unsigned char *MBRbuffer;
 int MBRbuffer_changed;
-struct fdisk_context *cxt = NULL;
 
 #define hex_val(c)	({ \
 				char _c = (c); \
@@ -180,7 +179,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-void fatal(enum failure why)
+void fatal(struct fdisk_context *cxt, enum failure why)
 {
 	close(cxt->dev_fd);
 	switch (why) {
@@ -453,7 +452,7 @@ void warn_alignment(void)
 }
 
 static void
-get_topology(int fd) {
+get_topology(struct fdisk_context *cxt) {
 	int arg;
 #ifdef HAVE_LIBBLKID
 	blkid_probe pr;
@@ -593,15 +592,15 @@ update_sector_offset(void)
 }
 
 void
-get_geometry(int fd, struct geom *g) {
+get_geometry(struct fdisk_context *cxt, struct geom *g) {
 	unsigned long long llcyls, nsects = 0;
 	unsigned int kern_heads = 0, kern_sectors = 0;
 
-	get_topology(fd);
+	get_topology(cxt);
 	heads = cylinders = sectors = 0;
 	pt_heads = pt_sectors = 0;
 
-	blkdev_get_geometry(fd, &kern_heads, &kern_sectors);
+	blkdev_get_geometry(cxt->dev_fd, &kern_heads, &kern_sectors);
 	get_partition_table_geometry();
 
 	heads = user_heads ? user_heads :
@@ -612,7 +611,7 @@ get_geometry(int fd, struct geom *g) {
 		kern_sectors ? kern_sectors : 63;
 
 	/* get number of 512-byte sectors, and convert it the real sectors */
-	if (blkdev_get_sectors(fd, &nsects) == 0)
+	if (blkdev_get_sectors(cxt->dev_fd, &nsects) == 0)
 		total_number_of_sectors = (nsects / (sector_size >> 9));
 
 	update_sector_offset();
@@ -658,7 +657,7 @@ void zeroize_mbr_buffer(void)
  *    0: found or created label
  *    1: I/O error
  */
-static int get_boot(int try_only) {
+static int get_boot(struct fdisk_context *cxt, int try_only) {
 
 	disklabel = ANY_LABEL;
 	memset(MBRbuffer, 0, 512);
@@ -666,17 +665,17 @@ static int get_boot(int try_only) {
 	if (512 != read(cxt->dev_fd, MBRbuffer, 512)) {
 		if (try_only)
 			return 1;
-		fatal(unable_to_read);
+		fatal(cxt, unable_to_read);
 	}
 
-	get_geometry(cxt->dev_fd, NULL);
+	get_geometry(cxt, NULL);
 	update_units();
 
-	if (!check_dos_label())
+	if (!check_dos_label(cxt))
 		if (check_sun_label() || check_sgi_label() || check_aix_label() || check_mac_label())
 			return 0;
 
-	if (check_osf_label()) {
+	if (check_osf_label(cxt)) {
 		/* intialize partitions for BSD as well */
 		dos_init();
 		if (!valid_part_table_flag(MBRbuffer)) {
@@ -695,7 +694,7 @@ static int get_boot(int try_only) {
 		fprintf(stderr,
 			_("Device does not contain a recognized partition table\n"));
 #ifdef __sparc__
-		create_sunlabel();
+		create_sunlabel(cxt);
 #else
 		create_doslabel();
 #endif
@@ -1214,7 +1213,7 @@ check_alignment(unsigned long long lba, int partition)
 }
 
 static void
-list_disk_geometry(void) {
+list_disk_geometry(struct fdisk_context *cxt) {
 	unsigned long long bytes = total_number_of_sectors * sector_size;
 	long megabytes = bytes/1000000;
 
@@ -1382,25 +1381,25 @@ fix_partition_table_order(void) {
 }
 
 static void
-list_table(int xtra) {
+list_table(struct fdisk_context *cxt, int xtra) {
 	struct partition *p;
 	char *type;
 	int i, w;
 
 	if (disklabel == SUN_LABEL) {
-		sun_list_table(xtra);
+		sun_list_table(cxt, xtra);
 		return;
 	}
 
 	if (disklabel == SGI_LABEL) {
-		sgi_list_table(xtra);
+		sgi_list_table(cxt, xtra);
 		return;
 	}
 
-	list_disk_geometry();
+	list_disk_geometry(cxt);
 
 	if (disklabel == OSF_LABEL) {
-		xbsd_print_disklabel(xtra);
+		xbsd_print_disklabel(cxt, xtra);
 		return;
 	}
 
@@ -1462,7 +1461,7 @@ list_table(int xtra) {
 }
 
 static void
-x_list_table(int extend) {
+x_list_table(struct fdisk_context *cxt, int extend) {
 	struct pte *pe;
 	struct partition *p;
 	int i;
@@ -1656,14 +1655,14 @@ static void new_partition(void)
 }
 
 static void
-write_table(void) {
+write_table(struct fdisk_context *cxt) {
 	int i;
 
 	if (disklabel == DOS_LABEL)
-		dos_write_table();
+		dos_write_table(cxt);
 	else if (disklabel == SGI_LABEL)
 		/* no test on change? the printf below might be mistaken */
-		sgi_write_table();
+		sgi_write_table(cxt);
 	else if (disklabel == SUN_LABEL) {
 		int needw = 0;
 
@@ -1671,15 +1670,15 @@ write_table(void) {
 			if (ptes[i].changed)
 				needw = 1;
 		if (needw)
-			sun_write_table();
+			sun_write_table(cxt);
 	}
 
 	printf(_("The partition table has been altered!\n\n"));
-	reread_partition_table(1);
+	reread_partition_table(cxt, 1);
 }
 
 void
-reread_partition_table(int leave) {
+reread_partition_table(struct fdisk_context *cxt, int leave) {
 	int i;
 	struct stat statbuf;
 
@@ -1740,10 +1739,10 @@ print_buffer(unsigned char pbuffer[]) {
 }
 
 static void
-print_raw(void) {
+print_raw(char *dev) {
 	int i;
 
-	printf(_("Device: %s\n"), cxt->dev_path);
+	printf(_("Device: %s\n"), dev);
 	if (disklabel == SUN_LABEL || disklabel == SGI_LABEL)
 		print_buffer(MBRbuffer);
 	else for (i = 3; i < partitions; i++)
@@ -1807,7 +1806,7 @@ static void __attribute__ ((__noreturn__)) handle_quit(struct fdisk_context *cxt
 }
 
 static void
-expert_command_prompt(void)
+expert_command_prompt(struct fdisk_context *cxt)
 {
 	char c;
 
@@ -1831,7 +1830,7 @@ expert_command_prompt(void)
 				sun_set_ncyl(cylinders);
 			break;
 		case 'd':
-			print_raw();
+			print_raw(cxt->dev_path);
 			break;
 		case 'e':
 			if (disklabel == SGI_LABEL)
@@ -1840,14 +1839,14 @@ expert_command_prompt(void)
 				sun_set_xcyl();
 			else
 			if (disklabel == DOS_LABEL)
-				x_list_table(1);
+				x_list_table(cxt, 1);
 			break;
 		case 'f':
 			if (disklabel == DOS_LABEL)
 				fix_partition_table_order();
 			break;
 		case 'g':
-			create_sgilabel();
+			create_sgilabel(cxt);
 			break;
 		case 'h':
 			user_heads = heads = read_int(1, heads, 256, 0,
@@ -1866,9 +1865,9 @@ expert_command_prompt(void)
 			break;
 		case 'p':
 			if (disklabel == SUN_LABEL)
-				list_table(1);
+				list_table(cxt, 1);
 			else
-				x_list_table(0);
+				x_list_table(cxt, 0);
 			break;
 		case 'q':
 			handle_quit(cxt);
@@ -1888,7 +1887,7 @@ expert_command_prompt(void)
 			verify();
 			break;
 		case 'w':
-			write_table(); 	/* does not return */
+			write_table(cxt); 	/* does not return */
 			break;
 		case 'y':
 			if (disklabel == SUN_LABEL)
@@ -1927,19 +1926,19 @@ print_partition_table_from_option(char *device)
 {
 	int gb;
 
-	cxt = fdisk_new_context_from_filename(device, 1);	/* read-only */
+	struct fdisk_context *cxt = fdisk_new_context_from_filename(device, 1);	/* read-only */
 	if (!cxt)
 		err(EXIT_FAILURE, _("unable to open %s"), device);
 
 	gpt_warning(device);
-	gb = get_boot(1);
+	gb = get_boot(cxt, 1);
 	if (gb < 0) { /* no DOS signature */
-		list_disk_geometry();
+		list_disk_geometry(cxt);
 		if (disklabel != AIX_LABEL && disklabel != MAC_LABEL)
-			btrydev(device);
+			btrydev(cxt);
 	}
 	else if (!gb)
-		list_table(0);
+		list_table(cxt, 0);
 	fdisk_free_context(cxt);
 	cxt = NULL;
 }
@@ -1993,7 +1992,7 @@ static void print_welcome(void)
 	fflush(stdout);
 }
 
-static void command_prompt(void)
+static void command_prompt(struct fdisk_context *cxt)
 {
 	int c;
 
@@ -2003,7 +2002,7 @@ static void command_prompt(void)
 		printf(_("Detected an OSF/1 disklabel on %s, entering "
 			 "disklabel mode.\n"),
 		       cxt->dev_path);
-		bsd_command_prompt();
+		bsd_command_prompt(cxt);
 		/* If we return we may want to make an empty DOS label? */
 		disklabel = DOS_LABEL;
 	}
@@ -2029,7 +2028,7 @@ static void command_prompt(void)
 				sgi_set_bootfile();
 			else if (disklabel == DOS_LABEL) {
 				disklabel = OSF_LABEL;
-				bsd_command_prompt();
+				bsd_command_prompt(cxt);
 				disklabel = DOS_LABEL;
 			} else
 				unknown_command(c);
@@ -2068,12 +2067,12 @@ static void command_prompt(void)
 			create_doslabel();
 			break;
 		case 'p':
-			list_table(0);
+			list_table(cxt, 0);
 			break;
 		case 'q':
 			handle_quit(cxt);
 		case 's':
-			create_sunlabel();
+			create_sunlabel(cxt);
 			break;
 		case 't':
 			change_sysid();
@@ -2085,10 +2084,10 @@ static void command_prompt(void)
 			verify();
 			break;
 		case 'w':
-			write_table(); 		/* does not return */
+			write_table(cxt); 		/* does not return */
 			break;
 		case 'x':
-			expert_command_prompt();
+			expert_command_prompt(cxt);
 			break;
 		default:
 			unknown_command(c);
@@ -2104,8 +2103,10 @@ static unsigned long long get_dev_blocks(char *dev)
 
 	if ((fd = open(dev, O_RDONLY)) < 0)
 		err(EXIT_FAILURE, _("unable to open %s"), dev);
-	if (blkdev_get_sectors(fd, &size) == -1)
-		fatal(ioctl_error);
+	if (blkdev_get_sectors(fd, &size) == -1) {
+		close(fd);
+		err(EXIT_FAILURE, _("BLKGETSIZE ioctl failed on %s"), dev);
+	}
 	close(fd);
 	return size/2;
 }
@@ -2113,6 +2114,7 @@ static unsigned long long get_dev_blocks(char *dev)
 int main(int argc, char **argv)
 {
 	int c, optl = 0, opts = 0;
+	struct fdisk_context *cxt = NULL;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -2223,9 +2225,9 @@ int main(int argc, char **argv)
 	print_welcome();
 
 	gpt_warning(cxt->dev_path);
-	get_boot(0);
+	get_boot(cxt, 0);
 
-	command_prompt();
+	command_prompt(cxt);
 
 	return 0;
 }
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index fab2a3a..9c75ca4 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -105,8 +105,6 @@ struct fdisk_context {
 	char *dev_path; /* device path */
 };
 
-extern struct fdisk_context *cxt;
-
 extern struct fdisk_context *fdisk_new_context_from_filename(const char *fname, int readonly);
 extern void fdisk_free_context(struct fdisk_context *cxt);
 
@@ -115,14 +113,14 @@ extern char *disk_device, *line_ptr;
 extern int fd, partitions;
 extern unsigned int display_in_cyl_units, units_per_sector;
 extern void change_units(void);
-extern void fatal(enum failure why);
-extern void get_geometry(int fd, struct geom *);
+extern void fatal(struct fdisk_context *cxt, enum failure why);
+extern void get_geometry(struct fdisk_context *, struct geom *);
 extern int  get_partition(int warn, int max);
 extern void list_types(struct systypes *sys);
 extern int read_line (int *asked);
 extern char read_char(char *mesg);
 extern int read_hex(struct systypes *sys);
-extern void reread_partition_table(int leave);
+extern void reread_partition_table(struct fdisk_context *cxt, int leave);
 extern struct partition *get_part_table(int);
 extern int valid_part_table_flag(unsigned char *b);
 extern unsigned int read_int(unsigned int low, unsigned int dflt,
@@ -200,25 +198,25 @@ static inline void set_start_sect(struct partition *p, unsigned int start_sect)
 	store4_little_endian(p->start4, start_sect);
 }
 
-static inline void seek_sector(int fd, unsigned long long secno)
+static inline void seek_sector(struct fdisk_context *cxt, unsigned long long secno)
 {
 	off_t offset = (off_t) secno * sector_size;
-	if (lseek(fd, offset, SEEK_SET) == (off_t) -1)
-		fatal(unable_to_seek);
+	if (lseek(cxt->dev_fd, offset, SEEK_SET) == (off_t) -1)
+		fatal(cxt, unable_to_seek);
 }
 
-static inline void read_sector(int fd, unsigned long long secno, unsigned char *buf)
+static inline void read_sector(struct fdisk_context *cxt, unsigned long long secno, unsigned char *buf)
 {
-	seek_sector(fd, secno);
-	if (read(fd, buf, sector_size) != sector_size)
-		fatal(unable_to_read);
+	seek_sector(cxt, secno);
+	if (read(cxt->dev_fd, buf, sector_size) != sector_size)
+		fatal(cxt, unable_to_read);
 }
 
-static inline void write_sector(int fd, unsigned long long secno, unsigned char *buf)
+static inline void write_sector(struct fdisk_context *cxt, unsigned long long secno, unsigned char *buf)
 {
-	seek_sector(fd, secno);
-	if (write(fd, buf, sector_size) != sector_size)
-		fatal(unable_to_write);
+	seek_sector(cxt, secno);
+	if (write(cxt->dev_fd, buf, sector_size) != sector_size)
+		fatal(cxt, unable_to_write);
 }
 
 static inline unsigned long long get_start_sect(struct partition *p)
diff --git a/fdisk/fdiskbsdlabel.c b/fdisk/fdiskbsdlabel.c
index 670e9bc..156483a 100644
--- a/fdisk/fdiskbsdlabel.c
+++ b/fdisk/fdiskbsdlabel.c
@@ -63,19 +63,21 @@
 
 static void xbsd_delete_part (void);
 static void xbsd_new_part (void);
-static void xbsd_write_disklabel (void);
-static int xbsd_create_disklabel (void);
+static void xbsd_write_disklabel (struct fdisk_context *cxt);
+static int xbsd_create_disklabel (struct fdisk_context *cxt);
 static void xbsd_edit_disklabel (void);
-static void xbsd_write_bootstrap (void);
+static void xbsd_write_bootstrap (struct fdisk_context *cxt);
 static void xbsd_change_fstype (void);
 static int xbsd_get_part_index (int max);
 static int xbsd_check_new_partition (int *i);
 static void xbsd_list_types (void);
 static unsigned short xbsd_dkcksum (struct xbsd_disklabel *lp);
-static int xbsd_initlabel  (struct partition *p, struct xbsd_disklabel *d,
+static int xbsd_initlabel  (struct fdisk_context *cxt,
+			    struct partition *p, struct xbsd_disklabel *d,
 			    int pindex);
-static int xbsd_readlabel  (struct partition *p, struct xbsd_disklabel *d);
-static int xbsd_writelabel (struct partition *p, struct xbsd_disklabel *d);
+static int xbsd_readlabel  (struct fdisk_context *cxt, 
+			    struct partition *p, struct xbsd_disklabel *d);
+static int xbsd_writelabel (struct fdisk_context *cxt, struct partition *p, struct xbsd_disklabel *d);
 static void sync_disks (void);
 
 #if defined (__alpha__)
@@ -108,18 +110,18 @@ static struct xbsd_disklabel xbsd_dlabel;
  * so this does not mean that there is a BSD disk label.
  */
 int
-check_osf_label(void) {
-	if (xbsd_readlabel (NULL, &xbsd_dlabel) == 0)
+check_osf_label(struct fdisk_context *cxt) {
+	if (xbsd_readlabel (cxt, NULL, &xbsd_dlabel) == 0)
 		return 0;
 	return 1;
 }
 
 int
-btrydev (char * dev) {
-	if (xbsd_readlabel (NULL, &xbsd_dlabel) == 0)
+btrydev (struct fdisk_context *cxt) {
+	if (xbsd_readlabel (cxt, NULL, &xbsd_dlabel) == 0)
 		return -1;
-	printf(_("\nBSD label for device: %s\n"), dev);
-	xbsd_print_disklabel (0);
+	printf(_("\nBSD label for device: %s\n"), cxt->dev_path);
+	xbsd_print_disklabel (cxt, 0);
 	return 0;
 }
 
@@ -139,7 +141,7 @@ is_bsd_partition_type(int type) {
 #endif
 
 void
-bsd_command_prompt (void)
+bsd_command_prompt (struct fdisk_context *cxt)
 {
 #if !defined (__alpha__)
   int t, ss;
@@ -158,8 +160,8 @@ bsd_command_prompt (void)
       }
       printf (_("Reading disklabel of %s at sector %d.\n"),
 	      partname(cxt->dev_path, t+1, 0), ss + BSD_LABELSECTOR);
-      if (xbsd_readlabel (xbsd_part, &xbsd_dlabel) == 0)
-	if (xbsd_create_disklabel () == 0)
+      if (xbsd_readlabel (cxt, xbsd_part, &xbsd_dlabel) == 0)
+	if (xbsd_create_disklabel (cxt) == 0)
 	  return;
       break;
     }
@@ -172,8 +174,8 @@ bsd_command_prompt (void)
 
 #elif defined (__alpha__)
 
-  if (xbsd_readlabel (NULL, &xbsd_dlabel) == 0)
-    if (xbsd_create_disklabel () == 0)
+  if (xbsd_readlabel (cxt, NULL, &xbsd_dlabel) == 0)
+    if (xbsd_create_disklabel (cxt) == 0)
       exit ( EXIT_SUCCESS );
 
 #endif
@@ -188,7 +190,7 @@ bsd_command_prompt (void)
 	xbsd_edit_disklabel ();
 	break;
       case 'i':
-	xbsd_write_bootstrap ();
+	xbsd_write_bootstrap (cxt);
 	break;
       case 'l':
 	xbsd_list_types ();
@@ -197,7 +199,7 @@ bsd_command_prompt (void)
 	xbsd_new_part ();
 	break;
       case 'p':
-	xbsd_print_disklabel (0);
+	      xbsd_print_disklabel (cxt, 0);
 	break;
       case 'q':
 	close (cxt->dev_fd);
@@ -205,7 +207,7 @@ bsd_command_prompt (void)
       case 'r':
 	return;
       case 's':
-	xbsd_print_disklabel (1);
+	      xbsd_print_disklabel (cxt, 1);
 	break;
       case 't':
 	xbsd_change_fstype ();
@@ -214,7 +216,7 @@ bsd_command_prompt (void)
 	change_units();
 	break;
       case 'w':
-	xbsd_write_disklabel ();
+	xbsd_write_disklabel (cxt);
 	break;
 #if !defined (__alpha__)
       case 'x':
@@ -281,7 +283,7 @@ xbsd_new_part (void)
 }
 
 void
-xbsd_print_disklabel (int show_all) {
+xbsd_print_disklabel (struct fdisk_context *cxt, int show_all) {
   struct xbsd_disklabel *lp = &xbsd_dlabel;
   struct xbsd_partition *pp;
   FILE *f = stdout;
@@ -379,20 +381,20 @@ xbsd_print_disklabel (int show_all) {
 }
 
 static void
-xbsd_write_disklabel (void) {
+xbsd_write_disklabel (struct fdisk_context *cxt) {
 #if defined (__alpha__)
 	printf (_("Writing disklabel to %s.\n"), cxt->dev_path);
-	xbsd_writelabel (NULL, &xbsd_dlabel);
+	xbsd_writelabel (cxt, NULL, &xbsd_dlabel);
 #else
 	printf (_("Writing disklabel to %s.\n"),
 		partname(cxt->dev_path, xbsd_part_index+1, 0));
-	xbsd_writelabel (xbsd_part, &xbsd_dlabel);
+	xbsd_writelabel (cxt, xbsd_part, &xbsd_dlabel);
 #endif
-	reread_partition_table(0);	/* no exit yet */
+	reread_partition_table(cxt, 0);	/* no exit yet */
 }
 
 static int
-xbsd_create_disklabel (void) {
+xbsd_create_disklabel (struct fdisk_context *cxt) {
 	char c;
 
 #if defined (__alpha__)
@@ -405,7 +407,7 @@ xbsd_create_disklabel (void) {
 	while (1) {
 		c = read_char (_("Do you want to create a disklabel? (y/n) "));
 		if (tolower(c) == 'y') {
-			if (xbsd_initlabel (
+			if (xbsd_initlabel (cxt, 
 #if defined (__alpha__) || defined (__powerpc__) || defined (__hppa__) || \
     defined (__s390__) || defined (__s390x__)
 				NULL, &xbsd_dlabel, 0
@@ -413,7 +415,7 @@ xbsd_create_disklabel (void) {
 				xbsd_part, &xbsd_dlabel, xbsd_part_index
 #endif
 				) == 1) {
-				xbsd_print_disklabel (1);
+				xbsd_print_disklabel (cxt, 1);
 				return 1;
 			} else
 				return 0;
@@ -491,7 +493,7 @@ xbsd_get_bootstrap (char *path, void *ptr, int size)
 }
 
 static void
-xbsd_write_bootstrap (void)
+xbsd_write_bootstrap (struct fdisk_context *cxt)
 {
   char *bootdir = BSD_LINUX_BOOTDIR;
   char path[sizeof(BSD_LINUX_BOOTDIR) + 1 + 2 + 4];  /* BSD_LINUX_BOOTDIR + / + {sd,wd} + boot */
@@ -546,9 +548,9 @@ xbsd_write_bootstrap (void)
 #endif
 
   if (lseek (cxt->dev_fd, (off_t) sector * SECTOR_SIZE, SEEK_SET) == -1)
-    fatal (unable_to_seek);
+	  fatal (cxt, unable_to_seek);
   if (BSD_BBSIZE != write (cxt->dev_fd, disklabelbuffer, BSD_BBSIZE))
-    fatal (unable_to_write);
+	  fatal (cxt, unable_to_write);
 
 #if defined (__alpha__)
   printf (_("Bootstrap installed on %s.\n"), cxt->dev_path);
@@ -631,12 +633,12 @@ xbsd_dkcksum (struct xbsd_disklabel *lp) {
 }
 
 static int
-xbsd_initlabel (struct partition *p, struct xbsd_disklabel *d,
+xbsd_initlabel (struct fdisk_context *cxt, struct partition *p, struct xbsd_disklabel *d,
 		int pindex __attribute__((__unused__))) {
 	struct xbsd_partition *pp;
 	struct geom g;
 
-	get_geometry (cxt->dev_fd, &g);
+	get_geometry (cxt, &g);
 	memset (d, 0, sizeof (struct xbsd_disklabel));
 
 	d -> d_magic = BSD_DISKMAGIC;
@@ -704,7 +706,7 @@ xbsd_initlabel (struct partition *p, struct xbsd_disklabel *d,
  * If it has the right magic, return 1.
  */
 static int
-xbsd_readlabel (struct partition *p, struct xbsd_disklabel *d)
+xbsd_readlabel (struct fdisk_context *cxt, struct partition *p, struct xbsd_disklabel *d)
 {
 	int t, sector;
 
@@ -716,9 +718,9 @@ xbsd_readlabel (struct partition *p, struct xbsd_disklabel *d)
 #endif
 
 	if (lseek (cxt->dev_fd, (off_t) sector * SECTOR_SIZE, SEEK_SET) == -1)
-		fatal (unable_to_seek);
+		fatal (cxt, unable_to_seek);
 	if (BSD_BBSIZE != read (cxt->dev_fd, disklabelbuffer, BSD_BBSIZE))
-		fatal (unable_to_read);
+		fatal (cxt, unable_to_read);
 
 	memmove (d,
 	         &disklabelbuffer[BSD_LABELSECTOR * SECTOR_SIZE + BSD_LABELOFFSET],
@@ -741,7 +743,7 @@ xbsd_readlabel (struct partition *p, struct xbsd_disklabel *d)
 }
 
 static int
-xbsd_writelabel (struct partition *p, struct xbsd_disklabel *d)
+xbsd_writelabel (struct fdisk_context *cxt, struct partition *p, struct xbsd_disklabel *d)
 {
   unsigned int sector;
 
@@ -763,15 +765,15 @@ xbsd_writelabel (struct partition *p, struct xbsd_disklabel *d)
 #if defined (__alpha__) && BSD_LABELSECTOR == 0
   alpha_bootblock_checksum (disklabelbuffer);
   if (lseek (cxt->dev_fd, (off_t) 0, SEEK_SET) == -1)
-    fatal (unable_to_seek);
+	  fatal (cxt, unable_to_seek);
   if (BSD_BBSIZE != write (cxt->dev_fd, disklabelbuffer, BSD_BBSIZE))
-    fatal (unable_to_write);
+	  fatal (cxt, unable_to_write);
 #else
   if (lseek (cxt->dev_fd, (off_t) sector * SECTOR_SIZE + BSD_LABELOFFSET,
 		   SEEK_SET) == -1)
-    fatal (unable_to_seek);
+	  fatal (cxt, unable_to_seek);
   if (sizeof (struct xbsd_disklabel) != write (cxt->dev_fd, d, sizeof (struct xbsd_disklabel)))
-    fatal (unable_to_write);
+	  fatal (cxt, unable_to_write);
 #endif
 
   sync_disks ();
diff --git a/fdisk/fdiskbsdlabel.h b/fdisk/fdiskbsdlabel.h
index 9bea7cf..79f2913 100644
--- a/fdisk/fdiskbsdlabel.h
+++ b/fdisk/fdiskbsdlabel.h
@@ -238,9 +238,9 @@ static struct systypes xbsd_fstypes[] = {
 #define	BSD_D_CHAIN    	0x10		/* can do back-back transfers */
 #define	BSD_D_DOSPART	0x20		/* within MSDOS partition */
 
-extern void bsd_command_prompt(void);
-extern int check_osf_label(void);
-extern int btrydev(char * dev);
-extern void xbsd_print_disklabel(int);
+extern void bsd_command_prompt(struct fdisk_context *cxt);
+extern int check_osf_label(struct fdisk_context *cxt);
+extern int btrydev(struct fdisk_context *cxt);
+extern void xbsd_print_disklabel(struct fdisk_context *cxt, int);
 
 #endif /* FDISK_BSD_LABEL_H */
diff --git a/fdisk/fdiskdoslabel.c b/fdisk/fdiskdoslabel.c
index 4a93691..1bd27ef 100644
--- a/fdisk/fdiskdoslabel.c
+++ b/fdisk/fdiskdoslabel.c
@@ -59,13 +59,13 @@ static int get_nonexisting_partition(int warn, int max)
 

 /* Allocate a buffer and read a partition table sector */
-static void read_pte(int fd, int pno, unsigned long long offset)
+static void read_pte(struct fdisk_context *cxt, int pno, unsigned long long offset)
 {
 	struct pte *pe = &ptes[pno];
 
 	pe->offset = offset;
 	pe->sectorbuffer = xmalloc(sector_size);
-	read_sector(fd, offset, pe->sectorbuffer);
+	read_sector(cxt, offset, pe->sectorbuffer);
 	pe->changed = 0;
 	pe->part_table = pe->ext_pointer = NULL;
 }
@@ -120,7 +120,7 @@ void dos_init(void)
 	warn_alignment();
 }
 
-static void read_extended(int ext)
+static void read_extended(struct fdisk_context *cxt, int ext)
 {
 	int i;
 	struct pte *pex;
@@ -156,7 +156,7 @@ static void read_extended(int ext)
 			return;
 		}
 
-		read_pte(cxt->dev_fd, partitions, extended_offset + get_start_sect(p));
+		read_pte(cxt, partitions, extended_offset + get_start_sect(p));
 
 		if (!extended_offset)
 			extended_offset = get_start_sect(p);
@@ -317,7 +317,7 @@ void dos_delete_partition(int i)
 	}
 }
 
-int check_dos_label(void)
+int check_dos_label(struct fdisk_context *cxt)
 {
 	int i;
 
@@ -334,7 +334,7 @@ int check_dos_label(void)
 				fprintf(stderr, _("Ignoring extra extended "
 					"partition %d\n"), i + 1);
 			else
-				read_extended(i);
+				read_extended(cxt, i);
 		}
 	}
 
@@ -658,7 +658,7 @@ void dos_new_partition(void)
 	}
 }
 
-void dos_write_table(void)
+void dos_write_table(struct fdisk_context *cxt)
 {
 	int i;
 
@@ -670,7 +670,7 @@ void dos_write_table(void)
 	}
 	if (MBRbuffer_changed) {
 		write_part_table_flag(MBRbuffer);
-		write_sector(cxt->dev_fd, 0, MBRbuffer);
+		write_sector(cxt, 0, MBRbuffer);
 	}
 	/* EBR (logical partitions) */
 	for (i = 4; i < partitions; i++) {
@@ -678,7 +678,7 @@ void dos_write_table(void)
 
 		if (pe->changed) {
 			write_part_table_flag(pe->sectorbuffer);
-			write_sector(cxt->dev_fd, pe->offset, pe->sectorbuffer);
+			write_sector(cxt, pe->offset, pe->sectorbuffer);
 		}
 	}
 }
diff --git a/fdisk/fdiskdoslabel.h b/fdisk/fdiskdoslabel.h
index 8c116f7..7f5e48e 100644
--- a/fdisk/fdiskdoslabel.h
+++ b/fdisk/fdiskdoslabel.h
@@ -47,11 +47,11 @@ extern void create_doslabel(void);
 extern void dos_print_mbr_id(void);
 extern void dos_set_mbr_id(void);
 extern void dos_delete_partition(int i);
-extern int check_dos_label(void);
+extern int check_dos_label(struct fdisk_context *cxt);
 extern int is_dos_partition(int t);
 extern void dos_init(void);
 extern void dos_add_partition(int n, int sys);
 extern void dos_new_partition(void);
-extern void dos_write_table(void);
+extern void dos_write_table(struct fdisk_context *cxt);
 
 #endif
diff --git a/fdisk/fdisksgilabel.c b/fdisk/fdisksgilabel.c
index c2ef06d..3ef9d69 100644
--- a/fdisk/fdisksgilabel.c
+++ b/fdisk/fdisksgilabel.c
@@ -178,7 +178,7 @@ check_sgi_label() {
 }
 
 void
-sgi_list_table(int xtra) {
+sgi_list_table(struct fdisk_context *cxt, int xtra) {
 	int i, w;
 	int kpi = 0;		/* kernel partition ID */
 	char *type;
@@ -350,7 +350,7 @@ create_sgiinfo(void) {
 sgiinfo *fill_sgiinfo(void);
 
 void
-sgi_write_table(void) {
+sgi_write_table(struct fdisk_context *cxt) {
 	sgilabel->csum = 0;
 	sgilabel->csum = SSWAP32(two_s_complement_32bit_sum(
 		(unsigned int*)sgilabel, 
@@ -358,9 +358,9 @@ sgi_write_table(void) {
 	assert(two_s_complement_32bit_sum(
 		(unsigned int*)sgilabel, sizeof(*sgilabel)) == 0);
 	if (lseek(cxt->dev_fd, 0, SEEK_SET) < 0)
-		fatal(unable_to_seek);
+		fatal(cxt, unable_to_seek);
 	if (write(cxt->dev_fd, sgilabel, SECTOR_SIZE) != SECTOR_SIZE)
-		fatal(unable_to_write);
+		fatal(cxt, unable_to_write);
 	if (! strncmp((char *) sgilabel->directory[0].vol_file_name, "sgilabel", 8)) {
 		/*
 		 * keep this habit of first writing the "sgilabel".
@@ -370,9 +370,9 @@ sgi_write_table(void) {
 		int infostartblock = SSWAP32(sgilabel->directory[0].vol_file_start);
 		if (lseek(cxt->dev_fd, (off_t) infostartblock*
 				SECTOR_SIZE, SEEK_SET) < 0)
-			fatal(unable_to_seek);
+			fatal(cxt, unable_to_seek);
 		if (write(cxt->dev_fd, info, SECTOR_SIZE) != SECTOR_SIZE)
-			fatal(unable_to_write);
+			fatal(cxt, unable_to_write);
 		free(info);
 	}
 }
@@ -682,7 +682,7 @@ sgi_add_partition(int n, int sys)
 }
 
 void
-create_sgilabel(void)
+create_sgilabel(struct fdisk_context *cxt)
 {
 	struct hd_geometry geometry;
 	struct {
diff --git a/fdisk/fdisksgilabel.h b/fdisk/fdisksgilabel.h
index 255fe9c..3a11499 100644
--- a/fdisk/fdisksgilabel.h
+++ b/fdisk/fdisksgilabel.h
@@ -113,17 +113,17 @@ typedef struct {
 extern struct	systypes sgi_sys_types[];
 extern void	sgi_nolabel( void );
 extern int	check_sgi_label( void );
-extern void	sgi_list_table( int xtra );
+extern void	sgi_list_table( struct fdisk_context *cxt, int xtra );
 extern int  sgi_change_sysid( int i, int sys );
 extern unsigned int	sgi_get_start_sector( int i );
 extern unsigned int	sgi_get_num_sectors( int i );
 extern int	sgi_get_sysid( int i );
 extern void	sgi_delete_partition( int i );
 extern void	sgi_add_partition( int n, int sys );
-extern void	create_sgilabel( void );
+extern void	create_sgilabel( struct fdisk_context *cxt );
 extern void	create_sgiinfo( void );
 extern int	verify_sgi( int verbose );
-extern void	sgi_write_table( void );
+extern void	sgi_write_table( struct fdisk_context *cxt );
 extern void	sgi_set_ilfact( void );
 extern void	sgi_set_rspeed( void );
 extern void	sgi_set_pcylcount( void );
diff --git a/fdisk/fdisksunlabel.c b/fdisk/fdisksunlabel.c
index 6944824..e94b652 100644
--- a/fdisk/fdisksunlabel.c
+++ b/fdisk/fdisksunlabel.c
@@ -149,7 +149,7 @@ int check_sun_label(void)
 	return 1;
 }
 
-void create_sunlabel(void)
+void create_sunlabel(struct fdisk_context *cxt)
 {
 	struct hd_geometry geometry;
 	unsigned long long llsectors, llcyls;
@@ -533,7 +533,7 @@ int sun_change_sysid(int i, uint16_t sys)
 	return 1;
 }
 
-void sun_list_table(int xtra)
+void sun_list_table(struct fdisk_context *cxt, int xtra)
 {
 	int i, w;
 	char *type;
@@ -626,7 +626,7 @@ void sun_set_pcylcount(void)
 				 _("Number of physical cylinders")));
 }
 
-void sun_write_table(void)
+void sun_write_table(struct fdisk_context *cxt)
 {
 	unsigned short *ush = (unsigned short *)sunlabel;
 	unsigned short csum = 0;
@@ -635,9 +635,9 @@ void sun_write_table(void)
 		csum ^= *ush++;
 	sunlabel->cksum = csum;
 	if (lseek(cxt->dev_fd, 0, SEEK_SET) < 0)
-		fatal(unable_to_seek);
+		fatal(cxt, unable_to_seek);
 	if (write(cxt->dev_fd, sunlabel, SECTOR_SIZE) != SECTOR_SIZE)
-		fatal(unable_to_write);
+		fatal(cxt, unable_to_write);
 }
 
 int sun_get_sysid(int i)
diff --git a/fdisk/fdisksunlabel.h b/fdisk/fdisksunlabel.h
index fa3f964..f33fe1c 100644
--- a/fdisk/fdisksunlabel.h
+++ b/fdisk/fdisksunlabel.h
@@ -79,13 +79,13 @@ struct sun_disk_label {
 extern struct systypes sun_sys_types[];
 extern int check_sun_label(void);
 extern void sun_nolabel(void);
-extern void create_sunlabel(void);
+extern void create_sunlabel(struct fdisk_context *cxt);
 extern void sun_delete_partition(int i);
 extern int sun_change_sysid(int i, uint16_t sys);
-extern void sun_list_table(int xtra);
+extern void sun_list_table(struct fdisk_context *cxt, int xtra);
 extern void verify_sun(void);
 extern void add_sun_partition(int n, int sys);
-extern void sun_write_table(void);
+extern void sun_write_table(struct fdisk_context *cxt);
 extern void sun_set_alt_cyl(void);
 extern void sun_set_ncyl(int cyl);
 extern void sun_set_xcyl(void);
-- 
1.7.4.1




