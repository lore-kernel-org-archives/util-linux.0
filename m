Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:55983 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754296AbcCMWbZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 Mar 2016 18:31:25 -0400
Received: from tenfore.ga-group.nl ([2.247.85.77]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0M96Jd-1aXDmg2i2H-00CRE0 for
 <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 23:31:23 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 05/12] tests: improve skipping of old btrfs-tools
Date: Sun, 13 Mar 2016 23:31:13 +0100
Message-Id: <1457908280-15588-6-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
References: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Older Linux distributions came with differently incomplete
btrfs-tools 0.19+git versions (2009-2013). Old mkfs.btrfs
needs minimum device size 256M.

Note the most simple way to skip btrfs-tools < 3.14 would be
  btrfs property --help 2>&1 || ts_skip "btrfs too old"
but I want to include 3.12 because of Ubuntu Trusty on travis.

This patch partly reverts/rewrites the following commits:
7e604f3c - tests: don't skip case "output undefined"
076153f8 - tests: don't compare btrfs mount options
370d31f7 - tests: skip btrfs tests if version too old

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/libmount/context-utab    |  1 -
 tests/expected/libmount/context-utab-py |  1 -
 tests/ts/libmount/context-utab          | 67 ++++++++++++++++----------------
 tests/ts/libmount/context-utab-py       | 68 ++++++++++++++++-----------------
 tests/ts/mount/fstab-btrfs              |  8 ++--
 5 files changed, 73 insertions(+), 72 deletions(-)

diff --git a/tests/expected/libmount/context-utab b/tests/expected/libmount/context-utab
index 10d4d56..7b403e5 100644
--- a/tests/expected/libmount/context-utab
+++ b/tests/expected/libmount/context-utab
@@ -1,5 +1,4 @@
 Create partitions
 Create filesystem
 Do tests...
-Create filesystem [btrfs]
 ...done.
diff --git a/tests/expected/libmount/context-utab-py b/tests/expected/libmount/context-utab-py
index 10d4d56..7b403e5 100644
--- a/tests/expected/libmount/context-utab-py
+++ b/tests/expected/libmount/context-utab-py
@@ -1,5 +1,4 @@
 Create partitions
 Create filesystem
 Do tests...
-Create filesystem [btrfs]
 ...done.
diff --git a/tests/ts/libmount/context-utab b/tests/ts/libmount/context-utab
index 4eb68ff..91a2404 100755
--- a/tests/ts/libmount/context-utab
+++ b/tests/ts/libmount/context-utab
@@ -15,7 +15,6 @@ ts_check_test_command "$TS_CMD_UUIDGEN"
 
 ts_skip_nonroot
 ts_check_prog "mkfs.ext4"
-ts_check_prog "mkfs.btrfs"
 
 TESTPROG="$TS_HELPER_LIBMOUNT_CONTEXT"
 LABEL=libmount-test
@@ -25,7 +24,7 @@ MOUNTPOINT="$TS_MOUNTPOINT"
 [ -x $TESTPROG ] || ts_skip "test not compiled"
 
 # set global variable TS_DEVICE
-ts_scsi_debug_init dev_size_mb=100
+ts_scsi_debug_init dev_size_mb=257
 DEVNAME=$(basename $TS_DEVICE)
 
 ts_log "Create partitions"
@@ -94,37 +93,39 @@ grep -q $DEVICE $LIBMOUNT_UTAB && \
 ts_finalize_subtest
 
 
