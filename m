Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:51618 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbcBKTkb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 11 Feb 2016 14:40:31 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 66625AB02
	for <util-linux@vger.kernel.org>; Thu, 11 Feb 2016 19:40:30 +0000 (UTC)
Subject: [PATCH] tests: fix redirection
To: util-linux@vger.kernel.org
References: <56BCE1F6.9000805@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56BCE3AD.408@suse.cz>
Date: Thu, 11 Feb 2016 20:40:29 +0100
MIME-Version: 1.0
In-Reply-To: <56BCE1F6.9000805@suse.cz>
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Many tests do.
2>&1 >> $TS_OUTPUT
It redirects stdout to $TS_OUTPUT and stderr to stdout.

It could cause unintended ignoring of errors on strerr and false positive result
of the test.

Use
>> $TS_OUTPUT 2>&1
instead to redirect both stdout and stderr to $TS_OUTPUT.

Automatically created by:
cd tests/ts
sed -i 's:2>\&1 >> \$TS_OUTPUT:>> $TS_OUTPUT 2>\&1:g' $(fgrep -rl '2>&1 >> $TS_OUTPUT' .)

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 tests/ts/cramfs/doubles            |  2 +-
 tests/ts/cramfs/fsck-endianness    |  2 +-
 tests/ts/cramfs/mkfs               |  2 +-
 tests/ts/hexdump/format-strings    |  4 ++--
 tests/ts/minix/fsck                |  4 ++--
 tests/ts/mount/devname             |  2 +-
 tests/ts/mount/fslists             |  8 ++++----
 tests/ts/mount/fstab-btrfs         | 28 ++++++++++++++--------------
 tests/ts/mount/fstab-devname       |  4 ++--
 tests/ts/mount/fstab-devname2label |  2 +-
 tests/ts/mount/fstab-devname2uuid  |  2 +-
 tests/ts/mount/fstab-label         |  6 +++---
 tests/ts/mount/fstab-label2devname |  4 ++--
 tests/ts/mount/fstab-label2uuid    |  4 ++--
 tests/ts/mount/fstab-none          |  2 +-
 tests/ts/mount/fstab-symlink       |  6 +++---
 tests/ts/mount/fstab-uuid          |  6 +++---
 tests/ts/mount/fstab-uuid2devname  |  4 ++--
 tests/ts/mount/fstab-uuid2label    |  4 ++--
 tests/ts/mount/label               |  4 ++--
 tests/ts/mount/regfile             |  2 +-
 tests/ts/mount/uuid                |  4 ++--
 tests/ts/swapon/devname            |  2 +-
 tests/ts/swapon/label              |  2 +-
 tests/ts/swapon/uuid               |  2 +-
 25 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/tests/ts/cramfs/doubles b/tests/ts/cramfs/doubles
index c815b27..cf6d09b 100755
--- a/tests/ts/cramfs/doubles
+++ b/tests/ts/cramfs/doubles
@@ -41,7 +41,7 @@ echo hello > $IMAGE_SRC/a
 echo hello > $IMAGE_SRC/b
 
 ts_log "create cramfs image"
-$TS_CMD_MKCRAMFS $IMAGE_SRC $IMAGE_PATH 2>&1 >> $TS_OUTPUT
+$TS_CMD_MKCRAMFS $IMAGE_SRC $IMAGE_PATH >> $TS_OUTPUT 2>&1
 [ -s "$IMAGE_PATH" ] || ts_die "Cannot create $IMAGE_PATH"
 
 ts_mount "cramfs" -r $IMAGE_PATH $TS_MOUNTPOINT
