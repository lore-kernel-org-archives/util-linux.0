Return-Path: dave@gnu.org
Subject: [PATCH] tests: grammar fixes
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Aug 2011 11:52:55 -0400
Message-ID: <1313596375.2653.2.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Wed, 17 Aug 2011 11:51:19 -0400

Trivial change, "Cannot found" to "Cannot find".

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 tests/ts/blkid/md-raid1-part          |    2 +-
 tests/ts/cramfs/mkfs                  |    4 ++--
 tests/ts/fdisk/align-512-4K           |    2 +-
 tests/ts/fdisk/align-512-4K-63        |    2 +-
 tests/ts/fdisk/align-512-4K-md        |    2 +-
 tests/ts/fdisk/align-512-512-topology |    2 +-
 tests/ts/fsck/ismounted               |    2 +-
 tests/ts/libmount/tabfiles-tags       |    4 ++--
 tests/ts/minix/mkfs                   |    2 +-
 tests/ts/mount/fstab-broken           |    4 ++--
 tests/ts/mount/fstab-devname          |    6 +++---
 tests/ts/mount/fstab-devname2label    |    4 ++--
 tests/ts/mount/fstab-devname2uuid     |    4 ++--
 tests/ts/mount/fstab-label            |    8 ++++----
 tests/ts/mount/fstab-label2devname    |    6 +++---
 tests/ts/mount/fstab-label2uuid       |    8 ++++----
 tests/ts/mount/fstab-symlink          |    6 +++---
 tests/ts/mount/fstab-uuid             |    8 ++++----
 tests/ts/mount/fstab-uuid2devname     |    6 +++---
 tests/ts/mount/fstab-uuid2label       |    8 ++++----
 tests/ts/mount/label                  |    6 +++---
 tests/ts/mount/move                   |    4 ++--
 tests/ts/mount/regfile                |    2 +-
 tests/ts/mount/remount                |    4 ++--
 tests/ts/mount/uuid                   |    6 +++---
 tests/ts/swapon/devname               |    4 ++--
 tests/ts/swapon/label                 |    4 ++--
 tests/ts/swapon/uuid                  |    4 ++--
 28 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/tests/ts/blkid/md-raid1-part b/tests/ts/blkid/md-raid1-part
index c990824..75630a2 100755
--- a/tests/ts/blkid/md-raid1-part
+++ b/tests/ts/blkid/md-raid1-part
@@ -34,7 +34,7 @@ modprobe scsi_debug dev_size_mb=51 sector_size=512
 sleep 3
 
 DEVNAME=$(grep scsi_debug /sys/block/*/device/model | awk -F '/' '{print $4}')
-[ "x${DEVNAME}" == "x" ] && ts_die "Cannot found device"
+[ "x${DEVNAME}" == "x" ] && ts_die "Cannot find device"
 
 DEVICE="/dev/${DEVNAME}"
 
diff --git a/tests/ts/cramfs/mkfs b/tests/ts/cramfs/mkfs
index 37d79c0..0b48d01 100755
--- a/tests/ts/cramfs/mkfs
+++ b/tests/ts/cramfs/mkfs
@@ -68,13 +68,13 @@ DEVICE=$($TS_CMD_LOSETUP -s -f $IMAGE_PATH)
 
 ts_log "check the image"
 ts_device_has "TYPE" "cramfs" $DEVICE
-[  "$?" == "0" ] || ts_die "Cannot found cramfs on $DEVICE" $DEVICE
+[  "$?" == "0" ] || ts_die "Cannot find cramfs on $DEVICE" $DEVICE
 
 ts_log "mount the image"
 $TS_CMD_MOUNT -r -L $LABEL $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
 
 # check it
-ts_is_mounted $DEVICE || ts_die "Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "Cannot find $DEVICE in /proc/mounts" $DEVICE
 
 cd $TS_MOUNTPOINT
 
diff --git a/tests/ts/fdisk/align-512-4K b/tests/ts/fdisk/align-512-4K
index cf3bbc0..2bc1280 100755
--- a/tests/ts/fdisk/align-512-4K
+++ b/tests/ts/fdisk/align-512-4K
@@ -37,7 +37,7 @@ modprobe scsi_debug dev_size_mb=50 sector_size=512 physblk_exp=3
 sleep 3
 
 DEVNAME=$(grep scsi_debug /sys/block/*/device/model | awk -F '/' '{print $4}')
