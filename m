Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:53338 "EHLO
	cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932159AbcCHJVK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Mar 2016 04:21:10 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/9] fdisk, sfdisk: adjust some formatting in the man pages
Date: Tue,  8 Mar 2016 10:07:44 +0100
Message-Id: <1457428072-2619-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Only the optional argument should be in italics,
the literal = should be bold.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/fdisk.8  |    6 +++---
 disk-utils/sfdisk.8 |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/disk-utils/fdisk.8 b/disk-utils/fdisk.8
index f0c6def..49401e5 100644
--- a/disk-utils/fdisk.8
+++ b/disk-utils/fdisk.8
@@ -67,11 +67,11 @@ the correct form is for example '-c=dos'.
 \fB\-h\fR, \fB\-\-help\fR
 Display a help text and exit.
 .TP
-\fB\-L\fR, \fB\-\-color\fR[\fI=when\fR]
+\fB\-L\fR, \fB\-\-color\fR[=\fIwhen\fR]
 Colorize the output.  The optional argument \fIwhen\fP
 can be \fBauto\fR, \fBnever\fR or \fBalways\fR.  If the \fIwhen\fR argument is omitted,
-it defaults to \fBauto\fR.  The colors can be disabled, for the current built-in default 
-see \fB\-\-help\fR output. See also the COLORS section.
+it defaults to \fBauto\fR.  The colors can be disabled; for the current built-in default
+see the \fB\-\-help\fR output.  See also the \fBCOLORS\fR section.
 .TP
 \fB\-l\fR, \fB\-\-list\fR
 List the partition tables for the specified devices and then exit.
diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 1e60de5..b8cacee 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -136,7 +136,7 @@ Back up the current partition table sectors before starting the partitioning.
 The default backup file name is ~/sfdisk-<device>-<offset>.bak; to use another
 name see option \fB\-O\fR, \fB\-\-backup\-file\fR.
 .TP
-.BR \-\-color[\fI=when]
+.BR \-\-color [ =\fIwhen ]
 Colorize the output.  The optional argument \fIwhen\fP
 can be \fBauto\fR, \fBnever\fR or \fBalways\fR.  If the \fIwhen\fR argument is omitted,
 it defaults to \fBauto\fR.  The colors can be disabled; for the current built-in default
@@ -159,7 +159,7 @@ Do not check through the re-read-partition-table ioctl whether the device is in
 Override the default backup file name.  Note that the device name and offset
 are always appended to the file name.
 .TP
-.BR \-\-move-data[\fI=path]
+.BR \-\-move-data [ =\fIpath ]
 Move data after partition relocation, for example when move begin of the
 partition to another place on the disk. The size of the partition has to be the
 same, the new and old location may overlap. The option requires \fB\-N\fR to be
-- 
1.7.0.4

