Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:55891 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752262AbaGYMzK (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Jul 2014 08:55:10 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/4] docs: fix some things that were overlooked during the first pass
Date: Fri, 25 Jul 2014 14:55:01 +0200
Message-Id: <1406292904-3956-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mainly more option sorting, some formatting adjustments, and the adding
of a missing --version here and there.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/dmesg.1     |   29 ++++++++------
 sys-utils/eject.1     |   94 +++++++++++++++++++++++++++-----------------
 sys-utils/fallocate.1 |  104 ++++++++++++++++++++++++++----------------------
 sys-utils/flock.1     |   61 ++++++++++++++--------------
 sys-utils/ipcmk.1     |   10 ++--
 sys-utils/ipcrm.1     |   48 +++++++++++++----------
 sys-utils/renice.1    |    6 +-
 sys-utils/setpriv.1   |  102 ++++++++++++++++++++++++------------------------
 sys-utils/setsid.1    |    9 ++++-
 sys-utils/unshare.1   |    9 +++-
 10 files changed, 260 insertions(+), 212 deletions(-)

diff --git a/sys-utils/dmesg.1 b/sys-utils/dmesg.1
index 86d35df..8a267f8 100644
--- a/sys-utils/dmesg.1
+++ b/sys-utils/dmesg.1
@@ -20,7 +20,7 @@ dmesg \- print or control the kernel ring buffer
 .B dmesg
 is used to examine or control the kernel ring buffer.
 .PP
-The default action is to read all messages from the kernel ring buffer.
+The default action is to display all messages from the kernel ring buffer.
 .SH OPTIONS
 The
 .BR \-\-clear ,
@@ -65,8 +65,6 @@ output.
 .IP "\fB\-H\fR, \fB\-\-human\fR"
 Enable human-readable output.  See also \fB\-\-color\fR, \fB\-\-reltime\fR
 and \fB\-\-nopager\fR.
-.IP "\fB\-h\fR, \fB\-\-help\fR"
-Display help text and exit.
 .IP "\fB\-k\fR, \fB\-\-kernel\fR"
 Print kernel messages.
 .IP "\fB\-L\fR, \fB\-\-color\fR[=\fIwhen\fR]"
@@ -152,15 +150,6 @@ system
 .BR SUSPEND / RESUME .
 .IP "\fB\-t\fR, \fB\-\-notime\fR"
 Do not print kernel's timestamps.
-.IP "\fB\-u\fR, \fB\-\-userspace\fR"
-Print userspace messages.
-.IP "\fB\-V\fR, \fB\-\-version\fR"
-Display version information and exit.
-.IP "\fB\-w\fR, \fB\-\-follow\fR"
-Wait for new messages.  This feature is supported only on systems with
-a readable /dev/kmsg (since kernel 3.5.0).
-.IP "\fB\-x\fR, \fB\-\-decode\fR"
-Decode facility and level (priority) numbers to human-readable prefixes.
 .IP "\fB\-\-time\-format\fR \fIformat\fR"
 Print timestamps using the given \fIformat\fR, which can be
 .BR ctime ,
@@ -183,6 +172,22 @@ The
 format has the same issue as
 .BR ctime :
 the time may be inaccurate when a system is suspended and resumed.
+.TP
+.BR \-u , " \-\-userspace"
+Print userspace messages.
+.TP
+.BR \-w , " \-\-follow"
+Wait for new messages.  This feature is supported only on systems with
+a readable /dev/kmsg (since kernel 3.5.0).
+.TP
+.BR \-x , " \-\-decode"
+Decode facility and level (priority) numbers to human-readable prefixes.
+.TP
+.BR \-V , " \-\-version"
+Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH COLORS
 Implicit coloring can be disabled by an empty file \fI/etc/terminal-colors.d/dmesg.disable\fR.
 See
diff --git a/sys-utils/eject.1 b/sys-utils/eject.1
index c307c25..8e0d92c 100644
--- a/sys-utils/eject.1
+++ b/sys-utils/eject.1
@@ -30,61 +30,87 @@ all four methods in order until it succeeds.
 If a device partition is specified, the whole-disk device is used.  If the device
 or a device partition is currently mounted, it is unmounted before ejecting.
 .SH OPTIONS
-.IP "\fB\-a\fR, \fB\-\-auto on\fR|\fBoff\fR"
+.TP
+.BR \-a , " \-\-auto on" | off
 This option controls the auto-eject mode, supported by some devices.  When
 enabled, the drive automatically ejects when the device is closed.