-[ "x${DEVNAME}" == "x" ] && ts_die "Cannot found device"
+[ "x${DEVNAME}" == "x" ] && ts_die "Cannot find device"
 
 DEVICE="/dev/${DEVNAME}"
 
diff --git a/tests/ts/fdisk/align-512-4K-63 b/tests/ts/fdisk/align-512-4K-63
index cd44ce4..cd7d2ac 100755
--- a/tests/ts/fdisk/align-512-4K-63
+++ b/tests/ts/fdisk/align-512-4K-63
@@ -37,7 +37,7 @@ modprobe scsi_debug dev_size_mb=50 sector_size=512 physblk_exp=3 lowest_aligned=
 sleep 3
 
 DEVNAME=$(grep scsi_debug /sys/block/*/device/model | awk -F '/' '{print $4}')
-[ "x${DEVNAME}" == "x" ] && ts_die "Cannot found device"
+[ "x${DEVNAME}" == "x" ] && ts_die "Cannot find device"
 
 DEVICE="/dev/${DEVNAME}"
 
diff --git a/tests/ts/fdisk/align-512-4K-md b/tests/ts/fdisk/align-512-4K-md
index ba0f0c8..fc2ce69 100755
--- a/tests/ts/fdisk/align-512-4K-md
+++ b/tests/ts/fdisk/align-512-4K-md
@@ -38,7 +38,7 @@ modprobe scsi_debug dev_size_mb=50 sector_size=512 physblk_exp=3
 sleep 3
 
 DEVNAME=$(grep scsi_debug /sys/block/*/device/model | awk -F '/' '{print $4}')
-[ "x${DEVNAME}" == "x" ] && ts_die "Cannot found device"
+[ "x${DEVNAME}" == "x" ] && ts_die "Cannot find device"
 
 DEVICE="/dev/${DEVNAME}"
 
diff --git a/tests/ts/fdisk/align-512-512-topology b/tests/ts/fdisk/align-512-512-topology
index 4563765..baf9155 100755
--- a/tests/ts/fdisk/align-512-512-topology
+++ b/tests/ts/fdisk/align-512-512-topology
@@ -37,7 +37,7 @@ modprobe scsi_debug dev_size_mb=50 sector_size=512
 sleep 3
 
 DEVNAME=$(grep scsi_debug /sys/block/*/device/model | awk -F '/' '{print $4}')
-[ "x${DEVNAME}" == "x" ] && ts_die "Cannot found device"
+[ "x${DEVNAME}" == "x" ] && ts_die "Cannot find device"
 
 DEVICE="/dev/${DEVNAME}"
 
diff --git a/tests/ts/fsck/ismounted b/tests/ts/fsck/ismounted
index fae465c..6b7f0f7 100755
--- a/tests/ts/fsck/ismounted
+++ b/tests/ts/fsck/ismounted
@@ -30,7 +30,7 @@ DEVICE=$(ts_device_init)
 
 mkfs.ext3 $DEVICE &> /dev/null || ts_die "Cannot make ext3 on $DEVICE" $DEVICE
 
-ts_device_has "TYPE" "ext3" $DEVICE || ts_die "Cannot found ext3 on $DEVICE" $DEVICE
+ts_device_has "TYPE" "ext3" $DEVICE || ts_die "Cannot find ext3 on $DEVICE" $DEVICE
 
 [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
 
diff --git a/tests/ts/libmount/tabfiles-tags b/tests/ts/libmount/tabfiles-tags
index 893c65b..87039cc 100755
--- a/tests/ts/libmount/tabfiles-tags
+++ b/tests/ts/libmount/tabfiles-tags
@@ -24,7 +24,7 @@ modprobe scsi_debug dev_size_mb=50 sector_size=512
 sleep 3
 
 DEVNAME=$(grep scsi_debug /sys/block/*/device/model | awk -F '/' '{print $4}')
-[ "x${DEVNAME}" == "x" ] && ts_die "Cannot found device"
+[ "x${DEVNAME}" == "x" ] && ts_die "Cannot find device"
 
 DEVICE="/dev/${DEVNAME}"
 LABEL="testLibmount"
