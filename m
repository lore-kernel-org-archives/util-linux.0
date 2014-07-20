Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:61327 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750732AbaGTVP5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 20 Jul 2014 17:15:57 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] docs: bring eight more man pages closer to standard formatting
Date: Sun, 20 Jul 2014 23:15:47 +0200
Message-Id: <1405890948-4884-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1405890948-4884-1-git-send-email-bensberg@justemail.net>
References: <1405890948-4884-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also, for chcpu, the options -c, -d, -e and -g are mutually exclusive,
and for the mode argument the option -p is not optional.  For ldattach,
use the standard options separator ", " instead of the unusual " | ".
And add the missing --version to several of the pages.  Besides, improve
the wording and the consistency of the spacing.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/blkdiscard.8 |   51 ++++++++++--------
 sys-utils/chcpu.8      |   58 +++++++++-----------
 sys-utils/fsfreeze.8   |   45 ++++++++--------
 sys-utils/fstrim.8     |   58 +++++++++++---------
 sys-utils/ldattach.8   |   76 +++++++++++++-------------
 sys-utils/losetup.8    |  140 +++++++++++++++++++++++++++---------------------
 sys-utils/setarch.8    |   45 ++++++++--------
 sys-utils/wdctl.8      |   51 ++++++++++-------
 8 files changed, 279 insertions(+), 245 deletions(-)

diff --git a/sys-utils/blkdiscard.8 b/sys-utils/blkdiscard.8
index e71a093..3c0334f 100644
--- a/sys-utils/blkdiscard.8
+++ b/sys-utils/blkdiscard.8
@@ -1,5 +1,5 @@
 .\" -*- nroff -*-
-.TH BLKDISCARD 8 "October 2012" "util-linux" "System Administration"
+.TH BLKDISCARD 8 "July 2014" "util-linux" "System Administration"
 .SH NAME
 blkdiscard \- discard sectors on a device
 .SH SYNOPSIS
@@ -15,7 +15,7 @@ blkdiscard \- discard sectors on a device
 .B blkdiscard
 is used to discard device sectors.  This is useful for solid-state
 drivers (SSDs) and thinly-provisioned storage.  Unlike
-.BR fstrim (8)
+.BR fstrim (8) ,
 this command is used directly on the block device.
 .PP
 By default,
@@ -33,32 +33,39 @@ The
 .I offset
 and
 .I length
-arguments may be followed by the multiplicative suffixes KiB=1024,
-MiB=1024*1024, and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is
+arguments may be followed by the multiplicative suffixes KiB (=1024),
+MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is
 optional, e.g., "K" has the same meaning as "KiB") or the suffixes
-KB=1000, MB=1000*1000, and so on for GB, TB, PB, EB, ZB and YB.
-.IP "\fB\-h, \-\-help\fP"
-Display help text and exit.
-.IP "\fB\-o, \-\-offset\fP \fIoffset\fP"
-Byte offset in the device from which to discard.  Provided value will be
-aligned to the device sector size.  Default value is zero.
-.IP "\fB\-l, \-\-length\fP \fIlength\fP"
-Number of bytes after starting point to discard.  Provided value will be
-aligned to the device sector size.  If the specified value extends past
+KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
+.TP
+.BR \-o , " \-\-offset \fIoffset"
+Byte offset into the device from which to start discarding.  The provided value
+will be aligned to the device sector size.  The default value is zero.
+.TP
+.BR \-l , " \-\-length \fIlength"
+The number of bytes to discard (counting from the starting point).  The provided value
+will be aligned to the device sector size.  If the specified value extends past
 the end of the device,
 .B blkdiscard
-will stop at the device size boundary.  Default value extends to the end
+will stop at the device size boundary.  The default value extends to the end
 of the device.
-.IP "\fB\-s, \-\-secure\fP"
-Perform secure discard.  Secure discard is the same as regular discard
-except all copies of the discarded blocks possibly created by garbage
-collection must also be erased.  It has to be supported by the device.
-.IP "\fB\-v, \-\-verbose\fP"
-Print aligned
+.TP
+.BR \-s , " \-\-secure"
+Perform a secure discard.  A secure discard is the same as a regular discard
+except that all copies of the discarded blocks that were possibly created by
+garbage collection must also be erased.  This requires support from the device.
+.TP
+.BR \-v , " \-\-verbose"
+Display the aligned values of
 .I offset
 and
-.I length
-arguments.
+.IR length .
+.TP
+.BR \-V , " \-\-version"
+Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH AUTHOR
 .MT lczerner@redhat.com
 Lukas Czerner
