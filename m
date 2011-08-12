Return-Path: dave@gnu.org
Subject: [PATCH] grammar fixes
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 12 Aug 2011 14:07:45 -0400
Message-ID: <1313172465.3305.4.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Fri, 12 Aug 2011 14:06:13 -0400

Correct grammar from "cannot found" to "cannot find".

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 libmount/src/context_umount.c  |    4 ++--
 tests/ts/hwclock/systohc       |    2 +-
 tests/ts/libmount/context      |   10 +++++-----
 tests/ts/libmount/context-utab |    8 ++++----
 tests/ts/mount/devname         |    6 +++---
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/libmount/src/context_umount.c b/libmount/src/context_umount.c
index 7c048d9..bc08aff 100644
--- a/libmount/src/context_umount.c
+++ b/libmount/src/context_umount.c
@@ -86,7 +86,7 @@ static int lookup_umount_fs(struct libmnt_context *cxt)
 	}
 
 	if (!fs) {
-		DBG(CXT, mnt_debug_h(cxt, "umount: cannot found %s in mtab", tgt));
+		DBG(CXT, mnt_debug_h(cxt, "umount: cannot find %s in mtab", tgt));
 		return 0;
 	}
 
@@ -197,7 +197,7 @@ static int evaluate_permissions(struct libmnt_context *cxt)
 
 	if (!(cxt->flags & MNT_FL_TAB_APPLIED)) {
 		DBG(CXT, mnt_debug_h(cxt,
-				"cannot found %s in mtab and you are not root",
+				"cannot find %s in mtab and you are not root",
 				mnt_fs_get_target(cxt->fs)));
 		goto eperm;
 	}
diff --git a/tests/ts/hwclock/systohc b/tests/ts/hwclock/systohc
index 9dedc62..f58d07e 100755
--- a/tests/ts/hwclock/systohc
+++ b/tests/ts/hwclock/systohc
@@ -24,7 +24,7 @@ NTP_SERVER="0.fedora.pool.ntp.org"
 ts_init "$*"
 ts_skip_nonroot
 
-[ -x "/usr/sbin/ntpdate" ] || ts_skip "cannot found ntpdate command"
+[ -x "/usr/sbin/ntpdate" ] || ts_skip "cannot find ntpdate command"
 
 set -o pipefail
 
diff --git a/tests/ts/libmount/context b/tests/ts/libmount/context
index 8119cee..0b10098 100755
--- a/tests/ts/libmount/context
+++ b/tests/ts/libmount/context
@@ -30,7 +30,7 @@ modprobe scsi_debug dev_size_mb=100
 sleep 3
 
 DEVNAME=$(grep scsi_debug /sys/block/*/device/model | awk -F '/' '{print $4}')
-[ "x${DEVNAME}" == "x" ] && ts_die "Cannot found device"
+[ "x${DEVNAME}" == "x" ] && ts_die "Cannot find device"
 
 DEVICE="/dev/${DEVNAME}"
 
@@ -63,7 +63,7 @@ mkdir -p $MOUNTPOINT &>  /dev/null
 $TESTPROG --mount $DEVICE $MOUNTPOINT >> $TS_OUTPUT 2>&1
 
 grep -q $DEVICE $LIBMOUNT_MTAB || \
-	echo "(by device) cannot found $DEVICE in $LIBMOUNT_MTAB" >> $TS_OUTPUT 2>&1
+	echo "(by device) cannot find $DEVICE in $LIBMOUNT_MTAB" >> $TS_OUTPUT 2>&1
 ts_finalize_subtest
 
 ts_init_subtest "umount-by-devname"
@@ -78,7 +78,7 @@ ts_init_subtest "mount-by-label"
 mkdir -p $MOUNTPOINT &>  /dev/null
 $TESTPROG --mount LABEL="$LABEL" $MOUNTPOINT >> $TS_OUTPUT 2>&1
 grep -q $DEVICE $LIBMOUNT_MTAB || \
-	echo "(by label) cannot found $DEVICE in $LIBMOUNT_MTAB" >> $TS_OUTPUT 2>&1
+	echo "(by label) cannot find $DEVICE in $LIBMOUNT_MTAB" >> $TS_OUTPUT 2>&1
 ts_finalize_subtest
 
 
@@ -93,7 +93,7 @@ ts_init_subtest "mount-by-uuid"
 mkdir -p $MOUNTPOINT &> /dev/null
 $TESTPROG --mount UUID="$UUID" $MOUNTPOINT >> $TS_OUTPUT 2>&1
 grep -q $DEVICE $LIBMOUNT_MTAB || \
-	echo "(by uuid) cannot found $DEVICE in $LIBMOUNT_MTAB" >> $TS_OUTPUT 2>&1
+	echo "(by uuid) cannot find $DEVICE in $LIBMOUNT_MTAB" >> $TS_OUTPUT 2>&1
 $TESTPROG --umount $MOUNTPOINT >> $TS_OUTPUT 2>&1
 grep -q $DEVICE $LIBMOUNT_MTAB &&
 	echo "umount failed: found $DEVICE in $LIBMOUNT_MTAB" >> $TS_OUTPUT 2>&1
@@ -105,7 +105,7 @@ mkdir -p $MOUNTPOINT &> /dev/null
 $TESTPROG --mount -o ro,noexec,nosuid,strictatime $DEVICE $MOUNTPOINT >> $TS_OUTPUT 2>&1
 $TS_CMD_FINDMNT --kernel $MOUNTPOINT -o VFS-OPTIONS -n >> $TS_OUTPUT 2>&1
 grep -q $DEVICE $LIBMOUNT_MTAB || \
-	echo "cannot found $DEVICE in $LIBMOUNT_MTAB" >> $TS_OUTPUT 2>&1
+	echo "cannot find $DEVICE in $LIBMOUNT_MTAB" >> $TS_OUTPUT 2>&1
 
 $TESTPROG --mount -o remount,rw $MOUNTPOINT >> $TS_OUTPUT 2>&1
 $TS_CMD_FINDMNT --kernel $MOUNTPOINT -o VFS-OPTIONS -n >> $TS_OUTPUT 2>&1
diff --git a/tests/ts/libmount/context-utab b/tests/ts/libmount/context-utab
index 5f36d28..94d4460 100755
--- a/tests/ts/libmount/context-utab
+++ b/tests/ts/libmount/context-utab
@@ -27,7 +27,7 @@ modprobe scsi_debug dev_size_mb=260
 sleep 3
 
 DEVNAME=$(grep scsi_debug /sys/block/*/device/model | awk -F '/' '{print $4}')
