Return-Path: util-linux-owner@vger.kernel.org
Received: from mga09.intel.com ([134.134.136.24]:1594 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751483AbcFXJ7x (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Jun 2016 05:59:53 -0400
From: Alexey Obitotskiy <aleksey.obitotskiy@intel.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com
Subject: [PATCH v.2] Add metadata signature check for IMSM on 4Kn drives (v.2)
Date: Fri, 24 Jun 2016 11:59:35 +0200
Message-Id: <1466762375-17486-1-git-send-email-aleksey.obitotskiy@intel.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Drives with 512 and 4K sectors have different offset for
metadata signature. Without signature detected on 4Kn drives
those drives will not be recognized as raid member. This
patch adds checking for IMSM signature for 4Kn drives.

Signed-off-by: Alexey Obitotskiy <aleksey.obitotskiy@intel.com>
---
 libblkid/src/superblocks/isw_raid.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/libblkid/src/superblocks/isw_raid.c b/libblkid/src/superblocks/isw_raid.c
index 065c2b2..81d53a1 100644
--- a/libblkid/src/superblocks/isw_raid.c
+++ b/libblkid/src/superblocks/isw_raid.c
@@ -25,11 +25,11 @@ struct isw_metadata {
 
 #define ISW_SIGNATURE		"Intel Raid ISM Cfg Sig. "
 
-
 static int probe_iswraid(blkid_probe pr,
 		const struct blkid_idmag *mag __attribute__((__unused__)))
 {
 	uint64_t off;
+	unsigned int sector_size;
 	struct isw_metadata *isw;
 
 	if (pr->size < 0x10000)
@@ -37,16 +37,17 @@ static int probe_iswraid(blkid_probe pr,
 	if (!S_ISREG(pr->mode) && !blkid_probe_is_wholedisk(pr))
 		return 1;
 
-	off = ((pr->size / 0x200) - 2) * 0x200;
-	isw = (struct isw_metadata *)
-			blkid_probe_get_buffer(pr,
-					off,
-					sizeof(struct isw_metadata));
+	sector_size = blkid_probe_get_sectorsize(pr);
+	off = ((pr->size / sector_size) - 2) * sector_size;
+
+	isw = (struct isw_metadata *)blkid_probe_get_buffer(pr,
+			off, sizeof(struct isw_metadata));
 	if (!isw)
 		return errno ? -errno : 1;
 
 	if (memcmp(isw->sig, ISW_SIGNATURE, sizeof(ISW_SIGNATURE)-1) != 0)
 		return 1;
+
 	if (blkid_probe_sprintf_version(pr, "%6s",
 			&isw->sig[sizeof(ISW_SIGNATURE)-1]) != 0)
 		return 1;
-- 
2.7.4