diff --git a/sys-utils/chcpu.8 b/sys-utils/chcpu.8
index c3ce86c..9bed8ea 100644
--- a/sys-utils/chcpu.8
+++ b/sys-utils/chcpu.8
@@ -1,18 +1,16 @@
-.TH CHCPU "8" "June 2012" Linux "User Manuals"
+.TH CHCPU 8 "July 2014" "util-linux" "System Administration"
 .SH NAME
 chcpu \- configure CPUs
 .SH SYNOPSIS
-chcpu
-[\-e] [\-d] [\-c] [\-g]
-cpu-list
-.br
-chcpu [\-p] mode
-.br
-chcpu
-\-r
+.B chcpu
+.BR \-c | \-d | \-e | \-g
+.I cpu-list
 .br
-chcpu [\-h] [\-V]
+.B chcpu \-p
+.I mode
 .br
+.B chcpu
+.BR \-r | \-h | \-V
 .SH DESCRIPTION
 .B chcpu
 can modify the state of CPUs.  It can enable or disable CPUs, scan for new
@@ -31,21 +29,24 @@ makes the command applicable to the CPUs with the addresses 0, 5, 7, 9, 10,
 and 11.
 .SH OPTIONS
 .TP
-.BR \-r , " \-\-rescan"
-Trigger a rescan of CPUs.  Use this option on systems that do not
-automatically detect newly attached CPUs.  The Linux kernel then recognizes
-the new CPUs.
-.TP
 .BR \-c , " \-\-configure " \fIcpu-list\fP
-Configure all specified CPUs.  Configuring a CPU means that the hypervisor
+Configure the specified CPUs.  Configuring a CPU means that the hypervisor
 takes a CPU from the CPU pool and assigns it to the virtual hardware on which
 your kernel runs.
 .TP
+.BR \-d , " \-\-disable " \fIcpu-list\fP
+Disable the specified CPUs.  Disabling a CPU means that the kernel sets it
+offline.
+.TP
 .BR \-e , " \-\-enable " \fIcpu-list\fP
-Enable all specified CPUs.  Enabling a CPU means that the kernel sets it
-online.  A CPU must be configured, see
-.BR -c ,
-before it can be enabled.
+Enable the specified CPUs.  Enabling a CPU means that the kernel sets it
+online.  A CPU must be configured, see \fB\-c\fR, before it can be enabled.
+.TP
+.BR \-g , " \-\-deconfigure " \fIcpu-list\fP
+Deconfigure the specified CPUs.  Deconfiguring a CPU means that the
+hypervisor removes the CPU from the virtual hardware on which the Linux
+instance runs and returns it to the CPU pool.  A CPU must be offline, see
+\fB\-d\fR, before it can be deconfigured.
 .TP
 .BR \-p , " \-\-dispatch " \fImode\fP
 Set the CPU dispatching
@@ -65,21 +66,16 @@ The workload is concentrated on few CPUs.
 .RE
 .PD 1
 .TP
-.BR \-d , " \-\-disable " \fIcpu-list\fP
-Disable all specified CPUs.  Disabling a CPU means that the kernel sets it
-offline.
+.BR \-r , " \-\-rescan"
+Trigger a rescan of CPUs.  After a rescan, the Linux kernel recognizes
+the new CPUs.  Use this option on systems that do not
+automatically detect newly attached CPUs.
 .TP
-.BR \-g , " \-\-deconfigure " \fIcpu-list\fP
-Deconfigure all specified CPUs.  Deconfiguring a CPU means that the
-hypervisor removes the CPU from the virtual hardware on which the Linux
-instance runs and returns it to the CPU pool.  A CPU must be offline, see
-\-d, before it can be deconfigured.
+.BR \-V , " \-\-version"
+Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.TP
-.BR \-V , " \-\-version"
-Display version information and exit.
 
 .SH RETURN CODES
 .B chcpu
diff --git a/sys-utils/fsfreeze.8 b/sys-utils/fsfreeze.8
index f57bbd7..364afca 100644
--- a/sys-utils/fsfreeze.8
+++ b/sys-utils/fsfreeze.8
@@ -1,7 +1,7 @@
 .\" -*- nroff -*-
-.TH FSFREEZE 8 "May 2010" "util-linux" "System Administration"
+.TH FSFREEZE 8 "July 2014" "util-linux" "System Administration"
 .SH NAME
-fsfreeze \- suspend access to a filesystem (Linux Ext3/4, ReiserFS, JFS, XFS)
+fsfreeze \- suspend access to a filesystem (Ext3/4, ReiserFS, JFS, XFS)
 .SH SYNOPSIS
 .B fsfreeze
 .BR \--freeze | \--unfreeze