diff --git a/tests/ts/cramfs/fsck-endianness b/tests/ts/cramfs/fsck-endianness
index 1ea8f51..d6d2ae3 100755
--- a/tests/ts/cramfs/fsck-endianness
+++ b/tests/ts/cramfs/fsck-endianness
@@ -39,7 +39,7 @@ test_image() {
 
 	rm -rf "$IMAGE_DATA"
 	ts_log "extract from $FROM_ENDIANNESS endian"
-	$TS_CMD_FSCKCRAMFS -v -b 4096 --extract=$IMAGE_DATA $FROM_IMAGE | head -n1 | cut -d" " -f4 2>&1 >> $TS_OUTPUT
+	$TS_CMD_FSCKCRAMFS -v -b 4096 --extract=$IMAGE_DATA $FROM_IMAGE | head -n1 | cut -d" " -f4 >> $TS_OUTPUT 2>&1
 
 	ts_log "create $TO_ENDIANNESS endian"
 	$TS_CMD_MKCRAMFS -N "$TO_ENDIANNESS" -b 4096 "$IMAGE_DATA" \
diff --git a/tests/ts/cramfs/mkfs b/tests/ts/cramfs/mkfs
index c4abb79..78e5c17 100755
--- a/tests/ts/cramfs/mkfs
+++ b/tests/ts/cramfs/mkfs
@@ -70,7 +70,7 @@ find -type f -exec md5sum {} \; | sort >> $TS_OUTPUT
 echo >> $TS_OUTPUT
 
 ts_log "create cramfs image"
-$TS_CMD_MKCRAMFS -n $LABEL $IMAGE_SRC $IMAGE_PATH 2>&1 >> $TS_OUTPUT
+$TS_CMD_MKCRAMFS -n $LABEL $IMAGE_SRC $IMAGE_PATH >> $TS_OUTPUT 2>&1
 [ -s "$IMAGE_PATH" ] || ts_die "Cannot create $IMAGE_PATH"
 
 ts_cd "$TS_OUTDIR"
diff --git a/tests/ts/hexdump/format-strings b/tests/ts/hexdump/format-strings
index f3d9289..e6f9229 100755
--- a/tests/ts/hexdump/format-strings
+++ b/tests/ts/hexdump/format-strings
@@ -32,9 +32,9 @@ BE_EXT=$(test "$BYTE_ORDER" = "BE" && echo ".BE")
 ts_init_subtest "empty-format"
 TS_EXPECTED+=$BE_EXT
 INPUT=$(printf \\1)
-$TS_CMD_HEXDUMP -n1 -ve '2 "" "%x"' <<< $INPUT 2>&1 >> $TS_OUTPUT
+$TS_CMD_HEXDUMP -n1 -ve '2 "" "%x"' <<< $INPUT >> $TS_OUTPUT 2>&1
 
-$TS_CMD_HEXDUMP -n1 -ve '4 "%x"' -e '2 ""' <<< $INPUT 2>&1 >> $TS_OUTPUT
+$TS_CMD_HEXDUMP -n1 -ve '4 "%x"' -e '2 ""' <<< $INPUT >> $TS_OUTPUT 2>&1
 ts_finalize_subtest
 
 #basic formats
diff --git a/tests/ts/minix/fsck b/tests/ts/minix/fsck
index 7a0bb84..b57b20e 100755
--- a/tests/ts/minix/fsck
+++ b/tests/ts/minix/fsck
@@ -30,10 +30,10 @@ ts_device_init
 DEVICE=$TS_LODEV
 
 ts_log "create minix fs"
-$TS_CMD_MKMINIX $DEVICE 2>&1 >> $TS_OUTPUT
+$TS_CMD_MKMINIX $DEVICE >> $TS_OUTPUT 2>&1
 
 ts_log "fsck minix fs"
-$TS_CMD_FSCKMINIX $DEVICE 2>&1 >> $TS_OUTPUT
+$TS_CMD_FSCKMINIX $DEVICE >> $TS_OUTPUT 2>&1
 
 ts_finalize
 
diff --git a/tests/ts/mount/devname b/tests/ts/mount/devname
index 2570fe3..caa79f7 100755
--- a/tests/ts/mount/devname
+++ b/tests/ts/mount/devname
@@ -38,7 +38,7 @@ ts_device_has "TYPE" "ext3" $DEVICE || ts_die "Cannot find ext3 on $DEVICE"
 
 [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
 
-$TS_CMD_MOUNT $DEVICE $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT $DEVICE $TS_MOUNTPOINT >> $TS_OUTPUT 2>&1
 
 ts_is_mounted $DEVICE || ts_die "Cannot find $DEVICE in /proc/mounts"
 
diff --git a/tests/ts/mount/fslists b/tests/ts/mount/fslists
index 63f1fab..64859ba 100755
--- a/tests/ts/mount/fslists
+++ b/tests/ts/mount/fslists
@@ -42,7 +42,7 @@ ts_device_has "TYPE" "ext3" $DEVICE || ts_die "Cannot find ext3 on $DEVICE"
 
 ts_init_subtest "one-type"
 [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
-$TS_CMD_MOUNT -t ext3 $DEVICE $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT -t ext3 $DEVICE $TS_MOUNTPOINT >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $TS_MOUNTPOINT
 ts_log "Success"
@@ -51,7 +51,7 @@ ts_finalize_subtest
 
 ts_init_subtest "more-types"
 [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
-$TS_CMD_MOUNT -t foo,bar,ext3 $DEVICE $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT -t foo,bar,ext3 $DEVICE $TS_MOUNTPOINT >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $TS_MOUNTPOINT
 ts_log "Success"
@@ -61,7 +61,7 @@ ts_finalize_subtest
 ts_init_subtest "more-types-fstab"
 [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
 ts_fstab_add $DEVICE $TS_MOUNTPOINT "foo,bar,ext3"
-$TS_CMD_MOUNT $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT $TS_MOUNTPOINT >> $TS_OUTPUT 2>&1
 ts_fstab_clean
 ts_is_mounted $DEVICE || ts_die "Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $TS_MOUNTPOINT
@@ -71,7 +71,7 @@ ts_finalize_subtest
 
 ts_init_subtest "type-pattern"
 [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
-$TS_CMD_MOUNT -t nofoo,bar $DEVICE $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT -t nofoo,bar $DEVICE $TS_MOUNTPOINT >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $TS_MOUNTPOINT
 ts_log "Success"
diff --git a/tests/ts/mount/fstab-btrfs b/tests/ts/mount/fstab-btrfs
index 0b11fd6..d14ad10 100755
--- a/tests/ts/mount/fstab-btrfs
+++ b/tests/ts/mount/fstab-btrfs
@@ -82,16 +82,16 @@ ts_fstab_add "$DEVICE" "$TS_MOUNTPOINT_SUBVOLID" "btrfs" "subvolid=$NON_DEFAULT_
 # test bind mount pointing to subvolume root
 ts_fstab_add "$TS_MOUNTPOINT_SUBVOLID" "$TS_MOUNTPOINT_BIND" "auto" "bind"
 
-$TS_CMD_MOUNT -a 2>&1 >> $TS_OUTPUT
-$TS_CMD_MOUNT -a 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT -a >> $TS_OUTPUT 2>&1
+$TS_CMD_MOUNT -a >> $TS_OUTPUT 2>&1
 
-$TS_CMD_UMOUNT "$TS_MOUNTPOINT_BIND" 2>&1 >> $TS_OUTPUT
-$TS_CMD_UMOUNT "$TS_MOUNTPOINT_DEFAULT" 2>&1 >> $TS_OUTPUT
-$TS_CMD_UMOUNT "$TS_MOUNTPOINT_SUBVOL" 2>&1 >> $TS_OUTPUT
-$TS_CMD_UMOUNT "$TS_MOUNTPOINT_SUBVOLID" 2>&1 >> $TS_OUTPUT
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_BIND" >> $TS_OUTPUT 2>&1
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_DEFAULT" >> $TS_OUTPUT 2>&1
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_SUBVOL" >> $TS_OUTPUT 2>&1
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_SUBVOLID" >> $TS_OUTPUT 2>&1
 
 # check that everything was unmounted
-$TS_CMD_MOUNT | grep "$TS_MOUNTPOINT_ANY" 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT | grep "$TS_MOUNTPOINT_ANY" >> $TS_OUTPUT 2>&1
 
 ts_fstab_clean
 ts_log "Success"
@@ -108,16 +108,16 @@ ts_fstab_add "$DEVICE" "$TS_MOUNTPOINT_SUBVOLID" "auto" "subvolid=$NON_DEFAULT_S
 # test bind mount pointing to subvolume sub-directory
 ts_fstab_add "$TS_MOUNTPOINT_SUBVOL/bind-mnt" "$TS_MOUNTPOINT_BIND" "auto" "bind"
 
-$TS_CMD_MOUNT -a 2>&1 >> $TS_OUTPUT
-$TS_CMD_MOUNT -a 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT -a >> $TS_OUTPUT 2>&1
+$TS_CMD_MOUNT -a >> $TS_OUTPUT 2>&1
 
-$TS_CMD_UMOUNT "$TS_MOUNTPOINT_BIND" 2>&1 >> $TS_OUTPUT
-$TS_CMD_UMOUNT "$TS_MOUNTPOINT_DEFAULT" 2>&1 >> $TS_OUTPUT
-$TS_CMD_UMOUNT "$TS_MOUNTPOINT_SUBVOL" 2>&1 >> $TS_OUTPUT
-$TS_CMD_UMOUNT "$TS_MOUNTPOINT_SUBVOLID" 2>&1 >> $TS_OUTPUT
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_BIND" >> $TS_OUTPUT 2>&1
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_DEFAULT" >> $TS_OUTPUT 2>&1
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_SUBVOL" >> $TS_OUTPUT 2>&1
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_SUBVOLID" >> $TS_OUTPUT 2>&1
 
 # check that everything was unmounted
-$TS_CMD_MOUNT | grep "$TS_MOUNTPOINT_ANY" 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT | grep "$TS_MOUNTPOINT_ANY" >> $TS_OUTPUT 2>&1
 
 ts_fstab_clean
 ts_log "Success"
diff --git a/tests/ts/mount/fstab-devname b/tests/ts/mount/fstab-devname
index f04e270..8e391c8 100755
--- a/tests/ts/mount/fstab-devname
+++ b/tests/ts/mount/fstab-devname
@@ -40,12 +40,12 @@ ts_device_has "TYPE" "ext3" $DEVICE || ts_die "Cannot find ext3 on $DEVICE"
 ts_fstab_add $DEVICE
 
 # variant A)
-$TS_CMD_MOUNT $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT $TS_MOUNTPOINT >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "A) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "A) Cannot umount $DEVICE"
 
 # variant B)
-$TS_CMD_MOUNT $DEVICE 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT $DEVICE >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "B) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "B) Cannot umount $DEVICE"
 
diff --git a/tests/ts/mount/fstab-devname2label b/tests/ts/mount/fstab-devname2label
index e135a2b..380b91d 100755
--- a/tests/ts/mount/fstab-devname2label
+++ b/tests/ts/mount/fstab-devname2label
@@ -41,7 +41,7 @@ ts_device_has "LABEL" $LABEL $DEVICE \
 
 ts_fstab_add "LABEL=$LABEL"
 
-$TS_CMD_MOUNT $DEVICE 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT $DEVICE >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "Cannot umount $DEVICE"
 
diff --git a/tests/ts/mount/fstab-devname2uuid b/tests/ts/mount/fstab-devname2uuid
index 8fca1b9..3ed19d2 100755
--- a/tests/ts/mount/fstab-devname2uuid
+++ b/tests/ts/mount/fstab-devname2uuid
@@ -41,7 +41,7 @@ UUID=$(ts_uuid_by_devname $DEVICE)
 
 ts_fstab_add "UUID=$UUID"
 
-$TS_CMD_MOUNT $DEVICE 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT $DEVICE >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "Cannot umount $DEVICE"
 
diff --git a/tests/ts/mount/fstab-label b/tests/ts/mount/fstab-label
index 8eec212..bc5a15f 100755
--- a/tests/ts/mount/fstab-label
+++ b/tests/ts/mount/fstab-label
@@ -42,17 +42,17 @@ ts_device_has "LABEL" $LABEL $DEVICE \
 ts_fstab_add "LABEL=$LABEL"
 
 # variant A)
-$TS_CMD_MOUNT $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT $TS_MOUNTPOINT >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "A) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "A) Cannot umount $DEVICE"
 
 # variant B)
-$TS_CMD_MOUNT -L $LABEL 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT -L $LABEL >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "B) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "B) Cannot umount $DEVICE"
 
 # variant C)
-$TS_CMD_MOUNT LABEL=$LABEL 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT LABEL=$LABEL >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "C) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "C) Cannot umount $DEVICE"
 
diff --git a/tests/ts/mount/fstab-label2devname b/tests/ts/mount/fstab-label2devname
index 7ad2349..3dcaad5 100755
--- a/tests/ts/mount/fstab-label2devname
+++ b/tests/ts/mount/fstab-label2devname
@@ -42,12 +42,12 @@ ts_device_has "LABEL" $LABEL $DEVICE \
 ts_fstab_add "$DEVICE"
 
 # variant A)
-$TS_CMD_MOUNT -L $LABEL 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT -L $LABEL >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "A) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "A) Cannot umount $DEVICE"
 
 # variant B)
