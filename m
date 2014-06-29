Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:57769 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751558AbaF2PzF (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 29 Jun 2014 11:55:05 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/7] docs: improve wording and formatting of the man page of lslogins
Date: Sun, 29 Jun 2014 17:49:39 +0200
Message-Id: <1404056983-10119-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1404056983-10119-1-git-send-email-bensberg@justemail.net>
References: <1404056983-10119-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Some typos, spacing, line breaks, and missing optional arguments.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 login-utils/lslogins.1 |   73 ++++++++++++++++++++++++-----------------------
 1 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/login-utils/lslogins.1 b/login-utils/lslogins.1
index efe9c58..1552020 100644
--- a/login-utils/lslogins.1
+++ b/login-utils/lslogins.1
@@ -5,22 +5,22 @@
 lslogins \- display information about known users in the system
 .SH SYNOPSIS
 .B lslogins
-[\fIoptions\fR] [-s|-u[\fI=UID\fR]] [-g \fIGROUPS\fR] [-l \fILOGINS\fR]
+[\fIoptions\fR] [\fB-s\fR|\fB-u\fR[=\fIUID\fR]] [\fB-g \fIgroups\fR] [\fB-l \fIlogins\fR]
 .SH DESCRIPTION
 .PP
 Examine the wtmp and btmp logs, /etc/shadow (if necessary) and /etc/passwd
 and output the desired data.
 .PP
-Mandatory arguments to long options are mandatory for short options too.
-.PP
 The default action is to list info about all the users in the system.
 .SH OPTIONS
-.PP
-Display info about existing users.
+Mandatory arguments to long options are mandatory for short options too.
 .TP
 \fB\-a\fR, \fB\-\-acc\-expiration\fR
 Display data about the date of last password change and the account expiration
-date (see shadow(5) for more info).  (Requires root priviliges.)
+date (see \fBshadow\fR(5) for more info).  (Requires root priviliges.)
+.TP
+\fB\-\-btmp\-file \fIpath\fP
+Alternate path for btmp.
 .TP
 \fB\-c\fR, \fB\-\-colon\-separate\fR
 Separate info about each user with a colon instead of a newline.
@@ -34,15 +34,20 @@ Display data about the users' last failed login attempts.
 \fB\-G\fR, \fB\-\-groups\-info\fR
 Show information about groups.
 .TP
-\fB\-g\fR, \fB\-\-groups\fR=\fIGROUPS\fR
-Only show data of users belonging to \fIGROUPS\fR. More than one group may be specified; the list has to be comma-separated.
+\fB\-g\fR, \fB\-\-groups\fR=\fIgroups\fR
+Only show data of users belonging to \fIgroups\fR.  More than one group
+may be specified; the list has to be comma-separated.
 .TP
-\fB\-l\fR, \fB\-\-logins\fR=\fILOGINS\fR
-Only show data of users with a login specified in \fILOGINS\fR. More than one login may be specified; the list has to be comma-separated.
+\fB\-h\fR, \fB\-\-help\fR
+Display help information and exit.
 .TP
-\fB\-L\fR, \-\-last\fR
+\fB\-L\fR, \fB\-\-last\fR
 Display data containing information about the users' last login sessions.
 .TP
+\fB\-l\fR, \fB\-\-logins\fR=\fIlogins\fR
+Only show data of users with a login specified in \fIlogins\fR (user names or user
+IDS).  More than one login may be specified; the list has to be comma-separated.
+.TP
 \fB\-m\fR, \fB\-\-supp\-groups\fR
 Show supplementary groups.
 .TP
@@ -52,51 +57,47 @@ Display each piece of information on a separate line.
 \fB\-\-notruncate\fR
 Don't truncate output.
 .TP
-\fB\-o , \-\-output \fIlist\fP
+\fB\-o\fR, \fB\-\-output \fIlist\fP
 Specify which output columns to print.  Use
 .B \-\-help
 to get a list of all supported columns.
 .TP
-\fB\-p , \-\-pwd\fR
-Display information related to login by password (see also \fB\-afR).
+\fB\-p\fR, \fB\-\-pwd\fR
+Display information related to login by password (see also \fB\-afL).
 .TP
 \fB\-r\fR, \fB\-\-raw\fR
 Raw output (no columnation).
 .TP
-\fB\-s\fR, \fB\-\-system\-accs\fR
-Show system accounts. These are by the default all accounts with UID below 1000 (non-inclusive), with the exception of either nobody or nfsnobody (UID 65534). The UID
-treshold can also be specified explicitly (necessary for some distributions that allocate UIDs
-starting from 100, 500 - or an entirely different value - rather than 1000).
+\fB\-s\fR, \fB\-\-system\-accs\fR[=\fIthreshold\fR]
+Show system accounts.  These are by default all accounts with a UID below 1000
+(non-inclusive), with the exception of either nobody or nfsnobody (UID 65534).  The UID
+threshold can also be specified explicitly (necessary for some distributions that
+allocate UIDs starting from 100, 500 - or an entirely different value - rather than 1000).
 .TP
 \fB\-\-time-format\fR \fItype\fP
-Display dates in short, full or iso format. The default is short, this time 
+Display dates in short, full or iso format.  The default is short, this time
 format is designed to be space efficient and human readable.
 .TP
-\fB\-u\fR, \fB\-\-user\-accs\fR
-Show user accounts. These are by the default all accounts with UID above 1000 (inclusive), with the exception of either nobody or nfsnobody (UID 65534). The UID
-treshold can also be specified explicitly (necessary for some distributions that allocate UIDs
-starting from 100, 500 - or an entirely different value - rather than 1000).
+\fB\-u\fR, \fB\-\-user\-accs\fR[=\fIthreshold\fR]
+Show user accounts.  These are by default all accounts with UID above 1000
+(inclusive), with the exception of either nobody or nfsnobody (UID 65534).  The UID
+threshold can also be specified explicitly (necessary for some distributions that
+allocate UIDs starting from 100, 500 - or an entirely different value - rather than 1000).
 .TP
-\fB\-z\fR, \fB\-\-print0\fR
-Delimit user entries with a nul character, instead of a newline.
-.TP
-\fB\-Z\fR, \fB\-\-context\fR
-Display the users' security context.
+\fB\-V\fR, \fB\-\-version\fR
+Display version information and exit.
 .TP
 \fB\-\-wtmp\-file \fIpath\fP
 Alternate path for wtmp.
 .TP
-\fB\-\-btmp\-file \fIpath\fP
-Alternate path for btmp.
-.TP
-\fB\-h\fR, \fB\-\-help\fR
-Display help information and exit.
+\fB\-Z\fR, \fB\-\-context\fR
+Display the users' security context.
 .TP
-\fB\-V\fR, \fB\-\-version\fR
-Display version information and exit.
+\fB\-z\fR, \fB\-\-print0\fR
+Delimit user entries with a nul character, instead of a newline.
 
 .SH NOTES
-The default UID tresholds are read from /etc/login.defs.
+The default UID thresholds are read from /etc/login.defs.
 
 .SH EXIT STATUS
 .TP
-- 
1.7.0.4