@@ -9,67 +9,66 @@ fsfreeze \- suspend access to a filesystem (Linux Ext3/4, ReiserFS, JFS, XFS)
 
 .SH DESCRIPTION
 .B fsfreeze
-suspends and resumes access to an filesystem
+suspends or resumes access to a filesystem.
 .PP
 .B fsfreeze
-halts new access to the filesystem and creates a stable image on disk.
+halts any new access to the filesystem and creates a stable image on disk.
 .B fsfreeze
-is intended to be used with hardware RAID devices that support the creation 
+is intended to be used with hardware RAID devices that support the creation
 of snapshots.
 .PP
 .B fsfreeze
 is unnecessary for
 .B device-mapper
-devices. The device-mapper (and LVM)
-automatically freezes filesystem on the device when a snapshot creation is requested.
+devices.  The device-mapper (and LVM) automatically freezes a filesystem
+on the device when a snapshot creation is requested.
 For more details see the
 .BR dmsetup (8)
 man page.
 .PP
 The
-.I mount-point
+.I mountpoint
 argument is the pathname of the directory where the filesystem
 is mounted.
 The filesystem must be mounted to be frozen (see
 .BR mount (8)).
 .PP
-Note that access time updates are also suspends if the filesystem is mounted with
-the traditional atime semantics (mount option strictatime, for more details see
+Note that access-time updates are also suspended if the filesystem is mounted with
+the traditional atime behavior (mount option \fBstrictatime\fR, for more details see
 .BR mount (8)).
 
 .SH OPTIONS
-.IP "\fB\-h, \-\-help\fP"
-Display help text and exit.
-.IP "\fB\-f, \-\-freeze\fP"
+.TP
+.BR \-f , " \-\-freeze"
 This option requests the specified a filesystem to be frozen from new
 modifications.  When this is selected, all ongoing transactions in the
 filesystem are allowed to complete, new write system calls are halted, other
 calls which modify the filesystem are halted, and all dirty data, metadata, and
 log information are written to disk.  Any process attempting to write to the
 frozen filesystem will block waiting for the filesystem to be unfrozen.
-
+.sp
 Note that even after freezing, the on-disk filesystem can contain
 information on files that are still in the process of unlinking.
 These files will not be unlinked until the filesystem is unfrozen
 or a clean mount of the snapshot is complete.
-.IP "\fB\-u, \-\-unfreeze\fP
+.TP
+.BR \-u , " \-\-unfreeze"
 This option is used to un-freeze the filesystem and allow operations to
 continue.  Any filesystem modifications that were blocked by the freeze are
 unblocked and allowed to complete.
-.IP "\fB\-V, \-\-version\fP"
+.TP
+.BR \-V , " \-\-version"
 Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH AUTHOR
 .PP
 Written by Hajime Taira.
 .SH NOTES
 .PP
-This man page based on xfs_freeze.
-One of
-.B \-f
-or
-.B \-u
-must be supplied to
-.BR fsfreeze .
+This man page is based on
+.BR xfs_freeze (8).
 .SH SEE ALSO
 .BR mount (8)
 .SH AVAILABILITY
diff --git a/sys-utils/fstrim.8 b/sys-utils/fstrim.8
index ae331e3..73c041d 100644
--- a/sys-utils/fstrim.8
+++ b/sys-utils/fstrim.8
@@ -1,5 +1,5 @@
 .\" -*- nroff -*-
-.TH FSTRIM 8 "November 2010" "util-linux" "System Administration"
+.TH FSTRIM 8 "July 2014" "util-linux" "System Administration"
 .SH NAME
 fstrim \- discard unused blocks on a mounted filesystem
 .SH SYNOPSIS
@@ -10,7 +10,7 @@ fstrim \- discard unused blocks on a mounted filesystem
 .RB [ \-l
 .IR length ]
 .RB [ \-m
-.IR minimum-free-extent ]
+.IR minimum-size ]
 .RB [ \-v ]
 .I mountpoint
 
@@ -32,38 +32,38 @@ is mounted.
 .PP
 Running
 .B fstrim
-more frequently or even using
-.B mount -o discard
-might affect lifetime of the poor quality SSD devices. The usual sufficient
-frequency is once a week for most desktop and server systems. Note that not all
-devices support queued trim, so each trim command incur a performance penalty
-to whatever else might be trying to use the disk at the time.
+frequently, or even using
+.BR "mount -o discard" ,
+might negatively affect the lifetime of poor-quality SSD devices.  For most
+desktop and server systems the sufficient trimming frequency is once a week.
+Note that not all
+devices support a queued trim, so each trim command incurs a performance penalty
+on whatever else might be trying to use the disk at the time.
 
 .SH OPTIONS
