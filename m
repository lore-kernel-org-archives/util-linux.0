Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:64066 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752479AbaGYMzN (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Jul 2014 08:55:13 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/4] docs: improve some wordings in the man page of mount
Date: Fri, 25 Jul 2014 14:55:02 +0200
Message-Id: <1406292904-3956-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1406292904-3956-1-git-send-email-bensberg@justemail.net>
References: <1406292904-3956-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also sort the command-line options alphabetically
(with the customary exception of -V and -h).

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/mount.8 |  336 ++++++++++++++++++++++++++++-------------------------
 1 files changed, 177 insertions(+), 159 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 43ef005..b73e854 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -34,26 +34,25 @@
 mount \- mount a filesystem
 .SH SYNOPSIS
 .B mount
-.RB [ \-lhV ]
+.RB [ \-l | \-h | \-V ]
 .LP
-.\" Quote used to include space between arguments
-.B "mount \-a
+.B mount \-a
 .RB [ \-fFnrsvw ]
 .RB [ \-t
-.IR vfstype ]
+.IR fstype ]
 .RB [ \-O
 .IR optlist ]
 .LP
 .B mount
 .RB [ \-fnrsvw ]
 .RB [ \-o
-.IR option [ \fB,\fIoption ]...]
+.IR options ]
 .IR device | dir
 .LP
 .B mount
 .RB [ \-fnrsvw ]
 .RB [ \-t
-.IB vfstype ]
+.IB fstype ]
 .RB [ \-o
 .IR options ]
 .I device dir
@@ -215,7 +214,7 @@ to be mounted as indicated, except for those whose line contains the
 .B noauto
 keyword.  Adding the
 .B \-F
-option will make mount fork, so that the
+option will make \fBmount\fR fork, so that the
 filesystems are mounted simultaneously.
 .LP
 When mounting a filesystem mentioned in
@@ -223,25 +222,23 @@ When mounting a filesystem mentioned in
 or
 .IR mtab ,
 it suffices to specify on the command line only the device, or only the mount point.
-
-
+.sp
 The programs
 .B mount
 and
 .B umount
-traditionally maintained list of currently mounted filesystems in the file
+traditionally maintained a list of currently mounted filesystems in the file
 .IR /etc/mtab .
-The mtab file is still supported, but it's recommended to use a symlink to 
-the file
+This real mtab file is still supported, but on current Linux systems it is
+better to make it a symlink to
 .I /proc/mounts
-rather than the regular mtab file on the current Linux systems.
-The mtab file maintained in userspace cannot reliably work with namespaces, containers
-and another advanced Linux features.
-
+instead, because a regular mtab file maintained in userspace cannot reliably
+work with namespaces, containers and other advanced Linux features.
+.sp
 If no arguments are given to
 .BR mount ,
-this list is printed.
-
+the list of mounted filesystems is printed.
+.sp
 If you want to override mount options from
 .I /etc/fstab
 you have to use the \fB\-o\fR option:
@@ -255,7 +252,7 @@ the list of options from
 .IR /etc/fstab .
 The usual behavior is that the last option wins if there are conflicting
 ones.
-
+.sp
 The
 .B mount
 program does not read the
@@ -532,24 +529,36 @@ option, when present.
 The command \fBmount\fR does not pass all command-line options to the
 \fB/sbin/mount.\fIsuffix\fR mount helpers.  The interface between \fBmount\fR
 and the mount helpers is described below in the section EXTERNAL HELPERS.
-
+.sp
 Command-line options available for the
 .B mount
 command are:
-.IP "\fB\-V, \-\-version\fP"
-Display version information and exit.
-.IP "\fB\-h, \-\-help\fP"
-Display help text and exit.
-.IP "\fB\-v, \-\-verbose\fP"
-Verbose mode.
-.IP "\fB\-a, \-\-all\fP"
+.TP
+.BR \-a , " \-\-all"
 Mount all filesystems (of the given types) mentioned in
 .I fstab
 (except for those whose line contains the
 .B noauto
 keyword).  The filesystems are mounted following their order in
 .IR fstab .
