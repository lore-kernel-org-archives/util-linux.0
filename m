Return-Path: util-linux-owner@vger.kernel.org
Received: from ex13.tuxera.com ([178.16.184.72]:45386 "EHLO ex13.tuxera.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757635AbcH3KJK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 30 Aug 2016 06:09:10 -0400
From: Rostislav Skudnov <rostislav@tuxera.com>
To: <util-linux@vger.kernel.org>
Subject: [PATCH] libblkid exfat.c: Limit maximum number of iterations in find_label
Date: Tue, 30 Aug 2016 10:07:49 +0000
Message-ID: <1472551669-14450-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Do not hang if there is a cluster chain loop in rootdir
---
 libblkid/src/superblocks/exfat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libblkid/src/superblocks/exfat.c b/libblkid/src/superblocks/exfat.c
index 01ed30b..e058423 100644
--- a/libblkid/src/superblocks/exfat.c
+++ b/libblkid/src/superblocks/exfat.c
@@ -86,8 +86,10 @@ static struct exfat_entry_label *find_label(blkid_probe pr,
 	uint32_t cluster = le32_to_cpu(sb->rootdir_cluster);
 	uint64_t offset = cluster_to_offset(sb, cluster);
 	uint8_t *entry;
+	const size_t max_iter = 10000;
+	size_t i = 0;
 
-	for (;;) {
+	for (; i<max_iter; i++) {
 		entry = (uint8_t *) blkid_probe_get_buffer(pr, offset,
 				EXFAT_ENTRY_SIZE);
 		if (!entry)
-- 
2.1.4

