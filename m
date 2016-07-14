Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32999 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbcGNICr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 14 Jul 2016 04:02:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so8536349wme.0
        for <util-linux@vger.kernel.org>; Thu, 14 Jul 2016 01:02:46 -0700 (PDT)
From: James Clarke <jrtc27@jrtc27.com>
To: util-linux@vger.kernel.org
Cc: James Clarke <jrtc27@jrtc27.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] tests: Fix fdisk/id and fdisk/mbr-nondos-mode on Sparc
Date: Thu, 14 Jul 2016 09:02:24 +0100
Message-Id: <20160714080224.37873-1-jrtc27@jrtc27.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sparc, fdisk defaults to using SUN disk labels, which causes the
output from these tests to differ from non-Sparc.

Signed-off-by: James Clarke <jrtc27@jrtc27.com>
---
 tests/expected/fdisk/id.sparc              |   3 +
 tests/expected/fdisk/mbr-nondos-mode.sparc | 189 +++++++++++++++++++++++++++++
 tests/ts/fdisk/id                          |  13 ++
 tests/ts/fdisk/mbr-nondos-mode             |  13 ++
 4 files changed, 218 insertions(+)

diff --git a/tests/expected/fdisk/id.sparc b/tests/expected/fdisk/id.sparc
new file mode 100644
index 0000000..aa3f407
--- /dev/null
+++ b/tests/expected/fdisk/id.sparc
@@ -0,0 +1,3 @@
+Initialize empty image
+Create MBR with ID=0x1
+Create MBR with ID=0x2
diff --git a/tests/expected/fdisk/mbr-nondos-mode.sparc b/tests/expected/fdisk/mbr-nondos-mode.sparc
new file mode 100644
index 0000000..ffbbd80
--- /dev/null
+++ b/tests/expected/fdisk/mbr-nondos-mode.sparc
@@ -0,0 +1,189 @@
+Initialize empty image
+8f4e33f3dc3e414ff94e5fb6905cba8c mbr-nondos-mode.img
+Create new DOS partition table
+8f4e33f3dc3e414ff94e5fb6905cba8c mbr-nondos-mode.img
+
+---layout----------
+Disk <removed>: 20 MiB, 20971520 bytes, 40960 sectors
+Units: sectors of 1 * 512 = 512 bytes
+Sector size (logical/physical): 512 bytes / 512 bytes
+I/O size (minimum/optimal): 512 bytes / <removed> bytes
+-------------------
+
+Create 1st primary partition
+d5ad6d4e743430c2a61e558bb3319175 mbr-nondos-mode.img
+
+---layout----------
+Disk <removed>: 20 MiB, 20971520 bytes, 40960 sectors
+Geometry: 255 heads, 63 sectors/track, 2 cylinders
+Units: sectors of 1 * 512 = 512 bytes
+Sector size (logical/physical): 512 bytes / 512 bytes
+I/O size (minimum/optimal): 512 bytes / <removed> bytes
+Disklabel type: sun
+
+Device             Start   End Sectors  Size Id Type         Flags
+<removed>1     0 16064   16065  7.9M 83 Linux native      
+<removed>2 16065 32129   16065  7.9M 82 Linux swap      u 
+<removed>3     0 32129   32130 15.7M  5 Whole disk        
+-------------------
+
+Set primary partition active
+d59bb4ba5914242f9a63a2d13fb68752 mbr-nondos-mode.img
+
+---layout----------
+Disk <removed>: 20 MiB, 20971520 bytes, 40960 sectors
+Geometry: 255 heads, 63 sectors/track, 2 cylinders
+Units: sectors of 1 * 512 = 512 bytes
+Sector size (logical/physical): 512 bytes / 512 bytes
+I/O size (minimum/optimal): 512 bytes / <removed> bytes
+Disklabel type: sun
+
+Device             Start   End Sectors  Size Id Type         Flags
+<removed>1     0 16064   16065  7.9M 83 Linux native     r
+<removed>2 16065 32129   16065  7.9M 82 Linux swap      u 
+<removed>3     0 32129   32130 15.7M  5 Whole disk        
+-------------------
+
+Re-create 1st primary partition
+d8ba04bdd46cec690fa672ac8fcaf387 mbr-nondos-mode.img
+
+---layout----------
+Disk <removed>: 20 MiB, 20971520 bytes, 40960 sectors
+Geometry: 255 heads, 63 sectors/track, 2 cylinders
+Units: sectors of 1 * 512 = 512 bytes
+Sector size (logical/physical): 512 bytes / 512 bytes
+I/O size (minimum/optimal): 512 bytes / <removed> bytes
+Disklabel type: sun
+
+Device             Start   End Sectors  Size Id Type         Flags
+<removed>1     0 16064   16065  7.9M 83 Linux native     r
+<removed>2 16065 32129   16065  7.9M 82 Linux swap      u 
+-------------------
+
+Create 2nd primary partition
+d8ba04bdd46cec690fa672ac8fcaf387 mbr-nondos-mode.img
+
+---layout----------
+Disk <removed>: 20 MiB, 20971520 bytes, 40960 sectors
+Geometry: 255 heads, 63 sectors/track, 2 cylinders
+Units: sectors of 1 * 512 = 512 bytes
+Sector size (logical/physical): 512 bytes / 512 bytes
+I/O size (minimum/optimal): 512 bytes / <removed> bytes
+Disklabel type: sun
+
+Device             Start   End Sectors  Size Id Type         Flags
+<removed>1     0 16064   16065  7.9M 83 Linux native     r
+<removed>2 16065 32129   16065  7.9M 82 Linux swap      u 
+-------------------
+
+Create extended partition
+d59bb4ba5914242f9a63a2d13fb68752 mbr-nondos-mode.img
+
+---layout----------
+Disk <removed>: 20 MiB, 20971520 bytes, 40960 sectors
+Geometry: 255 heads, 63 sectors/track, 2 cylinders
+Units: sectors of 1 * 512 = 512 bytes
+Sector size (logical/physical): 512 bytes / 512 bytes
+I/O size (minimum/optimal): 512 bytes / <removed> bytes
+Disklabel type: sun
+
+Device             Start   End Sectors  Size Id Type         Flags
+<removed>1     0 16064   16065  7.9M 83 Linux native     r
+<removed>2 16065 32129   16065  7.9M 82 Linux swap      u 
+<removed>3     0 32129   32130 15.7M  5 Whole disk        
+-------------------
+
+Create logical partitions
+d59bb4ba5914242f9a63a2d13fb68752 mbr-nondos-mode.img
+
+---layout----------
+Disk <removed>: 20 MiB, 20971520 bytes, 40960 sectors
+Geometry: 255 heads, 63 sectors/track, 2 cylinders
+Units: sectors of 1 * 512 = 512 bytes
+Sector size (logical/physical): 512 bytes / 512 bytes
+I/O size (minimum/optimal): 512 bytes / <removed> bytes
+Disklabel type: sun
+
+Device             Start   End Sectors  Size Id Type         Flags
+<removed>1     0 16064   16065  7.9M 83 Linux native     r
+<removed>2 16065 32129   16065  7.9M 82 Linux swap      u 
+<removed>3     0 32129   32130 15.7M  5 Whole disk        
+-------------------
+
+Delete logical partitions
+d59bb4ba5914242f9a63a2d13fb68752 mbr-nondos-mode.img
+
+---layout----------
+Disk <removed>: 20 MiB, 20971520 bytes, 40960 sectors
+Geometry: 255 heads, 63 sectors/track, 2 cylinders
+Units: sectors of 1 * 512 = 512 bytes
+Sector size (logical/physical): 512 bytes / 512 bytes
+I/O size (minimum/optimal): 512 bytes / <removed> bytes
+Disklabel type: sun
+
+Device             Start   End Sectors  Size Id Type         Flags
+<removed>1     0 16064   16065  7.9M 83 Linux native     r
+<removed>2 16065 32129   16065  7.9M 82 Linux swap      u 
+<removed>3     0 32129   32130 15.7M  5 Whole disk        
+-------------------
+
+Create another logical partition
+d59bb4ba5914242f9a63a2d13fb68752 mbr-nondos-mode.img
+
+---layout----------
+Disk <removed>: 20 MiB, 20971520 bytes, 40960 sectors
+Geometry: 255 heads, 63 sectors/track, 2 cylinders
+Units: sectors of 1 * 512 = 512 bytes
+Sector size (logical/physical): 512 bytes / 512 bytes
+I/O size (minimum/optimal): 512 bytes / <removed> bytes
+Disklabel type: sun
+
+Device             Start   End Sectors  Size Id Type         Flags
+<removed>1     0 16064   16065  7.9M 83 Linux native     r
+<removed>2 16065 32129   16065  7.9M 82 Linux swap      u 
+<removed>3     0 32129   32130 15.7M  5 Whole disk        
+-------------------
+
+Delete primary partition
+0bd87175c4c5c3ef9a46595027b6369c mbr-nondos-mode.img
+
+---layout----------
+Disk <removed>: 20 MiB, 20971520 bytes, 40960 sectors
+Geometry: 255 heads, 63 sectors/track, 2 cylinders
+Units: sectors of 1 * 512 = 512 bytes
+Sector size (logical/physical): 512 bytes / 512 bytes
+I/O size (minimum/optimal): 512 bytes / <removed> bytes
+Disklabel type: sun
+
+Device             Start   End Sectors  Size Id Type       Flags
+<removed>2 16065 32129   16065  7.9M 82 Linux swap    u 
+<removed>3     0 32129   32130 15.7M  5 Whole disk      
+-------------------
+
+Delete primary partition
+33f6e541ddcafed65d231ce3f2b76a59 mbr-nondos-mode.img
+
+---layout----------
+Disk <removed>: 20 MiB, 20971520 bytes, 40960 sectors
+Geometry: 255 heads, 63 sectors/track, 2 cylinders
+Units: sectors of 1 * 512 = 512 bytes
+Sector size (logical/physical): 512 bytes / 512 bytes
+I/O size (minimum/optimal): 512 bytes / <removed> bytes
+Disklabel type: sun
+
+Device             Start   End Sectors  Size Id Type       Flags
+<removed>3     0 32129   32130 15.7M  5 Whole disk      
+-------------------
+
+Delete extended partition
+e923755cbc0054eb85341fe119be07f9 mbr-nondos-mode.img
+
+---layout----------
+Disk <removed>: 20 MiB, 20971520 bytes, 40960 sectors
+Geometry: 255 heads, 63 sectors/track, 2 cylinders
+Units: sectors of 1 * 512 = 512 bytes
+Sector size (logical/physical): 512 bytes / 512 bytes
+I/O size (minimum/optimal): 512 bytes / <removed> bytes
+Disklabel type: sun
+-------------------
+
diff --git a/tests/ts/fdisk/id b/tests/ts/fdisk/id
index a24d793..85b87d6 100755
--- a/tests/ts/fdisk/id
+++ b/tests/ts/fdisk/id
@@ -25,6 +25,19 @@ ts_check_test_command "$TS_CMD_FDISK"
 FDISK_CMD_ID1="x\ni\n0x1\nr\nw\n"
 FDISK_CMD_ID2="x\ni\n0x2\nr\nw\n"
 