-[ "x${DEVNAME}" == "x" ] && ts_die "Cannot found device"
+[ "x${DEVNAME}" == "x" ] && ts_die "Cannot find device"
 
 DEVICE="/dev/${DEVNAME}"
 
@@ -64,7 +64,7 @@ ts_init_subtest "mount-by-devname"
 mkdir -p $MOUNTPOINT &>  /dev/null
 $TESTPROG --mount $DEVICE $MOUNTPOINT >> $TS_OUTPUT 2>&1
 grep -q $DEVICE /proc/mounts || \
-	echo "(by device) cannot found $DEVICE in /proc/mounts" >> $TS_OUTPUT 2>&1
+	echo "(by device) cannot find $DEVICE in /proc/mounts" >> $TS_OUTPUT 2>&1
 ts_finalize_subtest
 
 ts_init_subtest "umount-by-devname"
@@ -78,7 +78,7 @@ ts_init_subtest "mount-uhelper"
 mkdir -p $MOUNTPOINT &>  /dev/null
 $TESTPROG --mount -o uhelper=foo,rw LABEL="$LABEL" $MOUNTPOINT >> $TS_OUTPUT 2>&1
 grep -q $DEVICE $LIBMOUNT_UTAB || \
-	echo "(by label) cannot found $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
+	echo "(by label) cannot find $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
 ts_finalize_subtest
 
 ts_init_subtest "umount"
@@ -98,7 +98,7 @@ if [ -x "/sbin/mkfs.btrfs" ]; then
 	mkdir -p $MOUNTPOINT &>  /dev/null
 	$TESTPROG --mount -o uhelper=foo,rw,subvol=sub $DEVICE  $MOUNTPOINT >> $TS_OUTPUT 2>&1
 	grep -q $DEVICE $LIBMOUNT_UTAB || \
-		echo "cannot found $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
+		echo "cannot find $DEVICE in $LIBMOUNT_UTAB" >> $TS_OUTPUT 2>&1
 	ts_finalize_subtest
 
 	ts_log "All mount options (btrfs subvolume + utab) ---"
diff --git a/tests/ts/mount/devname b/tests/ts/mount/devname
index 4cbd087..8f32ef1 100755
--- a/tests/ts/mount/devname
+++ b/tests/ts/mount/devname
@@ -30,16 +30,16 @@ DEVICE=$(ts_device_init)
 
 mkfs.ext3 $DEVICE &> /dev/null || ts_die "Cannot make ext3 on $DEVICE" $DEVICE
 
-ts_device_has "TYPE" "ext3" $DEVICE || ts_die "Cannot found ext3 on $DEVICE" $DEVICE
+ts_device_has "TYPE" "ext3" $DEVICE || ts_die "Cannot find ext3 on $DEVICE" $DEVICE
 
 [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
 
 $TS_CMD_MOUNT $DEVICE $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
 
-ts_is_mounted $DEVICE || ts_die "Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "Cannot find $DEVICE in /proc/mounts" $DEVICE
 
 grep -q $DEVICE /etc/mtab ||
-	echo "mount failed: cannot found $DEVICE in mtab" >> $TS_OUTPUT 2>&1
+	echo "mount failed: cannot find $DEVICE in mtab" >> $TS_OUTPUT 2>&1
 
 $TS_CMD_UMOUNT $DEVICE || ts_die "Cannot umount $DEVICE" $DEVICE
 
-- 
1.7.4.1
