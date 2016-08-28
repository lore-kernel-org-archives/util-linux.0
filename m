Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([217.72.192.75]:53717 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbcH1TQC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 28 Aug 2016 15:16:02 -0400
Received: from localhost ([91.7.171.187]) by mrelayeu.kundenserver.de
 (mreue103) with ESMTPSA (Nemesis) id 0LuKFr-1awXub39mx-011gYb for
 <util-linux@vger.kernel.org>; Sun, 28 Aug 2016 21:15:58 +0200
Date: Sun, 28 Aug 2016 21:15:59 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] Avoid OOB access on illegal ZFS superblocks
Message-ID: <20160828191559.GA3110@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

64 bit systems can trigger an out of boundary access while performing
a ZFS superblock probe.

This happens due to a possible integer overflow while calculating
the remaining available bytes. The variable is of type "int" and the
string length is allowed to be larger than INT_MAX, which means that
avail calculation can overflow, circumventing the "avail < 0" check and
therefore accessing memory outside the "buff" array later on.

Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
---
 libblkid/src/superblocks/zfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libblkid/src/superblocks/zfs.c b/libblkid/src/superblocks/zfs.c
index b6ffac5..c41f769 100644
--- a/libblkid/src/superblocks/zfs.c
+++ b/libblkid/src/superblocks/zfs.c
@@ -112,7 +112,7 @@ static void zfs_extract_guid_name(blkid_probe pr, loff_t offset)
 
 			nvs->nvs_type = be32_to_cpu(nvs->nvs_type);
 			nvs->nvs_strlen = be32_to_cpu(nvs->nvs_strlen);
-			if (nvs->nvs_strlen > UINT_MAX - sizeof(*nvs))
+			if (nvs->nvs_strlen > INT_MAX - sizeof(*nvs))
 				break;
 			avail -= nvs->nvs_strlen + sizeof(*nvs);
 			DBG(LOWPROBE, ul_debug("nvstring: type %u string %*s\n", nvs->nvs_type,
-- 
2.9.3

