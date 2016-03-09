Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:51409 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752645AbcCIKzI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Mar 2016 05:55:08 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/3] findmnt: improve formatting and wording of the man page
Date: Wed,  9 Mar 2016 11:54:59 +0100
Message-Id: <1457520901-4133-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 misc-utils/findmnt.8 |   61 +++++++++++++++++++++++++------------------------
 1 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/misc-utils/findmnt.8 b/misc-utils/findmnt.8
index 6133ec2..b199ff8 100644
--- a/misc-utils/findmnt.8
+++ b/misc-utils/findmnt.8
@@ -1,4 +1,4 @@
-.TH FINDMNT 8 "June 2014" "util-linux" "System Administration"
+.TH FINDMNT 8 "June 2015" "util-linux" "System Administration"
 .SH NAME
 findmnt \- find a filesystem
 .SH SYNOPSIS
@@ -18,7 +18,7 @@ findmnt \- find a filesystem
 .SH DESCRIPTION
 .B findmnt
 will list all mounted filesytems or search for a filesystem.  The
-.B findmnt
+.B \%findmnt
 command is able to search in
 .IR /etc/fstab ,
 .IR /etc/mtab
@@ -30,14 +30,14 @@ or
 .IR mountpoint
 is not given, all filesystems are shown.
 .PP
-The device may be specified by device name, maj:min, filesystem LABEL or UUID,
-or partition PARTUUID or PARTLABEL.  Note that
-.B findmnt
+The device may be specified by device name, major:minor numbers,
+filesystem label or UUID, or partition label or UUID.  Note that
+.B \%findmnt
 follows
 .BR mount (8)
 behavior where a device name may be interpreted
-as a mountpoint (and vice versa) if the \fB--target\fR, \fB--mountpoint\fR or
-\fB--source\fR options are not specified.
+as a mountpoint (and vice versa) if the \fB\-\-target\fR, \fB\-\-mountpoint\fR or
+\fB\-\-source\fR options are not specified.
 .PP
 The command prints all mounted filesystems in the tree-like format by default.
 .SH OPTIONS
@@ -49,7 +49,7 @@ Disable all built-in filters and print all filesystems.
 Use ascii characters for tree formatting.
 .TP
 .BR \-b , " \-\-bytes"
-Print the SIZE, USED and AVAIL column in bytes rather than in a human-readable format.
+Print the SIZE, USED and AVAIL columns in bytes rather than in a human-readable format.
 .TP
 .BR \-C , " \-\-nocanonicalize"
 Do not canonicalize paths at all.  This option affects the comparing of paths
@@ -62,7 +62,7 @@ Canonicalize all printed paths.
 Imitate the output of
 .BR df (1).
 This option is equivalent to
-.B -o SOURCE,FSTYPE,SIZE,USED,AVAIL,USE%,TARGET
+.B \-o\ SOURCE,FSTYPE,SIZE,USED,AVAIL,USE%,TARGET
 but excludes all pseudo filesystems.
 Use \fB\-\-all\fP to print all filesystems.
 .TP
@@ -73,7 +73,7 @@ or
 .BR backward .
 .TP
 .BR \-e , " \-\-evaluate"
-Convert all tags (LABEL, UUID, PARTUUID or PARTLABEL) to the device names.
+Convert all tags (LABEL, UUID, PARTUUID or PARTLABEL) to the corresponding device names.
 .TP
 .BR \-F , " \-\-tab\-file \fIpath\fP"
 Search in an alternative file.  If used with \fB\-\-fstab\fP, \fB\-\-mtab\fP
@@ -104,7 +104,7 @@ option and the option \fB\-\-submounts\fP is not used or if more that one
 source file (the option \fB\-F\fP) is specified.
 .TP
 .BR \-M , " \-\-mountpoint \fIpath\fP"
-Explicitly define the mountpoint file or directory. See also \fB\-\-target\fP.
+Explicitly define the mountpoint file or directory.  See also \fB\-\-target\fP.
 .TP
 .BR \-m , " \-\-mtab"
 Search in
@@ -146,7 +146,7 @@ or
 options are not specified.
 
 The default list of columns may be extended if \fIlist\fP is
-specified in the format \fI+list\fP (e.g. \fBfindmnt -o +PROPAGATION\fP).
+specified in the format \fI+list\fP (e.g. \fBfindmnt \-o +PROPAGATION\fP).
 .TP
 .BR \-P , " \-\-pairs"
 Use key="value" output format.  All potentially unsafe characters are hex-escaped (\\x<code>).
@@ -156,7 +156,7 @@ Monitor changes in the /proc/self/mountinfo file.  Supported actions are: mount,
 umount, remount and move.  More than one action may be specified in a
 comma-separated list.  All actions are monitored by default.
 
-The time for which \fB--poll\fR will block can be restricted with the \fB\-\-timeout\fP
+The time for which \fB\-\-poll\fR will block can be restricted with the \fB\-\-timeout\fP
 or \fB\-\-first\-only\fP options.
 
 The standard columns always use the new version of the information from the
@@ -179,7 +179,7 @@ available for umount and remount actions
 .BR \-R , " \-\-submounts"
 Print recursively all submounts for the selected filesystems.  The restrictions
 defined by options \fB\-t\fP, \fB\-O\fP, \fB\-S\fP, \fB\-T\fP and
