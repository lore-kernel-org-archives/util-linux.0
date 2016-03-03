Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:64923 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754042AbcCCBLL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Mar 2016 20:11:11 -0500
Received: from tenfore.ga-group.nl ([77.12.144.244]) by mail.gmx.com
 (mrgmx102) with ESMTPSA (Nemesis) id 0LnlmV-1ZxpNS2r3X-00hsCJ for
 <util-linux@vger.kernel.org>; Thu, 03 Mar 2016 02:11:09 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 6/7] tests: fix minix tests for big endian
Date: Thu,  3 Mar 2016 02:11:04 +0100
Message-Id: <1456967465-16128-7-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456967465-16128-1-git-send-email-sweet_f_a@gmx.de>
References: <1456967465-16128-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

You may diff the new .BE files with non-BE file to see whether they
look fine.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/minix/fsck-images-badblocks.BE    | 35 ++++++++++++++++++++++++
 tests/expected/minix/fsck-images-check-blocks.BE | 29 ++++++++++++++++++++
 tests/expected/minix/fsck-images-v1c14.BE        | 28 +++++++++++++++++++
 tests/expected/minix/fsck-images-v1c30.BE        | 29 ++++++++++++++++++++
 tests/expected/minix/fsck-images-v2c14.BE        | 29 ++++++++++++++++++++
 tests/expected/minix/fsck-images-v2c30.BE        | 30 ++++++++++++++++++++
 tests/expected/minix/fsck-images-v3c60.BE        | 31 +++++++++++++++++++++
 tests/ts/minix/fsck-images                       | 10 +++++++
 8 files changed, 221 insertions(+)
 create mode 100644 tests/expected/minix/fsck-images-badblocks.BE
 create mode 100644 tests/expected/minix/fsck-images-check-blocks.BE
 create mode 100644 tests/expected/minix/fsck-images-v1c14.BE
 create mode 100644 tests/expected/minix/fsck-images-v1c30.BE
 create mode 100644 tests/expected/minix/fsck-images-v2c14.BE
 create mode 100644 tests/expected/minix/fsck-images-v2c30.BE
 create mode 100644 tests/expected/minix/fsck-images-v3c60.BE

