Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbhh.dreamhost.com ([208.97.132.177]:52953 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752144Ab2GVRFq (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 22 Jul 2012 13:05:46 -0400
Subject: [PATCH 08/10] fdisk: API: add create disklabel to label operations
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 22 Jul 2012 19:05:43 +0200
Message-ID: <1342976743.2863.18.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

With the creation of fdisk_label_create(), it can centralize calls to
fdisk_label_change() as this is one of the scenarios where the function is called.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/fdisk.c         |   12 +++------
 fdisks/fdisk.h         |    3 ++
 fdisks/fdiskaixlabel.c |    1 +
 fdisks/fdiskbsdlabel.c |   64 ++++++++++++++++++++++++------------------------
 fdisks/fdiskdoslabel.c |    6 +++-
 fdisks/fdiskdoslabel.h |    1 -
 fdisks/fdiskmaclabel.c |    1 +
 fdisks/fdisksgilabel.c |    5 +--
 fdisks/fdisksgilabel.h |    1 -
 fdisks/fdisksunlabel.c |    4 +-
 fdisks/fdisksunlabel.h |    1 -
 fdisks/utils.c         |   29 +++++++++++++++++++++
 12 files changed, 78 insertions(+), 50 deletions(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index ab2cf5b..034df15 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -505,11 +505,7 @@ static int get_boot(struct fdisk_context *cxt, int try_only) {
 
 		fprintf(stderr,
 			_("Device does not contain a recognized partition table\n"));
-#ifdef __sparc__
-		create_sunlabel(cxt);
-#else
-		create_doslabel(cxt);
-#endif
+		fdisk_label_create(cxt, NULL);
 	}
 	return 0;
 }
@@ -1551,7 +1547,7 @@ expert_command_prompt(struct fdisk_context *cxt)
 				fix_partition_table_order();
 			break;
 		case 'g':
-			create_sgilabel(cxt);
+			fdisk_label_create(cxt, "sgi");
 			break;
 		case 'h':
 			user_heads = cxt->geom.heads = read_int(cxt, 1, cxt->geom.heads, 256, 0,
@@ -1779,7 +1775,7 @@ static void command_prompt(struct fdisk_context *cxt)
 			new_partition(cxt);
 			break;
 		case 'o':
-			create_doslabel(cxt);
+			fdisk_label_create(cxt, "dos");
 			break;
 		case 'p':
 			list_table(cxt, 0);
@@ -1787,7 +1783,7 @@ static void command_prompt(struct fdisk_context *cxt)
 		case 'q':
 			handle_quit(cxt);
 		case 's':
-			create_sunlabel(cxt);
+			fdisk_label_create(cxt, "sun");
 			break;
 		case 't':
 			change_sysid(cxt);
diff --git a/fdisks/fdisk.h b/fdisks/fdisk.h
index d9a63e6..1258602 100644
--- a/fdisks/fdisk.h
+++ b/fdisks/fdisk.h
@@ -149,6 +149,8 @@ struct fdisk_label {
 	int (*write)(struct fdisk_context *cxt);
 	/* verify the partition table */
 	int (*verify)(struct fdisk_context *cxt);
+	/* create new disk label */
+	int (*create_label)(struct fdisk_context *cxt);
 	/* new partition */
 	void (*part_new)(struct fdisk_context *cxt, int partnum, int parttype);
 	/* delete partition */
@@ -178,6 +180,7 @@ extern int fdisk_label_partition_new(struct fdisk_context *cxt, int partnum, int
 extern int fdisk_label_partition_delete(struct fdisk_context *cxt, int partnum);
 extern int fdisk_label_write_table(struct fdisk_context *cxt);
 extern int fdisk_label_verify_table(struct fdisk_context *cxt);
+extern int fdisk_label_create(struct fdisk_context *cxt, const char *name);
 
 /* prototypes for fdisk.c */
 extern void check_consistency(struct fdisk_context *cxt, struct partition *p, int partition);
diff --git a/fdisks/fdiskaixlabel.c b/fdisks/fdiskaixlabel.c
index fa8a593..a4a6c05 100644
--- a/fdisks/fdiskaixlabel.c
+++ b/fdisks/fdiskaixlabel.c
@@ -80,6 +80,7 @@ const struct fdisk_label aix_label =
 	.probe = aix_probe_label,
 	.write = NULL,
 	.verify = NULL,
+	.create_label = NULL,
 	.part_new = aix_new_partition,
 	.part_delete = NULL,
 };
diff --git a/fdisks/fdiskbsdlabel.c b/fdisks/fdiskbsdlabel.c
index 34d8c00..0492cc1 100644
--- a/fdisks/fdiskbsdlabel.c
+++ b/fdisks/fdiskbsdlabel.c
@@ -62,7 +62,6 @@
 #include "fdiskbsdlabel.h"
 
 static void xbsd_delete_part (struct fdisk_context *cxt, int partnum);
-static int xbsd_create_disklabel (struct fdisk_context *cxt);
 static void xbsd_edit_disklabel (void);
 static void xbsd_write_bootstrap (struct fdisk_context *cxt);
 static void xbsd_change_fstype (void);
@@ -190,6 +189,37 @@ static void xbsd_new_part (struct fdisk_context *cxt, int partnum, int parttype)
 	xbsd_dlabel.d_partitions[i].p_fstype = BSD_FS_UNUSED;
 }
 
+static int xbsd_create_disklabel (struct fdisk_context *cxt)
+{
+	char c;
+
+#if defined (__alpha__)
+	fprintf (stderr, _("%s contains no disklabel.\n"), cxt->dev_path);
+#else
+	fprintf (stderr, _("%s contains no disklabel.\n"),
+		 partname(cxt->dev_path, xbsd_part_index+1, 0));
+#endif
+
+	while (1) {
+		c = read_char (_("Do you want to create a disklabel? (y/n) "));
+		if (tolower(c) == 'y') {
+			if (xbsd_initlabel (cxt,
+#if defined (__alpha__) || defined (__powerpc__) || defined (__hppa__) || \
+    defined (__s390__) || defined (__s390x__)
+				NULL, &xbsd_dlabel, 0
+#else
+				xbsd_part, &xbsd_dlabel, xbsd_part_index
+#endif
+				) == 1) {
+				xbsd_print_disklabel (cxt, 1);
+				return 1;
+			} else
+				return 0;
+		} else if (c == 'n')
+			return 0;
+	}
+}
+
 void
 bsd_command_prompt (struct fdisk_context *cxt)
 {
@@ -389,37 +419,6 @@ xbsd_print_disklabel (struct fdisk_context *cxt, int show_all) {
 }
 
 static int
-xbsd_create_disklabel (struct fdisk_context *cxt) {
-	char c;
-
-#if defined (__alpha__)
-	fprintf (stderr, _("%s contains no disklabel.\n"), cxt->dev_path);
-#else
-	fprintf (stderr, _("%s contains no disklabel.\n"),
-		 partname(cxt->dev_path, xbsd_part_index+1, 0));
-#endif
-
-	while (1) {
-		c = read_char (_("Do you want to create a disklabel? (y/n) "));
-		if (tolower(c) == 'y') {
-			if (xbsd_initlabel (cxt,
-#if defined (__alpha__) || defined (__powerpc__) || defined (__hppa__) || \
-    defined (__s390__) || defined (__s390x__)
-				NULL, &xbsd_dlabel, 0
-#else
-				xbsd_part, &xbsd_dlabel, xbsd_part_index
-#endif
-				) == 1) {
-				xbsd_print_disklabel (cxt, 1);
-				return 1;
-			} else
-				return 0;
-		} else if (c == 'n')
-			return 0;
-	}
-}
-
-static int
 edit_int (int def, char *mesg)
 {
   do {
@@ -847,6 +846,7 @@ const struct fdisk_label bsd_label =
 	.probe = osf_probe_label,
 	.write = xbsd_write_disklabel,
 	.verify = NULL,
+	.create_label = xbsd_create_disklabel,
 	.part_new = xbsd_new_part,
 	.part_delete = xbsd_delete_part,
 };
diff --git a/fdisks/fdiskdoslabel.c b/fdisks/fdiskdoslabel.c
index 13a6850..67f2f26 100644
--- a/fdisks/fdiskdoslabel.c
+++ b/fdisks/fdiskdoslabel.c
@@ -274,7 +274,7 @@ void dos_print_mbr_id(struct fdisk_context *cxt)
 	printf(_("Disk identifier: 0x%08x\n"), dos_read_mbr_id(cxt->mbr));
 }
 
-void create_doslabel(struct fdisk_context *cxt)
+static int dos_create_label(struct fdisk_context *cxt)
 {
 	unsigned int id;
 
@@ -285,7 +285,6 @@ void create_doslabel(struct fdisk_context *cxt)
 
 	dos_init(cxt);
 	fdisk_mbr_zeroize(cxt);
-	fdisk_label_change(cxt, "dos");
 	set_all_unchanged();
 	set_changed(0);
 
@@ -294,6 +293,8 @@ void create_doslabel(struct fdisk_context *cxt)
 
 	/* Put MBR signature */
 	write_part_table_flag(cxt->mbr);
+
+	return 0;
 }
 
 void dos_set_mbr_id(struct fdisk_context *cxt)
@@ -770,6 +771,7 @@ const struct fdisk_label dos_label =
 	.probe = dos_probe_label,
 	.write = dos_write_table,
 	.verify = dos_verify,
+	.create_label = dos_create_label,
 	.part_new = dos_new_partition,
 	.part_delete = dos_delete_partition,
 };
diff --git a/fdisks/fdiskdoslabel.h b/fdisks/fdiskdoslabel.h
index 964f91b..f008cc2 100644
--- a/fdisks/fdiskdoslabel.h
+++ b/fdisks/fdiskdoslabel.h
@@ -43,7 +43,6 @@ static inline sector_t get_partition_start(struct pte *pe)
 	return pe->offset + get_start_sect(pe->part_table);
 }
 
-extern void create_doslabel(struct fdisk_context *cxt);
 extern void dos_print_mbr_id(struct fdisk_context *cxt);
 extern void dos_set_mbr_id(struct fdisk_context *cxt);
 extern int is_dos_partition(int t);
diff --git a/fdisks/fdiskmaclabel.c b/fdisks/fdiskmaclabel.c
index 12b284f..df1d117 100644
--- a/fdisks/fdiskmaclabel.c
+++ b/fdisks/fdiskmaclabel.c
@@ -95,6 +95,7 @@ const struct fdisk_label mac_label =
 	.probe = mac_probe_label,
 	.write = NULL,
 	.verify = NULL,
+	.create_label = NULL,
 	.part_new = mac_new_partition,
 	.part_delete = NULL,
 };
diff --git a/fdisks/fdisksgilabel.c b/fdisks/fdisksgilabel.c
index 176dae4..8b837b8 100644
--- a/fdisks/fdisksgilabel.c
+++ b/fdisks/fdisksgilabel.c
@@ -711,8 +711,7 @@ static void sgi_add_partition(struct fdisk_context *cxt, int n, int sys)
 	sgi_set_partition(cxt, n, first, last-first, sys);
 }
 
