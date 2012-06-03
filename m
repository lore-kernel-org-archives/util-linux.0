Return-Path: util-linux-owner@vger.kernel.org
Received: from mailbigip.dreamhost.com ([208.97.132.5]:40304 "EHLO
	homiemail-a62.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753992Ab2FCSP0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Jun 2012 14:15:26 -0400
Subject: [PATCH 2/5] fdisk: add total sectors
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 03 Jun 2012 20:15:20 +0200
Message-ID: <1338747320.2864.11.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Add the total_sectors variable to the context structure. This is the initial geometry information.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c         |   21 ++++++++-------------
 fdisk/fdisk.h         |    5 ++++-
 fdisk/fdiskdoslabel.c |    4 ++--
 fdisk/utils.c         |   12 ++++++++++++
 4 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index d7ff2e5..654d8f3 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -145,7 +145,6 @@ unsigned int	heads,
 	units_per_sector = 1,
 	display_in_cyl_units = 0;
 
-sector_t total_number_of_sectors; /* in logical sectors */
 unsigned long grain = DEFAULT_SECTOR_SIZE;
 enum labeltype disklabel;	/* Current disklabel */
 
@@ -400,8 +399,8 @@ void update_units(void)
 
 void warn_limits(struct fdisk_context *cxt)
 {
-	if (total_number_of_sectors > UINT_MAX && !nowarn) {
-		unsigned long long bytes = total_number_of_sectors * cxt->sector_size;
+	if (cxt->total_sectors > UINT_MAX && !nowarn) {
+		unsigned long long bytes = cxt->total_sectors * cxt->sector_size;
 		int giga = bytes / 1000000000;
 		int hectogiga = (giga + 50) / 100;
 
@@ -509,7 +508,7 @@ update_sector_offset(struct fdisk_context *cxt)
 		sector_offset = x / cxt->sector_size;
 
 		/* don't use huge offset on small devices */
-		if (total_number_of_sectors <= sector_offset * 4)
+		if (cxt->total_sectors <= sector_offset * 4)
 			sector_offset = cxt->phy_sector_size / cxt->sector_size;
 
 		/* use 1MiB grain always when possible */
@@ -517,7 +516,7 @@ update_sector_offset(struct fdisk_context *cxt)
 			grain = 2048 * 512;
 
 		/* don't use huge grain on small devices */
-		if (total_number_of_sectors <= (grain * 4 / cxt->sector_size))
+		if (cxt->total_sectors <= (grain * 4 / cxt->sector_size))
 			grain = cxt->phy_sector_size;
 	}
 }
@@ -540,13 +539,9 @@ get_geometry(struct fdisk_context *cxt, struct geom *g) {
 		pt_sectors ? pt_sectors :
 		kern_sectors ? kern_sectors : 63;
 
-	/* get number of 512-byte sectors, and convert it the real sectors */
-	if (blkdev_get_sectors(cxt->dev_fd, &nsects) == 0)
-		total_number_of_sectors = (nsects / (cxt->sector_size >> 9));
-
 	update_sector_offset(cxt);
 
-	llcyls = total_number_of_sectors / (heads * sectors);
+	llcyls = cxt->total_sectors / (heads * sectors);
 	cylinders = llcyls;
 	if (cylinders != llcyls)	/* truncated? */
 		cylinders = ~0;
@@ -1146,7 +1141,7 @@ check_alignment(struct fdisk_context *cxt, sector_t lba, int partition)
 
 static void
 list_disk_geometry(struct fdisk_context *cxt) {
-	unsigned long long bytes = total_number_of_sectors * cxt->sector_size;
+	unsigned long long bytes = cxt->total_sectors * cxt->sector_size;
 	long megabytes = bytes/1000000;
 
 	if (megabytes < 10000)
@@ -1160,7 +1155,7 @@ list_disk_geometry(struct fdisk_context *cxt) {
 	printf(_("%d heads, %llu sectors/track, %d cylinders"),
 	       heads, sectors, cylinders);
 	if (units_per_sector == 1)
-		printf(_(", total %llu sectors"), total_number_of_sectors);
+		printf(_(", total %llu sectors"), cxt->total_sectors);
 	printf("\n");
 	printf(_("Units = %s of %d * %ld = %ld bytes\n"),
 	       str_units(PLURAL),
@@ -1468,7 +1463,7 @@ check(int n, unsigned int h, unsigned int s, unsigned int c,
 static void
 verify(struct fdisk_context *cxt) {
 	int i, j;
-	sector_t total = 1, n_sectors = total_number_of_sectors;
+	sector_t total = 1, n_sectors = cxt->total_sectors;
 	unsigned long long first[partitions], last[partitions];
 	struct partition *p;
 
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index 8fff6d8..a74f25e 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -112,6 +112,9 @@ struct fdisk_context {
 	unsigned long phy_sector_size; /* physical size */
 	unsigned long sector_size; /* logical size */
 	unsigned long alignment_offset;
+	
+	/* geometry */
+	sector_t total_sectors; /* in logical sectors */
 };
 
 extern struct fdisk_context *fdisk_new_context_from_filename(const char *fname, int readonly);
@@ -181,8 +184,8 @@ extern enum labeltype disklabel;
  */
 extern unsigned char *MBRbuffer;
 extern int MBRbuffer_changed;
-extern sector_t total_number_of_sectors;
 extern unsigned long grain;
+
 /* start_sect and nr_sects are stored little endian on all machines */
 /* moreover, they are not aligned correctly */
 static inline void
diff --git a/fdisk/fdiskdoslabel.c b/fdisk/fdiskdoslabel.c
index a187d77..c878891 100644
--- a/fdisk/fdiskdoslabel.c
+++ b/fdisk/fdiskdoslabel.c
@@ -449,10 +449,10 @@ void dos_add_partition(struct fdisk_context *cxt, int n, int sys)
 	fill_bounds(first, last);
 	if (n < 4) {
 		start = sector_offset;
-		if (display_in_cyl_units || !total_number_of_sectors)
+		if (display_in_cyl_units || !cxt->total_sectors)
 			limit = heads * sectors * cylinders - 1;
 		else
-			limit = total_number_of_sectors - 1;
+			limit = cxt->total_sectors - 1;
 
 		if (limit > UINT_MAX)
 			limit = UINT_MAX;
diff --git a/fdisk/utils.c b/fdisk/utils.c
index 2b5dc95..6fabd82 100644
--- a/fdisk/utils.c
+++ b/fdisk/utils.c
@@ -40,6 +40,16 @@ static unsigned long __get_sector_size(int fd)
 	return DEFAULT_SECTOR_SIZE;
 }
 
+static int __discover_geometry(struct fdisk_context *cxt)
+{
+	sector_t nsects;
+
+	/* get number of 512-byte sectors, and convert it the real sectors */
+	if (!blkdev_get_sectors(cxt->dev_fd, &nsects))
+		cxt->total_sectors = (nsects / (cxt->sector_size >> 9));
+	return 0;
+}
+
 static int __discover_topology(struct fdisk_context *cxt)
 {
 #ifdef HAVE_LIBBLKID
@@ -151,7 +161,9 @@ struct fdisk_context *fdisk_new_context_from_filename(const char *fname, int rea
 	cxt->dev_path = strdup(fname);
 	if (!cxt->dev_path)
 		goto fail;
+
 	__discover_topology(cxt);
+	__discover_geometry(cxt);
 
 	DBG(CONTEXT, dbgprint("context initialized for %s [%s]",
 			      fname, readonly ? "READ-ONLY" : "READ-WRITE"));
-- 
1.7.4.1