-The \fIoffset\fR, \fIlength\fR, and \fIminimum-free-extent\fR arguments may be
-followed by the multiplicative suffixes KiB=1024, MiB=1024*1024, and so on for
-GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is optional, e.g. "K" has the same
-meaning as "KiB") or the suffixes KB=1000, MB=1000*1000, and so on for GB, TB,
-PB, EB, ZB and YB.
+The \fIoffset\fR, \fIlength\fR, and \fIminimum-size\fR arguments may be
+followed by the multiplicative suffixes KiB (=1024),
+MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB"
+is optional, e.g., "K" has the same meaning as "KiB") or the suffixes
+KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
+
 .IP "\fB\-a, \-\-all\fP"
 Trim all mounted filesystems on devices that support the discard operation.
 The other supplied options, like \fB\-\-offset\fR, \fB\-\-length\fR and
 \fB-\-minimum\fR, are applied to all these devices.
 Errors from filesystems that do not support the discard operation are silently
 ignored.
-.IP "\fB\-h, \-\-help\fP"
-Display help text and exit.
 .IP "\fB\-o, \-\-offset\fP \fIoffset\fP"
-Byte offset in filesystem from which to begin searching for free blocks
-to discard.  Default value is zero, starting at the beginning of the
+Byte offset in the filesystem from which to begin searching for free blocks
+to discard.  The default value is zero, starting at the beginning of the
 filesystem.
 .IP "\fB\-l, \-\-length\fP \fIlength\fP"
-Number of bytes after starting point to search for free blocks to discard.
-If the specified value extends past the end of the filesystem,
+The number of bytes (after the starting point) to search for free blocks
+to discard.  If the specified value extends past the end of the filesystem,
 .B fstrim
-will stop at the filesystem size boundary. Default value extends to the end
-of the filesystem.
-.IP "\fB\-m, \-\-minimum\fP \fIminimum-free-extent\fP"
+will stop at the filesystem size boundary.  The default value extends to
+the end of the filesystem.
+.IP "\fB\-m, \-\-minimum\fP \fIminimum-size\fP"
 Minimum contiguous free range to discard, in bytes. (This value is internally
 rounded up to a multiple of the filesystem block size).  Free ranges smaller
 than this will be ignored.  By increasing this value, the fstrim operation
@@ -71,14 +71,14 @@ will complete more quickly for filesystems with badly fragmented freespace,
 although not all blocks will be discarded.  Default value is zero, discard
 every free block.
 .IP "\fB\-v, \-\-verbose\fP"
-Verbose execution. When specified 
+Verbose execution.  With this option
 .B fstrim
 will output the number of bytes passed from the filesystem
-down the block stack to the device for potential discard. This number is a
+down the block stack to the device for potential discard.  This number is a
 maximum discard amount from the storage device's perspective, because
 .I FITRIM
 ioctl called repeated will keep sending the same sectors for discard repeatedly.
-
+.sp
 .B fstrim
 will report the same potential discard bytes each time, but only sectors which
 had been written to between the discards would actually be discarded by the
@@ -88,6 +88,12 @@ LVM setup, etc.  These reductions would not be reflected in fstrim_range.len
 (the
 .B --length
 option).
+.TP
+.BR \-V , " \-\-version"
+Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 
 .SH RETURN CODES
 .IP 0
@@ -101,7 +107,7 @@ some filesystem discards have succeeded, some failed
 .PP
 The command
 .B fstrim --all
-returns 0 (all success), 32 (all failed) or 64 (some failed, some success).
+returns 0 (all succeeded), 32 (all failed) or 64 (some failed, some succeeded).
 
 .SH AUTHOR
 .nf
diff --git a/sys-utils/ldattach.8 b/sys-utils/ldattach.8
index 52bb787..7305a5c 100644
--- a/sys-utils/ldattach.8
+++ b/sys-utils/ldattach.8
@@ -1,15 +1,15 @@
 .\" Copyright 2008 Tilman Schmidt (tilman@imap.cc)
 .\" May be distributed under the GNU General Public License version 2 or later
-.TH LDATTACH 8 "February 2010" "util-linux" "System Administration"
+.TH LDATTACH 8 "July 2014" "util-linux" "System Administration"
 .SH NAME
 ldattach \- attach a line discipline to a serial line
 .SH SYNOPSIS
 .B ldattach
-.RB [ \-dhV78neo12 ]
-.RB [ \-s
-.IR speed ]
+.RB [ \-1278denoVh ]
 .RB [ \-i
 .IR iflag ]
+.RB [ \-s
+.IR speed ]
 .I ldisc device
 .SH DESCRIPTION
 The
@@ -23,18 +23,18 @@ and attaches the line discipline
 to it for processing of the sent and/or received data.
 It then goes into the background keeping the device open so that the
 line discipline stays loaded.
