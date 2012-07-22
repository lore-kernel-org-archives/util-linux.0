Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcahe.dreamhost.com ([208.97.132.74]:40711 "EHLO
	homiemail-a37.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752158Ab2GVRFf (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 22 Jul 2012 13:05:35 -0400
Subject: [PATCH 07/10] fdisk: API: add verify to label operations
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 22 Jul 2012 19:05:32 +0200
Message-ID: <1342976732.2863.17.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Two things worth noticing:
  * A new dos_verify function is created from current fdisk.c logic.
  * SGI verfiy is always verbose.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/fdisk.c         |   86 +++++------------------------------------------
 fdisks/fdisk.h         |    6 +++
 fdisks/fdiskaixlabel.c |    1 +
 fdisks/fdiskbsdlabel.c |    1 +
 fdisks/fdiskdoslabel.c |   65 ++++++++++++++++++++++++++++++++++++
 fdisks/fdiskmaclabel.c |    1 +
 fdisks/fdisksgilabel.c |   29 ++++++++--------
 fdisks/fdisksgilabel.h |    1 -
 fdisks/fdisksunlabel.c |    7 +++-
 fdisks/fdisksunlabel.h |    1 -
 fdisks/utils.c         |   13 +++++++
 11 files changed, 116 insertions(+), 95 deletions(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 2af84f1..ab2cf5b 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -957,7 +957,8 @@ long2chs(struct fdisk_context *cxt, unsigned long ls,
 	*s = ls % cxt->geom.sectors + 1;	/* sectors count from 1 */
 }
 
-static void check_consistency(struct fdisk_context *cxt, struct partition *p, int partition) {
+void check_consistency(struct fdisk_context *cxt, struct partition *p, int partition)
+{
 	unsigned int pbc, pbh, pbs;	/* physical beginning c, h, s */
 	unsigned int pec, peh, pes;	/* physical ending c, h, s */
 	unsigned int lbc, lbh, lbs;	/* logical beginning c, h, s */
@@ -1008,8 +1009,7 @@ static void check_consistency(struct fdisk_context *cxt, struct partition *p, in
 	}
 }
 
-static void
-check_alignment(struct fdisk_context *cxt, sector_t lba, int partition)
+void check_alignment(struct fdisk_context *cxt, sector_t lba, int partition)
 {
 	if (!lba_is_aligned(cxt, lba))
 		printf(_("Partition %i does not start on physical sector boundary.\n"),
@@ -1311,9 +1311,10 @@ void fill_bounds(sector_t *first, sector_t *last)
 	}
 }
 
-static void
-check(struct fdisk_context *cxt, int n, unsigned int h, unsigned int s, unsigned int c,
-      unsigned int start) {
+void check(struct fdisk_context *cxt, int n, 
+	   unsigned int h, unsigned int s, unsigned int c,
+	   unsigned int start)
+{
 	unsigned int total, real_s, real_c;
 
 	real_s = sector(s) - 1;
@@ -1337,79 +1338,12 @@ check(struct fdisk_context *cxt, int n, unsigned int h, unsigned int s, unsigned
 			"total %d\n"), n, start, total);
 }
 
-static void
-verify(struct fdisk_context *cxt) {
-	int i, j;
-	sector_t total = 1, n_sectors = cxt->total_sectors;
-	unsigned long long first[partitions], last[partitions];
-	struct partition *p;
-
+static void verify(struct fdisk_context *cxt)
+{
 	if (warn_geometry(cxt))
 		return;
 
-	if (disklabel == SUN_LABEL) {
-		verify_sun(cxt);
-		return;
-	}
-
-	if (disklabel == SGI_LABEL) {
-		verify_sgi(cxt, 1);
-		return;
-	}
-
-	fill_bounds(first, last);
-	for (i = 0; i < partitions; i++) {
-		struct pte *pe = &ptes[i];
-
-		p = pe->part_table;
-		if (p->sys_ind && !IS_EXTENDED (p->sys_ind)) {
-			check_consistency(cxt, p, i);
-			check_alignment(cxt, get_partition_start(pe), i);
-			if (get_partition_start(pe) < first[i])
-				printf(_("Warning: bad start-of-data in "
-					"partition %d\n"), i + 1);
-			check(cxt, i + 1, p->end_head, p->end_sector, p->end_cyl,
-			      last[i]);
-			total += last[i] + 1 - first[i];
-			for (j = 0; j < i; j++)
-			if ((first[i] >= first[j] && first[i] <= last[j])
-			 || ((last[i] <= last[j] && last[i] >= first[j]))) {
-				printf(_("Warning: partition %d overlaps "
-					"partition %d.\n"), j + 1, i + 1);
-				total += first[i] >= first[j] ?
-					first[i] : first[j];
-				total -= last[i] <= last[j] ?
-					last[i] : last[j];
-			}
-		}
-	}
-
-	if (extended_offset) {
-		struct pte *pex = &ptes[ext_index];
-		sector_t e_last = get_start_sect(pex->part_table) +
-			get_nr_sects(pex->part_table) - 1;
-
-		for (i = 4; i < partitions; i++) {
-			total++;
-			p = ptes[i].part_table;
-			if (!p->sys_ind) {
-				if (i != 4 || i + 1 < partitions)
-					printf(_("Warning: partition %d "
-						"is empty\n"), i + 1);
-			}
-			else if (first[i] < extended_offset ||
-					last[i] > e_last)
-				printf(_("Logical partition %d not entirely in "
-					"partition %d\n"), i + 1, ext_index + 1);
-		}
-	}
-
-	if (total > n_sectors)
-		printf(_("Total allocated sectors %llu greater than the maximum"
-			" %llu\n"), total, n_sectors);
-	else if (total < n_sectors)
-		printf(_("Remaining %lld unallocated %ld-byte sectors\n"),
-		       n_sectors - total, cxt->sector_size);
+	fdisk_label_verify_table(cxt);
 }
 
 void print_partition_size(struct fdisk_context *cxt,
diff --git a/fdisks/fdisk.h b/fdisks/fdisk.h
index 26612bc..d9a63e6 100644
--- a/fdisks/fdisk.h
+++ b/fdisks/fdisk.h
@@ -147,6 +147,8 @@ struct fdisk_label {
 	int (*probe)(struct fdisk_context *cxt);
 	/* write in-memory changes to disk */
 	int (*write)(struct fdisk_context *cxt);
+	/* verify the partition table */
+	int (*verify)(struct fdisk_context *cxt);
 	/* new partition */
 	void (*part_new)(struct fdisk_context *cxt, int partnum, int parttype);
 	/* delete partition */
@@ -175,8 +177,12 @@ extern int fdisk_label_change(struct fdisk_context *cxt, const char *name);
 extern int fdisk_label_partition_new(struct fdisk_context *cxt, int partnum, int parttype);
 extern int fdisk_label_partition_delete(struct fdisk_context *cxt, int partnum);
 extern int fdisk_label_write_table(struct fdisk_context *cxt);
+extern int fdisk_label_verify_table(struct fdisk_context *cxt);
 
 /* prototypes for fdisk.c */
+extern void check_consistency(struct fdisk_context *cxt, struct partition *p, int partition);
+extern void check_alignment(struct fdisk_context *cxt, sector_t lba, int partition);
+extern void check(struct fdisk_context *cxt, int n, unsigned int h, unsigned int s, unsigned int c, unsigned int start);
 extern char *disk_device, *line_ptr;
 extern int fd, partitions;
 extern unsigned int display_in_cyl_units, units_per_sector;
diff --git a/fdisks/fdiskaixlabel.c b/fdisks/fdiskaixlabel.c
index 7417894..fa8a593 100644
--- a/fdisks/fdiskaixlabel.c
+++ b/fdisks/fdiskaixlabel.c
@@ -79,6 +79,7 @@ const struct fdisk_label aix_label =
 	.name = "aix",
 	.probe = aix_probe_label,
 	.write = NULL,
+	.verify = NULL,
 	.part_new = aix_new_partition,
 	.part_delete = NULL,
 };
diff --git a/fdisks/fdiskbsdlabel.c b/fdisks/fdiskbsdlabel.c
index dd7bcf1..34d8c00 100644
--- a/fdisks/fdiskbsdlabel.c
+++ b/fdisks/fdiskbsdlabel.c
@@ -846,6 +846,7 @@ const struct fdisk_label bsd_label =
 	.name = "bsd",
 	.probe = osf_probe_label,
 	.write = xbsd_write_disklabel,
+	.verify = NULL,
 	.part_new = xbsd_new_part,
 	.part_delete = xbsd_delete_part,
 };
diff --git a/fdisks/fdiskdoslabel.c b/fdisks/fdiskdoslabel.c
index 67aec77..13a6850 100644
--- a/fdisks/fdiskdoslabel.c
+++ b/fdisks/fdiskdoslabel.c
@@ -594,6 +594,70 @@ static void add_logical(struct fdisk_context *cxt)
 	dos_add_partition(cxt, partitions - 1, LINUX_NATIVE);
 }
 
+static int dos_verify(struct fdisk_context *cxt)
+{
+	int i, j;
+	sector_t total = 1, n_sectors = cxt->total_sectors;
+	unsigned long long first[partitions], last[partitions];
+	struct partition *p;
+
+	fill_bounds(first, last);
+	for (i = 0; i < partitions; i++) {
+		struct pte *pe = &ptes[i];
+
+		p = pe->part_table;
+		if (p->sys_ind && !IS_EXTENDED (p->sys_ind)) {
+			check_consistency(cxt, p, i);
+			check_alignment(cxt, get_partition_start(pe), i);
+			if (get_partition_start(pe) < first[i])
+				printf(_("Warning: bad start-of-data in "
+					 "partition %d\n"), i + 1);
+			check(cxt, i + 1, p->end_head, p->end_sector, p->end_cyl,
+			      last[i]);
+			total += last[i] + 1 - first[i];
+			for (j = 0; j < i; j++)
+				if ((first[i] >= first[j] && first[i] <= last[j])
+				    || ((last[i] <= last[j] && last[i] >= first[j]))) {
+					printf(_("Warning: partition %d overlaps "
+						 "partition %d.\n"), j + 1, i + 1);
+					total += first[i] >= first[j] ?
+						first[i] : first[j];
+					total -= last[i] <= last[j] ?
+						last[i] : last[j];
+				}
+		}
+	}
+
+	if (extended_offset) {
+		struct pte *pex = &ptes[ext_index];
+		sector_t e_last = get_start_sect(pex->part_table) +
+			get_nr_sects(pex->part_table) - 1;
+
+		for (i = 4; i < partitions; i++) {
+			total++;
+			p = ptes[i].part_table;
+			if (!p->sys_ind) {
+				if (i != 4 || i + 1 < partitions)
+					printf(_("Warning: partition %d "
+						 "is empty\n"), i + 1);
+			}
+			else if (first[i] < extended_offset ||
+					last[i] > e_last)
+				printf(_("Logical partition %d not entirely in "
+					"partition %d\n"), i + 1, ext_index + 1);
+		}
+	}
+
+	if (total > n_sectors)
+		printf(_("Total allocated sectors %llu greater than the maximum"
+			 " %llu\n"), total, n_sectors);
+	else if (total < n_sectors)
+		printf(_("Remaining %lld unallocated %ld-byte sectors\n"),
+		       n_sectors - total, cxt->sector_size);
+
+	return 0;
+}
+
 /*
  * Ask the user for new partition type information (logical, extended).
  * This function calls the actual partition adding logic - dos_add_partition.
@@ -705,6 +769,7 @@ const struct fdisk_label dos_label =
 	.name = "dos",
 	.probe = dos_probe_label,
 	.write = dos_write_table,
+	.verify = dos_verify,
 	.part_new = dos_new_partition,
 	.part_delete = dos_delete_partition,
 };
diff --git a/fdisks/fdiskmaclabel.c b/fdisks/fdiskmaclabel.c
index f678417..12b284f 100644
--- a/fdisks/fdiskmaclabel.c
+++ b/fdisks/fdiskmaclabel.c
@@ -94,6 +94,7 @@ const struct fdisk_label mac_label =
 	.name = "mac",
 	.probe = mac_probe_label,
 	.write = NULL,
+	.verify = NULL,
 	.part_new = mac_new_partition,
 	.part_delete = NULL,
 };
diff --git a/fdisks/fdisksgilabel.c b/fdisks/fdisksgilabel.c
index e65bd63..176dae4 100644
--- a/fdisks/fdisksgilabel.c
+++ b/fdisks/fdisksgilabel.c
@@ -378,17 +378,6 @@ compare_start(struct fdisk_context *cxt, const void *x, const void *y) {
 	return (a > b) ? 1 : -1;
 }
 
-static int
-sgi_gaps(struct fdisk_context *cxt) {
-	/*
-	 * returned value is:
-	 *  = 0 : disk is properly filled to the rim
-	 *  < 0 : there is an overlap
-	 *  > 0 : there is still some vacant space
-	 */
-	return verify_sgi(cxt, 0);
-}
-
 static void generic_swap(void *a, void *b, int size)
 {
 	char t;
@@ -437,13 +426,11 @@ static void sort(void *base, size_t num, size_t size, struct fdisk_context *cxt,
 	}
 }
 
-
-int
-verify_sgi(struct fdisk_context *cxt, int verbose)
+static int sgi_verify(struct fdisk_context *cxt)
 {
 	int Index[16];		/* list of valid partitions */
 	int sortcount = 0;	/* number of used partitions, i.e. non-zero lengths */
-	int entire = 0, i = 0;
+	int entire = 0, i = 0, verbose = 1;
 	unsigned int start = 0;
 	long long gap = 0;	/* count unused blocks */
 	unsigned int lastblock = sgi_get_lastblock(cxt);
@@ -562,6 +549,17 @@ verify_sgi(struct fdisk_context *cxt, int verbose)
 	return (gap > 0) ? 1 : (gap == 0) ? 0 : -1;
 }
 
+static int
+sgi_gaps(struct fdisk_context *cxt) {
+	/*
+	 * returned value is:
+	 *  = 0 : disk is properly filled to the rim
+	 *  < 0 : there is an overlap
+	 *  > 0 : there is still some vacant space
+	 */
+	return sgi_verify(cxt);
+}
+
 int
 sgi_change_sysid(struct fdisk_context *cxt, int i, int sys)
 {
@@ -884,6 +882,7 @@ const struct fdisk_label sgi_label =
 	.name = "sgi",
 	.probe = sgi_probe_label,
 	.write = sgi_write_table,
+	.verify = sgi_verify,
 	.part_new = sgi_add_partition,
 	.part_delete = sgi_delete_partition,
 };
diff --git a/fdisks/fdisksgilabel.h b/fdisks/fdisksgilabel.h
index 139e74f..0ae73eb 100644
--- a/fdisks/fdisksgilabel.h
+++ b/fdisks/fdisksgilabel.h
@@ -118,7 +118,6 @@ extern unsigned int	sgi_get_num_sectors(struct fdisk_context *cxt, int i );
 extern int	sgi_get_sysid(struct fdisk_context *cxt, int i );
 extern void	create_sgilabel( struct fdisk_context *cxt );
 extern void	create_sgiinfo(struct fdisk_context *cxt);
-extern int	verify_sgi(struct fdisk_context *cxt, int verbose );
 extern void	sgi_set_ilfact( void );
 extern void	sgi_set_rspeed( void );
 extern void	sgi_set_pcylcount( void );
diff --git a/fdisks/fdisksunlabel.c b/fdisks/fdisksunlabel.c
index 2b543c6..007eef2 100644
--- a/fdisks/fdisksunlabel.c
+++ b/fdisks/fdisksunlabel.c
@@ -294,7 +294,7 @@ static int verify_sun_cmp(int *a, int *b)
     return -1;
 }
 
-void verify_sun(struct fdisk_context *cxt)
+static int sun_verify(struct fdisk_context *cxt)
 {
     uint32_t starts[SUN_NUM_PARTITIONS], lens[SUN_NUM_PARTITIONS], start, stop;
     uint32_t i,j,k,starto,endo;
@@ -346,7 +346,7 @@ void verify_sun(struct fdisk_context *cxt)
 
     if (array[0] == -1) {
 	printf(_("No partitions defined\n"));
-	return;
+	return 0;
     }
     stop = cxt->geom.cylinders * cxt->geom.heads * cxt->geom.sectors;
     if (starts[array[0]])
@@ -359,6 +359,8 @@ void verify_sun(struct fdisk_context *cxt)
     start = (starts[array[i]] + lens[array[i]]);
     if (start < stop)
         printf(_("Unused gap - sectors %d-%d\n"), start, stop);
+    
+    return 0;
 }
 
 static void sun_add_partition(struct fdisk_context *cxt, int n, int sys)
@@ -651,6 +653,7 @@ const struct fdisk_label sun_label =
 	.name = "sun",
 	.probe = sun_probe_label,
 	.write = sun_write_table,
+	.verify = sun_verify,
 	.part_new = sun_add_partition,
 	.part_delete = sun_delete_partition,
 };
diff --git a/fdisks/fdisksunlabel.h b/fdisks/fdisksunlabel.h
index 571633a..1728016 100644
--- a/fdisks/fdisksunlabel.h
+++ b/fdisks/fdisksunlabel.h
@@ -80,7 +80,6 @@ extern struct systypes sun_sys_types[];
 extern void create_sunlabel(struct fdisk_context *cxt);
 extern int sun_change_sysid(struct fdisk_context *cxt, int i, uint16_t sys);
 extern void sun_list_table(struct fdisk_context *cxt, int xtra);
-extern void verify_sun(struct fdisk_context *cxt);
 extern void sun_set_alt_cyl(struct fdisk_context *cxt);
 extern void sun_set_ncyl(struct fdisk_context *cxt, int cyl);
 extern void sun_set_xcyl(struct fdisk_context *cxt);
diff --git a/fdisks/utils.c b/fdisks/utils.c
index 0a44d40..4221b9d 100644
--- a/fdisks/utils.c
+++ b/fdisks/utils.c
@@ -95,6 +95,19 @@ int fdisk_label_write_table(struct fdisk_context *cxt)
 }	
 
 /**
+ * fdisk_label_verify_table:
+ * @cxt: fdisk context
+ *
+ * Verifies the partition tabe.
+ *
+ * Returns 0.
+ */
+int fdisk_label_verify_table(struct fdisk_context *cxt)
+{
+	return cxt->label->verify(cxt);
+}
+
+/**
  * fdisk_label_partition_new:
  * @cxt: fdisk context
  * @partnum: partition number to create
-- 
1.7.4.1




