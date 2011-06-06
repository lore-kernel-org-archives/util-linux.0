Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63725 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712Ab1FFTHe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Jun 2011 15:07:34 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1471009ewy.19
        for <util-linux@vger.kernel.org>; Mon, 06 Jun 2011 12:07:34 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/6] docs: sfdisk manual update
Date: Mon,  6 Jun 2011 21:07:17 +0200
Message-Id: <1307387239-9022-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1307387239-9022-1-git-send-email-kerolasa@iki.fi>
References: <1307387239-9022-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add to manual page previously unmentioned options and few missing
long options.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisk/sfdisk.8 |   53 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/fdisk/sfdisk.8 b/fdisk/sfdisk.8
index f6e98c1..c3f06b3 100644
--- a/fdisk/sfdisk.8
+++ b/fdisk/sfdisk.8
@@ -165,7 +165,7 @@ Print version number of
 .B sfdisk
 and exit immediately.
 .TP
-.BR \-? " or " \-\-help
+.BR \-h " or " \-\-help
 Print a usage message and exit immediately.
 .TP
 .BR \-T " or " \-\-list\-types
@@ -184,7 +184,7 @@ the partition table.
 .BR \-l " or " \-\-list
 List the partitions of a device.
 .TP
-.BR \-d
+.BR \-d " or " \-\-dump
 Dump the partitions of a device in a format useful as input
 to sfdisk. For example,
 .br
@@ -218,7 +218,7 @@ and change nothing else. (Probably this fifth partition
 is called /dev/hdb5, but you are free to call it something else,
 like `/my_equipment/disks/2/5' or so).
 .TP
-.BI \-A " number"
+.BI \-A " or " \-\-activate " number"
 Make the indicated partition(s) active, and all others inactive.
 .TP
 .BI \-c "\fR or " \-\-id " number [Id]"
@@ -238,22 +238,22 @@ For example:
 .fi
 first reports that /dev/hdb5 has Id 6, and then changes that into 83.
 .TP
-.BR \-uS " or " \-uB " or " \-uC " or " \-uM
-Accept or report in units of sectors (blocks, cylinders, megabytes,
-respectively). The default is cylinders, at least when the geometry
-is known.
+.BR \-u " or " \-\-unit " SBCM"
+Accept as input, or when reporting show, in units of Sectors
+(Blocks, Cylinders, Megabytes, respectively). The default is
+cylinders, at least when the geometry is known.
 .TP
 .BR \-x " or " \-\-show\-extended
 Also list non-primary extended partitions on output,
 and expect descriptors for them on input.
 .TP
-.BI \-C " cylinders"
+.BI \-C " or " \-\-cylinders " cylinders"
 Specify the number of cylinders, possibly overriding what the kernel thinks.
 .TP
-.BI \-H " heads"
+.BI \-H " or " \-\-heads " heads"
 Specify the number of heads, possibly overriding what the kernel thinks.
 .TP
-.BI \-S " sectors"
+.BI \-S " or " \-\-sectors " sectors"
 Specify the number of sectors, possibly overriding what the kernel thinks.
 .TP
 .BR \-f " or " \-\-force
@@ -301,7 +301,7 @@ Sometimes the last cylinder contains a bad sector table.
 .B \-n
 Go through all the motions, but do not actually write to disk.
 .TP
-.B \-R
+.B \-R " or " \-\-re-read
 Only execute the BLKRRPART ioctl (to make the kernel re-read
 the partition table). This can be useful for checking in advance
 that the final BLKRRPART will be successful, and also when you
@@ -316,6 +316,33 @@ is not mounted, or in use as a swap device, and refuses to continue
 if it is. This option suppresses the test. (On the other hand, the \-f
 option would force sfdisk to continue even when this test fails.)
 .TP
+.B \-\-in\-order
+Caution, see warning section. To be documented.
+.TP
+.B \-\-not\-in\-order
+Caution, see warning section. To be documented.
+.TP
+.B \-\-inside\-order
+Caution, see warning section. Chaining order.
+.TP
+.B \-\-not\-inside\-order
+Caution, see warning section. Chaining order.
+.TP
+.B \-\-nested
+Caution, see warning section. Every partition is contained in the
+surrounding partitions and is disjoint from all others.
+.TP
+.B \-\-chained
+Caution, see warning section. Every data partition is contained in
+the surrounding partitions and disjoint from all others, but
+extended partitions may lie outside (insofar as allowed by
+all_logicals_inside_outermost_extended).
+.TP
+.B \-\-onesector
+Caution, see warning section. All data partitions are mutually
+disjoint; extended partitions each use one sector only (except
+perhaps for the outermost one).
+.TP
 .BI \-O " file"
 Just before writing the new partition, output the sectors
 that are going to be overwritten to
@@ -479,7 +506,11 @@ and terminate with end-of-file (^D).
 .B sfdisk
 will assume that your input line represents the first of four,
 that the second one is extended, and the 3rd and 4th are empty.)
+.SH "CAUTION WARNIGNS"
 
+The options marked with caution in the manual page are dangerous.
+For example all functionality is not completely implemented,
+which can be a reason for unexpected results.
 .SH "DOS 6.x WARNING"
 
 The DOS 6.x FORMAT command looks for some information in the first
-- 
1.7.5.2

