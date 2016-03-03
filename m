Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:58488 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106AbcCCBLJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Mar 2016 20:11:09 -0500
Received: from tenfore.ga-group.nl ([77.12.144.244]) by mail.gmx.com
 (mrgmx102) with ESMTPSA (Nemesis) id 0M2WgT-1Zj2cB3T1h-00sOxd for
 <util-linux@vger.kernel.org>; Thu, 03 Mar 2016 02:11:07 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/7] tests: minix, use hexdump instead of md5sum
Date: Thu,  3 Mar 2016 02:11:00 +0100
Message-Id: <1456967465-16128-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456967465-16128-1-git-send-email-sweet_f_a@gmx.de>
References: <1456967465-16128-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/minix/fsck-images-auto-fix     | 28 ++++++++++++++++++++++++++-
 tests/expected/minix/fsck-images-check-blocks | 24 ++++++++++++++++++++++-
 tests/expected/minix/fsck-images-v1c14        | 22 ++++++++++++++++++++-
 tests/expected/minix/fsck-images-v1c30        | 24 ++++++++++++++++++++++-
 tests/expected/minix/fsck-images-v2c14        | 23 +++++++++++++++++++++-
 tests/expected/minix/fsck-images-v2c30        | 25 +++++++++++++++++++++++-
 tests/expected/minix/fsck-images-v3c60        | 27 +++++++++++++++++++++++++-
 tests/ts/minix/fsck-images                    |  5 +++--
 8 files changed, 169 insertions(+), 9 deletions(-)

diff --git a/tests/expected/minix/fsck-images-auto-fix b/tests/expected/minix/fsck-images-auto-fix
index 9680daa..b22c191 100644
--- a/tests/expected/minix/fsck-images-auto-fix
+++ b/tests/expected/minix/fsck-images-auto-fix
@@ -28,4 +28,30 @@ Inode 1 not used, marked used in the bitmap.
 FILE SYSTEM HAS BEEN CHANGED
 ----------------------------
 0
-29f0edbcb7e405bbc56e614af3c3cb7c auto-fix.img
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000400  10 00 00 00 00 00 01 00  01 00 05 00 00 00 00 00  |................|
+00000410  ff ff ff 7f 10 00 00 00  5a 4d 00 00 00 04 00 00  |........ZM......|
+00000420  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000800  03 00 fe ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000810  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00000c00  03 f0 ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000c10  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00001000  ed 41 02 00 e8 03 e8 03  80 00 00 00 98 3d b9 55  |.A...........=.U|
+00001010  98 3d b9 55 98 3d b9 55  05 00 00 00 00 00 00 00  |.=.U.=.U........|
+00001020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001400  01 00 fe ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00001410  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00001800  03 f0 ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00001810  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00001c00  ed 41 02 00 e8 03 e8 03  80 00 00 00 98 3d b9 55  |.A...........=.U|
+00001c10  98 3d b9 55 98 3d b9 55  05 00 00 00 00 00 00 00  |.=.U.=.U........|
+00001c20  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00002000
diff --git a/tests/expected/minix/fsck-images-check-blocks b/tests/expected/minix/fsck-images-check-blocks
index a5549fa..883d1e8 100644
--- a/tests/expected/minix/fsck-images-check-blocks
+++ b/tests/expected/minix/fsck-images-check-blocks
@@ -6,4 +6,26 @@ Maxsize=268966912
 
 mkfs return value: 0
 fsck return value: 0
-9336eb47979f61e934c3aec3434333d7
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000400  20 00 10 00 01 00 01 00  05 00 00 00 00 1c 08 10  | ...............|
+00000410  8f 13 01 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00000420  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000800  03 00 00 00 fe ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000810  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00000c00  03 f0 ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000c10  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00001000  ed 41 00 00 40 00 00 00  34 29 bd 55 00 02 05 00  |.A..@...4).U....|
+00001010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001400  01 00 2e 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001410  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001420  01 00 2e 2e 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001430  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001440  00 00 2e 62 61 64 62 6c  6f 63 6b 73 00 00 00 00  |...badblocks....|
+00001450  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00004000
diff --git a/tests/expected/minix/fsck-images-v1c14 b/tests/expected/minix/fsck-images-v1c14
index 3db2ace..b3301d9 100644
--- a/tests/expected/minix/fsck-images-v1c14
+++ b/tests/expected/minix/fsck-images-v1c14
@@ -6,4 +6,24 @@ Maxsize=268966912
 
 mkfs return value: 0
 fsck return value: 0
