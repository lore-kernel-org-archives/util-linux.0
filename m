Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37811 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab1HPWTN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 16 Aug 2011 18:19:13 -0400
Received: by mail-wy0-f174.google.com with SMTP id 24so281582wyg.19
        for <util-linux@vger.kernel.org>; Tue, 16 Aug 2011 15:19:12 -0700 (PDT)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 4/5] tests: add ts_fdisk_clean function to make fdisk output comparable
Date: Wed, 17 Aug 2011 00:19:05 +0200
Message-Id: <1313533146-2806-4-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1313533146-2806-1-git-send-email-cosoleto@gmail.com>
References: <1313533146-2806-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 tests/functions.sh                    |    7 +++++++
 tests/ts/blkid/md-raid0-whole         |    5 ++---
 tests/ts/blkid/md-raid1-part          |    6 ++----
 tests/ts/blkid/md-raid1-whole         |    5 ++---
 tests/ts/fdisk/align-512-4K           |    5 +----
 tests/ts/fdisk/align-512-4K-63        |    5 +----
 tests/ts/fdisk/align-512-4K-md        |    5 +----
 tests/ts/fdisk/align-512-512          |    4 +---
 tests/ts/fdisk/align-512-512-topology |    5 +----
 9 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/tests/functions.sh b/tests/functions.sh
index 70bd45a..acfbbee 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -393,3 +393,10 @@ s/# <!-- util-linux.*-->//;
 /^$/d" /etc/fstab
 }
 
+function ts_fdisk_clean {
+	# remove non comparable parts of fdisk output
+	[ x"${DEVNAME}" != x"" ] && sed -i -e "s/\/dev\/${DEVNAME}/\/dev\/.../g" $TS_OUTPUT
+	sed -i -e 's/Disk identifier:.*//g' \
+	       -e 's/Building a new.*//g' \
+	       $TS_OUTPUT
+}
diff --git a/tests/ts/blkid/md-raid0-whole b/tests/ts/blkid/md-raid0-whole
index 2ef7bcd..7a55c54 100755
--- a/tests/ts/blkid/md-raid0-whole
+++ b/tests/ts/blkid/md-raid0-whole
@@ -78,9 +78,8 @@ ts_log "Deinitialize devices"
 ts_device_deinit $DEVICE1
 ts_device_deinit $DEVICE2
 
-# remove disk ID and generated UUIDs
-sed -i -e 's/Disk identifier:.*//g' $TS_OUTPUT
-sed -i -e 's/Building a new.*//g' $TS_OUTPUT
+ts_fdisk_clean
+# remove generated UUIDs
 sed -i -e 's/ID_FS_UUID.*//g' $TS_OUTPUT
 
 ts_finalize
diff --git a/tests/ts/blkid/md-raid1-part b/tests/ts/blkid/md-raid1-part
index c990824..c6245c2 100755
--- a/tests/ts/blkid/md-raid1-part
+++ b/tests/ts/blkid/md-raid1-part
@@ -82,10 +82,8 @@ $TS_CMD_BLKID -p -o udev ${DEVICE}2 2>&1 | sort >> $TS_OUTPUT
 sleep 3
 rmmod scsi_debug
 
-# remove device name used, disk ID and generated UUIDs
-sed -i -e "s/\/dev\/${DEVNAME}/\/dev\/.../g" $TS_OUTPUT
-sed -i -e 's/Disk identifier:.*//g' $TS_OUTPUT
-sed -i -e 's/Building a new.*//g' $TS_OUTPUT
+ts_fdisk_clean
+# remove generated UUIDs
 sed -i -e 's/ID_FS_UUID.*//g' $TS_OUTPUT
 
 ts_finalize
diff --git a/tests/ts/blkid/md-raid1-whole b/tests/ts/blkid/md-raid1-whole
index 75efc42..32e17b8 100755
--- a/tests/ts/blkid/md-raid1-whole
+++ b/tests/ts/blkid/md-raid1-whole
@@ -78,9 +78,8 @@ ts_log "Deinitialize devices"
 ts_device_deinit $DEVICE1
 ts_device_deinit $DEVICE2
 
