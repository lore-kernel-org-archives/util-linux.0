Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:62558 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750706AbaGUV4J (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Jul 2014 17:56:09 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] docs: bring one more man page closer to standard formatting
Date: Mon, 21 Jul 2014 23:56:02 +0200
Message-Id: <1405979762-31641-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/umount.8 |  144 ++++++++++++++++++++++++++-------------------------
 1 files changed, 73 insertions(+), 71 deletions(-)

diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index 4128d2f..9d45157 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -22,23 +22,24 @@
 .\" with this program; if not, write to the Free Software Foundation, Inc.,
 .\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 .\"
-.TH UMOUNT 8 "August 2012" "util-linux" "System Administration"
+.TH UMOUNT 8 "July 2014" "util-linux" "System Administration"
 .SH NAME
 umount \- unmount file systems
 .SH SYNOPSIS
-.B umount
-.RB [ \-hV ]
-.LP
 .B umount \-a
 .RB [ \-dflnrv ]
 .RB [ \-t
 .IR fstype ]
 .RB [ \-O
-.IR options ]
-.br
+.IR option ...]
+.sp
 .B umount
 .RB [ \-dflnrv ]
-.RI { dir | device }...
+.RI { directory | device }...
+.sp
+.B umount
+.BR \-h | \-V
+
 .SH DESCRIPTION
 The
 .B umount
@@ -57,33 +58,31 @@ itself - it opens libc, and libc in its turn may open for example locale
 files.  A lazy unmount avoids this problem.
 .SH OPTIONS
 .TP
-\fB\-a\fR, \fB\-\-all\fR
+.BR \-a , " \-\-all"
 All of the filesystems described in
 .I /etc/mtab
-are unmounted.  (With
-.B umount
-version 2.7 and later: the
-.I proc
-filesystem is not unmounted.)
+are unmounted, except the \fIproc\fR filesystem.
 .TP
-\fB\-A\fR, \fB\-\-all-targets\fR
+.BR \-A , " \-\-all-targets"
 Unmount all mountpoints in the current namespace for the specified filesystem.
-The filesystem could be specified by one of the mountpoints or device name (or
-UUID, etc.). This option could be used together with \fB\-\-recursive\fR then
-all nested mounts within the filesystem are recursively unmounted. The 
-\fB\-\-all-targets\fR is only supported on systems where /etc/mtab is a symlink
+The filesystem can be specified by one of the mountpoints or the device name (or
+UUID, etc.).  When this option is used together with \fB\-\-recursive\fR, then
+all nested mounts within the filesystem are recursively unmounted.
+This option is only supported on systems where /etc/mtab is a symlink
 to /proc/mounts.
 .TP
-\fB\-c\fR, \fB\-\-no\-canonicalize\fR
+.BR \-c , " \-\-no-canonicalize"
 Do not canonicalize paths.  For more details about this option see the
 .BR mount (8)
-man page. Note that umount(8) does not pass this option to /sbin/umount.<type> helpers.
+man page.  Note that \fBumount\fR does not pass this option to the
+.BI /sbin/umount. type
+helpers.
 .TP
-\fB\-d\fR, \fB\-\-detach\-loop\fR
-In case the unmounted device was a loop device, also free this loop
+.BR \-d , " \-\-detach-loop"
+When the unmounted device was a loop device, also free this loop
 device.
 .TP
-\fB\-\-fake\fP
+.B \-\-fake
 Causes everything to be done except for the actual system call; this 'fakes'
 unmounting the filesystem.  It can be used to remove entries from
 .I /etc/mtab
@@ -91,90 +90,93 @@ that were unmounted earlier with the
 .B \-n
 option.
 .TP