-663e1fb18fc074fc15bdb698b0fd0fda
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000400  20 00 10 00 01 00 01 00  05 00 00 00 00 1c 08 10  | ...............|
+00000410  7f 13 01 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00000420  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000800  03 00 00 00 fe ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000810  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00000c00  03 f0 ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000c10  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00001000  ed 41 00 00 20 00 00 00  34 29 bd 55 00 02 05 00  |.A.. ...4).U....|
+00001010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001400  01 00 2e 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001410  01 00 2e 2e 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001420  00 00 2e 62 61 64 62 6c  6f 63 6b 73 00 00 00 00  |...badblocks....|
+00001430  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00004000
diff --git a/tests/expected/minix/fsck-images-v1c30 b/tests/expected/minix/fsck-images-v1c30
index a5549fa..883d1e8 100644
--- a/tests/expected/minix/fsck-images-v1c30
+++ b/tests/expected/minix/fsck-images-v1c30
@@ -6,4 +6,26 @@ Maxsize=268966912
 
 mkfs return value: 0
 fsck return value: 0
-9336eb47979f61e934c3aec3434333d7
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000400  20 00 10 00 01 00 01 00  05 00 00 00 00 1c 08 10  | ...............|
+00000410  8f 13 01 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00000420  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000800  03 00 00 00 fe ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000810  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00000c00  03 f0 ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000c10  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00001000  ed 41 00 00 40 00 00 00  34 29 bd 55 00 02 05 00  |.A..@...4).U....|
+00001010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001400  01 00 2e 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001410  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001420  01 00 2e 2e 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001430  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001440  00 00 2e 62 61 64 62 6c  6f 63 6b 73 00 00 00 00  |...badblocks....|
+00001450  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00004000
diff --git a/tests/expected/minix/fsck-images-v2c14 b/tests/expected/minix/fsck-images-v2c14
index 978e8ef..5e155b7 100644
--- a/tests/expected/minix/fsck-images-v2c14
+++ b/tests/expected/minix/fsck-images-v2c14
@@ -6,4 +6,25 @@ Maxsize=2147483647
 
 mkfs return value: 0
 fsck return value: 0
-acfd4cae9ccfc3bc1a12d3c4a39f95c9
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000400  10 00 00 00 01 00 01 00  05 00 00 00 ff ff ff 7f  |................|
+00000410  68 24 01 00 10 00 00 00  00 00 00 00 00 00 00 00  |h$..............|
+00000420  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000800  03 00 fe ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000810  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00000c00  03 f0 ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000c10  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00001000  ed 41 02 00 00 00 00 00  20 00 00 00 34 29 bd 55  |.A...... ...4).U|
+00001010  34 29 bd 55 34 29 bd 55  05 00 00 00 00 00 00 00  |4).U4).U........|
+00001020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001400  01 00 2e 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001410  01 00 2e 2e 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001420  00 00 2e 62 61 64 62 6c  6f 63 6b 73 00 00 00 00  |...badblocks....|
+00001430  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00004000
diff --git a/tests/expected/minix/fsck-images-v2c30 b/tests/expected/minix/fsck-images-v2c30
index b3795a5..5f35ed7 100644
--- a/tests/expected/minix/fsck-images-v2c30
+++ b/tests/expected/minix/fsck-images-v2c30
@@ -6,4 +6,27 @@ Maxsize=2147483647
 
 mkfs return value: 0
 fsck return value: 0
