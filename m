Return-Path: util-linux-owner@vger.kernel.org
Received: from hapkido.dreamhost.com ([66.33.216.122]:38827 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758027Ab1CaPA1 (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 31 Mar 2011 11:00:27 -0400
Received: from homiemail-a6.g.dreamhost.com (caiajhbdccah.dreamhost.com [208.97.132.207])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 46C7F17A5A8
	for <util-linux-ng@vger.kernel.org>; Thu, 31 Mar 2011 08:00:27 -0700 (PDT)
Subject: [PATCH 2/3] mkfs.minix: document mfs3 changes
From: Davidlohr Bueso <dave@gnu.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux-ng <util-linux-ng@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 31 Mar 2011 11:59:33 -0300
Message-ID: <1301583573.2159.16.camel@offworld>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Update the mkfs.minix manpage for new options and amount of characters for a filename.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 disk-utils/mkfs.minix.8 |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/disk-utils/mkfs.minix.8 b/disk-utils/mkfs.minix.8
index 9359106..da503e0 100644
--- a/disk-utils/mkfs.minix.8
+++ b/disk-utils/mkfs.minix.8
@@ -1,4 +1,4 @@
-.\" Copyright 1992, 1993, 1994 Rickard E. Faith (faith@cs.unc.edu)
+.\" Copyright 1992, 1993, 1994 Rickard E. Faith (faith@cs.unc.edu) - updated by Davidlohr Bueso <dave@gnu.og> 2011.
 .\" May be freely distributed.
 .TH MKFS.MINIX 8 "2 July 1996" "Util-linux 2.6" "Linux System Administrator's Manual"
 .SH NAME
@@ -46,12 +46,12 @@ are found, the count is printed.
 .TP
 .BI \-n " namelength"
 Specify the maximum length of filenames.
-Currently, the only allowable values are 14 and 30.
+Currently, the only allowable values are 14, 30 and 60 (v3 specific).
 The default is 30. Note that kernels older than 0.99p7
 only accept namelength 14.
 .TP
 .BI \-i " inodecount"
-Specify the number of inodes for the filesystem.
+	Specify the number of inodes for the filesystem.
 .TP
 .BI \-l " filename"
 Read the bad blocks list from
@@ -59,8 +59,17 @@ Read the bad blocks list from
 The file has one bad block number per line.  The count of bad blocks read
 is printed.
 .TP
-.B \-v
+.B \-1
+Make a Minix version 1 filesystem.
+.TP
+.B \-2, \-v
 Make a Minix version 2 filesystem.
+.TP
+.B \-3
+Make a Minix version 3 filesystem.
+.TP
+.BI \-B " blocksize"
+Specify the block size to use (only for v3)
 .SH "EXIT CODES"
 The exit code returned by
 .B mkfs.minix
-- 
1.7.1