-$TS_CMD_MOUNT "LABEL=$LABEL" 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT "LABEL=$LABEL" >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "B) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "B) Cannot umount $DEVICE"
 
diff --git a/tests/ts/mount/fstab-label2uuid b/tests/ts/mount/fstab-label2uuid
index 2a759f0..486d070 100755
--- a/tests/ts/mount/fstab-label2uuid
+++ b/tests/ts/mount/fstab-label2uuid
@@ -47,12 +47,12 @@ UUID=$(ts_uuid_by_devname $DEVICE)
 ts_fstab_add "UUID=$UUID"
 
 # variant A)
-$TS_CMD_MOUNT -L $LABEL 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT -L $LABEL >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "A) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "A) Cannot umount $DEVICE"
 
 # variant B)
-$TS_CMD_MOUNT "LABEL=$LABEL" 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT "LABEL=$LABEL" >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "B) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "B) Cannot umount $DEVICE"
 
diff --git a/tests/ts/mount/fstab-none b/tests/ts/mount/fstab-none
index b90008f..ff610a6 100755
--- a/tests/ts/mount/fstab-none
+++ b/tests/ts/mount/fstab-none
@@ -16,7 +16,7 @@ ts_fstab_add "none" "$TS_MOUNTPOINT" "tmpfs" "rw,nosuid,nodev,relatime"
 
 mkdir -p $TS_MOUNTPOINT
 
