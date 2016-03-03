Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:56017 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754042AbcCCBLN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Mar 2016 20:11:13 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Davidlohr Bueso <davidlohr@hp.com>
Subject: [PATCH 5/7] mkfs.minix: fix v2/v3 .badblocks inode number for big endian
Date: Thu,  3 Mar 2016 02:11:03 +0100
Message-Id: <1456967465-16128-6-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456967465-16128-1-git-send-email-sweet_f_a@gmx.de>
References: <1456967465-16128-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

For minix v2/v3 on big endian systems the inode number of the unwanted
".badblocks" file was not set to zero. This was introduced when v3 was
added in a2657ae3.

Actually it did not seem to cause any problems but since we zero it out
at all we should do it correctly. Now we zero out the whole directory
entry (inclusive ".badblocks" file name, also for v1). Unfortunately we
have to update the test data checksums.

CC: Davidlohr Bueso <davidlohr@hp.com>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/mkfs.minix.c                       | 5 ++---
 tests/expected/minix/fsck-images-check-blocks | 2 --
 tests/expected/minix/fsck-images-v1c14        | 3 +--
 tests/expected/minix/fsck-images-v1c30        | 2 --
 tests/expected/minix/fsck-images-v2c14        | 3 +--
 tests/expected/minix/fsck-images-v2c30        | 2 --
 tests/expected/minix/fsck-images-v3c60        | 3 ---
 7 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index b472242..24e6188 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -369,8 +369,7 @@ static void make_root_inode_v1(struct fs_control *ctl) {
 	if (ctl->fs_bad_blocks)
 		inode->i_size = 3 * ctl->fs_dirsize;
 	else {
-		root_block[2 * ctl->fs_dirsize] = '\0';
-		root_block[2 * ctl->fs_dirsize + 1] = '\0';
+		memset(&root_block[2 * ctl->fs_dirsize], 0, ctl->fs_dirsize);
 		inode->i_size = 2 * ctl->fs_dirsize;
 	}
 	inode->i_mode = S_IFDIR + 0755;
@@ -391,7 +390,7 @@ static void make_root_inode_v2_v3 (struct fs_control *ctl) {
 	if (ctl->fs_bad_blocks)
 		inode->i_size = 3 * ctl->fs_dirsize;
 	else {
-		root_block[2 * ctl->fs_dirsize] = '\0';
+		memset(&root_block[2 * ctl->fs_dirsize], 0, ctl->fs_dirsize);
 		inode->i_size = 2 * ctl->fs_dirsize;
 	}
 
diff --git a/tests/expected/minix/fsck-images-check-blocks b/tests/expected/minix/fsck-images-check-blocks
index 883d1e8..fce90fd 100644
--- a/tests/expected/minix/fsck-images-check-blocks
+++ b/tests/expected/minix/fsck-images-check-blocks
@@ -25,7 +25,5 @@ fsck return value: 0
 00001410  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 00001420  01 00 2e 2e 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 00001430  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
-00001440  00 00 2e 62 61 64 62 6c  6f 63 6b 73 00 00 00 00  |...badblocks....|
-00001450  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 *
 00004000
diff --git a/tests/expected/minix/fsck-images-v1c14 b/tests/expected/minix/fsck-images-v1c14
index b3301d9..75e3310 100644
--- a/tests/expected/minix/fsck-images-v1c14
+++ b/tests/expected/minix/fsck-images-v1c14
@@ -23,7 +23,6 @@ fsck return value: 0
 *
 00001400  01 00 2e 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 00001410  01 00 2e 2e 00 00 00 00  00 00 00 00 00 00 00 00  |................|
-00001420  00 00 2e 62 61 64 62 6c  6f 63 6b 73 00 00 00 00  |...badblocks....|
-00001430  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001420  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 *
 00004000
diff --git a/tests/expected/minix/fsck-images-v1c30 b/tests/expected/minix/fsck-images-v1c30
index 883d1e8..fce90fd 100644
--- a/tests/expected/minix/fsck-images-v1c30
+++ b/tests/expected/minix/fsck-images-v1c30
@@ -25,7 +25,5 @@ fsck return value: 0
 00001410  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 00001420  01 00 2e 2e 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 00001430  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
-00001440  00 00 2e 62 61 64 62 6c  6f 63 6b 73 00 00 00 00  |...badblocks....|
-00001450  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 *
 00004000
diff --git a/tests/expected/minix/fsck-images-v2c14 b/tests/expected/minix/fsck-images-v2c14
index 5e155b7..e8bc4e3 100644
--- a/tests/expected/minix/fsck-images-v2c14
+++ b/tests/expected/minix/fsck-images-v2c14
@@ -24,7 +24,6 @@ fsck return value: 0
 *
 00001400  01 00 2e 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 00001410  01 00 2e 2e 00 00 00 00  00 00 00 00 00 00 00 00  |................|
-00001420  00 00 2e 62 61 64 62 6c  6f 63 6b 73 00 00 00 00  |...badblocks....|
-00001430  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001420  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 *
 00004000
diff --git a/tests/expected/minix/fsck-images-v2c30 b/tests/expected/minix/fsck-images-v2c30
index 5f35ed7..0066e49 100644
--- a/tests/expected/minix/fsck-images-v2c30
+++ b/tests/expected/minix/fsck-images-v2c30
@@ -26,7 +26,5 @@ fsck return value: 0
 00001410  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 00001420  01 00 2e 2e 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 00001430  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
-00001440  00 00 2e 62 61 64 62 6c  6f 63 6b 73 00 00 00 00  |...badblocks....|
-00001450  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 *
 00004000
diff --git a/tests/expected/minix/fsck-images-v3c60 b/tests/expected/minix/fsck-images-v3c60
index be2b54d..89ac9c9 100644
--- a/tests/expected/minix/fsck-images-v3c60
+++ b/tests/expected/minix/fsck-images-v3c60
@@ -28,7 +28,4 @@ fsck return value: 0
 00001440  01 00 00 00 2e 2e 00 00  00 00 00 00 00 00 00 00  |................|
 00001450  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 *
-00001480  00 00 00 00 2e 62 61 64  62 6c 6f 63 6b 73 00 00  |.....badblocks..|
-00001490  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
-*
 00004000
-- 
1.8.4.5