-$TS_CMD_WIPEFS -a  $DEVICE &> /dev/null
-ts_log "Create filesystem [btrfs]"
-mkfs.btrfs -L "$LABEL" $DEVICE &> /dev/null
-udevadm settle
-
-mount -t btrfs $DEVICE $MOUNTPOINT &> /dev/null
-btrfs subvolume create $MOUNTPOINT/sub &> /dev/null
-umount $MOUNTPOINT &> /dev/null
-
-udevadm settle
-
-ts_init_subtest "mount-uhelper-subvol"
-mkdir -p $MOUNTPOINT &>  /dev/null
-ts_valgrind $TESTPROG --mount -o uhelper=foo,rw,subvol=sub $DEVICE  $MOUNTPOINT >> $TS_OUTPUT 2>&1
-grep -q $DEVICE $LIBMOUNT_UTAB || \
-	echo "cannot find $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
-ts_finalize_subtest
-
-# Don't temporary write btrfs mount options to the test output,
-# the options depend on kernel version (since 4.2 it contains
-# subvol= and subvolid=).
-#
-#ts_log "All mount options (btrfs subvolume + utab) ---"
-#$TS_CMD_FINDMNT --mtab $MOUNTPOINT -o OPTIONS -n >> $TS_OUTPUT 2>&1
-#ts_log "---"
-
-ts_init_subtest "umount-subvol"
-ts_valgrind $TESTPROG --umount $MOUNTPOINT >> $TS_OUTPUT 2>&1
-grep -q $DEVICE $LIBMOUNT_UTAB && \
-	echo "umount (mountpoint) failed: found $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
-ts_finalize_subtest
+if type "mkfs.btrfs" &>/dev/null && mkfs.btrfs --version &>/dev/null; then
+	$TS_CMD_WIPEFS -a  $DEVICE &> /dev/null
+	#ts_log "Create filesystem [btrfs]"
+	mkfs.btrfs -L "$LABEL" $DEVICE &> /dev/null
+	udevadm settle
+
+	mount -t btrfs $DEVICE $MOUNTPOINT &> /dev/null
+	btrfs subvolume create $MOUNTPOINT/sub &> /dev/null
+	umount $MOUNTPOINT &> /dev/null
+
+	udevadm settle
+
+	ts_init_subtest "mount-uhelper-subvol"
+	mkdir -p $MOUNTPOINT &>  /dev/null
+	ts_valgrind $TESTPROG --mount -o uhelper=foo,rw,subvol=sub $DEVICE  $MOUNTPOINT >> $TS_OUTPUT 2>&1
+	grep -q $DEVICE $LIBMOUNT_UTAB || \
+		echo "cannot find $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
+	ts_finalize_subtest
+
+	# Don't temporary write btrfs mount options to the test output,
+	# the options depend on kernel version (since 4.2 it contains
+	# subvol= and subvolid=).
+	#
+	#ts_log "All mount options (btrfs subvolume + utab) ---"
+	#$TS_CMD_FINDMNT --mtab $MOUNTPOINT -o OPTIONS -n >> $TS_OUTPUT 2>&1
+	#ts_log "---"
+
+	ts_init_subtest "umount-subvol"
+	ts_valgrind $TESTPROG --umount $MOUNTPOINT >> $TS_OUTPUT 2>&1
+	grep -q $DEVICE $LIBMOUNT_UTAB && \
+		echo "umount (mountpoint) failed: found $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
+	ts_finalize_subtest
+fi
 
 ts_log "...done."
 rmmod scsi_debug
diff --git a/tests/ts/libmount/context-utab-py b/tests/ts/libmount/context-utab-py
index b781faf..ae565ad 100755
--- a/tests/ts/libmount/context-utab-py
+++ b/tests/ts/libmount/context-utab-py
@@ -14,7 +14,6 @@ ts_check_test_command "$TS_CMD_UUIDGEN"
 
 ts_skip_nonroot
 ts_check_prog "mkfs.ext4"
-ts_check_prog "mkfs.btrfs"
 
 ts_init_py libmount
 
@@ -26,7 +25,7 @@ UUID=$($TS_CMD_UUIDGEN)
 MOUNTPOINT="$TS_MOUNTPOINT"
 
 # set global variable TS_DEVICE
-ts_scsi_debug_init dev_size_mb=100
+ts_scsi_debug_init dev_size_mb=257
 DEVNAME=$(basename $TS_DEVICE)
 
 ts_log "Create partitions"
@@ -95,38 +94,39 @@ grep -q $DEVICE $LIBMOUNT_UTAB && \
 ts_finalize_subtest
 
 
