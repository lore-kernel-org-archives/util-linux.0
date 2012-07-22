Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcahe.dreamhost.com ([208.97.132.74]:44855 "EHLO
	homiemail-a61.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752168Ab2GVRFZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 22 Jul 2012 13:05:25 -0400
Subject: [PATCH 06/10] fdisk: API: add new partition to label operations
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 22 Jul 2012 19:05:12 +0200
Message-ID: <1342976712.2863.16.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/fdisk.c         |   38 +++++-----------------
 fdisks/fdisk.h         |    3 ++
 fdisks/fdiskaixlabel.c |   10 ++++++
 fdisks/fdiskbsdlabel.c |   81 +++++++++++++++++++++++------------------------
 fdisks/fdiskdoslabel.c |   10 ++++--
 fdisks/fdiskdoslabel.h |    2 -
 fdisks/fdiskmaclabel.c |   10 ++++++
 fdisks/fdisksgilabel.c |    4 +-
 fdisks/fdisksgilabel.h |    1 -
 fdisks/fdisksunlabel.c |    3 +-
 fdisks/fdisksunlabel.h |    1 -
 fdisks/utils.c         |   16 +++++++++
 12 files changed, 99 insertions(+), 80 deletions(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 7212840..2af84f1 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -1423,39 +1423,19 @@ void print_partition_size(struct fdisk_context *cxt,
 
 static void new_partition(struct fdisk_context *cxt)
 {
-	if (warn_geometry(cxt))
-		return;
-
-	if (disklabel == SUN_LABEL) {
-		add_sun_partition(cxt, get_partition(cxt, 0, partitions), LINUX_NATIVE);
-		return;
-	}
+	int partnum, parttype;
 
-	if (disklabel == SGI_LABEL) {
-		sgi_add_partition(cxt, get_partition(cxt, 0, partitions), LINUX_NATIVE);
-		return;
-	}
-
-	if (disklabel == AIX_LABEL) {
-		printf(_("\tSorry - this fdisk cannot handle AIX disk labels."
-			 "\n\tIf you want to add DOS-type partitions, create"
-			 "\n\ta new empty DOS partition table first. (Use o.)"
-			 "\n\tWARNING: "
-			 "This will destroy the present disk contents.\n"));
+	if (warn_geometry(cxt))
 		return;
-	}
 
-	if (disklabel == MAC_LABEL) {
-		printf(_("\tSorry - this fdisk cannot handle Mac disk labels."
-		         "\n\tIf you want to add DOS-type partitions, create"
-		         "\n\ta new empty DOS partition table first. (Use o.)"
-		         "\n\tWARNING: "
-		         "This will destroy the present disk contents.\n"));
-		 return;
-	}
+	if (disklabel == SUN_LABEL || disklabel == SGI_LABEL)
+		partnum = get_partition(cxt, 0, partitions);
 
-	/* default to DOS/BSD */
-	dos_new_partition(cxt);
+	/*
+	 * Use default LINUX_NATIVE partition type, DOS labels
+	 * may override this internally.
+	 */
+	fdisk_label_partition_new(cxt, partnum, LINUX_NATIVE);
 }
 
 static void write_table(struct fdisk_context *cxt)
diff --git a/fdisks/fdisk.h b/fdisks/fdisk.h
index 577303b..26612bc 100644
--- a/fdisks/fdisk.h
+++ b/fdisks/fdisk.h
@@ -147,6 +147,8 @@ struct fdisk_label {
 	int (*probe)(struct fdisk_context *cxt);
 	/* write in-memory changes to disk */
 	int (*write)(struct fdisk_context *cxt);
+	/* new partition */
+	void (*part_new)(struct fdisk_context *cxt, int partnum, int parttype);
 	/* delete partition */
 	void (*part_delete)(struct fdisk_context *cxt, int partnum);
 };
@@ -170,6 +172,7 @@ extern void fdisk_geom_set_cyls(struct fdisk_context *cxt);
 extern const char *fdisk_error_name(enum fdisk_error errcode);
 extern void fdisk_error_fatal(struct fdisk_context *cxt, enum fdisk_error errcode);
 extern int fdisk_label_change(struct fdisk_context *cxt, const char *name);
+extern int fdisk_label_partition_new(struct fdisk_context *cxt, int partnum, int parttype);
 extern int fdisk_label_partition_delete(struct fdisk_context *cxt, int partnum);
 extern int fdisk_label_write_table(struct fdisk_context *cxt);
 
diff --git a/fdisks/fdiskaixlabel.c b/fdisks/fdiskaixlabel.c
index d264027..7417894 100644
--- a/fdisks/fdiskaixlabel.c
+++ b/fdisks/fdiskaixlabel.c
@@ -65,10 +65,20 @@ static int aix_probe_label(struct fdisk_context *cxt)
     return 0;
 }
 
+static void aix_new_partition(struct fdisk_context *cxt, int partnum, int parttype)
+{
+	printf(_("\tSorry - this fdisk cannot handle AIX disk labels."
+		 "\n\tIf you want to add DOS-type partitions, create"
+		 "\n\ta new empty DOS partition table first. (Use o.)"
+		 "\n\tWARNING: "
+		 "This will destroy the present disk contents.\n"));
+}
+
 const struct fdisk_label aix_label =
 {
 	.name = "aix",
 	.probe = aix_probe_label,
 	.write = NULL,
+	.part_new = aix_new_partition,
 	.part_delete = NULL,
 };
diff --git a/fdisks/fdiskbsdlabel.c b/fdisks/fdiskbsdlabel.c
index b827a5b..dd7bcf1 100644
--- a/fdisks/fdiskbsdlabel.c
+++ b/fdisks/fdiskbsdlabel.c
@@ -62,7 +62,6 @@
 #include "fdiskbsdlabel.h"
 
 static void xbsd_delete_part (struct fdisk_context *cxt, int partnum);
-static void xbsd_new_part (struct fdisk_context *cxt);
 static int xbsd_create_disklabel (struct fdisk_context *cxt);
 static void xbsd_edit_disklabel (void);
 static void xbsd_write_bootstrap (struct fdisk_context *cxt);
@@ -154,6 +153,43 @@ static int xbsd_write_disklabel (struct fdisk_context *cxt)
 	return 0;
 }
 
+static void xbsd_new_part (struct fdisk_context *cxt, int partnum, int parttype)
+{
+	unsigned int begin, end;
+	char mesg[256];
+	int i;
+
+	if (!xbsd_check_new_partition (&i))
+		return;
+
+#if !defined (__alpha__) && !defined (__powerpc__) && !defined (__hppa__)
+	begin = get_start_sect(xbsd_part);
+	end = begin + get_nr_sects(xbsd_part) - 1;
+#else
+	begin = 0;
+	end = xbsd_dlabel.d_secperunit - 1;
+#endif
+
+	snprintf (mesg, sizeof(mesg), _("First %s"), str_units(SINGULAR));
+	begin = read_int (cxt, bsd_cround (begin), bsd_cround (begin), bsd_cround (end),
+			  0, mesg);
+
+	if (display_in_cyl_units)
+		begin = (begin - 1) * xbsd_dlabel.d_secpercyl;
+
+	snprintf (mesg, sizeof(mesg), _("Last %s or +size or +sizeM or +sizeK"),
+		  str_units(SINGULAR));
+	end = read_int (cxt, bsd_cround (begin), bsd_cround (end), bsd_cround (end),
+			bsd_cround (begin), mesg);
+
+	if (display_in_cyl_units)
+		end = end * xbsd_dlabel.d_secpercyl - 1;
+
+	xbsd_dlabel.d_partitions[i].p_size   = end - begin + 1;
+	xbsd_dlabel.d_partitions[i].p_offset = begin;
+	xbsd_dlabel.d_partitions[i].p_fstype = BSD_FS_UNUSED;
+}
+
 void
 bsd_command_prompt (struct fdisk_context *cxt)
 {
@@ -210,8 +246,8 @@ bsd_command_prompt (struct fdisk_context *cxt)
 	xbsd_list_types ();
 	break;
       case 'n':
-	xbsd_new_part (cxt);
-	break;
+	      xbsd_new_part (cxt, 0, 0);
+	      break;
       case 'p':
 	      xbsd_print_disklabel (cxt, 0);
 	break;
@@ -254,44 +290,6 @@ static void xbsd_delete_part(struct fdisk_context *cxt, int partnum)
 			xbsd_dlabel.d_npartitions--;
 }
 
-static void
-xbsd_new_part (struct fdisk_context *cxt)
-{
-  unsigned int begin, end;
-  char mesg[256];
-  int i;
-
-  if (!xbsd_check_new_partition (&i))
-    return;
-
-#if !defined (__alpha__) && !defined (__powerpc__) && !defined (__hppa__)
-  begin = get_start_sect(xbsd_part);
-  end = begin + get_nr_sects(xbsd_part) - 1;
-#else
-  begin = 0;
-  end = xbsd_dlabel.d_secperunit - 1;
-#endif
-
-  snprintf (mesg, sizeof(mesg), _("First %s"), str_units(SINGULAR));
-  begin = read_int (cxt, bsd_cround (begin), bsd_cround (begin), bsd_cround (end),
-		    0, mesg);
-
-  if (display_in_cyl_units)
-    begin = (begin - 1) * xbsd_dlabel.d_secpercyl;
-
-  snprintf (mesg, sizeof(mesg), _("Last %s or +size or +sizeM or +sizeK"),
-	   str_units(SINGULAR));
-  end = read_int (cxt, bsd_cround (begin), bsd_cround (end), bsd_cround (end),
-		  bsd_cround (begin), mesg);
-
-  if (display_in_cyl_units)
-    end = end * xbsd_dlabel.d_secpercyl - 1;
-
-  xbsd_dlabel.d_partitions[i].p_size   = end - begin + 1;
-  xbsd_dlabel.d_partitions[i].p_offset = begin;
-  xbsd_dlabel.d_partitions[i].p_fstype = BSD_FS_UNUSED;
-}
-
 void
 xbsd_print_disklabel (struct fdisk_context *cxt, int show_all) {
   struct xbsd_disklabel *lp = &xbsd_dlabel;
@@ -848,5 +846,6 @@ const struct fdisk_label bsd_label =
 	.name = "bsd",
 	.probe = osf_probe_label,
 	.write = xbsd_write_disklabel,
+	.part_new = xbsd_new_part,
 	.part_delete = xbsd_delete_part,
 };
diff --git a/fdisks/fdiskdoslabel.c b/fdisks/fdiskdoslabel.c
index 65609c5..67aec77 100644
--- a/fdisks/fdiskdoslabel.c
+++ b/fdisks/fdiskdoslabel.c
@@ -598,10 +598,13 @@ static void add_logical(struct fdisk_context *cxt)
  * Ask the user for new partition type information (logical, extended).
  * This function calls the actual partition adding logic - dos_add_partition.
  */
-void dos_new_partition(struct fdisk_context *cxt)
+static void dos_new_partition(struct fdisk_context *cxt, int partnum, int parttype)
 {
 	int i, free_primary = 0;
 
+	/* default */
+	parttype = LINUX_NATIVE;
+
 	for (i = 0; i < 4; i++)
 		free_primary += !ptes[i].part_table->sys_ind;
 
@@ -620,7 +623,7 @@ void dos_new_partition(struct fdisk_context *cxt)
 	} else if (partitions >= MAXIMUM_PARTS) {
 		printf(_("All logical partitions are in use\n"));
 		printf(_("Adding a primary partition\n"));
-		dos_add_partition(cxt, get_partition(cxt, 0, 4), LINUX_NATIVE);
+		dos_add_partition(cxt, get_partition(cxt, 0, 4), parttype);
 	} else {
 		char c, dflt, line[LINE_LENGTH];
 
@@ -642,7 +645,7 @@ void dos_new_partition(struct fdisk_context *cxt)
 		if (c == 'p') {
 			int i = get_nonexisting_partition(cxt, 0, 4);
 			if (i >= 0)
-				dos_add_partition(cxt, i, LINUX_NATIVE);
+				dos_add_partition(cxt, i, parttype);
 			return;
 		} else if (c == 'l' && extended_offset) {
 			add_logical(cxt);
@@ -702,5 +705,6 @@ const struct fdisk_label dos_label =
 	.name = "dos",
 	.probe = dos_probe_label,
 	.write = dos_write_table,
+	.part_new = dos_new_partition,
 	.part_delete = dos_delete_partition,
 };
diff --git a/fdisks/fdiskdoslabel.h b/fdisks/fdiskdoslabel.h
index 8a2c6dd..964f91b 100644
--- a/fdisks/fdiskdoslabel.h
+++ b/fdisks/fdiskdoslabel.h
@@ -48,7 +48,5 @@ extern void dos_print_mbr_id(struct fdisk_context *cxt);
 extern void dos_set_mbr_id(struct fdisk_context *cxt);
 extern int is_dos_partition(int t);
 extern void dos_init(struct fdisk_context *cxt);
-extern void dos_add_partition(struct fdisk_context *cxt, int n, int sys);
-extern void dos_new_partition(struct fdisk_context *cxt);
 
 #endif
diff --git a/fdisks/fdiskmaclabel.c b/fdisks/fdiskmaclabel.c
index 19c99f6..f678417 100644
--- a/fdisks/fdiskmaclabel.c
+++ b/fdisks/fdiskmaclabel.c
@@ -80,10 +80,20 @@ IS_MAC:
     return 0;
 }
 
+static void mac_new_partition(struct fdisk_context *cxt, int partnum, int parttype)
+{
+	printf(_("\tSorry - this fdisk cannot handle Mac disk labels."
+		 "\n\tIf you want to add DOS-type partitions, create"
+		 "\n\ta new empty DOS partition table first. (Use o.)"
+		 "\n\tWARNING: "
+		 "This will destroy the present disk contents.\n"));
+}
+
 const struct fdisk_label mac_label =
 {
 	.name = "mac",
 	.probe = mac_probe_label,
 	.write = NULL,
+	.part_new = mac_new_partition,
 	.part_delete = NULL,
 };
diff --git a/fdisks/fdisksgilabel.c b/fdisks/fdisksgilabel.c
index 39ba58d..e65bd63 100644
--- a/fdisks/fdisksgilabel.c
+++ b/fdisks/fdisksgilabel.c
@@ -644,8 +644,7 @@ static void sgi_delete_partition(struct fdisk_context *cxt, int partnum)
 	sgi_set_partition(cxt, partnum, 0, 0, 0);
 }
 