+# Sparc uses SUN disk labels by default and thus has a different output
+ARCH=$(uname -m)
+case $ARCH in
+	*sparc* )
+		ARCH_EXT=".sparc"
+		;;
+	*)
+		ARCH_EXT=""
+		;;
+esac
+
+TS_EXPECTED+="${ARCH_EXT}"
+
 ts_log "Initialize empty image"
 TEST_IMAGE_NAME=$(ts_image_init 10)
 
diff --git a/tests/ts/fdisk/mbr-nondos-mode b/tests/ts/fdisk/mbr-nondos-mode
index e01b060..7ac5dae 100755
--- a/tests/ts/fdisk/mbr-nondos-mode
+++ b/tests/ts/fdisk/mbr-nondos-mode
@@ -37,6 +37,19 @@ FDISK_CMD_DELETE_1PRIMARY="d\n1\n" # delete first primary
 FDISK_CMD_DELETE_2PRIMARY="d\n2\n" # delete first primary
 FDISK_CMD_DELETE_EXTENDED="d\n3\n" # delete second primary
 
+# Sparc uses SUN disk labels by default and thus has a different output
+ARCH=$(uname -m)
+case $ARCH in
+	*sparc* )
+		ARCH_EXT=".sparc"
+		;;
+	*)
+		ARCH_EXT=""
+		;;
+esac
+
+TS_EXPECTED+="${ARCH_EXT}"
+
 function print_layout {
 	echo -ne "\n---layout----------\n" >> $TS_OUTPUT
 	$TS_CMD_FDISK -l ${TEST_IMAGE_NAME} >> $TS_OUTPUT
-- 
2.9.1

