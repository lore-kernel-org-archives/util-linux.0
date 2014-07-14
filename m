Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:58830 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751487AbaGNJD2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Jul 2014 05:03:28 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/5] docs: many tiny formatting and wording improvements to man page of mount
Date: Mon, 14 Jul 2014 11:02:59 +0200
Message-Id: <1405328581-2202-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1405328581-2202-1-git-send-email-bensberg@justemail.net>
References: <1405328581-2202-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/mount.8 |  985 ++++++++++++++++++++++++++---------------------------
 1 files changed, 490 insertions(+), 495 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index fc8225a..9723c3b 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -29,7 +29,7 @@
 .\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 .\"
 .\"
-.TH MOUNT 8 "January 2012" "util-linux" "System Administration"
+.TH MOUNT 8 "July 2014" "util-linux" "System Administration"
 .SH NAME
 mount \- mount a filesystem
 .SH SYNOPSIS
@@ -47,7 +47,7 @@ mount \- mount a filesystem
 .B mount
 .RB [ \-fnrsvw ]
 .RB [ \-o
-.IR option [ \fB,\fPoption ]...]
+.IR option [ \fB,\fIoption ]...]
 .IR device | dir
 .LP
 .B mount
@@ -61,16 +61,16 @@ mount \- mount a filesystem
 All files accessible in a Unix system are arranged in one big
 tree, the file hierarchy, rooted at
 .BR / .
-These files can be spread out over several devices. The
+These files can be spread out over several devices.  The
 .B mount
 command serves to attach the filesystem found on some device
-to the big file tree. Conversely, the
+to the big file tree.  Conversely, the
 .BR umount (8)
 command will detach it again.
 
 The standard form of the
 .B mount
-command, is
+command is:
 .RS
 
 .br
@@ -92,7 +92,7 @@ the pathname
 refers to the root of the filesystem on
 .IR device .
 
-If only directory or device is given, for example:
+If only the directory or the device is given, for example:
 .RS
 
 .br
@@ -100,12 +100,13 @@ If only directory or device is given, for example:
 .br
 
 .RE
-then mount looks for a mountpoint and if not found then for a device in the
-/etc/fstab file. It's possible to use
+then \fBmount\fR looks for a mountpoint (and if not found then for a device) in the
+.IR /etc/fstab
+file.  It's possible to use the
 .B \-\-target
 or
 .B \-\-source
-options to avoid ambivalent interpretation of the given argument. For example
+options to avoid ambivalent interpretation of the given argument.  For example:
 .RS
 
 .br
@@ -115,64 +116,60 @@ options to avoid ambivalent interpretation of the given argument. For example
 .RE
 
 
-.B The listing and help.
+.B The listing.
 .RS
 The listing mode is maintained for backward compatibility only.
 
-For more robust and definable output use
+For more robust and customizable output use
 .BR findmnt (8),
-\fBespecially in your scripts\fP. Note that control characters in the
+\fBespecially in your scripts\fP.  Note that control characters in the
 mountpoint name are replaced with '?'.
 
-.TP
+The following command lists all mounted filesystems (of type
+.IR type ):
+
+.RS
+.br
 .BR "mount " [ \-l "] [" "\-t \fItype\/\fP" ]
-lists all mounted filesystems (of type
-.IR type ).
-The option \-l adds the labels in this listing.
-See below.
+.br
+.RE
+
+The option \fB\-l\fR adds labels to this listing.  See below.
 .RE
 
 .B The device indication.
 .RS
-Most devices are indicated by a file name (of a block special device), like
+Most devices are indicated by a filename (of a block special device), like
 .IR /dev/sda1 ,
-but there are other possibilities. For example, in the case of an NFS mount,
+but there are other possibilities.  For example, in the case of an NFS mount,
 .I device
 may look like
 .IR knuth.cwi.nl:/dir .
-It is possible to indicate a block special device using its
-filesystem
-.B LABEL
-or
-.B UUID
-(see the \-L and \-U options below) and
-partition
-.B PARTUUID
-or
-.B PARTLABEL
-(partition identifiers are supported for example for GUID Partition Table (GPT)
-partition tables).
+It is also possible to indicate a block special device using its filesystem label
+or UUID (see the \fB\-L\fR and \fB\-U\fR options below), or its partition label
+or UUID.  (Partition identifiers are supported for example for GUID Partition
+Tables (GPT).)
 
 Don't forget that there is no guarantee that UUIDs and labels are really
 unique, especially if you move, share or copy the device.  Use
 .B "lsblk \-o +UUID,PARTUUID"
 to verify that the UUIDs are really unique in your system.
 
-The recommended setup is to use tags (e.g. LABEL=<label>) rather than
+The recommended setup is to use tags (e.g. \fBLABEL=\fIlabel\fR) rather than
 .B /dev/disk/by-{label,uuid,partuuid,partlabel}
-udev symlinks in the /etc/fstab file. The tags are
-more readable, robust and portable. The
+udev symlinks in the /etc/fstab file.  Tags are
+more readable, robust and portable.  The
 .BR mount (8)
 command internally uses udev
-symlinks, so the use of symlinks in /etc/fstab has no advantage over the tags.
+symlinks, so the use of symlinks in /etc/fstab has no advantage over tags.
 For more details see
 .BR libblkid (3).
 
 Note that
 .BR mount (8)
-uses UUIDs as strings. The UUIDs from command line or
+uses UUIDs as strings.  The UUIDs from the command line or from
 .BR fstab (5)
-are not converted to internal binary representation. The string representation
+are not converted to internal binary representation.  The string representation
 of the UUID should be based on lower case characters.
 
 The
@@ -195,10 +192,11 @@ The file
 (see
 .BR fstab (5)),
 may contain lines describing what devices are usually
-mounted where, using which options. The default location of the
+mounted where, using which options.  The default location of the
 .BR fstab (5)
-file could be overridden by \-\-fstab <path> command line option (see below for
-more details).
+file can be overridden with the
+.BI \-\-fstab " path"
+command-line option (see below for more details).
 .LP
 The command
 .RS
@@ -215,7 +213,7 @@ The command
 (of the proper type and/or having or not having the proper options)
 to be mounted as indicated, except for those whose line contains the
 .B noauto
-keyword. Adding the
+keyword.  Adding the
 .B \-F
 option will make mount fork, so that the
 filesystems are mounted simultaneously.
@@ -224,7 +222,7 @@ When mounting a filesystem mentioned in
 .I fstab
 or
 .IR mtab ,
-it suffices to give only the device, or only the mount point.
+it suffices to specify on the command line only the device, or only the mount point.
 
 
 The programs
@@ -237,33 +235,35 @@ If no arguments are given to
 .BR mount ,
 this list is printed.
 
+If you want to override mount options from
+.I /etc/fstab
+you have to use the \fB\-o\fR option:
+.RS
+.sp
+.BI mount " device" \fR| "dir " \-o " options"
+.sp
+.RE
+and then the mount options from the command line will be appended to
+the list of options from
+.IR /etc/fstab .
+The usual behavior is that the last option wins if there are conflicting
+ones.
+
 The
 .B mount
 program does not read the
 .I /etc/fstab
-file if
+file if both
 .I device
 (or LABEL, UUID, PARTUUID or PARTLABEL) and
 .I dir
-are specified. For example:
+are specified.  For example, to mount device
+.BR foo " at " /dir :
 .RS
 .sp
 .B "mount /dev/foo /dir"
 .sp
 .RE
-If you want to override mount options from
-.I /etc/fstab
-you have to use:
-.RS
-.sp
-.B "mount device|dir \-o <options>"
-.sp
-.RE
-and then the mount options from command line will be appended to
-the list of options from
-.IR /etc/fstab .
-The usual behavior is that the last option wins if there is more duplicated
-options.
 
 When the
 .I proc
@@ -273,11 +273,11 @@ the files
 .I /etc/mtab
 and
 .I /proc/mounts
-have very similar contents. The former has somewhat
+have very similar contents.  The former has somewhat
 more information, such as the mount options used,
 but is not necessarily up-to-date (cf.\& the
 .B \-n
-option below). It is possible to replace
+option below).  It is possible to replace
 .I /etc/mtab
 by a symbolic link to
 .IR /proc/mounts ,
@@ -294,7 +294,7 @@ However, when
 .I fstab
 contains the
 .B user
-option on a line, anybody can mount the corresponding system.
+option on a line, anybody can mount the corresponding filesystem.
 .LP
 Thus, given a line
 .RS
@@ -302,7 +302,7 @@ Thus, given a line
 .B "/dev/cdrom  /cd  iso9660  ro,user,noauto,unhide"
 .sp
 .RE
-any user can mount the iso9660 filesystem found on his CDROM
+any user can mount the iso9660 filesystem found on an inserted CDROM
 using the command
 .RS
 .sp
@@ -318,7 +318,7 @@ or
 For more details, see
 .BR fstab (5).
 Only the user that mounted a filesystem can unmount it again.
-If any user should be able to unmount, then use
+If any user should be able to unmount it, then use
 .B users
 instead of
 .B user
@@ -330,7 +330,7 @@ The
 option is similar to the
 .B user
 option, with the restriction that the user must be the owner
-of the special file. This may be useful e.g.\& for
+of the special file.  This may be useful e.g.\& for
 .I /dev/fd
 if a login script makes the console user owner of this device.
 The
@@ -339,45 +339,40 @@ option is similar, with the restriction that the user must be
 member of the group of the special file.
 .RE
 
-
 .B The bind mounts.
 .RS
 .\" In fact since 2.3.99. At first the syntax was mount -t bind.
 Since Linux 2.4.0 it is possible to remount part of the
-file hierarchy somewhere else. The call is
+file hierarchy somewhere else.  The call is:
+
 .RS
 .br
 .B mount \-\-bind
 .I olddir newdir
 .RE
-or shortoption
-.RS
-.br
-.B mount \-B
-.I olddir newdir
-.RE
-or fstab entry is:
+
+or by using this fstab entry:
+
 .RS
 .br
-.I /olddir
-.I /newdir
+.BI / olddir
+.BI / newdir
 .B none bind
 .RE
 
-After this call the same contents is accessible in two places.
-One can also remount a single file (on a single file). It's also
+After this call the same contents are accessible in two places.
+One can also remount a single file (on a single file).  It's also
 possible to use the bind mount to create a mountpoint from a regular
 directory, for example:
 
 .RS
 .br
-.B mount \-\-bind
-.I foo foo
+.B mount \-\-bind foo foo
 .RE
 
 The bind mount call attaches only (part of) a single filesystem, not possible
-submounts. The entire file hierarchy including submounts is attached
-a second place using
+submounts.  The entire file hierarchy including submounts is attached
+a second place by using:
 
 .RS
 .br
@@ -385,18 +380,12 @@ a second place using
 .I olddir newdir
 .RE
 
-or shortoption
-
-.RS
-.br
-.B mount \-R
-.I olddir newdir
-.RE
-.\" available since Linux 2.4.11.
-
 Note that the filesystem mount options will remain the same as those
-on the original mount point, and cannot be changed by passing the \-o
-option along with \-\-bind/\-\-rbind. The mount options can be
+on the original mount point, and cannot be changed by passing the
+.B \-o
+option along with
+.BR \-\-bind / \-\-rbind .
+The mount options can be
 changed by a separate remount command, for example:
 
 .RS
@@ -408,12 +397,12 @@ changed by a separate remount command, for example:
 .I newdir
 .RE
 
-Note that behavior of the remount operation depends on the /etc/mtab file. The
-first command stores the 'bind' flag to the /etc/mtab file and the second
+Note that the behavior of the remount operation depends on the /etc/mtab file.
+The first command stores the 'bind' flag in the /etc/mtab file and the second
 command reads the flag from the file.  If you have a system without the
 /etc/mtab file or if you explicitly define source and target for the remount
-command (then mount(8) does not read /etc/mtab), then you have to use bind flag
-(or option) for the remount command too. For example:
+command (then \fBmount\fR(8) does not read /etc/mtab), then you have to use
+the bind flag (or option) for the remount command too.  For example:
 
 .RS
 .br