-
+.sp
 The line discipline
 .I ldisc
 may be specified either by name
 or by number.
-
+.sp
 In order to detach the line discipline,
 .BR kill (1)
 the
 .B ldattach
 process.
-
+.sp
 With no arguments,
 .B ldattach
 prints usage information.
@@ -89,48 +89,48 @@ Driver for Siemens Gigaset M101 serial DECT adapter.
 Driver for serial line Pulse Per Second (PPS) source.
 .SH OPTIONS
 .TP
-\fB-d\fP | \fB--debug\fP
-Causes
-.B ldattach
-to stay in the foreground so that it can be interrupted or debugged,
-and to print verbose messages about its progress to the standard error output.
+.BR \-1 , " \-\-onestopbit"
+Set the number of stop bits of the serial line to one.
 .TP
-\fB-h\fP | \fB--help\fP
-Display help text and exit.
+.BR \-2 , " \-\-twostopbits"
+Set the number of stop bits of the serial line to two.
 .TP
-\fB-V\fP | \fB--version\fP
-Display version information and exit.
+.BR \-7 , " \-\-sevenbits"
+Set the character size of the serial line to 7 bits.
 .TP
-\fB-s\fP \fIvalue\fP | \fB--speed\fP \fIvalue\fP
-Set the speed of the serial line to the specified value.
+.BR \-8 , " \-\-eightbits"
+Set the character size of the serial line to 8 bits.
 .TP
-\fB-7\fP | \fB--sevenbits\fP
-Sets the character size of the serial line to 7 bits.
+.BR \-d , " \-\-debug"
+Keep
+.B ldattach
+in the foreground so that it can be interrupted or debugged,
+and to print verbose messages about its progress to standard error output.
 .TP
-\fB-8\fP | \fB--eightbits\fP
-Sets the character size of the serial line to 8 bits.
+.BR \-e , " \-\-evenparity"
+Set the parity of the serial line to even.
 .TP
-\fB-n\fP | \fB--noparity\fP
-Sets the parity of the serial line to none.
+.BR -i , " --iflag " [ \- ] \fIvalue\fR...
+Set the specified bits in the c_iflag word of the serial line.
+The given \fIvalue\fP may be a number or a symbolic name.
+If \fIvalue\fP is prefixed by a minus sign, the specified bits are cleared
+instead.  Several comma-separated values may be given in order to
+set and clear multiple bits.
 .TP
-\fB-e\fP | \fB--evenparity\fP
-Sets the parity of the serial line to even.
+.BR \-n , " \-\-noparity"
+Set the parity of the serial line to none.
 .TP
-\fB-o\fP | \fB--oddparity\fP
-Sets the parity of the serial line to odd.
+.BR \-o , " \-\-oddparity"
+Set the parity of the serial line to odd.
 .TP
-\fB-1\fP | \fB--onestopbit\fP
-Sets the number of stop bits of the serial line to one.
+.BR  \-s , " \-\-speed " \fIvalue
+Set the speed (the baud rate) of the serial line to the specified \fIvalue\fR.
 .TP
-\fB-2\fP | \fB--twostopbits\fP
-Sets the number of stop bits of the serial line to two.
+.BR \-V , " \-\-version"
+Display version information and exit.
 .TP
-\fB-i\fP \fIvalue\fP | \fB--iflag\fP [\fB-\fP]\fIvalue\fP{,...}
-Sets the specified bits in the c_iflag word of the serial line.
-\fIValue\fP may be a number or a symbolic name.
-If \fIvalue\fP is prefixed by a minus sign, clear the specified bits instead.
-Several comma separated \fIvalue\fPs may be given in order to
-set and clear multiple bits.
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH "SEE ALSO"
 .BR inputattach (1),
 .BR ttys (4)
diff --git a/sys-utils/losetup.8 b/sys-utils/losetup.8
index 72990aa..1a67f9f 100644
--- a/sys-utils/losetup.8
+++ b/sys-utils/losetup.8
@@ -1,4 +1,4 @@
-.TH LOSETUP 8 "July 2003" "util-linux" "System Administration"
+.TH LOSETUP 8 "July 2014" "util-linux" "System Administration"
 .SH NAME
 losetup \- set up and control loop devices
 .SH SYNOPSIS
@@ -18,26 +18,26 @@ Get info:
 .IR offset ]
 .sp
 .in -5
-Delete loop:
+Detach a loop device:
 .sp
 .in +5
 .B "losetup \-d"
 .IR loopdev ...
 .sp
 .in -5
-Delete all used loop devices:
+Detach all used loop devices:
 .sp
 .in +5
 .B "losetup \-D"
 .sp
 .in -5