-void
-sgi_add_partition(struct fdisk_context *cxt, int n, int sys)
+static void sgi_add_partition(struct fdisk_context *cxt, int n, int sys)
 {
 	char mesg[256];
 	unsigned int first=0, last=0;
@@ -885,5 +884,6 @@ const struct fdisk_label sgi_label =
 	.name = "sgi",
 	.probe = sgi_probe_label,
 	.write = sgi_write_table,
+	.part_new = sgi_add_partition,
 	.part_delete = sgi_delete_partition,
 };
diff --git a/fdisks/fdisksgilabel.h b/fdisks/fdisksgilabel.h
index 14f488f..139e74f 100644
--- a/fdisks/fdisksgilabel.h
+++ b/fdisks/fdisksgilabel.h
@@ -116,7 +116,6 @@ extern int  sgi_change_sysid(struct fdisk_context *cxt, int i, int sys);
 extern unsigned int	sgi_get_start_sector(struct fdisk_context *cxt, int i );
 extern unsigned int	sgi_get_num_sectors(struct fdisk_context *cxt, int i );
 extern int	sgi_get_sysid(struct fdisk_context *cxt, int i );
-extern void	sgi_add_partition( struct fdisk_context *cxt, int n, int sys );
 extern void	create_sgilabel( struct fdisk_context *cxt );
 extern void	create_sgiinfo(struct fdisk_context *cxt);
 extern int	verify_sgi(struct fdisk_context *cxt, int verbose );
