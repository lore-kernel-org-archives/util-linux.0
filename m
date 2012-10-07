Return-Path: dave@gnu.org
Message-ID: <1349620417.2548.6.camel@offbook>
Subject: [PATCH 1/5] fdisk: api: propagate partition deletion to users
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Date: Sun, 07 Oct 2012 16:33:37 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

The generic fdisk_delete_partition() function returns 0 when a partition
is correctly deleted, otherwise it's corresponding error (negative values).
This, however, does not include problems that can occur in actual label
specific contexts, so we need to propagate the corresponding return code,
back to the user visible api.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
I'll send a similar one shortly for adding partitions, which has the same problem.

 fdisks/fdisk.c         |    6 ++++--
 fdisks/fdisk.h         |    2 +-
 fdisks/fdiskbsdlabel.c |    6 ++++--
 fdisks/fdiskdoslabel.c |    4 +++-
 fdisks/fdisksgilabel.c |   13 ++++++++-----
 fdisks/fdisksunlabel.c |   12 +++++++-----
 fdisks/gpt.c           |    8 +++++---
 fdisks/utils.c         |    3 +--
 8 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 5e7c2e5..1295d54 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -841,8 +841,10 @@ static void delete_partition(struct fdisk_context *cxt, int partnum)
 		return;
 
 	ptes[partnum].changed = 1;
-	fdisk_delete_partition(cxt, partnum);
-	printf(_("Partition %d is deleted\n"), partnum + 1);
+	if (fdisk_delete_partition(cxt, partnum) != 0)
+		printf(_("Could not delete partition %d\n"), partnum + 1);
+	else
+		printf(_("Partition %d is deleted\n"), partnum + 1);
 }
 
 static void change_partition_type(struct fdisk_context *cxt)
diff --git a/fdisks/fdisk.h b/fdisks/fdisk.h
index 3f97eb2..90ebb62 100644
--- a/fdisks/fdisk.h
+++ b/fdisks/fdisk.h
@@ -173,7 +173,7 @@ struct fdisk_label {
 	/* new partition */
 	void (*part_add)(struct fdisk_context *cxt, int partnum, struct fdisk_parttype *t);
 	/* delete partition */
-	void (*part_delete)(struct fdisk_context *cxt, int partnum);
+	int (*part_delete)(struct fdisk_context *cxt, int partnum);
 	/* get partition type */
 	struct fdisk_parttype *(*part_get_type)(struct fdisk_context *cxt, int partnum);
 	/* set partition type */
diff --git a/fdisks/fdiskbsdlabel.c b/fdisks/fdiskbsdlabel.c
index af7513f..e8bd788 100644
--- a/fdisks/fdiskbsdlabel.c
+++ b/fdisks/fdiskbsdlabel.c
@@ -61,7 +61,7 @@
 #define DKTYPENAMES
 #include "fdiskbsdlabel.h"
 
-static void xbsd_delete_part (struct fdisk_context *cxt, int partnum);
+static int xbsd_delete_part (struct fdisk_context *cxt, int partnum);
 static void xbsd_edit_disklabel (void);
 static void xbsd_write_bootstrap (struct fdisk_context *cxt);
 static void xbsd_change_fstype (struct fdisk_context *cxt);
@@ -311,7 +311,7 @@ bsd_command_prompt (struct fdisk_context *cxt)
   }
 }
 
