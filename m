Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:65347 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380Ab2DEUk5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 5 Apr 2012 16:40:57 -0400
Received: by mail-ee0-f46.google.com with SMTP id c41so559672eek.19
        for <util-linux@vger.kernel.org>; Thu, 05 Apr 2012 13:40:56 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/3] docs: eject.1: align with Documentation/howto-man-page.txt
Date: Thu,  5 Apr 2012 22:40:49 +0200
Message-Id: <1333658449-20112-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1333658449-20112-1-git-send-email-kerolasa@iki.fi>
References: <1333658449-20112-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

* Add spaces after dots (English spacing).
* Add line break macros.
* Use URL and email macros where appropriate.
* Fix typo at the end of the manual (s/lsblk/eject/).

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/eject.1 |   96 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 51 insertions(+), 45 deletions(-)

diff --git a/sys-utils/eject.1 b/sys-utils/eject.1
index 8b1b11b..e2c446e 100644
--- a/sys-utils/eject.1
+++ b/sys-utils/eject.1
@@ -14,23 +14,22 @@ eject \- eject removable media
 .SH DESCRIPTION
 .B Eject
 allows removable media (typically a CD-ROM, floppy disk, tape, JAZ, ZIP or USB
-disk) to be ejected under software control. The command can also control some
+disk) to be ejected under software control.  The command can also control some
 multi-disc CD-ROM changers, the auto-eject feature supported by some devices,
 and close the disc tray of some CD-ROM drives.
-
-The device corresponding to \fIdevice\fP or \fImountpoint\fP is ejected. If no
+.PP
+The device corresponding to \fIdevice\fP or \fImountpoint\fP is ejected.  If no
 name is specified, the default name /dev/cdrom is used.
-
+.PP
 There are four different methods of ejecting, depending on whether the device
-is a CD-ROM, SCSI device, removable floppy, or tape. By default eject tries all
-four methods in order until it succeeds.
-
+is a CD-ROM, SCSI device, removable floppy, or tape.  By default eject tries
+all four methods in order until it succeeds.
+.PP
 If device partition is specified, the whole-disk device is used.  If the device
 or a device partition is currently mounted, it is unmounted before ejecting.
-
 .SH OPTIONS
 .IP "\fB\-a, \-\-auto \fIon|off\fP"
-This option controls the auto-eject mode, supported by some devices. When
+This option controls the auto-eject mode, supported by some devices.  When
 enabled, the drive automatically ejects when the device is closed.
 .IP "\fB\-c, \-\-changerslot \fIslot\fP"
 With this option a CD slot can be selected from an ATAPI/IDE CD-ROM changer.
@@ -47,7 +46,7 @@ Force eject, don't check device type.
 .IP "\fB\-h, \-\-help\fP"
 Print a help text and exit.
 .IP "\fB\-i, \-\-manualeject \fIon|off\fP"
-This option controls locking of the hardware eject button. When enabled, the
+This option controls locking of the hardware eject button.  When enabled, the
 drive will not be ejected when the button is pressed.  This is useful when you
 are carrying a laptop in a bag or case and don't want it to eject if the button
 is inadvertently pressed.
@@ -65,18 +64,17 @@ to not try to unmount the given device, even if it is mounted according to
 .IP "\fB\-n, \-\-noop\fP"
 With this option the selected device is displayed but no action is performed.
 .IP "\fB\-t, \-\-trayclose\fP"
-With this option the drive is given a CD-ROM tray close command. Not all
+With this option the drive is given a CD-ROM tray close command.  Not all
 devices support this command.
 .IP "\fB\-T, \-\-traytoggle\fP"
 With this option the drive is given a CD-ROM tray close command if it's opened,
-and a CD-ROM tray eject command if it's closed. Not all devices support this
+and a CD-ROM tray eject command if it's closed.  Not all devices support this
 command, because it uses the above CD-ROM tray close command.
 .IP "\fB\-r, \-\-cdrom\fP"
 This option specifies that the drive should be ejected using a CDROM eject
 command.
 .IP "\fB\-s, \-\-scsi\fP"
 This option specifies that the drive should be ejected using SCSI commands.
-
 .IP "\fB\-v, \-\-verbose\fP"
 Run in verbose mode; more information is displayed about what the command is
 doing.
@@ -85,70 +83,78 @@ Display program version and exit.
 .IP "\fB\-x, \-\-cdspeed \fI<speed>\fP"
 With this option the drive is given a CD-ROM select speed command.  The speed
 argument is a number indicating the desired speed (e.g. 8 for 8X speed), or 0
