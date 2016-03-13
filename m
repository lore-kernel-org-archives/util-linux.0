Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:54953 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754298AbcCMWbZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 Mar 2016 18:31:25 -0400
Received: from tenfore.ga-group.nl ([2.247.85.77]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0Ls7MZ-1Zglca42Kl-013zeM for
 <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 23:31:24 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 06/12] tests: don't use system's mount commands
Date: Sun, 13 Mar 2016 23:31:14 +0100
Message-Id: <1457908280-15588-7-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
References: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/eject/umount             | 11 ++++++-----
 tests/ts/libmount/context         |  2 +-
 tests/ts/libmount/context-py      |  2 +-
 tests/ts/libmount/context-utab    |  6 ++++--
 tests/ts/libmount/context-utab-py |  6 ++++--
 5 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/tests/ts/eject/umount b/tests/ts/eject/umount
index 28b2b99..a6e3acf 100755
--- a/tests/ts/eject/umount
+++ b/tests/ts/eject/umount
@@ -8,6 +8,7 @@ ts_init "$*"
 
 ts_check_test_command "$TS_CMD_FDISK"
 ts_check_test_command "$TS_CMD_EJECT"
+ts_check_test_command "$TS_CMD_MOUNT"
 
 ts_skip_nonroot
 ts_check_prog "mkfs.ext2"
@@ -71,7 +72,7 @@ init_device
 mkfs.ext2 -q -F $TS_DEVICE
 udevadm settle
 mkdir -p $TS_MOUNTPOINT
-mount $TS_DEVICE $TS_MOUNTPOINT
+$TS_CMD_MOUNT $TS_DEVICE $TS_MOUNTPOINT
 $TS_CMD_EJECT --force $TS_DEVICE && ts_log "Success"
 deinit_device
 ts_finalize_subtest
@@ -82,8 +83,8 @@ init_device
 init_partitions $TS_DEVICE
 mkdir -p ${TS_MOUNTPOINT}1
 mkdir -p ${TS_MOUNTPOINT}2
-mount ${TS_DEVICE}1 ${TS_MOUNTPOINT}1
-mount ${TS_DEVICE}2 ${TS_MOUNTPOINT}2
+$TS_CMD_MOUNT ${TS_DEVICE}1 ${TS_MOUNTPOINT}1
+$TS_CMD_MOUNT ${TS_DEVICE}2 ${TS_MOUNTPOINT}2
 $TS_CMD_EJECT --force $TS_DEVICE && ts_log "Success"
 deinit_device
 ts_finalize_subtest
@@ -102,8 +103,8 @@ init_device
 init_partitions $TS_DEVICE
 mkdir -p ${TS_MOUNTPOINT}1
 mkdir -p ${TS_MOUNTPOINT}2
-mount ${TS_DEVICE}1 ${TS_MOUNTPOINT}1
-mount ${TS_DEVICE}2 ${TS_MOUNTPOINT}2
+$TS_CMD_MOUNT ${TS_DEVICE}1 ${TS_MOUNTPOINT}1
+$TS_CMD_MOUNT ${TS_DEVICE}2 ${TS_MOUNTPOINT}2
 $TS_CMD_EJECT --force ${TS_DEVICE}1 && ts_log "Success"
 deinit_device
 ts_finalize_subtest
diff --git a/tests/ts/libmount/context b/tests/ts/libmount/context
index f05f661..d0d1c3d 100755
--- a/tests/ts/libmount/context
+++ b/tests/ts/libmount/context
@@ -29,7 +29,7 @@ TS_NOEXIST="$TS_OUTDIR/${TS_TESTNAME}-${TS_SUBNAME}-noex"
 [ -x $TESTPROG ] || ts_skip "test not compiled"
 
 ts_log "Init device"
-umount $MOUNTPOINT &> /dev/null
+$TS_CMD_UMOUNT $MOUNTPOINT &> /dev/null
 
 # set global variable TS_DEVICE
 ts_scsi_debug_init dev_size_mb=100
diff --git a/tests/ts/libmount/context-py b/tests/ts/libmount/context-py
index 19fec3a..c8b7b4e 100755
--- a/tests/ts/libmount/context-py
+++ b/tests/ts/libmount/context-py
@@ -31,7 +31,7 @@ TS_NOEXIST="$TS_OUTDIR/${TS_TESTNAME}-${TS_SUBNAME}-noex"
 [ -d $TS_NOEXIST ] && rmdir $TS_NOEXIST
 
 ts_log "Init device"
-umount $MOUNTPOINT &> /dev/null
+$TS_CMD_UMOUNT $MOUNTPOINT &> /dev/null
 
 # set global variable TS_DEVICE
 ts_scsi_debug_init dev_size_mb=100
diff --git a/tests/ts/libmount/context-utab b/tests/ts/libmount/context-utab
index 91a2404..a50cf67 100755
--- a/tests/ts/libmount/context-utab
+++ b/tests/ts/libmount/context-utab
@@ -10,6 +10,8 @@ ts_init "$*"
 
 ts_check_test_command "$TS_CMD_FDISK"
 ts_check_test_command "$TS_CMD_FINDMNT"
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
 ts_check_test_command "$TS_CMD_WIPEFS"
 ts_check_test_command "$TS_CMD_UUIDGEN"
 
@@ -99,9 +101,9 @@ if type "mkfs.btrfs" &>/dev/null && mkfs.btrfs --version &>/dev/null; then
 	mkfs.btrfs -L "$LABEL" $DEVICE &> /dev/null
 	udevadm settle
 
-	mount -t btrfs $DEVICE $MOUNTPOINT &> /dev/null
+	$TS_CMD_MOUNT -t btrfs $DEVICE $MOUNTPOINT &> /dev/null
 	btrfs subvolume create $MOUNTPOINT/sub &> /dev/null
-	umount $MOUNTPOINT &> /dev/null
+	$TS_CMD_UMOUNT $MOUNTPOINT &> /dev/null
 
 	udevadm settle
 
diff --git a/tests/ts/libmount/context-utab-py b/tests/ts/libmount/context-utab-py
index ae565ad..7994f4f 100755
--- a/tests/ts/libmount/context-utab-py
+++ b/tests/ts/libmount/context-utab-py
@@ -9,6 +9,8 @@ ts_init "$*"
 
 ts_check_test_command "$TS_CMD_FDISK"
 ts_check_test_command "$TS_CMD_FINDMNT"
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
 ts_check_test_command "$TS_CMD_WIPEFS"
 ts_check_test_command "$TS_CMD_UUIDGEN"
 
@@ -100,9 +102,9 @@ if type "mkfs.btrfs" &>/dev/null && mkfs.btrfs --version &>/dev/null; then
 	mkfs.btrfs -L "$LABEL" $DEVICE &> /dev/null
 	udevadm settle
 
-	mount -t btrfs $DEVICE $MOUNTPOINT &> /dev/null
+	$TS_CMD_MOUNT -t btrfs $DEVICE $MOUNTPOINT &> /dev/null
 	btrfs subvolume create $MOUNTPOINT/sub &> /dev/null
-	umount $MOUNTPOINT &> /dev/null
+	$TS_CMD_UMOUNT $MOUNTPOINT &> /dev/null
 
 	udevadm settle
 
-- 
1.8.4.5