-.IP "\fB\-c, \-\-changerslot \fIslot\fP"
+.TP
+.BR \-c , " \-\-changerslot " \fIslot
 With this option a CD slot can be selected from an ATAPI/IDE CD-ROM changer.
 Linux 2.0 or higher is required to use this feature.  The CD-ROM drive cannot
 be in use (mounted data CD or playing a music CD) for a change request to work.
 Please also note that the first slot of the changer is referred to as 0, not 1.
-.IP "\fB\-d, \-\-default\fP"
+.TP
+.BR \-d , " \-\-default"
 List the default device name.
-.IP "\fB\-f, \-\-floppy\fP"
+.TP
+.BR \-F , " \-\-force"
+Force eject, don't check device type.
+.TP
+.BR \-f , " \-\-floppy"
 This option specifies that the drive should be ejected using a removable floppy
 disk eject command.
-.IP "\fB\-F, \-\-force\fP"
-Force eject, don't check device type.
-.IP "\fB\-h, \-\-help\fP"
+.TP
+.BR \-h , " \-\-help"
 Display help text and exit.
-.IP "\fB\-i\fR, \fB\-\-manualeject on\fR|\fBoff\fR"
+.TP
+.BR \-i , " \-\-manualeject on" | off
 This option controls locking of the hardware eject button.  When enabled, the
 drive will not be ejected when the button is pressed.  This is useful when you
 are carrying a laptop in a bag or case and don't want it to eject if the button
 is inadvertently pressed.
-.IP "\fB\-p, \-\-proc\fP"
-This option allows you to use /proc/mounts instead /etc/mtab.  It also passes the
-\fB\-n\fR option to \fBumount\fR(1).
-.IP "\fB\-q, \-\-tape\fP"
-This option specifies that the drive should be ejected using a tape drive
-offline command.
-.IP "\fB\-m, \-\-no-unmount\fP"
-The option tells eject to not try to unmount at all.
-.IP "\fB\-M, \-\-no-partitions-unmount\fP"
+.TP
+.BR \-M , " \-\-no-partitions-unmount"
 The option tells eject to not try to unmount other partitions on partitioned
 devices.  If another partition is still mounted, the program will not attempt
 to eject the media.  It will attempt to unmount only the device or mountpoint
 given on the command line.
-.IP "\fB\-n, \-\-noop\fP"
+.TP
+.BR \-m , " \-\-no-unmount"
+The option tells eject to not try to unmount at all.
+.TP
+.BR \-n , " \-\-noop"
 With this option the selected device is displayed but no action is performed.
-.IP "\fB\-t, \-\-trayclose\fP"
-With this option the drive is given a CD-ROM tray close command.  Not all
-devices support this command.
-.IP "\fB\-T, \-\-traytoggle\fP"
-With this option the drive is given a CD-ROM tray close command if it's opened,
-and a CD-ROM tray eject command if it's closed.  Not all devices support this
-command, because it uses the above CD-ROM tray close command.
-.IP "\fB\-r, \-\-cdrom\fP"
+.TP
+.BR \-p , " \-\-proc"
+This option allows you to use /proc/mounts instead /etc/mtab.  It also passes the
+\fB\-n\fR option to \fBumount\fR(8).
+.TP
+.BR \-q , " \-\-tape"
+This option specifies that the drive should be ejected using a tape drive
+offline command.
+.TP
+.BR \-r , " \-\-cdrom"
 This option specifies that the drive should be ejected using a CDROM eject
 command.
-.IP "\fB\-s, \-\-scsi\fP"
+.TP
+.BR \-s , " \-\-scsi"
 This option specifies that the drive should be ejected using SCSI commands.
-.IP "\fB\-v, \-\-verbose\fP"
+.TP
+.BR \-T , " \-\-traytoggle"
+With this option the drive is given a CD-ROM tray close command if it's opened,
+and a CD-ROM tray eject command if it's closed.  Not all devices support this
+command, because it uses the above CD-ROM tray close command.
+.TP
+.BR \-t , " \-\-trayclose"
+With this option the drive is given a CD-ROM tray close command.  Not all
+devices support this command.
+.TP
+.BR \-V , " \-\-version"
+Display version information and exit.
+.TP
+.BR \-v , " \-\-verbose"
 Run in verbose mode; more information is displayed about what the command is
 doing.