-\fB\--direction\fP are not applied to submounts.  All submounts are always
+\fB\%\-\-direction\fP are not applied to submounts.  All submounts are always
 printed in tree-like order.  The option enables the tree-like output format by
 default.  This option has no effect for \fB\-\-mtab\fP or \fB\-\-fstab\fP.
 .TP
@@ -187,28 +187,29 @@ default.  This option has no effect for \fB\-\-mtab\fP or \fB\-\-fstab\fP.
 Use raw output format.  All potentially unsafe characters are hex-escaped (\\x<code>).
 .TP
 .BR \-S , " \-\-source \fIspec\fP"
-Explicitly define the mount source.  Supported are \fIdevice\fR, \fImaj:min\fR,
-\fILABEL=\fR, \fIUUID=\fR, \fIPARTLABEL=\fR or \fIPARTUUID=\fR.
+Explicitly define the mount source.  Supported specifications are \fIdevice\fR,
+\fImaj\fB:\fImin\fR, \fBLABEL=\fIlabel\fR, \fBUUID=\fIuuid\fR,
+\fBPARTLABEL=\fIlabel\fR and \fBPARTUUID=\fIuuid\fR.
 .TP
 .BR \-s , " \-\-fstab"
 Search in
 .IR /etc/fstab .
-The output is in the list format (see \fB--list\fR).
+The output is in the list format (see \fB\-\-list\fR).
 .TP
 .BR \-T , " \-\-target \fIpath\fP"
-Define the mount target. If the \fIpath\fR
+Define the mount target.  If \fIpath\fR
 is not a mountpoint file or directory, then
 .B findmnt
-checks \fIpath\fR elements in reverse order to get the mountpoint (this feature is 
-supported only if search in kernel files and unsupported for \fB\-\-fstab\fP). It's
-recommended to use the option \fB--mountpoint\fR when checks of \fIpath\fR elements is
+checks the \fIpath\fR elements in reverse order to get the mountpoint (this feature is
+supported only when searching in kernel files and unsupported for \fB\-\-fstab\fP).  It's
+recommended to use the option \fB\-\-mountpoint\fR when checks of \fIpath\fR elements are
 unwanted and \fIpath\fR is a strictly specified mountpoint.
 .TP
 .BR \-t , " \-\-types \fIlist\fP"
 Limit the set of printed filesystems.  More than one type may be
 specified in a comma-separated list.  The list of filesystem types can be
 prefixed with
-.I no
+.B no
 to specify the filesystem types on which no action should be taken.  For
 more details see
 .BR mount (8).
@@ -228,10 +229,10 @@ Do not truncate text in columns.  The default is to not truncate the
 columns.  This option disables text truncation also in all other columns.
 .TP
 .BR \-v , " \-\-nofsroot"
-Do not print a [/dir] in the SOURCE column for bind-mounts or btrfs subvolumes.
+Do not print a [/dir] in the SOURCE column for bind mounts or btrfs subvolumes.
 .TP
 .BR \-w , " \-\-timeout \fImilliseconds\fP"
-Specify an upper limit on the time for which \fB--poll\fR will block, in milliseconds.
+Specify an upper limit on the time for which \fB\-\-poll\fR will block, in milliseconds.
 .SH EXAMPLES
 .IP "\fBfindmnt \-\-fstab \-t nfs\fP"
 Prints all NFS filesystems defined in
@@ -241,21 +242,21 @@ Prints all
 .IR /etc/fstab
 filesystems where the mountpoint directory is /mnt/foo.  It also prints bind mounts where /mnt/foo
 is a source.
-.IP "\fBfindmnt \-\-fstab --target /mnt/foo\fP"
+.IP "\fBfindmnt \-\-fstab \-\-target /mnt/foo\fP"
 Prints all
 .IR /etc/fstab
 filesystems where the mountpoint directory is /mnt/foo.
-.IP "\fBfindmnt --fstab --evaluate\fP"
+.IP "\fBfindmnt \-\-fstab \-\-evaluate\fP"
 Prints all
 .IR /etc/fstab
 filesystems and converts LABEL= and UUID= tags to the real device names.
-.IP "\fBfindmnt -n --raw --evaluate --output=target LABEL=/boot\fP"
+.IP "\fBfindmnt \-n \-\-raw \-\-evaluate \-\-output=target LABEL=/boot\fP"
 Prints only the mountpoint where the filesystem with label "/boot" is mounted.
-.IP "\fBfindmnt --poll --mountpoint /mnt/foo\fP"
+.IP "\fBfindmnt \-\-poll \-\-mountpoint /mnt/foo\fP"
 Monitors mount, unmount, remount and move on /mnt/foo.
-.IP "\fBfindmnt --poll=umount --first-only --mountpoint /mnt/foo\fP"
+.IP "\fBfindmnt \-\-poll=umount \-\-first-only \-\-mountpoint /mnt/foo\fP"
 Waits for /mnt/foo unmount.
-.IP "\fBfindmnt --poll=remount -t ext3 -O ro\fP"
+.IP "\fBfindmnt \-\-poll=remount \-t ext3 \-O ro\fP"
 Monitors remounts to read-only mode on all ext3 filesystems.
 .SH ENVIRONMENT
 .IP LIBMOUNT_FSTAB=<path>
-- 
1.7.0.4