@@ -34,7 +34,7 @@ UUID="de1bc6e9-34ab-4151-a1d7-900042eee8d9"
 # Create filesystem
 #
 mkfs.ext3 -F -L $LABEL $DEVICE -U $UUID &> /dev/null || ts_die "Cannot make ext3 on $DEVICE" $DEVICE
-ts_device_has_uuid $DEVICE || ts_die "Cannot found UUID on $DEVICE" $DEVICE
+ts_device_has_uuid $DEVICE || ts_die "Cannot find UUID on $DEVICE" $DEVICE
 
 FSTAB="$TS_OUTDIR/fstab"
 
diff --git a/tests/ts/minix/mkfs b/tests/ts/minix/mkfs
index e74a169..21c3ffe 100755
--- a/tests/ts/minix/mkfs
+++ b/tests/ts/minix/mkfs
@@ -36,7 +36,7 @@ ts_log "mount the filesystem"
 $TS_CMD_MOUNT $DEVICE $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
 
 # check it
-ts_is_mounted $DEVICE || ts_die "Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "Cannot find $DEVICE in /proc/mounts" $DEVICE
 
 ts_log "umount the image"
 $TS_CMD_UMOUNT $DEVICE
diff --git a/tests/ts/mount/fstab-broken b/tests/ts/mount/fstab-broken
index c256e02..46f272a 100755
--- a/tests/ts/mount/fstab-broken
+++ b/tests/ts/mount/fstab-broken
@@ -37,7 +37,7 @@ ts_init_subtest "mount"
 $TS_CMD_MOUNT $MNT &> /dev/null
 $TS_CMD_FINDMNT --kernel --target "$MNT" &> /dev/null
 if [ "$?" != "0" ]; then
-	ts_log "Cannot found $MNT in /proc/self/mountinfo"
+	ts_log "Cannot find $MNT in /proc/self/mountinfo"
 else
 	ts_log "OK"
 fi
@@ -49,7 +49,7 @@ ts_init_subtest "mount-all"
 $TS_CMD_MOUNT -a &> /dev/null
 $TS_CMD_FINDMNT --kernel --target "$MNT" &> /dev/null
 if [ "$?" != "0" ]; then
-	ts_log "Cannot found $MNT in /proc/self/mountinfo"
+	ts_log "Cannot find $MNT in /proc/self/mountinfo"
 else
 	ts_log "OK"
 fi
diff --git a/tests/ts/mount/fstab-devname b/tests/ts/mount/fstab-devname
index 04fda9d..9af8db6 100755
--- a/tests/ts/mount/fstab-devname
+++ b/tests/ts/mount/fstab-devname
@@ -29,7 +29,7 @@ DEVICE=$(ts_device_init)
 
 mkfs.ext3 $DEVICE &> /dev/null || ts_die "Cannot make ext3 on $DEVICE" $DEVICE
 
-ts_device_has "TYPE" "ext3" $DEVICE || ts_die "Cannot found ext3 on $DEVICE" $DEVICE
+ts_device_has "TYPE" "ext3" $DEVICE || ts_die "Cannot find ext3 on $DEVICE" $DEVICE
 
 [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
 
@@ -37,12 +37,12 @@ ts_fstab_add $DEVICE
 
 # variant A)
 $TS_CMD_MOUNT $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "A) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "A) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "A) Cannot umount $DEVICE" $DEVICE
 
 # variant B)
 $TS_CMD_MOUNT $DEVICE 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "B) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "B) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "B) Cannot umount $DEVICE" $DEVICE
 
 ts_device_deinit $DEVICE
diff --git a/tests/ts/mount/fstab-devname2label b/tests/ts/mount/fstab-devname2label
index 25db73f..34214db 100755
--- a/tests/ts/mount/fstab-devname2label
+++ b/tests/ts/mount/fstab-devname2label
@@ -31,14 +31,14 @@ DEVICE=$(ts_device_init)
 mkfs.ext3 -L $LABEL $DEVICE &> /dev/null || ts_die "Cannot make ext3 on $DEVICE" $DEVICE
 
 ts_device_has "LABEL" $LABEL $DEVICE \