@@ -425,9 +414,9 @@ command (then mount(8) does not read /etc/mtab), then you have to use bind flag
 .RE
 
 Note that
-.I remount,ro,bind
-will create a read-only mountpoint (VFS entry), but the original filesystem suberblock
-will be still writable, it means that the
+.B remount,ro,bind
+will create a read-only mountpoint (VFS entry), but the original filesystem
+superblock will still be writable, meaning that the
 .I olddir
 will be writable, but the
 .I newdir
@@ -438,43 +427,43 @@ will be read-only.
 .RS
 Since Linux 2.5.1 it is possible to atomically move a
 .B mounted tree
-to another place. The call is
+to another place.  The call is:
+
 .RS
 .br
 .B mount \-\-move
 .I olddir newdir
 .RE
-or shortoption
-.RS
-.br
-.B mount \-M
-.I olddir newdir
-.RE
-This will cause the contents which previously appeared under olddir to be
-accessed under newdir.  The physical location of the files is not changed.
-Note that the
+
+This will cause the contents which previously appeared under
+.I olddir
+to now be accessible under
+.IR newdir .
+The physical location of the files is not changed.
+Note that
 .I olddir
 has to be a mountpoint.
 
-Note that moving a mount residing under a shared mount is invalid and
-unsupported. Use
+Note also that moving a mount residing under a shared mount is invalid and
+unsupported.  Use
 .B findmnt \-o TARGET,PROPAGATION /dir
 to see the current propagation flags.
 .RE
 
-.B The shared subtrees operations.
+.B The shared subtree operations.
 .RS
 Since Linux 2.6.15 it is possible to mark a mount and its submounts as shared,
-private, slave or unbindable. A shared mount provides ability to create mirrors
-of that mount such that mounts and umounts within any of the mirrors propagate
-to the other mirror. A slave mount receives propagation from its master, but
-any not vice-versa.  A private mount carries no propagation abilities.  An
+private, slave or unbindable.  A shared mount provides the ability to create mirrors
+of that mount such that mounts and unmounts within any of the mirrors propagate
+to the other mirror.  A slave mount receives propagation from its master, but
+not vice versa.  A private mount carries no propagation abilities.  An
 unbindable mount is a private mount which cannot be cloned through a bind
-operation. Detailed semantics is documented in
+operation.  The detailed semantics are documented in
 .B Documentation/filesystems/sharedsubtree.txt
 file in the kernel source tree.
 
-Supported operations:
+Supported operations are:
+
 .RS
 .nf
 .BI "mount \-\-make-shared " mountpoint
@@ -484,7 +473,7 @@ Supported operations:
 .fi
 .RE
 
-The following commands allows one to recursively change the type of all the
+The following commands allow one to recursively change the type of all the
 mounts under a given mountpoint.
 
 .RS
@@ -499,47 +488,50 @@ mounts under a given mountpoint.
 .BR mount (8)
 .B does not read
 .BR fstab (5)
-when \-\-make-* operation is requested. All necessary information has to be
-specified on command line.
+when a \fB\-\-make-\fR* operation is requested.  All necessary information has to be
+specified on the command line.
 
-Note that Linux kernel does not allow to change more propagation flags by one
+Note that the Linux kernel does not allow to change multiple propagation flags
+with a single
 .BR mount (2)
-syscall and the flags cannot be mixed with another mount options.
+syscall, and the flags cannot be mixed with other mount options.
 
-Since util-linux 2.23 mount command allows to use more propagation flags
-together and with another mount operations. This feature is EXPERIMENTAL.
-The propagation flags are applied by additional mount(2) syscalls
-after previous successful mount operation. Note that this use case is not
-atomic. The propagation flags is possible to specify in
+Since util-linux 2.23 the \fBmount\fR command allows to use several propagation flags
+together and also together with other mount operations.  This feature is EXPERIMENTAL.
+The propagation flags are applied by additional \fBmount\fR(2) syscalls when the
+preceeding mount operations were successful.  Note that this use case is not
+atomic.  It is possible to specify the propagation flags in
 .BR fstab (5)
 as mount options
-.RI ( private ,
-.IR slave ,
-.IR shared ,
-.IR unbindable ,
-.IR rprivate ,
-.IR rslave ,
-.IR rshared ,
-.IR runbindable ).
-
-For example
+.RB ( private ,
+.BR slave ,
+.BR shared ,
+.BR unbindable ,
+.BR rprivate ,
+.BR rslave ,
+.BR rshared ,
+.BR runbindable ).
+
+For example:
+
 .RS
 .nf
-.BI "mount \-\-make-private \-\-make-unbindable /dev/sda1 /A"
+.BI "mount \-\-make-private \-\-make-unbindable /dev/sda1 /foo"
 .fi
 .RE
 
-is the same as
+is the same as:
+
 .RS
 .nf
-.BI "mount /dev/sda1 /A"
-.BI "mount \-\-make-private /A"
-.BI "mount \-\-make-unbindable /A"
+.BI "mount /dev/sda1 /foo"
+.BI "mount \-\-make-private /foo"
+.BI "mount \-\-make-unbindable /foo"
 .fi
 .RE
 .RE
 
-.SH COMMAND LINE OPTIONS
+.SH COMMAND-LINE OPTIONS
 The full set of mount options used by an invocation of
 .B mount
 is determined by first extracting the
@@ -551,13 +543,13 @@ argument, and finally applying a
 .BR \-r " or " \-w
 option, when present.
 
-The command mount does not pass all command line options to the
-/sbin/mount.<suffix> mount helpers. The interface between the mount and the
-mount helpers is described below in the section EXTERNAL HELPERS.
+The command \fBmount\fR does not pass all command-line options to the
+\fB/sbin/mount.\fIsuffix\fR mount helpers.  The interface between \fBmount\fR
+and the mount helpers is described below in the section EXTERNAL HELPERS.
 
-Command line options available for the
+Command-line options available for the
 .B mount
-command:
+command are:
 .IP "\fB\-V, \-\-version\fP"
 Display version information and exit.
 .IP "\fB\-h, \-\-help\fP"
@@ -569,15 +561,16 @@ Mount all filesystems (of the given types) mentioned in
 .I fstab
 (except for those whose line contains the
 .B noauto
-keyword). The filesystems are mounted following their order in fstab.
+keyword).  The filesystems are mounted following their order in
+.IR fstab .
 .IP "\fB\-F, \-\-fork\fP"
 (Used in conjunction with
 .BR \-a .)
-Fork off a new incarnation of mount for each device.
+Fork off a new incarnation of \fBmount\fR for each device.
 This will do the mounts on different devices or different NFS servers
 in parallel.
 This has the advantage that it is faster; also NFS timeouts go in
-parallel. A disadvantage is that the mounts are done in undefined order.
+parallel.  A disadvantage is that the mounts are done in undefined order.
 Thus, you cannot use this option if you want to mount both
 .I /usr
 and
@@ -589,14 +582,14 @@ conjunction with the
 .B \-v
 flag to determine what the
 .B mount
-command is trying to do. It can also be used to add entries for devices
-that were mounted earlier with the \-n option. The \-f option checks for
-existing record in /etc/mtab and fails when the record already
-exists (with regular non-fake mount, this check is done by kernel).
+command is trying to do.  It can also be used to add entries for devices
+that were mounted earlier with the \fB\-n\fR option.  The \fB\-f\fR option
+checks for an existing record in /etc/mtab and fails when the record already
+exists (with a regular non-fake mount, this check is done by the kernel).
 .IP "\fB\-i, \-\-internal-only\fP"
-Don't call the /sbin/mount.<filesystem> helper even if it exists.
+Don't call the \fB/sbin/mount.\fIfilesystem\fR helper even if it exists.
 .IP "\fB\-l, \-\-show-labels\fP"
-Add the labels in the mount output. Mount must have
+Add the labels in the mount output.  \fBmount\fR must have
 permission to read the disk device (e.g.\& be suid root) for this to work.
 One can set such a label for ext2, ext3 or ext4 using the
 .BR e2label (8)
@@ -611,35 +604,41 @@ This is necessary for example when
 .I /etc
 is on a read-only filesystem.
 .IP "\fB\-c, \-\-no-canonicalize\fP"
-Don't canonicalize paths. The mount command canonicalizes all paths
-(from command line or fstab) by default. This option can be used
+Don't canonicalize paths.  The mount command canonicalizes all paths
+(from command line or fstab) by default.  This option can be used
 together with the
 .B \-f
-flag for already canonicalized absolute paths. The option is designed for mount
-helpers which call mount -i. It's strongly recommended do not use this command
-line option for standard mount operations.
+flag for already canonicalized absolute paths.  The option is designed for mount
+helpers which call \fBmount -i\fR.  It is strongly recommended to not use this
+command-line option for normal mount operations.
 
-Note that mount(8) does not pass this option to /sbin/mount.<type> helpers.
+Note that \fBmount\fR(8) does not pass this option to the
+\fB/sbin/mount.\fItype\fR helpers.
 .IP "\fB\-s\fP"
-Tolerate sloppy mount options rather than failing. This will ignore mount
-options not supported by a filesystem type. Not all filesystems support this
-option. Currently it's supported by the mount.nfs mount helper only.
-.IP "\fB\-\-source \fIsrc\fP"
+Tolerate sloppy mount options rather than failing.  This will ignore mount
+options not supported by a filesystem type.  Not all filesystems support this
+option.  Currently it's supported by the \fBmount.nfs\fR mount helper only.
+.IP "\fB\-\-source \fIdev\fP"
+If only one argument for the mount command is given then the argument might be
+interpreted as target (mountpoint) or source (device).  This option allows to
+explicitly define that the argument is the mount source.
+.IP "\fB\-\-target \fIdir\fP"
 If only one argument for the mount command is given then the argument might be
-interpreted as target (mountpoint) or source (device). This option allows to
-explicitly define that the argument is mount source.
+interpreted as target (mountpoint) or source (device).  This option allows to
+explicitly define that the argument is the mount target.
 .IP "\fB\-r, \-\-read-only\fP"
-Mount the filesystem read-only. A synonym is
+Mount the filesystem read-only.  A synonym is
 .BR "\-o ro" .
 
 Note that, depending on the filesystem type, state and kernel behavior, the
-system may still write to the device. For example, ext3 or ext4 will replay its
-journal if the filesystem is dirty. To prevent this kind of write access, you
-may want to mount ext3 or ext4 filesystem with "ro,noload" mount options or
-set the block device to read-only mode, see command
-.BR blockdev (8).
+system may still write to the device.  For example, ext3 and ext4 will replay the
+journal if the filesystem is dirty.  To prevent this kind of write access, you
+may want to mount an ext3 or ext4 filesystem with the \fBro,noload\fR mount
+options or set the block device itself to read-only mode, see the
+.BR blockdev (8)
+command.
 .IP "\fB\-w, \-\-rw, \-\-read-write\fP"
-Mount the filesystem read/write. This is the default. A synonym is
+Mount the filesystem read/write.  This is the default.  A synonym is
 .BR "\-o rw" .
 .IP "\fB\-L, \-\-label \fIlabel\fP"
 Mount the partition that has the specified
@@ -651,18 +650,18 @@ These two options require the file
 .I /proc/partitions
 (present since Linux 2.1.116) to exist.
 .IP "\fB\-T, \-\-fstab \fIpath\fP"
-Specifies alternative fstab file. If the \fIpath\fP is directory then the files
+Specifies an alternative fstab file.  If \fIpath\fP is a directory then the files
 in the directory are sorted by
-.BR strverscmp (3),
-files that starts with "."\& or without \&.fstab extension are ignored. The option
-can be specified more than once. This option is mostly designed for initramfs
-or chroot scripts where additional configuration is specified outside standard
+.BR strverscmp (3);
+files that start with "."\& or without an \&.fstab extension are ignored.  The option
+can be specified more than once.  This option is mostly designed for initramfs
+or chroot scripts where additional configuration is specified beyond standard
 system configuration.
 