-$TS_CMD_MOUNT $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT $TS_MOUNTPOINT >> $TS_OUTPUT 2>&1
 [ "$?" = "0" ] || ts_log "error: mount $TS_MOUNTPOINT"
 
 $TS_CMD_FINDMNT --mountpoint "$TS_MOUNTPOINT" &> /dev/null
diff --git a/tests/ts/mount/fstab-symlink b/tests/ts/mount/fstab-symlink
index ba8dafb..1a12b85 100755
--- a/tests/ts/mount/fstab-symlink
+++ b/tests/ts/mount/fstab-symlink
@@ -46,7 +46,7 @@ ln -s $DEVICE $LINKNAME
 ts_fstab_add $LINKNAME $TS_MOUNTPOINT "auto" "defaults,user"
 
 # variant A) -- UID=0
-$TS_CMD_MOUNT $LINKNAME 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT $LINKNAME >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "A) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $LINKNAME || ts_die "A) Cannot umount $LINKNAME"
 
@@ -57,10 +57,10 @@ $TS_CMD_UMOUNT $LINKNAME || ts_die "A) Cannot umount $LINKNAME"
 #ts_init_suid $TS_CMD_MOUNT
 #ts_init_suid $TS_CMD_UMOUNT
 #
-#su $TS_TESTUSER -c "$TS_CMD_MOUNT -v -v -v $LINKNAME" 2>&1 >> $TS_OUTPUT
+#su $TS_TESTUSER -c "$TS_CMD_MOUNT -v -v -v $LINKNAME" >> $TS_OUTPUT 2>&1
 #ts_is_mounted $DEVICE
 #   || ts_die "B) Cannot find $DEVICE in /proc/mounts"
