Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:53670 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751576AbaGOVHt (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Jul 2014 17:07:49 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/3] docs: bring some more man pages closer to standard formatting
Date: Tue, 15 Jul 2014 23:07:38 +0200
Message-Id: <1405458458-13966-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1405458458-13966-1-git-send-email-bensberg@justemail.net>
References: <1405458458-13966-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/dmesg.1 |   52 +++++++++++++++++++++++++++---------------------
 sys-utils/eject.1 |   56 +++++++++++++++++++++++++++-------------------------
 sys-utils/flock.1 |   44 ++++++++++++++++++++++------------------
 3 files changed, 82 insertions(+), 70 deletions(-)

diff --git a/sys-utils/dmesg.1 b/sys-utils/dmesg.1
index c4c64df..86d35df 100644
--- a/sys-utils/dmesg.1
+++ b/sys-utils/dmesg.1
@@ -5,41 +5,47 @@
 dmesg \- print or control the kernel ring buffer
 .SH SYNOPSIS
 .B dmesg
-.RB [ options ]
+[options]
 .sp
-dmesg \-\-clear
+.B dmesg \-\-clear
 .br
-dmesg \-\-read-clear [options]
+.BR "dmesg \-\-read-clear " [options]
 .br
-dmesg \-\-console-level level
+.BI "dmesg \-\-console-level " level
 .br
-dmesg \-\-console-on
+.B dmesg \-\-console-on
 .br
-dmesg \-\-console-off
+.B dmesg \-\-console-off
 .SH DESCRIPTION
 .B dmesg
 is used to examine or control the kernel ring buffer.
 .PP
 The default action is to read all messages from the kernel ring buffer.
 .SH OPTIONS
-The \-\-clear, \-\-read-clear, \-\-console-on, \-\-console-off and
-\-\-console-level options are mutually exclusive.
+The
+.BR \-\-clear ,
+.BR \-\-read-clear ,
+.BR \-\-console-on ,
+.BR \-\-console-off ,
+and
+.B \-\-console-level
+options are mutually exclusive.
 .PP
 .IP "\fB\-C\fR, \fB\-\-clear\fR"
 Clear the ring buffer.
 .IP "\fB\-c\fR, \fB\-\-read-clear\fR"
 Clear the ring buffer after first printing its contents.
 .IP "\fB\-D\fR, \fB\-\-console-off\fR"
-Disable printing messages to the console.
+Disable the printing of messages to the console.
 .IP "\fB\-d\fR, \fB\-\-show-delta\fR"
 Display the timestamp and the time delta spent between messages.  If used
 together with
 .B \-\-notime
 then only the time delta without the timestamp is printed.
-.IP "\fB\-e\fR, \fB\-\-reltime\fR"
-Display the local time and the delta in human-readable format.
 .IP "\fB\-E\fR, \fB\-\-console-on\fR"
 Enable printing messages to the console.
+.IP "\fB\-e\fR, \fB\-\-reltime\fR"
+Display the local time and the delta in human-readable format.
 .IP "\fB\-F\fR, \fB\-\-file \fIfile\fR"
 Read the messages from the given
 .IR file .
@@ -49,12 +55,12 @@ Restrict output to the given (comma-separated)
 of facilities.  For example:
 .PP
 .RS 14
-dmesg \-\-facility=daemon
+.B dmesg \-\-facility=daemon
 .RE
 .IP
 will print messages from system daemons only.  For all supported facilities
-see
-.B dmesg \-\-help
+see the
+.B \-\-help
 output.
 .IP "\fB\-H\fR, \fB\-\-human\fR"
 Enable human-readable output.  See also \fB\-\-color\fR, \fB\-\-reltime\fR
@@ -66,18 +72,18 @@ Print kernel messages.
 .IP "\fB\-L\fR, \fB\-\-color\fR[=\fIwhen\fR]"
 Colorize important messages (enabled by default).  The optional argument \fIwhen\fP
 can be \fBauto\fR, \fBnever\fR or \fBalways\fR.  If the \fIwhen\fR argument is omitted,
