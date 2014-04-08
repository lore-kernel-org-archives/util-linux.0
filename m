Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28450 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756272AbaDHHtA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Apr 2014 03:49:00 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s387n0hR017087
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:49:00 -0400
Received: from redhat.brq.redhat.com (unused-4-202.brq.redhat.com [10.34.4.202])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s387moTr004800
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:48:59 -0400
From: Ondrej Oprala <ooprala@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 09/10] cfdisk: minor man page improvements
Date: Tue,  8 Apr 2014 09:48:48 +0200
Message-Id: <1396943329-22347-10-git-send-email-ooprala@redhat.com>
In-Reply-To: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
References: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Ondrej Oprala <ooprala@redhat.com>
---
 disk-utils/cfdisk.8 | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/disk-utils/cfdisk.8 b/disk-utils/cfdisk.8
index 64197ef..01bde08 100644
--- a/disk-utils/cfdisk.8
+++ b/disk-utils/cfdisk.8
@@ -14,7 +14,7 @@
 .\" " for hilit mode
 .TH CFDISK 8 "March 2014" "util-linux" "System Administration"
 .SH NAME
-cfdisk \- display or manipulate disk partition table
+cfdisk \- display or manipulate a disk partition table
 .SH SYNOPSIS
 .B cfdisk
 .RB [ options ]
@@ -26,13 +26,13 @@ The default device is /dev/sda.
 
 Note that
 .B cfdisk
-provides basic partitioning functionality by user friendly interface. If you
-need advanced features then use 
+provides basic partitioning functionality by a user friendly interface. If you
+need advanced features, use 
 .BR fdisk (8).
 
 Since version 2.25
 .BR cfdisk (8)
-supports MBR (DOS), GPT, SUN and SGI disk labels, but it does not provides any
+supports MBR (DOS), GPT, SUN and SGI disk labels, but it does not provide any
 functionality in regards to CHS (Cylinder-Head-Sector) addressing. CHS has
 never been important for Linux and this addressing concept does not make any
 sense for new devices.
@@ -44,9 +44,9 @@ utils
 .BR partx (8)
 and
 .BR lsblk (8)
-in very comfortable and rich way.
+in a very comfortable and rich way.
 
-If you want to remove an old partition table from device than use
+If you want to remove an old partition table from a device, use
 .BR wipefs (8).
 
 .SH OPTIONS
@@ -55,7 +55,7 @@ Display help text and exit.
 .IP "\fB\-L\fR, \fB\-\-color\fR[=\fIwhen\fR]"
 Colorize output, enabled by default.  The optional argument \fIwhen\fP can be
 \fBauto\fR, \fBnever\fR or \fBalways\fR.  If the \fIwhen\fR argument is omitted,
-then it defaults to \fBauto\fR.
+it defaults to \fBauto\fR.
 .IP "\fB-V, \-\-version"
 Display version information and exit.
 
@@ -67,9 +67,9 @@ after the command is not necessary).  Here is a list of the available
 commands:
 .TP
 .B b
-Toggle bootable flag of the current partition.  This allows you to
-select which primary partition is bootable on the drive. This command does not
-have to available for all partition label types.
+Toggle the bootable flag of the current partition.  This allows you to
+select which primary partition is bootable on the drive. This command may not
+be available for all partition label types.
 .TP
 .B d
 Delete the current partition.  This will convert the current partition
@@ -92,8 +92,8 @@ MiB=1024*1024, and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB"
 is optional, e.g. "K" has the same meaning as  "KiB")
 .TP
 .B q
-Quit program.  This will exit the program without writing any data to
-disk.
+Quit the program.  This will exit the program without writing any data to
+the disk.
 .TP
 .B t
 Change the partition type.  By default, new partitions are created as
-- 
1.8.5.1

