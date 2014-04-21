Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:47478 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284AbaDUAbg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 20 Apr 2014 20:31:36 -0400
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Cc: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Subject: [PATCH 1/4] partx.8: Improve the typesetting of the manual
Date: Mon, 21 Apr 2014 00:30:24 +0000
Message-Id: <1398040227-14535-1-git-send-email-bjarniig@rhi.hi.is>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  Add a space character around '|' (means "or")

  Add "(hyphen-minus)" after "\-" to show character name for input

  Change '\-\-' to '\en', when it is used as a dash (pause, separation)

  Add a comma before "or" in a series of words (3 or more)

  Change '-' to '\(en' (an en-dash), if it means a range

  Protect a full stop (.), that begins or ends a string, with \&

  Change '--' to '\-\-', if it indicates an option

  Change '-' to '\-', if it indicates an option

  Change '-' to '\-', if means a minus

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 disk-utils/partx.8 | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/disk-utils/partx.8 b/disk-utils/partx.8
index 33fbf3b..815b50a 100644
--- a/disk-utils/partx.8
+++ b/disk-utils/partx.8
@@ -8,9 +8,9 @@
 partx \- tell the Linux kernel about the presence and numbering of
 on-disk partitions
 .SH SYNOPSIS
-partx [\-a|\-d|\-s|\-u] [\-t TYPE] [\-n M:N] [\-] disk
+partx [\-a | \-d | \-s | \-u] [\-t TYPE] [\-n M:N] [\-] disk
 .br
-partx [\-a|\-d|\-s|\-u] [\-t TYPE] partition [disk]
+partx [\-a | \-d | \-s | \-u] [\-t TYPE] partition [disk]
 .SH DESCRIPTION
 Given a device or disk-image,
 .B partx
@@ -22,7 +22,7 @@ The
 argument is optional when a
 .I partition
 argument is provided.  To force scanning a partition as if it were a whole disk
-(for example to list nested subpartitions), use the argument "-".  For example:
+(for example to list nested subpartitions), use the argument "\-" (hyphen-minus).  For example:
 
 .RS 7
 .TP
@@ -33,7 +33,7 @@ This will see sda3 as a whole-disk rather than a partition.
 .PP
 The
 .B partx is not an fdisk program
-\-\- adding and removing partitions does not change the disk, it just
+\(en adding and removing partitions does not change the disk, it just
 tells the kernel about the presence and numbering of on-disk
 partitions.
 .SH OPTIONS
@@ -66,7 +66,7 @@ to get
 .I list
 of all supported columns.  This option cannot be combined with
 .BR \-\-add ,
-.B \-\-delete
+.BR \-\-delete ,
 or
 .B \-\-list
 options.
@@ -75,7 +75,7 @@ Output using key="value" format.
 .IP "\fB\-n\fR, \fB\-\-nr \fIM:N\fP"
 Specify the range of partitions.  For backward compatibility also the
 format
-.I M-N
+.I M\(enN
 is supported.  The range may contain negative numbers, for example
 .BI \-\-nr \ :\-1
 means the last partition, and
@@ -84,21 +84,21 @@ means the last two partitions.  Supported range specifications are:
 .RS 14
 .TP
 .I M
-Specifies just one partition (e.g. \fB\-\-nr\fR
+Specifies just one partition (e.g.\& \fB\-\-nr\fR
 .IR 3 ).
 .TP
 .I M:
-Specifies lower limit only (e.g. \fB\-\-nr\fR
+Specifies lower limit only (e.g.\& \fB\-\-nr\fR
 .IR 2: ).
 .TP
 .I :N
-Specifies upper limit only (e.g. \fB\-\-nr\fR
+Specifies upper limit only (e.g.\& \fB\-\-nr\fR
 .IR :4 ).
 .TP
 .IR M:N \ or
 .TQ
-.I M-N
-Specifies lower and upper limits (e.g. \fB--nr\fR
+.I M\(enN
+Specifies lower and upper limits (e.g.\& \fB\-\-nr\fR
 .IR 2:4 ).
 .RE
 .IP "\fB\-r\fR, \fB\-\-raw\fP"
@@ -119,7 +119,7 @@ Specify the partition table type
 .IR sgi ,
 .IR solaris_x86 ,
 .IR sun ,
-.I ultrix
+.IR ultrix ,
 or
 .IR unixware .
 .IP "\fB\-v\fR, \fB\-\-verbose\fP"
@@ -128,7 +128,7 @@ Verbose mode.
 .TP
 partx \-\-show /dev/sdb3
 .TQ
-partx \-\-show --nr 3 /dev/sdb
+partx \-\-show \-\-nr 3 /dev/sdb
 .TQ
 partx \-\-show /dev/sdb3 /dev/sdb
 All three commands list partition 3 of /dev/sdb.
@@ -137,17 +137,17 @@ partx \-\-show \- /dev/sdb3
 Lists all subpartitions on /dev/sdb3 (the device is used as
 whole-disk).
 .TP
-partx \-o START -g --nr 5 /dev/sdb
+partx \-o START \-g \-\-nr 5 /dev/sdb
 Prints the start sector of partition 5 on /dev/sdb without header.
 .TP
 partx \-o SECTORS,SIZE /dev/sda5 /dev/sda
 Lists the length in sectors and human-readable size of partition 5 on
 /dev/sda.
 .TP
-partx \-\-add --nr 3:5 /dev/sdd
+partx \-\-add \-\-nr 3:5 /dev/sdd
 Adds all available partitions from 3 to 5 (inclusive) on /dev/sdd.
 .TP
-partx \-d --nr :-1 /dev/sdd
+partx \-d \-\-nr :\-1 /dev/sdd
 Removes the last partition on /dev/sdd.
 .SH SEE ALSO
 .BR addpart (8),
@@ -166,7 +166,7 @@ Karel Zak
 .PP
 The original version was written by
 .MT aeb@cwi.nl
-Andries E. Brouwer
+Andries E.\& Brouwer
 .ME .
 .SH ENVIRONMENT
 .IP LIBBLKID_DEBUG=0xffff
-- 
1.9.0