-.IP "\fB\-F, \-\-fork\fP"
+.TP
+.BR \-B , " \-\-bind"
+Remount a subtree somewhere else (so that its contents are available
+in both places).  See above.
+.TP
+.BR \-c , " \-\-no-canonicalize"
+Don't canonicalize paths.  The mount command canonicalizes all paths
+(from command line or fstab) by default.  This option can be used
+together with the
+.B \-f
+flag for already canonicalized absolute paths.  The option is designed for mount
+helpers which call \fBmount -i\fR.  It is strongly recommended to not use this
+command-line option for normal mount operations.
+.sp
+Note that \fBmount\fR(8) does not pass this option to the
+\fB/sbin/mount.\fItype\fR helpers.
+.TP
+.BR \-F , " \-\-fork"
 (Used in conjunction with
 .BR \-a .)
 Fork off a new incarnation of \fBmount\fR for each device.
@@ -574,7 +583,12 @@ checks for an existing record in /etc/mtab and fails when the record already
 exists (with a regular non-fake mount, this check is done by the kernel).
 .IP "\fB\-i, \-\-internal-only\fP"
 Don't call the \fB/sbin/mount.\fIfilesystem\fR helper even if it exists.
-.IP "\fB\-l, \-\-show-labels\fP"
+.TP
+.BR \-L , " \-\-label " \fIlabel
+Mount the partition that has the specified
+.IR label .
+.TP
+.BR \-l , " \-\-show-labels"
 Add the labels in the mount output.  \fBmount\fR must have
 permission to read the disk device (e.g.\& be suid root) for this to work.
 One can set such a label for ext2, ext3 or ext4 using the
@@ -583,39 +597,85 @@ utility, or for XFS using
 .BR xfs_admin (8),
 or for reiserfs using
 .BR reiserfstune (8).
-.IP "\fB\-n, \-\-no-mtab\fP"
+.TP
+.BR \-M , " \-\-move"
+Move a subtree to some other place.  See above.
+.TP
+.BR \-n , " \-\-no-mtab"
 Mount without writing in
 .IR /etc/mtab .
 This is necessary for example when
 .I /etc
 is on a read-only filesystem.
-.IP "\fB\-c, \-\-no-canonicalize\fP"
-Don't canonicalize paths.  The mount command canonicalizes all paths
-(from command line or fstab) by default.  This option can be used
-together with the
-.B \-f
-flag for already canonicalized absolute paths.  The option is designed for mount
-helpers which call \fBmount -i\fR.  It is strongly recommended to not use this
-command-line option for normal mount operations.
+.TP
+.BR \-O , " \-\-test-opts " \fIopts
+Limit the set of filesystems to which the
+.B \-a
+option applies.  In this regard it is like the
+.B \-t
+option except that
+.B \-O
+is useless without
+.BR \-a .
+For example, the command:
+.RS
+.RS
+.sp
+.B "mount \-a \-O no_netdev"
+.sp
+.RE
+mounts all filesystems except those which have the option
+.I _netdev
+specified in the options field in the
+.I /etc/fstab
+file.
 
