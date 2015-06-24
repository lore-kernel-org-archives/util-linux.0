Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33536 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbbFXIPn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 24 Jun 2015 04:15:43 -0400
Received: by wiwl6 with SMTP id l6so87782596wiw.0
        for <util-linux@vger.kernel.org>; Wed, 24 Jun 2015 01:15:42 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 12/12] docs: make fsck.minix(8) more pretty
Date: Wed, 24 Jun 2015 09:15:19 +0100
Message-Id: <1435133719-2971-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
References: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use real table to device list, add missing new paragraph markers, remove
braces that cause reader to wonder if test is meant or not, squeeze error
code list, move references to bottom of the manual, and use mail or web
address macro when possible.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fsck.minix.8 | 130 +++++++++++++++++++++++++++++-------------------
 1 file changed, 80 insertions(+), 50 deletions(-)

diff --git a/disk-utils/fsck.minix.8 b/disk-utils/fsck.minix.8
index 84d54bb..3598781 100644
--- a/disk-utils/fsck.minix.8
+++ b/disk-utils/fsck.minix.8
@@ -10,32 +10,32 @@ fsck.minix \- check consistency of Minix filesystem
 .SH DESCRIPTION
 .B fsck.minix
 performs a consistency check for the Linux MINIX filesystem.
-
-The program
-assumes the filesystem is quiescent.
+.PP
+The program assumes the filesystem is quiescent.
 .B fsck.minix
 should not be used on a mounted device unless you can be sure nobody is
-writing to it (and remember that the kernel can write to it when it
-searches for files).
-
+writing to it.  Remember that the kernel can write to device when it
+searches for files.
+.PP
 The \fIdevice\fR name will usually have the following form:
-.nf
 .RS
-/dev/hda[1\(en63] (IDE disk 1)
-/dev/hdb[1\(en63] (IDE disk 2)
-/dev/sda[1\(en15] (SCSI disk 1)
-/dev/sdb[1\(en15] (SCSI disk 2)
+.TS
+tab(:);
+left l l.
+/dev/hda[1\(en63]:IDE disk 1
+/dev/hdb[1\(en63]:IDE disk 2
+/dev/sda[1\(en15]:SCSI disk 1
+/dev/sdb[1\(en15]:SCSI disk 2
+.TE
 .RE
-.fi
-
-If the filesystem was changed (i.e., repaired), then
+.PP
+If the filesystem was changed, i.e., repaired, then
 .B fsck.minix
 will print "FILE SYSTEM HAS CHANGED" and will
 .BR sync (2)
-three times before exiting.  Since Linux does not currently have raw
-devices, there is
+three times before exiting.  There is
 .I no
-need to reboot at this time.
+need to reboot after check.
 .SH WARNING
 .B fsck.minix
 should
@@ -46,8 +46,9 @@ on a mounted filesystem is very dangerous, due to the possibility that
 deleted files are still in use, and can seriously damage a perfectly good
 filesystem!  If you absolutely have to run
 .B fsck.minix
-on a mounted filesystem (i.e., the root filesystem), make sure nothing is
-writing to the disk, and that no files are "zombies" waiting for deletion.
+on a mounted filesystem, such as the root filesystem, make sure nothing
+is writing to the disk, and that no files are "zombies" waiting for
+deletion.
 .SH OPTIONS
 .TP
 \fB\-l\fR, \fB\-\-list\fR
@@ -57,9 +58,9 @@ List all filenames.
 Perform interactive repairs.
 .TP
 \fB\-a\fR, \fB\-\-auto\fR
-Perform automatic repairs.  (This option implies
+Perform automatic repairs.  This option implies
 .B \-\-repair
-and serves to answer all of the questions asked with the default.)  Note
+and serves to answer all of the questions asked with the default.  Note
 that this can be extremely dangerous in the case of extensive filesystem
 damage.
 .TP
@@ -73,25 +74,18 @@ Output super-block information.
 Activate MINIX-like "mode not cleared" warnings.
 .TP
 \fB\-f\fR, \fB\-\-force\fR
-Force a filesystem check even if the filesystem was marked as valid (this
-marking is done by the kernel when the filesystem is unmounted).
+Force a filesystem check even if the filesystem was marked as valid.
+Marking is done by the kernel when the filesystem is unmounted.
 .TP
 \fB\-V\fR, \fB\-\-version\fR
 Display version information and exit.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
-.SH "SEE ALSO"
-.BR fsck (8),
-.BR fsck.ext2 (8),
-.BR mkfs (8),
-.BR mkfs.minix (8),
-.BR mkfs.ext2 (8),
-.BR reboot (8)
 .SH DIAGNOSTICS
 There are numerous diagnostic messages.  The ones mentioned here are the
 most commonly seen in normal usage.
-
+.PP
 If the device does not exist,
 .B fsck.minix
 will print "unable to read super block".  If the device exists, but is not
@@ -102,37 +96,73 @@ will print "bad magic number in super-block".
 The exit code returned by
 .B fsck.minix
 is the sum of the following:
-.IP 0
+.PP
+.RS
+.PD 0
+.TP
+.B 0
 No errors
-.IP 3
+.TP
+.B 3
 Filesystem errors corrected, system should be rebooted if filesystem was
 mounted
-.IP 4
+.TP
+.B 4
 Filesystem errors left uncorrected
-.IP 7
+.TP
+.B 7
 Combination of exit codes 3 and 4
-.IP 8
+.TP
+.B 8
 Operational error
-.IP 16
+.TP
+.B 16
 Usage or syntax error
+.PD
+.RE
 .PP
-In point of fact, only 0, 3, 4, 7, 8, and 16 can ever be returned.
-.SH AUTHOR
-Linus Torvalds (torvalds@cs.helsinki.fi)
+.SH AUTHORS
+.MT torvalds@\:cs.\:helsinki.\:fi
+Linus Torvalds
+.ME
 .br
-Error code values by Rik Faith (faith@cs.unc.edu)
+Error code values by
+.MT faith@\:cs.\:unc.\:edu
+Rik Faith
+.ME
 .br
-Added support for filesystem valid flag: Dr.\& Wettstein
-(greg%wind.uucp@plains.nodak.edu)
+Added support for filesystem valid flag:
+.MT greg%\:wind.\:uucp@\:plains.\:nodak.\:edu
+Dr.\& Wettstein
+.ME .
 .br
-Check to prevent fsck of mounted filesystem added by Daniel Quinlan
-(quinlan@yggdrasil.com)
+Check to prevent fsck of mounted filesystem added by
+.MT quinlan@\:yggdrasil.\:com
+Daniel Quinlan
+.ME .
 .br
-Minix v2 fs support by Andreas Schwab
-(schwab@issan.informatik.uni-dortmund.de), updated by Nicolai
-Langfeldt (janl@math.uio.no)
+Minix v2 fs support by
+.MT schwab@\:issan.\:informatik.\:uni-dortmund.\:de
+Andreas Schwab
+.ME ,
+updated by
+.MT janl@\:math.\:uio.\:no
+Nicolai Langfeldt
+.ME .
 .br
-Portability patch by Russell King (rmk@ecs.soton.ac.uk).
+Portability patch by
+.MT rmk@\:ecs.\:soton.\:ac.\:uk
+Russell King
+.ME .
+.SH "SEE ALSO"
+.BR fsck (8),
+.BR fsck.ext2 (8),
+.BR mkfs (8),
+.BR mkfs.minix (8),
+.BR mkfs.ext2 (8),
+.BR reboot (8)
 .SH AVAILABILITY
 The fsck.minix command is part of the util-linux package and is available from
-ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
+.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
-- 
2.4.4

