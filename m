Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f170.google.com ([209.85.215.170]:64383 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096Ab3GGTzB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:55:01 -0400
Received: by mail-ea0-f170.google.com with SMTP id h10so2504237eaj.29
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:55:00 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/34] docs: add missing options to sfdisk manual
Date: Sun,  7 Jul 2013 20:54:17 +0100
Message-Id: <1373226889-3451-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

And improve what is said about four of the dangerous options.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisks/sfdisk.8 | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/fdisks/sfdisk.8 b/fdisks/sfdisk.8
index 2b166fa..e42c5dd 100644
--- a/fdisks/sfdisk.8
+++ b/fdisks/sfdisk.8
@@ -326,6 +326,19 @@ DOS and Linux should interpret the partition table in the same way.
 Of course one can only know where cylinder boundaries are when
 one knows what geometry DOS will use for this disk.)
 .TP
+.BR \-U ", " "\-\-unhide " \fIdevice\fR
+Make various Microsoft partition types unhidden.  For full list see types
+output.
+.IP
+.nf
+.if t .ft CW
+    % sfdisk --list-types | grep Hidden
+.fi
+.IP
+Notice that the
+.B Hidden NTFS WinRE
+(Windows Recovery Environment) does not have non-hidden equivalent.
+.TP
 .BR \-\-IBM ", " \-\-leave\-last
 Certain IBM diagnostic programs assume that they can use the
 last cylinder on a disk for disk-testing purposes.  If you think
@@ -353,16 +366,18 @@ if it is.  This option suppresses the test.  (On the other hand, the \fB\-f\fR
 option would force \fBsfdisk\fR to continue even when this test fails.)
 .TP
 .B \-\-in\-order
-Caution, see warning section.  To be documented.
+Partitions are in order.  See also warning section.
 .TP
 .B \-\-not\-in\-order
-Caution, see warning section.  To be documented.
+Partitions are not in order.  See also warning section.
 .TP
 .B \-\-inside\-outer
-Caution, see warning section.  Chaining order.
+All logical partitions are inside outermost extended.  See also warning
+section and chaining.
 .TP
 .B \-\-not\-inside\-outer
-Caution, see warning section.  Chaining order.
+Some, or none, of the logical partitions are not inside outermost
+extended.  See also warning section and chaining.
 .TP
 .B \-\-nested
 Caution, see warning section.  Every partition is contained in the
@@ -392,6 +407,9 @@ After destroying your filesystems with an unfortunate
 .B sfdisk
 command, you would have been able to restore the old situation
 if only you had preserved it using the \fB\-O\fR flag.
+.TP
+.BR \-1 ", " \-\-one-only
+Reserved option that does nothing currently.
 
 .SH THEORY
 Block 0 of a disk (the Master Boot Record) contains among
-- 
1.8.3.2

