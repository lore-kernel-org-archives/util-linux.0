Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:56851 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751304AbaG0S70 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 27 Jul 2014 14:59:26 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/6] docs: improve the formatting of the chfn and chsh man pages
Date: Sun, 27 Jul 2014 20:58:58 +0200
Message-Id: <1406487540-10491-4-git-send-email-bensberg@justemail.net>
In-Reply-To: <1406487540-10491-1-git-send-email-bensberg@justemail.net>
References: <1406487540-10491-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also fix a pasting mistake where the chfn man page suggested
to use ypchsh or lchsh for non-local entries.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 login-utils/chfn.1 |   38 +++++++++++++++++---------------------
 login-utils/chsh.1 |   24 ++++++++++--------------
 2 files changed, 27 insertions(+), 35 deletions(-)

diff --git a/login-utils/chfn.1 b/login-utils/chfn.1
index 3b44fb3..564fed3 100644
--- a/login-utils/chfn.1
+++ b/login-utils/chfn.1
@@ -2,15 +2,11 @@
 .\"  chfn.1 -- change your finger information
 .\"  (c) 1994 by salvatore valente <svalente@athena.mit.edu>
 .\"
-.\"  this program is free software.  you can redistribute it and
-.\"  modify it under the terms of the gnu general public license.
-.\"  there is no warranty.
+.\"  This program is free software.  You can redistribute it and
+.\"  modify it under the terms of the GNU General Public License.
+.\"  There is no warranty.
 .\"
-.\"  $Author: faith $
-.\"  $Revision: 1.1 $
-.\"  $Date: 1995/03/12 01:29:16 $
-.\"
-.TH CHFN 1 "July 2009" "util-linux" "User Commands"
+.TH CHFN 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
 chfn \- change your finger information
 .SH SYNOPSIS
@@ -38,40 +34,40 @@ program.  The Linux
 command will display four pieces of information that can be changed by
 .BR chfn :
 your real name, your work room and phone, and your home phone.
-
-.B chfn
-supports non-local entries (kerberos, LDAP, etc.\&) if linked with libuser,
-otherwise use ypchsh, lchsh or any other implementation for non-local
-entries.
-.SS COMMAND LINE
+.PP
 Any of the four pieces of information can be specified on the command
 line.  If no information is given on the command line,
 .B chfn
 enters interactive mode.
-.SS INTERACTIVE MODE
+.PP
 In interactive mode,
 .B chfn
 will prompt for each field.  At a prompt, you can enter the new information,
 or just press return to leave the field unchanged.  Enter the keyword
 "none" to make the field blank.
+.PP
+.B chfn
+supports non-local entries (kerberos, LDAP, etc.\&) if linked with libuser,
+otherwise use \fBypchfn\fR, \fBlchfn\fR or any other implementation for
+non-local entries.
 .SH OPTIONS
 .TP
-.BI "\-f, \-\-full-name " full-name
+.BR \-f , " \-\-full-name " \fIfull-name
 Specify your real name.
 .TP
-.BI "\-o, \-\-office " office
+.BR \-o , " \-\-office " \fIoffice
 Specify your office room number.
 .TP
-.BI "\-p, \-\-office-phone " office-phone
+.BR \-p , " \-\-office-phone " \fIoffice-phone
 Specify your office phone number.
 .TP
-.BI "\-h, \-\-home-phone " home-phone
+.BR \-h , " \-\-home-phone " \fIhome-phone
 Specify your home phone number.
 .TP
-.B "\-u, \-\-help"
+.BR \-u , " \-\-help"
 Display help text and exit.
 .TP
-.B "\-v, \-\-version"
+.BR \-v , " \-\-version"
 Display version information and exit.
 .SH "EXIT STATUS"
 Returns 0 if operation was successful, 1 if operation failed or command syntax was not valid.
diff --git a/login-utils/chsh.1 b/login-utils/chsh.1
index 229f5e1..eb59c5c 100644
--- a/login-utils/chsh.1
+++ b/login-utils/chsh.1
@@ -2,15 +2,11 @@
 .\"  chsh.1 -- change your login shell
 .\"  (c) 1994 by salvatore valente <svalente@athena.mit.edu>
 .\"
-.\"  this program is free software.  you can redistribute it and
-.\"  modify it under the terms of the gnu general public license.
-.\"  there is no warranty.
+.\"  This program is free software.  You can redistribute it and
+.\"  modify it under the terms of the GNU General Public License.
+.\"  There is no warranty.
 .\"
-.\"  $Author: faith $
-.\"  $Revision: 1.1 $
-.\"  $Date: 1995/03/12 01:28:58 $
-.\"
-.TH CHSH 1 "July 2009" "util-linux" "User Commands"
+.TH CHSH 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
 chsh \- change your login shell
 .SH SYNOPSIS
@@ -30,22 +26,22 @@ prompts for one.
 
 .B chsh
 supports non-local entries (kerberos, LDAP, etc.\&) if linked with libuser,
-otherwise use ypchsh, lchsh or any other implementation for non-local
-entries.
+otherwise use \fBypchsh\fR, \fBlchsh\fR or any other implementation for
+non-local entries.
 .SH OPTIONS
 .TP
-.BI "\-s, \-\-shell " shell
+.BR \-s , " \-\-shell " \fIshell
 Specify your login shell.
 .TP
-.B "\-l, \-\-list-shells"
+.BR \-l , " \-\-list-shells"
 Print the list of shells listed in
 .I /etc/shells
 and exit.
 .TP
-.B "\-u, \-\-help"
+.BR \-u , " \-\-help"
 Display help text and exit.
 .TP
-.B "\-v, \-\-version"
+.BR \-v , " \-\-version"
 Display version information and exit.
 .SH "VALID SHELLS"
 .B chsh
-- 
1.7.0.4

