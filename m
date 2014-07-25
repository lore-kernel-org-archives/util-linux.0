Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:64177 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752286AbaGYMzR (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Jul 2014 08:55:17 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/4] various: erase all traces of the long-obsolete xiafs
Date: Fri, 25 Jul 2014 14:55:03 +0200
Message-Id: <1406292904-3956-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1406292904-3956-1-git-send-email-bensberg@justemail.net>
References: <1406292904-3956-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The xiafs filesystem was removed from the kernel fifteen years ago,
and any kernel that contained it reached end of life ten years ago.
It's time to stop mentioning it in the mount man page and elsewhere.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 bash-completion/findmnt |    3 +--
 bash-completion/mount   |    2 +-
 bash-completion/umount  |    2 +-
 disk-utils/fsck.8       |    1 -
 disk-utils/fsck.c       |    3 +--
 disk-utils/mkfs.8       |    3 +--
 sys-utils/mount.8       |    5 -----
 7 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/bash-completion/findmnt b/bash-completion/findmnt
index 3ed331a..0f62aa4 100644
--- a/bash-completion/findmnt
+++ b/bash-completion/findmnt
@@ -61,8 +61,7 @@ _findmnt_module()
 				hfsplus hpfs iso9660 jfs minix msdos
 				ncpfs nfs nfs4 ntfs proc qnx4 ramfs
 				reiserfs romfs squashfs smbfs sysv tmpfs
-				ubifs udf ufs umsdos usbfs vfat xenix xfs
-				xiafs"
+				ubifs udf ufs umsdos usbfs vfat xenix xfs"
 			COMPREPLY=( $(compgen -W "$TYPES" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/mount b/bash-completion/mount
index db97a91..7ebcec3 100644
--- a/bash-completion/mount
+++ b/bash-completion/mount
@@ -20,7 +20,7 @@ devpts	  nodevpts	nfs4	  nonfs4	usbfs	  nousbfs
 efs	  noefs		ntfs	  nontfs	vfat	  novfat
 ext	  noext		proc	  noproc	xenix	  noxenix
 ext2	  noext2	qnx4	  noqnx4	xfs	  noxfs
-ext3	  noext3	ramfs	  noramfs	xiafs	  noxiafs
+ext3	  noext3	ramfs	  noramfs
 ext4	  noext4	reiserfs  noreiserfs
 hfs	  nohfs		romfs	  noromfs
 "
diff --git a/bash-completion/umount b/bash-completion/umount
index f178bd7..5be921e 100644
--- a/bash-completion/umount
+++ b/bash-completion/umount
@@ -20,7 +20,7 @@ devpts	  nodevpts	nfs4	  nonfs4	usbfs	  nousbfs
 efs	  noefs		ntfs	  nontfs	vfat	  novfat
 ext	  noext		proc	  noproc	xenix	  noxenix
 ext2	  noext2	qnx4	  noqnx4	xfs	  noxfs
-ext3	  noext3	ramfs	  noramfs	xiafs	  noxiafs
+ext3	  noext3	ramfs	  noramfs
 ext4	  noext4	reiserfs  noreiserfs
 "
 			COMPREPLY=( $(compgen -W "$TYPES" -- $cur) )
diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index 51864d3..833fca2 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -457,7 +457,6 @@ or
 .BR fsck.nfs (8),
 .BR fsck.vfat (8),
 .BR fsck.xfs (8),
-.BR fsck.xiafs (8),
 .BR reiserfsck (8).
 .ad
 .SH AUTHOR
diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index 40c59c6..a0f9db1 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -81,8 +81,7 @@ static const char *really_wanted[] = {
 	"ext4",
 	"ext4dev",
 	"jfs",
-	"reiserfs",
-	"xiafs"
+	"reiserfs"
 };
 
 /*
diff --git a/disk-utils/mkfs.8 b/disk-utils/mkfs.8
index 6246db9..675822d 100644
--- a/disk-utils/mkfs.8
+++ b/disk-utils/mkfs.8
@@ -100,8 +100,7 @@ for the ext2 filesystem.
 .BR mkfs.minix (8),
 .BR mkfs.msdos (8),
 .BR mkfs.vfat (8),
-.BR mkfs.xfs (8),
-.BR mkfs.xiafs (8)
+.BR mkfs.xfs (8)
 .ad
 .SH AVAILABILITY
 The mkfs command is part of the util-linux package and is available from
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index b73e854..1acd7ce 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -2982,11 +2982,6 @@ where failover must not result in clients seeing
 inconsistent namespace presentation during or after a
 failover event.
 
-.SH "Mount options for xiafs"
-None.  Although nothing is wrong with xiafs, it is not used much,
-and is not maintained.  Probably one shouldn't use it.
-Since Linux version 2.1.21 xiafs is no longer part of the kernel source.
-
 .SH "THE LOOP DEVICE"
 One further possible type is a mount via the loop device.  For example,
 the command
-- 
1.7.0.4

