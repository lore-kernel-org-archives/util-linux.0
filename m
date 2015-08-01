Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36229 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbbHASBF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 1 Aug 2015 14:01:05 -0400
Received: by wicgj17 with SMTP id gj17so55497483wic.1
        for <util-linux@vger.kernel.org>; Sat, 01 Aug 2015 11:01:04 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] mkfs.minix: re-fix block count maths
Date: Sat,  1 Aug 2015 19:01:00 +0100
Message-Id: <1438452060-1152-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Error, that Joshua Hudson already pointed out, creapped back to commit
da41ff5 when changes were applied from mailbox rather than git remote, as
the corrected change had included some accidental rubbish.

Reference: http://www.spinics.net/lists/util-linux-ng/msg11764.html
Reference: http://www.spinics.net/lists/util-linux-ng/msg11848.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.minix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 16305b2..2da0e68 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -706,8 +706,8 @@ static void determine_device_blocks(struct fs_control *ctl, const struct stat *s
 		errx(MKFS_EX_ERROR, _("%s: number of blocks too small"), ctl->device_name);
 	if (fs_version == 1 && ctl->fs_blocks > MINIX_MAX_INODES)
 		ctl->fs_blocks = MINIX_MAX_INODES;
-	if (ctl->fs_blocks > MINIX_MAX_INODES * BITS_PER_BLOCK)
-		ctl->fs_blocks = MINIX_MAX_INODES * BITS_PER_BLOCK;	/* Utter maximum: Clip. */
+	if (ctl->fs_blocks > (4 + ((MINIX_MAX_INODES - 4) * BITS_PER_BLOCK)))
+		ctl->fs_blocks = 4 + ((MINIX_MAX_INODES - 4) * BITS_PER_BLOCK);	/* Utter maximum: Clip. */
 }
 
 static void check_user_instructions(struct fs_control *ctl)
-- 
2.5.0