-#su $TS_TESTUSER -c "$TS_CMD_UMOUNT $LINKNAME" 2>&1 >> $TS_OUTPUT \
+#su $TS_TESTUSER -c "$TS_CMD_UMOUNT $LINKNAME" >> $TS_OUTPUT 2>&1 \
 #   || ts_die "B) Cannot umount $LINKNAME"
 
 ts_fstab_clean
diff --git a/tests/ts/mount/fstab-uuid b/tests/ts/mount/fstab-uuid
index 867bc08..afe414d 100755
--- a/tests/ts/mount/fstab-uuid
+++ b/tests/ts/mount/fstab-uuid
@@ -42,17 +42,17 @@ UUID=$(ts_uuid_by_devname $DEVICE)
 ts_fstab_add "UUID=$UUID"
 
 # varian A)
-$TS_CMD_MOUNT $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT $TS_MOUNTPOINT >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "A) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "A) Cannot umount $DEVICE"
 
 # varian B)
-$TS_CMD_MOUNT -U $UUID 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT -U $UUID >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "B) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "B) Cannot umount $DEVICE"
 
 # varian C)
-$TS_CMD_MOUNT UUID=$UUID 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT UUID=$UUID >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "C) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "C) Cannot umount $DEVICE"
 
diff --git a/tests/ts/mount/fstab-uuid2devname b/tests/ts/mount/fstab-uuid2devname
index 0196843..3197148 100755
--- a/tests/ts/mount/fstab-uuid2devname
+++ b/tests/ts/mount/fstab-uuid2devname
@@ -42,12 +42,12 @@ UUID=$(ts_uuid_by_devname $DEVICE)
 ts_fstab_add "$DEVICE"
 
 # variant A)