-.IP "\fB\-V, \-\-version\fP"
-Display version information and exit.
-.IP "\fB\-x, \-\-cdspeed \fIspeed\fP"
+.TP
+.BR \-X , " \-\-listspeed"
+With this option the CD-ROM drive will be probed to detect the available
+speeds.  The output is a list of speeds which can be used as an argument of the
+\fB\-x\fR option.  This only works with Linux 2.6.13 or higher, on previous versions
+solely the maximum speed will be reported.  Also note that some drives may not
+correctly report the speed and therefore this option does not work with them.
+.TP
+.BR \-x , " \-\-cdspeed " \fIspeed
 With this option the drive is given a CD-ROM select speed command.  The
 .I speed
 argument is a number indicating the desired speed (e.g. 8 for 8X speed), or 0
@@ -92,12 +118,6 @@ for maximum data rate.  Not all devices support this command and you can only
 specify speeds that the drive is capable of.  Every time the media is changed
 this option is cleared.  This option can be used alone, or with the
 \fB\-t\fR and \fB\-c\fR options.
-.IP "\fB\-X, \-\-listspeed\fP" 
-With this option the CD-ROM drive will be probed to detect the available
-speeds.  The output is a list of speeds which can be used as an argument of the
-\fB\-x\fR option.  This only works with Linux 2.6.13 or higher, on previous versions
-solely the maximum speed will be reported.  Also note that some drives may not
-correctly report the speed and therefore this option does not work with them.
 .SH EXIT STATUS
 Returns 0 if operation was successful, 1 if operation failed or command syntax
 was not valid.
diff --git a/sys-utils/fallocate.1 b/sys-utils/fallocate.1
index b03f19b..0762321 100644
--- a/sys-utils/fallocate.1
+++ b/sys-utils/fallocate.1
@@ -4,9 +4,9 @@
 fallocate \- preallocate or deallocate space to a file
 .SH SYNOPSIS
 .B fallocate
+.RB [ \-c ]
 .RB [ \-n ]
 .RB [ \-p ]
-.RB [ \-c ]
 .RB [ \-z ]
 .RB [ \-o
 .IR offset ]
@@ -14,8 +14,7 @@ fallocate \- preallocate or deallocate space to a file
 .IR length
 .I filename
 .PP
-.B fallocate
-.RB \-d
+.B fallocate \-d
 .RB [ \-o
 .IR offset ]
 .RB [ \-l
@@ -24,28 +23,57 @@ fallocate \- preallocate or deallocate space to a file
 .SH DESCRIPTION
 .B fallocate
 is used to manipulate the allocated disk space for a file, either to deallocate
-or preallocate it. For filesystems which support the fallocate system call,
+or preallocate it.  For filesystems which support the fallocate system call,
 preallocation is done quickly by allocating blocks and marking them as
-uninitialized, requiring no IO to the data blocks. This is much faster than
+uninitialized, requiring no IO to the data blocks.  This is much faster than
 creating a file by filling it with zeros.
 .PP
 The exit code returned by
 .B fallocate
 is 0 on success and 1 on failure.
-.PP
 .SH OPTIONS
-The \fIlength\fR and \fIoffset\fR arguments may be followed by the multiplicative
-suffixes KiB=1024, MiB=1024*1024, and so on for GiB, TiB, PiB, EiB, ZiB and YiB
-(the "iB" is optional, e.g. "K" has the same meaning as "KiB") or the suffixes
-KB=1000, MB=1000*1000, and so on for GB, TB, PB, EB, ZB and YB.
-
+The \fIlength\fR and \fIoffset\fR
+arguments may be followed by the multiplicative suffixes KiB (=1024),
+MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is
+optional, e.g., "K" has the same meaning as "KiB") or the suffixes
+KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
+.PP
 The options \fB\-\-collapse-range\fP, \fB\-\-dig-holes\fP, \fB\-\-punch-hole\fP and
 \fB\-\-zero-range\fP are mutually exclusive.