-$TS_CMD_WIPEFS -a  $DEVICE &> /dev/null
-ts_log "Create filesystem [btrfs]"
-mkfs.btrfs -L "$LABEL" $DEVICE &> /dev/null
-udevadm settle
-
-mount -t btrfs $DEVICE $MOUNTPOINT &> /dev/null
-btrfs subvolume create $MOUNTPOINT/sub &> /dev/null
-umount $MOUNTPOINT &> /dev/null
-
-udevadm settle
-
-ts_init_subtest "mount-uhelper-subvol"
-mkdir -p $MOUNTPOINT &>  /dev/null
-$PYTHON $TESTPROG --mount -o uhelper=foo,rw,subvol=sub $DEVICE  $MOUNTPOINT >> $TS_OUTPUT 2>&1
-grep -q $DEVICE $LIBMOUNT_UTAB || \
-	echo "cannot find $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
-ts_finalize_subtest
-
-
-# Don't temporary write btrfs mount options to the test output,
-# the options depend on kernel version (since 4.2 it contains
-# subvol= and subvolid=).
-#
-#ts_log "All mount options (btrfs subvolume + utab) ---"
-#$TS_CMD_FINDMNT --mtab $MOUNTPOINT -o OPTIONS -n >> $TS_OUTPUT 2>&1
-#ts_log "---"
-
-ts_init_subtest "umount-subvol"
-$PYTHON $TESTPROG --umount $MOUNTPOINT >> $TS_OUTPUT 2>&1
-grep -q $DEVICE $LIBMOUNT_UTAB && \
-	echo "umount (mountpoint) failed: found $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
-ts_finalize_subtest
+if type "mkfs.btrfs" &>/dev/null && mkfs.btrfs --version &>/dev/null; then
+	$TS_CMD_WIPEFS -a  $DEVICE &> /dev/null
+	#ts_log "Create filesystem [btrfs]"
+	mkfs.btrfs -L "$LABEL" $DEVICE &> /dev/null
+	udevadm settle
+
+	mount -t btrfs $DEVICE $MOUNTPOINT &> /dev/null
+	btrfs subvolume create $MOUNTPOINT/sub &> /dev/null
+	umount $MOUNTPOINT &> /dev/null
+
+	udevadm settle
+
+	ts_init_subtest "mount-uhelper-subvol"
+	mkdir -p $MOUNTPOINT &>  /dev/null
+	$PYTHON $TESTPROG --mount -o uhelper=foo,rw,subvol=sub $DEVICE  $MOUNTPOINT >> $TS_OUTPUT 2>&1
+	grep -q $DEVICE $LIBMOUNT_UTAB || \
+		echo "cannot find $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
+	ts_finalize_subtest
+
+	# Don't temporary write btrfs mount options to the test output,
+	# the options depend on kernel version (since 4.2 it contains
+	# subvol= and subvolid=).
+	#
+	#ts_log "All mount options (btrfs subvolume + utab) ---"
+	#$TS_CMD_FINDMNT --mtab $MOUNTPOINT -o OPTIONS -n >> $TS_OUTPUT 2>&1
+	#ts_log "---"
+
+	ts_init_subtest "umount-subvol"
+	$PYTHON $TESTPROG --umount $MOUNTPOINT >> $TS_OUTPUT 2>&1
+	grep -q $DEVICE $LIBMOUNT_UTAB && \
+		echo "umount (mountpoint) failed: found $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
+	ts_finalize_subtest
+fi
 
 ts_log "...done."
 rmmod scsi_debug
diff --git a/tests/ts/mount/fstab-btrfs b/tests/ts/mount/fstab-btrfs
index 30aed1d..6abbd0b 100755
--- a/tests/ts/mount/fstab-btrfs
+++ b/tests/ts/mount/fstab-btrfs
@@ -30,8 +30,10 @@ ts_check_prog "mkfs.btrfs"
 ts_check_prog "btrfs"
 
 # btrfs feature check
-btrfs inspect rootid bla 2>&1 | grep -q "unknown token" \
-	&& ts_skip "btrfs too old"
+if ! btrfs inspect-internal --help &>/dev/null || \
+   btrfs inspect-internal rootid bla 2>&1 | grep -q "unknown token"; then
+	ts_skip "btrfs too old"
+fi
 
 TS_MOUNTPOINT_ANY="$TS_MOUNTPOINT"
 TS_MOUNTPOINT_CREATE="$TS_MOUNTPOINT-create"
@@ -62,7 +64,7 @@ mkdir bind-point
 mkdir -p d1/dd1/ddd1
 cd ./d1/dd1/ddd1
 btrfs subvol create s2 >/dev/null
-DEFAULT_SUBVOLID=$(btrfs inspect rootid s2)
+DEFAULT_SUBVOLID=$(btrfs inspect-internal rootid s2)
 btrfs subvol set-default $DEFAULT_SUBVOLID . >/dev/null
 NON_DEFAULT_SUBVOLID=$(btrfs subvol list "$TS_MOUNTPOINT_CREATE" | while read dummy id rest ; do if test $id = $DEFAULT_SUBVOLID ; then continue ; fi ; echo $id ; done)
 cd ../../../..
-- 
1.8.4.5

