Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcagg.dreamhost.com ([208.97.132.66]:58241 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757512Ab2FQQKP (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 17 Jun 2012 12:10:15 -0400
Subject: [PATCH 3/9] fdisk: API: add mbr
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 17 Jun 2012 18:10:07 +0200
Message-ID: <1339949407.2668.15.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

This patch adds to the fdisk API the relevant logic to buffers that have MBR. This also serves for
future GPT support for the protective MBR. All labels have been updated to have access to the cxt
structure for the corresponding buffer.

An important observation is that SGI no longer uses the standard qsort(3) function to sort partitions,
as it needs access to cxt. To address this, a heap sort implementation from the kernel was added to
the label code and adapted to fdisk.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c         |   83 +++++++-------------
 fdisk/fdisk.h         |   13 +--
 fdisk/fdiskaixlabel.c |   11 ++-
 fdisk/fdiskaixlabel.h |    6 +-
 fdisk/fdiskdoslabel.c |   29 ++++----
 fdisk/fdiskdoslabel.h |    4 +-
 fdisk/fdiskmaclabel.c |    8 +-
 fdisk/fdiskmaclabel.h |    6 +-
 fdisk/fdisksgilabel.c |  209 +++++++++++++++++++++++++++++++------------------
 fdisk/fdisksgilabel.h |   28 ++++----
 fdisk/fdisksunlabel.c |   26 ++++---
 fdisk/fdisksunlabel.h |   18 ++--
 fdisk/utils.c         |   31 +++++++
 13 files changed, 262 insertions(+), 210 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 4bab260..6f9e412 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -1,6 +1,7 @@
 /* fdisk.c -- Partition table manipulator for Linux.
  *
  * Copyright (C) 1992  A. V. Le Blanc (LeBlanc@mcc.ac.uk)
+ * Copyright (C) 2012  Davidlohr Bueso <dave@gnu.org>
  *
  * This program is free software.  You can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -50,7 +51,6 @@
 
 #include "gpt.h"
 
-unsigned char *MBRbuffer;
 int MBRbuffer_changed;
 
 #define hex_val(c)	({ \
@@ -231,10 +231,10 @@ void print_menu(enum menutype menu)
 }
 
 static int
-get_sysid(int i) {
+get_sysid(struct fdisk_context *cxt, int i) {
 	return (
-		disklabel == SUN_LABEL ? sun_get_sysid(i) :
-		disklabel == SGI_LABEL ? sgi_get_sysid(i) :
+		disklabel == SUN_LABEL ? sun_get_sysid(cxt, i) :
+		disklabel == SGI_LABEL ? sgi_get_sysid(cxt, i) :
 		ptes[i].part_table->sys_ind);
 }
 
@@ -439,8 +439,8 @@ void warn_alignment(struct fdisk_context *cxt)
 }
 
 static void
-get_partition_table_geometry(void) {
-	unsigned char *bufp = MBRbuffer;
+get_partition_table_geometry(struct fdisk_context *cxt) {
+	unsigned char *bufp = cxt->mbr;
 	struct partition *p;
 	int i, h, s, hh, ss;
 	int first = 1;
@@ -530,7 +530,7 @@ get_geometry(struct fdisk_context *cxt, struct geom *g)
 	pt_heads = pt_sectors = 0;
 
 	blkdev_get_geometry(cxt->dev_fd, &kern_heads, &kern_sectors);
-	get_partition_table_geometry();
+	get_partition_table_geometry(cxt);
 
 	heads = user_heads ? user_heads :
 		pt_heads ? pt_heads :
@@ -556,27 +556,6 @@ get_geometry(struct fdisk_context *cxt, struct geom *g)
 }
 
 /*
- * Please, always use allocated buffer if you want to cast the buffer to
- * any struct -- cast non-allocated buffer to any struct is against
- * strict-aliasing rules.  --kzak 16-Oct-2009
- */
-static void init_mbr_buffer(void)
-{
-	if (MBRbuffer)
-		return;
-
-	MBRbuffer = xcalloc(1, MAX_SECTOR_SIZE);
-}
-
-void zeroize_mbr_buffer(void)
-{
-	if (MBRbuffer)
-		memset(MBRbuffer, 0, MAX_SECTOR_SIZE);
-}
-
-
-
-/*
  * Read MBR.  Returns:
  *   -1: no 0xaa55 flag present (possibly entire disk BSD)
  *    0: found or created label
@@ -585,25 +564,19 @@ void zeroize_mbr_buffer(void)
 static int get_boot(struct fdisk_context *cxt, int try_only) {
 
 	disklabel = ANY_LABEL;
-	memset(MBRbuffer, 0, 512);
-
-	if (512 != read(cxt->dev_fd, MBRbuffer, 512)) {
-		if (try_only)
-			return 1;
-		fatal(cxt, unable_to_read);
-	}
 
 	get_geometry(cxt, NULL);
 	update_units();
 
 	if (!check_dos_label(cxt))
-		if (check_sun_label() || check_sgi_label() || check_aix_label() || check_mac_label())
+		if (check_sun_label(cxt) || check_sgi_label(cxt) || check_aix_label(cxt) 
+		    || check_mac_label(cxt))
 			return 0;
 
 	if (check_osf_label(cxt)) {
 		/* intialize partitions for BSD as well */
 		dos_init(cxt);
-		if (!valid_part_table_flag(MBRbuffer)) {
+		if (!valid_part_table_flag(cxt->mbr)) {
 			disklabel = OSF_LABEL;
 			return 0;
 		}
@@ -879,7 +852,7 @@ get_partition_dflt(struct fdisk_context *cxt, int warn, int max, int dflt) {
 		    || (disklabel == SUN_LABEL &&
 			(!sunlabel->partitions[i].num_sectors ||
 			 !sunlabel->part_tags[i].tag))
-		    || (disklabel == SGI_LABEL && (!sgi_get_num_sectors(i)))
+		    || (disklabel == SGI_LABEL && (!sgi_get_num_sectors(cxt, i)))
 		   )
 			fprintf(stderr,
 				_("Warning: partition %d has empty type\n"),
@@ -983,7 +956,7 @@ delete_partition(struct fdisk_context *cxt, int i)
 	if (disklabel == DOS_LABEL)
 		dos_delete_partition(i);
 	else if (disklabel == SUN_LABEL)
-		sun_delete_partition(i);
+		sun_delete_partition(cxt, i);
 	else if (disklabel == SGI_LABEL)
 		sgi_delete_partition(cxt, i);
 
@@ -1001,7 +974,7 @@ static void change_sysid(struct fdisk_context *cxt)
 	if (i == -1)
 		return;
 	p = ptes[i].part_table;
-	origsys = sys = get_sysid(i);
+	origsys = sys = get_sysid(cxt, i);
 
 	/* if changing types T to 0 is allowed, then
 	   the reverse change must be allowed, too */
@@ -1042,10 +1015,10 @@ static void change_sysid(struct fdisk_context *cxt)
                         if (sys == origsys)
 				break;
 			if (disklabel == SUN_LABEL) {
-				ptes[i].changed = sun_change_sysid(i, sys);
+				ptes[i].changed = sun_change_sysid(cxt, i, sys);
 			} else
 			if (disklabel == SGI_LABEL) {
-				ptes[i].changed = sgi_change_sysid(i, sys);
+				ptes[i].changed = sgi_change_sysid(cxt, i, sys);
 			} else {
 				p->sys_ind = sys;
 				ptes[i].changed = 1;
@@ -1168,7 +1141,7 @@ list_disk_geometry(struct fdisk_context *cxt) {
 	if (cxt->alignment_offset)
 		printf(_("Alignment offset: %lu bytes\n"), cxt->alignment_offset);
 	if (disklabel == DOS_LABEL)
-		dos_print_mbr_id();
+		dos_print_mbr_id(cxt);
 	printf("\n");
 }
 
@@ -1471,12 +1444,12 @@ verify(struct fdisk_context *cxt) {
 		return;
 
 	if (disklabel == SUN_LABEL) {
-		verify_sun();
+		verify_sun(cxt);
 		return;
 	}
 
 	if (disklabel == SGI_LABEL) {
-		verify_sgi(1);
+		verify_sgi(cxt, 1);
 		return;
 	}
 
@@ -1671,7 +1644,7 @@ static void print_raw(struct fdisk_context *cxt)
 
 	printf(_("Device: %s\n"), cxt->dev_path);
 	if (disklabel == SUN_LABEL || disklabel == SGI_LABEL)
-		print_buffer(cxt, MBRbuffer);
+		print_buffer(cxt, cxt->mbr);
 	else for (i = 3; i < partitions; i++)
 		     print_buffer(cxt, ptes[i].sectorbuffer);
 }
@@ -1754,7 +1727,7 @@ expert_command_prompt(struct fdisk_context *cxt)
 				read_int(cxt, 1, cylinders, 1048576, 0,
 					 _("Number of cylinders"));
 			if (disklabel == SUN_LABEL)
-				sun_set_ncyl(cylinders);
+				sun_set_ncyl(cxt, cylinders);
 			break;
 		case 'd':
 			print_raw(cxt);
@@ -1784,7 +1757,7 @@ expert_command_prompt(struct fdisk_context *cxt)
 			if (disklabel == SUN_LABEL)
 				sun_set_ilfact(cxt);
 			else if (disklabel == DOS_LABEL)
-				dos_set_mbr_id();
+				dos_set_mbr_id(cxt);
 			break;
 		case 'o':
 			if (disklabel == SUN_LABEL)
@@ -1942,17 +1915,17 @@ static void command_prompt(struct fdisk_context *cxt)
 			if (disklabel == DOS_LABEL)
 				toggle_active(get_partition(cxt, 1, partitions));
 			else if (disklabel == SUN_LABEL)
-				toggle_sunflags(get_partition(cxt, 1, partitions),
+				toggle_sunflags(cxt, get_partition(cxt, 1, partitions),
 						SUN_FLAG_UNMNT);
 			else if (disklabel == SGI_LABEL)
-				sgi_set_bootpartition(
+				sgi_set_bootpartition(cxt,
 					get_partition(cxt, 1, partitions));
 			else
 				unknown_command(c);
 			break;
 		case 'b':
 			if (disklabel == SGI_LABEL)
-				sgi_set_bootfile();
+				sgi_set_bootfile(cxt);
 			else if (disklabel == DOS_LABEL) {
 				disklabel = OSF_LABEL;
 				bsd_command_prompt(cxt);
@@ -1964,10 +1937,10 @@ static void command_prompt(struct fdisk_context *cxt)
 			if (disklabel == DOS_LABEL)
 				toggle_dos_compatibility_flag(cxt);
 			else if (disklabel == SUN_LABEL)
-				toggle_sunflags(get_partition(cxt, 1, partitions),
+				toggle_sunflags(cxt, get_partition(cxt, 1, partitions),
 						SUN_FLAG_RONLY);
 			else if (disklabel == SGI_LABEL)
-				sgi_set_swappartition(
+				sgi_set_swappartition(cxt,
 					get_partition(cxt, 1, partitions));
 			else
 				unknown_command(c);
@@ -1977,7 +1950,7 @@ static void command_prompt(struct fdisk_context *cxt)
 			break;
 		case 'i':
 			if (disklabel == SGI_LABEL)
-				create_sgiinfo();
+				create_sgiinfo(cxt);
 			else
 				unknown_command(c);
 			break;
@@ -2113,7 +2086,7 @@ int main(int argc, char **argv)
 		printf(_("Warning: the -b (set sector size) option should"
 			 " be used with one specified device\n"));
 
-	init_mbr_buffer();
+	/* init_mbr_buffer(); */
 
 	if (optl) {
 		nowarn = 1;
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index 9d17cdd..b4f2814 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -104,8 +104,9 @@ struct geom {
 typedef unsigned long long sector_t;
 
 struct fdisk_context {
-	int dev_fd;     /* device descriptor */
-	char *dev_path; /* device path */
+	int dev_fd;         /* device descriptor */
+	char *dev_path;     /* device path */
+	unsigned char *mbr; /* buffer with master boot record */
 
 	/* topology */
 	unsigned long io_size;		/* I/O size used by fdisk */
@@ -123,6 +124,7 @@ extern struct fdisk_context *fdisk_new_context_from_filename(const char *fname,
 extern int fdisk_dev_has_topology(struct fdisk_context *cxt);
 extern int fdisk_dev_sectsz_is_default(struct fdisk_context *cxt);
 extern void fdisk_free_context(struct fdisk_context *cxt);
+extern void fdisk_mbr_zeroize(struct fdisk_context *cxt);
 
 /* prototypes for fdisk.c */
 extern char *disk_device, *line_ptr;
@@ -145,7 +147,6 @@ extern unsigned int read_int(struct fdisk_context *cxt,
 extern void print_menu(enum menutype);
 extern void print_partition_size(struct fdisk_context *cxt, int num, sector_t start, sector_t stop, int sysid);
 
-extern void zeroize_mbr_buffer(void);
 extern void fill_bounds(sector_t *first, sector_t *last);
 extern unsigned int heads, cylinders;
 extern sector_t sectors;
@@ -180,12 +181,6 @@ enum labeltype {
 };
 
 extern enum labeltype disklabel;
-
-/*
- * Raw disk label. For DOS-type partition tables the MBR,
- * with descriptions of the primary partitions.
- */
-extern unsigned char *MBRbuffer;
 extern int MBRbuffer_changed;
 extern unsigned long grain;
 
diff --git a/fdisk/fdiskaixlabel.c b/fdisk/fdiskaixlabel.c
index 9fde61f..c15ab74 100644
--- a/fdisk/fdiskaixlabel.c
+++ b/fdisk/fdiskaixlabel.c
@@ -14,6 +14,8 @@
 #include "fdiskaixlabel.h"
 #include "nls.h"
 
+#define aixlabel ((aix_partition *)cxt->mbr)
+
 static	int     other_endian = 0;
 static  short	volumes=1;
 
@@ -39,16 +41,15 @@ aix_info( void ) {
 }
 
 void
-aix_nolabel( void )
+aix_nolabel(struct fdisk_context *cxt)
 {
     aixlabel->magic = 0;
     partitions = 4;
-    zeroize_mbr_buffer();
+    fdisk_mbr_zeroize(cxt);
     return;
 }
 
-int
-check_aix_label( void )
+int check_aix_label(struct fdisk_context *cxt)
 {
     if (aixlabel->magic != AIX_LABEL_MAGIC &&
 	aixlabel->magic != AIX_LABEL_MAGIC_SWAPPED) {
@@ -61,6 +62,6 @@ check_aix_label( void )
     partitions= 1016;
     volumes = 15;
     aix_info();
-    aix_nolabel();		/* %% */
+    aix_nolabel(cxt);		/* %% */
     return 1;
 }
diff --git a/fdisk/fdiskaixlabel.h b/fdisk/fdiskaixlabel.h
index 324b9ae..bd4cb27 100644
--- a/fdisk/fdiskaixlabel.h
+++ b/fdisk/fdiskaixlabel.h
@@ -20,12 +20,8 @@ typedef struct {
 #define	AIX_INFO_MAGIC		0x00072959
 #define	AIX_INFO_MAGIC_SWAPPED	0x59290700
 
-/* fdisk.c */
-#define aixlabel ((aix_partition *)MBRbuffer)
-
 /* fdiskaixlabel.c */
 extern struct	systypes aix_sys_types[];
-extern void	aix_nolabel( void );
-extern int	check_aix_label( void );
+extern int	check_aix_label(struct fdisk_context *cxt);
 
 #endif /* FDISK_AIX_LABEL_H */
diff --git a/fdisk/fdiskdoslabel.c b/fdisk/fdiskdoslabel.c
index 299cff8..abf101b 100644
--- a/fdisk/fdiskdoslabel.c
+++ b/fdisk/fdiskdoslabel.c
@@ -108,10 +108,10 @@ void dos_init(struct fdisk_context *cxt)
 	for (i = 0; i < 4; i++) {
 		struct pte *pe = &ptes[i];
 
-		pe->part_table = pt_offset(MBRbuffer, i);
+		pe->part_table = pt_offset(cxt->mbr, i);
 		pe->ext_pointer = NULL;
 		pe->offset = 0;
-		pe->sectorbuffer = MBRbuffer;
+		pe->sectorbuffer = cxt->mbr;
 		pe->changed = 0;
 	}
 
@@ -214,9 +214,9 @@ static void read_extended(struct fdisk_context *cxt, int ext)
 	}
 }
 
-void dos_print_mbr_id(void)
+void dos_print_mbr_id(struct fdisk_context *cxt)
 {
-	printf(_("Disk identifier: 0x%08x\n"), dos_read_mbr_id(MBRbuffer));
+	printf(_("Disk identifier: 0x%08x\n"), dos_read_mbr_id(cxt->mbr));
 }
 
 void create_doslabel(struct fdisk_context *cxt)
@@ -229,26 +229,25 @@ void create_doslabel(struct fdisk_context *cxt)
 	fprintf(stderr, _("Building a new DOS disklabel with disk identifier 0x%08x.\n"), id);
 
 	dos_init(cxt);
-	zeroize_mbr_buffer();
-
+	fdisk_mbr_zeroize(cxt);
 	set_all_unchanged();
 	set_changed(0);
 
 	/* Generate an MBR ID for this disk */
-	dos_write_mbr_id(MBRbuffer, id);
+	dos_write_mbr_id(cxt->mbr, id);
 
 	/* Put MBR signature */
-	write_part_table_flag(MBRbuffer);
+	write_part_table_flag(cxt->mbr);
 }
 
-void dos_set_mbr_id(void)
+void dos_set_mbr_id(struct fdisk_context *cxt)
 {
 	unsigned long new_id;
 	char *ep;
 	char ps[64];
 
 	snprintf(ps, sizeof ps, _("New disk identifier (current 0x%08x): "),
-		 dos_read_mbr_id(MBRbuffer));
+		 dos_read_mbr_id(cxt->mbr));
 
 	if (read_chars(ps) == '\n')
 		return;
@@ -257,9 +256,9 @@ void dos_set_mbr_id(void)
 	if (*ep != '\n')
 		return;
 
-	dos_write_mbr_id(MBRbuffer, new_id);
+	dos_write_mbr_id(cxt->mbr, new_id);
 	MBRbuffer_changed = 1;
-	dos_print_mbr_id();
+	dos_print_mbr_id(cxt);
 }
 
 void dos_delete_partition(int i)
@@ -321,7 +320,7 @@ int check_dos_label(struct fdisk_context *cxt)
 {
 	int i;
 
-	if (!valid_part_table_flag(MBRbuffer))
+	if (!valid_part_table_flag(cxt->mbr))
 		return 0;
 
 	dos_init(cxt);
@@ -668,8 +667,8 @@ void dos_write_table(struct fdisk_context *cxt)
 				MBRbuffer_changed = 1;
 	}
 	if (MBRbuffer_changed) {
-		write_part_table_flag(MBRbuffer);
-		write_sector(cxt, 0, MBRbuffer);
+		write_part_table_flag(cxt->mbr);
+		write_sector(cxt, 0, cxt->mbr);
 	}
 	/* EBR (logical partitions) */
 	for (i = 4; i < partitions; i++) {
diff --git a/fdisk/fdiskdoslabel.h b/fdisk/fdiskdoslabel.h
index 8d62d52..f64a4ce 100644
--- a/fdisk/fdiskdoslabel.h
+++ b/fdisk/fdiskdoslabel.h
@@ -44,8 +44,8 @@ static inline sector_t get_partition_start(struct pte *pe)
 }
 
 extern void create_doslabel(struct fdisk_context *cxt);
-extern void dos_print_mbr_id(void);
-extern void dos_set_mbr_id(void);
+extern void dos_print_mbr_id(struct fdisk_context *cxt);
+extern void dos_set_mbr_id(struct fdisk_context *cxt);
 extern void dos_delete_partition(int i);
 extern int check_dos_label(struct fdisk_context *cxt);
 extern int is_dos_partition(int t);
diff --git a/fdisk/fdiskmaclabel.c b/fdisk/fdiskmaclabel.c
index e82347d..1c2e403 100644
--- a/fdisk/fdiskmaclabel.c
+++ b/fdisk/fdiskmaclabel.c
@@ -39,16 +39,16 @@ mac_info( void ) {
 }
 
 void
-mac_nolabel( void )
+mac_nolabel(struct fdisk_context *cxt)
 {
     maclabel->magic = 0;
     partitions = 4;
-    zeroize_mbr_buffer();
+    fdisk_mbr_zeroize(cxt);
     return;
 }
 
 int
-check_mac_label( void )
+check_mac_label(struct fdisk_context *cxt)
 {
 	/*
 	Conversion: only 16 bit should compared
@@ -77,7 +77,7 @@ IS_MAC:
     partitions= 1016; // =?
     volumes = 15;	// =?
     mac_info();
-    mac_nolabel();		/* %% */
+    mac_nolabel(cxt);		/* %% */
     return 1;
 }
 
diff --git a/fdisk/fdiskmaclabel.h b/fdisk/fdiskmaclabel.h
index e664a15..4873dcd 100644
--- a/fdisk/fdiskmaclabel.h
+++ b/fdisk/fdiskmaclabel.h
@@ -28,12 +28,12 @@ typedef struct {
 #define	MAC_LABEL_MAGIC_3_SWAPPED	0x0000d405
 
 /* fdisk.c */
-#define maclabel ((mac_partition *)MBRbuffer)
+#define maclabel ((mac_partition *)cxt->mbr)
 
 /* fdiskmaclabel.c */
 extern struct	systypes mac_sys_types[];
-extern void	mac_nolabel( void );
-extern int	check_mac_label( void );
+extern void	mac_nolabel(struct fdisk_context *cxt);
+extern int	check_mac_label(struct fdisk_context *cxt);
 
 #endif /* FDISK_MAC_LABEL_H */
 
diff --git a/fdisk/fdisksgilabel.c b/fdisk/fdisksgilabel.c
index 9c425b3..7db28d9 100644
--- a/fdisk/fdisksgilabel.c
+++ b/fdisk/fdisksgilabel.c
@@ -11,7 +11,11 @@
  *
  * 2003-03-20 Phillip Kesling <pkesling@sgi.com>
  *      Some fixes
+ *
+ * 2012-06-16 Davidlohr Bueso <dave@gnu.org>
+ *      Adapt to fdisk context and add heap sort for partitions
  */
+
 #include <stdio.h>              /* stderr */
 #include <stdlib.h>		/* exit */
 #include <string.h>             /* strstr */
@@ -103,12 +107,12 @@ struct systypes sgi_sys_types[] = {
 };
 
 static int
-sgi_get_nsect(void) {
+sgi_get_nsect(struct fdisk_context *cxt) {
 	return SSWAP16(sgilabel->devparam.nsect);
 }
 
 static int
-sgi_get_ntrks(void) {
+sgi_get_ntrks(struct fdisk_context *cxt) {
 	return SSWAP16(sgilabel->devparam.ntrks);
 }
 
@@ -130,7 +134,7 @@ sgi_get_pcylcount(void) {
 #endif
 
 void
-sgi_nolabel() {
+sgi_nolabel(struct fdisk_context *cxt) {
 	sgilabel->magic = 0;
 	partitions = 4;
 }
@@ -147,7 +151,7 @@ two_s_complement_32bit_sum(unsigned int *base, int size /* in bytes */) {
 }
 
 int
-check_sgi_label() {
+check_sgi_label(struct fdisk_context *cxt) {
 	if (sizeof(sgilabel) > 512) {
 		fprintf(stderr,
 			_("According to MIPS Computer Systems, Inc the "
@@ -209,21 +213,21 @@ sgi_list_table(struct fdisk_context *cxt, int xtra) {
 		 "Pt# %*s  Info     Start       End   Sectors  Id  System\n"),
 	       w + 1, _("Device"));
 	for (i = 0 ; i < partitions; i++) {
-		if (sgi_get_num_sectors(i) || debug) {
-			uint32_t start = sgi_get_start_sector(i);
-			uint32_t len = sgi_get_num_sectors(i);
+		if (sgi_get_num_sectors(cxt, i) || debug) {
+			uint32_t start = sgi_get_start_sector(cxt, i);
+			uint32_t len = sgi_get_num_sectors(cxt, i);
 			kpi++;		/* only count nonempty partitions */
 			printf(
 				"%2d: %s %4s %9ld %9ld %9ld  %2x  %s\n",
 /* fdisk part number */   i+1,
 /* device */              partname(cxt->dev_path, kpi, w+2),
-/* flags */               (sgi_get_swappartition() == i) ? "swap" :
-/* flags */               (sgi_get_bootpartition() == i) ? "boot" : "    ", 
+/* flags */               (sgi_get_swappartition(cxt) == i) ? "swap" :
+/* flags */               (sgi_get_bootpartition(cxt) == i) ? "boot" : "    ", 
 /* start */               (long) scround(start),
 /* end */                 (long) scround(start+len)-1,
 /* no odd flag on end */  (long) len, 
-/* type id */             sgi_get_sysid(i),
-/* type name */           (type = partition_type(sgi_get_sysid(i)))
+/* type id */             sgi_get_sysid(cxt, i),
+/* type name */           (type = partition_type(sgi_get_sysid(cxt, i)))
 				? type : _("Unknown"));
 		}
 	}
@@ -243,35 +247,35 @@ sgi_list_table(struct fdisk_context *cxt, int xtra) {
 }
 
 unsigned int
-sgi_get_start_sector(int i) {
+sgi_get_start_sector(struct fdisk_context *cxt, int i) {
 	return SSWAP32(sgilabel->partitions[i].start_sector);
 }
 
 unsigned int
-sgi_get_num_sectors(int i) {
+sgi_get_num_sectors(struct fdisk_context *cxt, int i) {
 	return SSWAP32(sgilabel->partitions[i].num_sectors);
 }
 
 int
-sgi_get_sysid(int i)
+sgi_get_sysid(struct fdisk_context *cxt, int i)
 {
 	return SSWAP32(sgilabel->partitions[i].id);
 }
 
 int
-sgi_get_bootpartition(void)
+sgi_get_bootpartition(struct fdisk_context *cxt)
 {
 	return (short) SSWAP16(sgilabel->boot_part);
 }
 
 int
-sgi_get_swappartition(void)
+sgi_get_swappartition(struct fdisk_context *cxt)
 {
 	return (short) SSWAP16(sgilabel->swap_part);
 }
 
 void
-sgi_set_bootpartition(int i)
+sgi_set_bootpartition(struct fdisk_context *cxt, int i)
 {
 	sgilabel->boot_part = SSWAP16(((short)i));
 }
@@ -282,12 +286,12 @@ sgi_get_lastblock(void) {
 }
 
 void
-sgi_set_swappartition(int i) {
+sgi_set_swappartition(struct fdisk_context *cxt, int i) {
 	sgilabel->swap_part = SSWAP16(((short)i));
 }
 
 static int
-sgi_check_bootfile(const char* aFile) {
+sgi_check_bootfile(struct fdisk_context *cxt, const char* aFile) {
 	if (strlen(aFile) < 3) /* "/a\n" is minimum */ {
 		printf(_("\nInvalid Bootfile!\n"
 			 "\tThe bootfile must be an absolute non-zero pathname,\n"
@@ -316,7 +320,7 @@ sgi_check_bootfile(const char* aFile) {
 }
 
 void
-sgi_set_bootfile(void)
+sgi_set_bootfile(struct fdisk_context *cxt)
 {
 	printf(_("\nThe current boot file is: %s\n"), sgilabel->boot_file);
 	if (read_chars(_("Please enter the name of the new boot file: ")) == '\n') {
@@ -324,7 +328,7 @@ sgi_set_bootfile(void)
 		return;
 	}
 
-	if (sgi_check_bootfile(line_ptr)) {
+	if (sgi_check_bootfile(cxt, line_ptr)) {
 		size_t i = 0;
 		while (i < 16) {
 			if ((line_ptr[i] != '\n')	/* in principle caught again by next line */
@@ -340,7 +344,7 @@ sgi_set_bootfile(void)
 }
 
 void
-create_sgiinfo(void) {
+create_sgiinfo(struct fdisk_context *cxt) {
 	/* I keep SGI's habit to write the sgilabel to the second block */
 	sgilabel->directory[0].vol_file_start = SSWAP32(2);
 	sgilabel->directory[0].vol_file_size = SSWAP32(sizeof(sgiinfo));
@@ -378,18 +382,18 @@ sgi_write_table(struct fdisk_context *cxt) {
 }
 
 static int
-compare_start(int *x, int *y) {
+compare_start(struct fdisk_context *cxt, const void *x, const void *y) {
 	/*
 	 * sort according to start sectors
 	 * and prefers largest partition:
 	 * entry zero is entire disk entry
 	 */
-	unsigned int i = *x;
-	unsigned int j = *y;
-	unsigned int a = sgi_get_start_sector(i);
-	unsigned int b = sgi_get_start_sector(j);
-	unsigned int c = sgi_get_num_sectors(i);
-	unsigned int d = sgi_get_num_sectors(j);
+	unsigned int i = *(int *) x;
+	unsigned int j = *(int *) y;
+	unsigned int a = sgi_get_start_sector(cxt, i);
+	unsigned int b = sgi_get_start_sector(cxt, j);
+	unsigned int c = sgi_get_num_sectors(cxt, i);
+	unsigned int d = sgi_get_num_sectors(cxt, j);
 
 	if (a == b)
 		return (d > c) ? 1 : (d == c) ? 0 : -1;
@@ -397,18 +401,67 @@ compare_start(int *x, int *y) {
 }
 
 static int
-sgi_gaps(void) {
+sgi_gaps(struct fdisk_context *cxt) {
 	/*
 	 * returned value is:
 	 *  = 0 : disk is properly filled to the rim
 	 *  < 0 : there is an overlap
 	 *  > 0 : there is still some vacant space
 	 */
-	return verify_sgi(0);
+	return verify_sgi(cxt, 0);
 }
 
+static void generic_swap(void *a, void *b, int size)
+{
+	char t;
+
+	do {
+		t = *(char *)a;
+		*(char *)a++ = *(char *)b;
+		*(char *)b++ = t;
+	} while (--size > 0);
+}
+
+
+/* heap sort, based on Matt Mackall's linux kernel version */
+static void sort(void *base, size_t num, size_t size, struct fdisk_context *cxt,
+		 int (*cmp_func)(struct fdisk_context *, const void *, const void *))
+{		 
+	/* pre-scale counters for performance */
+	int i = (num/2 - 1) * size;
+	size_t n = num * size, c, r;
+
+	/* heapify */
+	for ( ; i >= 0; i -= size) {
+		for (r = i; r * 2 + size < n; r  = c) {
+			c = r * 2 + size;
+			if (c < n - size &&
+			    cmp_func(cxt, base + c, base + c + size) < 0)
+				c += size;
+			if (cmp_func(cxt, base + r, base + c) >= 0)
+				break;
+			generic_swap(base + r, base + c, size);
+		}
+	}
+
+	/* sort */
+	for (i = n - size; i > 0; i -= size) {
+		generic_swap(base, base + i, size);
+		for (r = 0; r * 2 + size < (size_t) i; r = c) {
+			c = r * 2 + size;
+			if (c < i - size &&
+			    cmp_func(cxt, base + c, base + c + size) < 0)
+				c += size;
+			if (cmp_func(cxt, base + r, base + c) >= 0)
+				break;
+			generic_swap(base + r, base + c, size);
+		}
+	}
+}
+
+
 int
-verify_sgi(int verbose)
+verify_sgi(struct fdisk_context *cxt, int verbose)
 {
 	int Index[16];		/* list of valid partitions */
 	int sortcount = 0;	/* number of used partitions, i.e. non-zero lengths */
@@ -419,9 +472,9 @@ verify_sgi(int verbose)
 
 	clearfreelist();
 	for (i=0; i<16; i++) {
-		if (sgi_get_num_sectors(i) != 0) {
+		if (sgi_get_num_sectors(cxt, i) != 0) {
 			Index[sortcount++]=i;
-			if (sgi_get_sysid(i) == ENTIRE_DISK) {
+			if (sgi_get_sysid(cxt, i) == ENTIRE_DISK) {
 				if (entire++ == 1) {
 					if (verbose)
 						printf(_("More than one entire disk entry present.\n"));
@@ -434,71 +487,73 @@ verify_sgi(int verbose)
 			printf(_("No partitions defined\n"));
 		return (lastblock > 0) ? 1 : (lastblock == 0) ? 0 : -1;
 	}
-	qsort(Index, sortcount, sizeof(Index[0]), (void*)compare_start);
-	if (sgi_get_sysid(Index[0]) == ENTIRE_DISK) {
+
+	sort(Index, sortcount, sizeof(Index[0]), cxt, compare_start);
+
+	if (sgi_get_sysid(cxt, Index[0]) == ENTIRE_DISK) {
 		if ((Index[0] != 10) && verbose)
 			printf(_("IRIX likes when Partition 11 covers the entire disk.\n"));
-		if ((sgi_get_start_sector(Index[0]) != 0) && verbose)
+		if ((sgi_get_start_sector(cxt, Index[0]) != 0) && verbose)
 			printf(_("The entire disk partition should start "
 				 "at block 0,\n"
 				 "not at diskblock %d.\n"),
-			       sgi_get_start_sector(Index[0]));
+			       sgi_get_start_sector(cxt, Index[0]));
 		if (debug)	/* I do not understand how some disks fulfil it */
-			if ((sgi_get_num_sectors(Index[0]) != lastblock) && verbose)
+			if ((sgi_get_num_sectors(cxt, Index[0]) != lastblock) && verbose)
 				printf(_("The entire disk partition is only %d diskblock large,\n"
 					 "but the disk is %d diskblocks long.\n"),
-				       sgi_get_num_sectors(Index[0]), lastblock);
-		lastblock = sgi_get_num_sectors(Index[0]);
+				       sgi_get_num_sectors(cxt, Index[0]), lastblock);
+		lastblock = sgi_get_num_sectors(cxt, Index[0]);
 	} else {
 		if (verbose)
 			printf(_("Partition 11 should cover the entire disk.\n"));
 		if (debug>2)
 			printf("sysid=%d\tpartition=%d\n",
-			       sgi_get_sysid(Index[0]), Index[0]+1);
+			       sgi_get_sysid(cxt, Index[0]), Index[0]+1);
 	}
 	for (i=1, start=0; i<sortcount; i++) {
-		int cylsize = sgi_get_nsect() * sgi_get_ntrks();
-		if ((sgi_get_start_sector(Index[i]) % cylsize) != 0) {
+		int cylsize = sgi_get_nsect(cxt) * sgi_get_ntrks(cxt);
+		if ((sgi_get_start_sector(cxt, Index[i]) % cylsize) != 0) {
 			if (debug)	/* I do not understand how some disks fulfil it */
 				if (verbose)
 					printf(_("Partition %d does not start on cylinder boundary.\n"),
 					       Index[i]+1);
 		}
-		if (sgi_get_num_sectors(Index[i]) % cylsize != 0) {
+		if (sgi_get_num_sectors(cxt, Index[i]) % cylsize != 0) {
 			if (debug)	/* I do not understand how some disks fulfil it */
 				if (verbose)
 					printf(_("Partition %d does not end on cylinder boundary.\n"),
 					       Index[i]+1);
 		}
 		/* We cannot handle several "entire disk" entries. */
-		if (sgi_get_sysid(Index[i]) == ENTIRE_DISK) continue;
-		if (start > sgi_get_start_sector(Index[i])) {
+		if (sgi_get_sysid(cxt, Index[i]) == ENTIRE_DISK) continue;
+		if (start > sgi_get_start_sector(cxt, Index[i])) {
 			if (verbose)
 				printf(_("The Partition %d and %d overlap by %d sectors.\n"),
 				       Index[i-1]+1, Index[i]+1,
-				       start - sgi_get_start_sector(Index[i]));
+				       start - sgi_get_start_sector(cxt, Index[i]));
 			if (gap >  0) gap = -gap;
 			if (gap == 0) gap = -1;
 		}
-		if (start < sgi_get_start_sector(Index[i])) {
+		if (start < sgi_get_start_sector(cxt, Index[i])) {
 			if (verbose)
 				printf(_("Unused gap of %8u sectors - sectors %8u-%u\n"),
-				       sgi_get_start_sector(Index[i]) - start,
-				       start, sgi_get_start_sector(Index[i])-1);
-			gap += sgi_get_start_sector(Index[i]) - start;
-			add2freelist(start, sgi_get_start_sector(Index[i]));
+				       sgi_get_start_sector(cxt, Index[i]) - start,
+				       start, sgi_get_start_sector(cxt, Index[i])-1);
+			gap += sgi_get_start_sector(cxt, Index[i]) - start;
+			add2freelist(start, sgi_get_start_sector(cxt, Index[i]));
 		}
-		start = sgi_get_start_sector(Index[i])
-			+ sgi_get_num_sectors(Index[i]);
+		start = sgi_get_start_sector(cxt, Index[i])
+			+ sgi_get_num_sectors(cxt, Index[i]);
 		/* Align free space on cylinder boundary */
 		if (start % cylsize)
 			start += cylsize - (start % cylsize);
 		if (debug > 1) {
 			if (verbose)
 				printf("%2d:%12d\t%12d\t%12d\n", Index[i],
-				       sgi_get_start_sector(Index[i]),
-				       sgi_get_num_sectors(Index[i]),
-				       sgi_get_sysid(Index[i]));
+				       sgi_get_start_sector(cxt, Index[i]),
+				       sgi_get_num_sectors(cxt, Index[i]),
+				       sgi_get_sysid(cxt, Index[i]));
 		}
 	}
 	if (start < lastblock) {
@@ -513,31 +568,31 @@ verify_sgi(int verbose)
 	 * Go for details now
 	 */
 	if (verbose) {
-		if (sgi_get_bootpartition() < 0 || !sgi_get_num_sectors(sgi_get_bootpartition())) {
+		if (sgi_get_bootpartition(cxt) < 0 || !sgi_get_num_sectors(cxt, sgi_get_bootpartition(cxt))) {
 			printf(_("\nThe boot partition does not exist.\n"));
 		}
-		if (sgi_get_swappartition() < 0 || !sgi_get_num_sectors(sgi_get_swappartition())) {
+		if (sgi_get_swappartition(cxt) < 0 || !sgi_get_num_sectors(cxt, sgi_get_swappartition(cxt))) {
 			printf(_("\nThe swap partition does not exist.\n"));
 		} else {
-			if ((sgi_get_sysid(sgi_get_swappartition()) != SGI_SWAP)
-			    &&  (sgi_get_sysid(sgi_get_swappartition()) != LINUX_SWAP))
+			if ((sgi_get_sysid(cxt, sgi_get_swappartition(cxt)) != SGI_SWAP)
+			    &&  (sgi_get_sysid(cxt, sgi_get_swappartition(cxt)) != LINUX_SWAP))
 				printf(_("\nThe swap partition has no swap type.\n"));
 		}
-		if (sgi_check_bootfile("/unix"))
+		if (sgi_check_bootfile(cxt, "/unix"))
 			printf(_("\tYou have chosen an unusual boot file name.\n"));
 	}
 	return (gap > 0) ? 1 : (gap == 0) ? 0 : -1;
 }
 
 int
-sgi_change_sysid(int i, int sys)
+sgi_change_sysid(struct fdisk_context *cxt, int i, int sys)
 {
-	if (sgi_get_num_sectors(i) == 0) /* caught already before, ... */ {
+	if (sgi_get_num_sectors(cxt, i) == 0) /* caught already before, ... */ {
 		printf(_("Sorry, only for non-empty partitions you can change the tag.\n"));
 		return 0;
 	}
 	if (((sys != ENTIRE_DISK) && (sys != SGI_VOLHDR))
-	    && (sgi_get_start_sector(i)<1)) {
+	    && (sgi_get_start_sector(cxt, i)<1)) {
 		read_chars(
 			_("It is highly recommended that the partition at offset 0\n"
 			  "is of type \"SGI volhdr\", the IRIX system will rely on it to\n"
@@ -553,11 +608,11 @@ sgi_change_sysid(int i, int sys)
 
 /* returns partition index of first entry marked as entire disk */
 static int
-sgi_entire(void) {
+sgi_entire(struct fdisk_context *cxt) {
 	int i;
 
 	for (i=0; i<16; i++)
-		if (sgi_get_sysid(i) == SGI_VOLUME)
+		if (sgi_get_sysid(cxt, i) == SGI_VOLUME)
 			return i;
 	return -1;
 }
@@ -569,7 +624,7 @@ sgi_set_partition(struct fdisk_context *cxt,
 	sgilabel->partitions[i].num_sectors = SSWAP32(length);
 	sgilabel->partitions[i].start_sector = SSWAP32(start);
 	set_changed(i);
-	if (sgi_gaps() < 0)	/* rebuild freelist */
+	if (sgi_gaps(cxt) < 0)	/* rebuild freelist */
 		printf(_("Partition overlap on the disk.\n"));
 	if (length)
 		print_partition_size(cxt, i + 1, start, start + length, sys);
@@ -580,7 +635,7 @@ sgi_set_entire(struct fdisk_context *cxt) {
 	int n;
 
 	for (n=10; n<partitions; n++) {
-		if (!sgi_get_num_sectors(n)) {
+		if (!sgi_get_num_sectors(cxt, n)) {
 			sgi_set_partition(cxt, n, 0, sgi_get_lastblock(), SGI_VOLUME);
 			break;
 		}
@@ -594,7 +649,7 @@ sgi_set_volhdr(struct fdisk_context *cxt)
 	int n;
 
 	for (n=8; n<partitions; n++) {
-		if (!sgi_get_num_sectors(n)) {
+		if (!sgi_get_num_sectors(cxt, n)) {
 			/*
 			 * Choose same default volume header size
 			 * as IRIX fx uses.
@@ -623,22 +678,22 @@ sgi_add_partition(struct fdisk_context *cxt, int n, int sys)
 	} else if (n == 8) {
 		sys = 0;
 	}
-	if (sgi_get_num_sectors(n)) {
+	if (sgi_get_num_sectors(cxt, n)) {
 		printf(_("Partition %d is already defined.  Delete "
 			 "it before re-adding it.\n"), n + 1);
 		return;
 	}
-	if ((sgi_entire() == -1)
+	if ((sgi_entire(cxt) == -1)
 	    &&  (sys != SGI_VOLUME)) {
 		printf(_("Attempting to generate entire disk entry automatically.\n"));
 		sgi_set_entire(cxt);
 		sgi_set_volhdr(cxt);
 	}
-	if ((sgi_gaps() == 0) &&  (sys != SGI_VOLUME)) {
+	if ((sgi_gaps(cxt) == 0) &&  (sys != SGI_VOLUME)) {
 		printf(_("The entire disk is already covered with partitions.\n"));
 		return;
 	}
-	if (sgi_gaps() < 0) {
+	if (sgi_gaps(cxt) < 0) {
 		printf(_("You got a partition overlap on the disk. Fix it first!\n"));
 		return;
 	}
@@ -730,7 +785,7 @@ create_sgilabel(struct fdisk_context *cxt)
 #endif
 	for (i = 0; i < 4; i++) {
 		old[i].sysid = 0;
-		if (valid_part_table_flag(MBRbuffer)) {
+		if (valid_part_table_flag(cxt->mbr)) {
 			if (get_part_table(i)->sys_ind) {
 				old[i].sysid = get_part_table(i)->sys_ind;
 				old[i].start = get_start_sect(get_part_table(i));
@@ -748,7 +803,7 @@ create_sgilabel(struct fdisk_context *cxt)
 			break;
 		}
 
-	zeroize_mbr_buffer();
+	fdisk_mbr_zeroize(cxt);
 	sgilabel->magic = SSWAP32(SGI_LABEL_MAGIC);
 	sgilabel->boot_part = SSWAP16(0);
 	sgilabel->swap_part = SSWAP16(1);
diff --git a/fdisk/fdisksgilabel.h b/fdisk/fdisksgilabel.h
index 7611d32..dff32b1 100644
--- a/fdisk/fdisksgilabel.h
+++ b/fdisk/fdisksgilabel.h
@@ -106,33 +106,33 @@ typedef struct {
 #define SSWAP32(x) (other_endian ? swab32(x) : (uint32_t)(x))
 
 /* fdisk.c */
-#define sgilabel ((sgi_partition *)MBRbuffer)
+#define sgilabel ((sgi_partition *)cxt->mbr)
 #define sgiparam (sgilabel->devparam)
 
 /* fdisksgilabel.c */
 extern struct	systypes sgi_sys_types[];
-extern void	sgi_nolabel( void );
-extern int	check_sgi_label( void );
+extern void	sgi_nolabel(struct fdisk_context *cxt);
+extern int	check_sgi_label(struct fdisk_context *cxt);
 extern void	sgi_list_table( struct fdisk_context *cxt, int xtra );
-extern int  sgi_change_sysid( int i, int sys );
-extern unsigned int	sgi_get_start_sector( int i );
-extern unsigned int	sgi_get_num_sectors( int i );
-extern int	sgi_get_sysid( int i );
+extern int  sgi_change_sysid(struct fdisk_context *cxt, int i, int sys);
+extern unsigned int	sgi_get_start_sector(struct fdisk_context *cxt, int i );
+extern unsigned int	sgi_get_num_sectors(struct fdisk_context *cxt, int i );
+extern int	sgi_get_sysid(struct fdisk_context *cxt, int i );
 extern void	sgi_delete_partition( struct fdisk_context *cxt, int i );
 extern void	sgi_add_partition( struct fdisk_context *cxt, int n, int sys );
 extern void	create_sgilabel( struct fdisk_context *cxt );
-extern void	create_sgiinfo( void );
-extern int	verify_sgi( int verbose );
+extern void	create_sgiinfo(struct fdisk_context *cxt);
+extern int	verify_sgi(struct fdisk_context *cxt, int verbose );
 extern void	sgi_write_table( struct fdisk_context *cxt );
 extern void	sgi_set_ilfact( void );
 extern void	sgi_set_rspeed( void );
 extern void	sgi_set_pcylcount( void );
 extern void	sgi_set_xcyl( void );
 extern void	sgi_set_ncyl( void );
-extern void	sgi_set_bootpartition( int i );
-extern void	sgi_set_swappartition( int i );
-extern int	sgi_get_bootpartition( void );
-extern int	sgi_get_swappartition( void );
-extern void	sgi_set_bootfile(void);
+extern void	sgi_set_bootpartition(struct fdisk_context *cxt, int i );
+extern void	sgi_set_swappartition(struct fdisk_context *cxt, int i );
+extern int	sgi_get_bootpartition(struct fdisk_context *cxt);
+extern int	sgi_get_swappartition(struct fdisk_context *cxt);
+extern void	sgi_set_bootfile(struct fdisk_context *cxt);
 
 #endif /* FDISK_SGI_LABEL_H */
diff --git a/fdisk/fdisksunlabel.c b/fdisk/fdisksunlabel.c
index ae24e16..90f52f4 100644
--- a/fdisk/fdisksunlabel.c
+++ b/fdisk/fdisksunlabel.c
@@ -78,13 +78,13 @@ static void init(void)
 	partitions = SUN_NUM_PARTITIONS;
 }
 
-void sun_nolabel(void)
+void sun_nolabel(struct fdisk_context *cxt)
 {
 	sunlabel->magic = 0;
 	partitions = 4;
 }
 
-int check_sun_label(void)
+int check_sun_label(struct fdisk_context *cxt)
 {
 	unsigned short *ush;
 	int csum;
@@ -166,7 +166,7 @@ void create_sunlabel(struct fdisk_context *cxt)
 #endif
 
 	init();
-	zeroize_mbr_buffer();
+	fdisk_mbr_zeroize(cxt);
 
 	sunlabel->magic = SSWAP16(SUN_LABEL_MAGIC);
 	sunlabel->sanity = SSWAP32(SUN_LABEL_SANE);
@@ -242,7 +242,7 @@ void create_sunlabel(struct fdisk_context *cxt)
 	set_changed(0);
 }
 
-void toggle_sunflags(int i, uint16_t mask)
+void toggle_sunflags(struct fdisk_context *cxt, int i, uint16_t mask)
 {
 	struct sun_tag_flag *p = &sunlabel->part_tags[i];
 
@@ -251,7 +251,8 @@ void toggle_sunflags(int i, uint16_t mask)
 	set_changed(i);
 }
 
-static void fetch_sun(uint32_t *starts, uint32_t *lens, uint32_t *start, uint32_t *stop)
+static void fetch_sun(struct fdisk_context *cxt, uint32_t *starts, 
+		      uint32_t *lens, uint32_t *start, uint32_t *stop)
 {
 	int i, continuous = 1;
 
@@ -298,7 +299,7 @@ static int verify_sun_cmp(int *a, int *b)
     return -1;
 }
 
-void verify_sun(void)
+void verify_sun(struct fdisk_context *cxt)
 {
     uint32_t starts[SUN_NUM_PARTITIONS], lens[SUN_NUM_PARTITIONS], start, stop;
     uint32_t i,j,k,starto,endo;
@@ -306,7 +307,7 @@ void verify_sun(void)
 
     verify_sun_starts = starts;
 
-    fetch_sun(starts, lens, &start, &stop);
+    fetch_sun(cxt, starts, lens, &start, &stop);
 
     for (k = 0; k < 7; k++) {
 	for (i = 0; i < SUN_NUM_PARTITIONS; i++) {
@@ -347,6 +348,7 @@ void verify_sun(void)
     }
     qsort(array,ARRAY_SIZE(array),sizeof(array[0]),
 	  (int (*)(const void *,const void *)) verify_sun_cmp);
+
     if (array[0] == -1) {
     	printf(_("No partitions defined\n"));
     	return;
@@ -382,7 +384,7 @@ void add_sun_partition(struct fdisk_context *cxt, int n, int sys)
 		return;
 	}
 	
-	fetch_sun(starts, lens, &start, &stop);
+	fetch_sun(cxt, starts, lens, &start, &stop);
 	if (stop <= start) {
 		if (n == 2)
 			whole_disk = 1;
@@ -484,7 +486,7 @@ and is of type `Whole disk'\n"));
 	set_sun_partition(cxt, n, first, last, sys);
 }
 
-void sun_delete_partition(int i)
+void sun_delete_partition(struct fdisk_context *cxt, int i)
 {
 	struct sun_partition *part = &sunlabel->partitions[i];
 	struct sun_tag_flag *tag = &sunlabel->part_tags[i];
@@ -503,7 +505,7 @@ void sun_delete_partition(int i)
 	part->num_sectors = 0;
 }
 
-int sun_change_sysid(int i, uint16_t sys)
+int sun_change_sysid(struct fdisk_context *cxt, int i, uint16_t sys)
 {
 	struct sun_partition *part = &sunlabel->partitions[i];
 	struct sun_tag_flag *tag = &sunlabel->part_tags[i];
@@ -594,7 +596,7 @@ void sun_set_alt_cyl(struct fdisk_context *cxt)
 				 _("Number of alternate cylinders")));
 }
 
-void sun_set_ncyl(int cyl)
+void sun_set_ncyl(struct fdisk_context *cxt, int cyl)
 {
 	sunlabel->ncyl = SSWAP16(cyl);
 }
@@ -641,7 +643,7 @@ void sun_write_table(struct fdisk_context *cxt)
 		fatal(cxt, unable_to_write);
 }
 
-int sun_get_sysid(int i)
+int sun_get_sysid(struct fdisk_context *cxt, int i)
 {
 	return SSWAP16(sunlabel->part_tags[i].tag);
 }
diff --git a/fdisk/fdisksunlabel.h b/fdisk/fdisksunlabel.h
index 8cb13ec..d3cd430 100644
--- a/fdisk/fdisksunlabel.h
+++ b/fdisk/fdisksunlabel.h
@@ -73,26 +73,26 @@ struct sun_disk_label {
 
 #define SUN_LABEL_MAGIC		0xDABE
 #define SUN_LABEL_MAGIC_SWAPPED	0xBEDA
-#define sunlabel ((struct sun_disk_label *)MBRbuffer)
+#define sunlabel ((struct sun_disk_label *)cxt->mbr)
 
 /* fdisksunlabel.c */
 extern struct systypes sun_sys_types[];
-extern int check_sun_label(void);
-extern void sun_nolabel(void);
+extern int check_sun_label(struct fdisk_context *cxt);
+extern void sun_nolabel(struct fdisk_context *cxt);
 extern void create_sunlabel(struct fdisk_context *cxt);
-extern void sun_delete_partition(int i);
-extern int sun_change_sysid(int i, uint16_t sys);
+extern void sun_delete_partition(struct fdisk_context *cxt, int i);
+extern int sun_change_sysid(struct fdisk_context *cxt, int i, uint16_t sys);
 extern void sun_list_table(struct fdisk_context *cxt, int xtra);
-extern void verify_sun(void);
+extern void verify_sun(struct fdisk_context *cxt);
 extern void add_sun_partition(struct fdisk_context *cxt, int n, int sys);
 extern void sun_write_table(struct fdisk_context *cxt);
 extern void sun_set_alt_cyl(struct fdisk_context *cxt);
-extern void sun_set_ncyl(int cyl);
+extern void sun_set_ncyl(struct fdisk_context *cxt, int cyl);
 extern void sun_set_xcyl(struct fdisk_context *cxt);
 extern void sun_set_ilfact(struct fdisk_context *cxt);
 extern void sun_set_rspeed(struct fdisk_context *cxt);
 extern void sun_set_pcylcount(struct fdisk_context *cxt);
-extern void toggle_sunflags(int i, uint16_t mask);
-extern int sun_get_sysid(int i);
+extern void toggle_sunflags(struct fdisk_context *cxt, int i, uint16_t mask);
+extern int sun_get_sysid(struct fdisk_context *cxt, int i);
 
 #endif /* FDISK_SUN_LABEL_H */
diff --git a/fdisk/utils.c b/fdisk/utils.c
index d105d8e..616fcc0 100644
--- a/fdisk/utils.c
+++ b/fdisk/utils.c
@@ -31,6 +31,21 @@
 
 int fdisk_debug_mask;
 
+static int __init_mbr_buffer(struct fdisk_context *cxt)
+{
+	cxt->mbr = calloc(1, MAX_SECTOR_SIZE);
+	if (!cxt->mbr)
+		goto fail;
+
+	/* read MBR */
+	if (512 != read(cxt->dev_fd, cxt->mbr, 512))
+		goto fail;
+
+	return 0;
+fail:
+	return -1;
+}
+
 static unsigned long __get_sector_size(int fd)
 {
 	int sect_sz;
@@ -94,6 +109,18 @@ static int __discover_topology(struct fdisk_context *cxt)
 }
 
 /**
+ * fdisk_mbr_zeroize:
+ * @cxt: fdisk context
+ *
+ * Zero's MBR buffer
+ */
+void fdisk_mbr_zeroize(struct fdisk_context *cxt)
+{
+	if (cxt->mbr)
+		bzero(cxt->mbr, MAX_SECTOR_SIZE);
+}
+
+/**
  * fdisk_dev_sectsz_is_default:
  * @cxt: fdisk context
  *
@@ -181,6 +208,9 @@ struct fdisk_context *fdisk_new_context_from_filename(const char *fname, int rea
 	if (!cxt->dev_path)
 		goto fail;
 
+	if (__init_mbr_buffer(cxt) < 0)
+		goto fail;
+
 	__discover_topology(cxt);
 	__discover_geometry(cxt);
 
@@ -210,5 +240,6 @@ void fdisk_free_context(struct fdisk_context *cxt)
 	DBG(CONTEXT, dbgprint("freeing context for %s", cxt->dev_path));
 	close(cxt->dev_fd);
 	free(cxt->dev_path);
+	free(cxt->mbr);
 	free(cxt);
 }
-- 
1.7.4.1