- || ts_die "Cannot found LABEL '$LABEL' on $DEVICE" $DEVICE
+ || ts_die "Cannot find LABEL '$LABEL' on $DEVICE" $DEVICE
 
 [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
 
 ts_fstab_add "LABEL=$LABEL"
 
 $TS_CMD_MOUNT $DEVICE 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "Cannot umount $DEVICE" $DEVICE
 
 ts_device_deinit $DEVICE
diff --git a/tests/ts/mount/fstab-devname2uuid b/tests/ts/mount/fstab-devname2uuid
index 373e175..859bcda 100755
--- a/tests/ts/mount/fstab-devname2uuid
+++ b/tests/ts/mount/fstab-devname2uuid
@@ -29,7 +29,7 @@ DEVICE=$(ts_device_init)
 
 mkfs.ext3 $DEVICE &> /dev/null || ts_die "Cannot make ext3 on $DEVICE" $DEVICE
 
-ts_device_has_uuid $DEVICE || ts_die "Cannot found UUID on $DEVICE" $DEVICE
+ts_device_has_uuid $DEVICE || ts_die "Cannot find UUID on $DEVICE" $DEVICE
 
 UUID=$(ts_uuid_by_devname $DEVICE)
 
@@ -38,7 +38,7 @@ UUID=$(ts_uuid_by_devname $DEVICE)
 ts_fstab_add "UUID=$UUID"
 
 $TS_CMD_MOUNT $DEVICE 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "Cannot umount $DEVICE" $DEVICE
 
 ts_device_deinit $DEVICE
diff --git a/tests/ts/mount/fstab-label b/tests/ts/mount/fstab-label
index 88331f4..2c1e7eb 100755
--- a/tests/ts/mount/fstab-label
+++ b/tests/ts/mount/fstab-label
@@ -31,7 +31,7 @@ DEVICE=$(ts_device_init)
 mkfs.ext3 -L $LABEL $DEVICE &> /dev/null || ts_die "Cannot make ext3 on $DEVICE" $DEVICE
 
 ts_device_has "LABEL" $LABEL $DEVICE \
- || ts_die "Cannot found LABEL '$LABEL' on $DEVICE" $DEVICE
+ || ts_die "Cannot find LABEL '$LABEL' on $DEVICE" $DEVICE
 
 [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
 
@@ -39,17 +39,17 @@ ts_fstab_add "LABEL=$LABEL"
 
 # variant A)
 $TS_CMD_MOUNT $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "A) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "A) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "A) Cannot umount $DEVICE" $DEVICE
 
 # variant B)
 $TS_CMD_MOUNT -L $LABEL 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "B) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "B) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "B) Cannot umount $DEVICE" $DEVICE
 
 # variant C)
 $TS_CMD_MOUNT LABEL=$LABEL 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "C) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "C) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "C) Cannot umount $DEVICE" $DEVICE
 
 ts_device_deinit $DEVICE
diff --git a/tests/ts/mount/fstab-label2devname b/tests/ts/mount/fstab-label2devname
index 88ae748..0d10f1b 100755
--- a/tests/ts/mount/fstab-label2devname
+++ b/tests/ts/mount/fstab-label2devname
@@ -31,7 +31,7 @@ DEVICE=$(ts_device_init)
 mkfs.ext3 -L $LABEL $DEVICE &> /dev/null || ts_die "Cannot make ext3 on $DEVICE" $DEVICE
 
 ts_device_has "LABEL" $LABEL $DEVICE \
- || ts_die "Cannot found LABEL '$LABEL' on $DEVICE" $DEVICE
+ || ts_die "Cannot find LABEL '$LABEL' on $DEVICE" $DEVICE
 
 [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
 
@@ -39,12 +39,12 @@ ts_fstab_add "$DEVICE"
 
 # variant A)
 $TS_CMD_MOUNT -L $LABEL 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "A) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "A) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "A) Cannot umount $DEVICE" $DEVICE
 
 # variant B)
 $TS_CMD_MOUNT "LABEL=$LABEL" 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "B) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "B) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "B) Cannot umount $DEVICE" $DEVICE
 
 ts_device_deinit $DEVICE
diff --git a/tests/ts/mount/fstab-label2uuid b/tests/ts/mount/fstab-label2uuid
index c643e61..0ad4f05 100755
--- a/tests/ts/mount/fstab-label2uuid
+++ b/tests/ts/mount/fstab-label2uuid
@@ -32,9 +32,9 @@ DEVICE=$(ts_device_init)
 mkfs.ext3 -L $LABEL $DEVICE &> /dev/null || ts_die "Cannot make ext3 on $DEVICE" $DEVICE
 
 ts_device_has "LABEL" $LABEL $DEVICE \