-Note that mount(8) does not pass the option \fB\-\-fstab\fP to
-/sbin/mount.<type> helpers, it means that the alternative fstab files will be
-invisible for the helpers. This is no problem for normal mounts, but user
-(non-root) mounts always require fstab to verify user's rights.
+Note that \fBmount\fR(8) does not pass the option \fB\-\-fstab\fP to the
+\fB/sbin/mount.\fItype\fR helpers, meaning that the alternative fstab files will be
+invisible for the helpers.  This is no problem for normal mounts, but user
+(non-root) mounts always require fstab to verify the user's rights.
 .IP "\fB\-t, \-\-types \fIvfstype\fP"
 The argument following the
 .B \-t
@@ -718,11 +717,11 @@ and
 .I coherent
 will be removed at some point in the future \(en use
 .I sysv
-instead. Since kernel version 2.1.21 the types
+instead.  Since kernel version 2.1.21 the types
 .I ext
 and
 .I xiafs
-do not exist anymore. Earlier,
+do not exist anymore.  Earlier,
 .I usbfs
 was known as
 .IR usbdevfs .
@@ -733,8 +732,8 @@ The programs
 .B mount
 and
 .B umount
-support filesystem subtypes.  The subtype is defined by '.subtype' suffix.  For
-example  'fuse.sshfs'. It's recommended to use subtype notation rather than add
+support filesystem subtypes.  The subtype is defined by a '.subtype' suffix.  For
+example  'fuse.sshfs'.  It's recommended to use subtype notation rather than add
 any prefix to the mount source (for example 'sshfs#example.com' is
 deprecated).
 
@@ -743,14 +742,14 @@ For most types all the
 program has to do is issue a simple
 .IR mount (2)
 system call, and no detailed knowledge of the filesystem type is required.
-For a few types however (like nfs, nfs4, cifs, smbfs, ncpfs) ad hoc code is
-necessary. The nfs, nfs4, cifs, smbfs, and ncpfs filesystems
-have a separate mount program. In order to make it possible to
-treat all types in a uniform way, mount will execute the program
-.BI /sbin/mount. TYPE
+For a few types however (like nfs, nfs4, cifs, smbfs, ncpfs) an ad hoc code is
+necessary.  The nfs, nfs4, cifs, smbfs, and ncpfs filesystems
+have a separate mount program.  In order to make it possible to
+treat all types in a uniform way, \fBmount\fR will execute the program
+.BI /sbin/mount. type
 (if that exists) when called with type
-.IR TYPE .
-Since various versions of the
+.IR type .
+Since different versions of the
 .B smbmount
 program have different calling conventions,
 .B /sbin/mount.smbfs
@@ -775,10 +774,10 @@ and
 .IR nfs ).
 If
 .I /etc/filesystems
-ends in a line with a single * only, mount will read
+ends in a line with a single *, mount will read
 .I /proc/filesystems
-afterwards. All of the filesystem types will be
-mounted with mount option "silent".
+afterwards.  While trying, all filesystem types will be
+mounted with the mount option \fBsilent\fR.
 
 The
 .B auto
@@ -788,13 +787,13 @@ Creating a file
 can be useful to change the probe order (e.g., to try vfat before msdos
 or ext3 before ext2) or if you use a kernel module autoloader.
 
-More than one type may be specified in a comma separated
+More than one type may be specified in a comma-separated
 list.  The list of filesystem types can be prefixed with
 .B no
 to specify the filesystem types on which no action should be taken.
 (This can be meaningful with the
 .B \-a
-option.) For example, the command:
+option.)  For example, the command
 .RS
 .RS
 .sp
@@ -806,18 +805,14 @@ mounts all filesystems except those of type
 and
 .IR ext .
 .RE
-.IP "\fB\-\-target \fIdir\fP"
-If only one argument for the mount command is given then the argument might be
-interpreted as target (mountpoint) or source (device). This option allows to
-explicitly define that the argument is mount target.
 .IP "\fB\-O, \-\-test-opts \fIopts\fP"
-Used in conjunction with
-.BR \-a ,
-to limit the set of filesystems to which the
+Limit the set of filesystems to which the
 .B \-a
-is applied.  Like
+option applies.  In this regard it is like the
 .B \-t
-in this regard except that it is useless except in the context of
+option except that
+.B \-O
+is useless without
 .BR \-a .
 For example, the command:
 .RS
@@ -852,9 +847,8 @@ mounts all ext2 filesystems with the _netdev option, not all filesystems
 that are either ext2 or have the _netdev option specified.
 .RE
 .IP "\fB\-o, \-\-options \fIopts\fP"
-Options are specified with a
-.B \-o
-flag followed by a comma separated string of options. For example:
+Use the specified mount options.  The \fIopts\fR argument is
+a comma-separated list.  For example:
 .RS
 .RS
 .sp
@@ -862,46 +856,46 @@ flag followed by a comma separated string of options. For example:
 .sp
 .RE
 
-For more details, see
-.B FILESYSTEM INDEPENDENT MOUNT OPTIONS
+For more details, see the
+.B FILESYSTEM-INDEPENDENT MOUNT OPTIONS
 and
-.B FILESYSTEM SPECIFIC MOUNT OPTIONS
+.B FILESYSTEM-SPECIFIC MOUNT OPTIONS
 sections.
 .RE
 .IP "\fB\-B, \-\-bind\fP"
 Remount a subtree somewhere else (so that its contents are available
-in both places). See above.
+in both places).  See above.
 .IP "\fB\-R, \-\-rbind\fP"
 Remount a subtree and all possible submounts somewhere else (so that its
-contents are available in both places). See above.
+contents are available in both places).  See above.
 .IP "\fB\-M, \-\-move\fP"
-Move a subtree to some other place. See above.
+Move a subtree to some other place.  See above.
 
-.SH FILESYSTEM INDEPENDENT MOUNT OPTIONS
+.SH FILESYSTEM-INDEPENDENT MOUNT OPTIONS
 Some of these options are only useful when they appear in the
 .I /etc/fstab
 file.
 
 Some of these options could be enabled or disabled by default
-in the system kernel. To check the current setting see the options
-in /proc/mounts. Note that filesystems also have per-filesystem
+in the system kernel.  To check the current setting see the options
+in /proc/mounts.  Note that filesystems also have per-filesystem
 specific default mount options (see for example \fBtune2fs \-l\fP
 output for extN filesystems).
 
 The following options apply to any filesystem that is being
 mounted (but not every filesystem actually honors them \(en e.g.\&, the
 .B sync
-option today has effect only for ext2, ext3, fat, vfat and ufs):
+option today has an effect only for ext2, ext3, fat, vfat and ufs):
 
 .TP
 .B async
-All I/O to the filesystem should be done asynchronously. (See also the
+All I/O to the filesystem should be done asynchronously.  (See also the
 .B sync
 option.)
 .TP
 .B atime
-Do not use noatime feature, then the inode access time is controlled by kernel
-defaults. See also the description for
+Do not use the noatime feature, so the inode access time is controlled by kernel
+defaults.  See also the descriptions of the
 .B strictatime
 and
 .B relatime
@@ -927,10 +921,10 @@ The
 option is useful when mounting filesystems that do not support
 extended attributes, such as a floppy or hard disk formatted with VFAT, or
 systems that are not normally running under SELinux, such as an ext3 formatted
-disk from a non-SELinux workstation. You can also use
+disk from a non-SELinux workstation.  You can also use
 .B context=
-on filesystems you do not trust, such as a floppy. It also helps in compatibility with
-xattr-supporting filesystems on earlier 2.4.<x> kernel versions. Even where
+on filesystems you do not trust, such as a floppy.  It also helps in compatibility with
+xattr-supporting filesystems on earlier 2.4.<x> kernel versions.  Even where
 xattrs are supported, you can save time not having to label every file by
 assigning the entire disk one security context.
 
@@ -941,25 +935,25 @@ Two other options are
 .B fscontext=
 and
 .BR defcontext= ,
-both of which are mutually exclusive of the context option. This means you
+both of which are mutually exclusive of the context option.  This means you
 can use fscontext and defcontext with each other, but neither can be used with
 context.
 
 The
 .B fscontext=
 option works for all filesystems, regardless of their xattr
-support. The fscontext option sets the overarching filesystem label to a
-specific security context. This filesystem label is separate from the
-individual labels on the files. It represents the entire filesystem for
+support.  The fscontext option sets the overarching filesystem label to a
+specific security context.  This filesystem label is separate from the
+individual labels on the files.  It represents the entire filesystem for
 certain kinds of permission checks, such as during mount or file creation.
 Individual file labels are still obtained from the xattrs on the files
-themselves. The context option actually sets the aggregate context that
+themselves.  The context option actually sets the aggregate context that
 fscontext provides, in addition to supplying the same label for individual
 files.
 
 You can set the default security context for unlabeled files using
 .B defcontext=
-option. This overrides the value set for unlabeled files in the policy and requires a
+option.  This overrides the value set for unlabeled files in the policy and requires a
 filesystem that supports xattr labeling.
 
 The
@@ -993,11 +987,11 @@ For more details, see
 
 .TP
 .B defaults
-Use default options:
-.BR rw ", " suid ", " dev ", " exec ", " auto ", " nouser ", and " async.
+Use the default options:
+.BR rw ", " suid ", " dev ", " exec ", " auto ", " nouser ", and " async .
 
-Note that the real set of the all default mount options depends on kernel
-and filesystem type. See the begin of this section for more details.
+Note that the real set of all default mount options depends on kernel
+and filesystem type.  See the beginning of this section for more details.
 .TP
 .B dev
 Interpret character or block special devices on the filesystem.
@@ -1007,7 +1001,7 @@ Do not interpret character or block special devices on the file
 system.
 .TP
 .B diratime
-Update directory inode access times on this filesystem. This is the default.
+Update directory inode access times on this filesystem.  This is the default.
 .TP
 .B nodiratime
 Do not update directory inode access times on this filesystem.
@@ -1021,9 +1015,9 @@ mkdir, rmdir, mknod and rename.
 Permit execution of binaries.
 .TP
 .B noexec
-Do not allow direct execution of any binaries on the mounted filesystem.
+Do not permit direct execution of any binaries on the mounted filesystem.
 (Until recently it was possible to run binaries anyway using a command like
-/lib/ld*.so /mnt/binary. This trick fails since Linux 2.4.25 / 2.6.0.)
+/lib/ld*.so /mnt/binary.  This trick fails since Linux 2.4.25 / 2.6.0.)
 .TP
 .B group
 Allow an ordinary (i.e., non-root) user to mount the filesystem if one
@@ -1040,7 +1034,7 @@ Every time the inode is modified, the i_version field will be incremented.
 Do not increment the i_version inode field.
 .TP
 .B mand
-Allow mandatory locks on this filesystem. See
+Allow mandatory locks on this filesystem.  See
 .BR fcntl (2).
 .TP
 .B nomand
@@ -1057,33 +1051,33 @@ Do not report errors for this device if it does not exist.
 .B relatime
 Update inode access times relative to modify or change time.  Access
 time is only updated if the previous access time was earlier than the
-current modify or change time. (Similar to noatime, but doesn't break
-mutt or other applications that need to know if a file has been read
-since the last time it was modified.)
+current modify or change time.  (Similar to \fBnoatime\fR, but it doesn't
+break \fBmutt\fR or other applications that need to know if a file has been
+read since the last time it was modified.)
 
 Since Linux 2.6.30, the kernel defaults to the behavior provided by this
 option (unless
 .B noatime
-was  specified), and the
+was specified), and the
 .B strictatime
-option is required to obtain traditional semantics. In addition, since Linux
-2.6.30, the file's last access time is always  updated  if  it  is more than 1
+option is required to obtain traditional semantics.  In addition, since Linux
+2.6.30, the file's last access time is always updated if it is more than 1
 day old.
 .TP
 .B norelatime
