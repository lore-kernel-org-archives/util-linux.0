Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:45656 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767Ab2GZOEc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 10:04:32 -0400
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: dave@gnu.org
Subject: [PATCH 1/5] fdisk: make grain global variable part of fdisk_context()
Date: Thu, 26 Jul 2012 16:04:24 +0200
Message-Id: <1343311468-20206-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There is no reason for this to be global variable - it belongs
to the context.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisks/fdisk.c         |   17 ++++++++---------
 fdisks/fdisk.h         |    3 ++-
 fdisks/fdiskdoslabel.c |    2 +-
 fdisks/utils.c         |    2 ++
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index f00db4a..0aa8a0b 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -132,7 +132,6 @@ int	nowarn = 0,			/* no warnings for fdisk -l/-s */
 unsigned int	user_cylinders, user_heads, user_sectors;
 sector_t sector_offset = 1;
 unsigned int units_per_sector = 1, display_in_cyl_units = 0;
-unsigned long grain = DEFAULT_SECTOR_SIZE;
 enum fdisk_labeltype disklabel;	/* Current disklabel */
 
 static void __attribute__ ((__noreturn__)) usage(FILE *out)
@@ -300,8 +299,8 @@ lba_is_aligned(struct fdisk_context *cxt, sector_t lba)
 	unsigned int granularity = max(cxt->phy_sector_size, cxt->min_io_size);
 	unsigned long long offset;
 
-	if (grain > granularity)
-		granularity = grain;
+	if (cxt->grain > granularity)
+		granularity = cxt->grain;
 	offset = (lba * cxt->sector_size) & (granularity - 1);
 
 	return !((granularity + cxt->alignment_offset - offset) & (granularity - 1));
@@ -323,7 +322,7 @@ sector_t align_lba(struct fdisk_context *cxt, sector_t lba, int direction)
 	if (lba_is_aligned(cxt, lba))
 		res = lba;
 	else {
-		sector_t sects_in_phy = grain / cxt->sector_size;
+		sector_t sects_in_phy = cxt->grain / cxt->sector_size;
 
 		if (lba < sector_offset)
 			res = sector_offset;
@@ -446,7 +445,7 @@ void warn_alignment(struct fdisk_context *cxt)
 void
 update_sector_offset(struct fdisk_context *cxt)
 {
-	grain = cxt->io_size;
+	cxt->grain = cxt->io_size;
 
 	if (dos_compatible_flag)
 		sector_offset = cxt->geom.sectors;	/* usually 63 sectors */
@@ -481,12 +480,12 @@ update_sector_offset(struct fdisk_context *cxt)
 			sector_offset = cxt->phy_sector_size / cxt->sector_size;
 
 		/* use 1MiB grain always when possible */
-		if (grain < 2048 * 512)
-			grain = 2048 * 512;
+		if (cxt->grain < 2048 * 512)
+			cxt->grain = 2048 * 512;
 
 		/* don't use huge grain on small devices */
-		if (cxt->total_sectors <= (grain * 4 / cxt->sector_size))
-			grain = cxt->phy_sector_size;
+		if (cxt->total_sectors <= (cxt->grain * 4 / cxt->sector_size))
+			cxt->grain = cxt->phy_sector_size;
 	}
 }
 
diff --git a/fdisks/fdisk.h b/fdisks/fdisk.h
index 29b57fe..04c25e2 100644
--- a/fdisks/fdisk.h
+++ b/fdisks/fdisk.h
@@ -121,6 +121,8 @@ struct fdisk_context {
 	unsigned long sector_size;	/* logical size */
 	unsigned long alignment_offset;
 
+	unsigned long grain;		/* alignment unit */
+
 	/* geometry */
 	sector_t total_sectors; /* in logical sectors */
 	struct fdisk_geometry geom;
@@ -237,7 +239,6 @@ enum fdisk_labeltype {
 
 extern enum fdisk_labeltype disklabel;
 extern int MBRbuffer_changed;
-extern unsigned long grain;
 
 /* start_sect and nr_sects are stored little endian on all machines */
 /* moreover, they are not aligned correctly */
diff --git a/fdisks/fdiskdoslabel.c b/fdisks/fdiskdoslabel.c
index 06c868e..10006f6 100644
--- a/fdisks/fdiskdoslabel.c
+++ b/fdisks/fdiskdoslabel.c
@@ -22,7 +22,7 @@
 		s |= (sector >> 2) & 0xc0;				\
 	}
 
-#define alignment_required	(grain != cxt->sector_size)
+#define alignment_required	(cxt->grain != cxt->sector_size)
 
 struct pte ptes[MAXIMUM_PARTS];
 sector_t extended_offset;
diff --git a/fdisks/utils.c b/fdisks/utils.c
index 19aed87..9b69de3 100644
--- a/fdisks/utils.c
+++ b/fdisks/utils.c
@@ -488,6 +488,8 @@ struct fdisk_context *fdisk_new_context_from_filename(const char *fname, int rea
 	__discover_topology(cxt);
 	__discover_system_geometry(cxt);
 
+	cxt->grain = DEFAULT_SECTOR_SIZE;
+
 	/* detect labels and apply labes specific stuff (e.g geomery)
 	 * to the context */
 	__probe_labels(cxt);
-- 
1.7.7

