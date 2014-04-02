Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:54636 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932480AbaDBXaO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Apr 2014 19:30:14 -0400
Received: from katla.rhi.hi.is (localhost [127.0.0.1])
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4) with ESMTP id s32NUCcT023389
	for <util-linux@vger.kernel.org>; Wed, 2 Apr 2014 23:30:12 GMT
Received: (from bjarniig@localhost)
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4/Submit) id s32NUC4m023388
	for util-linux@vger.kernel.org; Wed, 2 Apr 2014 23:30:12 GMT
Date: Wed, 2 Apr 2014 23:30:12 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Subject: [PATCH] fsck(8): Some typographical corrections to the manual
Message-ID: <20140402233011.GA23377@rhi.hi.is>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Package: util-linux
Version: 2.24.1
Severity: minor
File: disk-utils/fsck.8
Tags: patch

  The word "kilobytes" is ambiguous.  Change it to "kibibytes" if kilo
does not mean 1000.  Otherwise add "(1000 B)" after it.

  Changes:

  A string, that begins or ends with a full stop (.), protected with \&

  - changed to \- if it shows an option

  -- change to \(en if it means a dash (pause, separation)

  Space between sentences is two word spaces in *roff.  Thus it is
better to begin each sentence on a new line when the file contains
formatting commands

  --- changed to \(en if it means a dash (pause, separation)

  Punctuation separated from a word with a space, if it is an argument
to a macro like "BR" (two font styles used alternately)

  Adjusting inhibited for the section "SEE ALSO" with ".na/.ad"

  Patch is in the attachment

-- 
Bjarni I. Gislason

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fsck.8.diff"

--- fsck.8	2014-01-14 11:48:04.000000000 +0000
+++ fsck.8.new	2014-04-01 22:04:10.000000000 +0000
@@ -12,7 +12,7 @@ fsck \- check and repair a Linux filesys
 .RI [ fd ]]
 .RB [ \-t
 .IR fstype ]
-.RI [ filesystem ...]
+.RI [ filesystem \&...\&]
 .RB [ \-\- ]
 .RI [ fs-specific-options ]
 .SH DESCRIPTION
@@ -95,18 +95,18 @@ further details.
 .B \-l
 Lock the whole-disk device by an exclusive
 .BR flock (2).
-This option can be used with one device only (this means that \fB-A\fR and
-\fB-l\fR are mutually exclusive).  This option is recommended when more
+This option can be used with one device only (this means that \fB\-A\fR and
+\fB\-l\fR are mutually exclusive).  This option is recommended when more
 .BR fsck (8)
 instances are executed in the same time.  The option is ignored when used for
 multiple devices or for non-rotating disks.  \fBfsck\fR does not lock underlying
-devices when executed to check stacked devices (e.g. MD or DM) -- this feature is
+devices when executed to check stacked devices (e.g.\& MD or DM) \(en this feature is
 not implemented yet.
 .TP
 .B \-r
-Report certain statistics for each fsck when it completes. These statistics
+Report certain statistics for each fsck when it completes.  These statistics
 include the exit status, the maximum run set size (in kilobytes), the elapsed
-all-clock time and the user and system CPU time used by the fsck run. For
+all-clock time and the user and system CPU time used by the fsck run.  For
 example:
 
 /dev/sda1: status 0, rss 92828, real 4.002804, user 2.677592, sys 0.86186
@@ -230,7 +230,7 @@ will attempt to check them in parallel,
 multiple filesystem checks on the same physical disk.
 .sp
 .B fsck
-does not check stacked devices (RAIDs, dm-crypt, ...) in parallel with any other
+does not check stacked devices (RAIDs, dm-crypt, \&...\&) in parallel with any other
 device.  See below for FSCK_FORCE_ALL_PARALLEL setting.  The /sys filesystem is
 used to detemine dependencies between devices.
 .sp
@@ -246,7 +246,7 @@ value of 2.  This will allow
 to automatically run filesystem checkers in parallel if it is advantageous
 to do so.  System administrators might choose
 not to use this configuration if they need to avoid multiple filesystem
-checks running in parallel for some reason --- for example, if the
+checks running in parallel for some reason \(en for example, if the
 machine in question is short on memory so that
 excessive paging is a concern.
 .sp
@@ -330,7 +330,7 @@ what you expect,
 .B don't bother reporting it as a bug.
 You're almost certainly doing something that you shouldn't be doing
 with
-.BR fsck.
+.BR fsck .
 .PP
 Options to different filesystem-specific fsck's are not standardized.
 If in doubt, please consult the man pages of the filesystem-specific
@@ -383,7 +383,7 @@ all filesystem-specific checkers impleme
 and
 .BR fsck.cramfs (8)
 do not support the
-.B -y
+.B \-y
 option as of this writing.
 .SH FILES
 .IR /etc/fstab .
@@ -441,6 +441,7 @@ enables debug output.
 .B LIBMOUNT_DEBUG=0xffff
 enables debug output.
 .SH SEE ALSO
+.na
 .BR fstab (5),
 .BR mkfs (8),
 .BR fsck.ext2 (8)
@@ -457,6 +458,7 @@ or
 .BR fsck.xfs (8),
 .BR fsck.xiafs (8),
 .BR reiserfsck (8).
+.ad
 .SH AUTHOR
 .MT tytso@mit.edu
 Theodore Ts'o

--7JfCtLOvnd9MIVvH--
