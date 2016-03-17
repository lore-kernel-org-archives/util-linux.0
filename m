Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:49388 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932084AbcCQJyh (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 05:54:37 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] docs: miscellaneous tiny tweaks of man pages
Date: Thu, 17 Mar 2016 10:54:31 +0100
Message-Id: <1458208471-2937-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/fdisk.8    |    8 ++++----
 misc-utils/cal.1      |    4 ++--
 sys-utils/fallocate.1 |    4 ++--
 sys-utils/mount.8     |   12 +++++-------
 text-utils/tailf.1    |   10 +++++-----
 5 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/disk-utils/fdisk.8 b/disk-utils/fdisk.8
index 89e3153..41069dd 100644
--- a/disk-utils/fdisk.8
+++ b/disk-utils/fdisk.8
@@ -3,7 +3,7 @@
 .\" Copyright 2012 Davidlohr Bueso <dave@gnu.org>
 .\" Copyright (C) 2013 Karel Zak <kzak@redhat.com>
 .\" May be distributed under the GNU General Public License
-.TH FDISK 8 "September 2013" "util-linux" "System Administration"
+.TH FDISK 8 "February 2016" "util-linux" "System Administration"
 
 .SH NAME
 fdisk \- manipulate disk partition table
@@ -54,10 +54,10 @@ between logical and physical sector size.  This option changes both sector sizes
 .IB sectorsize .
 .TP
 \fB\-B\fR, \fB\-\-protect\-boot\fP
-Don't erase the begin of the first disk sector when create a new disk label. This
+Don't erase the begin of the first disk sector when create a new disk label.  This
 feature is supported for GPT and MBR.
 .TP
-\fB\-c\fR, \fB\-\-compatibility\fR[\fI=mode\fR]
+\fB\-c\fR, \fB\-\-compatibility\fR[=\fImode\fR]
 Specify the compatibility mode, 'dos' or 'nondos'.  The default is non-DOS
 mode.  For backward compatibility, it is possible to use the option without
 the \fImode\fR argument -- then the default is used.  Note that the optional
@@ -96,7 +96,7 @@ in favour of
 Enable support only for disklabels of the specified \fItype\fP, and disable
 support for all other types.
 .TP
-\fB\-u\fR, \fB\-\-units\fR[\fI=unit\fR]
+\fB\-u\fR, \fB\-\-units\fR[=\fIunit\fR]
 When listing partition tables, show sizes in 'sectors' or in 'cylinders'.  The
 default is to show sizes in sectors.  For backward compatibility, it is possible
 to use the option without the \fIunit\fR argument -- then the default is used.
diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index 071c693..031e015 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -75,10 +75,10 @@ Display a calendar for the whole year.
 \fB\-Y, \fB\-\-twelve\fR
 Display a calendar for the next twelve months.
 .TP
-\fB\-w\fR, \fB\-\-week\fR[\fI=number\fR]
+\fB\-w\fR, \fB\-\-week\fR[=\fInumber\fR]
 Display week numbers in the calendar (US or ISO-8601).
 .TP
-\fB\-\-color\fR[\fI=when\fR]
+\fB\-\-color\fR[=\fIwhen\fR]
 Colorize the output.  The optional argument \fIwhen\fP
 can be \fBauto\fR, \fBnever\fR or \fBalways\fR.  If the \fIwhen\fR argument is omitted,
 it defaults to \fBauto\fR.  The colors can be disabled; for the current built-in default
diff --git a/sys-utils/fallocate.1 b/sys-utils/fallocate.1
index 5421a11..38b2217 100644
--- a/sys-utils/fallocate.1
+++ b/sys-utils/fallocate.1
@@ -1,9 +1,9 @@
-.TH FALLOCATE 1 "September 2011" "util-linux" "User Commands"
+.TH FALLOCATE 1 "April 2014" "util-linux" "User Commands"
 .SH NAME
 fallocate \- preallocate or deallocate space to a file
 .SH SYNOPSIS
 .B fallocate
-.RB [ \-c | \-p | -z ]
+.RB [ \-c | \-p | \-z ]
 .RB [ \-o
 .IR offset ]
 .B \-l
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index c48bfef..3197c8e 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -2374,7 +2374,7 @@ By default, the files are owned by root and not readable by somebody else.
 
 .SS "Mount options for overlay"
 Since Linux 3.18 the overlay pseudo filesystem implements a union mount for
-other file systems.
+other filesystems.
 
 An overlay filesystem combines two filesystems - an \fBupper\fR filesystem and
 a \fBlower\fR filesystem.  When a name exists in both filesystems, the object
@@ -2384,9 +2384,9 @@ either hidden or, in the case of directories, merged with the upper object.
 The lower filesystem can be any filesystem supported by Linux and does not need
 to be writable.  The lower filesystem can even be another overlayfs.  The upper
 filesystem will normally be writable and if it is it must support the creation
-of trusted.* extended attributes, and must provide valid d_type in readdir
+of trusted.* extended attributes, and must provide a valid d_type in readdir
 responses, so NFS is not suitable.
- 
+
 A read-only overlay of two read-only filesystems may use any filesystem type.
 The options \fBlowerdir\fR and \fBupperdir\fR are combined into a merged
 directory by using:
@@ -2616,10 +2616,8 @@ mount options.  It can be added later, when the tmpfs is already mounted
 on MountPoint, by 'mount \-o remount,mpol=Policy:NodeList MountPoint'.
 
 .SS "Mount options for ubifs"
-UBIFS is a flash file system which works on top of UBI volumes.  Note that
-.B
-atime
-is not supported and is always turned off.
+UBIFS is a flash filesystem which works on top of UBI volumes.  Note that
+\fBatime\fR is not supported and is always turned off.
 .TP
 The device name may be specified as
 .RS
diff --git a/text-utils/tailf.1 b/text-utils/tailf.1
index 9c6bd6a..31bc177 100644
--- a/text-utils/tailf.1
+++ b/text-utils/tailf.1
@@ -21,7 +21,7 @@
 .\" Formatted or processed versions of this manual, if unaccompanied by
 .\" the source, must acknowledge the copyright and authors of this work.
 .\"
-.TH TAILF 1 "July 2014" "util-linux" "User Commands"
+.TH TAILF 1 "March 2015" "util-linux" "User Commands"
 .SH NAME
 tailf \- follow the growth of a log file
 .SH SYNOPSIS
@@ -30,10 +30,10 @@ tailf \- follow the growth of a log file
 .I file
 .SH DESCRIPTION
 .B tailf is deprecated.
-It may have unfixed bugs and will be removed in March 2017. Nowadays it's safe
-to use
+It may have unfixed bugs and will be removed from util-linux in March 2017.
+Nowadays it's safe to use
 .B tail -f
-(coreutils) in contrast to the original documentation below.
+(from coreutils), in contrast to what the original documentation below says.
 .PP
 .B tailf
 will print out the last 10 lines of the given \fIfile\fR and then wait
@@ -45,7 +45,7 @@ does not occur periodically when no log activity is happening.
 .PP
 .B tailf
 is extremely useful for monitoring log files on a laptop when logging is
-infrequent and the user desires that the hard disk spin down to conserve
+infrequent and the user wishes the hard disk to spin down to conserve
 battery life.
 .TP
 .BR \-n , " -\-lines=\fInumber\fR" , " \-\fInumber\fR"
-- 
1.7.0.4