-Note that \fBmount\fR(8) does not pass this option to the
-\fB/sbin/mount.\fItype\fR helpers.
-.IP "\fB\-s\fP"
-Tolerate sloppy mount options rather than failing.  This will ignore mount
-options not supported by a filesystem type.  Not all filesystems support this
-option.  Currently it's supported by the \fBmount.nfs\fR mount helper only.
-.IP "\fB\-\-source \fIdev\fP"
-If only one argument for the mount command is given then the argument might be
-interpreted as target (mountpoint) or source (device).  This option allows to
-explicitly define that the argument is the mount source.
-.IP "\fB\-\-target \fIdir\fP"
-If only one argument for the mount command is given then the argument might be
-interpreted as target (mountpoint) or source (device).  This option allows to
-explicitly define that the argument is the mount target.
-.IP "\fB\-r, \-\-read-only\fP"
+It is different from
+.B \-t
+in that each option is matched exactly; a leading
+.B no
+at the beginning of one option does not negate the rest.
+
+The
+.B \-t
+and
+.B \-O
+options are cumulative in effect; that is, the command
+.RS
+.sp
+.B "mount \-a \-t ext2 \-O _netdev"
+.sp
+.RE
+mounts all ext2 filesystems with the _netdev option, not all filesystems
+that are either ext2 or have the _netdev option specified.
+.RE
+.TP
+.BR \-o , " \-\-options " \fIopts
+Use the specified mount options.  The \fIopts\fR argument is
+a comma-separated list.  For example:
+.RS
+.RS
+.sp
+.B "mount LABEL=mydisk \-o noatime,nodev,nosuid"
+.sp
+.RE
+
+For more details, see the
+.B FILESYSTEM-INDEPENDENT MOUNT OPTIONS
+and
+.B FILESYSTEM-SPECIFIC MOUNT OPTIONS
+sections.
+.RE
+
+.TP
+.BR \-R , " \-\-rbind"
+Remount a subtree and all possible submounts somewhere else (so that its
+contents are available in both places).  See above.
+.TP
+.BR \-r , " \-\-read-only"
 Mount the filesystem read-only.  A synonym is
 .BR "\-o ro" .
-
+.sp
 Note that, depending on the filesystem type, state and kernel behavior, the
 system may still write to the device.  For example, ext3 and ext4 will replay the
 journal if the filesystem is dirty.  To prevent this kind of write access, you
@@ -623,19 +683,23 @@ may want to mount an ext3 or ext4 filesystem with the \fBro,noload\fR mount
 options or set the block device itself to read-only mode, see the
 .BR blockdev (8)
 command.
-.IP "\fB\-w, \-\-rw, \-\-read-write\fP"
-Mount the filesystem read/write.  This is the default.  A synonym is
-.BR "\-o rw" .
-.IP "\fB\-L, \-\-label \fIlabel\fP"
-Mount the partition that has the specified
-.IR label .
-.IP "\fB\-U, \-\-uuid \fIuuid\fP"
-Mount the partition that has the specified
-.IR uuid .
-These two options require the file
-.I /proc/partitions
-(present since Linux 2.1.116) to exist.
-.IP "\fB\-T, \-\-fstab \fIpath\fP"
+.TP
+.B \-s
+Tolerate sloppy mount options rather than failing.  This will ignore mount
+options not supported by a filesystem type.  Not all filesystems support this
+option.  Currently it's supported by the \fBmount.nfs\fR mount helper only.
+.TP
+.BI \-\-source " device"
+If only one argument for the mount command is given then the argument might be
+interpreted as target (mountpoint) or source (device).  This option allows to
+explicitly define that the argument is the mount source.
+.TP
+.BI \-\-target " directory"
+If only one argument for the mount command is given then the argument might be
+interpreted as target (mountpoint) or source (device).  This option allows to
+explicitly define that the argument is the mount target.
+.TP
+.BR \-T , " \-\-fstab " \fIpath
 Specifies an alternative fstab file.  If \fIpath\fP is a directory then the files
 in the directory are sorted by
 .BR strverscmp (3);
@@ -643,22 +707,23 @@ files that start with "."\& or without an \&.fstab extension are ignored.  The o
 can be specified more than once.  This option is mostly designed for initramfs
 or chroot scripts where additional configuration is specified beyond standard
 system configuration.
-
+.sp
 Note that \fBmount\fR(8) does not pass the option \fB\-\-fstab\fP to the
 \fB/sbin/mount.\fItype\fR helpers, meaning that the alternative fstab files will be
 invisible for the helpers.  This is no problem for normal mounts, but user
 (non-root) mounts always require fstab to verify the user's rights.
