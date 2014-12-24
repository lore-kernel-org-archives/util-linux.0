Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:49700 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751380AbaLXQ4R (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 24 Dec 2014 11:56:17 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 01/10] docs: improve some wordings on the man page of wipefs
Date: Wed, 24 Dec 2014 17:56:01 +0100
Message-Id: <1419440170-10850-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 misc-utils/wipefs.8 |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/misc-utils/wipefs.8 b/misc-utils/wipefs.8
index 13cadb4..c4addef 100644
--- a/misc-utils/wipefs.8
+++ b/misc-utils/wipefs.8
@@ -2,7 +2,7 @@
 .\" Copyright 2009 by Karel Zak.  All Rights Reserved.
 .\" This file may be copied under the terms of the GNU Public License.
 .\"
-.TH WIPEFS 8 "October 2009" "util-linux" "System Administration"
+.TH WIPEFS 8 "December 2014" "util-linux" "System Administration"
 .SH NAME
 wipefs \- wipe a signature from a device
 .SH SYNOPSIS
@@ -20,41 +20,42 @@ to make the signatures invisible for libblkid.
 
 .B wipefs
 does not erase the filesystem itself nor any other data from the device.
-When used without options \fB-a\fR or \fB-o\fR, it lists all visible filesystems
+When used without any options, \fBwipefs\fR lists all visible filesystems
 and the offsets of their basic signatures.
 
 .B wipefs
-calls BLKRRPART ioctl when erase partition table to inform kernel about the change.
+calls the BLKRRPART ioctl when it has erased a partition-table signature
+to inform the kernel about the change.
 
-Note that some filesystems or some partition tables store more magic strings on
-the devices.  The
+Note that some filesystems and some partition tables store more magic strings on
+the device.  The
 .B wipefs
 command lists only the first offset where a magic string has been detected.  The device
 is not scanned for additional magic strings for the same filesystem.  It is possible
-that after \fBwipefs -o \fIoffset\fR the same filesystem or partition
-table will still be visible by another magic string on another offset.
+that after a \fBwipefs -o \fIoffset\fR the same filesystem or partition
+table will still be visible because of another magic string on another offset.
 
-When used with option \fB-a\fR, all magic strings that are visible for libblkid are
+When option \fB-a\fR is used, all magic strings that are visible for libblkid are
 erased.
 
 Note that by default
 .B wipefs
-does not erase nested partition tables on non-whole disk devices. The option 
-\-\-force is required.
+does not erase nested partition tables on non-whole disk devices.
+For this the option \fB\-\-force\fR is required.
 
 .SH OPTIONS
 .TP
 .BR \-a , " \-\-all"
 Erase all available signatures.  The set of erased signatures can be
-restricted with the \fB\-t\fP \fIlist\fP option.
+restricted with the \fB\-t\fR option.
 .TP
 .BR \-b , " \-\-backup"
 Create a signature backup to the file $HOME/wipefs-<devname>-<offset>.bak.
-For more details see EXAMPLES section.
+For more details see the \fBEXAMPLES\fR section.
 .TP
 .BR \-f , " \-\-force"
 Force erasure, even if the filesystem is mounted.  This is required in
-order to erase the partition table on a block device.
+order to erase a partition-table signature on a block device.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
@@ -66,7 +67,7 @@ Causes everything to be done except for the write() call.
 Specify the location (in bytes) of the signature which should be erased from the
 device.  The \fIoffset\fR number may include a "0x" prefix; then the number will be
 interpreted as a hex value.  It is possible to specify multiple \fB-o\fR options.
-
+.sp
 The \fIoffset\fR argument may be followed by the multiplicative
 suffixes KiB (=1024), MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB
 (the "iB" is optional, e.g. "K" has the same meaning as "KiB"), or the suffixes
@@ -77,7 +78,7 @@ Print out in parsable instead of printable format.  Encode all potentially unsaf
 characters of a string to the corresponding hex value prefixed by '\\x'.
 .TP
 .BR \-q , " \-\-quiet"
-Suppress output messages after successful signature wipe.
+Suppress any messages after a successful signature wipe.
 .TP
 .BR \-t , " \-\-types " \fIlist\fP
 Limit the set of printed or erased signatures.  More than one type may
@@ -94,7 +95,7 @@ Erases all signatures from the device /dev/sdb and creates a signature backup
 file ~/wipefs-sdb-<offset>.bak for each signature.
 .TP
 .BR "dd if=~/wipefs-sdb-0x00000438.bak of=/dev/sdb seek=$((0x00000438)) bs=1 conv=notrunc"
-Restores ext2 signature from the backup file  ~/wipefs-sdb-0x00000438.bak.
+Restores an ext2 signature from the backup file  ~/wipefs-sdb-0x00000438.bak.
 .SH AUTHOR
 Karel Zak <kzak@redhat.com>
 .SH ENVIRONMENT
-- 
1.7.0.4

