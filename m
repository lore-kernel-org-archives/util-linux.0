Return-Path: util-linux-owner@vger.kernel.org
Received: from mga09.intel.com ([134.134.136.24]:9234 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751773AbcFWIcb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 23 Jun 2016 04:32:31 -0400
From: Alexey Obitotskiy <aleksey.obitotskiy@intel.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com
Subject: [PATCH][RESEND] Add metadata signature check for IMSM on 4Kn drives
Date: Thu, 23 Jun 2016 10:32:16 +0200
Message-Id: <1466670736-31676-1-git-send-email-aleksey.obitotskiy@intel.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Drives with 512 and 4K sectors have different offset for
metadata signature. Without signature detected on 4Kn drives
those drives will not be recognized as raid member. This
patch adds checking for IMSM signature for 4Kn drives.

Signed-off-by: Alexey Obitotskiy <aleksey.obitotskiy@intel.com>
---
 libblkid/src/superblocks/isw_raid.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/libblkid/src/superblocks/isw_raid.c b/libblkid/src/superblocks/isw_raid.c
index 065c2b2..e9ecf05 100644
--- a/libblkid/src/superblocks/isw_raid.c
+++ b/libblkid/src/superblocks/isw_raid.c
@@ -26,6 +26,14 @@ struct isw_metadata {
 #define ISW_SIGNATURE		"Intel Raid ISM Cfg Sig. "
 
 
+static struct isw_metadata *get_isw_metadata(blkid_probe pr, unsigned int sector_size,
+		uint64_t *off)
+{
+	*off = ((pr->size / sector_size) - 2) * sector_size;
+	return (struct isw_metadata *)blkid_probe_get_buffer(pr,
+			*off, sizeof(struct isw_metadata));
+}
+
 static int probe_iswraid(blkid_probe pr,
 		const struct blkid_idmag *mag __attribute__((__unused__)))
 {
@@ -37,16 +45,19 @@ static int probe_iswraid(blkid_probe pr,
 	if (!S_ISREG(pr->mode) && !blkid_probe_is_wholedisk(pr))
 		return 1;
 
-	off = ((pr->size / 0x200) - 2) * 0x200;
-	isw = (struct isw_metadata *)
-			blkid_probe_get_buffer(pr,
-					off,
-					sizeof(struct isw_metadata));
+	isw = get_isw_metadata(pr, 512, &off);
 	if (!isw)
 		return errno ? -errno : 1;
 
-	if (memcmp(isw->sig, ISW_SIGNATURE, sizeof(ISW_SIGNATURE)-1) != 0)
-		return 1;
+	if (memcmp(isw->sig, ISW_SIGNATURE, sizeof(ISW_SIGNATURE)-1) != 0) {
+		isw = get_isw_metadata(pr, 4096, &off);
+		if (!isw)
+			return errno ? -errno : 1;
+
+		if (memcmp(isw->sig, ISW_SIGNATURE, sizeof(ISW_SIGNATURE)-1) != 0)
+			return 1;
+	}
+
 	if (blkid_probe_sprintf_version(pr, "%6s",
 			&isw->sig[sizeof(ISW_SIGNATURE)-1]) != 0)
 		return 1;
-- 
2.7.4