diff --git a/tests/expected/minix/fsck-images-badblocks.BE b/tests/expected/minix/fsck-images-badblocks.BE
new file mode 100644
index 0000000..724f4de
--- /dev/null
+++ b/tests/expected/minix/fsck-images-badblocks.BE
@@ -0,0 +1,35 @@
+32 inodes
+16 blocks
+Firstdatazone=5 (5)
+Zonesize=1024
+Maxsize=268966912
+
+2 bad blocks
+mkfs return value: 0
+fsck return value: 0
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000400  00 20 00 10 00 01 00 01  00 05 00 00 10 08 1c 00  |. ..............|
+00000410  13 8f 00 01 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00000420  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000800  07 00 00 00 fe ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000810  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00000c00  33 f0 ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |3...............|
+00000c10  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00001000  41 ed 00 00 00 00 00 60  55 bd 29 34 00 02 00 05  |A......`U.)4....|
+00001010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001020  80 00 00 00 00 00 08 00  55 bd 29 34 00 01 00 08  |........U.)4....|
+00001030  00 09 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001400  00 01 2e 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001410  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001420  00 01 2e 2e 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001430  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001440  00 02 2e 62 61 64 62 6c  6f 63 6b 73 00 00 00 00  |...badblocks....|
+00001450  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00004000
diff --git a/tests/expected/minix/fsck-images-check-blocks.BE b/tests/expected/minix/fsck-images-check-blocks.BE
new file mode 100644
index 0000000..8bc29b8
--- /dev/null
+++ b/tests/expected/minix/fsck-images-check-blocks.BE
@@ -0,0 +1,29 @@
+32 inodes
+16 blocks
+Firstdatazone=5 (5)
+Zonesize=1024
+Maxsize=268966912
+
+mkfs return value: 0
+fsck return value: 0
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000400  00 20 00 10 00 01 00 01  00 05 00 00 10 08 1c 00  |. ..............|
+00000410  13 8f 00 01 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00000420  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000800  03 00 00 00 fe ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000810  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00000c00  03 f0 ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000c10  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00001000  41 ed 00 00 00 00 00 40  55 bd 29 34 00 02 00 05  |A......@U.)4....|
+00001010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001400  00 01 2e 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001410  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001420  00 01 2e 2e 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001430  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00004000
diff --git a/tests/expected/minix/fsck-images-v1c14.BE b/tests/expected/minix/fsck-images-v1c14.BE
new file mode 100644
index 0000000..5df561c
--- /dev/null
+++ b/tests/expected/minix/fsck-images-v1c14.BE
@@ -0,0 +1,28 @@
+32 inodes
+16 blocks
+Firstdatazone=5 (5)
+Zonesize=1024
+Maxsize=268966912
+
+mkfs return value: 0
+fsck return value: 0
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000400  00 20 00 10 00 01 00 01  00 05 00 00 10 08 1c 00  |. ..............|
+00000410  13 7f 00 01 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00000420  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000800  03 00 00 00 fe ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000810  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00000c00  03 f0 ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000c10  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00001000  41 ed 00 00 00 00 00 20  55 bd 29 34 00 02 00 05  |A...... U.)4....|
+00001010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001400  00 01 2e 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001410  00 01 2e 2e 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001420  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00004000
diff --git a/tests/expected/minix/fsck-images-v1c30.BE b/tests/expected/minix/fsck-images-v1c30.BE
new file mode 100644
index 0000000..8bc29b8
--- /dev/null
+++ b/tests/expected/minix/fsck-images-v1c30.BE
@@ -0,0 +1,29 @@
+32 inodes
+16 blocks
+Firstdatazone=5 (5)
+Zonesize=1024
+Maxsize=268966912
+
+mkfs return value: 0
+fsck return value: 0
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000400  00 20 00 10 00 01 00 01  00 05 00 00 10 08 1c 00  |. ..............|
+00000410  13 8f 00 01 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00000420  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000800  03 00 00 00 fe ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000810  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00000c00  03 f0 ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000c10  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00001000  41 ed 00 00 00 00 00 40  55 bd 29 34 00 02 00 05  |A......@U.)4....|
+00001010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001400  00 01 2e 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001410  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001420  00 01 2e 2e 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001430  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00004000
diff --git a/tests/expected/minix/fsck-images-v2c14.BE b/tests/expected/minix/fsck-images-v2c14.BE
new file mode 100644
index 0000000..8b67386
--- /dev/null
+++ b/tests/expected/minix/fsck-images-v2c14.BE
@@ -0,0 +1,29 @@
+16 inodes
+16 blocks
+Firstdatazone=5 (5)
+Zonesize=1024
+Maxsize=2147483647
+
+mkfs return value: 0
+fsck return value: 0
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000400  00 10 00 00 00 01 00 01  00 05 00 00 7f ff ff ff  |................|
+00000410  24 68 00 01 00 00 00 10  00 00 00 00 00 00 00 00  |$h..............|
+00000420  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000800  03 00 fe ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000810  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00000c00  03 f0 ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000c10  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00001000  41 ed 00 02 00 00 00 00  00 00 00 20 55 bd 29 34  |A.......... U.)4|
+00001010  55 bd 29 34 55 bd 29 34  00 00 00 05 00 00 00 00  |U.)4U.)4........|
+00001020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001400  00 01 2e 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001410  00 01 2e 2e 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001420  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00004000
diff --git a/tests/expected/minix/fsck-images-v2c30.BE b/tests/expected/minix/fsck-images-v2c30.BE
new file mode 100644
index 0000000..722d368
--- /dev/null
+++ b/tests/expected/minix/fsck-images-v2c30.BE
@@ -0,0 +1,30 @@
+16 inodes
+16 blocks
+Firstdatazone=5 (5)
+Zonesize=1024
+Maxsize=2147483647
+
+mkfs return value: 0
+fsck return value: 0
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000400  00 10 00 00 00 01 00 01  00 05 00 00 7f ff ff ff  |................|
+00000410  24 78 00 01 00 00 00 10  00 00 00 00 00 00 00 00  |$x..............|
+00000420  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000800  03 00 fe ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000810  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00000c00  03 f0 ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000c10  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00001000  41 ed 00 02 00 00 00 00  00 00 00 40 55 bd 29 34  |A..........@U.)4|
+00001010  55 bd 29 34 55 bd 29 34  00 00 00 05 00 00 00 00  |U.)4U.)4........|
+00001020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001400  00 01 2e 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001410  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001420  00 01 2e 2e 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001430  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00004000
diff --git a/tests/expected/minix/fsck-images-v3c60.BE b/tests/expected/minix/fsck-images-v3c60.BE
new file mode 100644
index 0000000..788c01d
--- /dev/null
+++ b/tests/expected/minix/fsck-images-v3c60.BE
@@ -0,0 +1,31 @@
+16 inodes
+16 blocks
+Firstdatazone=5 (5)
+Zonesize=1024
+Maxsize=2147483647
+
+mkfs return value: 0
+fsck return value: 0
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000400  00 00 00 10 00 00 00 01  00 01 00 05 00 00 00 00  |................|
+00000410  7f ff ff ff 00 00 00 10  4d 5a 00 00 04 00 00 00  |........MZ......|
+00000420  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000800  03 00 fe ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000810  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00000c00  03 f0 ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000c10  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00001000  41 ed 00 02 00 00 00 00  00 00 00 80 55 bd 29 34  |A...........U.)4|
+00001010  55 bd 29 34 55 bd 29 34  00 00 00 05 00 00 00 00  |U.)4U.)4........|
+00001020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001400  00 00 00 01 2e 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001410  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001440  00 00 00 01 2e 2e 00 00  00 00 00 00 00 00 00 00  |................|
+00001450  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00004000
diff --git a/tests/ts/minix/fsck-images b/tests/ts/minix/fsck-images
index 4c5f675..a9341e7 100755
--- a/tests/ts/minix/fsck-images
+++ b/tests/ts/minix/fsck-images
@@ -26,10 +26,15 @@ ts_check_test_command "$TS_CMD_FSCKMINIX"
 ts_check_test_command "$TS_HELPER_MKFS_MINIX"
 ts_check_test_command "$TS_CMD_HEXDUMP"
 
+# on big endian systems some of the subtests have different expected output
+BYTE_ORDER=$($TS_HELPER_SYSINFO byte-order)
+BE_EXT=$(test "$BYTE_ORDER" = "BE" && echo ".BE")
+
 export MKFS_MINIX_TEST_SECOND_SINCE_EPOCH='1438460212'
 
 check_minix_fs_type() {
 	ts_init_subtest $1
+	TS_EXPECTED+=$BE_EXT
 	img=${TS_OUTPUT}.img
 	dd if=/dev/zero bs=1024 count=16 of=$img >/dev/null 2>&1
 	$TS_HELPER_MKFS_MINIX $2 $img >> $TS_OUTPUT 2>&1
@@ -57,6 +62,11 @@ check_minix_fs_type 'badblocks' "-l $bad"
 
 rm -f $bad
 
+# no more big endian tests below
+if test "$BYTE_ORDER" = "BE"; then
+	ts_finalize
+fi
+
 # NOTE this seems odd: a 2nd fsck run would again modify the FS
 ts_init_subtest "auto-fix"
 img=${TS_OUTPUT}.img
-- 
1.8.4.5

