Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:50855 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755129AbcCCBLM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Mar 2016 20:11:12 -0500
Received: from tenfore.ga-group.nl ([77.12.144.244]) by mail.gmx.com
 (mrgmx102) with ESMTPSA (Nemesis) id 0M1iGk-1Zm3ol4Aqg-00tmH8 for
 <util-linux@vger.kernel.org>; Thu, 03 Mar 2016 02:11:10 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 7/7] tests: minix, add a useful non-root check
Date: Thu,  3 Mar 2016 02:11:05 +0100
Message-Id: <1456967465-16128-8-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456967465-16128-1-git-send-email-sweet_f_a@gmx.de>
References: <1456967465-16128-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/minix/fsck | 366 +++++++++++++++++++++++++++++++++++++++++++++-
 tests/ts/minix/fsck       |  45 ++++--
 tests/ts/minix/mkfs       |   2 +-
 3 files changed, 396 insertions(+), 17 deletions(-)

diff --git a/tests/expected/minix/fsck b/tests/expected/minix/fsck
index 84de725..4d65d12 100644
--- a/tests/expected/minix/fsck
+++ b/tests/expected/minix/fsck
@@ -1,8 +1,370 @@
-create minix fs
+#####################################
+$ mkfs.minix   image
 1728 inodes
 5120 blocks
 Firstdatazone=58 (58)
 Zonesize=1024
 Maxsize=268966912
 