-then it defaults to \fBauto\fR.
+it defaults to \fBauto\fR.
 .IP  "\fB\-l\fR, \fB\-\-level \fIlist\fR"
 Restrict output to the given (comma-separated)
 .I list
 of levels.  For example:
 .PP
 .RS 14
-dmesg \-\-level=err,warn
+.B dmesg \-\-level=err,warn
 .RE
 .IP
-will print error and warning messages only.  For all supported levels see
-.B dmesg \-\-help
+will print error and warning messages only.  For all supported levels see the
+.B \-\-help
 output.
 .IP "\fB\-n\fR, \fB\-\-console-level \fIlevel\fR
 Set the
@@ -85,8 +91,8 @@ Set the
 at which printing of messages is done to the console.  The
 .I level
 is a level number or abbreviation of the level name.  For all supported
-levels see
-.B dmesg \-\-help
+levels see the
+.B \-\-help
 output.
 .sp
 For example,
@@ -179,11 +185,11 @@ format has the same issue as
 the time may be inaccurate when a system is suspended and resumed.
 .SH COLORS
 Implicit coloring can be disabled by an empty file \fI/etc/terminal-colors.d/dmesg.disable\fR.
-
 See
 .BR terminal-colors.d (5)
-for more details about colorization configuration. The logical color names
-support by
+for more details about colorization configuration.
+.PP
+The logical color names supported by
 .B dmesg
 are:
 .TP
diff --git a/sys-utils/eject.1 b/sys-utils/eject.1
index 1acc3b3..c307c25 100644
--- a/sys-utils/eject.1
+++ b/sys-utils/eject.1
@@ -9,33 +9,33 @@
 eject \- eject removable media
 .SH SYNOPSIS
 .B eject
-.RB [ options ]
+[options]
 .IR device | mountpoint
 .SH DESCRIPTION
-.B Eject
+.B eject
 allows removable media (typically a CD-ROM, floppy disk, tape, JAZ, ZIP or USB
 disk) to be ejected under software control.  The command can also control some
 multi-disc CD-ROM changers, the auto-eject feature supported by some devices,
 and close the disc tray of some CD-ROM drives.
 .PP
 The device corresponding to \fIdevice\fP or \fImountpoint\fP is ejected.  If no
-name is specified, the default name /dev/cdrom is used. The device may be
+name is specified, the default name \fB/dev/cdrom\fR is used.  The device may be
 addressed by device name (e.g. 'sda'), device path (e.g. '/dev/sda'),
-UUID=<uuid> or LABEL=<label> tags.
+UUID=\fIuuid\fR or LABEL=\fIlabel\fR tags.
 .PP
 There are four different methods of ejecting, depending on whether the device
-is a CD-ROM, SCSI device, removable floppy, or tape.  By default eject tries
+is a CD-ROM, SCSI device, removable floppy, or tape.  By default \fBeject\fR tries
 all four methods in order until it succeeds.
 .PP
-If device partition is specified, the whole-disk device is used.  If the device
+If a device partition is specified, the whole-disk device is used.  If the device
 or a device partition is currently mounted, it is unmounted before ejecting.
 .SH OPTIONS
-.IP "\fB\-a, \-\-auto \fIon|off\fP"
+.IP "\fB\-a\fR, \fB\-\-auto on\fR|\fBoff\fR"
 This option controls the auto-eject mode, supported by some devices.  When
 enabled, the drive automatically ejects when the device is closed.
 .IP "\fB\-c, \-\-changerslot \fIslot\fP"
 With this option a CD slot can be selected from an ATAPI/IDE CD-ROM changer.
-Linux 2.0 or higher is required to use this feature. The CD-ROM drive can not
+Linux 2.0 or higher is required to use this feature.  The CD-ROM drive cannot
 be in use (mounted data CD or playing a music CD) for a change request to work.
 Please also note that the first slot of the changer is referred to as 0, not 1.
 .IP "\fB\-d, \-\-default\fP"
@@ -47,24 +47,24 @@ disk eject command.
 Force eject, don't check device type.
 .IP "\fB\-h, \-\-help\fP"
 Display help text and exit.
