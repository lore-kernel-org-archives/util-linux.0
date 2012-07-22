Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcaib.dreamhost.com ([208.97.132.81]:44314 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752109Ab2GVRFS (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 22 Jul 2012 13:05:18 -0400
Subject: [PATCH 04/10] fdisk: API: add delete partition to label operations
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 22 Jul 2012 19:05:07 +0200
Message-ID: <1342976707.2863.14.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/fdisk.c         |   21 ++-------
 fdisks/fdisk.h         |    3 +
 fdisks/fdiskaixlabel.c |    1 +
 fdisks/fdiskbsdlabel.c |   25 +++++------
 fdisks/fdiskdoslabel.c |  113 ++++++++++++++++++++++++------------------------
 fdisks/fdiskdoslabel.h |    1 -
 fdisks/fdiskmaclabel.c |    1 +
 fdisks/fdisksgilabel.c |    6 +-
 fdisks/fdisksgilabel.h |    1 -
 fdisks/fdisksunlabel.c |    9 ++--
 fdisks/fdisksunlabel.h |    1 -
 fdisks/utils.c         |   15 ++++++
 12 files changed, 101 insertions(+), 96 deletions(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 46322bc..27002f6 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -856,25 +856,14 @@ toggle_dos_compatibility_flag(struct fdisk_context *cxt) {
 	update_sector_offset(cxt);
 }
 
-static void
-delete_partition(struct fdisk_context *cxt, int i)
+static void delete_partition(struct fdisk_context *cxt, int partnum)
 {
-	if (i < 0)
+	if (partnum < 0 || warn_geometry(cxt))
 		return;
 
-	if (warn_geometry(cxt))
-		return;		/* C/H/S not set */
-
-	ptes[i].changed = 1;
-
-	if (disklabel == DOS_LABEL)
-		dos_delete_partition(i);
-	else if (disklabel == SUN_LABEL)
-		sun_delete_partition(cxt, i);
-	else if (disklabel == SGI_LABEL)
-		sgi_delete_partition(cxt, i);
-
-	printf(_("Partition %d is deleted\n"), i + 1);
+	ptes[partnum].changed = 1;
+	fdisk_label_partition_delete(cxt, partnum);
+	printf(_("Partition %d is deleted\n"), partnum + 1);
 }
 
 static void change_sysid(struct fdisk_context *cxt)
diff --git a/fdisks/fdisk.h b/fdisks/fdisk.h
index d7e85f5..816e127 100644
--- a/fdisks/fdisk.h
+++ b/fdisks/fdisk.h
@@ -145,6 +145,8 @@ struct fdisk_label {
 
 	/* probe disk label */
 	int (*probe)(struct fdisk_context *cxt);
+	/* delete partition */
+	void (*part_delete)(struct fdisk_context *cxt, int partnum);
 };
 
 /*
@@ -166,6 +168,7 @@ extern void fdisk_geom_set_cyls(struct fdisk_context *cxt);
 extern const char *fdisk_error_name(enum fdisk_error errcode);
 extern void fdisk_error_fatal(struct fdisk_context *cxt, enum fdisk_error errcode);
 extern int fdisk_label_change(struct fdisk_context *cxt, const char *name);
+extern int fdisk_label_partition_delete(struct fdisk_context *cxt, int partnum);
 
 /* prototypes for fdisk.c */
 extern char *disk_device, *line_ptr;
diff --git a/fdisks/fdiskaixlabel.c b/fdisks/fdiskaixlabel.c
index f590e3a..45f3aa9 100644
--- a/fdisks/fdiskaixlabel.c
+++ b/fdisks/fdiskaixlabel.c
@@ -69,4 +69,5 @@ const struct fdisk_label aix_label =
 {
 	.name = "aix",
 	.probe = aix_probe_label,
+	.part_delete = NULL,
 };
diff --git a/fdisks/fdiskbsdlabel.c b/fdisks/fdiskbsdlabel.c
index fe91fe8..c7f3f86 100644
--- a/fdisks/fdiskbsdlabel.c
+++ b/fdisks/fdiskbsdlabel.c
@@ -61,7 +61,7 @@
 #define DKTYPENAMES
 #include "fdiskbsdlabel.h"
 
-static void xbsd_delete_part (void);
+static void xbsd_delete_part (struct fdisk_context *cxt, int partnum);
 static void xbsd_new_part (struct fdisk_context *cxt);
 static void xbsd_write_disklabel (struct fdisk_context *cxt);
 static int xbsd_create_disklabel (struct fdisk_context *cxt);
@@ -184,8 +184,8 @@ bsd_command_prompt (struct fdisk_context *cxt)
     putchar ('\n');
     switch (tolower (read_char (_("BSD disklabel command (m for help): ")))) {
       case 'd':
-	xbsd_delete_part ();
-	break;
+	      xbsd_delete_part(cxt, xbsd_get_part_index(xbsd_dlabel.d_npartitions));
+	      break;
       case 'e':
 	xbsd_edit_disklabel ();
 	break;
@@ -230,18 +230,14 @@ bsd_command_prompt (struct fdisk_context *cxt)
   }
 }
 
-static void
-xbsd_delete_part (void)
+static void xbsd_delete_part(struct fdisk_context *cxt, int partnum)
 {
-  int i;
-
-  i = xbsd_get_part_index (xbsd_dlabel.d_npartitions);
-  xbsd_dlabel.d_partitions[i].p_size   = 0;
-  xbsd_dlabel.d_partitions[i].p_offset = 0;
-  xbsd_dlabel.d_partitions[i].p_fstype = BSD_FS_UNUSED;
-  if (xbsd_dlabel.d_npartitions == i + 1)
-    while (xbsd_dlabel.d_partitions[xbsd_dlabel.d_npartitions-1].p_size == 0)
-      xbsd_dlabel.d_npartitions--;
+	xbsd_dlabel.d_partitions[partnum].p_size   = 0;
+	xbsd_dlabel.d_partitions[partnum].p_offset = 0;
+	xbsd_dlabel.d_partitions[partnum].p_fstype = BSD_FS_UNUSED;
+	if (xbsd_dlabel.d_npartitions == partnum + 1)
+		while (!xbsd_dlabel.d_partitions[xbsd_dlabel.d_npartitions-1].p_size)
+			xbsd_dlabel.d_npartitions--;
 }
 
 static void
@@ -850,4 +846,5 @@ const struct fdisk_label bsd_label =
 {
 	.name = "bsd",
 	.probe = osf_probe_label,
+	.part_delete = xbsd_delete_part,
 };
diff --git a/fdisks/fdiskdoslabel.c b/fdisks/fdiskdoslabel.c
index 9b9b23a..e32088e 100644
--- a/fdisks/fdiskdoslabel.c
+++ b/fdisks/fdiskdoslabel.c
@@ -120,6 +120,61 @@ void dos_init(struct fdisk_context *cxt)
 	warn_alignment(cxt);
 }
 
+static void dos_delete_partition(struct fdisk_context *cxt, int partnum)
+{
+	struct pte *pe = &ptes[partnum];
+	struct partition *p = pe->part_table;
+	struct partition *q = pe->ext_pointer;
+
+	/* Note that for the fifth partition (partnum == 4) we don't actually
+	   decrement partitions. */
+
+	if (partnum < 4) {
+		if (IS_EXTENDED (p->sys_ind) && partnum == ext_index) {
+			partitions = 4;
+			ptes[ext_index].ext_pointer = NULL;
+			extended_offset = 0;
+		}
+		clear_partition(p);
+	} else if (!q->sys_ind && partnum > 4) {
+		/* the last one in the chain - just delete */
+		--partitions;
+		--partnum;
+		clear_partition(ptes[partnum].ext_pointer);
+		ptes[partnum].changed = 1;
+	} else {
+		/* not the last one - further ones will be moved down */
+		if (partnum > 4) {
+			/* delete this link in the chain */
+			p = ptes[partnum-1].ext_pointer;
+			*p = *q;
+			set_start_sect(p, get_start_sect(q));
+			set_nr_sects(p, get_nr_sects(q));
+			ptes[partnum-1].changed = 1;
+		} else if (partitions > 5) {    /* 5 will be moved to 4 */
+			/* the first logical in a longer chain */
+			struct pte *pe = &ptes[5];
+
+			if (pe->part_table) /* prevent SEGFAULT */
+				set_start_sect(pe->part_table,
+					       get_partition_start(pe) -
+					       extended_offset);
+			pe->offset = extended_offset;
+			pe->changed = 1;
+		}
+
+		if (partitions > 5) {
+			partitions--;
+			while (partnum < partitions) {
+				ptes[partnum] = ptes[partnum+1];
+				partnum++;
+			}
+		} else
+			/* the only logical: clear only */
+			clear_partition(ptes[partnum].part_table);
+	}
+}
+
 static void read_extended(struct fdisk_context *cxt, int ext)
 {
 	int i;
@@ -208,7 +263,7 @@ static void read_extended(struct fdisk_context *cxt, int ext)
 		if (!get_nr_sects(pe->part_table) &&
 		    (partitions > 5 || ptes[4].part_table->sys_ind)) {
 			printf(_("omitting empty partition (%d)\n"), i+1);
-			dos_delete_partition(i);
+			dos_delete_partition(cxt, i);
 			goto remove; 	/* numbering changed */
 		}
 	}
@@ -262,61 +317,6 @@ void dos_set_mbr_id(struct fdisk_context *cxt)
 	dos_print_mbr_id(cxt);
 }
 
