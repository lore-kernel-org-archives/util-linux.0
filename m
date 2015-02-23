Return-Path: util-linux-owner@vger.kernel.org
Received: from mta04.eastlink.ca ([24.224.136.10]:58549 "EHLO
	mta04.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbbBWLKh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 23 Feb 2015 06:10:37 -0500
Received: from cmgw05.eastlink.ca ([71.7.199.171])
 by mta04.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NK800D791EBTD50@mta04.eastlink.ca> for
 util-linux@vger.kernel.org; Mon, 23 Feb 2015 07:10:35 -0400 (AST)
Received: from tesla ([10.0.0.17])	by llama.cordes.ca with esmtp
 (Exim 3.36 #1 (Debian))	id 1YPquI-0003MN-00	for <util-linux@vger.kernel.org>;
 Mon, 23 Feb 2015 07:10:34 -0400
From: Peter Cordes <peter@cordes.ca>
To: util-linux@vger.kernel.org
Subject: [PATCH] docs: fstab(5) grammar / English fixes, and some other updates
Date: Mon, 23 Feb 2015 07:10:34 -0400
Message-id: <1424689834-29236-1-git-send-email-peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I proofread the whole thing.  I fixed everything that I thought could use
improvement.

various grammar fixes (commas, word order, etc.).

Added an example line.

Reworded a couple things to hopefully make it clear to someone that
didn't already know about fstab.

Expanded on a couple things.

Tightened up the wording in some other places to get the point across
faster and in less space.

Updated the date.

Signed-off-by: Peter Cordes <peter@cordes.ca>
---
 sys-utils/fstab.5 | 85 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 37 deletions(-)

diff --git a/sys-utils/fstab.5 b/sys-utils/fstab.5
index 9287519..4f5369c 100644
--- a/sys-utils/fstab.5
+++ b/sys-utils/fstab.5
@@ -31,7 +31,7 @@
 .\"
 .\"     @(#)fstab.5	6.5 (Berkeley) 5/10/91
 .\"
-.TH FSTAB 5 "August 2010" "util-linux" "File Formats"
+.TH FSTAB 5 "February 2015" "util-linux" "File Formats"
 .SH NAME
 fstab \- static information about the filesystems
 .SH SYNOPSIS
@@ -39,12 +39,12 @@ fstab \- static information about the filesystems
 .SH DESCRIPTION
 The file
 .B fstab
-contains descriptive information about the various file systems.
+contains descriptive information about the filesystems the system can mount.
 .B fstab
 is only read by programs, and not written; it is the duty of the system
 administrator to properly create and maintain this file.  Each filesystem
 is described on a separate line; fields on each line are separated by tabs or
-spaces.  Lines starting with '#' are comments, blank lines are ignored. The
+spaces.  Lines starting with '#' are comments.  Blank lines are ignored. The
 order of records in
 .B fstab
 is important because
@@ -56,27 +56,38 @@ sequentially iterate through
 .B fstab
 doing their thing.
 
+This is a typical example of an
+.B fstab
+entry:
+.sp 1
+LABEL=t-home2   /home      ext4    defaults,auto_da_alloc      0 2
+
 .B The first field
 .RI ( fs_spec ).
 .RS
 This field describes the block special device or
 remote filesystem to be mounted.
 .LP
-For ordinary mounts it will hold (a link to) a block special
+For ordinary mounts, it will hold (a link to) a block special
 device node (as created by
 .BR mknod (8))
 for the device to be mounted, like `/dev/cdrom' or `/dev/sdb7'.
-For NFS mounts one will have <host>:<dir>, e.g., `knuth.aeb.nl:/'.
-For procfs, use `proc'.
+For NFS mounts, this field is <host>:<dir>, e.g., `knuth.aeb.nl:/'.
+For filesystems with no storage, any string can be used, and will show up in
+.BR df (1)
+output, for example.  Typical usage is `proc' for procfs; `mem', `none',
+or `tmpfs' for tmpfs.  Other special filesystems, like udev and sysfs,
+are typically not listed in
+.BR fstab .
 .LP
-Instead of giving the device explicitly, one may indicate
-the filesystem that is to be mounted by its UUID or
-LABEL (cf.
+Instead of a device name, LABEL=<label> or UUID=<uuid> may be given.
+This is the recommended method, as device names are often a coincidence
+of hardware detection order, and can change when other disks are added or removed.
+(cf.
 .BR e2label (8)
 or
-.BR xfs_admin (8)),
-writing LABEL=<label> or UUID=<uuid>,
-e.g., `LABEL=Boot' or `UUID=3e6be9de\%-8139\%-11d1\%-9106\%-a43f08d823a6'.
+.BR xfs_admin (8)).
+For example, `LABEL=Boot' or `UUID=3e6be9de\%-8139\%-11d1\%-9106\%-a43f08d823a6'.
 
 It's also possible to use PARTUUID= and PARTLABEL=. These partitions identifiers
 are supported for example for GUID Partition Table (GPT).
@@ -86,7 +97,7 @@ See
 .BR blkid (8)
 or
 .BR lsblk (8)
-for more details about devices identifiers.
+for more details about device identifiers.
 
 .LP
 Note that
@@ -106,9 +117,9 @@ contains spaces these can be escaped as `\\040'.
 .B The third field
 .RI ( fs_vfstype ).
 .RS
-This field describes the type of the filesystem.  Linux supports lots
-of filesystem types, the most common are ext2, ext3, ext4, xfs, btrfs, vfat,
-sysfs, proc, nfs and cifs. For more details, see
+This field describes the type of the filesystem.  Linux supports many
+filesystem types, including ext4, xfs, btrfs, vfat, ntfs, hfsplus,
+tmpfs, sysfs, proc, iso9660, udf, nfs, cifs, and many more. For more details, see
 .BR mount (8).
 
 An entry
@@ -138,14 +149,19 @@ deprecated).
 .RS
 This field describes the mount options associated with the filesystem.
 
-It is formatted as a comma separated list of options.  It contains at least
-the type of mount plus any additional options appropriate to the filesystem
-type. For documentation on the available mount options, see
-.BR mount (8).
-For documentation on the available swap options, see
+It is formatted as a comma separated list of options.
+It contains at least the type of mount
+.RB ( ro
+or
+.BR rw ),
+plus any additional options appropriate to the filesystem
+type (including performance-tuning options).
+For details, see
+.BR mount (8)
+or
 .BR swapon (8).
 
-Basic file system independent options are:
+Basic filesystem independent options are:
 .TP
 .B defaults
 use default options: rw, suid, dev, exec, auto, nouser, and async.
@@ -171,31 +187,26 @@ do not report errors for this device if it does not exist.
 .B The fifth field
 .RI ( fs_freq ).
 .RS
-This field is used for these filesystems by the
+This field is used by
 .BR dump (8)
-command to determine which filesystems need to be dumped.  If the fifth
-field is not present, a value of zero is returned and
-.B dump
-will assume that the filesystem does not need to be dumped.
+to determine which filesystems need to be dumped.
+Defaults to zero (don't dump) if not present.
 .RE
 
 .B The sixth field
 .RI ( fs_passno ).
 .RS
-This field is used by the
+This field is used by
 .BR fsck (8)
-program to determine the order in which filesystem checks are done at
-reboot time.  The root filesystem should be specified with a
+to determine the order in which filesystem checks are done at
+boot time.  The root filesystem should be specified with a
 .I fs_passno
-of 1, and other filesystems should have a
+of 1.  Other filesystems should have a
 .I fs_passno
 of 2.  Filesystems within a drive will be checked sequentially, but
 filesystems on different drives will be checked at the same time to utilize
-parallelism available in the hardware.  If the sixth field is not present
-or zero, a value of zero is returned and
-.B fsck
-will assume that the filesystem does not need to be checked.
-.RE
+parallelism available in the hardware.
+Defaults to zero (don't fsck) if not present.
 
 .SH NOTES
 The proper way to read records from
@@ -207,7 +218,7 @@ or
 
 The keyword
 .B ignore
-as filesystem type (3rd field) is not more supported by the pure
+as a filesystem type (3rd field) is no longer supported by the pure
 libmount based mount utility (since util-linux v2.22).
 
 .SH FILES
-- 
2.3.0