-# remove disk ID and generated UUIDs
-sed -i -e 's/Disk identifier:.*//g' $TS_OUTPUT
-sed -i -e 's/Building a new.*//g' $TS_OUTPUT
+ts_fdisk_clean
+# remove generated UUIDs
 sed -i -e 's/ID_FS_UUID.*//g' $TS_OUTPUT
 
 ts_finalize
diff --git a/tests/ts/fdisk/align-512-4K b/tests/ts/fdisk/align-512-4K
index cf3bbc0..2885079 100755
--- a/tests/ts/fdisk/align-512-4K
+++ b/tests/ts/fdisk/align-512-4K
@@ -82,9 +82,6 @@ cat /sys/block/${DEVNAME}/${DEVNAME}{1,2,3,4,5,6,7}/alignment_offset >> $TS_OUTP
 sleep 3
 rmmod scsi_debug
 
-# remove device name used and disk ID
-sed -i -e "s/\/dev\/${DEVNAME}/\/dev\/.../g" $TS_OUTPUT
-sed -i -e 's/Disk identifier:.*//g' $TS_OUTPUT
-sed -i -e 's/Building a new.*//g' $TS_OUTPUT
+ts_fdisk_clean
 
 ts_finalize
diff --git a/tests/ts/fdisk/align-512-4K-63 b/tests/ts/fdisk/align-512-4K-63
index cd44ce4..cb8b1a2 100755
--- a/tests/ts/fdisk/align-512-4K-63
+++ b/tests/ts/fdisk/align-512-4K-63
@@ -82,9 +82,6 @@ cat /sys/block/${DEVNAME}/${DEVNAME}{1,2,3,4,5,6,7}/alignment_offset >> $TS_OUTP
 sleep 3
 rmmod scsi_debug
 
-# remove device name used and disk ID
-sed -i -e "s/\/dev\/${DEVNAME}/\/dev\/.../g" $TS_OUTPUT
-sed -i -e 's/Disk identifier:.*//g' $TS_OUTPUT
-sed -i -e 's/Building a new.*//g' $TS_OUTPUT
+ts_fdisk_clean
 
 ts_finalize
diff --git a/tests/ts/fdisk/align-512-4K-md b/tests/ts/fdisk/align-512-4K-md
index ba0f0c8..2aff08c 100755
--- a/tests/ts/fdisk/align-512-4K-md
+++ b/tests/ts/fdisk/align-512-4K-md
@@ -94,9 +94,6 @@ sleep 3
 /sbin/mdadm -q -S ${MD_DEVICE} >> $TS_OUTPUT 2>&1
 rmmod scsi_debug
 
-# remove device name used and disk ID
-sed -i -e "s/\/dev\/${DEVNAME}/\/dev\/.../g" $TS_OUTPUT
-sed -i -e 's/Disk identifier:.*//g' $TS_OUTPUT
-sed -i -e 's/Building a new.*//g' $TS_OUTPUT
+ts_fdisk_clean
 
 ts_finalize
diff --git a/tests/ts/fdisk/align-512-512 b/tests/ts/fdisk/align-512-512
index f60f404..82a6268 100755
--- a/tests/ts/fdisk/align-512-512
+++ b/tests/ts/fdisk/align-512-512
@@ -65,8 +65,6 @@ EOF
 
 ts_device_deinit $DEVICE
 
-# remove disk ID 
-sed -i -e 's/Disk identifier:.*//g' $TS_OUTPUT
-sed -i -e 's/Building a new.*//g' $TS_OUTPUT
+ts_fdisk_clean
 
 ts_finalize
diff --git a/tests/ts/fdisk/align-512-512-topology b/tests/ts/fdisk/align-512-512-topology
index 4563765..95065dc 100755
--- a/tests/ts/fdisk/align-512-512-topology
+++ b/tests/ts/fdisk/align-512-512-topology
@@ -82,9 +82,6 @@ cat /sys/block/${DEVNAME}/${DEVNAME}{1,2,3,4,5,6,7}/alignment_offset >> $TS_OUTP
 sleep 3
 rmmod scsi_debug
 
-# remove device name used and disk ID
-sed -i -e "s/\/dev\/${DEVNAME}/\/dev\/.../g" $TS_OUTPUT
-sed -i -e 's/Disk identifier:.*//g' $TS_OUTPUT
-sed -i -e 's/Building a new.*//g' $TS_OUTPUT
+ts_fdisk_clean
 
 ts_finalize
-- 
1.7.3.4