-void dos_delete_partition(int i)
-{
-	struct pte *pe = &ptes[i];
-	struct partition *p = pe->part_table;
-	struct partition *q = pe->ext_pointer;
-
-	/* Note that for the fifth partition (i == 4) we don't actually
-	   decrement partitions. */
-
-	if (i < 4) {
-		if (IS_EXTENDED (p->sys_ind) && i == ext_index) {
-			partitions = 4;
-			ptes[ext_index].ext_pointer = NULL;
-			extended_offset = 0;
-		}
-		clear_partition(p);
-	} else if (!q->sys_ind && i > 4) {
-		/* the last one in the chain - just delete */
-		--partitions;
-		--i;
-		clear_partition(ptes[i].ext_pointer);
-		ptes[i].changed = 1;
-	} else {
-		/* not the last one - further ones will be moved down */
-		if (i > 4) {
-			/* delete this link in the chain */
-			p = ptes[i-1].ext_pointer;
-			*p = *q;
-			set_start_sect(p, get_start_sect(q));
-			set_nr_sects(p, get_nr_sects(q));
-			ptes[i-1].changed = 1;
-		} else if (partitions > 5) {    /* 5 will be moved to 4 */
-			/* the first logical in a longer chain */
-			struct pte *pe = &ptes[5];
-
-			if (pe->part_table) /* prevent SEGFAULT */
-				set_start_sect(pe->part_table,
-					       get_partition_start(pe) -
-					       extended_offset);
-			pe->offset = extended_offset;
-			pe->changed = 1;
-		}
-
-		if (partitions > 5) {
-			partitions--;
-			while (i < partitions) {
-				ptes[i] = ptes[i+1];
-				i++;
-			}
-		} else
-			/* the only logical: clear only */
-			clear_partition(ptes[i].part_table);
-	}
-}
-
 static int dos_probe_label(struct fdisk_context *cxt)
 {
 	int i;
@@ -686,4 +686,5 @@ const struct fdisk_label dos_label =
 {
 	.name = "dos",
 	.probe = dos_probe_label,
+	.part_delete = dos_delete_partition,
 };
diff --git a/fdisks/fdiskdoslabel.h b/fdisks/fdiskdoslabel.h
index 608e3f7..4aa16e5 100644
--- a/fdisks/fdiskdoslabel.h
+++ b/fdisks/fdiskdoslabel.h
@@ -46,7 +46,6 @@ static inline sector_t get_partition_start(struct pte *pe)
 extern void create_doslabel(struct fdisk_context *cxt);
 extern void dos_print_mbr_id(struct fdisk_context *cxt);
 extern void dos_set_mbr_id(struct fdisk_context *cxt);
-extern void dos_delete_partition(int i);
 extern int is_dos_partition(int t);
 extern void dos_init(struct fdisk_context *cxt);
 extern void dos_add_partition(struct fdisk_context *cxt, int n, int sys);
diff --git a/fdisks/fdiskmaclabel.c b/fdisks/fdiskmaclabel.c
index 98cff26..198a2d0 100644
--- a/fdisks/fdiskmaclabel.c
+++ b/fdisks/fdiskmaclabel.c
@@ -84,4 +84,5 @@ const struct fdisk_label mac_label =
 {
 	.name = "mac",
 	.probe = mac_probe_label,
+	.part_delete = NULL,
 };
diff --git a/fdisks/fdisksgilabel.c b/fdisks/fdisksgilabel.c
index 6001038..51b0e1f 100644
--- a/fdisks/fdisksgilabel.c
+++ b/fdisks/fdisksgilabel.c
@@ -637,10 +637,9 @@ sgi_set_volhdr(struct fdisk_context *cxt)
 	}
 }
 