-Do not use
+Do not use the
 .B relatime
-feature. See also the
+feature.  See also the
 .B strictatime
 mount option.
 .TP
 .B strictatime
-Allows to explicitly requesting full atime updates. This makes it
-possible for kernel to defaults to
+Allows to explicitly request full atime updates.  This makes it
+possible for the kernel to default to
 .B relatime
 or
 .B noatime
-but still allow userspace to override it. For more details about the default
+but still allow userspace to override it.  For more details about the default
 system mount options see /proc/mounts.
 .TP
 .B nostrictatime
@@ -1114,15 +1108,15 @@ This option implies the options
 .B remount
 Attempt to remount an already-mounted filesystem.  This is commonly
 used to change the mount flags for a filesystem, especially to make a
-readonly filesystem writable. It does not change device or mount point.
+readonly filesystem writable.  It does not change device or mount point.
 
-The remount functionality follows the standard way how the mount command works
-with options from fstab. It means the mount command doesn't read fstab (or
-mtab) only when a
+The remount functionality follows the standard way the mount command works
+with options from fstab.  This means that the mount command only doesn't
+read fstab (or mtab) when both the
 .I device
 and
 .I dir
-are fully specified.
+are specified.
 
 .B "mount \-o remount,rw /dev/foo /dir"
 
@@ -1133,7 +1127,7 @@ maintained by the mount command.
 .B "mount \-o remount,rw  /dir"
 
 After this call mount reads fstab (or mtab) and merges these options with
-options from command line (\c
+the options from the command line (\c
 .B \-o\c
 ).
 .TP
@@ -1144,8 +1138,9 @@ Mount the filesystem read-only.
 Mount the filesystem read-write.
 .TP
 .B sync
-All I/O to the filesystem should be done synchronously. In case of media with limited number of write cycles
-(e.g.\& some flash drives) "sync" may cause life-cycle shortening.
+All I/O to the filesystem should be done synchronously.  In the case of
+media with a limited number of write cycles
+(e.g.\& some flash drives), \fBsync\fR may cause life-cycle shortening.
 .TP
 .B user
 Allow an ordinary user to mount the filesystem.
@@ -1169,21 +1164,22 @@ This option implies the options
 .TP
 .B x-*
 All options prefixed with "x-" are interpreted as comments or userspace
-applications specific options. These options are not stored to mtab file, send
-to mount.<type> helpers or
+application-specific options.  These options are not stored in the mtab file,
+nor sent to the mount.<type> helpers nor the
 .BR mount (2)
-system call. The suggested format is x-<appname>.<option> (e.g.\& x-systemd.automount).
+system call.  The suggested format is x-<appname>.<option> (e.g.\& x-systemd.automount).
 .TP
-.B x-mount.mkdir[=<mode>]
-Allow to make a target directory (mountpoint). The optional argument <mode>
-specifies the file system access mode used for
+.BR x-mount.mkdir [ = \fImode\fR ]
+Allow to make a target directory (mountpoint).  The optional argument
+.I mode
+specifies the filesystem access mode used for
 .BR mkdir (2)
-in octal notation. The default mode is 0755. This functionality is supported
+in octal notation.  The default mode is 0755.  This functionality is supported
 only for root users.
 
-.SH "FILESYSTEM SPECIFIC MOUNT OPTIONS"
+.SH "FILESYSTEM-SPECIFIC MOUNT OPTIONS"
 The following options apply only to certain filesystems.
-We sort them by filesystem. They all follow the
+We sort them by filesystem.  They all follow the
 .B \-o
 flag.
 
@@ -1227,7 +1223,7 @@ Do not allow any changes to the protection bits on the filesystem.
 .B usemp
 Set uid and gid of the root of the filesystem to the uid and gid
 of the mount point upon the first sync or umount, and then
-clear this option. Strange...
+clear this option.  Strange...
 .TP
 .B verbose
 Print an informational message for each successful mount.
@@ -1245,16 +1241,16 @@ Prefix (of length at most 30) used before '/' when following a symbolic link.
 Give explicitly the location of the root block.
 .TP
 .BI bs= value
-Give blocksize. Allowed values are 512, 1024, 2048, 4096.
+Give blocksize.  Allowed values are 512, 1024, 2048, 4096.
 .TP
 .BR grpquota | noquota | quota | usrquota
 These options are accepted but ignored.
 (However, quota utilities may react to such strings in
 .IR /etc/fstab .)
 .SH "Mount options for btrfs"
-Btrfs is a copy on write filesystem for Linux aimed at
+Btrfs is a copy-on-write filesystem for Linux aimed at
 implementing advanced features while focusing on fault tolerance,
-repair and easy administration.
+repair, and easy administration.
 .TP
 .BI alloc_start= bytes
 Debugging option to force all block allocations above a certain
@@ -1264,18 +1260,18 @@ Default is 1MB.
 .TP
 .B autodefrag
 Disable/enable auto defragmentation.
-Auto defragmentation detects small random writes into files and queue
+Auto defragmentation detects small random writes into files and queues
 them up for the defrag process.  Works best for small files;
-Not well suited for large database workloads.
+not well-suited for large database workloads.
 .TP
-\fBcheck_int\fP|\fBcheck_int_data\fP|\fBcheck_int_print_mask=\fP\,\fIvalue\fP
+.BR check_int | check_int_data | check_int_print_mask =\fIvalue\fR
 These debugging options control the behavior of the integrity checking
 module(the BTRFS_FS_CHECK_INTEGRITY config option required).
 
 .B check_int
 enables the integrity checker module, which examines all
-block write requests to ensure on-disk consistency, at a large
-memory and CPU cost.  
+block-write requests to ensure on-disk consistency, at a large
+memory and CPU cost.
 
 .B check_int_data
 includes extent data in the integrity checks, and
@@ -1291,17 +1287,17 @@ See comments at the top of
 for more info.
 .TP
 .BI commit= seconds
-Set the interval of periodic commit, 30 seconds by default. Higher
-values defer data being synced to permanent storage with obvious
-consequences when the system crashes. The upper bound is not forced,
+Set the interval of periodic commit, 30 seconds by default.  Higher
+values defer data being synced to permanent storage, with obvious
+consequences when the system crashes.  The upper bound is not forced,
 but a warning is printed if it's more than 300 seconds (5 minutes).
 .TP
-\fBcompress\fP|\fBcompress=\fP\,\fItype\fP|\fBcompress-force\fP|\fBcompress-force=\fP\,\fItype\fP
+.BR compress | compress= \fItype\fR| compress-force | compress-force= \fItype\fR
 Control BTRFS file data compression.  Type may be specified as "zlib"
 "lzo" or "no" (for no compression, used for remounting).  If no type
-is specified, zlib is used.  If compress-force is specified,
+is specified, zlib is used.  If \fBcompress-force\fR is specified,
 all files will be compressed, whether or not they compress well.
-If compression is enabled, nodatacow and nodatasum are disabled.
+If compression is enabled, \fBnodatacow\fR and \fBnodatasum\fR are disabled.
 .TP
 .B degraded
 Allow mounts to continue with missing devices.  A read-write mount may
@@ -1314,13 +1310,13 @@ can be avoided.  Especially useful when trying to mount a multi-device
 setup as root.  May be specified multiple times for multiple devices.
 .TP
 .B discard
-Disable/enable discard mount option.
-Discard issues frequent commands to let the block device reclaim space
-freed by the filesystem.
+Disable/enable the discard mount option.
+The discard function issues frequent commands to let the block device
+reclaim space freed by the filesystem.
 This is useful for SSD devices, thinly provisioned
 LUNs and virtual machine images, but may have a significant
-performance impact.  (The fstrim command is also available to
-initiate batch trims from userspace).
+performance impact.  (The \fBfstrim\fR command is also available to
+initiate batch trims from userspace.)
 .TP
 .B enospc_debug
 Disable/enable debugging option to be more verbose in some ENOSPC conditions.
@@ -1335,61 +1331,61 @@ The
 .B flushoncommit
 mount option forces any data dirtied by a write in a
 prior transaction to commit as part of the current commit.  This makes
-the committed state a fully consistent view of the file system from the
-application's perspective (i.e., it includes all completed file system
+the committed state a fully consistent view of the filesystem from the
+application's perspective (i.e., it includes all completed filesystem
 operations).  This was previously the behavior only when a snapshot is
 created.
 .TP
 .B inode_cache
 Enable free inode number caching.   Defaults to off due to an overflow
-problem when the free space crcs don't fit inside a single page.
+problem when the free space CRCs don't fit inside a single page.
 .TP
 .BI max_inline= bytes
 Specify the maximum amount of space, in bytes, that can be inlined in
-a metadata B-tree leaf.  The value is specified in bytes, optionally 
+a metadata B-tree leaf.  The value is specified in bytes, optionally
 with a K, M, or G suffix, case insensitive.  In practice, this value
 is limited by the root sector size, with some space unavailable due
 to leaf headers.  For a 4k sectorsize, max inline data is ~3900 bytes.
 .TP
 .BI metadata_ratio= value
 Specify that 1 metadata chunk should be allocated after every
-.IR value
+.I value
 data chunks.  Off by default.
 .TP
 .B noacl
 Enable/disable support for Posix Access Control Lists (ACLs).  See the
-.B acl(5)
+.BR acl (5)
 manual page for more information about ACLs.
 .TP
 .B nobarrier
-Enable/disable the use of block layer write barriers.  Write barriers
+Enable/disable the use of block-layer write barriers.  Write barriers
 ensure that certain IOs make it through the device cache and are on
-persistent storage. If disabled on a device with a volatile
-(non-battery-backed) write-back cache, nobarrier option will lead to
-filesystem corruption on a system crash or power loss.
+persistent storage.  If disabled on a device with a volatile
+(non-battery-backed) write-back cache, the \fBnobarrier\fR option will
+lead to filesystem corruption on a system crash or power loss.
 .TP
 .B nodatacow
 Enable/disable data copy-on-write for newly created files.
-Nodatacow implies nodatasum, and disables all compression.
+This option implies \fBnodatasum\fR, and disables all compression.
 .TP
 .B nodatasum
 Enable/disable data checksumming for newly created files.
-Datasum implies datacow.
+This option implies \fBdatacow\fR.
 .TP
 .B notreelog
 Enable/disable the tree logging used for fsync and O_SYNC writes.
 .TP
 .B recovery
 Enable autorecovery attempts if a bad tree root is found at mount time.
-Currently this scans a list of several previous tree roots and tries to 
+Currently this scans a list of several previous tree roots and tries to
 use the first readable.
 .TP
 .B rescan_uuid_tree
-Force check and rebuild procedure of the UUID tree. This should not
+Force check and rebuild procedure of the UUID tree.  This should not
 normally be needed.
 .TP
 .B skip_balance
-Skip automatic resume of interrupted balance operation after mount.
+Skip automatic resume of an interrupted balance operation after mount.
 May be resumed with "btrfs balance resume."
 .TP
 .B nospace_cache
@@ -1402,17 +1398,17 @@ has gone wrong.
 .BR ssd | nossd | ssd_spread
 Options to control ssd allocation schemes.  By default, BTRFS will
 enable or disable ssd allocation heuristics depending on whether a
-rotational or nonrotational disk is in use.  The ssd and nossd options
-can override this autodetection.
+rotational or nonrotational disk is in use.  The \fBssd\fR and
+\fBnossd\fR options can override this autodetection.
 
-The ssd_spread mount option attempts to allocate into big chunks
-of unused space, and may perform better on low-end ssds.  ssd_spread
-implies ssd, enabling all other ssd heuristics as well.
+The \fBssd_spread\fR mount option attempts to allocate into big chunks
+of unused space, and may perform better on low-end ssds.  \fBssd_spread\fR
+implies \fBssd\fR, enabling all other ssd heuristics as well.
 .TP
 .BI subvol= path
 Mount subvolume at
 .IR path
