Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:55326 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932165AbcCGXMM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Mar 2016 18:12:12 -0500
Received: from assos.lan ([84.185.129.97]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M7YF5-1ZgiuI2qff-00xKbx for
 <util-linux@vger.kernel.org>; Tue, 08 Mar 2016 00:12:06 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 09/12] tests: don't skip case "output undefined"
Date: Tue,  8 Mar 2016 00:11:59 +0100
Message-Id: <1457392322-4974-10-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
References: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Treat missing expected files as empty and let the test fail if
there is non-empty output.

Expected output may be missing in these cases:
 1. forgot to commit the file after changing/adding a (sub)test
 2. a bug in a test where we do tricks with TS_EXPECTED
 3. and most notable if ts_die() is called before a subtest is
    initialized, e.g. in ts_scsi_debug_init()

I always wondered why we don't treat this as FAILED. Now we do
so, ts_finalize and ts_gen_diff looks much cleaner now.

The change discovers that tests with subtest were ignoring the
"non-sub" expected files which had to be fixed. BTW we removed
any zero sized files.

Moreover now we respect diff's return value. In past all test
succeeded when diff was not able to write to diffdir, e.g. when
running tests as normal user after they run as root.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/build-sys/config         |  0
 tests/expected/colcrt/functional        |  0
 tests/expected/colcrt/regressions       |  0
 tests/expected/eject/umount             |  0
 tests/expected/libmount/context-utab    |  3 +-
 tests/expected/libmount/context-utab-py |  3 +-
 tests/expected/libmount/tabdiff         |  0
 tests/expected/logger/errors            |  0
 tests/expected/logger/formats           |  0
 tests/expected/logger/options           |  0
 tests/expected/losetup/losetup          |  0
 tests/expected/minix/mkfs               |  0
 tests/expected/misc/getopt2             | 19 -----------
 tests/expected/misc/getopt3             |  0
 tests/expected/mount/fstab-btrfs        |  1 -
 tests/expected/mount/umount-alltargets  |  1 -
 tests/expected/script/options           |  0
 tests/expected/sfdisk/dos               |  0
 tests/expected/sfdisk/gpt               |  0
 tests/expected/sfdisk/resize            |  0
 tests/functions.sh                      | 48 ++++++++++-----------------
 tests/ts/libmount/context-utab          | 47 +++++++++++++-------------
 tests/ts/libmount/context-utab-py       | 58 ++++++++++++++++-----------------
 tests/ts/losetup/losetup                |  1 -
 tests/ts/misc/getopt2                   | 19 -----------
 25 files changed, 72 insertions(+), 128 deletions(-)
 delete mode 100644 tests/expected/build-sys/config
 delete mode 100644 tests/expected/colcrt/functional
 delete mode 100644 tests/expected/colcrt/regressions
 delete mode 100644 tests/expected/eject/umount
 delete mode 100644 tests/expected/libmount/tabdiff
 delete mode 100644 tests/expected/logger/errors
 delete mode 100644 tests/expected/logger/formats
 delete mode 100644 tests/expected/logger/options
 delete mode 100644 tests/expected/losetup/losetup
 delete mode 100644 tests/expected/minix/mkfs
 delete mode 100644 tests/expected/misc/getopt2
 delete mode 100644 tests/expected/misc/getopt3
 delete mode 100644 tests/expected/mount/fstab-btrfs
 delete mode 100644 tests/expected/script/options
 delete mode 100644 tests/expected/sfdisk/dos
 delete mode 100644 tests/expected/sfdisk/gpt
 delete mode 100644 tests/expected/sfdisk/resize

diff --git a/tests/expected/build-sys/config b/tests/expected/build-sys/config
deleted file mode 100644
index e69de29..0000000
diff --git a/tests/expected/colcrt/functional b/tests/expected/colcrt/functional
deleted file mode 100644
index e69de29..0000000
diff --git a/tests/expected/colcrt/regressions b/tests/expected/colcrt/regressions
deleted file mode 100644
index e69de29..0000000
diff --git a/tests/expected/eject/umount b/tests/expected/eject/umount
deleted file mode 100644
index e69de29..0000000
diff --git a/tests/expected/libmount/context-utab b/tests/expected/libmount/context-utab
index cde2e3f..2149373 100644
--- a/tests/expected/libmount/context-utab
+++ b/tests/expected/libmount/context-utab
@@ -1,9 +1,8 @@
-Init device
 Create partitions
 Create filesystem
 Do tests...
 Create filesystem [btrfs]
 All mount options (btrfs subvolume + utab) ---