- || ts_die "Cannot found LABEL '$LABEL' on $DEVICE" $DEVICE
+ || ts_die "Cannot find LABEL '$LABEL' on $DEVICE" $DEVICE
 
-ts_device_has_uuid $DEVICE || ts_die "Cannot found UUID on $DEVICE" $DEVICE
+ts_device_has_uuid $DEVICE || ts_die "Cannot find UUID on $DEVICE" $DEVICE
 
 UUID=$(ts_uuid_by_devname $DEVICE)
 
@@ -44,12 +44,12 @@ ts_fstab_add "UUID=$UUID"
 
 # variant A)
 $TS_CMD_MOUNT -L $LABEL 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "A) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "A) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "A) Cannot umount $DEVICE" $DEVICE
 
 # variant B)
 $TS_CMD_MOUNT "LABEL=$LABEL" 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "B) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "B) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "B) Cannot umount $DEVICE" $DEVICE
 
 ts_device_deinit $DEVICE
diff --git a/tests/ts/mount/fstab-symlink b/tests/ts/mount/fstab-symlink
index 0c1c68d..7f9d91f 100755
--- a/tests/ts/mount/fstab-symlink
+++ b/tests/ts/mount/fstab-symlink
@@ -32,7 +32,7 @@ DEVICE=$(ts_device_init)
 
 mkfs.ext3 $DEVICE &> /dev/null || ts_die "Cannot make ext3 on $DEVICE" $DEVICE
 
-ts_device_has "TYPE" "ext3" $DEVICE || ts_die "Cannot found ext3 on $DEVICE" $DEVICE
+ts_device_has "TYPE" "ext3" $DEVICE || ts_die "Cannot find ext3 on $DEVICE" $DEVICE
 
 [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
 
@@ -43,7 +43,7 @@ ts_fstab_add $LINKNAME $TS_MOUNTPOINT "auto" "defaults,user"
 
 # variant A) -- UID=0
 $TS_CMD_MOUNT $LINKNAME 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "A) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "A) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $LINKNAME || ts_die "A) Cannot umount $LINKNAME" $DEVICE
 
 # varian B) -- disabled, the $TS_CMD_MOUNT is usually not a real program, but
@@ -55,7 +55,7 @@ $TS_CMD_UMOUNT $LINKNAME || ts_die "A) Cannot umount $LINKNAME" $DEVICE
 #
 #su $TS_TESTUSER -c "$TS_CMD_MOUNT -v -v -v $LINKNAME" 2>&1 >> $TS_OUTPUT
 #ts_is_mounted $DEVICE
-#   || ts_die "B) Cannot found $DEVICE in /proc/mounts" $DEVICE
+#   || ts_die "B) Cannot find $DEVICE in /proc/mounts" $DEVICE
 #su $TS_TESTUSER -c "$TS_CMD_UMOUNT $LINKNAME" 2>&1 >> $TS_OUTPUT \
 #   || ts_die "B) Cannot umount $LINKNAME" $DEVICE
 
diff --git a/tests/ts/mount/fstab-uuid b/tests/ts/mount/fstab-uuid
index 7032c29..8c65b4d 100755
--- a/tests/ts/mount/fstab-uuid
+++ b/tests/ts/mount/fstab-uuid
@@ -29,7 +29,7 @@ DEVICE=$(ts_device_init)
 
 mkfs.ext3 $DEVICE &> /dev/null || ts_die "Cannot make ext3 on $DEVICE" $DEVICE
 
-ts_device_has_uuid $DEVICE || ts_die "Cannot found UUID on $DEVICE" $DEVICE
+ts_device_has_uuid $DEVICE || ts_die "Cannot find UUID on $DEVICE" $DEVICE
 
 UUID=$(ts_uuid_by_devname $DEVICE)
 
@@ -39,17 +39,17 @@ ts_fstab_add "UUID=$UUID"
 
 # varian A)
 $TS_CMD_MOUNT $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "A) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "A) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "A) Cannot umount $DEVICE" $DEVICE
 
 # varian B)
 $TS_CMD_MOUNT -U $UUID 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "B) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "B) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "B) Cannot umount $DEVICE" $DEVICE
 
 # varian C)
 $TS_CMD_MOUNT UUID=$UUID 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "C) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "C) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "C) Cannot umount $DEVICE" $DEVICE
 
 ts_device_deinit $DEVICE
