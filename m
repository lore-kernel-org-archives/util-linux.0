Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:58008 "EHLO
	cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752287AbaJ0VST (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Oct 2014 17:18:19 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/4] docs: spelling, wording, and grammar fixes in the man page of whereis
Date: Mon, 27 Oct 2014 22:18:10 +0100
Message-Id: <1414444693-16407-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 misc-utils/whereis.1 |   37 +++++++++++++++++++------------------
 1 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/misc-utils/whereis.1 b/misc-utils/whereis.1
index e8e4327..243fc14 100644
--- a/misc-utils/whereis.1
+++ b/misc-utils/whereis.1
@@ -30,7 +30,7 @@
 .\" SUCH DAMAGE.
 .\"
 .\" @(#)whereis.1 from UCB 4.2
-.TH WHEREIS 1 "March 2013" "util-linux" "User Commands"
+.TH WHEREIS 1 "October 2014" "util-linux" "User Commands"
 .SH NAME
 whereis \- locate the binary, source, and manual page files for a command
 .SH SYNOPSIS
@@ -56,26 +56,27 @@ in the places specified by
 .B $PATH
 and
 .BR $MANPATH .
-
-The search restrinctions (options \fB\-b\fP, \fB\-m\fP and \fB\-s\fP) are
-cumulative and always applied for the next \fIname\fP patterns specified on
-command line. The first search restrinction resets the search mask. For example
+.sp
+The search restrictions (options \fB\-b\fP, \fB\-m\fP and \fB\-s\fP)
+are cumulative and apply to the subsequent \fIname\fP patterns on
+the command line.  Any new search restriction resets the search mask.
+For example,
 .RS
 .sp
 .B "whereis -bm ls tr -m gcc"
 .sp
 .RE
-searchs for "ls" and "tr" binaries and man pages, and "gcc" man pages only.
-
-The options \fB\-B\fP, \fB\-M\fP and \fB\-S\fP resets search paths for the next
-\fIname\fP patterns. For example
+searches for "ls" and "tr" binaries and man pages, and for "gcc" man pages only.
+.sp
+The options \fB\-B\fP, \fB\-M\fP and \fB\-S\fP reset search paths for the
+subsequent \fIname\fP patterns.  For example,
 .RS
 .sp
 .B "whereis -m ls -M /usr/share/man/man1 -f cal"
 .sp
 .RE
-searchs for "ls" man pages in all default paths, but for "cal" in
-/usr/share/man/man1 directory only.
+searches for "ls" man pages in all default paths, but for "cal" in
+the /usr/share/man/man1 directory only.
 
 .SH OPTIONS
 .TP
@@ -114,15 +115,15 @@ or
 .BR \-S
 options is used.
 .IP "\fB\-l"
-Output list of effective lookup paths the
+Output the list of effective lookup paths that
 .B whereis
-is using.  When non of
+is using.  When none of
 .BR \-B ,
 .BR \-M ,
 or
 .BR \-S
-is specified the option will out hard coded paths that the command was able to
-find on system.
+is specified, the option will output the hard-coded paths
+that the command was able to find on the system.
 .SH EXAMPLE
 To find all files in
 .B /usr/\:bin
@@ -132,14 +133,14 @@ in
 or have no source in
 .BR /usr/\:src :
 .IP
-.B $ cd /usr/bin
+.B cd /usr/bin
 .br
-.B $ whereis \-u \-ms \-M /usr/man/man1 \-S /usr/src \-f *
+.B whereis \-u \-ms \-M /usr/man/man1 \-S /usr/src \-f *
 .SH "FILE SEARCH PATHS"
 By default
 .B whereis
 tries to find files from hard-coded paths, which are defined with glob
-patterns. The command attempst to use contents of
+patterns.  The command attempst to use contents of
 .B $PATH
 and
 .B $MANPATH
-- 
1.7.0.4