-rw,relatime,ssd,uhelper=foo
+rw,relatime,ssd,space_cache,uhelper=foo
 ---
 ...done.
diff --git a/tests/expected/libmount/context-utab-py b/tests/expected/libmount/context-utab-py
index cde2e3f..2149373 100644
--- a/tests/expected/libmount/context-utab-py
+++ b/tests/expected/libmount/context-utab-py
@@ -1,9 +1,8 @@
-Init device
 Create partitions
 Create filesystem
 Do tests...
 Create filesystem [btrfs]
 All mount options (btrfs subvolume + utab) ---
-rw,relatime,ssd,uhelper=foo
+rw,relatime,ssd,space_cache,uhelper=foo
 ---
 ...done.
diff --git a/tests/expected/libmount/tabdiff b/tests/expected/libmount/tabdiff
deleted file mode 100644
index e69de29..0000000
diff --git a/tests/expected/logger/errors b/tests/expected/logger/errors
deleted file mode 100644
index e69de29..0000000
diff --git a/tests/expected/logger/formats b/tests/expected/logger/formats
deleted file mode 100644
index e69de29..0000000
diff --git a/tests/expected/logger/options b/tests/expected/logger/options
deleted file mode 100644
index e69de29..0000000
diff --git a/tests/expected/losetup/losetup b/tests/expected/losetup/losetup
deleted file mode 100644
index e69de29..0000000
diff --git a/tests/expected/minix/mkfs b/tests/expected/minix/mkfs
deleted file mode 100644
index e69de29..0000000
diff --git a/tests/expected/misc/getopt2 b/tests/expected/misc/getopt2
deleted file mode 100644
index 59ec59b..0000000
--- a/tests/expected/misc/getopt2
+++ /dev/null
@@ -1,19 +0,0 @@
-exit value: 0
-exit value: 0
-exit value: 0
-exit value: 1
-exit value: 0
-exit value: 0
-exit value: 0
-exit value: 0
-exit value: 1
-exit value: 0
-exit value: 0
-exit value: 0
-exit value: 0
-exit value: 0
-exit value: 1
-exit value: 1
-exit value: 0
-exit value: 0
-exit value: 1
diff --git a/tests/expected/misc/getopt3 b/tests/expected/misc/getopt3
deleted file mode 100644
index e69de29..0000000
diff --git a/tests/expected/mount/fstab-btrfs b/tests/expected/mount/fstab-btrfs
deleted file mode 100644
index 3582111..0000000
--- a/tests/expected/mount/fstab-btrfs
+++ /dev/null
@@ -1 +0,0 @@
-Success
diff --git a/tests/expected/mount/umount-alltargets b/tests/expected/mount/umount-alltargets
index 53514d1..a0e4679 100644
--- a/tests/expected/mount/umount-alltargets
+++ b/tests/expected/mount/umount-alltargets
@@ -1,4 +1,3 @@
-Init device
 Create partitions
 Create filesystem A
 Create filesystem B