diff --git a/tests/ts/mount/fstab-uuid2devname b/tests/ts/mount/fstab-uuid2devname
index 99d00b8..51bac14 100755
--- a/tests/ts/mount/fstab-uuid2devname
+++ b/tests/ts/mount/fstab-uuid2devname
@@ -29,7 +29,7 @@ DEVICE=$(ts_device_init)
 
 mkfs.ext3 $DEVICE &> /dev/null || ts_die "Cannot make ext3 on $DEVICE" $DEVICE
 
-ts_device_has_uuid $DEVICE || ts_die "Cannot found UUID on $DEVICE" $DEVICE
+ts_device_has_uuid $DEVICE || ts_die "Cannot find UUID on $DEVICE" $DEVICE
 
 UUID=$(ts_uuid_by_devname $DEVICE)
 
@@ -39,12 +39,12 @@ ts_fstab_add "$DEVICE"
 
 # variant A)
 $TS_CMD_MOUNT -U $UUID 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "A) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "A) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "A) Cannot umount $DEVICE" $DEVICE
 
 # variant B)
 $TS_CMD_MOUNT "UUID=$UUID" 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "B) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "B) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "B) Cannot umount $DEVICE" $DEVICE
 
 ts_device_deinit $DEVICE
diff --git a/tests/ts/mount/fstab-uuid2label b/tests/ts/mount/fstab-uuid2label
index e510fc1..442cdb7 100755
--- a/tests/ts/mount/fstab-uuid2label
+++ b/tests/ts/mount/fstab-uuid2label
@@ -31,9 +31,9 @@ DEVICE=$(ts_device_init)
 mkfs.ext3 -L $LABEL $DEVICE &> /dev/null || ts_die "Cannot make ext3 on $DEVICE" $DEVICE
 
 ts_device_has "LABEL" $LABEL $DEVICE \
- || ts_die "Cannot found LABEL '$LABEL' on $DEVICE" $DEVICE
+ || ts_die "Cannot find LABEL '$LABEL' on $DEVICE" $DEVICE
 
-ts_device_has_uuid $DEVICE || ts_die "Cannot found UUID on $DEVICE" $DEVICE
+ts_device_has_uuid $DEVICE || ts_die "Cannot find UUID on $DEVICE" $DEVICE
 
 UUID=$(ts_uuid_by_devname $DEVICE)
 
@@ -43,12 +43,12 @@ ts_fstab_add "LABEL=$LABEL"
 
 # variant A)
 $TS_CMD_MOUNT -U $UUID 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "A) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "A) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "A) Cannot umount $DEVICE" $DEVICE
 
 # variant B)
 $TS_CMD_MOUNT "UUID=$UUID" 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "B) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "B) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "B) Cannot umount $DEVICE" $DEVICE
 
 ts_device_deinit $DEVICE
diff --git a/tests/ts/mount/label b/tests/ts/mount/label
index 92b1c13..873ea95 100755
--- a/tests/ts/mount/label
+++ b/tests/ts/mount/label
@@ -32,18 +32,18 @@ DEVICE=$(ts_device_init)
 mkfs.ext3 -L $LABEL $DEVICE &> /dev/null || ts_die "Cannot make ext3 on $DEVICE" $DEVICE
 
 ts_device_has "LABEL" $LABEL $DEVICE \
- || ts_die "Cannot found LABEL '$LABEL' on $DEVICE" $DEVICE
+ || ts_die "Cannot find LABEL '$LABEL' on $DEVICE" $DEVICE
 
 [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
 
 # variant A)
 $TS_CMD_MOUNT -L $LABEL $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "A) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "A) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "A) Cannot umount $DEVICE" $DEVICE
 
 # variant B)
 $TS_CMD_MOUNT LABEL=$LABEL $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "B) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "B) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "B) Cannot umount $DEVICE" $DEVICE
 
 ts_device_deinit $DEVICE
diff --git a/tests/ts/mount/move b/tests/ts/mount/move
index dfdd79a..3862f46 100755
--- a/tests/ts/mount/move
+++ b/tests/ts/mount/move
@@ -35,14 +35,14 @@ $TS_CMD_MOUNT --bind $DIR_SRC $DIR_A
 
 # check the bind
 $TS_CMD_FINDMNT --kernel --target "$DIR_A" &> /dev/null
