Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:50090 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755204AbbFQG33 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 17 Jun 2015 02:29:29 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] sfdisk: improve some formatting and wording in the man page
Date: Wed, 17 Jun 2015 08:28:33 +0200
Message-Id: <1434522513-2124-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1434522513-2124-1-git-send-email-bensberg@justemail.net>
References: <1434522513-2124-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The main fix is: giving -J, --json its own paragraph.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/sfdisk.8 |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 91cba72..c2ec89b 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -10,7 +10,7 @@
 .\" entire resulting derived work is distributed under the terms of a
 .\" permission notice identical to this one.
 .\"
-.TH SFDISK 8 "December 2014" "util-linux" "System Administration"
+.TH SFDISK 8 "June 2015" "util-linux" "System Administration"
 .SH NAME
 sfdisk \- display or manipulate a disk partition table
 .SH SYNOPSIS
@@ -35,7 +35,7 @@ never been important for Linux, and this addressing concept does not make any
 sense for new devices.
 .sp
 .B sfdisk
-(since version 2.26) aligns start and end of the partitions to
+(since version 2.26) aligns the start and end of partitions to
 block-device I/O limits when relative sizes are specified, or when the
 default values are used.
 .sp
@@ -57,28 +57,29 @@ input format.  If standard input is a terminal, then \fBsfdisk\fR starts an
 interactive session.
 .sp
 If the option \fB\-N\fR is specified, then the changes are applied to
-the partition addressed by \fIpartition-number\fR. The unspecified fields
+the partition addressed by \fIpartition-number\fR.  The unspecified fields
 of the partition are not modified.
 .sp
-Note that it's possible to address unused partition by \fB\-N\fR. For example
-MBR always contains 4 partitions, but the number of the used partitions may be
-smaller.  In this case sfdisk follows the default values from the partition
-table and it does not use built-in defaults for the unused partition specified
-by \fB\-N\fR. See also \fB\---append\fR.
+Note that it's possible to address an unused partition with \fB\-N\fR.
+For example, an MBR always contains 4 partitions, but the number of used
+partitions may be smaller.  In this case \fBsfdisk\fR follows the default
+values from the partition table and does not use built-in defaults for the
+unused partition given with \fB\-N\fR.  See also \fB\---append\fR.
 .TP
 .BR \-A , " \-\-activate \fIdevice\fR [" \fIpartition-number\fR...]
 Switch on the bootable flag.  If no \fIpartition-number\fR is specified,
 then all partitions with an enabled flag are listed.
 .TP
 .BR \-d , " \-\-dump " \fIdevice\fR
-Dump the partitions of a device in a format that is usable as input to sfdisk.
+Dump the partitions of a device in a format that is usable as input to \fBsfdisk\fR.
 See the section \fBBACKING UP THE PARTITION TABLE\fR.
 .TP
 .BR \-g , " \-\-show\-geometry " [ \fIdevice ...]
 List the geometry of all or the specified devices.
+.TP
 .BR \-J , " \-\-json " \fIdevice\fR
-Dump the partitions of a device in JSON format. Note that sfdisk is not able to
-use JSON as input format.
+Dump the partitions of a device in JSON format.  Note that \fBsfdisk\fR is
+not able to use JSON as input format.
 .TP
 .BR \-l , " \-\-list " [ \fIdevice ...]
 List the partitions of all or the specified devices.  This command can be used
@@ -124,20 +125,20 @@ Don't create a new partition table, but only append the specified partitions.
 .BR \-b , " \-\-backup"
 Back up the current partition table sectors before starting the partitioning.
 The default backup file name is ~/sfdisk-<device>-<offset>.bak; to use another
-name see \fB\-\-backup\-file\fR.
+name see option \fB\-O\fR, \fB\-\-backup\-file\fR.
 .TP
-.BR "\-\-color"[\fI=when\fR]
+.BR \-\-color [ \fI=when ]
 Colorize the output.  The optional argument \fIwhen\fP
 can be \fBauto\fR, \fBnever\fR or \fBalways\fR.  If the \fIwhen\fR argument is omitted,
-it defaults to \fBauto\fR.  The colors can be disabled, for the current built-in default 
-see \fB\-\-help\fR output. See also the COLORS section.
+it defaults to \fBauto\fR.  The colors can be disabled; for the current built-in default
+see the \fB\-\-help\fR output.  See also the \fBCOLORS\fR section.
 .TP
 .BR \-f , " \-\-force"
 Disable all consistency checking.
 .TP
 .BR \-\-Linux
 Deprecated and ignored option.  Partitioning that is compatible with
-Linux (and other modern OS) is the default.
+Linux (and other modern operating systems) is the default.
 .TP
 .BR \-n , " \-\-no\-act"
 Do everything except writing to the device.
-- 
1.7.0.4