-Print name of first unused loop device:
+Print the name of the first unused loop device:
 .sp
 .in +5
 .B "losetup \-f"
 .sp
 .in -5
-Setup loop device:
+Set up a loop device:
 .sp
 .in +5
 .B losetup
@@ -46,12 +46,12 @@ Setup loop device:
 .RB [ \-\-sizelimit
 .IR size ]
 .in +8
-.RB [ \-rP ]
-.RB { \-f [ \-\-show ]| \fIloopdev\fP }
+.RB [ \-Pr ]
+.RB [ \-\-show ]  " \-f" | \fIloopdev\fP
 .I file
 .sp
 .in -13
-Resize loop device:
+Resize a loop device:
 .sp
 .in +5
 .B "losetup \-c"
@@ -61,78 +61,96 @@ Resize loop device:
 .SH DESCRIPTION
 .B losetup
 is used to associate loop devices with regular files or block devices,
-to detach loop devices and to query the status of a loop device. If only the
+to detach loop devices, and to query the status of a loop device.  If only the
 \fIloopdev\fP argument is given, the status of the corresponding loop
-device is shown. If no option is given, all loop devices are shown.
-
-Note that the old output format (e.g. losetup -a) with comma delimited strings is
-deprecated in favour of the --list output format.
+device is shown.  If no option is given, all loop devices are shown.
+.sp
+Note that the old output format (i.e. \fBlosetup -a\fR) with comma-delimited
+strings is deprecated in favour of the \fB--list\fR output format.
 
 .SH OPTIONS
-+The \fIsize\fR and \fIoffset\fR arguments may be followed by the multiplicative
-+suffixes KiB=1024, MiB=1024*1024, and so on for GiB, TiB, PiB, EiB, ZiB and YiB
-+(the "iB" is optional, e.g. "K" has the same meaning as "KiB") or the suffixes
-+KB=1000, MB=1000*1000, and so on for GB, TB, PB, EB, ZB and YB.
+The \fIsize\fR and \fIoffset\fR
+arguments may be followed by the multiplicative suffixes KiB (=1024),
+MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is
+optional, e.g., "K" has the same meaning as "KiB") or the suffixes
+KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
 
-.IP "\fB\-a, \-\-all\fP"
-show status of all loop devices. Note that not all information are accessible
-for non-root users. See also \fB\-\-list\fP. The old output format (as printed
-without --list) is deprecated.
-.IP "\fB\-c, \-\-set-capacity\fP \fIloopdev\fP
-force loop driver to reread size of the file associated with the specified loop device
-.IP "\fB\-d, \-\-detach\fP \fIloopdev\fP..."
-detach the file or device associated with the specified loop device(s)
-.IP "\fB\-D, \-\-detach-all\fP"
-detach all associated loop devices
-.IP "\fB\-f, \-\-find\fP"
-find the first unused loop device. If a
+.TP
+.BR \-a , " \-\-all"
+Show the status of all loop devices.  Note that not all information is accessible
+for non-root users.  See also \fB\-\-list\fR.  The old output format (as printed
+without \fB--list)\fR is deprecated.
+.TP
+.BR \-c , " \-\-set-capacity " \fIloopdev
+Force the loop driver to reread the size of the file associated with the
+specified loop device.
+.TP
+.BR \-d , " \-\-detach " \fIloopdev\fR...
+Detach the file or device associated with the specified loop device(s).
+.TP
+.BR \-D , " \-\-detach-all"
+Detach all associated loop devices.
+.TP
+.BR \-f , " \-\-find"
+Find the first unused loop device.  If a
 .I file
-argument is present, use this device. Otherwise, print its name
-.IP "\fB\-h, \-\-help\fP"
-print help
+argument is present, use the found device as loop device.
+Otherwise, just print its name.
 .IP "\fB\-j, \-\-associated \fIfile\fP"
-show status of all loop devices associated with given
-.I file
-.IP "\fB\-l, \-\-list"
-if a loop device or the -a option is specified, print default columns for
-either the specified loop device or all loop devices, default is to print info
-about all devices.  See also \fB\-\-output\fP, \fB\-\-noheadings\fP
+Show the status of all loop devices associated with the given
+.IR file .
+.TP
+.BR \-l , " \-\-list"
+If a loop device or the \fB-a\fR option is specified, print the default columns
+for either the specified loop device or all loop devices; the default is to
+print info about all devices.  See also \fB\-\-output\fP, \fB\-\-noheadings\fP
 and \fB\-\-raw\fP.
