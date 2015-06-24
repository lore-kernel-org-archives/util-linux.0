Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38399 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbbFXIPe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 24 Jun 2015 04:15:34 -0400
Received: by wibdq8 with SMTP id dq8so38722229wib.1
        for <util-linux@vger.kernel.org>; Wed, 24 Jun 2015 01:15:32 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 04/12] mkfs.minix: remove unuseful code
Date: Wed, 24 Jun 2015 09:15:11 +0100
Message-Id: <1435133719-2971-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
References: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Checks about inodes vs block sizes does not add much robustness.  Both
values are derived at compilation time from struct minix_inode size, and
they form full definition circle.

Bad block check for none-block devices should not be supressed, user
requested it so let him have it.

Check for st_rdev == 0x0300 || st_rdev == 0x0340 was unreachable.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.minix.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index a198e5a..d3b46b2 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -659,11 +659,6 @@ int main(int argc, char ** argv) {
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	if (INODE_SIZE * MINIX_INODES_PER_BLOCK != MINIX_BLOCK_SIZE)
-		errx(MKFS_EX_ERROR, _("%s: bad inode size"), device_name);
-	if (INODE2_SIZE * MINIX2_INODES_PER_BLOCK != MINIX_BLOCK_SIZE)
-		errx(MKFS_EX_ERROR, _("%s: bad inode size"), device_name);
-
 	while ((i = getopt_long(argc, argv, "1v23n:i:cl:Vh", longopts, NULL)) != -1)
 		switch (i) {
 		case '1':
@@ -776,9 +771,7 @@ int main(int argc, char ** argv) {
 	} else if (!S_ISBLK(statbuf.st_mode)) {
 		if (!BLOCKS)
 			BLOCKS = statbuf.st_size / MINIX_BLOCK_SIZE;
-		check=0;
-	} else if (statbuf.st_rdev == 0x0300 || statbuf.st_rdev == 0x0340)
-		errx(MKFS_EX_ERROR, _("will not try to make filesystem on '%s'"), device_name);
+	}
 	if (BLOCKS < 10)
 		errx(MKFS_EX_ERROR, _("%s: number of blocks too small"), device_name);
 
-- 
2.4.4

