Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:65517 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753460AbbLCUMe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 3 Dec 2015 15:12:34 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] lsns: improve formatting and wording of the man page
Date: Thu,  3 Dec 2015 21:12:28 +0100
Message-Id: <1449173548-24200-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/lsns.8 |   31 ++++++++++++++-----------------
 1 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/sys-utils/lsns.8 b/sys-utils/lsns.8
index 665f6f9..fd8cfc6 100644
--- a/sys-utils/lsns.8
+++ b/sys-utils/lsns.8
@@ -1,4 +1,4 @@
-.\" Man page for the lslocks command.
+.\" Man page for the lsns command.
 .\" Copyright 2015 Karel Zak <kzak@redhat.com>
 .\" May be distributed under the GNU General Public License
 
@@ -8,9 +8,7 @@ lsns \- list namespaces
 .SH SYNOPSIS
 .B lsns
 [options]
-.RB [
-.I namespace
-.RB ]
+.RI [ namespace ]
 
 .SH DESCRIPTION
 .B lsns
@@ -19,16 +17,16 @@ given \fInamespace\fP.  The \fInamespace\fP identifier is an inode number.
 
 The default output is subject to change.  So whenever possible, you should
 avoid using default outputs in your scripts.  Always explicitly define expected
-columns by using --output columns-list in environments where a stable output is
-required.
+columns by using the \fB\-\-output\fR option together with a columns list in
+environments where a stable output is required.
 
-Note that lsns reads information directly from /proc filesystem and for
-non-root users it may returns incomplete information.  The current 
-/proc filesystem may be unshared and affected by PID namespace (see \fBunshare --mount-proc\fP
-for more details).
+Note that \fBlsns\fR reads information directly from the /proc filesystem and
+for non-root users it may return incomplete information.  The current /proc
+filesystem may be unshared and affected by a PID namespace
+(see \fBunshare \-\-mount\-proc\fP for more details).
 .B lsns
-is not able to see persistent namespaces without processes where the namespace 
-instance is hold by the bind mount to /proc/[pid]/ns/[type].
+is not able to see persistent namespaces without processes where the namespace
+instance is held by a bind mount to /proc/\fIpid\fR/ns/\fItype\fR.
 
 .SH OPTIONS
 .TP
@@ -42,12 +40,11 @@ Use list output format.
 Do not print a header line.
 .TP
 .BR \-o , " \-\-output " \fIlist\fP
-Specify which output columns to print.  Use
-.B "--help"
+Specify which output columns to print.  Use \fB\-\-help\fR
 to get a list of all supported columns.
 
 The default list of columns may be extended if \fIlist\fP is
-specified in the format \fI+list\fP (e.g. \fBlsns -o +PATH\fP).
+specified in the format \fB+\fIlist\fP (e.g. \fBlsns \-o +PATH\fP).
 .TP
 .BR \-p , " \-\-task " \fIpid\fP
 Display only the namepsaces held by the process with this \fIpid\fR.
@@ -56,8 +53,8 @@ Display only the namepsaces held by the process with this \fIpid\fR.
 Use the raw output format.
 .TP
 .BR \-t , " \-\-type " \fItype\fP
-Display specified \fItype\fP of the namespaces only. The supported types are
-\fBmnt\fP, \fBnet\fP, \fBipc\fP, \fBuser\fP, \fBpid\fP and \fButs\fP. This
+Display the specified \fItype\fP of namespaces only.  The supported types are
+\fBmnt\fP, \fBnet\fP, \fBipc\fP, \fBuser\fP, \fBpid\fP and \fButs\fP.  This
 option may be given more than once.
 .TP
 .BR \-u , " \-\-notruncate"
-- 
1.7.0.4