-
-.IP "\fB\-n, \-\-keep-size\fP"
+.TP
+.BR \-c , " \-\-collapse-range"
+Removes a byte range from a file, without leaving a hole.  The byte range
+to be collapsed starts at \fIoffset\fP and continues
+for \fIlength\fR bytes.  At the completion of the operation, the contents of
+the file starting at the location \fIoffset\fR+\fIlength\fR will be appended at the
+location \fIoffset\fR, and the file will be \fIlength\fR bytes smaller.  The option
+\fB\-\-keep\-size\fR may not be specified for colapse range operation.
+.sp
+Available since Linux 3.15 for ext4 (only for extent-based files) and XFS.
+.TP
+.BR \-d , " \-\-dig-holes"
+Detect and dig holes.  This makes the file sparse in-place, without using extra
+disk space.  The minimum size of the hole depends on filesystem I/O block size
+(usually 4096 bytes).  Also, when using this option, \fB\-\-keep-size\fP is
+implied.  If no range is specified by \fB\-\-offset\fP and \fB\-\-length\fP,
+then the entire file is analyzed for holes.
+.sp
+You can think of this option as doing a "\fBcp --sparse\fP" and then renaming
+the destination file to the original, without the need for extra disk space.
+.sp
+See \fB\-\-punch-hole\fP for a list of supported filesystems.
+.TP
+.BR \-l , " \-\-length " \fIlength
+Specifies the length of the range, in bytes.
+.TP
+.BR \-n , " \-\-keep-size"
 Do not modify the apparent length of the file.  This may effectively allocate
 blocks past EOF, which can be removed with a truncate.
-.IP "\fB\-p, \-\-punch-hole\fP"
+.TP
+.BR \-o , " \-\-offset " \fIoffset
+Specifies the beginning offset of the range, in bytes.
+.TP
+.BR \-p , " \-\-punch-hole"
 Deallocates space (i.e., creates a hole) in the byte range starting at
 \fIoffset\fP and continuing for \fIlength\fR bytes.  Within the
 specified range, partial filesystem blocks are zeroed, and whole
@@ -53,55 +81,35 @@ filesystem blocks are removed from the file.  After a successful
 call, subsequent reads from this range will return zeroes.  This option
 may not be specified at the same time as  the \fB\-\-zero-range\fP option.
 Also, when using this option, \fB\-\-keep-size\fP is implied.
-
+.sp
 Supported for XFS (since Linux 2.6.38), ext4 (since Linux 3.0),
 Btrfs (since Linux 3.7) and tmpfs (since Linux 3.5).
-.IP "\fB\-d, \-\-dig-holes\fP"
-Detect and dig holes. Makes the file sparse in-place, without using extra disk
-space. The minimal size of the hole depends on filesystem I/O block size
-(usually 4096 bytes). Also, when using this option, \fB\-\-keep-size\fP is
-implied. If no range is specified by \fB\-\-offset\fP and \fB\-\-length\fP,
-then all file is analyzed for holes.
-
-You can think of this as doing a "\fBcp --sparse\fP" and
-renaming the dest file as the original, without the need for extra disk space.
-
-See \fB\-\-punch-hole\fP for list of the supported filesystems.
-.IP "\fB\-c, \-\-collapse-range\fP"
-Removes a byte range from a file, without leaving a hole.  The byte range
-to be collapsed starts at \fIoffset\fP and continues
-for \fIlength\fR bytes.  At the completion of the operation, the contents of
-the file starting at the location offset+length will be appended at the
-location offset, and the file will be \fIlength\fR bytes smaller. The option
-\fB\-\-keep\-size\fR may not be specified for colapse range operation.
-
-Available since Linux 3.15 for ext4 (only for extent-based files) and XFS.
-.IP "\fB\-z, \-\-zero-range\fP"
+.TP
+.BR \-v , " \-\-verbose"
+Enable verbose mode.
+.TP
+.BR \-z , " \-\-zero-range"
 Zeroes space in the byte range starting at \fIoffset\fP and
 continuing for \fIlength\fR bytes.  Within the specified range, blocks are
 preallocated for the regions that span the holes in the file.  After
 a successful call, subsequent reads from this range will return zeroes.
-
+.sp
 Zeroing is done within the filesystem preferably by converting the
 range into unwritten extents.  This approach means that the specified
 range will not be physically zeroed out on the device (except for
 partial blocks at the either end of the range), and I/O is
 (otherwise) required only to update metadata.
-
+.sp
 Option \fB\-\-keep\-size\fP can be specified to prevent file length
 modification.
-
+.sp
 Available since Linux 3.14 for ext4 (only for extent-based files) and XFS.