-$TS_CMD_MOUNT -U $UUID 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT -U $UUID >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "A) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "A) Cannot umount $DEVICE"
 
 # variant B)
-$TS_CMD_MOUNT "UUID=$UUID" 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT "UUID=$UUID" >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "B) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "B) Cannot umount $DEVICE"
 
diff --git a/tests/ts/mount/fstab-uuid2label b/tests/ts/mount/fstab-uuid2label
index 6418389..22c5647 100755
--- a/tests/ts/mount/fstab-uuid2label
+++ b/tests/ts/mount/fstab-uuid2label
@@ -46,12 +46,12 @@ UUID=$(ts_uuid_by_devname $DEVICE)
 ts_fstab_add "LABEL=$LABEL"
 
 # variant A)
-$TS_CMD_MOUNT -U $UUID 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT -U $UUID >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "A) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "A) Cannot umount $DEVICE"
 
 # variant B)
-$TS_CMD_MOUNT "UUID=$UUID" 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT "UUID=$UUID" >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "B) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "B) Cannot umount $DEVICE"
 
diff --git a/tests/ts/mount/label b/tests/ts/mount/label
index 451a9eb..09f598e 100755
--- a/tests/ts/mount/label
+++ b/tests/ts/mount/label
@@ -41,12 +41,12 @@ ts_device_has "LABEL" $LABEL $DEVICE \
 [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
 
 # variant A)
-$TS_CMD_MOUNT -L $LABEL $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT -L $LABEL $TS_MOUNTPOINT >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "A) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "A) Cannot umount $DEVICE"
 
 # variant B)
-$TS_CMD_MOUNT LABEL=$LABEL $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT LABEL=$LABEL $TS_MOUNTPOINT >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "B) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "B) Cannot umount $DEVICE"
 