-.IP "\fB\-i, \-\-manualeject \fIon|off\fP"
+.IP "\fB\-i\fR, \fB\-\-manualeject on\fR|\fBoff\fR"
 This option controls locking of the hardware eject button.  When enabled, the
 drive will not be ejected when the button is pressed.  This is useful when you
 are carrying a laptop in a bag or case and don't want it to eject if the button
 is inadvertently pressed.
 .IP "\fB\-p, \-\-proc\fP"
-This option allow you to use /proc/mounts instead /etc/mtab. It also passes the
-\-n option to \fBumount\fR(1).
+This option allows you to use /proc/mounts instead /etc/mtab.  It also passes the
+\fB\-n\fR option to \fBumount\fR(1).
 .IP "\fB\-q, \-\-tape\fP"
 This option specifies that the drive should be ejected using a tape drive
 offline command.
 .IP "\fB\-m, \-\-no-unmount\fP"
 The option tells eject to not try to unmount at all.
 .IP "\fB\-M, \-\-no-partitions-unmount\fP"
-The option tells eject to not try to unmount another partitions on partitioned
-devices. If another partition is mounted the program will not attempt to eject
-the media. It will attempt to unmount only mountpoint or mounted device given
-on eject command line.
+The option tells eject to not try to unmount other partitions on partitioned
+devices.  If another partition is still mounted, the program will not attempt
+to eject the media.  It will attempt to unmount only the device or mountpoint
+given on the command line.
 .IP "\fB\-n, \-\-noop\fP"
 With this option the selected device is displayed but no action is performed.
 .IP "\fB\-t, \-\-trayclose\fP"
@@ -84,24 +84,25 @@ Run in verbose mode; more information is displayed about what the command is
 doing.
 .IP "\fB\-V, \-\-version\fP"
 Display version information and exit.
-.IP "\fB\-x, \-\-cdspeed \fI<speed>\fP"
-With this option the drive is given a CD-ROM select speed command.  The speed
+.IP "\fB\-x, \-\-cdspeed \fIspeed\fP"
+With this option the drive is given a CD-ROM select speed command.  The
+.I speed
 argument is a number indicating the desired speed (e.g. 8 for 8X speed), or 0
 for maximum data rate.  Not all devices support this command and you can only
 specify speeds that the drive is capable of.  Every time the media is changed
-this option is cleared.  This option can be used alone, or with the \-t and \-c
-options.
+this option is cleared.  This option can be used alone, or with the
+\fB\-t\fR and \fB\-c\fR options.
 .IP "\fB\-X, \-\-listspeed\fP" 
 With this option the CD-ROM drive will be probed to detect the available
 speeds.  The output is a list of speeds which can be used as an argument of the
-\-x option.  This only works with Linux 2.6.13 or higher, on previous versions
-solely the maximum speed will be reported.  Also note that some drive may not
+\fB\-x\fR option.  This only works with Linux 2.6.13 or higher, on previous versions
+solely the maximum speed will be reported.  Also note that some drives may not
 correctly report the speed and therefore this option does not work with them.
 .SH EXIT STATUS
 Returns 0 if operation was successful, 1 if operation failed or command syntax
 was not valid.
 .SH NOTES