-.IP "\fB\-t, \-\-types \fIvfstype\fP"
+.TP
+.BR \-t , " \-\-types " \fIfstype
 The argument following the
 .B \-t
 is used to indicate the filesystem type.  The filesystem types which are
-currently supported depend on kernel. See
+currently supported depend on the running kernel.  See
 .I /proc/filesystems
 and
 .I /lib/modules/$(uname -r)/kernel/fs
-for complete list of the filesystems. The most common are ext2, ext3, ext4, 
+for a complete list of the filesystems.  The most common are ext2, ext3, ext4,
 xfs, btrfs, vfat, sysfs, proc, nfs and cifs.
-
+.sp
 The programs
 .B mount
 and
@@ -691,7 +756,7 @@ ends in a line with a single *, mount will read
 .I /proc/filesystems
 afterwards.  While trying, all filesystem types will be
 mounted with the mount option \fBsilent\fR.
-
+.sp
 The
 .B auto
 type may be useful for user-mounted floppies.
@@ -699,23 +764,23 @@ Creating a file
 .I /etc/filesystems
 can be useful to change the probe order (e.g., to try vfat before msdos
 or ext3 before ext2) or if you use a kernel module autoloader.
-
+.sp
 More than one type may be specified in a comma-separated
-list for
+list, for option
 .B \-t
-as well as by
+as well as in an
 .I /etc/fstab
-entry.  The list of filesystem types for the option
-.B \-t 
+entry.  The list of filesystem types for option
+.B \-t
 can be prefixed with
 .B no
 to specify the filesystem types on which no action should be taken.
 The prefix
 .B no
-has no any effect when specified by
+has no effect when specified in an
 .I /etc/fstab
 entry.
-
+.sp
 The prefix
 .B no
 can be meaningful with the
@@ -750,72 +815,23 @@ program have different calling conventions,
 .B /sbin/mount.smbfs
 may have to be a shell script that sets up the desired call.
 .RE
-
-.IP "\fB\-O, \-\-test-opts \fIopts\fP"
-Limit the set of filesystems to which the
-.B \-a
-option applies.  In this regard it is like the
-.B \-t
-option except that
-.B \-O
-is useless without
-.BR \-a .
-For example, the command:
-.RS
-.RS
-.sp
-.B "mount \-a \-O no_netdev"
-.sp
-.RE
-mounts all filesystems except those which have the option
-.I _netdev
-specified in the options field in the
-.I /etc/fstab
-file.
-
-It is different from
-.B \-t
-in that each option is matched exactly; a leading
-.B no
-at the beginning of one option does not negate the rest.
-
-The
-.B \-t
-and
-.B \-O
-options are cumulative in effect; that is, the command
-.RS
-.sp
-.B "mount \-a \-t ext2 \-O _netdev"
-.sp
-.RE
-mounts all ext2 filesystems with the _netdev option, not all filesystems
-that are either ext2 or have the _netdev option specified.
-.RE
-.IP "\fB\-o, \-\-options \fIopts\fP"
-Use the specified mount options.  The \fIopts\fR argument is
-a comma-separated list.  For example:
-.RS
-.RS
-.sp
-.B "mount LABEL=mydisk \-o noatime,nodev,nosuid"
-.sp
-.RE
-
-For more details, see the
-.B FILESYSTEM-INDEPENDENT MOUNT OPTIONS
-and
-.B FILESYSTEM-SPECIFIC MOUNT OPTIONS
-sections.
-.RE
-.IP "\fB\-B, \-\-bind\fP"
-Remount a subtree somewhere else (so that its contents are available
-in both places).  See above.
-.IP "\fB\-R, \-\-rbind\fP"
-Remount a subtree and all possible submounts somewhere else (so that its
-contents are available in both places).  See above.
-.IP "\fB\-M, \-\-move\fP"
-Move a subtree to some other place.  See above.
+.TP
+.BR \-U , " \-\-uuid " \fIuuid
+Mount the partition that has the specified
+.IR uuid .
+.TP
+.BR \-v , " \-\-verbose"
+Verbose mode.
+.TP
+.BR \-w , " \-\-rw" , " \-\-read-write"
+Mount the filesystem read/write.  This is the default.  A synonym is
+.BR "\-o rw" .
+.TP
+.BR \-V , " \-\-version"
+Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 
 .SH FILESYSTEM-INDEPENDENT MOUNT OPTIONS
 Some of these options are only useful when they appear in the