diff --git a/tests/ts/mount/regfile b/tests/ts/mount/regfile
index 9898062..4f5ce30 100755
--- a/tests/ts/mount/regfile
+++ b/tests/ts/mount/regfile
@@ -21,7 +21,7 @@ mkfs.ext3 -F $IMAGE &> /dev/null || ts_die "Cannot make ext3 on $IMAGE"
 
 [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
 
-$TS_CMD_MOUNT $IMAGE $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT $IMAGE $TS_MOUNTPOINT >> $TS_OUTPUT 2>&1
 
 DEVICE=$(awk '/regfile/ { print $1 }' /proc/mounts)
 
diff --git a/tests/ts/mount/uuid b/tests/ts/mount/uuid
index 442860c..efd2774 100755
--- a/tests/ts/mount/uuid
+++ b/tests/ts/mount/uuid
@@ -40,12 +40,12 @@ UUID=$(ts_uuid_by_devname $DEVICE)
 [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
 
 # variant A)
-$TS_CMD_MOUNT -U $UUID $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT -U $UUID $TS_MOUNTPOINT >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "A) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "A) Cannot umount $DEVICE"
 
 # variant B)
-$TS_CMD_MOUNT UUID=$UUID $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT UUID=$UUID $TS_MOUNTPOINT >> $TS_OUTPUT 2>&1
 ts_is_mounted $DEVICE || ts_die "B) Cannot find $DEVICE in /proc/mounts"
 $TS_CMD_UMOUNT $DEVICE || ts_die "B) Cannot umount $DEVICE"
 
diff --git a/tests/ts/swapon/devname b/tests/ts/swapon/devname
index a4cf99f..978b875 100755
--- a/tests/ts/swapon/devname
+++ b/tests/ts/swapon/devname
@@ -36,7 +36,7 @@ $TS_CMD_MKSWAP $DEVICE > /dev/null 2>> $TS_OUTPUT \
 
 ts_device_has "TYPE" "swap" $DEVICE || ts_die "Cannot find swap on $DEVICE"
 
-$TS_CMD_SWAPON $DEVICE 2>&1 >> $TS_OUTPUT
+$TS_CMD_SWAPON $DEVICE >> $TS_OUTPUT 2>&1
 
 grep -q $DEVICE /proc/swaps || ts_die "Cannot find $DEVICE in /proc/swaps"
 
diff --git a/tests/ts/swapon/label b/tests/ts/swapon/label
index 187ccf9..af7da4f 100755
--- a/tests/ts/swapon/label
+++ b/tests/ts/swapon/label
@@ -38,7 +38,7 @@ $TS_CMD_MKSWAP -L $LABEL $DEVICE > /dev/null 2>> $TS_OUTPUT \
 ts_device_has "LABEL" $LABEL $DEVICE \
  || ts_die "Cannot find LABEL '$LABEL' on $DEVICE"
 
-$TS_CMD_SWAPON -L $LABEL 2>&1 >> $TS_OUTPUT
+$TS_CMD_SWAPON -L $LABEL >> $TS_OUTPUT 2>&1
 
 grep -q $DEVICE /proc/swaps || ts_die "Cannot find $DEVICE in /proc/swaps"
 
diff --git a/tests/ts/swapon/uuid b/tests/ts/swapon/uuid
index 2a8d78f..954e8cd 100755
--- a/tests/ts/swapon/uuid
+++ b/tests/ts/swapon/uuid
@@ -38,7 +38,7 @@ ts_device_has_uuid $DEVICE || ts_die "Cannot find UUID on $DEVICE"
 
 UUID=$(ts_uuid_by_devname $DEVICE)
 
-$TS_CMD_SWAPON -U $UUID 2>&1 >> $TS_OUTPUT
+$TS_CMD_SWAPON -U $UUID >> $TS_OUTPUT 2>&1
 
 grep -q $DEVICE /proc/swaps || ts_die "Cannot find $DEVICE in /proc/swaps"
 
-- 
2.7.0

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
