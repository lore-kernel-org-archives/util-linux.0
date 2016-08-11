Return-Path: util-linux-owner@vger.kernel.org
Received: from ex13.tuxera.com ([178.16.184.72]:24046 "EHLO ex13.tuxera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932125AbcHKSYK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 11 Aug 2016 14:24:10 -0400
From: Rostislav Skudnov <rostislav@tuxera.com>
To: <util-linux@vger.kernel.org>
Subject: [PATCH] libblkid: Check that cluster size is nonzero when probing exFAT
Date: Thu, 11 Aug 2016 18:24:00 +0000
Message-ID: <1470939840-13356-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This should prevent division by zero in find_label()

Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>
---
 libblkid/src/superblocks/exfat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libblkid/src/superblocks/exfat.c b/libblkid/src/superblocks/exfat.c
index 3f1e75c..01ed30b 100644
--- a/libblkid/src/superblocks/exfat.c
+++ b/libblkid/src/superblocks/exfat.c
@@ -114,7 +114,7 @@ static int probe_exfat(blkid_probe pr, const struct blkid_idmag *mag)
 	struct exfat_entry_label *label;
 
 	sb = blkid_probe_get_sb(pr, mag, struct exfat_super_block);
-	if (!sb)
+	if (!sb || !CLUSTER_SIZE(sb))
 		return errno ? -errno : BLKID_PROBE_NONE;
 
 	label = find_label(pr, sb);
-- 
2.1.4