@@ -966,8 +982,8 @@ Do not permit direct execution of any binaries on the mounted filesystem.
 /lib/ld*.so /mnt/binary.  This trick fails since Linux 2.4.25 / 2.6.0.)
 .TP
 .B group
-Allow an ordinary (i.e., non-root) user to mount the filesystem if one
-of his groups matches the group of the device.
+Allow an ordinary user to mount the filesystem if one
+of that user's groups matches the group of the device.
 This option implies the options
 .BR nosuid " and " nodev
 (unless overridden by subsequent options, as in the option line
@@ -1044,8 +1060,8 @@ Turn on the silent flag.
 Turn off the silent flag.
 .TP
 .B owner
-Allow an ordinary (i.e., non-root) user to mount the filesystem if he
-is the owner of the device.
+Allow an ordinary user to mount the filesystem if that
+user is the owner of the device.
 This option implies the options
 .BR nosuid " and " nodev
 (unless overridden by subsequent options, as in the option line
@@ -1090,31 +1106,33 @@ media with a limited number of write cycles
 .TP
 .B user
 Allow an ordinary user to mount the filesystem.
-The name of the mounting user is written to mtab (or to the private libmount
-file in /run/mount on system without regular mtab) so that he can unmount the
-filesystem again.
+The name of the mounting user is written to the mtab file (or to the private
+libmount file in /run/mount on systems without a regular mtab) so that this
+same user can unmount the filesystem again.
 This option implies the options
 .BR noexec ", " nosuid ", and " nodev
 (unless overridden by subsequent options, as in the option line
 .BR user,exec,dev,suid ).
 .TP
 .B nouser
-Forbid an ordinary (i.e., non-root) user to mount the filesystem.
+Forbid an ordinary user to mount the filesystem.
 This is the default; it does not imply any other options.
 .TP
 .B users
-Allow every user to mount and unmount the filesystem.
+Allow any user to mount and to unmount the filesystem, even
+when some other ordinary user mounted it.
 This option implies the options
 .BR noexec ", " nosuid ", and " nodev
 (unless overridden by subsequent options, as in the option line
 .BR users,exec,dev,suid ).
 .TP
 .B x-*
-All options prefixed with "x-" are interpreted as comments or userspace
+All options prefixed with "x-" are interpreted as comments or as userspace
 application-specific options.  These options are not stored in the mtab file,
-nor sent to the mount.<type> helpers nor the
+nor sent to the mount.\fItype\fR helpers nor to the
 .BR mount (2)
-system call.  The suggested format is x-<appname>.<option> (e.g.\& x-systemd.automount).
+system call.  The suggested format is \fBx-\fIappname\fR.\fIoption\fR
+(e.g.\& \fBx-systemd.automount\fR).
 .TP
 .BR x-mount.mkdir [ = \fImode\fR ]
 Allow to make a target directory (mountpoint).  The optional argument
@@ -1129,7 +1147,7 @@ The following options apply only to certain filesystems.
 We sort them by filesystem.  They all follow the
 .B \-o
 flag.
-
+.sp
 What options are supported depends a bit on the running kernel.
 More info may be found in the kernel source subdirectory
 .IR Documentation/filesystems .
-- 
1.7.0.4