-void
-create_sgilabel(struct fdisk_context *cxt)
+static int sgi_create_label(struct fdisk_context *cxt)
 {
 	struct hd_geometry geometry;
 	struct {
@@ -778,7 +777,6 @@ create_sgilabel(struct fdisk_context *cxt)
 		}
 
 	fdisk_mbr_zeroize(cxt);
-	fdisk_label_change(cxt, "sgi");
 
 	sgilabel->magic = SSWAP32(SGI_LABEL_MAGIC);
 	sgilabel->boot_part = SSWAP16(0);
@@ -883,6 +881,7 @@ const struct fdisk_label sgi_label =
 	.probe = sgi_probe_label,
 	.write = sgi_write_table,
 	.verify = sgi_verify,
+	.create_label = sgi_create_label,
 	.part_new = sgi_add_partition,
 	.part_delete = sgi_delete_partition,
 };
diff --git a/fdisks/fdisksgilabel.h b/fdisks/fdisksgilabel.h
index 0ae73eb..5a958fa 100644
--- a/fdisks/fdisksgilabel.h
+++ b/fdisks/fdisksgilabel.h
@@ -116,7 +116,6 @@ extern int  sgi_change_sysid(struct fdisk_context *cxt, int i, int sys);
 extern unsigned int	sgi_get_start_sector(struct fdisk_context *cxt, int i );
 extern unsigned int	sgi_get_num_sectors(struct fdisk_context *cxt, int i );
 extern int	sgi_get_sysid(struct fdisk_context *cxt, int i );