-fsck minix fs
+return mkfs: 0
+$ fsck.minix -lavsf image
+Forcing filesystem check on image.
+1728 inodes
+5120 blocks
+Firstdatazone=58 (58)
+Zonesize=1024
+Maxsize=268966912
+Filesystem state=1
+namelen=30
+
+
+     1 inodes used (0%)
+    59 zones used (1%)
+
+     0 regular files
+     1 directories
+     0 character device files
+     0 block device files
+     0 links
+     0 symbolic links
+------
+     1 files
+return fsck: 0
+#####################################
+$ mkfs.minix  -n 14 image
+1728 inodes
+5120 blocks
+Firstdatazone=58 (58)
+Zonesize=1024
+Maxsize=268966912
+
+return mkfs: 0
+$ fsck.minix -lavsf image
+Forcing filesystem check on image.
+1728 inodes
+5120 blocks
+Firstdatazone=58 (58)
+Zonesize=1024
+Maxsize=268966912
+Filesystem state=1
+namelen=14
+
+
+     1 inodes used (0%)
+    59 zones used (1%)
+
+     0 regular files
+     1 directories
+     0 character device files
+     0 block device files
+     0 links
+     0 symbolic links
+------
+     1 files
+return fsck: 0
+#####################################
+$ mkfs.minix  -n 30 image
+1728 inodes
+5120 blocks
+Firstdatazone=58 (58)
+Zonesize=1024
+Maxsize=268966912
+
+return mkfs: 0
+$ fsck.minix -lavsf image
+Forcing filesystem check on image.
+1728 inodes
+5120 blocks
+Firstdatazone=58 (58)
+Zonesize=1024
+Maxsize=268966912
+Filesystem state=1
+namelen=30
+
+
+     1 inodes used (0%)
+    59 zones used (1%)
+
+     0 regular files
+     1 directories
+     0 character device files
+     0 block device files
+     0 links
+     0 symbolic links
+------
+     1 files
+return fsck: 0
+#####################################
+$ mkfs.minix  -n 60 image
+mkfs.minix: unsupported name length: 60
+return mkfs: 8
+#####################################
+$ mkfs.minix -1  image
+1728 inodes
+5120 blocks
+Firstdatazone=58 (58)
+Zonesize=1024
+Maxsize=268966912
+
+return mkfs: 0
+$ fsck.minix -lavsf image
+Forcing filesystem check on image.
+1728 inodes
+5120 blocks
+Firstdatazone=58 (58)
+Zonesize=1024
+Maxsize=268966912
+Filesystem state=1
+namelen=30
+
+
+     1 inodes used (0%)
+    59 zones used (1%)
+
+     0 regular files
+     1 directories
+     0 character device files
+     0 block device files
+     0 links
+     0 symbolic links
+------
+     1 files
+return fsck: 0
+#####################################
+$ mkfs.minix -1 -n 14 image
+1728 inodes
+5120 blocks
+Firstdatazone=58 (58)
+Zonesize=1024
+Maxsize=268966912
+
+return mkfs: 0
+$ fsck.minix -lavsf image
+Forcing filesystem check on image.
+1728 inodes
+5120 blocks
+Firstdatazone=58 (58)
+Zonesize=1024
+Maxsize=268966912
+Filesystem state=1
+namelen=14
+
+
+     1 inodes used (0%)
+    59 zones used (1%)
+
+     0 regular files
+     1 directories
+     0 character device files
+     0 block device files
+     0 links
+     0 symbolic links
+------
+     1 files
+return fsck: 0
+#####################################
+$ mkfs.minix -1 -n 30 image
+1728 inodes
+5120 blocks
+Firstdatazone=58 (58)
+Zonesize=1024
+Maxsize=268966912
+
+return mkfs: 0
+$ fsck.minix -lavsf image
+Forcing filesystem check on image.
+1728 inodes
+5120 blocks
+Firstdatazone=58 (58)
+Zonesize=1024
+Maxsize=268966912
+Filesystem state=1
+namelen=30
+
+
+     1 inodes used (0%)
+    59 zones used (1%)
+
+     0 regular files
+     1 directories
+     0 character device files
+     0 block device files
+     0 links
+     0 symbolic links
+------
+     1 files
+return fsck: 0
+#####################################
+$ mkfs.minix -1 -n 60 image
+mkfs.minix: unsupported name length: 60
+return mkfs: 8
+#####################################
+$ mkfs.minix -2  image
+1712 inodes
+5120 blocks
+Firstdatazone=111 (111)
+Zonesize=1024
+Maxsize=2147483647
+
+return mkfs: 0
+$ fsck.minix -lavsf image
+Forcing filesystem check on image.
+1712 inodes
+5120 blocks
+Firstdatazone=111 (111)
+Zonesize=1024
+Maxsize=2147483647
+Filesystem state=1
+namelen=30
+
+
+     1 inodes used (0%)
+   112 zones used (2%)
+
+     0 regular files
+     1 directories
+     0 character device files
+     0 block device files
+     0 links
+     0 symbolic links
+------
+     1 files
+return fsck: 0
+#####################################
+$ mkfs.minix -2 -n 14 image
+1712 inodes
+5120 blocks
+Firstdatazone=111 (111)
+Zonesize=1024
+Maxsize=2147483647
+
+return mkfs: 0
+$ fsck.minix -lavsf image
+Forcing filesystem check on image.
+1712 inodes
+5120 blocks
+Firstdatazone=111 (111)
+Zonesize=1024
+Maxsize=2147483647
+Filesystem state=1
+namelen=14
+
+
+     1 inodes used (0%)
+   112 zones used (2%)
+
+     0 regular files
+     1 directories
+     0 character device files
+     0 block device files
+     0 links
+     0 symbolic links
+------
+     1 files
+return fsck: 0
+#####################################
+$ mkfs.minix -2 -n 30 image
+1712 inodes
+5120 blocks
+Firstdatazone=111 (111)
+Zonesize=1024
+Maxsize=2147483647
+
+return mkfs: 0
+$ fsck.minix -lavsf image
+Forcing filesystem check on image.
+1712 inodes
+5120 blocks
+Firstdatazone=111 (111)
+Zonesize=1024
+Maxsize=2147483647
+Filesystem state=1
+namelen=30
+
+
+     1 inodes used (0%)
+   112 zones used (2%)
+
+     0 regular files
+     1 directories
+     0 character device files
+     0 block device files
+     0 links
+     0 symbolic links
+------
+     1 files
+return fsck: 0
+#####################################
+$ mkfs.minix -2 -n 60 image
+mkfs.minix: unsupported name length: 60
+return mkfs: 8
+#####################################
+$ mkfs.minix -3  image
+1712 inodes
+5120 blocks
+Firstdatazone=111 (111)
+Zonesize=1024
+Maxsize=2147483647
+
+return mkfs: 0
+$ fsck.minix -lavsf image
+Forcing filesystem check on image.
+1712 inodes
+5120 blocks
+Firstdatazone=111 (111)
+Zonesize=1024
+Maxsize=2147483647
+namelen=60
+
+
+     1 inodes used (0%)
+   112 zones used (2%)
+
+     0 regular files
+     1 directories
+     0 character device files
+     0 block device files
+     0 links
+     0 symbolic links
+------
+     1 files
+return fsck: 0
+#####################################
+$ mkfs.minix -3 -n 14 image
+mkfs.minix: unsupported name length: 14
+return mkfs: 8
+#####################################
+$ mkfs.minix -3 -n 30 image
+mkfs.minix: unsupported name length: 30
+return mkfs: 8
+#####################################
+$ mkfs.minix -3 -n 60 image
+1712 inodes
+5120 blocks
+Firstdatazone=111 (111)
+Zonesize=1024
+Maxsize=2147483647
+
+return mkfs: 0
+$ fsck.minix -lavsf image
+Forcing filesystem check on image.
+1712 inodes
+5120 blocks
+Firstdatazone=111 (111)
+Zonesize=1024
+Maxsize=2147483647
+namelen=60
+
+
+     1 inodes used (0%)
+   112 zones used (2%)
+
+     0 regular files
+     1 directories
+     0 character device files
+     0 block device files
+     0 links
+     0 symbolic links
+------
+     1 files
+return fsck: 0
diff --git a/tests/ts/minix/fsck b/tests/ts/minix/fsck
index b57b20e..21fbde8 100755
--- a/tests/ts/minix/fsck
+++ b/tests/ts/minix/fsck
@@ -15,25 +15,42 @@
 # GNU General Public License for more details.
 #
 TS_TOPDIR="${0%/*}/../.."