diff --git a/fdisks/fdisksunlabel.c b/fdisks/fdisksunlabel.c
index 2cae2dd..2b543c6 100644
--- a/fdisks/fdisksunlabel.c
+++ b/fdisks/fdisksunlabel.c
@@ -361,7 +361,7 @@ void verify_sun(struct fdisk_context *cxt)
         printf(_("Unused gap - sectors %d-%d\n"), start, stop);
 }
 
-void add_sun_partition(struct fdisk_context *cxt, int n, int sys)
+static void sun_add_partition(struct fdisk_context *cxt, int n, int sys)
 {
 	uint32_t starts[SUN_NUM_PARTITIONS], lens[SUN_NUM_PARTITIONS];
 	struct sun_partition *part = &sunlabel->partitions[n];
@@ -651,5 +651,6 @@ const struct fdisk_label sun_label =
 	.name = "sun",
 	.probe = sun_probe_label,
 	.write = sun_write_table,
+	.part_new = sun_add_partition,
 	.part_delete = sun_delete_partition,
 };
diff --git a/fdisks/fdisksunlabel.h b/fdisks/fdisksunlabel.h
index 0ede6e3..571633a 100644
--- a/fdisks/fdisksunlabel.h
+++ b/fdisks/fdisksunlabel.h
@@ -81,7 +81,6 @@ extern void create_sunlabel(struct fdisk_context *cxt);
 extern int sun_change_sysid(struct fdisk_context *cxt, int i, uint16_t sys);
 extern void sun_list_table(struct fdisk_context *cxt, int xtra);
 extern void verify_sun(struct fdisk_context *cxt);
-extern void add_sun_partition(struct fdisk_context *cxt, int n, int sys);
 extern void sun_set_alt_cyl(struct fdisk_context *cxt);
 extern void sun_set_ncyl(struct fdisk_context *cxt, int cyl);
 extern void sun_set_xcyl(struct fdisk_context *cxt);
diff --git a/fdisks/utils.c b/fdisks/utils.c
index 9b5092d..0a44d40 100644
--- a/fdisks/utils.c
+++ b/fdisks/utils.c
@@ -95,6 +95,22 @@ int fdisk_label_write_table(struct fdisk_context *cxt)
 }	
 
 /**
+ * fdisk_label_partition_new:
+ * @cxt: fdisk context
+ * @partnum: partition number to create
+ * @parttype: partition type to create
+ *
+ * Creates a new partition, with number @partnum and type @parttype.
+ *
+ * Returns 0.
+ */
+int fdisk_label_partition_new(struct fdisk_context *cxt, int partnum, int parttype)
+{
+	cxt->label->part_new(cxt, partnum, parttype);
+	return 0;
+}
+
+/**
  * fdisk_label_partition_delete:
  * @cxt: fdisk context
  * @partnum: partition number to delete
-- 
1.7.4.1