-extern void	create_sgilabel( struct fdisk_context *cxt );
 extern void	create_sgiinfo(struct fdisk_context *cxt);
 extern void	sgi_set_ilfact( void );
 extern void	sgi_set_rspeed( void );
diff --git a/fdisks/fdisksunlabel.c b/fdisks/fdisksunlabel.c
index 007eef2..68a8955 100644
--- a/fdisks/fdisksunlabel.c
+++ b/fdisks/fdisksunlabel.c
@@ -144,7 +144,7 @@ static int sun_probe_label(struct fdisk_context *cxt)
 	return 0;
 }
 
-void create_sunlabel(struct fdisk_context *cxt)
+static int sun_create_label(struct fdisk_context *cxt)
 {
 	struct hd_geometry geometry;
 	sector_t llsectors, llcyls;
@@ -161,7 +161,6 @@ void create_sunlabel(struct fdisk_context *cxt)
 
 	init();
 	fdisk_mbr_zeroize(cxt);
-	fdisk_label_change(cxt, "sun");
 
 	sunlabel->magic = SSWAP16(SUN_LABEL_MAGIC);
 	sunlabel->sanity = SSWAP32(SUN_LABEL_SANE);
@@ -654,6 +653,7 @@ const struct fdisk_label sun_label =
 	.probe = sun_probe_label,
 	.write = sun_write_table,
 	.verify = sun_verify,
+	.create_label = sun_create_label,
 	.part_new = sun_add_partition,
 	.part_delete = sun_delete_partition,
 };
