Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:65392 "EHLO
	cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752813AbcCNJKn (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 05:10:43 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/4] fallocate: improve synopsis and spelling in man page
Date: Mon, 14 Mar 2016 10:10:11 +0100
Message-Id: <1457946613-2435-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1457946613-2435-1-git-send-email-bensberg@justemail.net>
References: <1457946613-2435-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/fallocate.1 |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/sys-utils/fallocate.1 b/sys-utils/fallocate.1
index dd9f293..5421a11 100644
--- a/sys-utils/fallocate.1
+++ b/sys-utils/fallocate.1
@@ -3,14 +3,12 @@
 fallocate \- preallocate or deallocate space to a file
 .SH SYNOPSIS
 .B fallocate
-.RB [ \-c ]
-.RB [ \-n ]
-.RB [ \-p ]
-.RB [ \-z ]
+.RB [ \-c | \-p | -z ]
 .RB [ \-o
 .IR offset ]
 .B \-l
 .IR length
+.RB [ \-n ]
 .I filename
 .PP
 .B fallocate \-d
@@ -25,7 +23,7 @@ is used to manipulate the allocated disk space for a file, either to deallocate
 or preallocate it.  For filesystems which support the fallocate system call,
 preallocation is done quickly by allocating blocks and marking them as
 uninitialized, requiring no IO to the data blocks.  This is much faster than
-creating a file by filling it with zeros.
+creating a file by filling it with zeroes.
 .PP
 The exit code returned by
 .B fallocate
@@ -46,7 +44,7 @@ to be collapsed starts at \fIoffset\fP and continues
 for \fIlength\fR bytes.  At the completion of the operation, the contents of
 the file starting at the location \fIoffset\fR+\fIlength\fR will be appended at the
 location \fIoffset\fR, and the file will be \fIlength\fR bytes smaller.  The option
-\fB\-\-keep\-size\fR may not be specified for colapse range operation.
+\fB\-\-keep\-size\fR may not be specified for the collapse-range operation.
 .sp
 Available since Linux 3.15 for ext4 (only for extent-based files) and XFS.
 .TP
-- 
1.7.0.4