-.IP "\fB\-n, \fB\-\-noheadings\fP"
-don't print headings for \fB\-\-list\fP output format
-.IP "\fB\-o, \-\-offset \fIoffset\fP"
-the data start is moved \fIoffset\fP bytes into the specified file or
-device
-.IP "\fB\-O, \-\-output \fIcolumns\fP"
-specify which columns are to be printed for the \fB\-\-list\fP output
-.IP "\fB\-\-sizelimit \fIsize\fP"
-the data end is set to no more than \fIsize\fP bytes after the data start
-.IP "\fB\-P, \-\-partscan\fP"
-force kernel to scan partition table on newly created loop device
+.TP
+.BR \-n , " \-\-noheadings"
+Don't print headings for \fB\-\-list\fP output format.
+.TP
+.BR \-o , " \-\-offset " \fIoffset
+The data start is moved \fIoffset\fP bytes into the specified file or device.
+.TP
+.BR \-O , " \-\-output " \fIcolumns
+Specify the columns that are to be printed for the \fB\-\-list\fP output.
+.TP
+.BR \-P , " \-\-partscan"
+Force the kernel to scan the partition table on a newly created loop device.
 .IP "\fB\-\-raw\fP"
-use raw \fB\-\-list\fP output format
-.IP "\fB\-r, \-\-read-only\fP"
-setup read-only loop device
+Use the raw \fB\-\-list\fP output format.
+.TP
+.BR \-r , " \-\-read-only"
+Set up a read-only loop device.
+.IP "\fB\-\-sizelimit \fIsize\fP"
+The data end is set to no more than \fIsize\fP bytes after the data start.
 .IP "\fB\-\-show\fP"
-print device name if the
-.I -f
+Display the name of the assigned loop device if the
+.B \-f
 option and a
 .I file
 argument are present.
-.IP "\fB\-v, \-\-verbose\fP"
-verbose mode
+.TP
+.BR \-v , " \-\-verbose"
+Verbose mode.
+.TP
+.BR \-V , " \-\-version"
+Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 
 .SH ENCRYPTION
-.B Cryptoloop is no longer supported in favor of dm-crypt. For more details see
-.B cryptsetup(8).
+.B Cryptoloop is no longer supported in favor of dm-crypt.
+.B For more details see cryptsetup (8).
 
 .SH RETURN VALUE
 .B losetup
-returns 0 on success, nonzero on failure. When
+returns 0 on success, nonzero on failure.  When
 .B losetup
 displays the status of a loop device, it returns 1 if the device
 is not configured and 2 if an error occurred which prevented
-from determining the status of the device.
+determining the status of the device.
 
 .SH FILES
 .TP
@@ -156,7 +174,7 @@ The following commands can be used as an example of using the loop device.
 # losetup --detach /dev/loop0
 .fi
 .SH AUTHORS
-Karel Zak <kzak@redhat.com>, based on original version from
+Karel Zak <kzak@redhat.com>, based on the original version from
 Theodore Ts'o <tytso@athena.mit.edu>
 .SH AVAILABILITY
 The losetup command is part of the util-linux package and is available from
diff --git a/sys-utils/setarch.8 b/sys-utils/setarch.8
index f8c748f..ad9d4c2 100644
--- a/sys-utils/setarch.8
+++ b/sys-utils/setarch.8
@@ -1,50 +1,43 @@
-.TH SETARCH 8 "September 2011" "util-linux" "System Administration"
+.TH SETARCH 8 "July 2014" "util-linux" "System Administration"
 .SH NAME
 setarch \- change reported architecture in new program environment and set personality flags
 .SH SYNOPSIS
 .B setarch
-.I <arch>
-.RI [ options ]
-.RI [ program
-.RI [ arguments ]]
-.br
-.B arch
-.RI [ options ]
+.I arch
+[options]
 .RI [ program
 .RI [ arguments ]]
+.sp
+.B setarch
+.BR \-\-list | \-h | \-V
 .SH DESCRIPTION
 .B setarch
-This utility currently only affects the output of uname -m. For example, on an AMD64 system, running 'setarch i386 program' will cause 'program' to see
+currently only affects the output of \fBuname -m\fR.
+For example, on an AMD64 system, running 'setarch i386 program' will cause 'program' to see
 .IR i686
-(or other relevant arch) instead of
+instead of
 .IR x86_64
-as machine type. It also allows to set various personality options. The default
+as the machine type.  It also allows to set various personality options.
+The default
 .B program
 is /bin/sh.
 .SH OPTIONS
 .TP