-.IP "\fB\-o, \-\-offset\fP \fIoffset\fP
-Specifies the beginning offset of the range, in bytes.
-.IP "\fB\-l, \-\-length\fP \fIlength\fP
-Specifies the length of the range, in bytes.
-.IP "\fB\-h, \-\-help\fP"
-Display help text and exit.
-.IP "\fB-v, \-\-verbose"
-Enable verbose mode.
-.IP "\fB-V, \-\-version"
+.TP
+.BR \-V , " \-\-version"
 Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH AUTHORS
 .UR sandeen@redhat.com
 Eric Sandeen
diff --git a/sys-utils/flock.1 b/sys-utils/flock.1
index 6c28a35..276d726 100644
--- a/sys-utils/flock.1
+++ b/sys-utils/flock.1
@@ -61,56 +61,55 @@ The third form uses an open file by its file descriptor \fInumber\fR.
 See the examples below for how that can be used.
 .SH OPTIONS
 .TP
-\fB\-s\fP, \fB\-\-shared\fP
-Obtain a shared lock, sometimes called a read lock.
+.BR \-c , " \-\-command " \fIcommand
+Pass a single \fIcommand\fR, without arguments, to the shell with
+.BR \-c .
 .TP
-\fB\-x\fP, \fB\-e\fP, \fB\-\-exclusive\fP
+.BR \-E , " \-\-conflict-exit-code " \fInumber
+The exit code used when the \fB\-n\fP option is in use, and the
+conflicting lock exists, or the \fB\-w\fP option is in use,
+and the timeout is reached.  The default value is \fB1\fR.
+.TP
+.BR \-e , " \-x" , " \-\-exclusive"
 Obtain an exclusive lock, sometimes called a write lock.  This is the
 default.
 .TP
-\fB\-u\fP, \fB\-\-unlock\fP
-Drop a lock.  This is usually not required, since a lock is automatically
-dropped when the file is closed.  However, it may be required in special
-cases, for example if the enclosed command group may have forked a background
-process which should not be holding the lock.
-.TP
-\fB\-n\fP, \fB\-\-nb\fP, \fB\-\-nonblock\fP
+.BR \-n , " \-\-nb" , " \-\-nonblock"
 Fail rather than wait if the lock cannot be
 immediately acquired.
 See the
 .B \-E
 option for the exit code used.
 .TP
-\fB\-w\fP, \fB\-\-wait\fP, \fB\-\-timeout\fP \fIseconds\fP
-Fail if the lock cannot be acquired within
-.IR seconds .
-Decimal fractional values are allowed.
-See the
-.B \-E
-option for the exit code used.
-.TP
-\fB\-o\fP, \fB\-\-close\fP
+.BR \-o , " \-\-close"
 Close the file descriptor on which the lock is held before executing
 .IR command .
 This is useful if
 .I command
 spawns a child process which should not be holding the lock.
 .TP
-\fB\-E\fP, \fB\-\-conflict\-exit\-code\fP \fInumber\fP
-The exit code used when the \fB\-n\fP option is in use, and the
-conflicting lock exists, or the \fB\-w\fP option is in use,
-and the timeout is reached.  The default value is 1.
+.BR \-s , " \-\-shared"
+Obtain a shared lock, sometimes called a read lock.
 .TP
-\fB\-c\fP, \fB\-\-command\fP \fIcommand\fP
-Pass a single
-.IR command ,
-without arguments, to the shell with
-.BR -c .
+.BR \-u , " \-\-unlock"
+Drop a lock.  This is usually not required, since a lock is automatically
+dropped when the file is closed.  However, it may be required in special
+cases, for example if the enclosed command group may have forked a background
+process which should not be holding the lock.
 .TP
-\fB\-h\fP, \fB\-\-help\fP
-Display help text and exit.
-.IP "\fB\-V, \-\-version\fP"
+.BR \-w , " \-\-wait" , " \-\-timeout " \fIseconds
+Fail if the lock cannot be acquired within
+.IR seconds .
+Decimal fractional values are allowed.
+See the
+.B \-E
+option for the exit code used.
+.TP
+.BR \-V , " \-\-version"
 Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH EXAMPLES
 .TP
 shell1> flock /tmp -c cat
diff --git a/sys-utils/ipcmk.1 b/sys-utils/ipcmk.1
index f79a717..48e34bf 100644
--- a/sys-utils/ipcmk.1
+++ b/sys-utils/ipcmk.1
@@ -14,7 +14,7 @@ and semaphore arrays.
 .TP
 Resources can be specified with these options:
 .TP
-.BR \-M , " \-\-shmem \fIsize\fR"
+.BR \-M , " \-\-shmem " \fIsize
 Create a shared memory segment of
 .I size
 bytes.
