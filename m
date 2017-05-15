Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34836 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932268AbdEOKyv (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 15 May 2017 06:54:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id v4so27404822wmb.2
        for <util-linux@vger.kernel.org>; Mon, 15 May 2017 03:54:50 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] fsck.minix: fix crash
Date: Mon, 15 May 2017 11:54:43 +0100
Message-Id: <20170515105443.8440-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

disk-utils/fsck.minix.c:421:30: runtime error: index 513 out of bounds for
type 'unsigned short [512]'

Addresses: https://github.com/karelzak/util-linux/issues/373
Reported-by: Hanno Bock <hanno@gentoo.org>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fsck.minix.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index 34fbfdf72..1b4d9b461 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -401,6 +401,7 @@ map_block(struct minix_inode *inode, unsigned int blknr) {
 	unsigned short ind[MINIX_BLOCK_SIZE >> 1];
 	unsigned short dind[MINIX_BLOCK_SIZE >> 1];
 	int blk_chg, block, result;
+	size_t range;
 
 	if (blknr < 7)
 		return check_zone_nr(inode->i_zone + blknr, &changed);
@@ -418,7 +419,12 @@ map_block(struct minix_inode *inode, unsigned int blknr) {
 	block = check_zone_nr(inode->i_zone + 8, &changed);
 	read_block(block, (char *)dind);
 	blk_chg = 0;
-	result = check_zone_nr(dind + (blknr / 512), &blk_chg);
+	range = blknr / 512;
+	if (ARRAY_SIZE(dind) <= range) {
+		printf(_("Warning: block out of range\n"));
+		return 1;
+	}
+	result = check_zone_nr(dind + range, &blk_chg);
 	if (blk_chg)
 		write_block(block, (char *)dind);
 	block = result;
-- 
2.13.0