-[ "$?" == "0" ] || ts_die "Cannot found binded $DIR_A in /proc/self/mountinfo"
+[ "$?" == "0" ] || ts_die "Cannot find binded $DIR_A in /proc/self/mountinfo"
 
 # move
 $TS_CMD_MOUNT --move $DIR_A $DIR_B
 
 # check the move
 $TS_CMD_FINDMNT --kernel --target "$DIR_B" &> /dev/null
-[ "$?" == "0" ] || ts_die "Cannot found binded $DIR_B in /proc/self/mountinfo"
+[ "$?" == "0" ] || ts_die "Cannot find binded $DIR_B in /proc/self/mountinfo"
 
 # clean up
 $TS_CMD_UMOUNT $DIR_B
diff --git a/tests/ts/mount/regfile b/tests/ts/mount/regfile
index 05a28ee..fa5605e 100755
--- a/tests/ts/mount/regfile
+++ b/tests/ts/mount/regfile
@@ -21,7 +21,7 @@ $TS_CMD_MOUNT $IMAGE $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
 
 DEVICE=$(awk '/regfile/ { print $1 }' /proc/mounts)
 
-grep -q "$TS_MOUNTPOINT" /proc/mounts || ts_die "Cannot found $TS_MOUNTPOINT in /proc/mounts"
+grep -q "$TS_MOUNTPOINT" /proc/mounts || ts_die "Cannot find $TS_MOUNTPOINT in /proc/mounts"
 
 if [ -f "/sys/block/$(basename $DEVICE)/loop" ]; then
 	$TS_CMD_UMOUNT $IMAGE || ts_die "Cannot umount $IMAGE"
diff --git a/tests/ts/mount/remount b/tests/ts/mount/remount
index 33db5dc..051c595 100755
--- a/tests/ts/mount/remount
+++ b/tests/ts/mount/remount
@@ -35,7 +35,7 @@ $TS_CMD_MOUNT $DEVICE $TS_MOUNTPOINT || ts_die "Cannot mount $TS_MOUNTPOINT" $DE
 
 # check the mount
 egrep -q "^$DEVICE $TS_MOUNTPOINT" /etc/mtab \
- || ts_die "Cannot found $TS_MOUNTPOINT in /etc/mtab" $DEVICE
+ || ts_die "Cannot find $TS_MOUNTPOINT in /etc/mtab" $DEVICE
 
 # remount
 $TS_CMD_MOUNT -o remount,ro $TS_MOUNTPOINT \
@@ -43,7 +43,7 @@ $TS_CMD_MOUNT -o remount,ro $TS_MOUNTPOINT \
 
 # check the remount
 $TS_CMD_FINDMNT --kernel --target "$TS_MOUNTPOINT" --options "ro" &> /dev/null
-[ "$?" == "0" ] || ts_die "Cannot found read-only in $TS_MOUNTPOINT in /proc/self/mountinfo"
+[ "$?" == "0" ] || ts_die "Cannot find read-only in $TS_MOUNTPOINT in /proc/self/mountinfo"
 
 ts_device_deinit $DEVICE
 
diff --git a/tests/ts/mount/uuid b/tests/ts/mount/uuid
index 3a47d50..e29ad39 100755
--- a/tests/ts/mount/uuid
+++ b/tests/ts/mount/uuid
@@ -29,7 +29,7 @@ DEVICE=$(ts_device_init)
 
 mkfs.ext3 $DEVICE &> /dev/null || ts_die "Cannot make ext3 on $DEVICE" $DEVICE
 
-ts_device_has_uuid $DEVICE || ts_die "Cannot found UUID on $DEVICE" $DEVICE
+ts_device_has_uuid $DEVICE || ts_die "Cannot find UUID on $DEVICE" $DEVICE
 
 UUID=$(ts_uuid_by_devname $DEVICE)
 
@@ -37,12 +37,12 @@ UUID=$(ts_uuid_by_devname $DEVICE)
 
 # variant A)
 $TS_CMD_MOUNT -U $UUID $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "A) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "A) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "A) Cannot umount $DEVICE" $DEVICE
 
 # variant B)
 $TS_CMD_MOUNT UUID=$UUID $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