@@ -22,20 +22,20 @@ bytes.
 .BR \-Q , " \-\-queue"
 Create a message queue.
 .TP
-.BR \-S , " \-\-semaphore \fInumber\fR"
+.BR \-S , " \-\-semaphore " \fInumber
 Create a semaphore array with
 .I number
 of elements.
 .PP
 Other options are:
 .TP
-.BR \-p , " \-\-mode \fImode\fR"
+.BR \-p , " \-\-mode " \fImode
 Access permissions for the resource.  Default is 0644.
 .TP
-\fB\-V\fR, \fB\-\-version\fR
+.BR \-V , " \-\-version"
 Display version information and exit.
 .TP
-\fB\-h\fR, \fB\-\-help\fR
+.BR \-h , " \-\-help"
 Display help text and exit.
 .PP
 .SH "SEE ALSO"
diff --git a/sys-utils/ipcrm.1 b/sys-utils/ipcrm.1
index bdec3b8..6f58d0f 100644
--- a/sys-utils/ipcrm.1
+++ b/sys-utils/ipcrm.1
@@ -37,49 +37,55 @@ with objects specified either by key or by identifier (see below).
 Both keys and identifiers may be specified in decimal, hexadecimal
 (specified with an initial '0x' or '0X'), or octal (specified with
 an initial '0').
+.PP
+The details of the removes are described in
+.BR shmctl (2),
+.BR msgctl (2),
+and
+.BR semctl (2).
+The identifiers and keys can be found by using
+.BR ipcs (1).
 .SH OPTIONS
 .TP
-\fB\-M\fR, \fB\-\-shmem\-key\fR \fIshmkey\fR
+\fB-a\fR, \fB\-\-all\fR [\fBshm\fR] [\fBmsg\fR] [\fBsem\fR]
+Remove all resources.  When an option argument is provided, the removal is
+performed only for the specified resource types.  \fIWarning!\fR  Do not use
+.B \-a
+if you are unsure how the software using the resources might react to missing
+objects.  Some programs create these resources at startup and may not have
+any code to deal with an unexpected disappearance.
+.TP
+.BR \-M , " \-\-shmem-key " \fIshmkey
 Remove the shared memory segment created with
 .I shmkey
 after the last detach is performed.
 .TP
-\fB\-m\fR, \fB\-\-shmem\-id\fR \fIshmid\fR
+.BR \-m , " \-\-shmem-id " \fIshmid
 Remove the shared memory segment identified by
 .I shmid
 after the last detach is performed.
 .TP
-\fB\-Q\fR, \fB\-\-queue\-key\fR \fImsgkey\fR
+.BR \-Q , " \-\-queue-key " \fImsgkey
 Remove the message queue created with
 .IR msgkey .
 .TP
-\fB\-q\fR, \fB\-\-queue\-id\fR \fImsgid\fR
+.BR \-q , " \-\-queue-id " \fImsgid
 Remove the message queue identified by
 .IR msgid .
 .TP
-\fB\-S\fR, \fB\-\-semaphore\-key\fR \fIsemkey\fR
+.BR \-S , " \-\-semaphore-key " \fIsemkey
 Remove the semaphore created with
 .IR semkey .
 .TP
-\fB\-s\fR, \fB\-\-semaphore\-id\fR \fIsemid\fR
+.BR \-s , " \-\-semaphore-id " \fIsemid
 Remove the semaphore identified by
 .IR semid .
 .TP
-\fB-a\fR, \fB\-\-all\fR [\fBshm\fR] [\fBmsg\fR] [\fBsem\fR]
-Remove all resources.  When an option argument is provided, the removal is
-performed only for the specified resource types.  \fIWarning!\fR  Do not use
-.B \-a
-if you are unsure how the software using the resources might react to missing
-objects.  Some programs create these resources at startup and may not have
-any code to deal with an unexpected disappearance.
-.LP
-The details of the removes are described in
-.BR shmctl (2),
-.BR msgctl (2),
-and
-.BR semctl (2).
-The identifiers and keys can be found by using
-.BR ipcs (1).
+.BR \-V , " \-\-version"
+Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH NOTES
 In its first Linux implementation, \fBipcrm\fR used the deprecated syntax
 shown in the second line of the
