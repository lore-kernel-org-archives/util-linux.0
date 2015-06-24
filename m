Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33430 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbbFXIPh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 24 Jun 2015 04:15:37 -0400
Received: by wiwl6 with SMTP id l6so87780067wiw.0
        for <util-linux@vger.kernel.org>; Wed, 24 Jun 2015 01:15:36 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 07/12] mkfs.minix: check requested blocks will not exceed available on device
Date: Wed, 24 Jun 2015 09:15:14 +0100
Message-Id: <1435133719-2971-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
References: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier user could define more blocks than device, or backing file for
loopback file system, had available.  That lead to a system crash with
following commands;

fallocate --length 64KiB test-file
mkfs.minix -3 -i 842160 test-file 104882174
mkdir test-file.d
mount test-file test-file.d
cp /etc/service test-file.d
Killed
sudo umount test-file.d

The minix driver should probably not hang the whole kernel, but the least
that mkfs.minix ought to do is not to let users to get that condition
quite as easily.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.minix.c | 64 ++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 59e1674..c2ab664 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -656,6 +656,39 @@ static int find_super_magic(const struct fs_control *ctl)
 	}
 }
 
+static void determine_device_blocks(struct fs_control *ctl, const struct stat *statbuf)
+{
+	unsigned long long dev_blocks;
+
+	if (S_ISBLK(statbuf->st_mode)) {
+		int sectorsize;
+
+		if (blkdev_get_sector_size(ctl->device_fd, &sectorsize) == -1)
+			sectorsize = DEFAULT_SECTOR_SIZE;	/* kernel < 2.3.3 */
+		if (blkdev_is_misaligned(ctl->device_fd))
+			warnx(_("%s: device is misaligned"), ctl->device_name);
+		if (MINIX_BLOCK_SIZE < sectorsize)
+			errx(MKFS_EX_ERROR, _("block size smaller than physical "
+					      "sector size of %s"), ctl->device_name);
+		if (blkdev_get_size(ctl->device_fd, &dev_blocks) == -1)
+			errx(MKFS_EX_ERROR, _("cannot determine size of %s"), ctl->device_name);
+		dev_blocks /= MINIX_BLOCK_SIZE;
+	} else if (!S_ISBLK(statbuf->st_mode))
+		dev_blocks = statbuf->st_size / MINIX_BLOCK_SIZE;
+	if (!ctl->fs_blocks)
+		ctl->fs_blocks = dev_blocks;
+	else if (dev_blocks < ctl->fs_blocks)
+		errx(MKFS_EX_ERROR,
+		     _("%s: requested blocks (%llu) exceeds available (%llu) blocks\n"),
+		     ctl->device_name, ctl->fs_blocks, dev_blocks);
+	if (ctl->fs_blocks < 10)
+		errx(MKFS_EX_ERROR, _("%s: number of blocks too small"), ctl->device_name);
+	if (fs_version == 1 && ctl->fs_blocks > MINIX_MAX_INODES)
+		ctl->fs_blocks = MINIX_MAX_INODES;
+	if (ctl->fs_blocks > MINIX_MAX_INODES * BITS_PER_BLOCK)
+		ctl->fs_blocks = MINIX_MAX_INODES * BITS_PER_BLOCK;	/* Utter maximum: Clip. */
+}
+
 static void check_user_instructions(struct fs_control *ctl)
 {
 	switch (fs_version) {
@@ -782,38 +815,9 @@ int main(int argc, char ** argv)
 		ctl.device_fd = open(ctl.device_name, O_RDWR | O_EXCL);
 	else
 		ctl.device_fd = open(ctl.device_name, O_RDWR);
-
 	if (ctl.device_fd < 0)
 		err(MKFS_EX_ERROR, _("cannot open %s"), ctl.device_name);
-
-	if (S_ISBLK(statbuf.st_mode)) {
-		int sectorsize;
-
-		if (blkdev_get_sector_size(ctl.device_fd, &sectorsize) == -1)
-			sectorsize = DEFAULT_SECTOR_SIZE;		/* kernel < 2.3.3 */
-
-		if (blkdev_is_misaligned(ctl.device_fd))
-			warnx(_("%s: device is misaligned"), ctl.device_name);
-
-		if (MINIX_BLOCK_SIZE < sectorsize)
-			errx(MKFS_EX_ERROR, _("block size smaller than physical "
-					"sector size of %s"), ctl.device_name);
-		if (!ctl.fs_blocks) {
-			if (blkdev_get_size(ctl.device_fd, &ctl.fs_blocks) == -1)
-				errx(MKFS_EX_ERROR, _("cannot determine size of %s"),
-					ctl.device_name);
-			ctl.fs_blocks /= MINIX_BLOCK_SIZE;
-		}
-	} else if (!S_ISBLK(statbuf.st_mode)) {
-		if (!ctl.fs_blocks)
-			ctl.fs_blocks = statbuf.st_size / MINIX_BLOCK_SIZE;
-	}
-	if (ctl.fs_blocks < 10)
-		errx(MKFS_EX_ERROR, _("%s: number of blocks too small"), ctl.device_name);
-	if (fs_version == 1 && ctl.fs_blocks > MINIX_MAX_INODES)
-		ctl.fs_blocks = MINIX_MAX_INODES;
-	if (ctl.fs_blocks > MINIX_MAX_INODES * BITS_PER_BLOCK)
-		ctl.fs_blocks = MINIX_MAX_INODES * BITS_PER_BLOCK;	/* Utter maximum: Clip. */
+	determine_device_blocks(&ctl, &statbuf);
 	setup_tables(&ctl);
 	if (ctl.check_blocks)
 		check_blocks(&ctl);
-- 
2.4.4