-rather than the root subvolume. The
+rather than the root subvolume.  The
 .IR path
 is relative to the top level subvolume.
 .TP
@@ -1422,20 +1418,20 @@ This allows mounting of subvolumes which are not in the root of the mounted
 filesystem.
 You can use "btrfs subvolume list" to see subvolume ID numbers.
 .TP
-.BI subvolrootid= objectid (deprecated)
+.BI subvolrootid= objectid "  \fR(deprecated)"
 Mount subvolume specified by
 .IR objectid
 rather than the root subvolume.
 This allows mounting of subvolumes which are not in the root of the mounted
 filesystem.
 You can use "btrfs subvolume show " to see the object ID for a subvolume.
-.TP	
+.TP
 .BI thread_pool= number
 The number of worker threads to allocate.  The default number is equal
 to the number of CPUs + 2, or 8, whichever is smaller.
 .TP
 .B user_subvol_rm_allowed
-Allow subvolumes to be deleted by a non-root user. Use with caution. 
+Allow subvolumes to be deleted by a non-root user.  Use with caution.
 
 .SH "Mount options for cifs"
 See the options section of the
@@ -1468,7 +1464,7 @@ and the pseudo terminal slave can be accessed as
 .TP
 \fBuid=\fP\,\fIvalue\fP and \fBgid=\fP\,\fIvalue\fP
 This sets the owner or the group of newly created PTYs to
-the specified values. When nothing is specified, they will
+the specified values.  When nothing is specified, they will
 be set to the UID and GID of the creating process.
 For example, if there is a tty group with GID 5, then
 .B gid=5
@@ -1496,7 +1492,7 @@ Each mount of devpts with the
 option has a private set of pty indices.
 
 This option is mainly used to support containers in the
-linux kernel. It is implemented in linux kernel versions
+linux kernel.  It is implemented in linux kernel versions
 starting with 2.6.29.  Further, this mount option is valid
 only if CONFIG_DEVPTS_MULTIPLE_INSTANCES is enabled in the
 kernel configuration.
@@ -1534,13 +1530,13 @@ node and is highly recommended when the
 option is specified.
 
 This option is only implemented in linux kernel versions
-starting with 2.6.29. Further this option is valid only if
+starting with 2.6.29.  Further, this option is valid only if
 CONFIG_DEVPTS_MULTIPLE_INSTANCES is enabled in the kernel
 configuration.
 
 .SH "Mount options for ext"
 None.
-Note that the `ext' filesystem is obsolete. Don't use it.
+Note that the `ext' filesystem is obsolete.  Don't use it.
 Since Linux version 2.1.21 extfs is no longer part of the kernel source.
 
 .SH "Mount options for ext2"
@@ -1548,7 +1544,7 @@ The `ext2' filesystem is the standard Linux filesystem.
 .\" Due to a kernel bug, it may be mounted with random mount options
 .\" (fixed in Linux 2.0.4).
 Since Linux 2.5.46, for most mount options the default
-is determined by the filesystem superblock. Set them with
+is determined by the filesystem superblock.  Set them with
 .BR tune2fs (8).
 .TP
 .BR acl | noacl
@@ -1558,14 +1554,14 @@ Support POSIX Access Control Lists (or not).
 .BR bsddf | minixdf
 Set the behavior for the
 .I statfs
-system call. The
+system call.  The
 .B minixdf
 behavior is to return in the
 .I f_blocks
 field the total number of blocks of the filesystem, while the
 .B bsddf
 behavior (which is the default) is to subtract the overhead blocks
-used by the ext2 filesystem and not available for file storage. Thus
+used by the ext2 filesystem and not available for file storage.  Thus
 .sp 1
 % mount /k \-o minixdf; df /k; umount /k
 .TS
@@ -1585,17 +1581,17 @@ Filesystem#1024-blocks#Used#Available#Capacity#Mounted on
 /dev/sda6#2543714#13#2412169#0%#/k
 .TE
 .sp 1
-(Note that this example shows that one can add command line options
+(Note that this example shows that one can add command-line options
 to the options given in
 .IR /etc/fstab .)
 
 .TP
 .BR check=none " or " nocheck
-No checking is done at mount time. This is the default. This is fast.
+No checking is done at mount time.  This is the default.  This is fast.
 It is wise to invoke
 .BR e2fsck (8)
-every now and then, e.g.\& at boot time. The non-default behavior is unsupported
-(check=normal and check=strict options have been removed). Note that these mount options
+every now and then, e.g.\& at boot time.  The non-default behavior is unsupported
+(check=normal and check=strict options have been removed).  Note that these mount options
 don't have to be supported if ext4 kernel driver is used for ext2 and ext3 filesystems.
 .TP
 .B debug
@@ -1621,7 +1617,7 @@ if it is a directory itself.
 .TP
 .BR grpquota | noquota | quota | usrquota
 The usrquota (same as quota) mount option enables user quota support on the
-filesystem. grpquota enables group quotas support. You need the quota utilities
+filesystem.  grpquota enables group quotas support.  You need the quota utilities
 to actually enable and manage the quota system.
 .TP
 .B nouid32
@@ -1629,7 +1625,7 @@ Disables 32-bit UIDs and GIDs.  This is for interoperability with older
 kernels which only store and expect 16-bit values.
 .TP
 .BR oldalloc " or " orlov
-Use old allocator or Orlov allocator for new inodes. Orlov is default.
+Use old allocator or Orlov allocator for new inodes.  Orlov is default.
 .TP
 \fBresgid=\fP\,\fIn\fP and \fBresuid=\fP\,\fIn\fP
 The ext2 filesystem reserves a certain percentage of the available
@@ -1643,17 +1639,17 @@ These options determine who can use the reserved blocks.
 .BI sb= n
 Instead of block 1, use block
 .I n
-as superblock. This could be useful when the filesystem has been damaged.
+as superblock.  This could be useful when the filesystem has been damaged.
 (Earlier, copies of the superblock would be made every 8192 blocks: in
 block 1, 8193, 16385, \&...\& (and one got thousands of copies on
-a big filesystem). Since version 1.08,
+a big filesystem).  Since version 1.08,
 .B mke2fs
 has a \-s (sparse superblock) option to reduce the number of backup
-superblocks, and since version 1.15 this is the default. Note
+superblocks, and since version 1.15 this is the default.  Note
 that this may mean that ext2 filesystems created by a recent
 .B mke2fs
 cannot be mounted r/w under Linux 2.0.*.)
-The block number here uses 1\ k units. Thus, if you want to use logical
+The block number here uses 1\ k units.  Thus, if you want to use logical
 block 32768 on a filesystem with 4\ k blocks, use "sb=131072".
 .TP
 .BR user_xattr | nouser_xattr
@@ -1673,7 +1669,7 @@ well as the following additions:
 Update the ext3 filesystem's journal to the current format.
 .TP
 .B journal=inum
-When a journal already exists, this option is ignored. Otherwise, it
+When a journal already exists, this option is ignored.  Otherwise, it
 specifies the number of the inode which will represent the ext3 filesystem's
 journal file; ext3 will create a new journal, overwriting the old contents
 of the file whose inode number is
@@ -1726,7 +1722,7 @@ Abort the journal if an error occurs in a file data buffer in ordered mode.
 .TP
 .BR barrier=0 " / " barrier=1 "
 This disables / enables the use of write barriers in the jbd code.  barrier=0
-disables, barrier=1 enables (default). This also requires an IO stack which can
+disables, barrier=1 enables (default).  This also requires an IO stack which can
 support barriers, and if jbd gets an error on a barrier write, it will disable
 barriers again with a warning.  Write barriers enforce proper on-disk ordering
 of journal commits, making volatile disk write caches safe to use, at some
@@ -1736,24 +1732,24 @@ disabling barriers may safely improve performance.
 .BI commit= nrsec
 Sync all data and metadata every
 .I nrsec
-seconds. The default value is 5 seconds. Zero means default.
+seconds.  The default value is 5 seconds.  Zero means default.
 .TP
 .B user_xattr
-Enable Extended User Attributes. See the
+Enable Extended User Attributes.  See the
 .BR attr (5)
 manual page.
 .TP
 .B acl
-Enable POSIX Access Control Lists. See the
+Enable POSIX Access Control Lists.  See the
 .BR acl (5)
 manual page.
 .TP
 .BR usrjquota=aquota.user | grpjquota=aquota.group | jqfmt=vfsv0
 Apart from the old quota system (as in ext2, jqfmt=vfsold aka version 1 quota)
-ext3 also supports journaled quotas (version 2 quota). jqfmt=vfsv0
-enables journaled quotas. For journaled quotas the mount options
+ext3 also supports journaled quotas (version 2 quota).  jqfmt=vfsv0
+enables journaled quotas.  For journaled quotas the mount options
 usrjquota=aquota.user and grpjquota=aquota.group are required to tell the
-quota system which quota database files to use. Journaled quotas have the
+quota system which quota database files to use.  Journaled quotas have the
 advantage that even after a crash no quota check is required.
 
 .SH "Mount options for ext4"
@@ -1774,8 +1770,8 @@ code in e2fsck and the kernel to detect corruption in the kernel.  It is a
 compatible change and will be ignored by older kernels.
 .TP
 .B journal_async_commit
-Commit block can be written to disk without waiting for descriptor blocks. If
-enabled older kernels cannot mount the device.
+Commit block can be written to disk without waiting for descriptor blocks.
+If enabled, older kernels cannot mount the device.
 This will enable 'journal_checksum' internally.
 .TP
 .BR barrier=0 " / " barrier=1 " / " barrier " / " nobarrier
@@ -1788,38 +1784,38 @@ The ext4 filesystem enables write barriers by default.
 .BI inode_readahead_blks= n
 This tuning parameter controls the maximum number of inode table blocks that
 ext4's inode table readahead algorithm will pre-read into the buffer cache.
-The value must be a power of 2. The default value is 32 blocks.
+The value must be a power of 2.  The default value is 32 blocks.
 .TP
 .BI stripe= n
 Number of filesystem blocks that mballoc will try to use for allocation size
-and alignment. For RAID5/6 systems this should be the number of data disks *
+and alignment.  For RAID5/6 systems this should be the number of data disks *
 RAID chunk size in filesystem blocks.
 .TP
 .B delalloc
 Deferring block allocation until write-out time.
 .TP
 .B nodelalloc
-Disable delayed allocation. Blocks are allocated when data is copied from user
+Disable delayed allocation.  Blocks are allocated when data is copied from user
 to page cache.
 .TP
 .BI max_batch_time= usec
 Maximum amount of time ext4 should wait for additional filesystem operations to
-be batch together with a synchronous write operation. Since a synchronous
+be batch together with a synchronous write operation.  Since a synchronous
 write operation is going to force a commit and then a wait for the I/O
 complete, it doesn't cost much, and can be a huge throughput win, we wait for a
 small amount of time to see if any other transactions can piggyback on the
-synchronous write. The algorithm used is designed to automatically tune for
+synchronous write.  The algorithm used is designed to automatically tune for
 the speed of the disk, by measuring the amount of time (on average) that it
-takes to finish committing a transaction. Call this time the "commit time".
+takes to finish committing a transaction.  Call this time the "commit time".
 If the time that the transaction has been running is less than the commit time,
 ext4 will try sleeping for the commit time to see if other operations will join
-the transaction. The commit time is capped by the max_batch_time, which
-defaults to 15000\ \[mc]s (15\ ms). This optimization can be turned off entirely by
+the transaction.  The commit time is capped by the max_batch_time, which
+defaults to 15000\ \[mc]s (15\ ms).  This optimization can be turned off entirely by
 setting max_batch_time to 0.
 .TP
 .BI min_batch_time= usec
 This parameter sets the commit time (as described above) to be at least
-min_batch_time. It defaults to zero microseconds. Increasing this parameter
+min_batch_time.  It defaults to zero microseconds.  Increasing this parameter
 may improve the throughput of multi-threaded, synchronous workloads on very
 fast disks, at the cost of increasing latency.
 .TP
@@ -1853,14 +1849,14 @@ ext3, and avoids the "zero-length" problem that can happen when a system
 crashes before the delayed allocation blocks are forced to disk.
 .TP
 .B noinit_itable
-Do not initialize any uninitialized inode table blocks in the background. This
+Do not initialize any uninitialized inode table blocks in the background.  This
 feature may be used by installation CD's so that the install process can
 complete as quickly as possible; the inode table initialization process would
 then be deferred until the next time the filesystem is mounted.
 .TP
 .B init_itable=n
 The lazy itable init code will wait n times the number of milliseconds it took
-to zero out the previous block group's inode table. This minimizes the impact on
+to zero out the previous block group's inode table.  This minimizes the impact on
 system performance while the filesystem's inode table is being initialized.
 .TP
 .BR discard / nodiscard
@@ -1871,22 +1867,22 @@ testing has been done.
 .TP
 .B nouid32
 Disables 32-bit UIDs and GIDs.  This is for
-interoperability  with  older kernels which only
+interoperability with older kernels which only
 store and expect 16-bit values.
 .TP
 .BR block_validity / noblock_validity
 This options allows to enables/disables the in-kernel facility for tracking
-filesystem metadata blocks within internal data structures. This allows multi-\c
+filesystem metadata blocks within internal data structures.  This allows multi-\c
 block allocator and other routines to quickly locate extents which might
-overlap with filesystem metadata blocks. This option is intended for debugging
+overlap with filesystem metadata blocks.  This option is intended for debugging
 purposes and since it negatively affects the performance, it is off by default.
 .TP
 .BR dioread_lock / dioread_nolock
-Controls whether or not ext4 should use the DIO read locking. If the
+Controls whether or not ext4 should use the DIO read locking.  If the
 dioread_nolock option is specified ext4 will allocate uninitialized extent
 before buffer write and convert the extent to initialized after IO completes.
 This approach allows ext4 code to avoid using inode mutex, which improves
-scalability on high speed storages. However this does not work with data
+scalability on high speed storages.  However this does not work with data
 journaling and dioread_nolock option will be ignored with kernel warning.
 Note that dioread_nolock code path is only used for extent-based files.
 Because of the restrictions this options comprises it is off by default
@@ -1894,14 +1890,14 @@ Because of the restrictions this options comprises it is off by default
 .TP
 .B max_dir_size_kb=n
 This limits the size of the directories so that any attempt to expand them
-beyond the specified limit in kilobytes will cause an ENOSPC error. This is
+beyond the specified limit in kilobytes will cause an ENOSPC error.  This is
 useful in memory-constrained environments, where a very large directory can
 cause severe performance problems or even provoke the Out Of Memory killer. (For
 example, if there is only 512\ MB memory available, a 176\ MB directory may
 seriously cramp the system's style.)
 .TP
 .B i_version
-Enable 64-bit inode version support. This option is off by default.
+Enable 64-bit inode version support.  This option is off by default.
 
 .SH "Mount options for fat"
 (Note:
@@ -1914,7 +1910,7 @@ and
 filesystems.)
 .TP
 .BR blocksize= { 512 | 1024 | 2048 }
-Set blocksize (default 512). This option is obsolete.
+Set blocksize (default 512).  This option is obsolete.
 .TP
 \fBuid=\fP\,\fIvalue\fP and \fBgid=\fP\,\fIvalue\fP
 Set the owner and group of all files.
@@ -1923,7 +1919,7 @@ Set the owner and group of all files.
 .BI umask= value
 Set the umask (the bitmask of the permissions that are
 .B not
-present). The default is the umask of the current process.
+present).  The default is the umask of the current process.
 The value is given in octal.
 .TP
 .BI dmask= value
@@ -1950,13 +1946,13 @@ Other users can change timestamp.
 .PP
 The default is set from `dmask' option. (If the directory is writable,
 .BR utime (2)