diff --git a/sys-utils/renice.1 b/sys-utils/renice.1
index 5a4fcab..ec505bf 100644
--- a/sys-utils/renice.1
+++ b/sys-utils/renice.1
@@ -72,11 +72,11 @@ Interpret the succeeding arguments as process IDs
 .BR \-u , " \-\-user
 Interpret the succeeding arguments as usernames or UIDs.
 .TP
-.BR \-h , " \-\-help"
-Display help text and exit.
-.TP
 .BR \-V , " \-\-version"
 Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH EXAMPLES
 The following command would change the priority of the processes with
 PIDs 987 and 32, plus all processes owned by the users daemon and root:
diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index f627aeb..2a10424 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -11,28 +11,17 @@ Sets or queries various Linux privilege settings that are inherited across
 .BR execve (2).
 .SH OPTION
 .TP
-\fB\-d\fR, \fB\-\-dump\fR
+.B \-\-clear\-groups
+Clear supplementary groups.
+.TP
+.BR \-d , " \-\-dump"
 Dump current privilege state.  Can be specified more than once to show extra,
 mostly useless, information.  Incompatible with all other options.
 .TP
-\fB\-\-no\-new\-privs\fR
-Set the
-.I no_new_privs
-bit.  With this bit set,
-.BR execve (2)
-will not grant new privileges.  For example, the setuid and setgid bits as well
-as file capabilities will be disabled.  (Executing binaries with these bits set
-will still work, but they will not gain privileges.  Certain LSMs, especially
-AppArmor, may result in failures to execute certain programs.)  This bit is
-inherited by child processes and cannot be unset.  See
-.BR prctl (2)
-and
-.IR Documentation/\:prctl/\:no_\:new_\:privs.txt
-in the Linux kernel source.
-.IP
-The no_new_privs bit is supported since Linux 3.5.
+.B \-\-groups \fIgroup\fR...
+Set supplementary groups.  The argument is a comma-separated list.
 .TP
-.B \-\-inh\-caps \fR(\fB+\fR|\fB\-\fR)\fIcap\fR... or \fB\-\-bounding\-set \fR(\fB+\fR|\fB\-\fR)\fIcap\fR...
+.BR \-\-inh-caps " (" + | \- ) \fIcap "...  or  " \-\-bounding\-set " (" + | \- ) \fIcap ...
 Set the inheritable capabilities or the capability bounding set.  See
 .BR capabilities (7).
 The argument is a comma-separated list of
@@ -51,47 +40,58 @@ and the current bounding set for
 If you drop something from the bounding set without also dropping it from the
 inheritable set, you are likely to become confused.  Do not do that.
 .TP
+.B \-\-keep\-groups
+Preserve supplementary groups.  Only useful in conjunction with
+.BR \-\-rgid ,
+.BR \-\-egid ", or"
+.BR \-\-regid .
+.TP
 .BR \-\-list\-caps
 List all known capabilities.  This option must be specified alone.
 .TP
-\fB\-\-ruid\fR \fIuid\fR, \fB\-\-euid\fR \fIuid\fR, \fB\-\-reuid\fR \fIuid\fR
+.B \-\-no-new-privs
+Set the
+.I no_new_privs
+bit.  With this bit set,
+.BR execve (2)
+will not grant new privileges.  For example, the setuid and setgid bits as well
+as file capabilities will be disabled.  (Executing binaries with these bits set
+will still work, but they will not gain privileges.  Certain LSMs, especially
+AppArmor, may result in failures to execute certain programs.)  This bit is
+inherited by child processes and cannot be unset.  See
+.BR prctl (2)
+and
+.IR Documentation/\:prctl/\:no_\:new_\:privs.txt
+in the Linux kernel source.
+.sp
+The no_new_privs bit is supported since Linux 3.5.
+.TP
+.BI \-\-rgid " gid\fR, " \-\-egid " gid\fR, " \-\-regid " gid"
+Set the real, effective, or both gids.  The \fIgid\fR argument can be
+given as textual group name.
+.sp
+For safety, you must specify one of
+.BR \-\-clear-groups ,
+.BR \-\-groups ", or"
+.BR \-\-keep-groups
+if you set any primary
+.IR gid .
+.TP
+.BI \-\-ruid " uid\fR, " \-\-euid " uid\fR, " \-\-reuid " uid"
 Set the real, effective, or both uids.  The \fIuid\fR argument can be
 given as textual login name.
-.IP
-Setting
+.sp
+Setting a
 .I uid
 or
 .I gid
 does not change capabilities, although the exec call at the end might change
 capabilities.  This means that, if you are root, you probably want to do
 something like:
