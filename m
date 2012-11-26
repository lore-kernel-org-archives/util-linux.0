Return-Path: dave@gnu.org
Message-ID: <1353904158.2945.18.camel@offbook>
Subject: [PATCH 3/3] fdisk: api: propagate add partitions to users
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Date: Sun, 25 Nov 2012 20:29:18 -0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

Similarly to commit 1f5eb51b79275e32d045fd6718753bf04cde8374 we
do not propagate problems when adding partitions to user visible
api.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/fdisk.h         |    2 +-
 fdisks/fdiskaixlabel.c |    4 +++-
 fdisks/fdiskbsdlabel.c |   19 +++++++++++--------
 fdisks/fdiskdoslabel.c |   36 ++++++++++++++++++++----------------
 fdisks/fdiskmaclabel.c |    4 +++-
 fdisks/fdisksgilabel.c |   12 +++++++-----
 fdisks/fdisksunlabel.c |    9 +++++----
 fdisks/gpt.c           |   12 +++++++-----
 8 files changed, 57 insertions(+), 41 deletions(-)

diff --git a/fdisks/fdisk.h b/fdisks/fdisk.h
index 704f0f2..b099d78 100644
--- a/fdisks/fdisk.h
+++ b/fdisks/fdisk.h
@@ -187,7 +187,7 @@ struct fdisk_label {
 	/* create new disk label */
 	int (*create)(struct fdisk_context *cxt);
 	/* new partition */
-	void (*part_add)(struct fdisk_context *cxt, int partnum, struct fdisk_parttype *t);
+	int (*part_add)(struct fdisk_context *cxt, int partnum, struct fdisk_parttype *t);
 	/* delete partition */
 	int (*part_delete)(struct fdisk_context *cxt, int partnum);
 	/* get partition type */
diff --git a/fdisks/fdiskaixlabel.c b/fdisks/fdiskaixlabel.c
index ac375f5..d836363 100644
--- a/fdisks/fdiskaixlabel.c
+++ b/fdisks/fdiskaixlabel.c
@@ -66,7 +66,7 @@ static int aix_probe_label(struct fdisk_context *cxt)
     return 1;
 }
 
-static void aix_add_partition(
+static int aix_add_partition(
 		struct fdisk_context *cxt __attribute__((__unused__)),
 		int partnum __attribute__((__unused__)),
 		struct fdisk_parttype *t __attribute__((__unused__)))
@@ -76,6 +76,8 @@ static void aix_add_partition(
 		 "\n\ta new empty DOS partition table first. (Use o.)"
 		 "\n\tWARNING: "
 		 "This will destroy the present disk contents.\n"));
+
+	return -ENOSYS;
 }
 
 const struct fdisk_label aix_label =
diff --git a/fdisks/fdiskbsdlabel.c b/fdisks/fdiskbsdlabel.c
index 9fd658e..54c0327 100644
--- a/fdisks/fdiskbsdlabel.c
+++ b/fdisks/fdiskbsdlabel.c
@@ -151,16 +151,17 @@ static int xbsd_write_disklabel (struct fdisk_context *cxt)
 	return 0;
 }
 