diff --git a/tests/expected/script/options b/tests/expected/script/options
deleted file mode 100644
index e69de29..0000000
diff --git a/tests/expected/sfdisk/dos b/tests/expected/sfdisk/dos
deleted file mode 100644
index e69de29..0000000
diff --git a/tests/expected/sfdisk/gpt b/tests/expected/sfdisk/gpt
deleted file mode 100644
index e69de29..0000000
diff --git a/tests/expected/sfdisk/resize b/tests/expected/sfdisk/resize
deleted file mode 100644
index e69de29..0000000
diff --git a/tests/functions.sh b/tests/functions.sh
index 9e5d243..5d54efd 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -378,22 +378,21 @@ function ts_valgrind {
 function ts_gen_diff {
 	local res=0
 
-	if [ -s "$TS_OUTPUT" ]; then
+	[ -f "$TS_OUTPUT" ] || return 1
+	[ -f "$TS_EXPECTED" ] || TS_EXPECTED=/dev/null
 
-		# remove libtool lt- prefixes
-		sed --in-place 's/^lt\-\(.*\: \)/\1/g' $TS_OUTPUT
+	# remove libtool lt- prefixes
+	sed --in-place 's/^lt\-\(.*\: \)/\1/g' $TS_OUTPUT
 
-		[ -d "$TS_DIFFDIR" ] || mkdir -p "$TS_DIFFDIR"
-		diff -u $TS_EXPECTED $TS_OUTPUT > $TS_DIFF
+	[ -d "$TS_DIFFDIR" ] || mkdir -p "$TS_DIFFDIR"
+	diff -u $TS_EXPECTED $TS_OUTPUT > $TS_DIFF
 
-		if [ -s $TS_DIFF ]; then
-			res=1
-		else
-			rm -f $TS_DIFF;
-		fi
-	else
+	if [ $? -ne 0 ] || [ -s $TS_DIFF ]; then
 		res=1
+	else
+		rm -f $TS_DIFF;
 	fi
+
 	return $res
 }
 
@@ -409,16 +408,12 @@ function tt_gen_mem_report {
 function ts_finalize_subtest {
 	local res=0
 
-	if [ -s "$TS_EXPECTED" ]; then
-		ts_gen_diff
-		if [ $? -eq 1 ]; then
-			ts_failed_subtest "$1"
-			res=1
-		else
-			ts_ok_subtest "$(tt_gen_mem_report "$1")"
-		fi
+	ts_gen_diff
+	if [ $? -eq 1 ]; then
+		ts_failed_subtest "$1"
+		res=1
 	else
-		ts_skip_subtest "output undefined"
+		ts_ok_subtest "$(tt_gen_mem_report "$1")"
 	fi
 
 	[ $res -ne 0 ] && TS_NSUBFAILED=$(( $TS_NSUBFAILED + 1 ))
@@ -433,22 +428,15 @@ function ts_finalize {
 	ts_cleanup_on_exit
 
 	if [ $TS_NSUBTESTS -ne 0 ]; then
-		if [ $TS_NSUBFAILED -ne 0 ]; then
+		if ! ts_gen_diff || [ $TS_NSUBFAILED -ne 0 ]; then
 			ts_failed "$TS_NSUBFAILED from $TS_NSUBTESTS sub-tests"
 		else
 			ts_ok "all $TS_NSUBTESTS sub-tests PASSED"
 		fi
 	fi
 
-	if [ -s $TS_EXPECTED ]; then
-		ts_gen_diff
-		if [ $? -eq 1 ]; then
-			ts_failed "$1"
-		fi
-		ts_ok "$1"
-	fi
-
-	ts_skip "output undefined"
+	ts_gen_diff || ts_failed "$1"
+	ts_ok "$1"
 }
 
 function ts_die {
diff --git a/tests/ts/libmount/context-utab b/tests/ts/libmount/context-utab
index 8b93fe9..38bc170 100755
--- a/tests/ts/libmount/context-utab
+++ b/tests/ts/libmount/context-utab
@@ -15,6 +15,7 @@ ts_check_test_command "$TS_CMD_UUIDGEN"
 
 ts_skip_nonroot
 ts_check_prog "mkfs.ext4"
+ts_check_prog "mkfs.btrfs"
 
 TESTPROG="$TS_HELPER_LIBMOUNT_CONTEXT"
 LABEL=libmount-test
@@ -93,35 +94,33 @@ grep -q $DEVICE $LIBMOUNT_UTAB && \
 ts_finalize_subtest
 
 
-if [ -x "/sbin/mkfs.btrfs" ]; then
-	$TS_CMD_WIPEFS -a  $DEVICE &> /dev/null
-	ts_log "Create filesystem [btrfs]"
-	mkfs.btrfs -L "$LABEL" $DEVICE &> /dev/null
-	udevadm settle
+$TS_CMD_WIPEFS -a  $DEVICE &> /dev/null
+ts_log "Create filesystem [btrfs]"
+mkfs.btrfs -L "$LABEL" $DEVICE &> /dev/null
+udevadm settle
 
-	mount -t btrfs $DEVICE $MOUNTPOINT &> /dev/null
-	btrfs subvolume create $MOUNTPOINT/sub &> /dev/null
-	umount $MOUNTPOINT &> /dev/null
+mount -t btrfs $DEVICE $MOUNTPOINT &> /dev/null
+btrfs subvolume create $MOUNTPOINT/sub &> /dev/null
+umount $MOUNTPOINT &> /dev/null
 
-	udevadm settle
+udevadm settle
 
-	ts_init_subtest "mount-uhelper-subvol"
-	mkdir -p $MOUNTPOINT &>  /dev/null
-	ts_valgrind $TESTPROG --mount -o uhelper=foo,rw,subvol=sub $DEVICE  $MOUNTPOINT >> $TS_OUTPUT 2>&1
-	grep -q $DEVICE $LIBMOUNT_UTAB || \
-		echo "cannot find $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
-	ts_finalize_subtest
+ts_init_subtest "mount-uhelper-subvol"
+mkdir -p $MOUNTPOINT &>  /dev/null
+ts_valgrind $TESTPROG --mount -o uhelper=foo,rw,subvol=sub $DEVICE  $MOUNTPOINT >> $TS_OUTPUT 2>&1
+grep -q $DEVICE $LIBMOUNT_UTAB || \
+	echo "cannot find $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
+ts_finalize_subtest
 
-	ts_log "All mount options (btrfs subvolume + utab) ---"
-	$TS_CMD_FINDMNT --mtab $MOUNTPOINT -o OPTIONS -n >> $TS_OUTPUT 2>&1
-	ts_log "---"
+ts_log "All mount options (btrfs subvolume + utab) ---"
+$TS_CMD_FINDMNT --mtab $MOUNTPOINT -o OPTIONS -n >> $TS_OUTPUT 2>&1
+ts_log "---"
 
-	ts_init_subtest "umount-subvol"
-	ts_valgrind $TESTPROG --umount $MOUNTPOINT >> $TS_OUTPUT 2>&1
-	grep -q $DEVICE $LIBMOUNT_UTAB && \
-		echo "umount (mountpoint) failed: found $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
-	ts_finalize_subtest
-fi
+ts_init_subtest "umount-subvol"
+ts_valgrind $TESTPROG --umount $MOUNTPOINT >> $TS_OUTPUT 2>&1
+grep -q $DEVICE $LIBMOUNT_UTAB && \
+	echo "umount (mountpoint) failed: found $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
+ts_finalize_subtest
 
 ts_log "...done."
 rmmod scsi_debug
diff --git a/tests/ts/libmount/context-utab-py b/tests/ts/libmount/context-utab-py
index 5337d10..fdde63a 100755
--- a/tests/ts/libmount/context-utab-py
+++ b/tests/ts/libmount/context-utab-py
@@ -14,6 +14,7 @@ ts_check_test_command "$TS_CMD_UUIDGEN"
 
 ts_skip_nonroot
 ts_check_prog "mkfs.ext4"
+ts_check_prog "mkfs.btrfs"
 
 ts_init_py libmount
 
@@ -93,35 +94,34 @@ grep -q $DEVICE $LIBMOUNT_UTAB && \
 	echo "umount (mountpoint) failed: found $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
 ts_finalize_subtest
 
-if [ -x "/sbin/mkfs.btrfs" ]; then
-	$TS_CMD_WIPEFS -a  $DEVICE &> /dev/null
-	ts_log "Create filesystem [btrfs]"
-	mkfs.btrfs -L "$LABEL" $DEVICE &> /dev/null
-	udevadm settle
-
-	mount -t btrfs $DEVICE $MOUNTPOINT &> /dev/null
-	btrfs subvolume create $MOUNTPOINT/sub &> /dev/null
-	umount $MOUNTPOINT &> /dev/null
-
-	udevadm settle
-
-	ts_init_subtest "mount-uhelper-subvol"
-	mkdir -p $MOUNTPOINT &>  /dev/null
-	$PYTHON $TESTPROG --mount -o uhelper=foo,rw,subvol=sub $DEVICE  $MOUNTPOINT >> $TS_OUTPUT 2>&1
-	grep -q $DEVICE $LIBMOUNT_UTAB || \
-		echo "cannot find $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
-	ts_finalize_subtest
-
-	ts_log "All mount options (btrfs subvolume + utab) ---"
-	$TS_CMD_FINDMNT --mtab $MOUNTPOINT -o OPTIONS -n >> $TS_OUTPUT 2>&1
-	ts_log "---"
-
-	ts_init_subtest "umount-subvol"
-	$PYTHON $TESTPROG --umount $MOUNTPOINT >> $TS_OUTPUT 2>&1
-	grep -q $DEVICE $LIBMOUNT_UTAB && \
-		echo "umount (mountpoint) failed: found $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
-	ts_finalize_subtest
-fi
+
+$TS_CMD_WIPEFS -a  $DEVICE &> /dev/null
+ts_log "Create filesystem [btrfs]"
+mkfs.btrfs -L "$LABEL" $DEVICE &> /dev/null
+udevadm settle
+
+mount -t btrfs $DEVICE $MOUNTPOINT &> /dev/null
+btrfs subvolume create $MOUNTPOINT/sub &> /dev/null
+umount $MOUNTPOINT &> /dev/null
+
+udevadm settle
+
+ts_init_subtest "mount-uhelper-subvol"
+mkdir -p $MOUNTPOINT &>  /dev/null
+$PYTHON $TESTPROG --mount -o uhelper=foo,rw,subvol=sub $DEVICE  $MOUNTPOINT >> $TS_OUTPUT 2>&1
+grep -q $DEVICE $LIBMOUNT_UTAB || \
+	echo "cannot find $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
+ts_finalize_subtest
+
+ts_log "All mount options (btrfs subvolume + utab) ---"
+$TS_CMD_FINDMNT --mtab $MOUNTPOINT -o OPTIONS -n >> $TS_OUTPUT 2>&1
+ts_log "---"
+
+ts_init_subtest "umount-subvol"
+$PYTHON $TESTPROG --umount $MOUNTPOINT >> $TS_OUTPUT 2>&1
+grep -q $DEVICE $LIBMOUNT_UTAB && \
+	echo "umount (mountpoint) failed: found $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
+ts_finalize_subtest
 
 ts_log "...done."
 rmmod scsi_debug
diff --git a/tests/ts/losetup/losetup b/tests/ts/losetup/losetup
index a50d2eb..1fec0dd 100755
--- a/tests/ts/losetup/losetup
+++ b/tests/ts/losetup/losetup
@@ -30,7 +30,6 @@ ts_check_test_command "$TS_CMD_LSBLK"
 $TS_CMD_LOSETUP --version >/dev/null 2>$TS_OUTPUT || ts_failed
 $TS_CMD_LOSETUP --unknownopt >>$TS_OUTPUT 2>/dev/null && ts_failed
 test -s $TS_OUTPUT && ts_failed
-rm -f $TS_OUTPUT
 
 ts_skip_nonroot
 ts_check_losetup
diff --git a/tests/ts/misc/getopt2 b/tests/ts/misc/getopt2
index 677131f..779d15b 100755
--- a/tests/ts/misc/getopt2
+++ b/tests/ts/misc/getopt2
@@ -27,120 +27,101 @@ $TS_CMD_GETOPT -a -o abcde -l abcde -- -a -ab -abc -ac >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 ts_finalize_subtest
 
-echo "exit value: $?" >> $TS_OUTPUT
 ts_init_subtest alternative_option_long
 $TS_CMD_GETOPT --alternative -o a -l one,two:,three::,four:: -- -a -one -two=MANDATORY -three=OPTIONAL >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 ts_finalize_subtest
 
-echo "exit value: $?" >> $TS_OUTPUT
 ts_init_subtest alternative_option_short
 $TS_CMD_GETOPT -a -o a -l one,two:,three::,four:: -- -a -one -two=MANDATORY -three=OPTIONAL >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 ts_finalize_subtest
 
-echo "exit value: $?" >> $TS_OUTPUT
 ts_init_subtest invalid_getopt_option
 $TS_CMD_GETOPT -b >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 sed -i '1,1s/.*\///' $TS_OUTPUT
 ts_finalize_subtest
 
-echo "exit value: $?" >> $TS_OUTPUT
 ts_init_subtest invocation_model_one
 $TS_CMD_GETOPT abc:d::e::f::g: ARG0 -b ARG1 -d -eOPTIONAL1 -f NOT_OPTIONAL ARG2 -a -c -ISREQUIRED ARG3 -g "BECOMES THREE ARGUMENTS" >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 ts_finalize_subtest
 
-echo "exit value: $?" >> $TS_OUTPUT
 ts_init_subtest invocation_model_three_as_one
 $TS_CMD_GETOPT -o abc:d::e::f::g: -- ARG0 -b ARG1 -d -eOPTIONAL1 -f NOT_OPTIONAL ARG2 -a -c -ISREQUIRED ARG3 -g "BECOMES THREE ARGUMENTS" >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 ts_finalize_subtest
 
-echo "exit value: $?" >> $TS_OUTPUT
 ts_init_subtest invocation_model_two_as_one
 $TS_CMD_GETOPT -- abc:d::e::f::g: ARG0 -b ARG1 -d -eOPTIONAL1 -f NOT_OPTIONAL ARG2 -a -c -ISREQUIRED ARG3 -g "BECOMES THREE ARGUMENTS" >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 ts_finalize_subtest
 
-echo "exit value: $?" >> $TS_OUTPUT
 ts_init_subtest invocation_without_parameters
 $TS_CMD_GETOPT >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 ts_finalize_subtest
 
-echo "exit value: $?" >> $TS_OUTPUT
 ts_init_subtest long_option_ambiguous_1
 $TS_CMD_GETOPT -o a -l long1,long2 -- --long >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 sed -i -e '1,1s/.*\///' -e "1s/ambiguous$/ambiguous; possibilities: '--long1' '--long2'/" $TS_OUTPUT
 ts_finalize_subtest
 
-echo "exit value: $?" >> $TS_OUTPUT
 ts_init_subtest longopts
 $TS_CMD_GETOPT -o a -l long1,secondlong:,thirdlong::,abbriviation: -- --long1 EXTRA1 --thirdlong=ARGUMENT --secondlong=ARG --abbr ABBRARG -a >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 ts_finalize_subtest
 
-echo "exit value: $?" >> $TS_OUTPUT
 ts_init_subtest name_option_long
 $TS_CMD_GETOPT -n THIS_PROGRAM -o a -l long -- -b --long --whatever -a >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 ts_finalize_subtest
 
-echo "exit value: $?" >> $TS_OUTPUT
 ts_init_subtest name_option_short
 $TS_CMD_GETOPT --name THIS_PROGRAM -o a -l long -- -b --long --whatever -a >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 ts_finalize_subtest
 
-echo "exit value: $?" >> $TS_OUTPUT
 ts_init_subtest quiet_option_long
 $TS_CMD_GETOPT --quiet -o a,b: -l long1,long2 -- -c --unknown --long -b >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 ts_finalize_subtest
 
-echo "exit value: $?" >> $TS_OUTPUT
 ts_init_subtest quiet_option_short
 $TS_CMD_GETOPT -q -o a,b: -l long1,long2 -- -c --unknown --long -b >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 ts_finalize_subtest
 
-echo "exit value: $?" >> $TS_OUTPUT
 ts_init_subtest quiet_output_option_long
 $TS_CMD_GETOPT --quiet-output -o a,b: -l long1,long2 -- -c --unknown --long -b >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 sed -i -e '1,4s/.*\///' -e "3s/ambiguous$/ambiguous; possibilities: '--long1' '--long2'/" $TS_OUTPUT
 ts_finalize_subtest
 
-echo "exit value: $?" >> $TS_OUTPUT
 ts_init_subtest quiet_output_option_short
 $TS_CMD_GETOPT -Q -o a,b: -l long1,long2 -- -c --unknown --long -b >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 sed -i -e '1,4s/.*\///' -e "3s/ambiguous$/ambiguous; possibilities: '--long1' '--long2'/" $TS_OUTPUT
 ts_finalize_subtest
 
-echo "exit value: $?" >> $TS_OUTPUT
 ts_init_subtest same_long_short_options
 $TS_CMD_GETOPT -o a -l a -- -a --a >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 ts_finalize_subtest
 
-echo "exit value: $?" >> $TS_OUTPUT
 ts_init_subtest test_for_enhanced_getopt
 $TS_CMD_GETOPT -T >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 ts_finalize_subtest
 
-echo "exit value: $?" >> $TS_OUTPUT
 ts_init_subtest unknown_options
 $TS_CMD_GETOPT -o a -l long -- -b --long --whatever -a >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 sed -i '1,2s/.*\///' $TS_OUTPUT
 ts_finalize_subtest
 
-echo "exit value: $?" >> $TS_OUTPUT
 ts_init_subtest unquoted_option_bash
 $TS_CMD_GETOPT -s bash -u -o a: -l long1: -- -a '$?!* ' --long \"\\\' 'More
  than
-- 
1.9.1

