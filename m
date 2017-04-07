Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:59154 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932247AbdDGLgC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 7 Apr 2017 07:36:02 -0400
Received: from adsiz.fritz.box ([178.25.190.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLvGW-1d1vps2nQS-007ji1 for
 <util-linux@vger.kernel.org>; Fri, 07 Apr 2017 13:36:00 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] misc: fix some printf format strings
Date: Fri,  7 Apr 2017 13:35:58 +0200
Message-Id: <20170407113559.16107-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Fix compiler warnings seen on Linux/i586 and OSX/travis.

  #type            #format   #cast
   unsigned long    %lu       -
   uint64_t         PRIu64    -
   fdisk_sector_t   %ju       (uintmax_t)

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libblkid/src/partitions/gpt.c | 3 ++-
 libfdisk/src/alignment.c      | 2 +-
 sys-utils/blkzone.c           | 8 ++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/libblkid/src/partitions/gpt.c b/libblkid/src/partitions/gpt.c
index b7d050653..52704ed63 100644
--- a/libblkid/src/partitions/gpt.c
+++ b/libblkid/src/partitions/gpt.c
@@ -18,6 +18,7 @@
 #include <stdint.h>
 #include <stddef.h>
 #include <limits.h>
+#include <inttypes.h>
 
 #include "partitions.h"
 #include "crc32.h"
@@ -217,7 +218,7 @@ static struct gpt_header *get_gpt_header(
 
 	ssz = blkid_probe_get_sectorsize(pr);
 
-	DBG(LOWPROBE, ul_debug(" checking for GPT header at %ju", lba));
+	DBG(LOWPROBE, ul_debug(" checking for GPT header at %"PRIu64, lba));
 
 	/* whole sector is allocated for GPT header */
 	h = (struct gpt_header *) get_lba_buffer(pr, lba, ssz);
diff --git a/libfdisk/src/alignment.c b/libfdisk/src/alignment.c
index 2e2069992..327faa03d 100644
--- a/libfdisk/src/alignment.c
+++ b/libfdisk/src/alignment.c
@@ -348,7 +348,7 @@ int fdisk_apply_user_device_properties(struct fdisk_context *cxt)
 
 		if (cxt->sector_size != old_secsz) {
 			cxt->total_sectors = (old_total * (old_secsz/512)) / (cxt->sector_size >> 9);
-			DBG(CXT, ul_debugobj(cxt, "new total sectors: %ju", cxt->total_sectors));
+			DBG(CXT, ul_debugobj(cxt, "new total sectors: %ju", (uintmax_t)cxt->total_sectors));
 		}
 	}
 
diff --git a/sys-utils/blkzone.c b/sys-utils/blkzone.c
index e2c33770c..1457225c9 100644
--- a/sys-utils/blkzone.c
+++ b/sys-utils/blkzone.c
@@ -195,7 +195,7 @@ static int blkzone_report(struct blkzone_control *ctl)
 			err(EXIT_FAILURE, _("%s: BLKREPORTZONE ioctl failed"), ctl->devname);
 
 		if (ctl->verbose)
-			printf(_("Found %d zones from 0x%lx\n"),
+			printf(_("Found %d zones from 0x%"PRIx64"\n"),
 				zi->nr_zones, ctl->offset);
 
 		if (!zi->nr_zones) {
@@ -216,7 +216,7 @@ static int blkzone_report(struct blkzone_control *ctl)
 				break;
 			}
 
-			printf(_("  start: 0x%09lx, len 0x%06lx, wptr 0x%06lx"
+			printf(_("  start: 0x%09"PRIx64", len 0x%06"PRIx64", wptr 0x%06"PRIx64
 			 	" reset:%u non-seq:%u, zcond:%2u(%s) [type: %u(%s)]\n"),
 				start, len, (type == 0x1) ? 0 : wp - start,
 				entry->reset, entry->non_seq,
@@ -254,7 +254,7 @@ static int blkzone_reset(struct blkzone_control *ctl)
 
 	if (ctl->offset & (zonesize - 1))
 		errx(EXIT_FAILURE, _("%s: offset %" PRIu64 " is not aligned "
-			"to zone size %" PRIu64),
+			"to zone size %lu"),
 			ctl->devname, ctl->offset, zonesize);
 
 	if (ctl->offset > ctl->total_sectors)
@@ -273,7 +273,7 @@ static int blkzone_reset(struct blkzone_control *ctl)
 	    (zlen & (zonesize - 1)) &&
 	    ctl->offset + zlen != ctl->total_sectors)
 		errx(EXIT_FAILURE, _("%s: number of sectors %" PRIu64 " is not aligned "
-			"to zone size %" PRIu64),
+			"to zone size %lu"),
 			ctl->devname, ctl->length, zonesize);
 
 	za.sector = ctl->offset;
-- 
2.12.0