-is also allowed. I.e.\& \s+3~\s0dmask & 022)
+is also allowed.  I.e.\& \s+3~\s0dmask & 022)
 
 Normally
 .BR utime (2)
 checks current process is owner of the file, or it has
 CAP_FOWNER capability.  But FAT filesystem doesn't have uid/gid on disk, so
-normal check is too inflexible. With this option you can relax it.
+normal check is too inflexible.  With this option you can relax it.
 .RE
 .TP
 .BI check= value
@@ -1976,32 +1972,31 @@ Like "relaxed", but many special characters (*, ?, <, spaces, etc.) are
 rejected.  This is the default.
 .TP
 .BR s [ trict ]
-Like "normal", but names may not contain long parts and special characters
-that are sometimes used on Linux, but are not accepted by MS-DOS are
-rejected. (+, =, spaces, etc.)
+Like "normal", but names that contain long parts or special characters
+that are sometimes used on Linux but are not accepted by MS-DOS
+(+, =, etc.) are rejected.
 .RE
 .TP
 .BI codepage= value
 Sets the codepage for converting to shortname characters on FAT
-and VFAT filesystems. By default, codepage 437 is used.
+and VFAT filesystems.  By default, codepage 437 is used.
 .TP
-.BR conv= {b [ inary ]| t [ ext ]| a [ uto ]}
+.BI conv= mode
 The
 .I fat
-filesystem can perform CRLF<-->NL (MS-DOS text format to UNIX text
-format) conversion in the kernel. The following conversion modes are
-available:
+filesystem can perform CRLF<-->NL conversion (MS-DOS text format to UNIX text
+format) in the kernel.  The following conversion \fImode\fRs are available:
 .RS
 .TP
-.B binary
-no translation is performed.  This is the default.
+.BR b [ inary ]
+No translation is performed.  This is the default.
 .TP
-.B text
+.BR t [ ext ]
 CRLF<-->NL translation is performed on all files.
 .TP
-.B auto
+.BR a [ uto ]
 CRLF<-->NL translation is performed on all files that don't have a
-"well-known binary" extension. The list of known extensions can be found at
+"well-known binary" extension.  The list of known extensions can be found at
 the beginning of
 .I fs/fat/misc.c
 (as of 2.0, the list is: exe, com, bin, app, sys, drv, ovl, ovr, obj,
@@ -2009,21 +2004,21 @@ lib, dll, pif, arc, zip, lha, lzh, zoo, tar, z, arj, tz, taz, tzp, tpz,
 gz, tgz, deb, gif, bmp, tif, gl, jpg, pcx, tfm, vf, gf, pk, pxl, dvi).
 .PP
 Programs that do computed lseeks won't like in-kernel text conversion.
-Several people have had their data ruined by this translation. Beware!
+Several people have had their data ruined by this translation.  Beware!
 
 For filesystems mounted in binary mode, a conversion tool
-(fromdos/todos) is available. This option is obsolete.
+(fromdos/todos) is available.  This option is obsolete.
 .RE
 .TP
 .BI cvf_format= module
 Forces the driver to use the CVF (Compressed Volume File) module
 .RI cvf_ module
-instead of auto-detection. If the kernel supports kmod, the
+instead of auto-detection.  If the kernel supports kmod, the
 cvf_format=xxx option also controls on-demand CVF module loading.
 This option is obsolete.
 .TP
 .BI cvf_option= option
-Option passed to the CVF module. This option is obsolete.
+Option passed to the CVF module.  This option is obsolete.
 .TP
 .B debug
 Turn on the
@@ -2034,7 +2029,7 @@ inconsistent).
 .TP
 .B discard
 If set, causes discard/TRIM commands to be issued to the block device
-when blocks are freed. This is useful for SSD devices and
+when blocks are freed.  This is useful for SSD devices and
 sparse/thinly-provisioned LUNs.
 .TP
 .BR fat= {12 | 16 | 32 }
@@ -2043,12 +2038,12 @@ the automatic FAT type detection routine.  Use with caution!
 .TP
 .BI iocharset= value
 Character set to use for converting between 8 bit characters
-and 16 bit Unicode characters. The default is iso8859-1.
+and 16 bit Unicode characters.  The default is iso8859-1.
 Long filenames are stored on disk in Unicode format.
 .TP
 .B nfs
 If set, enables in-memory indexing of directory inodes to reduce the
-frequency of ESTALE errors in NFS client operations. Useful only when
+frequency of ESTALE errors in NFS client operations.  Useful only when
 the filesystem is exported via NFS.
 .TP
 .BI tz=UTC
@@ -2063,11 +2058,11 @@ local time.
 Turn on the
 .I quiet
 flag.  Attempts to chown or chmod files do not return errors,
-although they fail. Use with caution!
+although they fail.  Use with caution!
 .TP
 .B showexec
 If set, the execute permission bits of the file will be allowed only if
-the extension part of the name is \&.EXE, \&.COM, or \&.BAT. Not set by default.
+the extension part of the name is \&.EXE, \&.COM, or \&.BAT.  Not set by default.
 .TP
 .B sys_immutable
 If set, ATTR_SYS attribute on FAT is handled as IMMUTABLE flag on Linux.
@@ -2078,11 +2073,11 @@ If set, the filesystem will try to flush to disk more early than normal.
 Not set by default.
 .TP
 .B usefree
-Use the "free clusters" value stored on FSINFO. It'll
+Use the "free clusters" value stored on FSINFO.  It'll
 be used to determine number of free clusters without
-scanning disk. But it's not used by default, because
+scanning disk.  But it's not used by default, because
 recent Windows don't update it correctly in some
-case. If you are sure the "free clusters" on FSINFO is
+case.  If you are sure the "free clusters" on FSINFO is
 correct, by this option you can avoid scanning disk.
 .TP
 .BR dots ", " nodots ", " dotsOK= [ yes | no ]
@@ -2125,7 +2120,7 @@ of the current process.)
 .BI umask= value
 Set the umask (the bitmask of the permissions that are
 .B not
-present). The default is the umask of the current process.
+present).  The default is the umask of the current process.
 The value is given in octal.
 .TP
 .BR case= { lower | asis }
@@ -2144,14 +2139,14 @@ choose more or less at random between
 .BR conv=binary " and " conv=text .
 For
 .BR conv=binary ,
-just read what is in the file. This is the default.
+just read what is in the file.  This is the default.
 .TP
 .B nocheck
 Do not abort mounting when certain consistency checks fail.
 
 .SH "Mount options for iso9660"
 ISO 9660 is a standard describing a filesystem structure to be used