-1277a1e3a3cefa6afc63a9e38e4cfdf8
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000400  10 00 00 00 01 00 01 00  05 00 00 00 ff ff ff 7f  |................|
+00000410  78 24 01 00 10 00 00 00  00 00 00 00 00 00 00 00  |x$..............|
+00000420  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000800  03 00 fe ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000810  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00000c00  03 f0 ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000c10  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00001000  ed 41 02 00 00 00 00 00  40 00 00 00 34 29 bd 55  |.A......@...4).U|
+00001010  34 29 bd 55 34 29 bd 55  05 00 00 00 00 00 00 00  |4).U4).U........|
+00001020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001400  01 00 2e 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001410  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001420  01 00 2e 2e 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001430  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001440  00 00 2e 62 61 64 62 6c  6f 63 6b 73 00 00 00 00  |...badblocks....|
+00001450  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00004000
diff --git a/tests/expected/minix/fsck-images-v3c60 b/tests/expected/minix/fsck-images-v3c60
index cfb9b83..be2b54d 100644
--- a/tests/expected/minix/fsck-images-v3c60
+++ b/tests/expected/minix/fsck-images-v3c60
@@ -6,4 +6,29 @@ Maxsize=2147483647
 
 mkfs return value: 0
 fsck return value: 0
-ca57b3604ed9476108ac41d1bdb1e1d5
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000400  10 00 00 00 00 00 01 00  01 00 05 00 00 00 00 00  |................|
+00000410  ff ff ff 7f 10 00 00 00  5a 4d 00 00 00 04 00 00  |........ZM......|
+00000420  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000800  03 00 fe ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000810  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00000c00  03 f0 ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000c10  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00001000  ed 41 02 00 00 00 00 00  80 00 00 00 34 29 bd 55  |.A..........4).U|
+00001010  34 29 bd 55 34 29 bd 55  05 00 00 00 00 00 00 00  |4).U4).U........|
+00001020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001400  01 00 00 00 2e 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001410  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001440  01 00 00 00 2e 2e 00 00  00 00 00 00 00 00 00 00  |................|
+00001450  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001480  00 00 00 00 2e 62 61 64  62 6c 6f 63 6b 73 00 00  |.....badblocks..|
+00001490  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00004000
diff --git a/tests/ts/minix/fsck-images b/tests/ts/minix/fsck-images
index cb0a9e3..2248602 100755
--- a/tests/ts/minix/fsck-images
+++ b/tests/ts/minix/fsck-images
@@ -23,6 +23,7 @@ ts_skip_nonroot
 
 ts_check_test_command "$TS_CMD_FSCKMINIX"
 ts_check_test_command "$TS_HELPER_MKFS_MINIX"
+ts_check_test_command "$TS_CMD_HEXDUMP"
 
 export MKFS_MINIX_TEST_SECOND_SINCE_EPOCH='1438460212'
 
@@ -34,7 +35,7 @@ check_minix_fs_type() {
 	echo "mkfs return value: $?" >> $TS_OUTPUT
 	$TS_CMD_FSCKMINIX $img >> $TS_OUTPUT 2>&1
 	echo "fsck return value: $?" >> $TS_OUTPUT
-	md5sum $img | awk '{print $1}' >> $TS_OUTPUT 2>&1
+	$TS_CMD_HEXDUMP -C $img >> $TS_OUTPUT 2>&1
 	rm -f $img
 	ts_finalize_subtest
 }
@@ -51,7 +52,7 @@ cp "$TS_SELF/broken-root" $img
 "$TS_CMD_FSCKMINIX" -sav $img |
 	sed 's/Filesystem on .* is dirty/Filesystem auto-fix is dirty/' > $TS_OUTPUT 2>&1
 echo $? >> $TS_OUTPUT
-md5sum $img | sed 's/  .*auto-fix/ auto-fix/' >> $TS_OUTPUT
+$TS_CMD_HEXDUMP -C $img >> $TS_OUTPUT 2>&1
 ts_finalize_subtest
 
 ts_init_subtest "bug.773892"
-- 
1.8.4.5