-\fB\-v\fR, \fB\-\-verbose\fR
-Be verbose.
-.TP
-\fB\-h\fR, \fB\-\-help\fR
-Display help text and exit.
-(The help text is also displayed when \fBsetarch\fR receives no arguments.)
-.TP
-\fB\-V\fR, \fB\-\-version\fR
-Display version information and exit.
+\fB\-\-list\fR
+List the architectures that can be set.
 .TP
 \fB\-\-uname\-2.6\fR
 Causes the program to see a kernel version number beginning with 2.6.
 .TP
+.BR \-v , " \-\-verbose"
+Be verbose.
+.TP
 \fB\-3\fR, \fB\-\-3gb\fR
 Specifies that processes should use a maximum of 3GB of address space on systems where it is supported (ADDR_LIMIT_3GB).
 .TP
 \fB\-\-4gb\fR
 Ignored (for backward compatibility only).
 .TP
-\fB\-\-list\fR
-List architectures that can be set.
-.TP
 \fB\-B\fR, \fB\-\-32bit\fR
 Turns on ADDR_LIMIT_32BIT.
 .TP
@@ -71,6 +64,12 @@ Turns on READ_IMPLIES_EXEC.
 .TP
 \fB\-Z\fR, \fB\-\-mmap\-page\-zero\fR
 Turns on MMAP_PAGE_ZERO.
+.TP
+.BR \-V , " \-\-version"
+Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH EXAMPLES
 setarch ppc32 rpmbuild --target=ppc --rebuild foo.src.rpm
 .br
diff --git a/sys-utils/wdctl.8 b/sys-utils/wdctl.8
index 61ba5c3..c2a4282 100644
--- a/sys-utils/wdctl.8
+++ b/sys-utils/wdctl.8
@@ -1,49 +1,58 @@
 .\" wdctl.8 --
 .\" Copyright (C) 2012 Karel Zak <kzak@redhat.com>
 .\" May be distributed under the GNU General Public License
-.TH WDCTL "8" "June 2012" "util-linux" "System Administration"
+.TH WDCTL "8" "July 2014" "util-linux" "System Administration"
 .SH NAME
-wdctl \-
-show hardware watchdog status
+wdctl \- show hardware watchdog status
 .SH SYNOPSIS
 .B wdctl
-.RB [options]
-.RB [device...]
+[options]
+.RI [ device ...]
 .SH DESCRIPTION
 Show hardware watchdog status.  The default device is
 .IR /dev/watchdog .
 If more than one device is specified then the output is separated by
 one blank line.
 .PP
-Note that number of supported watchdog features is hardware specific.
+Note that the number of supported watchdog features is hardware specific.
 .SH OPTIONS
-.IP "\fB\-f\fR, \fB\-\-flags \fIlist\fP"
-Print selected flags only.
-.IP "\fB\-F\fR, \fB\-\-noflags\fP"
+.TP
+.BR \-f , " \-\-flags " \fIlist
+Print only the specified flags.
+.TP
+.BR \-F , " \-\-noflags"
 Do not print information about flags.
-.IP "\fB\-n\fR, \fB\-\-noheadings\fP"
-Do not print a header line for flags table.
-.IP "\fB\-I\fR, \fB\-\-noident\fP"
+.TP
+.BR \-I , " \-\-noident"
 Do not print watchdog identity information.
-.IP "\fB\-T\fR, \fB\-\-notimeouts\fP"
-Do not print watchdog timeouts.
-.IP "\fB\-s\fR, \fB\-\-settimeout \fIseconds\fP"
-Set the watchdog timeout in seconds.
+.TP
+.BR \-n , " \-\-noheadings"
+Do not print a header line for flags table.
 .IP "\fB\-o\fR, \fB\-\-output \fIlist\fP"
 Define the output columns to use in table of watchdog flags.  If no
 output arrangement is specified, then a default set is used.  Use
 .B \-\-help
 to get list of all supported columns.
-.IP "\fB\-O\fR, \fB\-\-oneline\fP"
+.TP
+.BR \-O , " \-\-oneline"
 Print all wanted information on one line in key="value" output format.
-.IP "\fB\-r\fR, \fB\-\-raw\fP"
+.TP
+.BR \-r , " \-\-raw"
 Use the raw output format.
+.TP
+.BR \-s , " \-settimeout " \fIseconds
+Set the watchdog timeout in seconds.
+.TP
+.BR \-T , " \-\-notimeouts"
+Do not print watchdog timeouts.
 .IP "\fB\-x\fR, \fB\-\-flags-only\fP"
 Same as \fB\-I \-T\fP.
-.IP "\fB\-h\fR, \fB\-\-help\fP"
-Display help text and exit.
-.IP "\fB\-V\fR, \fB\-\-version\fP"
+.TP
+.BR \-V , " \-\-version"
 Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH AUTHORS
 .MT kzak@\:redhat\:.com
 Karel Zak
-- 
1.7.0.4