-\fB\-f\fR, \fB\-\-force\fR
-Force unmount (in case of an unreachable NFS system).  (Requires kernel
+.BR \-f , " \-\-force"
+Force an unmount (in case of an unreachable NFS system).  (Requires kernel
 2.1.116 or later.)
 .TP
-\fB\-i\fR, \fB\-\-internal\-only\fR
-Do not call the /sbin/umount.<filesystem> helper even if it exists.  By
-default /sbin/umount.<filesystem> helper is called if one exists.
+.BR \-i , " \-\-internal-only"
+Do not call the \fB/sbin/umount.\fIfilesystem\fR helper even if it exists.
+By default such a helper program is called if it exists.
 .TP
-\fB\-n\fR, \fB\-\-no\-mtab\fR
+.BR \-l , " \-\-lazy"
+Lazy unmount.  Detach the filesystem from the file hierarchy now,
+and clean up all references to this filesystem as soon as it is not busy
+anymore.  (Requires kernel 2.4.11 or later.)
+.TP
+.BR \-n , " \-\-no-mtab"
 Unmount without writing in
 .IR /etc/mtab .
 .TP
-\fB\-l\fR, \fB\-\-lazy\fR
-Lazy unmount.  Detach the filesystem from the filesystem hierarchy now,
-and cleanup all references to the filesystem as soon as it is not busy
-anymore.  (Requires kernel 2.4.11 or later.)
-.TP
-\fB\-O\fR, \fB\-\-test\-opts\fR \fIoption\fR
-Indicate that the actions should only be taken on filesystems with the
-specified option in
+.BR \-O , " \-\-test-opts " \fIoption\fR...
+Unmount only the filesystems that have the specified option set in
 .IR /etc/fstab .
 More than one option may be specified in a comma-separated list.
 Each option can be prefixed with
 .B no
-to specify options for which no action should be taken.
+to indicate that no action should be taken for this option.
 .TP
-\fB\-R\fR, \fB\-\-recursive\fR
-Recursively unmount each directory specified. Recursion for each directory will
-stop if any unmount operation in the chain fails for any reason. The relationship
-between mountpoints is determined by /proc/self/mountinfo entries. The filesystem
-must be specified by mountpoint path, recursive unmount by device name (or UUID)
+.BR \-R , " \-\-recursive"
+Recursively unmount each specified directory.  Recursion for each directory will
+stop if any unmount operation in the chain fails for any reason.  The relationship
+between mountpoints is determined by /proc/self/mountinfo entries.  The filesystem
+must be specified by mountpoint path; a recursive unmount by device name (or UUID)
 is unsupported.
 .TP
-\fB\-r\fR, \fB\-\-read\-only\fR
-In case unmounting fails, try to remount read-only.
+.BR \-r , " \-\-read-only"
+When an unmount fails, try to remount the filesystem read-only.
 .TP
-\fB\-t\fR, \fB\-\-types\fR \fItype\fR
+.BR \-t , " \-\-types " \fItype\fR...
 Indicate that the actions should only be taken on filesystems of the
 specified
 .IR type .
 More than one type may be specified in a comma-separated list.  The list
 of filesystem types can be prefixed with
 .B no
-to specify the types of filesystem on which no action should be taken.
+to indicate that no action should be taken for all of the mentioned types.
 .TP
-\fB\-v\fR, \fB\-\-verbose\fR
+.BR \-v , " \-\-verbose"
 Verbose mode.
 .TP
-\fB\-h\fR, \fB\-\-help\fR
-Display help text and exit.
-.TP
-\fB\-V\fR, \fB\-\-version\fR
+.BR \-V , " \-\-version"
 Display version information and exit.
-.SH "THE LOOP DEVICE"
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
+.SH "LOOP DEVICE"
 The
 .B umount
-command will free the loop device (if any) associated with the mount, in
-case it finds the option 'loop=...' in
+command will free the loop device associated with a mount when
+it finds the option \fBloop=...\fR in
 .IR /etc/mtab ,
-or when the \-d option was given.  Any pending loop devices can be freed
-using 'losetup -d', see
+or when the \fB\-d\fR option was given.  Any still associated loop devices
+can be freed by using \fBlosetup -d\fR; see
 .BR losetup (8).
 .SH "EXTERNAL HELPERS"
-The syntax of external umount helpers is:
+The syntax of external unmount helpers is:
 .PP
-.BI /sbin/umount. <suffix>
-.RI { dir | device }
-.RB [ \-nlfvr ]
+.BI /sbin/umount. suffix
+.RI { directory | device }
+.RB [ \-flnrv ]
 .RB [ \-t
-.IR type.subtype ]
+.IR type . subtype ]
 .PP
-where the <suffix> is filesystem type or a value from "uhelper=" or
-"helper=" mtab option.  The \-t option is used for filesystems with
-subtypes support (for example /sbin/mount.fuse -t fuse.sshfs).
+where \fIsuffix\fR is the filesystem type or a value from a "uhelper=" or
+"helper=" mtab option.  The \fB\-t\fR option can be used for filesystems
+with subtypes support (for example \fB/sbin/mount.fuse -t fuse.sshfs\fR).
 .PP
-The uhelper= (unprivileged umount helper) is possible to use when
-non-root user wants to umount a mountpoint which is not defined in the
-/etc/fstab file (e.g. devices mounted by udisk).
+The \fBuhelper=\fR (unprivileged unmount helper) mount option can be used
+when non-root users need to be able to unmount a mountpoint which is not
+defined in \fI/etc/fstab\fR (e.g. devices mounted by udisk).
 .PP
-The helper= mount option redirects all umount requests to the
-/sbin/umount.<helper> independently on UID.
+The \fBhelper=\fR mount option redirects all unmount requests to the
+\fB/sbin/umount.\fItype\fR helper independently of UID.
 .SH FILES
-.I /etc/mtab
+.TP
+.B /etc/mtab
 table of mounted filesystems
+.TP
+.B /etc/fstab
+checked when option \fB\-O\fR is given
 .SH ENVIRONMENT
 .IP LIBMOUNT_FSTAB=<path>
 overrides the default location of the fstab file
-- 
1.7.0.4

