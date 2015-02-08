Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:54767 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758233AbbBHUVz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Feb 2015 15:21:55 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/4] docs: sort the options in the man page of sfdisk alphabetically
Date: Sun,  8 Feb 2015 21:21:30 +0100
Message-Id: <1423426891-1887-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1423426891-1887-1-git-send-email-bensberg@justemail.net>
References: <1423426891-1887-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also fix some typos.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/sfdisk.8 |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 2af8ece..4d001de 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -83,7 +83,7 @@ and GUID-specific bits in the range from 48 to 63.  For example, the string
 "RequiredPartiton,50,51" sets three bits.
 .TP
 .BR \-\-part\-label " \fIdevice partno [" \fIlabel ]
-Change the GPT partition name (label).  If \fIlabel\fR is nto specified,
+Change the GPT partition name (label).  If \fIlabel\fR is not specified,
 then print the current partition label.
 .TP
 .BR \-\-part\-type " \fIdevice partno [" \fItype ]
@@ -119,6 +119,20 @@ name see \fB\-\-backup\-file\fR.
 .BR \-f , " \-\-force"
 Disable all consistency checking.
 .TP
+.BR \-\-Linux
+Deprecated and ignored option.  Partitioning that is compatible with
+Linux (and other modern OS) is the default.
+.TP
+.BR \-n , " \-\-no\-act"
+Do everything except writing to the device.
+.TP
+.B \-\-no\-reread
+Do not check through the re-read-partition-table ioctl whether the device is in use.
+.TP
+.BR \-O , " \-\-backup\-file " \fIpath\fR
+Override the default backup file name.  Note that the device name and offset
+are always appended to the file name.
+.TP
 .BR \-o , " \-\-output " \fIlist
 Specify which output columns to print.  Use
 .B \-\-help
@@ -127,26 +141,12 @@ to get a list of all supported columns.
 The default list of columns may be extended if \fIlist\fP is
 specified in the format \fI+list\fP (e.g. \fB-o +UUID\fP).
 .TP
-.BR \-O , " \-\-backup\-file " \fIpath\fR
-Override the default backup file name.  Note that the device name and offset
-are always appended to the file name.
-.TP
 .BR \-q , " \-\-quiet"
 Suppress extra info messages.
 .TP
-.BR \-n , " \-\-no\-act"
-Do everything except write to device.
-.TP
-.B \-\-no\-reread
-Do not check through the re-read-partition-table ioctl whether the device is in use.
-.TP
 .BR \-u , " \-\-unit S"
 Deprecated option.  Only the sector unit is supported.
 .TP
-.BR "\-\-Linux"
-Deprecated and ignored option.  Linux (and another modern OS) compatible
-partitioning is the default.
-.TP
 .BR \-X , " \-\-label " \fItype
 Specify the disk label type (e.g. \fBdos\fR, \fBgpt\fR, ...).  If this option
 is not given, then \fBsfdisk\fR defaults to the existing label, but if there
@@ -202,7 +202,7 @@ is specified in the input.
 .RE
 where each line fills one partition descriptor.
 .sp
-Fields are separated by whitespace, or q comma or semicolon possibly followed by
+Fields are separated by whitespace, or by comma or semicolon possibly followed by
 whitespace; initial and trailing whitespace is ignored.  Numbers can be octal,
 decimal or hexadecimal; decimal is the default.  When  a field is absent or empty,
 a default value is used.  But when the \fB-N\fR option (change a single partition)
@@ -212,7 +212,7 @@ The default value of
 .I start
 is the first non-assigned sector aligned according to device I/O limits.
 The default start offset for the first partition is 1 MiB. The offset may
-be may be followed by the multiplicative suffixes (KiB, MiB, GiB, TiB, PiB,
+be followed by the multiplicative suffixes (KiB, MiB, GiB, TiB, PiB,
 EiB, ZiB and YiB) then the number is interpreted as offset in bytes.
 .sp
 The default value of
@@ -255,7 +255,7 @@ but might play a role for certain boot loaders and for other operating systems.)
 .B Named-fields format
 .RS
 This format is more readable, robust, extendible and allows to specify additional
-information (e.g. a UUID).  It is recommended to use this format to keep you scripts
+information (e.g. a UUID).  It is recommended to use this format to keep your scripts
 more readable.
 .RS
 .sp
-- 
1.7.0.4