-.IP
-\-\-reuid=1000 \-\-regid=1000 \-\-caps=\-all
-.TP
-\fB\-\-rgid\fR \fIgid\fR, \fB\-\-egid\fR \fIgid\fR, \fB\-\-regid\fR \fIgid\fR
-Set the real, effective, or both gids.  The \fIgid\fR argument can be
-given as textual group name.
-.IP
-For safety, you must specify one of
-.BR \-\-keep\-groups ,
-.BR \-\-clear\-groups ", or"
-.B \-\-groups
-if you set any primary
-.IR gid .
-.TP
-.B \-\-clear\-groups
-Clear supplementary groups.
-.TP
-.B \-\-keep\-groups
-Preserve supplementary groups.  Only useful in conjunction with
-.BR \-\-rgid ,
-.BR \-\-egid ", or"
-.BR \-\-regid .
-.TP
-.B \-\-groups \fIgroup\fR...
-Set supplementary groups.  The argument is a comma-separated list.
+.sp
+.B "        setpriv \-\-reuid=1000 \-\-regid=1000 \-\-caps=\-all"
 .TP
-.B \-\-securebits \fR(\fB+\fR|\fB\-\fR)\fIsecurebit\fR...
+.BR \-\-securebits " (" + | \- ) \fIsecurebit ...
 Set or clear securebits.  The argument is a comma-separated list.
 The valid securebits are
 .IR noroot ,
@@ -105,7 +105,7 @@ is cleared by
 .BR execve (2)
 and is therefore not allowed.
 .TP
-\fB\-\-selinux\-label\fR \fIlabel\fR
+.BI \-\-selinux-label " label"
 Request a particular SELinux transition (using a transition on exec, not
 dyntrans).  This will fail and cause
 .BR setpriv (1)
@@ -117,7 +117,7 @@ conjunction with
 This is similar to
 .BR runcon (1).
 .TP
-\fB\-\-apparmor\-profile\fR \fIprofile\fR
+.BI \-\-apparmor-profile " profile"
 Request a particular AppArmor profile (using a transition on exec).  This will
 fail and cause
 .BR setpriv (1)
@@ -125,10 +125,10 @@ to abort if AppArmor is not in use, and the transition may be ignored or cause
 .BR execve (2)
 to fail at AppArmor's whim.
 .TP
-\fB\-V\fR, \fB\-\-version\fR
+.BR \-V , " \-\-version"
 Display version information and exit.
 .TP
-\fB\-h\fR, \fB\-\-help\fR
+.BR \-h , " \-\-help"
 Display help text and exit.
 .SH NOTES
 If applying any specified option fails,
diff --git a/sys-utils/setsid.1 b/sys-utils/setsid.1
index 70e5079..7a30587 100644
--- a/sys-utils/setsid.1
+++ b/sys-utils/setsid.1
@@ -6,8 +6,9 @@
 setsid \- run a program in a new session
 .SH SYNOPSIS
 .B setsid
+[options]
 .I program
-.RI [ argument ...]
+.RI [ arguments ]
 .SH DESCRIPTION
 .B setsid
 runs a program in a new session.
@@ -20,6 +21,12 @@ Set the controlling terminal to the current one.
 Wait for the execution of the program to end, and return the exit value of
 this program as the return value of
 .BR setsid .
+.TP
+.BR \-V , " \-\-version"
+Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH "SEE ALSO"
 .BR setsid (2)
 .SH AUTHOR
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 9342262..1aa9bcb 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -48,9 +48,6 @@ The process will have a distinct set of UIDs, GIDs and capabilities.
 See \fBclone\fR(2) for the exact semantics of the flags.
 .SH OPTIONS
 .TP
-.BR \-h , " \-\-help"
-Display help text and exit.
-.TP
 .BR \-i , " \-\-ipc"
 Unshare the IPC namespace.
 .TP
@@ -88,6 +85,12 @@ conveniently gain capabilities needed to manage various aspects of the newly cre
 namespaces (such as configuring interfaces in the network namespace or mounting filesystems in
 the mount namespace) even when run unprivileged.  As a mere convenience feature, it does not support
 more sophisticated use cases, such as mapping multiple ranges of UIDs and GIDs.
+.TP
+.BR \-V , " \-\-version"
+Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH SEE ALSO
 .BR unshare (2),
 .BR clone (2),
-- 
1.7.0.4