-ts_is_mounted $DEVICE || ts_die "B) Cannot found $DEVICE in /proc/mounts" $DEVICE
+ts_is_mounted $DEVICE || ts_die "B) Cannot find $DEVICE in /proc/mounts" $DEVICE
 $TS_CMD_UMOUNT $DEVICE || ts_die "B) Cannot umount $DEVICE" $DEVICE
 
 ts_device_deinit $DEVICE
diff --git a/tests/ts/swapon/devname b/tests/ts/swapon/devname
index e2ac048..917b40b 100755
--- a/tests/ts/swapon/devname
+++ b/tests/ts/swapon/devname
@@ -30,12 +30,12 @@ DEVICE=$(ts_device_init)
 $TS_CMD_MKSWAP $DEVICE > /dev/null 2>> $TS_OUTPUT \
  || ts_die "Cannot make swap $DEVICE" $DEVICE
 
-ts_device_has "TYPE" "swap" $DEVICE || ts_die "Cannot found swap on $DEVICE" $DEVICE
+ts_device_has "TYPE" "swap" $DEVICE || ts_die "Cannot find swap on $DEVICE" $DEVICE
 
 LD_LIBRARY_PATH="$U_L_LIBRARY_PATH" \
 		$TS_CMD_SWAPON $DEVICE 2>&1 >> $TS_OUTPUT
 
-grep -q $DEVICE /proc/swaps || ts_die "Cannot found $DEVICE in /proc/swaps" $DEVICE
+grep -q $DEVICE /proc/swaps || ts_die "Cannot find $DEVICE in /proc/swaps" $DEVICE
 
 ts_swapoff $DEVICE
 ts_device_deinit $DEVICE
diff --git a/tests/ts/swapon/label b/tests/ts/swapon/label
index 0cb650a..3a5baa1 100755
--- a/tests/ts/swapon/label
+++ b/tests/ts/swapon/label
@@ -32,12 +32,12 @@ $TS_CMD_MKSWAP -L $LABEL $DEVICE > /dev/null 2>> $TS_OUTPUT \
  || ts_die "Cannot make swap on $DEVICE" $DEVICE
 
 ts_device_has "LABEL" $LABEL $DEVICE \
- || ts_die "Cannot found LABEL '$LABEL' on $DEVICE" $DEVICE
+ || ts_die "Cannot find LABEL '$LABEL' on $DEVICE" $DEVICE
 
 LD_LIBRARY_PATH="$U_L_LIBRARY_PATH" \
 	$TS_CMD_SWAPON -L $LABEL 2>&1 >> $TS_OUTPUT
 
-grep -q $DEVICE /proc/swaps || ts_die "Cannot found $DEVICE in /proc/swaps" $DEVICE
+grep -q $DEVICE /proc/swaps || ts_die "Cannot find $DEVICE in /proc/swaps" $DEVICE
 
 ts_swapoff $DEVICE
 ts_device_deinit $DEVICE
diff --git a/tests/ts/swapon/uuid b/tests/ts/swapon/uuid
index bbcafa2..413b46b 100755
--- a/tests/ts/swapon/uuid
+++ b/tests/ts/swapon/uuid
@@ -30,14 +30,14 @@ DEVICE=$(ts_device_init)
 $TS_CMD_MKSWAP $DEVICE > /dev/null 2>> $TS_OUTPUT \
  || ts_die "Cannot make swap $DEVICE" $DEVICE
 
-ts_device_has_uuid $DEVICE || ts_die "Cannot found UUID on $DEVICE" $DEVICE
+ts_device_has_uuid $DEVICE || ts_die "Cannot find UUID on $DEVICE" $DEVICE
 
 UUID=$(ts_uuid_by_devname $DEVICE)
 
 LD_LIBRARY_PATH="$U_L_LIBRARY_PATH" \
 	$TS_CMD_SWAPON -U $UUID 2>&1 >> $TS_OUTPUT
 
-grep -q $DEVICE /proc/swaps || ts_die "Cannot found $DEVICE in /proc/swaps" $DEVICE
+grep -q $DEVICE /proc/swaps || ts_die "Cannot find $DEVICE in /proc/swaps" $DEVICE
 
 ts_swapoff $DEVICE
 ts_device_deinit $DEVICE
-- 
1.7.4.1