-for maximum data rate. Not all devices support this command and you can only
-specify speeds that the drive is capable of. Every time the media is changed
-this option is cleared. This option can be used alone, or with the \-t and \-c
+for maximum data rate.  Not all devices support this command and you can only
+specify speeds that the drive is capable of.  Every time the media is changed
+this option is cleared.  This option can be used alone, or with the \-t and \-c
 options.
 .IP "\fB\-X, \-\-listspeed\fP" 
 With this option the CD-ROM drive will be probed to detect the available
-speeds. The output is a list of speeds which can be used as an argument of the
-\-x option. This only works with Linux 2.6.13 or higher, on previous versions
-solely the maximum speed will be reported. Also note that some drive may not
+speeds.  The output is a list of speeds which can be used as an argument of the
+\-x option.  This only works with Linux 2.6.13 or higher, on previous versions
+solely the maximum speed will be reported.  Also note that some drive may not
 correctly report the speed and therefore this option does not work with them.
-
 .SH EXIT STATUS
 Returns 0 if operation was successful, 1 if operation failed or command syntax
 was not valid.
-
 .SH NOTES
 .B Eject
 only works with devices that support one or more of the four methods of
-ejecting. This includes most CD-ROM drives (IDE, SCSI, and proprietary), some
+ejecting.  This includes most CD-ROM drives (IDE, SCSI, and proprietary), some
 SCSI tape drives, JAZ drives, ZIP drives (parallel port, SCSI, and IDE
-versions), and LS120 removable floppies. Users have also reported success with
-floppy drives on Sun SPARC and Apple Macintosh systems. If
+versions), and LS120 removable floppies.  Users have also reported success with
+floppy drives on Sun SPARC and Apple Macintosh systems.  If
 .B eject
 does not work, it is most likely a limitation of the kernel driver for the
 device and not the
 .B eject
 program itself.
-
+.PP
 The \-r, \-s, \-f, and \-q options allow controlling which methods are used to
-eject. More than one method can be specified. If none of these options are
+eject.  More than one method can be specified.  If none of these options are
 specified, it tries all four (this works fine in most cases).
-
+.PP
 .B Eject
 may not always be able to determine if the device is mounted (e.g. if it has
-several names). If the device name is a symbolic link,
+several names).  If the device name is a symbolic link,
 .B eject
 will follow the link and use the device that it points to.
-
+.PP
 If
 .B eject
 determines that the device can have multiple partitions, it will attempt to
-unmount all mounted partitions of the device before ejecting. If an unmount
+unmount all mounted partitions of the device before ejecting.  If an unmount
 fails, the program will not attempt to eject the media.
-
-You can eject an audio CD. Some CD-ROM drives will refuse to open the tray if
-the drive is empty. Some devices do not support the tray close command.
-
+.PP
+You can eject an audio CD.  Some CD-ROM drives will refuse to open the tray if
+the drive is empty.  Some devices do not support the tray close command.
+.PP
 If the auto-eject feature is enabled, then the drive will always be ejected
-after running this command. Not all Linux kernel CD-ROM drivers support the
-auto-eject mode. There is no way to find out the state of the auto-eject mode.
-
-You need appropriate privileges to access the device files. Running as root is
+after running this command.  Not all Linux kernel CD-ROM drivers support the
+auto-eject mode.  There is no way to find out the state of the auto-eject mode.
+.PP
+You need appropriate privileges to access the device files.  Running as root is
 required to eject some devices (e.g. SCSI devices).
-
 .SH AUTHORS
-.nf
-Jeff Tranter (tranter@pobox.com) - original author
-Karel Zak (kzak@redhat.com), Michal Luscon (mluscon@redhat.com) - util-linux version
-.fi
+.MT tranter@\:pobox.com
+Jeff Tranter
+.ME
+- original author.
+.br
+.MT kzak@\:redhat.com
+Karel Zak
+.ME
+and
+.MT mluscon@\:redhat.com
+Michal Luscon
+.ME
+- util-linux version.
 .SH SEE ALSO
 .BR lsblk (8),
 .BR findmnt (8),
 .BR mount (8),
 .BR umount (8)
 .SH AVAILABILITY
-The lsblk command is part of the util-linux package and is available from
-ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
+The eject command is part of the util-linux package and is available from
+.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
-- 
1.7.9.6

