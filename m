Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:64286 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752950AbcCCBLJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Mar 2016 20:11:09 -0500
Received: from tenfore.ga-group.nl ([77.12.144.244]) by mail.gmx.com
 (mrgmx102) with ESMTPSA (Nemesis) id 0LhCDT-1a4TD240zH-00oUxX for
 <util-linux@vger.kernel.org>; Thu, 03 Mar 2016 02:11:08 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/7] fsck.minix: fix v3 version offset
Date: Thu,  3 Mar 2016 02:11:02 +0100
Message-Id: <1456967465-16128-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456967465-16128-1-git-send-email-sweet_f_a@gmx.de>
References: <1456967465-16128-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Our test-suite discoverd it on big endian systems, but it was also
broken on little endian for inode numbers > 0xffff.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/fsck.minix.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index 2058a97..a040cf5 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -1011,13 +1011,14 @@ check_file2(struct minix2_inode *dir, unsigned int offset) {
 	block = map_block2(dir, offset / MINIX_BLOCK_SIZE);
 	read_block(block, blk);
 	name = blk + (offset % MINIX_BLOCK_SIZE) + version_offset;
-	ino = *(unsigned short *)(name - version_offset);
+	ino = version_offset == 4 ? *(uint32_t *)(name - version_offset)
+	                          : *(uint16_t *)(name - version_offset);
 	if (ino > get_ninodes()) {
 		get_current_name();
 		printf(_("The directory '%s' contains a bad inode number "
 			 "for file '%.*s'."), current_name, (int)namelen, name);
 		if (ask(_(" Remove"), 1)) {
-			*(unsigned short *)(name - version_offset) = 0;
+			memset(name - version_offset, 0, version_offset);
 			write_block(block, blk);
 		}
 		ino = 0;
-- 
1.8.4.5