-TS_DESC="mkfs checksums"
+TS_DESC="mkfs fsck"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
 ts_check_test_command "$TS_CMD_MKMINIX"
-
-ts_skip_nonroot
-ts_check_losetup
-
-IMAGE="$TS_OUTDIR/${TS_TESTNAME}-loop.img"
-ts_device_init
-DEVICE=$TS_LODEV
-
-ts_log "create minix fs"
-$TS_CMD_MKMINIX $DEVICE >> $TS_OUTPUT 2>&1
-
-ts_log "fsck minix fs"
-$TS_CMD_FSCKMINIX $DEVICE >> $TS_OUTPUT 2>&1
+ts_check_test_command "$TS_CMD_FSCKMINIX"
+
+mkfs_and_fsck_minix() {
+	local ret
+	ts_log "#####################################"
+	ts_log "$ mkfs.minix $1 image"
+	$TS_CMD_MKMINIX $1 $img >> $TS_OUTPUT 2>&1
+	ret=$?
+	echo "return mkfs: $ret" >> $TS_OUTPUT
+	test $ret = 0 || return $ret
+
+	ts_log "$ fsck.minix -lavsf image"
+	$TS_CMD_FSCKMINIX -lavsf $img >> $TS_OUTPUT 2>&1
+	ret=$?
+	echo "return fsck: $ret" >> $TS_OUTPUT
+	return $ret
+}
+
+img=$(ts_image_init)
+
+# TODO looping over arbitrary badblock files (-l bad) gives a lot segfaults
+for ver in "" "-1" "-2" "-3"; do
+for n in "" "-n 14" "-n 30" "-n 60"; do
+	mkfs_and_fsck_minix "$ver $n"
+done
+done
+
+rm -f $img
+
+sed -i "s@$img@image@g" $TS_OUTPUT
 
 ts_finalize
 
diff --git a/tests/ts/minix/mkfs b/tests/ts/minix/mkfs
index b5a01da..3f0f83f 100755
--- a/tests/ts/minix/mkfs
+++ b/tests/ts/minix/mkfs
@@ -15,7 +15,7 @@
 # GNU General Public License for more details.
 #
 TS_TOPDIR="${0%/*}/../.."
-TS_DESC="mkfs"
+TS_DESC="mkfs mount"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
-- 
1.8.4.5

