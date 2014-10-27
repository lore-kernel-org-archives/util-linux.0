Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:55451 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752287AbaJ0VSU (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Oct 2014 17:18:20 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/4] docs: fix some wording and formatting in man page of swapon
Date: Mon, 27 Oct 2014 22:18:11 +0100
Message-Id: <1414444693-16407-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1414444693-16407-1-git-send-email-bensberg@justemail.net>
References: <1414444693-16407-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/swapon.8 |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/sys-utils/swapon.8 b/sys-utils/swapon.8
index e88e2f1..2aa6fe2 100644
--- a/sys-utils/swapon.8
+++ b/sys-utils/swapon.8
@@ -38,7 +38,7 @@
 .\" Mon Sep 25 14:12:38 1995: Added -v and -p information
 .\" Tue Apr 30 03:32:07 1996: Added some text from A. Koppenhoefer
 .\"
-.TH SWAPON 8 "July 2014" "util-linux" "System Administration"
+.TH SWAPON 8 "October 2014" "util-linux" "System Administration"
 .SH NAME
 swapon, swapoff \- enable/disable devices and files for paging and swapping
 .SH SYNOPSIS
@@ -131,14 +131,15 @@ Use the partition that has the specified
 is needed.)
 .TP
 .BR \-o , " \-\-options " \fIopts\fP
-Specify swap options by fstab compatible comma separated string. For example:
+Specify swap options by an fstab-compatible comma-separated string.
+For example:
 .RS
 .RS
 .sp
 .B "swapon -o pri=1,discard=pages,nofail /dev/sda2"
 .sp
 .RE
-The \fIopts\fP string is evaluated as the last and overrides all another
+The \fIopts\fP string is evaluated last and overrides all other
 options.
 .RE
 .TP
@@ -154,15 +155,15 @@ to the option field of
 .I /etc/fstab
 for use with
 .BR "swapon -a" .
-When priority is not defined it defaults to \-1.
+When no priority is defined, it defaults to \-1.
 .TP
 .BR \-s , " \-\-summary"
 Display swap usage summary by device.  Equivalent to "cat /proc/swaps".
 Not available before Linux 2.1.25.  This output format is DEPRECATED in favour
 of \fB\-\-show\fR that provides better control on output data.
 .TP
-.BR " \-\-show" [ =\fIcolumn\fR]
-Display definable table of swap areas. See
+.BR \-\-show [ =\fIcolumn\fR ...]
+Display a definable table of swap areas.  See the
 .B \-\-help
 output for a list of available columns.
 .TP
@@ -185,10 +186,10 @@ output instead of in user-friendly units.
 Use the partition that has the specified
 .IR uuid .
 .TP
-.B "\-v, \-\-verbose"
+.BR \-v , " \-\-verbose"
 Be verbose.
 .TP
-.B "\-V, \-\-version"
+.BR \-V , " \-\-version"
 Display version information and exit.
 .SH NOTES
 You should not use
-- 
1.7.0.4