-void
-sgi_delete_partition(struct fdisk_context *cxt, int i)
+static void sgi_delete_partition(struct fdisk_context *cxt, int partnum)
 {
-	sgi_set_partition(cxt, i, 0, 0, 0);
+	sgi_set_partition(cxt, partnum, 0, 0, 0);
 }
 
 void
@@ -883,4 +882,5 @@ const struct fdisk_label sgi_label =
 {
 	.name = "sgi",
 	.probe = sgi_probe_label,
+	.part_delete = sgi_delete_partition,
 };
diff --git a/fdisks/fdisksgilabel.h b/fdisks/fdisksgilabel.h
index f6b88e8..98cf093 100644
--- a/fdisks/fdisksgilabel.h
+++ b/fdisks/fdisksgilabel.h
@@ -116,7 +116,6 @@ extern int  sgi_change_sysid(struct fdisk_context *cxt, int i, int sys);
 extern unsigned int	sgi_get_start_sector(struct fdisk_context *cxt, int i );
 extern unsigned int	sgi_get_num_sectors(struct fdisk_context *cxt, int i );
 extern int	sgi_get_sysid(struct fdisk_context *cxt, int i );
-extern void	sgi_delete_partition( struct fdisk_context *cxt, int i );
 extern void	sgi_add_partition( struct fdisk_context *cxt, int n, int sys );
 extern void	create_sgilabel( struct fdisk_context *cxt );
 extern void	create_sgiinfo(struct fdisk_context *cxt);