-static void xbsd_add_part (struct fdisk_context *cxt,
+static int xbsd_add_part (struct fdisk_context *cxt,
 		int partnum __attribute__((__unused__)),
 		struct fdisk_parttype *t __attribute__((__unused__)))
 {
 	unsigned int begin, end;
 	char mesg[256];
-	int i;
+	int i, rc;
 
-	if (!xbsd_check_new_partition (&i))
-		return;
+	rc = xbsd_check_new_partition(&i);
+	if (rc)
+		return rc;
 
 #if !defined (__alpha__) && !defined (__powerpc__) && !defined (__hppa__)
 	begin = get_start_sect(xbsd_part);
@@ -188,6 +189,8 @@ static void xbsd_add_part (struct fdisk_context *cxt,
 	xbsd_dlabel.d_partitions[i].p_size   = end - begin + 1;
 	xbsd_dlabel.d_partitions[i].p_offset = begin;
 	xbsd_dlabel.d_partitions[i].p_fstype = BSD_FS_UNUSED;
+
+	return 0;
 }
 
 static int xbsd_create_disklabel (struct fdisk_context *cxt)
@@ -603,7 +606,7 @@ xbsd_check_new_partition (int *i) {
 		if (t == BSD_MAXPARTITIONS) {
 			fprintf (stderr, _("The maximum number of partitions "
 					   "has been created\n"));
-			return 0;
+			return -EINVAL;
 		}
 	}
 
@@ -614,10 +617,10 @@ xbsd_check_new_partition (int *i) {
 
 	if (xbsd_dlabel.d_partitions[*i].p_size != 0) {
 		fprintf (stderr, _("This partition already exists.\n"));
-		return 0;
+		return -EINVAL;
 	}
 
-	return 1;
+	return 0;
 }
 
 static unsigned short
@@ -815,7 +818,7 @@ xbsd_link_part (struct fdisk_context *cxt)
 
   k = get_partition (cxt, 1, partitions);
 
-  if (!xbsd_check_new_partition (&i))
+  if (xbsd_check_new_partition (&i))
     return;
 
   p = get_part_table(k);
diff --git a/fdisks/fdiskdoslabel.c b/fdisks/fdiskdoslabel.c
index 2b66044..c17b8a2 100644
--- a/fdisks/fdiskdoslabel.c
+++ b/fdisks/fdiskdoslabel.c
@@ -489,7 +489,7 @@ static sector_t align_lba_in_range(struct fdisk_context *cxt,
 	return lba;
 }
 
-static void add_partition(struct fdisk_context *cxt, int n, struct fdisk_parttype *t)
+static int add_partition(struct fdisk_context *cxt, int n, struct fdisk_parttype *t)
 {
 	char mesg[256];		/* 48 does not suffice in Japanese */
 	int i, sys, read = 0;
@@ -503,7 +503,7 @@ static void add_partition(struct fdisk_context *cxt, int n, struct fdisk_parttyp
 	if (p && p->sys_ind) {
 		printf(_("Partition %d is already defined.  Delete "
 			 "it before re-adding it.\n"), n + 1);
-		return;
+		return -EINVAL;
 	}
 	fill_bounds(first, last);
 	if (n < 4) {
@@ -586,7 +586,7 @@ static void add_partition(struct fdisk_context *cxt, int n, struct fdisk_parttyp
 		printf(_("No free sectors available\n"));
 		if (n > 4)
 			partitions--;
-		return;
+		return -ENOSPC;
 	}
 	if (cround(start) == cround(limit)) {
 		stop = limit;
@@ -635,9 +635,11 @@ static void add_partition(struct fdisk_context *cxt, int n, struct fdisk_parttyp
 		pe4->changed = 1;
 		partitions = 5;
 	}
+
+	return 0;
 }
 
-static void add_logical(struct fdisk_context *cxt)
+static int add_logical(struct fdisk_context *cxt)
 {
 	if (partitions > 5 || ptes[4].part_table->sys_ind) {
 		struct pte *pe = &ptes[partitions];
@@ -650,7 +652,7 @@ static void add_logical(struct fdisk_context *cxt)
 		partitions++;
 	}
 	printf(_("Adding logical partition %d\n"), partitions);
-	add_partition(cxt, partitions - 1, NULL);
+	return add_partition(cxt, partitions - 1, NULL);
 }
 
 static int dos_verify_disklabel(struct fdisk_context *cxt)
@@ -723,32 +725,32 @@ static int dos_verify_disklabel(struct fdisk_context *cxt)
  *
  * API callback.
  */
-static void dos_add_partition(
+static int dos_add_partition(
 			struct fdisk_context *cxt,
 			int partnum __attribute__ ((__unused__)),
 			struct fdisk_parttype *t)
 {
-	int i, free_primary = 0;
+	int i, free_primary = 0, rc = 0;
 
 	for (i = 0; i < 4; i++)
 		free_primary += !ptes[i].part_table->sys_ind;
 
 	if (!free_primary && partitions >= MAXIMUM_PARTS) {
 		printf(_("The maximum number of partitions has been created\n"));
-		return;
+		return -EINVAL;
 	}
 
 	if (!free_primary) {
 		if (extended_offset) {
 			printf(_("All primary partitions are in use\n"));
-			add_logical(cxt);
+			rc = add_logical(cxt);
 		} else
 			printf(_("If you want to create more than four partitions, you must replace a\n"
 				 "primary partition with an extended partition first.\n"));
 	} else if (partitions >= MAXIMUM_PARTS) {
 		printf(_("All logical partitions are in use\n"));
 		printf(_("Adding a primary partition\n"));
-		add_partition(cxt, get_partition(cxt, 0, 4), t);
+		rc = add_partition(cxt, get_partition(cxt, 0, 4), t);
 	} else {
 		char c, dflt, line[LINE_LENGTH];
 
@@ -770,21 +772,23 @@ static void dos_add_partition(
 		if (c == 'p') {
 			int i = get_nonexisting_partition(cxt, 0, 4);
 			if (i >= 0)
-				add_partition(cxt, i, t);
-			return;
+				rc = add_partition(cxt, i, t);
+			goto done;
 		} else if (c == 'l' && extended_offset) {
-			add_logical(cxt);
-			return;
+			rc = add_logical(cxt);
+			goto done;
 		} else if (c == 'e' && !extended_offset) {
 			int i = get_nonexisting_partition(cxt, 0, 4);
 			if (i >= 0) {
 				t = fdisk_get_parttype_from_code(cxt, EXTENDED);
-				add_partition(cxt, i, t);
+				rc = add_partition(cxt, i, t);
 			}
-			return;
+			goto done;
 		} else
 			printf(_("Invalid partition type `%c'\n"), c);
 	}
+done:
+	return rc;
 }
 
 static int write_sector(struct fdisk_context *cxt, sector_t secno,
diff --git a/fdisks/fdiskmaclabel.c b/fdisks/fdiskmaclabel.c
index a30a34c..de3a8cc 100644
--- a/fdisks/fdiskmaclabel.c
+++ b/fdisks/fdiskmaclabel.c
@@ -84,7 +84,7 @@ IS_MAC:
     return 1;
 }
 
-static void mac_add_partition(
+static int mac_add_partition(
 			struct fdisk_context *cxt __attribute__ ((__unused__)),
 			int partnum __attribute__ ((__unused__)),
 			struct fdisk_parttype *t __attribute__ ((__unused__)))
@@ -94,6 +94,8 @@ static void mac_add_partition(
 		 "\n\ta new empty DOS partition table first. (Use o.)"
 		 "\n\tWARNING: "
 		 "This will destroy the present disk contents.\n"));
+
+	return -ENOSYS;
 }
 
 const struct fdisk_label mac_label =
diff --git a/fdisks/fdisksgilabel.c b/fdisks/fdisksgilabel.c
index 16f02a6..cf20445 100644
--- a/fdisks/fdisksgilabel.c
+++ b/fdisks/fdisksgilabel.c
@@ -641,8 +641,8 @@ static int sgi_delete_partition(struct fdisk_context *cxt, int partnum)
 	return sgi_set_partition(cxt, partnum, 0, 0, 0);
 }
 
-static void sgi_add_partition(struct fdisk_context *cxt, int n,
-			      struct fdisk_parttype *t)
+static int sgi_add_partition(struct fdisk_context *cxt, int n,
+			     struct fdisk_parttype *t)
 {
 	char mesg[256];
 	unsigned int first=0, last=0;
@@ -656,7 +656,7 @@ static void sgi_add_partition(struct fdisk_context *cxt, int n,
 	if (sgi_get_num_sectors(cxt, n)) {
 		printf(_("Partition %d is already defined.  Delete "
 			 "it before re-adding it.\n"), n + 1);
-		return;
+		return -EINVAL;
 	}
 	if ((sgi_entire(cxt) == -1)
 	    &&  (sys != SGI_VOLUME)) {
@@ -666,11 +666,11 @@ static void sgi_add_partition(struct fdisk_context *cxt, int n,
 	}
 	if ((sgi_gaps(cxt) == 0) &&  (sys != SGI_VOLUME)) {
 		printf(_("The entire disk is already covered with partitions.\n"));
-		return;
+		return -EINVAL;
 	}
 	if (sgi_gaps(cxt) < 0) {
 		printf(_("You got a partition overlap on the disk. Fix it first!\n"));
-		return;
+		return -EINVAL;
 	}
 	snprintf(mesg, sizeof(mesg), _("First %s"), str_units(SINGULAR));
 	for (;;) {
@@ -710,6 +710,8 @@ static void sgi_add_partition(struct fdisk_context *cxt, int n,
 		printf(_("It is highly recommended that eleventh partition\n"
 			 "covers the entire disk and is of type `SGI volume'\n"));
 	sgi_set_partition(cxt, n, first, last-first, sys);
+
+	return 0;
 }
 
 static int sgi_create_disklabel(struct fdisk_context *cxt)
diff --git a/fdisks/fdisksunlabel.c b/fdisks/fdisksunlabel.c
index 01be5e8..5bb141d 100644
--- a/fdisks/fdisksunlabel.c
+++ b/fdisks/fdisksunlabel.c
@@ -364,8 +364,8 @@ static int sun_verify_disklabel(struct fdisk_context *cxt)
     return 0;
 }
 
-static void sun_add_partition(struct fdisk_context *cxt, int n,
-			      struct fdisk_parttype *t)
+static int sun_add_partition(struct fdisk_context *cxt, int n,
+			     struct fdisk_parttype *t)
 {
 	uint32_t starts[SUN_NUM_PARTITIONS], lens[SUN_NUM_PARTITIONS];
 	struct sun_partition *part = &sunlabel->partitions[n];
@@ -380,7 +380,7 @@ static void sun_add_partition(struct fdisk_context *cxt, int n,
 	if (part->num_sectors && tag->tag != SSWAP16(SUN_TAG_UNASSIGNED)) {
 		printf(_("Partition %d is already defined.  Delete "
 			"it before re-adding it.\n"), n + 1);
-		return;
+		return -EINVAL;
 	}
 
 	fetch_sun(cxt, starts, lens, &start, &stop);
@@ -391,7 +391,7 @@ static void sun_add_partition(struct fdisk_context *cxt, int n,
 		else {
 			printf(_("Other partitions already cover the whole disk.\nDelete "
 			       "some/shrink them before retry.\n"));
-			return;
+			return -EINVAL;
 		}
 	}
 	snprintf(mesg, sizeof(mesg), _("First %s"), str_units(SINGULAR));
@@ -484,6 +484,7 @@ and is of type `Whole disk'\n"));
 		sys = SUN_TAG_BACKUP;
 
 	set_sun_partition(cxt, n, first, last, sys);
+	return 0;
 }
 
 static int sun_delete_partition(struct fdisk_context *cxt, int partnum)
diff --git a/fdisks/gpt.c b/fdisks/gpt.c
index abb2e11..cc20ba9 100644
--- a/fdisks/gpt.c
+++ b/fdisks/gpt.c
@@ -1453,7 +1453,7 @@ static int gpt_create_new_partition(int partnum, uint64_t fsect, uint64_t lsect,
 }
 
 /* Performs logical checks to add a new partition entry */
-static void gpt_add_partition(struct fdisk_context *cxt, int partnum,
+static int gpt_add_partition(struct fdisk_context *cxt, int partnum,
 			     struct fdisk_parttype *t)
 {
 	char msg[256];
@@ -1464,20 +1464,20 @@ static void gpt_add_partition(struct fdisk_context *cxt, int partnum,
 
 	/* check basic tests before even considering adding a new partition */
 	if (!cxt || partnum < 0)
-		return;
+		return -EINVAL;
 	if (!partition_unused(ents[partnum])) {
 		printf(_("Partition %d is already defined. "
 			 "Delete it before re-adding it.\n"), partnum +1);
-		return;
+		return -EINVAL;
 	}
 	if (le32_to_cpu(pheader->npartition_entries) == partitions_in_use(pheader, ents)) {
 		printf(_("All partitions are already in use.\n"));
-		return;
+		return -EINVAL;
 	}
 
 	if (!get_free_sectors(cxt, pheader, ents, &tmp, &f0)) {
 		printf(_("No free sectors available.\n"));
-		return;
+		return -ENOSPC;
 	}
 
 	first_sect = find_first_available(pheader, ents, 0);
@@ -1504,6 +1504,8 @@ static void gpt_add_partition(struct fdisk_context *cxt, int partnum,
 		printf(_("Could not create partition %d\n"), partnum + 1);
 	else
 		printf(_("Created partition %d\n"), partnum + 1);
+
+	return 0;
 }
 
 /*
-- 
1.7.9.5
