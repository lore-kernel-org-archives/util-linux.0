Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcahe.dreamhost.com ([208.97.132.74]:43438 "EHLO
	homiemail-a6.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753992Ab2FCSPW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Jun 2012 14:15:22 -0400
Subject: [PATCH 1/5] fdisk: add device topology to the API
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 03 Jun 2012 20:15:17 +0200
Message-ID: <1338747317.2864.10.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

This patch adds device topology discovery to the internal API. This functionality is static only to the API and therefore hidden
from general fdisk code. Functionality itself doesn't really change, min_io_size, io_size, logical and physical sector sizes and
alignment offset are added to the fdisk_context structure and elements are accessed from there. The logical sector size (sector_size)
is now unsigned long instead of unsigned int, this as no effect otherwise.

A few things to notice:
 - The patch is larger than I wanted but we need to modify function parameters across fdisk and its labels to use the topology data from
   cxt-> instances. Hopefully this will be pretty much it regarding this kind of modifications - perhaps geometry will need something
   of the like too.

 - The -b option must override internal discovery.

 - A new helper function has added to verify if the device provides topology information, this replaces the 'has_topology' global variable.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c         |  309 ++++++++++++++++++++-----------------------------
 fdisk/fdisk.h         |   34 ++++--
 fdisk/fdiskbsdlabel.c |   18 ++--
 fdisk/fdiskdoslabel.c |   75 ++++++------
 fdisk/fdiskdoslabel.h |    8 +-
 fdisk/fdisksgilabel.c |   49 ++++----
 fdisk/fdisksgilabel.h |    4 +-
 fdisk/fdisksunlabel.c |   53 +++++----
 fdisk/fdisksunlabel.h |   12 +-
 fdisk/utils.c         |   73 ++++++++++++-
 10 files changed, 329 insertions(+), 306 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 1143b2f..d7ff2e5 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -47,9 +47,6 @@
 #ifdef HAVE_LINUX_BLKPG_H
 #include <linux/blkpg.h>
 #endif
-#ifdef HAVE_LIBBLKID
-#include <blkid.h>
-#endif
 
 #include "gpt.h"
 
@@ -144,19 +141,12 @@ sector_t sector_offset = 1, sectors;
 
 unsigned int	heads,
 	cylinders,
-	sector_size = DEFAULT_SECTOR_SIZE,
 	user_set_sector_size = 0,
 	units_per_sector = 1,
 	display_in_cyl_units = 0;
 
 sector_t total_number_of_sectors; /* in logical sectors */
-unsigned long grain = DEFAULT_SECTOR_SIZE,
-	      io_size = DEFAULT_SECTOR_SIZE,
-	      min_io_size = DEFAULT_SECTOR_SIZE,
-	      phy_sector_size = DEFAULT_SECTOR_SIZE,
-	      alignment_offset;
-int has_topology;
-
+unsigned long grain = DEFAULT_SECTOR_SIZE;
 enum labeltype disklabel;	/* Current disklabel */
 
 static void __attribute__ ((__noreturn__)) usage(FILE *out)
@@ -318,22 +308,22 @@ test_c(char **m, char *mesg) {
 }
 
 static int
-lba_is_aligned(sector_t lba)
+lba_is_aligned(struct fdisk_context *cxt, sector_t lba)
 {
-	unsigned int granularity = max(phy_sector_size, min_io_size);
-	sector_t offset = (lba * sector_size) & (granularity - 1);
+	unsigned int granularity = max(cxt->phy_sector_size, cxt->min_io_size);
+	sector_t offset = (lba * cxt->sector_size) & (granularity - 1);
 
-	return !((granularity + alignment_offset - offset) & (granularity - 1));
+	return !((granularity + cxt->alignment_offset - offset) & (granularity - 1));
 }
 
-sector_t align_lba(sector_t lba, int direction)
+sector_t align_lba(struct fdisk_context *cxt, sector_t lba, int direction)
 {
 	sector_t res;
 
-	if (lba_is_aligned(lba))
+	if (lba_is_aligned(cxt, lba))
 		res = lba;
 	else {
-		sector_t sects_in_phy = grain / sector_size;
+		sector_t sects_in_phy = grain / cxt->sector_size;
 
 		if (lba < sector_offset)
 			res = sector_offset;
@@ -347,8 +337,8 @@ sector_t align_lba(sector_t lba, int direction)
 		else /* ALIGN_NEAREST */
 			res = ((lba + sects_in_phy / 2) / sects_in_phy) * sects_in_phy;
 
-		if (alignment_offset && !lba_is_aligned(res) &&
-		    res > alignment_offset / sector_size) {
+		if (cxt->alignment_offset && !lba_is_aligned(cxt, res) &&
+		    res > cxt->alignment_offset / cxt->sector_size) {
 			/*
 			 * apply alignment_offset
 			 *
@@ -357,8 +347,8 @@ sector_t align_lba(sector_t lba, int direction)
 			 * according the offset to be on the physical boundary.
 			 */
 			/* fprintf(stderr, "LBA: %llu apply alignment_offset\n", res); */
-			res -= (max(phy_sector_size, min_io_size) -
-					alignment_offset) / sector_size;
+			res -= (max(cxt->phy_sector_size, cxt->min_io_size) -
+					cxt->alignment_offset) / cxt->sector_size;
 
 			if (direction == ALIGN_UP && res < lba)
 				res += sects_in_phy;
@@ -408,31 +398,31 @@ void update_units(void)
 		units_per_sector = 1;	/* in sectors */
 }
 
-void warn_limits(void)
+void warn_limits(struct fdisk_context *cxt)
 {
 	if (total_number_of_sectors > UINT_MAX && !nowarn) {
-		unsigned long long bytes = total_number_of_sectors * sector_size;
+		unsigned long long bytes = total_number_of_sectors * cxt->sector_size;
 		int giga = bytes / 1000000000;
 		int hectogiga = (giga + 50) / 100;
 
 		fprintf(stderr, _("\n"
 "WARNING: The size of this disk is %d.%d TB (%llu bytes).\n"
 "DOS partition table format can not be used on drives for volumes\n"
-"larger than (%llu bytes) for %d-byte sectors. Use parted(1) and GUID \n"
+"larger than (%llu bytes) for %ld-byte sectors. Use parted(1) and GUID \n"
 "partition table format (GPT).\n\n"),
 			hectogiga / 10, hectogiga % 10,
 			bytes,
-			(sector_t ) UINT_MAX * sector_size,
-			sector_size);
+			(sector_t ) UINT_MAX * cxt->sector_size,
+			cxt->sector_size);
 	}
 }
 
-void warn_alignment(void)
+void warn_alignment(struct fdisk_context *cxt)
 {
 	if (nowarn)
 		return;
 
-	if (sector_size != phy_sector_size)
+	if (cxt->sector_size != cxt->phy_sector_size)
 		fprintf(stderr, _("\n"
 "The device presents a logical sector size that is smaller than\n"
 "the physical sector size. Aligning to a physical sector (or optimal\n"
@@ -451,64 +441,6 @@ void warn_alignment(void)
 }
 
 static void
-get_topology(struct fdisk_context *cxt) {
-	int arg;
-#ifdef HAVE_LIBBLKID
-	blkid_probe pr;
-
-	pr = blkid_new_probe();
-	if (pr && blkid_probe_set_device(pr, cxt->dev_fd, 0, 0) == 0) {
-		blkid_topology tp = blkid_probe_get_topology(pr);
-
-		if (tp) {
-			min_io_size = blkid_topology_get_minimum_io_size(tp);
-			io_size = blkid_topology_get_optimal_io_size(tp);
-			phy_sector_size = blkid_topology_get_physical_sector_size(tp);
-			alignment_offset = blkid_topology_get_alignment_offset(tp);
-
-			/* We assume that the device provides topology info if
-			 * optimal_io_size is set or alignment_offset is set or
-			 * minimum_io_size is not power of 2.
-			 *
-			 * See also update_sector_offset().
-			 */
-			if (io_size || alignment_offset ||
-			    (min_io_size & (min_io_size - 1)))
-				has_topology = 1;
-			if (!io_size)
-				/* optimal IO is optional, default to minimum IO */
-				io_size = min_io_size;
-		}
-	}
-	blkid_free_probe(pr);
-#endif
-
-	if (user_set_sector_size)
-		/* fdisk since 2.17 differentiate between logical and physical
-		 * sectors size. For backward compatibility the
-		 *    fdisk -b <sectorsize>
-		 * changes both, logical and physical sector size.
-		 */
-		phy_sector_size = sector_size;
-
-	else if (blkdev_get_sector_size(cxt->dev_fd, &arg) == 0) {
-		sector_size = arg;
-
-		if (!phy_sector_size)
-			phy_sector_size = sector_size;
-	}
-
-	if (!min_io_size)
-		min_io_size = phy_sector_size;
-	if (!io_size)
-		io_size = min_io_size;
-
-	if (sector_size != DEFAULT_SECTOR_SIZE)
-		printf(_("Note: sector size is %d (not %d)\n"),
-		       sector_size, DEFAULT_SECTOR_SIZE);
-}
-
-static void
 get_partition_table_geometry(void) {
 	unsigned char *bufp = MBRbuffer;
 	struct partition *p;
@@ -544,9 +476,9 @@ get_partition_table_geometry(void) {
  * Sets LBA of the first partition
  */
 void
-update_sector_offset(void)
+update_sector_offset(struct fdisk_context *cxt)
 {
-	grain = io_size;
+	grain = cxt->io_size;
 
 	if (dos_compatible_flag)
 		sector_offset = sectors;	/* usually 63 sectors */
@@ -564,29 +496,29 @@ update_sector_offset(void)
 		 */
 		sector_t x = 0;
 
-		if (has_topology) {
-			if (alignment_offset)
-				x = alignment_offset;
-			else if (io_size > 2048 * 512)
-				x = io_size;
+		if (fdisk_dev_has_topology(cxt)) {
+			if (cxt->alignment_offset)
+				x = cxt->alignment_offset;
+			else if (cxt->io_size > 2048 * 512)
+				x = cxt->io_size;
 		}
 		/* default to 1MiB */
 		if (!x)
 			x = 2048 * 512;
 
-		sector_offset = x / sector_size;
+		sector_offset = x / cxt->sector_size;
 
 		/* don't use huge offset on small devices */
 		if (total_number_of_sectors <= sector_offset * 4)
-			sector_offset = phy_sector_size / sector_size;
+			sector_offset = cxt->phy_sector_size / cxt->sector_size;
 
 		/* use 1MiB grain always when possible */
 		if (grain < 2048 * 512)
 			grain = 2048 * 512;
 
 		/* don't use huge grain on small devices */
-		if (total_number_of_sectors <= (grain * 4 / sector_size))
-			grain = phy_sector_size;
+		if (total_number_of_sectors <= (grain * 4 / cxt->sector_size))
+			grain = cxt->phy_sector_size;
 	}
 }
 
@@ -595,7 +527,6 @@ get_geometry(struct fdisk_context *cxt, struct geom *g) {
 	sector_t llcyls, nsects = 0;
 	unsigned int kern_heads = 0, kern_sectors = 0;
 
-	get_topology(cxt);
 	heads = cylinders = sectors = 0;
 	pt_heads = pt_sectors = 0;
 
@@ -611,9 +542,9 @@ get_geometry(struct fdisk_context *cxt, struct geom *g) {
 
 	/* get number of 512-byte sectors, and convert it the real sectors */
 	if (blkdev_get_sectors(cxt->dev_fd, &nsects) == 0)
-		total_number_of_sectors = (nsects / (sector_size >> 9));
+		total_number_of_sectors = (nsects / (cxt->sector_size >> 9));
 
-	update_sector_offset();
+	update_sector_offset(cxt);
 
 	llcyls = total_number_of_sectors / (heads * sectors);
 	cylinders = llcyls;
@@ -676,7 +607,7 @@ static int get_boot(struct fdisk_context *cxt, int try_only) {
 
 	if (check_osf_label(cxt)) {
 		/* intialize partitions for BSD as well */
-		dos_init();
+		dos_init(cxt);
 		if (!valid_part_table_flag(MBRbuffer)) {
 			disklabel = OSF_LABEL;
 			return 0;
@@ -695,7 +626,7 @@ static int get_boot(struct fdisk_context *cxt, int try_only) {
 #ifdef __sparc__
 		create_sunlabel(cxt);
 #else
-		create_doslabel();
+		create_doslabel(cxt);
 #endif
 	}
 	return 0;
@@ -796,7 +727,8 @@ read_hex(struct systypes *sys)
 }
 
 unsigned int
-read_int_with_suffix(unsigned int low, unsigned int dflt, unsigned int high,
+read_int_with_suffix(struct fdisk_context *cxt,
+	unsigned int low, unsigned int dflt, unsigned int high,
 	 unsigned int base, char *mesg, int *is_suffix_used)
 {
 	unsigned int res;
@@ -895,7 +827,7 @@ read_int_with_suffix(unsigned int low, unsigned int dflt, unsigned int high,
 				unsigned long unit;
 
 				bytes = (unsigned long long) res * absolute;
-				unit = sector_size * units_per_sector;
+				unit = cxt->sector_size * units_per_sector;
 				bytes += unit/2;	/* round */
 				bytes /= unit;
 				res = bytes;
@@ -932,18 +864,19 @@ read_int_with_suffix(unsigned int low, unsigned int dflt, unsigned int high,
  * There is no default if DFLT is not between LOW and HIGH.
  */
 unsigned int
-read_int(unsigned int low, unsigned int dflt, unsigned int high,
+read_int(struct fdisk_context *cxt, 
+	 unsigned int low, unsigned int dflt, unsigned int high,
 	 unsigned int base, char *mesg)
 {
-	return read_int_with_suffix(low, dflt, high, base, mesg, NULL);
+	return read_int_with_suffix(cxt, low, dflt, high, base, mesg, NULL);
 }
 
 int
-get_partition_dflt(int warn, int max, int dflt) {
+get_partition_dflt(struct fdisk_context *cxt, int warn, int max, int dflt) {
 	struct pte *pe;
 	int i;
 
-	i = read_int(1, dflt, max, 0, _("Partition number")) - 1;
+	i = read_int(cxt, 1, dflt, max, 0, _("Partition number")) - 1;
 	pe = &ptes[i];
 
 	if (warn) {
@@ -961,14 +894,14 @@ get_partition_dflt(int warn, int max, int dflt) {
 }
 
 int
-get_partition(int warn, int max) {
-	return get_partition_dflt(warn, max, 0);
+get_partition(struct fdisk_context *cxt, int warn, int max) {
+	return get_partition_dflt(cxt, warn, max, 0);
 }
 
 /* User partition selection unless one partition only is available */
 
 static int
-get_existing_partition(int warn, int max) {
+get_existing_partition(struct fdisk_context *cxt, int warn, int max) {
 	int pno = -1;
 	int i;
 
@@ -995,7 +928,7 @@ get_existing_partition(int warn, int max) {
 
 not_implemented:
 not_unique:
-	return get_partition(warn, max);
+	return get_partition(cxt, warn, max);
 }
 
 const char *
@@ -1031,18 +964,18 @@ toggle_active(int i) {
 }
 
 static void
-toggle_dos_compatibility_flag(void) {
+toggle_dos_compatibility_flag(struct fdisk_context *cxt) {
 	dos_compatible_flag = ~dos_compatible_flag;
 	if (dos_compatible_flag)
 		printf(_("DOS Compatibility flag is set (DEPRECATED!)\n"));
 	else
 		printf(_("DOS Compatibility flag is not set\n"));
 
-	update_sector_offset();
+	update_sector_offset(cxt);
 }
 
 static void
-delete_partition(int i)
+delete_partition(struct fdisk_context *cxt, int i)
 {
 	if (i < 0)
 		return;
@@ -1057,18 +990,18 @@ delete_partition(int i)
 	else if (disklabel == SUN_LABEL)
 		sun_delete_partition(i);
 	else if (disklabel == SGI_LABEL)
-		sgi_delete_partition(i);
+		sgi_delete_partition(cxt, i);
 
 	printf(_("Partition %d is deleted\n"), i + 1);
 }
 
-static void
-change_sysid(void) {
+static void change_sysid(struct fdisk_context *cxt)
+{
 	char *temp;
 	int i, sys, origsys;
 	struct partition *p;
 
-	i = get_existing_partition(0, partitions);
+	i = get_existing_partition(cxt, 0, partitions);
 
 	if (i == -1)
 		return;
@@ -1204,16 +1137,16 @@ static void check_consistency(struct partition *p, int partition) {
 }
 
 static void
-check_alignment(sector_t lba, int partition)
+check_alignment(struct fdisk_context *cxt, sector_t lba, int partition)
 {
-	if (!lba_is_aligned(lba))
+	if (!lba_is_aligned(cxt, lba))
 		printf(_("Partition %i does not start on physical sector boundary.\n"),
 			partition + 1);
 }
 
 static void
 list_disk_geometry(struct fdisk_context *cxt) {
-	unsigned long long bytes = total_number_of_sectors * sector_size;
+	unsigned long long bytes = total_number_of_sectors * cxt->sector_size;
 	long megabytes = bytes/1000000;
 
 	if (megabytes < 10000)
@@ -1229,16 +1162,16 @@ list_disk_geometry(struct fdisk_context *cxt) {
 	if (units_per_sector == 1)
 		printf(_(", total %llu sectors"), total_number_of_sectors);
 	printf("\n");
-	printf(_("Units = %s of %d * %d = %d bytes\n"),
+	printf(_("Units = %s of %d * %ld = %ld bytes\n"),
 	       str_units(PLURAL),
-	       units_per_sector, sector_size, units_per_sector * sector_size);
+	       units_per_sector, cxt->sector_size, units_per_sector * cxt->sector_size);
 
-	printf(_("Sector size (logical/physical): %u bytes / %lu bytes\n"),
-				sector_size, phy_sector_size);
+	printf(_("Sector size (logical/physical): %lu bytes / %lu bytes\n"),
+				cxt->sector_size, cxt->phy_sector_size);
 	printf(_("I/O size (minimum/optimal): %lu bytes / %lu bytes\n"),
-				min_io_size, io_size);
-	if (alignment_offset)
-		printf(_("Alignment offset: %lu bytes\n"), alignment_offset);
+				cxt->min_io_size, cxt->io_size);
+	if (cxt->alignment_offset)
+		printf(_("Alignment offset: %lu bytes\n"), cxt->alignment_offset);
 	if (disklabel == DOS_LABEL)
 		dos_print_mbr_id();
 	printf("\n");
@@ -1428,12 +1361,12 @@ list_table(struct fdisk_context *cxt, int xtra) {
 			unsigned int pblocks = psects;
 			unsigned int podd = 0;
 
-			if (sector_size < 1024) {
-				pblocks /= (1024 / sector_size);
-				podd = psects % (1024 / sector_size);
+			if (cxt->sector_size < 1024) {
+				pblocks /= (1024 / cxt->sector_size);
+				podd = psects % (1024 / cxt->sector_size);
 			}
-			if (sector_size > 1024)
-				pblocks *= (sector_size / 1024);
+			if (cxt->sector_size > 1024)
+				pblocks *= (cxt->sector_size / 1024);
                         printf(
 			    "%s  %c %11lu %11lu %11lu%c  %2x  %s\n",
 			partname(cxt->dev_path, i+1, w+2),
@@ -1447,7 +1380,7 @@ list_table(struct fdisk_context *cxt, int xtra) {
 /* type name */		(type = partition_type(p->sys_ind)) ?
 			type : _("Unknown"));
 			check_consistency(p, i);
-			check_alignment(get_partition_start(pe), i);
+			check_alignment(cxt, get_partition_start(pe), i);
 		}
 	}
 
@@ -1482,7 +1415,7 @@ x_list_table(struct fdisk_context *cxt, int extend) {
 				(unsigned long) get_nr_sects(p), p->sys_ind);
 			if (p->sys_ind) {
 				check_consistency(p, i);
-				check_alignment(get_partition_start(pe), i);
+				check_alignment(cxt, get_partition_start(pe), i);
 			}
 		}
 	}
@@ -1533,7 +1466,7 @@ check(int n, unsigned int h, unsigned int s, unsigned int c,
 }
 
 static void
-verify(void) {
+verify(struct fdisk_context *cxt) {
 	int i, j;
 	sector_t total = 1, n_sectors = total_number_of_sectors;
 	unsigned long long first[partitions], last[partitions];
@@ -1559,7 +1492,7 @@ verify(void) {
 		p = pe->part_table;
 		if (p->sys_ind && !IS_EXTENDED (p->sys_ind)) {
 			check_consistency(p, i);
-			check_alignment(get_partition_start(pe), i);
+			check_alignment(cxt, get_partition_start(pe), i);
 			if (get_partition_start(pe) < first[i])
 				printf(_("Warning: bad start-of-data in "
 					"partition %d\n"), i + 1);
@@ -1603,30 +1536,31 @@ verify(void) {
 		printf(_("Total allocated sectors %llu greater than the maximum"
 			" %llu\n"), total, n_sectors);
 	else if (total < n_sectors)
-		printf(_("Remaining %lld unallocated %d-byte sectors\n"),
-		       n_sectors - total, sector_size);
+		printf(_("Remaining %lld unallocated %ld-byte sectors\n"),
+		       n_sectors - total, cxt->sector_size);
 }
 
-void print_partition_size(int num, sector_t start, sector_t stop, int sysid)
+void print_partition_size(struct fdisk_context *cxt,
+			  int num, sector_t start, sector_t stop, int sysid)
 {
 	char *str = size_to_human_string(SIZE_SUFFIX_3LETTER | SIZE_SUFFIX_SPACE,
-				     (stop - start + 1) * sector_size);
+				     (stop - start + 1) * cxt->sector_size);
 	printf(_("Partition %d of type %s and of size %s is set\n"), num, partition_type(sysid), str);
 	free(str);
 }
 
-static void new_partition(void)
+static void new_partition(struct fdisk_context *cxt)
 {
 	if (warn_geometry())
 		return;
 
 	if (disklabel == SUN_LABEL) {
-		add_sun_partition(get_partition(0, partitions), LINUX_NATIVE);
+		add_sun_partition(cxt, get_partition(cxt, 0, partitions), LINUX_NATIVE);
 		return;
 	}
 
 	if (disklabel == SGI_LABEL) {
-		sgi_add_partition(get_partition(0, partitions), LINUX_NATIVE);
+		sgi_add_partition(cxt, get_partition(cxt, 0, partitions), LINUX_NATIVE);
 		return;
 	}
 
@@ -1649,7 +1583,7 @@ static void new_partition(void)
 	}
 
 	/* default to DOS/BSD */
-	dos_new_partition();
+	dos_new_partition(cxt);
 }
 
 static void
@@ -1719,10 +1653,10 @@ reread_partition_table(struct fdisk_context *cxt, int leave) {
 
 #define MAX_PER_LINE	16
 static void
-print_buffer(unsigned char pbuffer[]) {
+print_buffer(struct fdisk_context *cxt, unsigned char pbuffer[]) {
 	unsigned int i, l;
 
-	for (i = 0, l = 0; i < sector_size; i++, l++) {
+	for (i = 0, l = 0; i < cxt->sector_size; i++, l++) {
 		if (l == 0)
 			printf("0x%03X:", i);
 		printf(" %02X", pbuffer[i]);
@@ -1736,19 +1670,19 @@ print_buffer(unsigned char pbuffer[]) {
 	printf("\n");
 }
 
-static void
-print_raw(char *dev) {
+static void print_raw(struct fdisk_context *cxt)
+{
 	int i;
 
-	printf(_("Device: %s\n"), dev);
+	printf(_("Device: %s\n"), cxt->dev_path);
 	if (disklabel == SUN_LABEL || disklabel == SGI_LABEL)
-		print_buffer(MBRbuffer);
+		print_buffer(cxt, MBRbuffer);
 	else for (i = 3; i < partitions; i++)
-		print_buffer(ptes[i].sectorbuffer);
+		     print_buffer(cxt, ptes[i].sectorbuffer);
 }
 
 static void
-move_begin(int i) {
+move_begin(struct fdisk_context *cxt, int i) {
 	struct pte *pe = &ptes[i];
 	struct partition *p = pe->part_table;
 	unsigned int new, free_start, curr_start, last;
@@ -1785,7 +1719,7 @@ move_begin(int i) {
 
 	last = get_partition_start(pe) + get_nr_sects(p) - 1;
 
-	new = read_int(free_start, curr_start, last, free_start,
+	new = read_int(cxt, free_start, curr_start, last, free_start,
 		       _("New beginning of data")) - pe->offset;
 
 	if (new != get_nr_sects(p)) {
@@ -1814,27 +1748,27 @@ expert_command_prompt(struct fdisk_context *cxt)
 		switch (c) {
 		case 'a':
 			if (disklabel == SUN_LABEL)
-				sun_set_alt_cyl();
+				sun_set_alt_cyl(cxt);
 			break;
 		case 'b':
 			if (disklabel == DOS_LABEL)
-				move_begin(get_partition(0, partitions));
+				move_begin(cxt, get_partition(cxt, 0, partitions));
 			break;
 		case 'c':
 			user_cylinders = cylinders =
-				read_int(1, cylinders, 1048576, 0,
+				read_int(cxt, 1, cylinders, 1048576, 0,
 					 _("Number of cylinders"));
 			if (disklabel == SUN_LABEL)
 				sun_set_ncyl(cylinders);
 			break;
 		case 'd':
-			print_raw(cxt->dev_path);
+			print_raw(cxt);
 			break;
 		case 'e':
 			if (disklabel == SGI_LABEL)
 				sgi_set_xcyl();
 			else if (disklabel == SUN_LABEL)
-				sun_set_xcyl();
+				sun_set_xcyl(cxt);
 			else
 			if (disklabel == DOS_LABEL)
 				x_list_table(cxt, 1);
@@ -1847,19 +1781,19 @@ expert_command_prompt(struct fdisk_context *cxt)
 			create_sgilabel(cxt);
 			break;
 		case 'h':
-			user_heads = heads = read_int(1, heads, 256, 0,
+			user_heads = heads = read_int(cxt, 1, heads, 256, 0,
 					 _("Number of heads"));
 			update_units();
 			break;
 		case 'i':
 			if (disklabel == SUN_LABEL)
-				sun_set_ilfact();
+				sun_set_ilfact(cxt);
 			else if (disklabel == DOS_LABEL)
 				dos_set_mbr_id();
 			break;
 		case 'o':
 			if (disklabel == SUN_LABEL)
-				sun_set_rspeed();
+				sun_set_rspeed(cxt);
 			break;
 		case 'p':
 			if (disklabel == SUN_LABEL)
@@ -1872,24 +1806,24 @@ expert_command_prompt(struct fdisk_context *cxt)
 		case 'r':
 			return;
 		case 's':
-			user_sectors = sectors = read_int(1, sectors, 63, 0,
+			user_sectors = sectors = read_int(cxt, 1, sectors, 63, 0,
 					   _("Number of sectors"));
 			if (dos_compatible_flag)
 				fprintf(stderr, _("Warning: setting "
 					"sector offset for DOS "
 					"compatiblity\n"));
-			update_sector_offset();
+			update_sector_offset(cxt);
 			update_units();
 			break;
 		case 'v':
-			verify();
+			verify(cxt);
 			break;
 		case 'w':
 			write_table(cxt);
 			break;
 		case 'y':
 			if (disklabel == SUN_LABEL)
-				sun_set_pcylcount();
+				sun_set_pcylcount(cxt);
 			break;
 		default:
 			print_menu(EXPERT_MENU);
@@ -1918,15 +1852,15 @@ gpt_warning(char *dev)
 }
 
 /* Print disk geometry and partition table of a specified device (-l option) */
-
-static void
-print_partition_table_from_option(char *device)
+static void print_partition_table_from_option(char *device, unsigned long sector_size)
 {
 	int gb;
 
 	struct fdisk_context *cxt = fdisk_new_context_from_filename(device, 1);	/* read-only */
 	if (!cxt)
 		err(EXIT_FAILURE, _("unable to open %s"), device);
+	if (sector_size)  /* passed -b option, override autodiscovery */
+		cxt->phy_sector_size = cxt->sector_size = sector_size;
 
 	gpt_warning(device);
 	gb = get_boot(cxt, 1);
@@ -1946,7 +1880,7 @@ print_partition_table_from_option(char *device)
  * try all things in /proc/partitions that look like a full disk
  */
 static void
-print_all_partition_table_from_option(void)
+print_all_partition_table_from_option(unsigned long sector_size)
 {
 	FILE *procpt;
 	char line[128], ptname[128], devname[256];
@@ -1968,7 +1902,7 @@ print_all_partition_table_from_option(void)
 			char *cn = canonicalize_path(devname);
 			if (cn) {
 				if (!is_ide_cdrom_or_tape(cn))
-					print_partition_table_from_option(cn);
+					print_partition_table_from_option(cn, sector_size);
 				free(cn);
 			}
 		}
@@ -2011,13 +1945,13 @@ static void command_prompt(struct fdisk_context *cxt)
 		switch (c) {
 		case 'a':
 			if (disklabel == DOS_LABEL)
-				toggle_active(get_partition(1, partitions));
+				toggle_active(get_partition(cxt, 1, partitions));
 			else if (disklabel == SUN_LABEL)
-				toggle_sunflags(get_partition(1, partitions),
+				toggle_sunflags(get_partition(cxt, 1, partitions),
 						SUN_FLAG_UNMNT);
 			else if (disklabel == SGI_LABEL)
 				sgi_set_bootpartition(
-					get_partition(1, partitions));
+					get_partition(cxt, 1, partitions));
 			else
 				unknown_command(c);
 			break;
@@ -2033,18 +1967,18 @@ static void command_prompt(struct fdisk_context *cxt)
 			break;
 		case 'c':
 			if (disklabel == DOS_LABEL)
-				toggle_dos_compatibility_flag();
+				toggle_dos_compatibility_flag(cxt);
 			else if (disklabel == SUN_LABEL)
-				toggle_sunflags(get_partition(1, partitions),
+				toggle_sunflags(get_partition(cxt, 1, partitions),
 						SUN_FLAG_RONLY);
 			else if (disklabel == SGI_LABEL)
 				sgi_set_swappartition(
-						get_partition(1, partitions));
+					get_partition(cxt, 1, partitions));
 			else
 				unknown_command(c);
 			break;
 		case 'd':
-			delete_partition(get_existing_partition(1, partitions));
+			delete_partition(cxt, get_existing_partition(cxt, 1, partitions));
 			break;
 		case 'i':
 			if (disklabel == SGI_LABEL)
@@ -2059,10 +1993,10 @@ static void command_prompt(struct fdisk_context *cxt)
 			print_menu(MAIN_MENU);
 			break;
 		case 'n':
-			new_partition();
+			new_partition(cxt);
 			break;
 		case 'o':
-			create_doslabel();
+			create_doslabel(cxt);
 			break;
 		case 'p':
 			list_table(cxt, 0);
@@ -2073,13 +2007,13 @@ static void command_prompt(struct fdisk_context *cxt)
 			create_sunlabel(cxt);
 			break;
 		case 't':
-			change_sysid();
+			change_sysid(cxt);
 			break;
 		case 'u':
 			change_units();
 			break;
 		case 'v':
-			verify();
+			verify(cxt);
 			break;
 		case 'w':
 			write_table(cxt);
@@ -2112,6 +2046,7 @@ static sector_t get_dev_blocks(char *dev)
 int main(int argc, char **argv)
 {
 	int c, optl = 0, opts = 0;
+	unsigned long sector_size = 0;
 	struct fdisk_context *cxt = NULL;
 
 	setlocale(LC_ALL, "");
@@ -2191,9 +2126,9 @@ int main(int argc, char **argv)
 		if (argc > optind) {
 			int k;
 			for (k = optind; k < argc; k++)
-				print_partition_table_from_option(argv[k]);
+				print_partition_table_from_option(argv[k], sector_size);
 		} else
-			print_all_partition_table_from_option();
+			print_all_partition_table_from_option(sector_size);
 		exit(0);
 	}
 
@@ -2216,6 +2151,8 @@ int main(int argc, char **argv)
 		cxt = fdisk_new_context_from_filename(argv[optind], 0);
 		if (!cxt)
 			err(EXIT_FAILURE, _("unable to open %s"), argv[optind]);
+		if (user_set_sector_size) /* passed -b option, override autodiscovery */
+			cxt->phy_sector_size = cxt->sector_size = sector_size;
 	}
 	else
 		usage(stderr);
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index 31129e8..8fff6d8 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -105,9 +105,17 @@ typedef unsigned long long sector_t;
 struct fdisk_context {
 	int dev_fd;     /* device descriptor */
 	char *dev_path; /* device path */
+	
+	/* topology */
+	unsigned long io_size;
+	unsigned long min_io_size;
+	unsigned long phy_sector_size; /* physical size */
+	unsigned long sector_size; /* logical size */
+	unsigned long alignment_offset;
 };
 
 extern struct fdisk_context *fdisk_new_context_from_filename(const char *fname, int readonly);
+extern int fdisk_dev_has_topology(struct fdisk_context *cxt);
 extern void fdisk_free_context(struct fdisk_context *cxt);
 
 /* prototypes for fdisk.c */
@@ -117,7 +125,7 @@ extern unsigned int display_in_cyl_units, units_per_sector;
 extern void change_units(void);
 extern void fatal(struct fdisk_context *cxt, enum failure why);
 extern void get_geometry(struct fdisk_context *, struct geom *);
-extern int  get_partition(int warn, int max);
+extern int  get_partition(struct fdisk_context *cxt, int warn, int max);
 extern void list_types(struct systypes *sys);
 extern int read_line (int *asked);
 extern char read_char(char *mesg);
@@ -125,14 +133,15 @@ extern int read_hex(struct systypes *sys);
 extern void reread_partition_table(struct fdisk_context *cxt, int leave);
 extern struct partition *get_part_table(int);
 extern int valid_part_table_flag(unsigned char *b);
-extern unsigned int read_int(unsigned int low, unsigned int dflt,
+extern unsigned int read_int(struct fdisk_context *cxt,
+			     unsigned int low, unsigned int dflt,
 			     unsigned int high, unsigned int base, char *mesg);
 extern void print_menu(enum menutype);
-extern void print_partition_size(int num, sector_t start, sector_t stop, int sysid);
+extern void print_partition_size(struct fdisk_context *cxt, int num, sector_t start, sector_t stop, int sysid);
 
 extern void zeroize_mbr_buffer(void);
 extern void fill_bounds(sector_t *first, sector_t *last);
-extern unsigned int heads, cylinders, sector_size;
+extern unsigned int heads, cylinders;
 extern sector_t sectors;
 extern char *partition_type(unsigned char type);
 extern void update_units(void);
@@ -140,12 +149,13 @@ extern char read_chars(char *mesg);
 extern void set_changed(int);
 extern void set_all_unchanged(void);
 extern int warn_geometry(void);
-extern void warn_limits(void);
-extern void warn_alignment(void);
-extern unsigned int read_int_with_suffix(unsigned int low, unsigned int dflt, unsigned int high,
+extern void warn_limits(struct fdisk_context *cxt);
+extern void warn_alignment(struct fdisk_context *cxt);
+extern unsigned int read_int_with_suffix(struct fdisk_context *cxt,
+					 unsigned int low, unsigned int dflt, unsigned int high,
 				  unsigned int base, char *mesg, int *is_suffix_used);
-extern sector_t align_lba(sector_t lba, int direction);
-extern int get_partition_dflt(int warn, int max, int dflt);
+extern sector_t align_lba(struct fdisk_context *cxt, sector_t lba, int direction);
+extern int get_partition_dflt(struct fdisk_context *cxt, int warn, int max, int dflt);
 
 #define PLURAL	0
 #define SINGULAR 1
@@ -202,7 +212,7 @@ static inline void set_start_sect(struct partition *p, unsigned int start_sect)
 
 static inline void seek_sector(struct fdisk_context *cxt, sector_t secno)
 {
-	off_t offset = (off_t) secno * sector_size;
+	off_t offset = (off_t) secno * cxt->sector_size;
 	if (lseek(cxt->dev_fd, offset, SEEK_SET) == (off_t) -1)
 		fatal(cxt, unable_to_seek);
 }
@@ -210,14 +220,14 @@ static inline void seek_sector(struct fdisk_context *cxt, sector_t secno)
 static inline void read_sector(struct fdisk_context *cxt, sector_t secno, unsigned char *buf)
 {
 	seek_sector(cxt, secno);
-	if (read(cxt->dev_fd, buf, sector_size) != sector_size)
+	if (read(cxt->dev_fd, buf, cxt->sector_size) != cxt->sector_size)
 		fatal(cxt, unable_to_read);
 }
 
 static inline void write_sector(struct fdisk_context *cxt, sector_t secno, unsigned char *buf)
 {
 	seek_sector(cxt, secno);
-	if (write(cxt->dev_fd, buf, sector_size) != sector_size)
+	if (write(cxt->dev_fd, buf, cxt->sector_size) != cxt->sector_size)
 		fatal(cxt, unable_to_write);
 }
 
diff --git a/fdisk/fdiskbsdlabel.c b/fdisk/fdiskbsdlabel.c
index 156483a..370cefb 100644
--- a/fdisk/fdiskbsdlabel.c
+++ b/fdisk/fdiskbsdlabel.c
@@ -62,7 +62,7 @@
 #include "fdiskbsdlabel.h"
 
 static void xbsd_delete_part (void);
-static void xbsd_new_part (void);
+static void xbsd_new_part (struct fdisk_context *cxt);
 static void xbsd_write_disklabel (struct fdisk_context *cxt);
 static int xbsd_create_disklabel (struct fdisk_context *cxt);
 static void xbsd_edit_disklabel (void);
@@ -86,7 +86,7 @@ void alpha_bootblock_checksum (char *boot);
 
 #if !defined (__alpha__)
 static int xbsd_translate_fstype (int linux_type);
-static void xbsd_link_part (void);
+static void xbsd_link_part (struct fdisk_context *cxt);
 static struct partition *xbsd_part;
 static int xbsd_part_index;
 #endif
@@ -196,7 +196,7 @@ bsd_command_prompt (struct fdisk_context *cxt)
 	xbsd_list_types ();
 	break;
       case 'n':
-	xbsd_new_part ();
+	xbsd_new_part (cxt);
 	break;
       case 'p':
 	      xbsd_print_disklabel (cxt, 0);
@@ -220,7 +220,7 @@ bsd_command_prompt (struct fdisk_context *cxt)
 	break;
 #if !defined (__alpha__)
       case 'x':
-	xbsd_link_part ();
+	xbsd_link_part (cxt);
 	break;
 #endif
       default:
@@ -245,7 +245,7 @@ xbsd_delete_part (void)
 }
 
 static void
-xbsd_new_part (void)
+xbsd_new_part (struct fdisk_context *cxt)
 {
   unsigned int begin, end;
   char mesg[256];
@@ -263,7 +263,7 @@ xbsd_new_part (void)
 #endif
 
   snprintf (mesg, sizeof(mesg), _("First %s"), str_units(SINGULAR));
-  begin = read_int (bsd_cround (begin), bsd_cround (begin), bsd_cround (end),
+  begin = read_int (cxt, bsd_cround (begin), bsd_cround (begin), bsd_cround (end),
 		    0, mesg);
 
   if (display_in_cyl_units)
@@ -271,7 +271,7 @@ xbsd_new_part (void)
 
   snprintf (mesg, sizeof(mesg), _("Last %s or +size or +sizeM or +sizeK"),
 	   str_units(SINGULAR));
-  end = read_int (bsd_cround (begin), bsd_cround (end), bsd_cround (end),
+  end = read_int (cxt, bsd_cround (begin), bsd_cround (end), bsd_cround (end),
 		  bsd_cround (begin), mesg);
 
   if (display_in_cyl_units)
@@ -810,12 +810,12 @@ xbsd_translate_fstype (int linux_type)
 }
 
 static void
-xbsd_link_part (void)
+xbsd_link_part (struct fdisk_context *cxt)
 {
   int k, i;
   struct partition *p;
 
-  k = get_partition (1, partitions);
+  k = get_partition (cxt, 1, partitions);
 
   if (!xbsd_check_new_partition (&i))
     return;
diff --git a/fdisk/fdiskdoslabel.c b/fdisk/fdiskdoslabel.c
index 382909c..a187d77 100644
--- a/fdisk/fdiskdoslabel.c
+++ b/fdisk/fdiskdoslabel.c
@@ -22,13 +22,13 @@
 		s |= (sector >> 2) & 0xc0;			\
 	}
 
-#define alignment_required	(grain != sector_size)
+#define alignment_required	(grain != cxt->sector_size)
 
 struct pte ptes[MAXIMUM_PARTS];
 sector_t extended_offset;
 int ext_index;
 
-static int get_nonexisting_partition(int warn, int max)
+static int get_nonexisting_partition(struct fdisk_context *cxt, int warn, int max)
 {
 	int pno = -1;
 	int i;
@@ -54,7 +54,7 @@ static int get_nonexisting_partition(int warn, int max)
 	return -1;
 
  not_unique:
-	return get_partition_dflt(warn, max, dflt);
+	return get_partition_dflt(cxt, warn, max, dflt);
 }
 

@@ -64,7 +64,7 @@ static void read_pte(struct fdisk_context *cxt, int pno, sector_t offset)
 	struct pte *pe = &ptes[pno];
 
 	pe->offset = offset;
-	pe->sectorbuffer = xmalloc(sector_size);
+	pe->sectorbuffer = xmalloc(cxt->sector_size);
 	read_sector(cxt, offset, pe->sectorbuffer);
 	pe->changed = 0;
 	pe->part_table = pe->ext_pointer = NULL;
@@ -96,7 +96,7 @@ static void clear_partition(struct partition *p)
 	set_nr_sects(p,0);
 }
 
-void dos_init(void)
+void dos_init(struct fdisk_context *cxt)
 {
 	int i;
 
@@ -116,8 +116,8 @@ void dos_init(void)
 	}
 
 	warn_geometry();
-	warn_limits();
-	warn_alignment();
+	warn_limits(cxt);
+	warn_alignment(cxt);
 }
 
 static void read_extended(struct fdisk_context *cxt, int ext)
@@ -219,7 +219,7 @@ void dos_print_mbr_id(void)
 	printf(_("Disk identifier: 0x%08x\n"), dos_read_mbr_id(MBRbuffer));
 }
 
-void create_doslabel(void)
+void create_doslabel(struct fdisk_context *cxt)
 {
 	unsigned int id;
 
@@ -228,7 +228,7 @@ void create_doslabel(void)
 
 	fprintf(stderr, _("Building a new DOS disklabel with disk identifier 0x%08x.\n"), id);
 
-	dos_init();
+	dos_init(cxt);
 	zeroize_mbr_buffer();
 
 	set_all_unchanged();
@@ -324,7 +324,7 @@ int check_dos_label(struct fdisk_context *cxt)
 	if (!valid_part_table_flag(MBRbuffer))
 		return 0;
 
-	dos_init();
+	dos_init(cxt);
 
 	for (i = 0; i < 4; i++) {
 		struct pte *pe = &ptes[i];
@@ -368,7 +368,8 @@ int is_dos_partition(int t)
 		t == 0xc1 || t == 0xc4 || t == 0xc6);
 }
 
-static void set_partition(int i, int doext, sector_t start,
+static void set_partition(struct fdisk_context *cxt,
+			  int i, int doext, sector_t start,
 			  sector_t stop, int sysid)
 {
 	struct partition *p;
@@ -387,7 +388,7 @@ static void set_partition(int i, int doext, sector_t start,
 	set_nr_sects(p, stop - start + 1);
 
 	if (!doext)
-		print_partition_size(i + 1, start, stop, sysid);
+		print_partition_size(cxt, i + 1, start, stop, sysid);
 
 	if (dos_compatible_flag && (start/(sectors*heads) > 1023))
 		start = heads*sectors*1024 - 1;
@@ -416,12 +417,13 @@ static sector_t get_unused_start(int part_n, sector_t start,
 	return start;
 }
 
-static sector_t align_lba_in_range(sector_t lba, sector_t start, sector_t stop)
+static sector_t align_lba_in_range(struct fdisk_context *cxt,
+				   sector_t lba, sector_t start, sector_t stop)
 {
-	start = align_lba(start, ALIGN_UP);
-	stop = align_lba(stop, ALIGN_DOWN);
+	start = align_lba(cxt, start, ALIGN_UP);
+	stop = align_lba(cxt, stop, ALIGN_DOWN);
 
-	lba = align_lba(lba, ALIGN_NEAREST);
+	lba = align_lba(cxt, lba, ALIGN_NEAREST);
 
 	if (lba < start)
 		return start;
@@ -430,7 +432,7 @@ static sector_t align_lba_in_range(sector_t lba, sector_t start, sector_t stop)
 	return lba;
 }
 
-void dos_add_partition(int n, int sys)
+void dos_add_partition(struct fdisk_context *cxt, int n, int sys)
 {
 	char mesg[256];		/* 48 does not suffice in Japanese */
 	int i, read = 0;
@@ -477,7 +479,7 @@ void dos_add_partition(int n, int sys)
 
 		/* the default sector should be aligned and unused */
 		do {
-			aligned = align_lba_in_range(dflt, dflt, limit);
+			aligned = align_lba_in_range(cxt, dflt, dflt, limit);
 			dflt = get_unused_start(n, aligned, first, last);
 		} while (dflt != aligned && dflt > aligned && dflt < limit);
 
@@ -493,7 +495,7 @@ void dos_add_partition(int n, int sys)
 		if (!read && start == temp) {
 			sector_t i = start;
 
-			start = read_int(cround(i), cround(dflt), cround(limit),
+			start = read_int(cxt, cround(i), cround(dflt), cround(limit),
 					 0, mesg);
 			if (display_in_cyl_units) {
 				start = (start - 1) * units_per_sector;
@@ -536,8 +538,9 @@ void dos_add_partition(int n, int sys)
 			_("Last %1$s, +%2$s or +size{K,M,G}"),
 			 str_units(SINGULAR), str_units(PLURAL));
 
-		stop = read_int_with_suffix(cround(start), cround(limit), cround(limit),
-				cround(start), mesg, &is_suffix_used);
+		stop = read_int_with_suffix(cxt, 
+					    cround(start), cround(limit), cround(limit),
+					    cround(start), mesg, &is_suffix_used);
 		if (display_in_cyl_units) {
 			stop = stop * units_per_sector - 1;
 			if (stop >limit)
@@ -550,15 +553,15 @@ void dos_add_partition(int n, int sys)
 			 * and align the end of the partition. The next
 			 * partition will start at phy.block boundary.
 			 */
-			stop = align_lba_in_range(stop, start, limit) - 1;
+			stop = align_lba_in_range(cxt, stop, start, limit) - 1;
 			if (stop > limit)
 				stop = limit;
 		}
 	}
 
-	set_partition(n, 0, start, stop, sys);
+	set_partition(cxt, n, 0, start, stop, sys);
 	if (n > 4)
-		set_partition(n - 1, 1, ptes[n].offset, stop, EXTENDED);
+		set_partition(cxt, n - 1, 1, ptes[n].offset, stop, EXTENDED);
 
 	if (IS_EXTENDED (sys)) {
 		struct pte *pe4 = &ptes[4];
@@ -567,7 +570,7 @@ void dos_add_partition(int n, int sys)
 		ext_index = n;
 		pen->ext_pointer = p;
 		pe4->offset = extended_offset = start;
-		pe4->sectorbuffer = xcalloc(1, sector_size);
+		pe4->sectorbuffer = xcalloc(1, cxt->sector_size);
 		pe4->part_table = pt_offset(pe4->sectorbuffer, 0);
 		pe4->ext_pointer = pe4->part_table + 1;
 		pe4->changed = 1;
@@ -575,12 +578,12 @@ void dos_add_partition(int n, int sys)
 	}
 }
 
-static void add_logical(void)
+static void add_logical(struct fdisk_context *cxt)
 {
 	if (partitions > 5 || ptes[4].part_table->sys_ind) {
 		struct pte *pe = &ptes[partitions];
 
-		pe->sectorbuffer = xcalloc(1, sector_size);
+		pe->sectorbuffer = xcalloc(1, cxt->sector_size);
 		pe->part_table = pt_offset(pe->sectorbuffer, 0);
 		pe->ext_pointer = pe->part_table + 1;
 		pe->offset = 0;
@@ -588,14 +591,14 @@ static void add_logical(void)
 		partitions++;
 	}
 	printf(_("Adding logical partition %d\n"), partitions);
-	dos_add_partition(partitions - 1, LINUX_NATIVE);
+	dos_add_partition(cxt, partitions - 1, LINUX_NATIVE);
 }
 
 /*
  * Ask the user for new partition type information (logical, extended).
  * This function calls the actual partition adding logic - dos_add_partition.
  */
-void dos_new_partition(void)
+void dos_new_partition(struct fdisk_context *cxt)
 {
 	int i, free_primary = 0;
 
@@ -610,14 +613,14 @@ void dos_new_partition(void)
 	if (!free_primary) {
 		if (extended_offset) {
 			printf(_("All primary partitions are in use\n"));
-			add_logical();
+			add_logical(cxt);
 		} else
 			printf(_("If you want to create more than four partitions, you must replace a\n"
 				 "primary partition with an extended partition first.\n"));
 	} else if (partitions >= MAXIMUM_PARTS) {
 		printf(_("All logical partitions are in use\n"));
 		printf(_("Adding a primary partition\n"));
-		dos_add_partition(get_partition(0, 4), LINUX_NATIVE);
+		dos_add_partition(cxt, get_partition(cxt, 0, 4), LINUX_NATIVE);
 	} else {
 		char c, dflt, line[LINE_LENGTH];
 
@@ -637,17 +640,17 @@ void dos_new_partition(void)
 			printf(_("Using default response %c\n"), c);
 		}
 		if (c == 'p') {
-			int i = get_nonexisting_partition(0, 4);
+			int i = get_nonexisting_partition(cxt, 0, 4);
 			if (i >= 0)
-				dos_add_partition(i, LINUX_NATIVE);
+				dos_add_partition(cxt, i, LINUX_NATIVE);
 			return;
 		} else if (c == 'l' && extended_offset) {
-			add_logical();
+			add_logical(cxt);
 			return;
 		} else if (c == 'e' && !extended_offset) {
-			int i = get_nonexisting_partition(0, 4);
+			int i = get_nonexisting_partition(cxt, 0, 4);
 			if (i >= 0)
-				dos_add_partition(i, EXTENDED);
+				dos_add_partition(cxt, i, EXTENDED);
 			return;
 		} else
 			printf(_("Invalid partition type `%c'\n"), c);
diff --git a/fdisk/fdiskdoslabel.h b/fdisk/fdiskdoslabel.h
index a436e53..8d62d52 100644
--- a/fdisk/fdiskdoslabel.h
+++ b/fdisk/fdiskdoslabel.h
@@ -43,15 +43,15 @@ static inline sector_t get_partition_start(struct pte *pe)
 	return pe->offset + get_start_sect(pe->part_table);
 }
 
-extern void create_doslabel(void);
+extern void create_doslabel(struct fdisk_context *cxt);
 extern void dos_print_mbr_id(void);
 extern void dos_set_mbr_id(void);
 extern void dos_delete_partition(int i);
 extern int check_dos_label(struct fdisk_context *cxt);
 extern int is_dos_partition(int t);
-extern void dos_init(void);
-extern void dos_add_partition(int n, int sys);
-extern void dos_new_partition(void);
+extern void dos_init(struct fdisk_context *cxt);
+extern void dos_add_partition(struct fdisk_context *cxt, int n, int sys);
+extern void dos_new_partition(struct fdisk_context *cxt);
 extern void dos_write_table(struct fdisk_context *cxt);
 
 #endif
diff --git a/fdisk/fdisksgilabel.c b/fdisk/fdisksgilabel.c
index 14e3443..9c425b3 100644
--- a/fdisk/fdisksgilabel.c
+++ b/fdisk/fdisksgilabel.c
@@ -190,20 +190,20 @@ sgi_list_table(struct fdisk_context *cxt, int xtra) {
 			 "%d cylinders, %d physical cylinders\n"
 			 "%d extra sects/cyl, interleave %d:1\n"
 			 "%s\n"
-			 "Units = %s of %d * %d bytes\n\n"),
+			 "Units = %s of %d * %ld bytes\n\n"),
 		       cxt->dev_path, heads, sectors, cylinders,
 		       SSWAP16(sgiparam.pcylcount),
 		       (int) sgiparam.sparecyl, SSWAP16(sgiparam.ilfact),
 		       (char *)sgilabel,
 		       str_units(PLURAL), units_per_sector,
-                       sector_size);
+                       cxt->sector_size);
 	} else {
 		printf(_("\nDisk %s (SGI disk label): "
 			 "%d heads, %llu sectors, %d cylinders\n"
-			 "Units = %s of %d * %d bytes\n\n"),
+			 "Units = %s of %d * %ld bytes\n\n"),
 		       cxt->dev_path, heads, sectors, cylinders,
 		       str_units(PLURAL), units_per_sector,
-                       sector_size);
+                       cxt->sector_size);
 	}
 	printf(_("----- partitions -----\n"
 		 "Pt# %*s  Info     Start       End   Sectors  Id  System\n"),
@@ -563,7 +563,8 @@ sgi_entire(void) {
 }
 
 static void
-sgi_set_partition(int i, unsigned int start, unsigned int length, int sys) {
+sgi_set_partition(struct fdisk_context *cxt,
+		  int i, unsigned int start, unsigned int length, int sys) {
 	sgilabel->partitions[i].id = SSWAP32(sys);
 	sgilabel->partitions[i].num_sectors = SSWAP32(length);
 	sgilabel->partitions[i].start_sector = SSWAP32(start);
@@ -571,16 +572,16 @@ sgi_set_partition(int i, unsigned int start, unsigned int length, int sys) {
 	if (sgi_gaps() < 0)	/* rebuild freelist */
 		printf(_("Partition overlap on the disk.\n"));
 	if (length)
-		print_partition_size(i + 1, start, start + length, sys);
+		print_partition_size(cxt, i + 1, start, start + length, sys);
 }
 
 static void
-sgi_set_entire(void) {
+sgi_set_entire(struct fdisk_context *cxt) {
 	int n;
 
 	for (n=10; n<partitions; n++) {
 		if (!sgi_get_num_sectors(n)) {
-			sgi_set_partition(n, 0, sgi_get_lastblock(), SGI_VOLUME);
+			sgi_set_partition(cxt, n, 0, sgi_get_lastblock(), SGI_VOLUME);
 			break;
 		}
 	}
@@ -588,7 +589,7 @@ sgi_set_entire(void) {
 
 static
 void
-sgi_set_volhdr(void)
+sgi_set_volhdr(struct fdisk_context *cxt)
 {
 	int n;
 
@@ -599,20 +600,20 @@ sgi_set_volhdr(void)
 			 * as IRIX fx uses.
 			 */
 			if (4096 < sgi_get_lastblock())
-				sgi_set_partition(n, 0, 4096, SGI_VOLHDR);
+				sgi_set_partition(cxt, n, 0, 4096, SGI_VOLHDR);
 			break;
 		}
 	}
 }
 
 void
-sgi_delete_partition(int i)
+sgi_delete_partition(struct fdisk_context *cxt, int i)
 {
-	sgi_set_partition(i, 0, 0, 0);
+	sgi_set_partition(cxt, i, 0, 0, 0);
 }
 
 void
-sgi_add_partition(int n, int sys)
+sgi_add_partition(struct fdisk_context *cxt, int n, int sys)
 {
 	char mesg[256];
 	unsigned int first=0, last=0;
@@ -630,8 +631,8 @@ sgi_add_partition(int n, int sys)
 	if ((sgi_entire() == -1)
 	    &&  (sys != SGI_VOLUME)) {
 		printf(_("Attempting to generate entire disk entry automatically.\n"));
-		sgi_set_entire();
-		sgi_set_volhdr();
+		sgi_set_entire(cxt);
+		sgi_set_volhdr(cxt);
 	}
 	if ((sgi_gaps() == 0) &&  (sys != SGI_VOLUME)) {
 		printf(_("The entire disk is already covered with partitions.\n"));
@@ -645,7 +646,7 @@ sgi_add_partition(int n, int sys)
 	for (;;) {
 		if (sys == SGI_VOLUME) {
 			last = sgi_get_lastblock();
-			first = read_int(0, 0, last-1, 0, mesg);
+			first = read_int(cxt, 0, 0, last-1, 0, mesg);
 			if (first != 0) {
 				printf(_("It is highly recommended that eleventh partition\n"
 					 "covers the entire disk and is of type `SGI volume'\n"));
@@ -653,7 +654,7 @@ sgi_add_partition(int n, int sys)
 		} else {
 			first = freelist[0].first;
 			last  = freelist[0].last;
-			first = read_int(scround(first), scround(first), scround(last)-1,
+			first = read_int(cxt, scround(first), scround(first), scround(last)-1,
 					 0, mesg);
 		}
 		if (display_in_cyl_units)
@@ -669,7 +670,7 @@ sgi_add_partition(int n, int sys)
 			break;
 	}
 	snprintf(mesg, sizeof(mesg), _(" Last %s"), str_units(SINGULAR));
-	last = read_int(scround(first), scround(last)-1, scround(last)-1,
+	last = read_int(cxt, scround(first), scround(last)-1, scround(last)-1,
 			scround(first), mesg)+1;
 	if (display_in_cyl_units)
 		last *= units_per_sector;                                     
@@ -678,7 +679,7 @@ sgi_add_partition(int n, int sys)
 	if ((sys == SGI_VOLUME) && (first != 0 || last != sgi_get_lastblock()))
 		printf(_("It is highly recommended that eleventh partition\n"
 			 "covers the entire disk and is of type `SGI volume'\n"));
-	sgi_set_partition(n, first, last-first, sys);
+	sgi_set_partition(cxt, n, first, last-first, sys);
 }
 
 void
@@ -695,7 +696,7 @@ create_sgilabel(struct fdisk_context *cxt)
 	int res; 		/* the result from the ioctl */
 	int sec_fac; 		/* the sector factor */
 
-	sec_fac = sector_size / 512;	/* determine the sector factor */
+	sec_fac = cxt->sector_size / 512;	/* determine the sector factor */
 
 	fprintf(stderr,
 		_("Building a new SGI disklabel.\n"));
@@ -769,7 +770,7 @@ create_sgilabel(struct fdisk_context *cxt)
 	sgilabel->devparam.unused1			= SSWAP16(0);
 	sgilabel->devparam.nsect			= SSWAP16(geometry.sectors);
 	/* sectors/track */
-	sgilabel->devparam.bytes			= SSWAP16(sector_size);
+	sgilabel->devparam.bytes			= SSWAP16(cxt->sector_size);
 	sgilabel->devparam.ilfact			= SSWAP16(1);
 	sgilabel->devparam.flags			= SSWAP32(TRACK_FWD|\
 								  IGNORE_ERRORS|RESEEK);
@@ -787,11 +788,11 @@ create_sgilabel(struct fdisk_context *cxt)
 	disklabel  = SGI_LABEL;
 	partitions = 16;
 	volumes    = 15;
-	sgi_set_entire();
-	sgi_set_volhdr();
+	sgi_set_entire(cxt);
+	sgi_set_volhdr(cxt);
 	for (i = 0; i < 4; i++) {
 		if (old[i].sysid) {
-			sgi_set_partition(i, old[i].start, old[i].nsect, old[i].sysid);
+			sgi_set_partition(cxt, i, old[i].start, old[i].nsect, old[i].sysid);
 		}
 	}
 }
diff --git a/fdisk/fdisksgilabel.h b/fdisk/fdisksgilabel.h
index 3a11499..7611d32 100644
--- a/fdisk/fdisksgilabel.h
+++ b/fdisk/fdisksgilabel.h
@@ -118,8 +118,8 @@ extern int  sgi_change_sysid( int i, int sys );
 extern unsigned int	sgi_get_start_sector( int i );
 extern unsigned int	sgi_get_num_sectors( int i );
 extern int	sgi_get_sysid( int i );
-extern void	sgi_delete_partition( int i );
-extern void	sgi_add_partition( int n, int sys );
+extern void	sgi_delete_partition( struct fdisk_context *cxt, int i );
+extern void	sgi_add_partition( struct fdisk_context *cxt, int n, int sys );
 extern void	create_sgilabel( struct fdisk_context *cxt );
 extern void	create_sgiinfo( void );
 extern int	verify_sgi( int verbose );
diff --git a/fdisk/fdisksunlabel.c b/fdisk/fdisksunlabel.c
index 9d5b3e8..ae24e16 100644
--- a/fdisk/fdisksunlabel.c
+++ b/fdisk/fdisksunlabel.c
@@ -59,7 +59,8 @@ static inline uint32_t __swap32(uint32_t x) {
 #define SSWAP32(x) (other_endian ? __swap32(x) \
 				 : (uint32_t)(x))
 
-static void set_sun_partition(int i, uint32_t start, uint32_t stop, uint16_t sysid)
+static void set_sun_partition(struct fdisk_context *cxt,
+			      int i, uint32_t start, uint32_t stop, uint16_t sysid)
 {
 	sunlabel->part_tags[i].tag = SSWAP16(sysid);
 	sunlabel->part_tags[i].flag = SSWAP16(0);
@@ -68,7 +69,7 @@ static void set_sun_partition(int i, uint32_t start, uint32_t stop, uint16_t sys
 	sunlabel->partitions[i].num_sectors =
 		SSWAP32(stop - start);
 	set_changed(i);
-	print_partition_size(i + 1, start, stop, sysid);
+	print_partition_size(cxt, i + 1, start, stop, sysid);
 }
 
 static void init(void)
@@ -173,7 +174,7 @@ void create_sunlabel(struct fdisk_context *cxt)
 	sunlabel->num_partitions = SSWAP16(SUN_NUM_PARTITIONS);
 
 	res = blkdev_get_sectors(cxt->dev_fd, &llsectors);
-	sec_fac = sector_size / 512;
+	sec_fac = cxt->sector_size / 512;
 
 #ifdef HDIO_GETGEO
 	if (!ioctl(cxt->dev_fd, HDIO_GETGEO, &geometry)) {
@@ -195,9 +196,9 @@ void create_sunlabel(struct fdisk_context *cxt)
 	} else
 #endif
 	{
-	        heads = read_int(1,1,1024,0,_("Heads"));
-		sectors = read_int(1,1,1024,0,_("Sectors/track"));
-		cylinders = read_int(1,1,65535,0,_("Cylinders"));
+	        heads = read_int(cxt, 1,1,1024,0,_("Heads"));
+		sectors = read_int(cxt, 1,1,1024,0,_("Sectors/track"));
+		cylinders = read_int(cxt, 1,1,65535,0,_("Cylinders"));
 	}
 
 	sunlabel->acyl   = SSWAP16(2);
@@ -220,14 +221,14 @@ void create_sunlabel(struct fdisk_context *cxt)
 	} else
 	        ndiv = cylinders * 2 / 3;
 
-	set_sun_partition(0, 0, ndiv * heads * sectors,
+	set_sun_partition(cxt, 0, 0, ndiv * heads * sectors,
 			  SUN_TAG_LINUX_NATIVE);
-	set_sun_partition(1, ndiv * heads * sectors,
+	set_sun_partition(cxt, 1, ndiv * heads * sectors,
 			  cylinders * heads * sectors,
 			  SUN_TAG_LINUX_SWAP);
 	sunlabel->part_tags[1].flag |= SSWAP16(SUN_FLAG_UNMNT);
 
-	set_sun_partition(2, 0, cylinders * heads * sectors, SUN_TAG_BACKUP);
+	set_sun_partition(cxt, 2, 0, cylinders * heads * sectors, SUN_TAG_BACKUP);
 
 	{
 		unsigned short *ush = (unsigned short *)sunlabel;
@@ -363,7 +364,7 @@ void verify_sun(void)
         printf(_("Unused gap - sectors %d-%d\n"), start, stop);
 }
 
-void add_sun_partition(int n, int sys)
+void add_sun_partition(struct fdisk_context *cxt, int n, int sys)
 {
 	uint32_t starts[SUN_NUM_PARTITIONS], lens[SUN_NUM_PARTITIONS];
 	struct sun_partition *part = &sunlabel->partitions[n];
@@ -394,9 +395,9 @@ void add_sun_partition(int n, int sys)
 	snprintf(mesg, sizeof(mesg), _("First %s"), str_units(SINGULAR));
 	for (;;) {
 		if (whole_disk)
-			first = read_int(0, 0, 0, 0, mesg);
+			first = read_int(cxt, 0, 0, 0, 0, mesg);
 		else
-			first = read_int(scround(start), scround(stop)+1,
+			first = read_int(cxt, scround(start), scround(stop)+1,
 					 scround(stop), 0, mesg);
 		if (display_in_cyl_units)
 			first *= units_per_sector;
@@ -451,13 +452,13 @@ and is of type `Whole disk'\n"));
 		 _("Last %s or +size or +sizeM or +sizeK"),
 		 str_units(SINGULAR));
 	if (whole_disk)
-		last = read_int(scround(stop2), scround(stop2), scround(stop2),
+		last = read_int(cxt, scround(stop2), scround(stop2), scround(stop2),
 				0, mesg);
 	else if (n == 2 && !first)
-		last = read_int(scround(first), scround(stop2), scround(stop2),
+		last = read_int(cxt, scround(first), scround(stop2), scround(stop2),
 				scround(first), mesg);
 	else
-		last = read_int(scround(first), scround(stop), scround(stop),
+		last = read_int(cxt, scround(first), scround(stop), scround(stop),
 				scround(first), mesg);
 	if (display_in_cyl_units)
 		last *= units_per_sector;
@@ -480,7 +481,7 @@ and is of type `Whole disk'\n"));
 	if (whole_disk)
 		sys = SUN_TAG_BACKUP;
 
-	set_sun_partition(n, first, last, sys);
+	set_sun_partition(cxt, n, first, last, sys);
 }
 
 void sun_delete_partition(int i)
@@ -586,10 +587,10 @@ void sun_list_table(struct fdisk_context *cxt, int xtra)
 	}
 }
 
-void sun_set_alt_cyl(void)
+void sun_set_alt_cyl(struct fdisk_context *cxt)
 {
 	sunlabel->acyl =
-		SSWAP16(read_int(0,SSWAP16(sunlabel->acyl), 65535, 0,
+		SSWAP16(read_int(cxt, 0,SSWAP16(sunlabel->acyl), 65535, 0,
 				 _("Number of alternate cylinders")));
 }
 
@@ -598,31 +599,31 @@ void sun_set_ncyl(int cyl)
 	sunlabel->ncyl = SSWAP16(cyl);
 }
 
-void sun_set_xcyl(void)
+void sun_set_xcyl(struct fdisk_context *cxt)
 {
 	sunlabel->apc =
-		SSWAP16(read_int(0, SSWAP16(sunlabel->apc), sectors, 0,
+		SSWAP16(read_int(cxt, 0, SSWAP16(sunlabel->apc), sectors, 0,
 				 _("Extra sectors per cylinder")));
 }
 
-void sun_set_ilfact(void)
+void sun_set_ilfact(struct fdisk_context *cxt)
 {
 	sunlabel->intrlv =
-		SSWAP16(read_int(1, SSWAP16(sunlabel->intrlv), 32, 0,
+		SSWAP16(read_int(cxt, 1, SSWAP16(sunlabel->intrlv), 32, 0,
 				 _("Interleave factor")));
 }
 
-void sun_set_rspeed(void)
+void sun_set_rspeed(struct fdisk_context *cxt)
 {
 	sunlabel->rpm =
-		SSWAP16(read_int(1, SSWAP16(sunlabel->rpm), 100000, 0,
+		SSWAP16(read_int(cxt, 1, SSWAP16(sunlabel->rpm), 100000, 0,
 				 _("Rotation speed (rpm)")));
 }
 
-void sun_set_pcylcount(void)
+void sun_set_pcylcount(struct fdisk_context *cxt)
 {
 	sunlabel->pcyl =
-		SSWAP16(read_int(0, SSWAP16(sunlabel->pcyl), 65535, 0,
+		SSWAP16(read_int(cxt, 0, SSWAP16(sunlabel->pcyl), 65535, 0,
 				 _("Number of physical cylinders")));
 }
 
diff --git a/fdisk/fdisksunlabel.h b/fdisk/fdisksunlabel.h
index f33fe1c..8cb13ec 100644
--- a/fdisk/fdisksunlabel.h
+++ b/fdisk/fdisksunlabel.h
@@ -84,14 +84,14 @@ extern void sun_delete_partition(int i);
 extern int sun_change_sysid(int i, uint16_t sys);
 extern void sun_list_table(struct fdisk_context *cxt, int xtra);
 extern void verify_sun(void);
-extern void add_sun_partition(int n, int sys);
+extern void add_sun_partition(struct fdisk_context *cxt, int n, int sys);
 extern void sun_write_table(struct fdisk_context *cxt);
-extern void sun_set_alt_cyl(void);
+extern void sun_set_alt_cyl(struct fdisk_context *cxt);
 extern void sun_set_ncyl(int cyl);
-extern void sun_set_xcyl(void);
-extern void sun_set_ilfact(void);
-extern void sun_set_rspeed(void);
-extern void sun_set_pcylcount(void);
+extern void sun_set_xcyl(struct fdisk_context *cxt);
+extern void sun_set_ilfact(struct fdisk_context *cxt);
+extern void sun_set_rspeed(struct fdisk_context *cxt);
+extern void sun_set_pcylcount(struct fdisk_context *cxt);
 extern void toggle_sunflags(int i, uint16_t mask);
 extern int sun_get_sysid(int i);
 
diff --git a/fdisk/utils.c b/fdisk/utils.c
index 3a12e2e..2b5dc95 100644
--- a/fdisk/utils.c
+++ b/fdisk/utils.c
@@ -20,12 +20,82 @@
 #include <string.h>
 #include <stdlib.h>
 #include <unistd.h>
+#ifdef HAVE_LIBBLKID
+#include <blkid.h>
+#endif
 
+#include "nls.h"
+#include "blkdev.h"
 #include "common.h"
 #include "fdisk.h"
 
 int fdisk_debug_mask;
 
+static unsigned long __get_sector_size(int fd)
+{
+	unsigned int sect_sz;
+
+	if (!blkdev_get_sector_size(fd, &sect_sz))
+		return (unsigned long) sect_sz;
+	return DEFAULT_SECTOR_SIZE;
+}
+
+static int __discover_topology(struct fdisk_context *cxt)
+{
+#ifdef HAVE_LIBBLKID
+	blkid_probe pr;
+
+	pr = blkid_new_probe();
+	if (pr && blkid_probe_set_device(pr, cxt->dev_fd, 0, 0) == 0) {
+		blkid_topology tp = blkid_probe_get_topology(pr);
+
+		if (tp) {
+			cxt->min_io_size = blkid_topology_get_minimum_io_size(tp);
+			cxt->io_size = blkid_topology_get_optimal_io_size(tp);
+			cxt->phy_sector_size = blkid_topology_get_physical_sector_size(tp);
+			cxt->alignment_offset = blkid_topology_get_alignment_offset(tp);
+
+			if (!cxt->io_size)
+				/* optimal IO is optional, default to minimum IO */
+				cxt->io_size = cxt->min_io_size;
+		}
+	}
+	blkid_free_probe(pr);
+#endif
+
+	/* no blkid or error, use default values */
+	if (!cxt->min_io_size)      cxt->min_io_size = DEFAULT_SECTOR_SIZE;
+	if (!cxt->io_size)          cxt->io_size = DEFAULT_SECTOR_SIZE;
+
+	cxt->sector_size = __get_sector_size(cxt->dev_fd);
+	if (!cxt->phy_sector_size) /* could not discover physical size */
+		cxt->phy_sector_size = cxt->sector_size;
+	if (cxt->sector_size != DEFAULT_SECTOR_SIZE)
+		printf(_("Note: sector size is %ld (not %d)\n"),
+		       cxt->sector_size, DEFAULT_SECTOR_SIZE);
+
+	return 0;
+}
+
+/**
+ * fdisk_dev_has_topology:
+ * @cxt: fdisk context
+ *
+ * Returns 1 if the device provides topology information, otherwise 0.
+ */
+int fdisk_dev_has_topology(struct fdisk_context *cxt)
+{
+	/* 
+	 * Assume that the device provides topology info if
+	 * optimal_io_size is set or alignment_offset is set or
+	 * minimum_io_size is not power of 2.
+	 */
+	if (cxt->io_size || cxt->alignment_offset ||
+	    (cxt->min_io_size & (cxt->min_io_size - 1)))
+		return 1;
+	return 0;
+}
+
 /**
  * fdisk_init_debug:
  * @mask: debug mask (0xffff to enable full debuging)
@@ -81,9 +151,10 @@ struct fdisk_context *fdisk_new_context_from_filename(const char *fname, int rea
 	cxt->dev_path = strdup(fname);
 	if (!cxt->dev_path)
 		goto fail;
+	__discover_topology(cxt);
 
 	DBG(CONTEXT, dbgprint("context initialized for %s [%s]",
-			fname, readonly ? "READ-ONLY" : "READ-WRITE"));
+			      fname, readonly ? "READ-ONLY" : "READ-WRITE"));
 	return cxt;
 fail:
 	errsv = errno;
-- 
1.7.4.1