-static void xbsd_delete_part(struct fdisk_context *cxt __attribute__((__unused__)),
+static int xbsd_delete_part(struct fdisk_context *cxt __attribute__((__unused__)),
 			     int partnum)
 {
 	xbsd_dlabel.d_partitions[partnum].p_size   = 0;
@@ -320,6 +320,8 @@ static void xbsd_delete_part(struct fdisk_context *cxt __attribute__((__unused__
 	if (xbsd_dlabel.d_npartitions == partnum + 1)
 		while (!xbsd_dlabel.d_partitions[xbsd_dlabel.d_npartitions-1].p_size)
 			xbsd_dlabel.d_npartitions--;
+
+	return 0;
 }
 
 void
diff --git a/fdisks/fdiskdoslabel.c b/fdisks/fdiskdoslabel.c
index 2436af5..3e56e38 100644
--- a/fdisks/fdiskdoslabel.c
+++ b/fdisks/fdiskdoslabel.c
@@ -135,7 +135,7 @@ void dos_init(struct fdisk_context *cxt)
 	warn_alignment(cxt);
 }
 
-static void dos_delete_partition(
+static int dos_delete_partition(
 		struct fdisk_context *cxt __attribute__ ((__unused__)),
 		int partnum)
 {
@@ -190,6 +190,8 @@ static void dos_delete_partition(
 			/* the only logical: clear only */
 			clear_partition(ptes[partnum].part_table);
 	}
+
+	return 0;
 }
 
 static void read_extended(struct fdisk_context *cxt, int ext)
diff --git a/fdisks/fdisksgilabel.c b/fdisks/fdisksgilabel.c
index aa46fd5..665d3e7 100644
--- a/fdisks/fdisksgilabel.c
+++ b/fdisks/fdisksgilabel.c
@@ -587,17 +587,20 @@ sgi_entire(struct fdisk_context *cxt) {
 	return -1;
 }
 
-static void
-sgi_set_partition(struct fdisk_context *cxt,
-		  int i, unsigned int start, unsigned int length, int sys) {
+static int sgi_set_partition(struct fdisk_context *cxt, int i,
+			     unsigned int start, unsigned int length, int sys)
+{
 	sgilabel->partitions[i].id = SSWAP32(sys);
 	sgilabel->partitions[i].num_sectors = SSWAP32(length);
 	sgilabel->partitions[i].start_sector = SSWAP32(start);
 	set_changed(i);
+
 	if (sgi_gaps(cxt) < 0)	/* rebuild freelist */
 		printf(_("Partition overlap on the disk.\n"));
 	if (length)
 		print_partition_size(cxt, i + 1, start, start + length, sys);
+
+	return 0;
 }
 
 static void
@@ -631,9 +634,9 @@ sgi_set_volhdr(struct fdisk_context *cxt)
 	}
 }
 
-static void sgi_delete_partition(struct fdisk_context *cxt, int partnum)
+static int sgi_delete_partition(struct fdisk_context *cxt, int partnum)
 {
-	sgi_set_partition(cxt, partnum, 0, 0, 0);
+	return sgi_set_partition(cxt, partnum, 0, 0, 0);
 }
 
 static void sgi_add_partition(struct fdisk_context *cxt, int n,
diff --git a/fdisks/fdisksunlabel.c b/fdisks/fdisksunlabel.c
index 9d3c3d1..f272f65 100644
--- a/fdisks/fdisksunlabel.c
+++ b/fdisks/fdisksunlabel.c
@@ -486,7 +486,7 @@ and is of type `Whole disk'\n"));
 	set_sun_partition(cxt, n, first, last, sys);
 }
 
-static void sun_delete_partition(struct fdisk_context *cxt, int partnum)
+static int sun_delete_partition(struct fdisk_context *cxt, int partnum)
 {
 	struct sun_partition *part = &sunlabel->partitions[partnum];
 	struct sun_tag_flag *tag = &sunlabel->part_tags[partnum];
@@ -496,13 +496,15 @@ static void sun_delete_partition(struct fdisk_context *cxt, int partnum)
 	    tag->tag == SSWAP16(SUN_TAG_BACKUP) &&
 	    !part->start_cylinder &&
 	    (nsec = SSWAP32(part->num_sectors))
-	      == cxt->geom.heads * cxt->geom.sectors * cxt->geom.cylinders)
+	    == cxt->geom.heads * cxt->geom.sectors * cxt->geom.cylinders)
 		printf(_("If you want to maintain SunOS/Solaris compatibility, "
-		       "consider leaving this\n"
-		       "partition as Whole disk (5), starting at 0, with %u "
-		       "sectors\n"), nsec);
+			 "consider leaving this\n"
+			 "partition as Whole disk (5), starting at 0, with %u "
+			 "sectors\n"), nsec);
 	tag->tag = SSWAP16(SUN_TAG_UNASSIGNED);
 	part->num_sectors = 0;
+
+	return 0;
 }
 

diff --git a/fdisks/gpt.c b/fdisks/gpt.c
index 91c7312..eca1a2b 100644
--- a/fdisks/gpt.c
+++ b/fdisks/gpt.c
@@ -1223,19 +1223,21 @@ static int gpt_verify_disklabel(struct fdisk_context *cxt)
 }
 
 /* Delete a single GPT partition, specified by partnum. */
-static void gpt_delete_partition(struct fdisk_context *cxt, int partnum)
+static int gpt_delete_partition(struct fdisk_context *cxt, int partnum)
 {
 	if (!cxt || partition_unused(ents[partnum]) || partnum < 0)
-		return;
+		return -EINVAL;
 
 	/* hasta la vista, baby! */
 	memset(&ents[partnum], 0, sizeof(ents[partnum]));
 	if (!partition_unused(ents[partnum]))
-		printf(_("Could not delete partition %d\n"), partnum + 1);
+		return -EINVAL;
 	else {
 		gpt_recompute_crc(pheader, ents);
 		gpt_recompute_crc(bheader, ents);
 	}
+
+	return 0;
 }
 
 static void gpt_entry_set_type(struct gpt_entry *e, struct gpt_guid *type)
diff --git a/fdisks/utils.c b/fdisks/utils.c
index a206631..0b65186 100644
--- a/fdisks/utils.c
+++ b/fdisks/utils.c
@@ -126,8 +126,7 @@ int fdisk_delete_partition(struct fdisk_context *cxt, int partnum)
 
 	DBG(LABEL, dbgprint("deleting %s partition number %d",
 				cxt->label->name, partnum));
-	cxt->label->part_delete(cxt, partnum);
-	return 0;
+	return cxt->label->part_delete(cxt, partnum);
 }
 
 static int __probe_labels(struct fdisk_context *cxt)
-- 
1.7.9.5