diff --git a/fdisks/fdisksunlabel.h b/fdisks/fdisksunlabel.h
index 1728016..7196e1f 100644
--- a/fdisks/fdisksunlabel.h
+++ b/fdisks/fdisksunlabel.h
@@ -77,7 +77,6 @@ struct sun_disk_label {
 
 /* fdisksunlabel.c */
 extern struct systypes sun_sys_types[];
-extern void create_sunlabel(struct fdisk_context *cxt);
 extern int sun_change_sysid(struct fdisk_context *cxt, int i, uint16_t sys);
 extern void sun_list_table(struct fdisk_context *cxt, int xtra);
 extern void sun_set_alt_cyl(struct fdisk_context *cxt);
diff --git a/fdisks/utils.c b/fdisks/utils.c
index 4221b9d..62cd6aa 100644
--- a/fdisks/utils.c
+++ b/fdisks/utils.c
@@ -124,6 +124,35 @@ int fdisk_label_partition_new(struct fdisk_context *cxt, int partnum, int partty
 }
 
 /**
+ * fdisk_label_create:
+ * @cxt: fdisk context
+ * @name: label name
+ *
+ * Creates a new disk label of type @name. If @name is NULL, then it
+ * will create a default system label type, either SUN or DOS.
+ *
+ * Returns 0 on success, otherwise, a corresponding error.
+ */
+int fdisk_label_create(struct fdisk_context *cxt, const char *name)
+{
+	int errcode;
+
+	if (!name) { /* use default label creation */
+#ifdef __sparc__
+		errcode = fdisk_label_change(cxt, "sun");
+#else
+		errcode = fdisk_label_change(cxt, "dos");
+#endif
+		if (errcode)
+			goto done;
+	}
+	
+	errcode = fdisk_label_change(cxt, name);
+done:
+	return errcode;
+}
+
+/**
  * fdisk_label_partition_delete:
  * @cxt: fdisk context
  * @partnum: partition number to delete
-- 
1.7.4.1




