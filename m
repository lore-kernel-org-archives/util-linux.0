Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:49484 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756215AbaGNUxt (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Jul 2014 16:53:49 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/3] docs: improve wording and formatting of the man page of cfdisk
Date: Mon, 14 Jul 2014 22:53:34 +0200
Message-Id: <1405371216-7774-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.8 |   82 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/disk-utils/cfdisk.8 b/disk-utils/cfdisk.8
index c5fe2b4..6471de6 100644
--- a/disk-utils/cfdisk.8
+++ b/disk-utils/cfdisk.8
@@ -11,7 +11,6 @@
 .\" entire resulting derived work is distributed under the terms of a
 .\" permission notice identical to this one.
 .\"
-.\" " for hilit mode
 .TH CFDISK 8 "March 2014" "util-linux" "System Administration"
 .SH NAME
 cfdisk \- display or manipulate a disk partition table
@@ -22,25 +21,27 @@ cfdisk \- display or manipulate a disk partition table
 .SH DESCRIPTION
 .B cfdisk
 is a curses-based program for partitioning any block device.
-The default device is /dev/sda.
+The default device is
+.BR /dev/sda .
 
 Note that
 .B cfdisk
-provides basic partitioning functionality by a user friendly interface. If you
-need advanced features, use 
-.BR fdisk (8).
+provides basic partitioning functionality with a user-friendly interface.
+If you need advanced features, use
+.BR fdisk (8)
+instead.
 
 Since version 2.25
-.BR cfdisk (8)
-supports MBR (DOS), GPT, SUN and SGI disk labels, but it does not provide any
-functionality in regards to CHS (Cylinder-Head-Sector) addressing. CHS has
-never been important for Linux and this addressing concept does not make any
+.B cfdisk
+supports MBR (DOS), GPT, SUN and SGI disk labels, but no longer provides any
+functionality for CHS (Cylinder-Head-Sector) addressing.  CHS has
+never been important for Linux, and this addressing concept does not make any
 sense for new devices.
 
 Since version 2.25
-.BR cfdisk (8)
-also does not provide a 'print' command. This functionality is provided by
-utils
+.B cfdisk
+also does not provide a 'print' command any more.
+This functionality is provided by the utilities
 .BR partx (8)
 and
 .BR lsblk (8)
@@ -50,29 +51,34 @@ If you want to remove an old partition table from a device, use
 .BR wipefs (8).
 
 .SH OPTIONS
-.IP "\fB\-h, \-\-help\fP"
+.TP
+.BR \-h , " \-\-help"
 Display help text and exit.
-.IP "\fB\-L\fR, \fB\-\-color\fR[=\fIwhen\fR]"
-Colorize output, enabled by default.  The optional argument \fIwhen\fP can be
+.TP
+.BR \-L , " \-\-color" [ = \fIwhen\fR]
+Colorize the output; enabled by default.  The optional argument \fIwhen\fP can be
 \fBauto\fR, \fBnever\fR or \fBalways\fR.  If the \fIwhen\fR argument is omitted,
 it defaults to \fBauto\fR.
-.IP "\fB-V, \-\-version"
+.TP
+.BR \-V , " \-\-version"
 Display version information and exit.
-.IP "\fB-z, \-\-zero"
-Start with in-memory zeroed partition table. This option does not zero the
+.TP
+.BR \-z , " \-\-zero"
+Start with an in-memory zeroed partition table.  This option does not zero the
 partition table on the disk; rather, it simply starts the program without
 reading the existing partition table.
 
 .SH COMMANDS
+The commands for
 .B cfdisk
-commands can be entered by pressing the desired key (pressing
+can be entered by pressing the corresponding key (pressing
 .I Enter
 after the command is not necessary).  Here is a list of the available
 commands:
 .TP
 .B b
 Toggle the bootable flag of the current partition.  This allows you to
-select which primary partition is bootable on the drive. This command may not
+select which primary partition is bootable on the drive.  This command may not
 be available for all partition label types.
 .TP
 .B d
@@ -82,18 +88,18 @@ surrounding the current partition.  A partition already marked as free
 space or marked as unusable cannot be deleted.
 .TP
 .B h
-Print the help screen.
+Show the help screen.
 .TP
 .B n
-Create a new partition from free space. 
+Create a new partition from free space.
 .B cfdisk
-next prompts you for the size of the partition you want to create.
+then prompts you for the size of the partition you want to create.
 The default size is equal to the entire available free space at the current
 position.
 
-The size may be followed by  the  multiplicative suffixes KiB=1024, 
-MiB=1024*1024, and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" 
-is optional, e.g. "K" has the same meaning as  "KiB")
+The size may be followed by a multiplicative suffix: KiB (=1024),
+MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB
+(the "iB" is optional, e.g. "K" has the same meaning as "KiB").
 .TP
 .B q
 Quit the program.  This will exit the program without writing any data to
@@ -112,11 +118,12 @@ the write by entering `yes' or `no'.  If you enter `yes',
 will write the partition table to disk and then tell the kernel to re-read the
 partition table from the disk.
 
-The re-reading of the partition table does not work in some cases.  In such a
-case you need to inform the kernel about new partitions by
-.BR partprobe (8),
-.BR kpartx (8)
-or reboot the system.
+The re-reading of the partition table does not always work.  In such a
+case you need to inform the kernel about any new partitions by using
+.BR partprobe (8)
+or
+.BR partx (8),
+or by rebooting the system.
 .TP
 .IR "Up Arrow" , " Down Arrow"
 Move the cursor to the previous or next partition.  If there are more
@@ -125,22 +132,23 @@ partitions than can be displayed on a screen, you can display the next
 partition displayed on the screen.
 
 .PP
-All of the commands can be entered with either upper or lower case
+All commands can be entered with either uppercase or lowercase
 letters (except for
 .BR W rite).
-When in a sub-menu or at a prompt to enter a filename, you can hit the
+When in a submenu or at a prompt for entering a size, you can hit the
 .I ESC
-key to return to the main command line.
+key to return to the main menu.
 
 .SH COLORS
-Implicit coloring can be disabled by an empty file \fI/etc/terminal-colors.d/cfdisk.disable\fR.
+Implicit coloring can be disabled by creating the empty file
+.IR /etc/terminal-colors.d/cfdisk.disable .
 
 See
 .BR terminal-colors.d (5)
 for more details about colorization configuration.
 
 .B cfdisk
-does not support colors customization by color scheme file.
+does not support color customization with a color-scheme file.
 
 .SH "SEE ALSO"
 .BR fdisk (8),
@@ -151,7 +159,7 @@ does not support colors customization by color scheme file.
 .SH AUTHOR
 Karel Zak <kzak@redhat.com>
 .PP
-The current cfdisk implemntation is based on the original cfdisk
+The current cfdisk implementation is based on the original cfdisk
 from Kevin E. Martin (martin@cs.unc.edu).
 
 .SH AVAILABILITY
-- 
1.7.0.4