diff --git a/fdisks/fdisksunlabel.c b/fdisks/fdisksunlabel.c
index b63335c..c74ffbb 100644
--- a/fdisks/fdisksunlabel.c
+++ b/fdisks/fdisksunlabel.c
@@ -482,13 +482,13 @@ and is of type `Whole disk'\n"));
 	set_sun_partition(cxt, n, first, last, sys);
 }
 
-void sun_delete_partition(struct fdisk_context *cxt, int i)
+static void sun_delete_partition(struct fdisk_context *cxt, int partnum)
 {
-	struct sun_partition *part = &sunlabel->partitions[i];
-	struct sun_tag_flag *tag = &sunlabel->part_tags[i];
+	struct sun_partition *part = &sunlabel->partitions[partnum];
+	struct sun_tag_flag *tag = &sunlabel->part_tags[partnum];
 	unsigned int nsec;
 
-	if (i == 2 &&
+	if (partnum == 2 &&
 	    tag->tag == SSWAP16(SUN_TAG_BACKUP) &&
 	    !part->start_cylinder &&
 	    (nsec = SSWAP32(part->num_sectors))
@@ -648,4 +648,5 @@ const struct fdisk_label sun_label =
 {
 	.name = "sun",
 	.probe = sun_probe_label,
+	.part_delete = sun_delete_partition,
 };
diff --git a/fdisks/fdisksunlabel.h b/fdisks/fdisksunlabel.h
index 9779e22..47aa30a 100644
--- a/fdisks/fdisksunlabel.h
+++ b/fdisks/fdisksunlabel.h
@@ -78,7 +78,6 @@ struct sun_disk_label {
 /* fdisksunlabel.c */
 extern struct systypes sun_sys_types[];
 extern void create_sunlabel(struct fdisk_context *cxt);
-extern void sun_delete_partition(struct fdisk_context *cxt, int i);
 extern int sun_change_sysid(struct fdisk_context *cxt, int i, uint16_t sys);
 extern void sun_list_table(struct fdisk_context *cxt, int xtra);
 extern void verify_sun(struct fdisk_context *cxt);
diff --git a/fdisks/utils.c b/fdisks/utils.c
index 48dedfb..c8b8f7e 100644
--- a/fdisks/utils.c
+++ b/fdisks/utils.c
@@ -81,6 +81,21 @@ done:
 	return 0;
 }
 
+/**
+ * fdisk_label_partition_delete:
+ * @cxt: fdisk context
+ * @partnum: partition number to delete
+ *
+ * Deletes a @partnum partition.
+ *
+ * Returns 0 on success, otherwise, a corresponding error.
+ */
+int fdisk_label_partition_delete(struct fdisk_context *cxt, int partnum)
+{
+	cxt->label->part_delete(cxt, partnum);
+	return 0;
+}	
+
 static int __probe_labels(struct fdisk_context *cxt)
 {
 	int i, rc = 0;
-- 
1.7.4.1




