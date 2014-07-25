Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:56760 "EHLO
	cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752286AbaGYMzW (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Jul 2014 08:55:22 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/4] various: erase all traces of the long-obsolete ext filesystem
Date: Fri, 25 Jul 2014 14:55:04 +0200
Message-Id: <1406292904-3956-4-git-send-email-bensberg@justemail.net>
In-Reply-To: <1406292904-3956-1-git-send-email-bensberg@justemail.net>
References: <1406292904-3956-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The same argument as for xiafs: dead for over ten years.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 bash-completion/findmnt |    2 +-
 bash-completion/mount   |    2 +-
 bash-completion/umount  |    3 ++-
 sys-utils/mount.8       |   13 +++----------
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/bash-completion/findmnt b/bash-completion/findmnt
index 0f62aa4..a7df4a0 100644
--- a/bash-completion/findmnt
+++ b/bash-completion/findmnt
@@ -57,7 +57,7 @@ _findmnt_module()
 		'-t'|'--types')
 			local TYPES
 			TYPES="adfs affs autofs cifs coda coherent cramfs
-				debugfs devpts efs ext ext2 ext3 ext4 hfs
+				debugfs devpts efs ext2 ext3 ext4 hfs
 				hfsplus hpfs iso9660 jfs minix msdos
 				ncpfs nfs nfs4 ntfs proc qnx4 ramfs
 				reiserfs romfs squashfs smbfs sysv tmpfs
diff --git a/bash-completion/mount b/bash-completion/mount
index 7ebcec3..e4a98ad 100644
--- a/bash-completion/mount
+++ b/bash-completion/mount
@@ -18,7 +18,7 @@ cramfs	  nocramfs	ncpfs	  noncpfs	ufs	  noufs
 debugfs	  nodebugfs	nfs	  nonfs		umsdos	  noumsdos
 devpts	  nodevpts	nfs4	  nonfs4	usbfs	  nousbfs
 efs	  noefs		ntfs	  nontfs	vfat	  novfat
-ext	  noext		proc	  noproc	xenix	  noxenix
+			proc	  noproc	xenix	  noxenix
 ext2	  noext2	qnx4	  noqnx4	xfs	  noxfs
 ext3	  noext3	ramfs	  noramfs
 ext4	  noext4	reiserfs  noreiserfs
diff --git a/bash-completion/umount b/bash-completion/umount
index 5be921e..ecf78ec 100644
--- a/bash-completion/umount
+++ b/bash-completion/umount
@@ -18,10 +18,11 @@ cramfs	  nocramfs	ncpfs	  noncpfs	ufs	  noufs
 debugfs	  nodebugfs	nfs	  nonfs		umsdos	  noumsdos
 devpts	  nodevpts	nfs4	  nonfs4	usbfs	  nousbfs
 efs	  noefs		ntfs	  nontfs	vfat	  novfat
-ext	  noext		proc	  noproc	xenix	  noxenix
+			proc	  noproc	xenix	  noxenix
 ext2	  noext2	qnx4	  noqnx4	xfs	  noxfs
 ext3	  noext3	ramfs	  noramfs
 ext4	  noext4	reiserfs  noreiserfs
+hfs	  nohfs		romfs	  noromfs
 "
 			COMPREPLY=( $(compgen -W "$TYPES" -- $cur) )
 			return 0
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 1acd7ce..b6711ad 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -789,14 +789,14 @@ option.  For example, the command
 .RS
 .RS
 .sp
-.B "mount \-a \-t nomsdos,ext"
+.B "mount \-a \-t nomsdos,smbfs"
 .sp
 .RE
 mounts all filesystems except those of type
 .I msdos
 and
-.IR ext .
-
+.IR smbfs .
+.sp
 For most types all the
 .B mount
 program has to do is issue a simple
@@ -1499,15 +1499,8 @@ starting with 2.6.29.  Further, this option is valid only if
 CONFIG_DEVPTS_MULTIPLE_INSTANCES is enabled in the kernel
 configuration.
 
-.SH "Mount options for ext"
-None.
-Note that the `ext' filesystem is obsolete.  Don't use it.
-Since Linux version 2.1.21 extfs is no longer part of the kernel source.
-
 .SH "Mount options for ext2"
 The `ext2' filesystem is the standard Linux filesystem.
-.\" Due to a kernel bug, it may be mounted with random mount options
-.\" (fixed in Linux 2.0.4).
 Since Linux 2.5.46, for most mount options the default
 is determined by the filesystem superblock.  Set them with
 .BR tune2fs (8).
-- 
1.7.0.4

