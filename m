Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:53261 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750782AbbAKV2Z (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 11 Jan 2015 16:28:25 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/4] docs: make the wording of the partx man page a bit more precise
Date: Sun, 11 Jan 2015 22:27:58 +0100
Message-Id: <1421011678-5890-4-git-send-email-bensberg@justemail.net>
In-Reply-To: <1421011678-5890-1-git-send-email-bensberg@justemail.net>
References: <1421011678-5890-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/partx.8 |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/disk-utils/partx.8 b/disk-utils/partx.8
index fb0fe38..af2bb5e 100644
--- a/disk-utils/partx.8
+++ b/disk-utils/partx.8
@@ -1,4 +1,4 @@
-.\" partx.8 --
+.\" partx.8 -- man page for partx
 .\" Copyright 2007 Karel Zak <kzak@redhat.com>
 .\" Copyright 2007 Red Hat, Inc.
 .\" Copyright 2010 Davidlohr Bueso <dave@gnu.org>
@@ -6,39 +6,40 @@
 .\"
 .TH PARTX "8" "December 2014" "util-linux" "System Administration"
 .SH NAME
-partx \- tell the Linux kernel about the presence and numbering of on-disk partitions
+partx \- tell the kernel about the presence and numbering of on-disk partitions
 .SH SYNOPSIS
 .B partx
-.RB [ \-a | \-d | \-s | \-u ]
+.RB [ \-a | \-d | \-P | \-r | \-s | \-u ]
 .RB [ \-t " \fItype\fR]"
 .RB [ \-n " \fIM" : \fIN\fR]
 .RB [ \- "] " \fIdisk
 .br
 .B partx
-.RB [ \-a | \-d | \-s | \-u ]
+.RB [ \-a | \-d | \-P | \-r | \-s | \-u ]
 .RB [ \-t " \fItype\fR]"
 .IR partition " [" disk ]
 .SH DESCRIPTION
 Given a device or disk-image,
 .B partx
 tries to parse the partition table and list its contents.  It
-optionally adds or removes partitions.
+can also tell the kernel to add or remove partitions from its
+bookkeeping.
 .PP
 The
 .I disk
 argument is optional when a
 .I partition
 argument is provided.  To force scanning a partition as if it were a whole disk
-(for example to list nested subpartitions), use the argument "\-" (hyphen-minus).  For example:
+(for example to list nested subpartitions), use the argument "\-" (hyphen-minus).
+For example:
 
 .RS 7
 .TP
 partx \-\-show \- /dev/sda3
 .RE
 .PP
-This will see sda3 as a whole-disk rather than a partition.
+This will see sda3 as a whole-disk rather than as a partition.
 .PP
-The
 .B partx is not an fdisk program
 \(en adding and removing partitions does not change the disk, it just
 tells the kernel about the presence and numbering of on-disk
@@ -55,7 +56,7 @@ Print the SIZE column in bytes rather than in human-readable format.
 Delete the specified partitions or all partitions.
 .TP
 .BR \-g , " \-\-noheadings"
-Do not print a header line.
+Do not print a header line with \fB\-\-show\fR or \fB\-\-raw\fR.
 .TP
 .BR \-l , " \-\-list"
 List the partitions.  Note that all numbers are in 512-byte sectors.
@@ -88,7 +89,8 @@ Specifies the lower and upper limits (e.g.\& \fB\-\-nr 2:4\fR).
 .TP
 .BR \-o , " \-\-output " \fIlist
 Define the output columns to use for
-.B \-\-show
+.BR \-\-show ,
+.B \-\-pairs
 and
 .B \-\-raw
 output.  If no output arrangement is specified, then a default set is
@@ -104,14 +106,16 @@ or
 options.
 .TP
 .BR \-P , " \-\-pairs"
-Output using key="value" format.
+List the partitions using the KEY="value" format.
 .TP
 .BR \-r , " \-\-raw"
-Use the raw output format.
+List the partitions using the raw output format.
 .TP
-.BR \-s , "\-\-show"
-List the partitions.  All numbers (except SIZE) are in 512-byte sectors.
-The output columns can be rearranged with the \fB\-\-output\fR option.
+.BR \-s , " \-\-show"
+List the partitions.
+The output columns can be selected and rearranged with the
+\fB\-\-output\fR option.
+All numbers (except SIZE) are in 512-byte sectors.
 .TP
 .BR \-t , " \-\-type " \fItype
 Specify the partition table type, which can be one of
-- 
1.7.0.4