-.B Eject
+.B eject
 only works with devices that support one or more of the four methods of
 ejecting.  This includes most CD-ROM drives (IDE, SCSI, and proprietary), some
 SCSI tape drives, JAZ drives, ZIP drives (parallel port, SCSI, and IDE
@@ -113,11 +114,12 @@ device and not the
 .B eject
 program itself.
 .PP
-The \-r, \-s, \-f, and \-q options allow controlling which methods are used to
+The \fB\-r\fR, \fB\-s\fR, \fB\-f\fR, and \fB\-q\fR options allow controlling
+which methods are used to
 eject.  More than one method can be specified.  If none of these options are
 specified, it tries all four (this works fine in most cases).
 .PP
-.B Eject
+.B eject
 may not always be able to determine if the device is mounted (e.g. if it has
 several names).  If the device name is a symbolic link,
 .B eject
@@ -126,9 +128,9 @@ will follow the link and use the device that it points to.
 If
 .B eject
 determines that the device can have multiple partitions, it will attempt to
-unmount all mounted partitions of the device before ejecting (see
---no-partitions-unmount). If an unmount fails, the program will not attempt to
-eject the media.
+unmount all mounted partitions of the device before ejecting (see also
+\fB--no-partitions-unmount\fR).  If an unmount fails, the program will not
+attempt to eject the media.
 .PP
 You can eject an audio CD.  Some CD-ROM drives will refuse to open the tray if
 the drive is empty.  Some devices do not support the tray close command.
diff --git a/sys-utils/flock.1 b/sys-utils/flock.1
index c245eda..6c28a35 100644
--- a/sys-utils/flock.1
+++ b/sys-utils/flock.1
@@ -24,37 +24,41 @@
 .\"   OTHER DEALINGS IN THE SOFTWARE.
 .\"
 .\" -----------------------------------------------------------------------
-.TH FLOCK 1 "September 2011" "util-linux" "User Commands"
+.TH FLOCK 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
 flock \- manage locks from shell scripts
 .SH SYNOPSIS
 .B flock
-[options] <file|directory> <command> [command args]
+[options]
+.IR file | "directory command " [ arguments ]
 .br
 .B flock
-[options] <file|directory> -c <command>
+[options]
+.IR file | directory
+.BI \-c " command"
 .br
 .B flock
-[options] <file descriptor number>
+.RI [options] " number"
 .SH DESCRIPTION
 .PP
 This utility manages
 .BR flock (2)
-locks from within shell scripts or the command line.
+locks from within shell scripts or from the command line.
 .PP
-The first and second forms wrap the lock around the executing a command, in
-a manner similar to
+The first and second of the above forms wrap the lock around the execution of a
+.IR command ,
+in a manner similar to
 .BR su (1)
 or
 .BR newgrp (1).
-It locks a specified file or directory, which is created (assuming
-appropriate permissions), if it does not already exist.  By default, if the
+They lock a specified \fIfile\fR or \fIdirectory\fR, which is created (assuming
+appropriate permissions) if it does not already exist.  By default, if the
 lock cannot be immediately acquired,
 .B flock
 waits until the lock is available.
 .PP
-The third form uses open file by file descriptor number.  See examples how
-that can be used.
+The third form uses an open file by its file descriptor \fInumber\fR.
+See the examples below for how that can be used.
 .SH OPTIONS
 .TP
 \fB\-s\fP, \fB\-\-shared\fP
@@ -74,7 +78,7 @@ process which should not be holding the lock.
 Fail rather than wait if the lock cannot be
 immediately acquired.
 See the
-.I \-E
+.B \-E
 option for the exit code used.
 .TP
 \fB\-w\fP, \fB\-\-wait\fP, \fB\-\-timeout\fP \fIseconds\fP
@@ -82,20 +86,20 @@ Fail if the lock cannot be acquired within
 .IR seconds .
 Decimal fractional values are allowed.
 See the
-.I \-E
+.B \-E
 option for the exit code used.
 .TP
 \fB\-o\fP, \fB\-\-close\fP
 Close the file descriptor on which the lock is held before executing
-.BR command\ .
+.IR command .
 This is useful if
-.B command
+.I command
 spawns a child process which should not be holding the lock.
 .TP
 \fB\-E\fP, \fB\-\-conflict\-exit\-code\fP \fInumber\fP
 The exit code used when the \fB\-n\fP option is in use, and the
 conflicting lock exists, or the \fB\-w\fP option is in use,
-and the timeout is reached. The default value is 1.
+and the timeout is reached.  The default value is 1.
 .TP
 \fB\-c\fP, \fB\-\-command\fP \fIcommand\fP
 Pass a single
@@ -153,14 +157,14 @@ also sets the FLOCKER env var to the right value so it doesn't run again.
 The command uses
 .B sysexits.h
 return values for everything, except when using either of the options
-.I \-n
+.B \-n
 or
-.I \-w
+.B \-w
 which report a failure to acquire the lock with a return value given by the
-.I \-E
+.B \-E
 option, or 1 by default.
 .PP
-When using the <command> variant, and executing the child worked, then
+When using the \fIcommand\fR variant, and executing the child worked, then
 the exit status is that of the child command.
 .SH AUTHOR
 .UR hpa@zytor.com
-- 
1.7.0.4