-on CD-ROMs. (This filesystem type is also seen on some DVDs. See also the
+on CD-ROMs. (This filesystem type is also seen on some DVDs.  See also the
 .I udf
 filesystem.)
 
@@ -2169,11 +2164,11 @@ the filesystem is indistinguishable from a normal UNIX filesystem (except
 that it is read-only, of course).
 .TP
 .B norock
-Disable the use of Rock Ridge extensions, even if available. Cf.\&
+Disable the use of Rock Ridge extensions, even if available.  Cf.\&
 .BR map .
 .TP
 .B nojoliet
-Disable the use of Microsoft Joliet extensions, even if available. Cf.\&
+Disable the use of Microsoft Joliet extensions, even if available.  Cf.\&
 .BR map .
 .TP
 .BR check= { r [ elaxed ]| s [ trict ]}
@@ -2198,7 +2193,7 @@ For non-Rock Ridge volumes, normal name translation maps upper
 to lower case ASCII, drops a trailing `;1', and converts `;' to `.'.
 With
 .B map=off
-no name translation is done. See
+no name translation is done.  See
 .BR norock .
 (Default:
 .BR map=normal .)
@@ -2246,7 +2241,7 @@ sense when using discs encoded using Microsoft's Joliet extensions.
 .TP
 .BI iocharset= value
 Character set to use for converting 16 bit Unicode characters on CD
-to 8 bit characters. The default is iso8859-1.
+to 8 bit characters.  The default is iso8859-1.
 .TP
 .B utf8
 Convert 16 bit Unicode characters on CD to UTF-8.
@@ -2265,14 +2260,14 @@ file.
 .BI resize= value
 Resize the volume to
 .I value
-blocks. JFS only supports growing a volume, not shrinking it. This option
-is only valid during a remount, when the volume is mounted read-write. The
+blocks.  JFS only supports growing a volume, not shrinking it.  This option
+is only valid during a remount, when the volume is mounted read-write.  The
 .B resize
 keyword with no value will grow the volume to the full size of the partition.
 .TP
 .B nointegrity
 Do not write to the journal.  The primary use of this option is to allow
-for higher performance when restoring a volume from backup media. The
+for higher performance when restoring a volume from backup media.  The
 integrity of the volume is not guaranteed if the system abnormally ends.
 .TP
 .B integrity
@@ -2297,7 +2292,7 @@ See mount options for fat.
 If the
 .I msdos
 filesystem detects an inconsistency, it reports an error and sets the file
-system read-only. The filesystem can be made writable again by remounting
+system read-only.  The filesystem can be made writable again by remounting
 it.
 
 .SH "Mount options for ncpfs"
@@ -2305,7 +2300,7 @@ Just like
 .IR nfs ", the " ncpfs
 implementation expects a binary argument (a
 .IR "struct ncp_mount_data" )
-to the mount system call. This argument is constructed by
+to the mount system call.  This argument is constructed by
 .BR ncpmount (8)
 and the current version of
 .B mount
@@ -2320,7 +2315,7 @@ The
 .IR nfs " and " nfs4
 implementation expects a binary argument (a
 .IR "struct nfs_mount_data" )
-to the mount system call. This argument is constructed by
+to the mount system call.  This argument is constructed by
 .BR mount.nfs (8)
 and the current version of
 .B mount
@@ -2331,7 +2326,7 @@ and the current version of
 .BI iocharset= name
 Character set to use when returning file names.
 Unlike VFAT, NTFS suppresses names that contain
-nonconvertible characters. Deprecated.
+nonconvertible characters.  Deprecated.
 .\" since 2.5.11
 .TP
 .BI nls= name
@@ -2346,13 +2341,13 @@ Use UTF-8 for converting file names.
 For 0 (or `no' or `false'), do not use escape sequences
 for unknown Unicode characters.
 For 1 (or `yes' or `true') or 2, use vfat-style 4-byte escape sequences
-starting with ":". Here 2 give a little-endian encoding
+starting with ":".  Here 2 give a little-endian encoding
 and 1 a byteswapped bigendian encoding.
 .TP
 .B posix=[0|1]
 If enabled (posix=1), the filesystem distinguishes between
-upper and lower case. The 8.3 alias names are presented as
-hard links instead of being suppressed. This option is obsolete.
+upper and lower case.  The 8.3 alias names are presented as
+hard links instead of being suppressed.  This option is obsolete.
 .TP
 \fBuid=\fP\,\fIvalue\fP, \fBgid=\fP\,\fIvalue\fP and \fBumask=\fP\,\fIvalue\fP
 Set the file permission on the filesystem.
@@ -2365,8 +2360,8 @@ By default, the files are owned by root and not readable by somebody else.
 These options are recognized, but have no effect as far as I can see.
 
 .SH "Mount options for ramfs"
-Ramfs is a memory based filesystem. Mount it and you have it. Unmount it
-and it is gone. Present since Linux 2.3.99pre4.
+Ramfs is a memory based filesystem.  Mount it and you have it.  Unmount it
+and it is gone.  Present since Linux 2.3.99pre4.
 There are no mount options.
 
 .SH "Mount options for reiserfs"
@@ -2374,7 +2369,7 @@ Reiserfs is a journaling filesystem.
 .TP
 .B conv
 Instructs version 3.6 reiserfs software to mount a version 3.5 filesystem,
-using the 3.6 format for newly created objects. This filesystem will no
+using the 3.6 format for newly created objects.  This filesystem will no
 longer be compatible with reiserfs 3.5 tools.
 .TP
 .BR hash= { rupasov | tea | r5 | detect }
@@ -2394,7 +2389,7 @@ and, therefore, low probability of hash collisions at some CPU cost.
 This may be used if EHASHCOLLISION errors are experienced with the r5 hash.
 .TP
 .B r5
-A modified version of the rupasov hash. It is used by default and is
+A modified version of the rupasov hash.  It is used by default and is
 the best choice unless the filesystem has huge directories and
 unusual file-name patterns.
 .TP
@@ -2403,16 +2398,16 @@ Instructs
 .I mount
 to detect which hash function is in use by examining
 the filesystem being mounted, and to write this information into
-the reiserfs superblock. This is only useful on the first mount of
+the reiserfs superblock.  This is only useful on the first mount of
 an old format filesystem.
 .RE
 .TP
 .B hashed_relocation
-Tunes the block allocator. This may provide performance improvements
+Tunes the block allocator.  This may provide performance improvements
 in some situations.
 .TP
 .B no_unhashed_relocation
-Tunes the block allocator. This may provide performance improvements
+Tunes the block allocator.  This may provide performance improvements
 in some situations.
 .TP
 .B noborder
@@ -2420,7 +2415,7 @@ Disable the border allocator algorithm invented by Yury Yu. Rupasov.
 This may provide performance improvements in some situations.
 .TP
 .B nolog
-Disable journaling. This will provide slight performance improvements in
+Disable journaling.  This will provide slight performance improvements in
 some situations at the cost of losing reiserfs's fast recovery from crashes.
 Even with this option turned on, reiserfs still performs all journaling
 operations, save for actual writes into its journaling area.  Implementation
@@ -2430,13 +2425,13 @@ is a work in progress.
 .TP
 .B notail
 By default, reiserfs stores small files and `file tails' directly into its
-tree. This confuses some utilities such as
+tree.  This confuses some utilities such as
 .BR LILO (8).
 This option is used to disable packing of files into the tree.
 .TP
 .B replayonly
 Replay the transactions which are in the journal, but do not actually
-mount the filesystem. Mainly used by
+mount the filesystem.  Mainly used by
 .IR reiserfsck .
 .TP
 .BI resize= number
@@ -2452,18 +2447,18 @@ utility which can be obtained from
 .IR ftp://ftp.namesys.com/pub/reiserfsprogs .
 .TP
 .B user_xattr
-Enable Extended User Attributes. See the
+Enable Extended User Attributes.  See the
 .BR attr (5)
 manual page.
 .TP
 .B acl
-Enable POSIX Access Control Lists. See the
+Enable POSIX Access Control Lists.  See the
 .BR acl (5)
 manual page.
 .TP
 .BR barrier=none " / " barrier=flush "
 This disables / enables the use of write barriers in the journaling code.
-barrier=none disables, barrier=flush enables (default). This also requires an
+barrier=none disables, barrier=flush enables (default).  This also requires an
 IO stack which can support barriers, and if reiserfs gets an error on a barrier
 write, it will disable barriers again with a warning.  Write barriers enforce
 proper on-disk ordering of journal commits, making volatile disk write caches
@@ -2481,7 +2476,7 @@ Just like
 .IR nfs ", the " smbfs
 implementation expects a binary argument (a
 .IR "struct smb_mount_data" )
-to the mount system call. This argument is constructed by
+to the mount system call.  This argument is constructed by
 .BR smbmount (8)
 and the current version of
 .B mount
@@ -2495,7 +2490,7 @@ None.
 .BI size= nbytes
 Override default maximum size of the filesystem.
 The size is given in bytes, and rounded up to entire pages.
-The default is half of the memory. The size parameter also accepts a suffix %
+The default is half of the memory.  The size parameter also accepts a suffix %
 to limit this tmpfs instance to that percentage of your physical RAM:
 the default, when neither size nor nr_blocks is specified, is size=50%
 .TP
@@ -2503,7 +2498,7 @@ the default, when neither size nor nr_blocks is specified, is size=50%
 The same as size, but in blocks of PAGE_CACHE_SIZE
 .TP
 .B nr_inodes=
-The maximum number of inodes for this instance. The default
+The maximum number of inodes for this instance.  The default
 is half of the number of your physical RAM pages, or (on a
 machine with highmem) the number of lowmem RAM pages,
 whichever is the lower.
@@ -2565,7 +2560,7 @@ mount options.  It can be added later, when the tmpfs is already mounted
 on MountPoint, by 'mount \-o remount,mpol=Policy:NodeList MountPoint'.
 
 .SH "Mount options for ubifs"
-UBIFS is a flash file system which works on top of UBI volumes. Note that
+UBIFS is a flash file system which works on top of UBI volumes.  Note that
 .B
 atime
 is not supported and is always turned off.
@@ -2604,25 +2599,25 @@ separator may be used instead of
 The following mount options are available:
 .TP
 .B bulk_read
-Enable bulk-read. VFS read-ahead is disabled because it slows down the file
-system. Bulk-Read is an internal optimization. Some flashes may read faster if
-the data are read at one go, rather than at several read requests. For
+Enable bulk-read.  VFS read-ahead is disabled because it slows down the file
+system.  Bulk-Read is an internal optimization.  Some flashes may read faster if
+the data are read at one go, rather than at several read requests.  For
 example, OneNAND can do "read-while-load" if it reads more than one NAND page.
 .TP
 .B no_bulk_read
-Do not bulk-read. This is the default.
+Do not bulk-read.  This is the default.
 .TP
 .B chk_data_crc
-Check data CRC-32 checksums. This is the default.
+Check data CRC-32 checksums.  This is the default.
 .TP
 .BR no_chk_data_crc .
-Do not check data CRC-32 checksums. With this option, the filesystem does not
+Do not check data CRC-32 checksums.  With this option, the filesystem does not
 check CRC-32 checksum for data, but it does check it for the internal indexing
-information. This option only affects reading, not writing. CRC-32 is always
+information.  This option only affects reading, not writing.  CRC-32 is always
 calculated when writing the data.
 .TP
 .BR compr= { none | lzo | zlib }
-Select the default compressor which is used when new files are written. It is
+Select the default compressor which is used when new files are written.  It is
 still possible to read compressed files if mounted with the
 .B none
 option.
@@ -2665,10 +2660,10 @@ Set the block size. (May not work unless 2048.)
 Skip volume sequence recognition.
 .TP
 .B session=
-Set the CDROM session counting from 0. Default: last session.
+Set the CDROM session counting from 0.  Default: last session.
 .TP
 .B anchor=
-Override standard anchor location. Default: 256.
+Override standard anchor location.  Default: 256.
 .TP
 .B volume=
 Override the VolumeDesc location. (unused)
@@ -2689,7 +2684,7 @@ Override the root directory location. (unused)
 .TP
 .BI ufstype= value
 UFS is a filesystem widely used in different operating systems.
-The problem are differences among implementations. Features of some
+The problem are differences among implementations.  Features of some
 implementations are undocumented, so its hard to recognize the
 type of ufs automatically.
 That's why the user must specify the type of ufs by mount option.
@@ -2762,10 +2757,10 @@ Furthermore, there are
 .B uni_xlate
 Translate unhandled Unicode characters to special escaped sequences.
 This lets you backup and restore filenames that are created with any
-Unicode characters. Without this option, a '?' is used when no
-translation is possible. The escape character is ':' because it is
-otherwise invalid on the vfat filesystem. The escape sequence
-that gets used, where u is the unicode character,
+Unicode characters.  Without this option, a '?' is used when no
+translation is possible.  The escape character is ':' because it is
+otherwise invalid on the vfat filesystem.  The escape sequence
+that gets used, where u is the Unicode character,
 is: ':', (u & 0x3f), ((u>>6) & 0x3f), (u>>12).
 .TP
 .B posix
@@ -2779,33 +2774,31 @@ before trying
 .TP
 .B utf8
 UTF8 is the filesystem safe 8-bit encoding of Unicode that is used by the
-console. It can be enabled for the filesystem with this option or disabled
-with utf8=0, utf8=no or utf8=false. If `uni_xlate' gets set, UTF8 gets
+console.  It can be enabled for the filesystem with this option or disabled
+with utf8=0, utf8=no or utf8=false.  If `uni_xlate' gets set, UTF8 gets
 disabled.
 .TP
-.BR shortname= { lower | win95 | winnt | mixed }
-
+.BI shortname= mode
 Defines the behavior for creation and display of filenames which fit into
-8.3 characters. If a long name for a file exists, it will always be
-preferred display. There are four modes:
-:
+8.3 characters.  If a long name for a file exists, it will always be the
+preferred one for display.  There are four \fImode\fRs:
 .RS
 .TP
-.I lower
+.B lower
 Force the short name to lower case upon display; store a long name when
 the short name is not all upper case.
 .TP
-.I win95
+.B win95
 Force the short name to upper case upon display; store a long name when
 the short name is not all upper case.
 .TP
-.I winnt
-Display the shortname as is; store a long name when the short name is
+.B winnt
+Display the short name as is; store a long name when the short name is
 not all lower case or all upper case.
 .TP
-.I mixed
+.B mixed
 Display the short name as is; store a long name when the short name is not
-all upper case. This mode is the default since Linux 2.6.32.
+all upper case.  This mode is the default since Linux 2.6.32.
 .RE
 
 
@@ -2813,25 +2806,25 @@ all upper case. This mode is the default since Linux 2.6.32.
 .TP
 \fBdevuid=\fP\,\fIuid\fP and \fBdevgid=\fP\,\fIgid\fP and \fBdevmode=\fP\,\fImode\fP
 Set the owner and group and mode of the device files in the usbfs filesystem
-(default: uid=gid=0, mode=0644). The mode is given in octal.
+(default: uid=gid=0, mode=0644).  The mode is given in octal.
 .TP
 \fBbusuid=\fP\,\fIuid\fP and \fBbusgid=\fP\,\fIgid\fP and \fBbusmode=\fP\,\fImode\fP
 Set the owner and group and mode of the bus directories in the usbfs
-filesystem (default: uid=gid=0, mode=0555). The mode is given in octal.
+filesystem (default: uid=gid=0, mode=0555).  The mode is given in octal.
 .TP
 \fBlistuid=\fP\,\fIuid\fP and \fBlistgid=\fP\,\fIgid\fP and \fBlistmode=\fP\,\fImode\fP
 Set the owner and group and mode of the file
 .I devices
-(default: uid=gid=0, mode=0444). The mode is given in octal.
+(default: uid=gid=0, mode=0444).  The mode is given in octal.
 
 .SH "Mount options for xenix"
 None.
 
 .SH "Mount options for xfs"
 .TP
-.B allocsize=size
+.BI allocsize= size
 Sets the buffered I/O end-of-file preallocation size when
-doing delayed allocation writeout. Valid values for this
+doing delayed allocation writeout.  Valid values for this
 option are page size (typically 4KiB) through to 1GiB,
 inclusive, in power-of-2 increments.
 .sp
@@ -2839,7 +2832,7 @@ The default behavior is for dynamic end-of-file
 preallocation size, which uses a set of heuristics to
 optimise the preallocation size based on the current
 allocation patterns within the file and the access patterns
-to the file. Specifying a fixed allocsize value turns off
+to the file.  Specifying a fixed allocsize value turns off
 the dynamic behavior.
 .TP
 .BR attr2 | noattr2
@@ -2851,7 +2844,7 @@ attributes) the on-disk superblock feature bit field will be
 updated to reflect this format being in use.
 .sp
 The default behavior is determined by the on-disk feature
-bit indicating that attr2 behavior is active. If either
+bit indicating that attr2 behavior is active.  If either
 mount option it set, then that becomes the new default used
 by the filesystem.
 .sp
@@ -2912,7 +2905,7 @@ large inode numbers.  If applications are in use which do
 not handle inode numbers bigger than 32 bits, the inode32
 option should be specified.
 .TP
-.BR  largeio | nolargeio
+.BR largeio | nolargeio
 If "nolargeio" is specified, the optimal I/O reported in
 st_blksize by stat(2) will be as small as possible to allow
 user applications to avoid inefficient read/modify/write
@@ -2921,12 +2914,12 @@ this is the granularity of the page cache.
 .sp
 If "largeio" specified, a filesystem that was created with a
 "swidth" specified will return the "swidth" value (in bytes)
-in st_blksize. If the filesystem does not have a "swidth"
+in st_blksize.  If the filesystem does not have a "swidth"
 specified but does specify an "allocsize" then "allocsize"
-(in bytes) will be returned instead. Otherwise the behavior
+(in bytes) will be returned instead.  Otherwise the behavior
 is the same as if "nolargeio" was specified.
 .TP
-.B logbufs=value
+.BI logbufs= value
 Set the number of in-memory log buffers.  Valid numbers
 range from 2\(en8 inclusive.
 .sp
@@ -2934,23 +2927,23 @@ The default value is 8 buffers.
 .sp
 If the memory cost of 8 log buffers is too high on small
 systems, then it may be reduced at some cost to performance
-on metadata intensive workloads. The logbsize option below
+on metadata intensive workloads.  The logbsize option below
 controls the size of each buffer and so is also relevant to
 this case.
 .TP
-.B logbsize=value
+.BI logbsize= value
 Set the size of each in-memory log buffer.  The size may be
 specified in bytes, or in kibibytes (KiB) with a "k" suffix.
 Valid sizes for version 1 and version 2 logs are 16384 (value=16k)
 and 32768 (value=32k).  Valid sizes for version 2 logs also
-include 65536 (value=64k), 131072 (value=128k) and 262144 (value=256k). The
-logbsize must be an integer multiple of the log
+include 65536 (value=64k), 131072 (value=128k) and 262144 (value=256k).
+The logbsize must be an integer multiple of the log
 stripe unit configured at mkfs time.
 .sp
 The default value for version 1 logs is 32768, while the
 default value for version 2 logs is MAX(32768, log_sunit).
 .TP
-.BR logdev=device and rtdev=device
+.BI logdev= "device \fRand " rtdev= device
 Use an external log (metadata journal) and/or real-time device.
 An XFS filesystem has up to three parts: a data section, a log
 section, and a real-time section.  The real-time section is
@@ -2959,7 +2952,7 @@ section or contained within it.
 .TP
 .B noalign
 Data allocations will not be aligned at stripe unit
-boundaries. This is only relevant to filesystems created
+boundaries.  This is only relevant to filesystems created
 with non-zero data alignment parameters (sunit, swidth) by
 mkfs.
 .TP
@@ -2993,16 +2986,16 @@ enforced.  Refer to xfs_quota(8) for further details.
 Project disk quota accounting enabled and limits (optionally)
 enforced.  Refer to xfs_quota(8) for further details.
 .TP
-.BR sunit=value " and " swidth=value
+.BI sunit= "value \fRand " swidth =value
 Used to specify the stripe unit and width for a RAID device
 or a stripe volume.  "value" must be specified in 512-byte
-block units. These options are only relevant to filesystems
+block units.  These options are only relevant to filesystems
 that were created with non-zero data alignment parameters.
 .sp
 The sunit and swidth parameters specified must be compatible
 with the existing filesystem alignment characteristics.  In
 general, that means the only valid changes to sunit are
-increasing it by a power-of-2 multiple. Valid swidth values
+increasing it by a power-of-2 multiple.  Valid swidth values
 are any integer multiple of a valid sunit value.
 .sp
 Typically the only time these mount options are necessary if
@@ -3017,20 +3010,20 @@ size is larger than the stripe width size.
 .TP
 .B wsync
 When specified, all filesystem namespace operations are
-executed synchronously. This ensures that when the namespace
+executed synchronously.  This ensures that when the namespace
 operation (create, unlink, etc) completes, the change to the
-namespace is on stable storage. This is useful in HA setups
+namespace is on stable storage.  This is useful in HA setups
 where failover must not result in clients seeing
 inconsistent namespace presentation during or after a
 failover event.
 
 .SH "Mount options for xiafs"
-None. Although nothing is wrong with xiafs, it is not used much,
-and is not maintained. Probably one shouldn't use it.
+None.  Although nothing is wrong with xiafs, it is not used much,
+and is not maintained.  Probably one shouldn't use it.
 Since Linux version 2.1.21 xiafs is no longer part of the kernel source.
 
 .SH "THE LOOP DEVICE"
-One further possible type is a mount via the loop device. For example,
+One further possible type is a mount via the loop device.  For example,
 the command
 .RS
 .sp
@@ -3064,22 +3057,23 @@ not specified or the filesystem is known for libblkid, for example:
 .B "mount \-t ext3 /tmp/disk.img /mnt"
 .sp
 .RE
-This type of mount knows about four options, namely
-.BR loop ", " offset " and " sizelimit " ,
+This type of mount knows about three options, namely
+.BR loop ", " offset " and " sizelimit ,
 that are really options to
 .BR \%losetup (8).
 (These options can be used in addition to those specific
 to the filesystem type.)
 
-Since Linux 2.6.25 is supported auto-destruction of loop devices and
-then any loop device allocated by
+Since Linux 2.6.25 auto-destruction of loop devices is supported,
+meaning that any loop device allocated by
 .B mount
 will be freed by
 .B umount
-independently on
+independently of
 .IR /etc/mtab .
 
-You can also free a loop device by hand, using `losetup \-d' or `umount \-d`.
+You can also free a loop device by hand, using
+.BR "losetup \-d " or " umount \-d" .
 
 .SH RETURN CODES
 .B mount
@@ -3112,27 +3106,28 @@ mount failure
 some mount succeeded
 .RE
 
-The command mount \-a returns 0 (all success), 32 (all failed) or 64 (some
-failed, some success).
+The command \fBmount \-a\fR returns 0 (all succeeded), 32 (all failed), or 64 (some
+failed, some succeeded).
 
 .SH "EXTERNAL HELPERS"
 The syntax of external mount helpers is:
 
 .RS
-.BI /sbin/mount. <suffix>
+.BI /sbin/mount. suffix
 .I spec dir
 .RB [ \-sfnv ]
 .RB [ \-o
 .IR options ]
 .RB [ \-t
-.IR type.subtype ]
+.IR type \fB. subtype ]
 .RE
 
-where the <type> is filesystem type and \-sfnvo options have same meaning like
-standard mount options. The \-t option is used  for filesystems with subtypes
-support (for example /sbin/mount.fuse \-t fuse.sshfs).
+where the \fIsuffix\fR is the filesystem type and the \fB\-sfnvo\fR options have
+the same meaning as the normal mount options.  The \fB\-t\fR option is used for
+filesystems with subtypes support (for example
+.BR "/sbin/mount.fuse \-t fuse.sshfs" ).
 
-The command mount does not pass mount options
+The command \fBmount\fR does not pass the mount options
 .BR unbindable ,
 .BR runbindable ,
 .BR private ,
@@ -3149,8 +3144,8 @@ The command mount does not pass mount options
 .B offset
 and
 .B sizelimit
-to mount.<suffix> helpers. The all others options are
-used in comma delimited list as argument for the option \-o.
+to the mount.<suffix> helpers.  All other options are used in a
+comma-separated list as argument to the \fB\-o\fR option.
 
 .SH FILES
 .TP 18n
@@ -3219,9 +3214,9 @@ It is possible that files
 .I /etc/mtab
 and
 .I /proc/mounts
-don't match. The first file is based only on the mount command options, but the
+don't match.  The first file is based only on the mount command options, but the
 content of the second file also depends on the kernel and others settings (e.g.\&
-remote NFS server. In particular case the mount command may reports unreliable
+remote NFS server.  In particular case the mount command may reports unreliable
 information about a NFS mount point and the /proc/mounts file usually contains
 more reliable information.)
 .PP
@@ -3241,7 +3236,7 @@ or
 options used may fail when using older kernels if the
 .B mount
 command can't confirm that the size of the block device has been configured
-as requested. This situation can be worked around by using
+as requested.  This situation can be worked around by using
 the
 .B losetup
 command manually before calling
-- 
1.7.0.4

