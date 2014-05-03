Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:50070 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696AbaECCcu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 May 2014 22:32:50 -0400
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Cc: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Subject: [PATCH 21/21] login-utils/login.1: Improve the typesetting of the manual
Date: Sat,  3 May 2014 02:32:39 +0000
Message-Id: <1399084359-28425-5-git-send-email-bjarniig@rhi.hi.is>
In-Reply-To: <1399084359-28425-1-git-send-email-bjarniig@rhi.hi.is>
References: <1399084359-28425-1-git-send-email-bjarniig@rhi.hi.is>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  Change macros [BI]R to [BI] when they have only one argument

  Change word approprate
to            appropriate

  Change word adminitrator
to            administrator

  Use a real apostrophe \(aq instead of ' (prints as a single right
quote) or \' (prints as an acute accent)

  Protect a full stop (.), that begins or ends a string, with \&

  Change "and if does not exist then"
to       "and, if it does not exist, then"

  Enlarge tilde (diacritic, accent) as it prints small in "troff"

  Change a macro I to IR and add a full stop (.) to end the sentence

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 login-utils/login.1 | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/login-utils/login.1 b/login-utils/login.1
index 3e9434f..5b105c5 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -6,17 +6,17 @@ login \- begin session on the system
 .SH SYNOPSIS
 .B login
 [
-.BR \-p
+.B \-p
 ] [
-.BR \-h
-.IR host
+.B \-h
+.I host
 ] [
-.BR \-H
+.B \-H
 ] [
-.BR \-f
-.IR username
+.B \-f
+.I username
 |
-.IR username
+.I username
 ]
 .SH DESCRIPTION
 .B login
@@ -24,7 +24,7 @@ is used when signing onto a system.  If no argument is given,
 .B login
 prompts for the username.
 .PP
-The user is then prompted for a password, where approprate.  Echoing
+The user is then prompted for a password, where appropriate.  Echoing
 is disabled to prevent revealing the password.  Only a small number
 of password failures are permitted before
 .B login
@@ -41,7 +41,7 @@ The user and group ID will be set according to their values in the
 .I /etc/passwd
 file.  There is one exception if the user ID is zero: in this case,
 only the primary group ID of the account is set.  This should allow
-the system adminitrator to login even in case of network problems.
+the system administrator to login even in case of network problems.
 The value for
 .BR $HOME ,
 .BR $USER ,
@@ -65,7 +65,7 @@ preserved if the
 .B \-p
 option is given) or be initialize to the terminal type on your tty.
 .PP
-Then the user's shell is started.  If no shell is specified for the
+Then the user\(aqs shell is started.  If no shell is specified for the
 user in
 .BR /etc\:/passwd ,
 then
@@ -119,7 +119,7 @@ with the
 .B \-h
 option the name is
 .IR remote .
-It is necessary to create a proper PAM config files (e.g.
+It is necessary to create a proper PAM config files (e.g.\&
 .I /etc\:/pam.d\:/login
 and
 .IR /etc\:/pam.d\:/remote ).
@@ -138,7 +138,7 @@ Display version information and exit.
 reads the
 .IR /etc\:/login.defs (5)
 configuration file.  Note that the configuration file could be
-distributed with another package (e.g. shadow-utils).  The following
+distributed with another package (e.g.\& shadow-utils).  The following
 configuration items are relevant for
 .BR login (1):
 .PP
@@ -184,9 +184,9 @@ login failure.  The default value is
 (string)
 .RS 4
 The terminal permissions.  The default value is
-.IR 0600
+.I 0600
 or
-.IR 0620
+.I 0620
 if tty group is used.
 .RE
 .PP
@@ -200,7 +200,7 @@ The default value is
 If the
 .B TTYGROUP
 does not exist then the ownership of the terminal is set to the
-user\'s primary group.
+user\(aqs primary group.
 .PP
 The
 .B TTYGROUP
@@ -211,19 +211,19 @@ can be either the name of a group or a numeric group identifier.
 (string)
 .RS 4
 If defined, this file can inhibit all the usual chatter during the
-login sequence.  If a full pathname (e.g.
+login sequence.  If a full pathname (e.g.\&
 .IR /etc\:/hushlogins )
-is specified, then hushed mode will be enabled if the user\'s name or
+is specified, then hushed mode will be enabled if the user\(aqs name or
 shell are found in the file.  If this global hush login file is empty
 then the hushed mode will be enabled for all users.
 .PP
 If not a full pathname is specified, then hushed mode will be enabled
-if the file exists in the user\'s home directory.
+if the file exists in the user\(aqs home directory.
 .PP
 The default is to check
 .I /etc\:/hushlogins
-and if does not exist then
-.I ~/.hushlogin
+and, if it does not exist, then
+.IR \s+3~\s0/.hushlogin .
 .PP
 If the
 .B HUSHLOGIN_FILE
@@ -307,7 +307,7 @@ does a vhangup() system call to remove any possible listening
 processes on the tty.  This is to avoid password sniffing.  If one
 uses the command
 .BR login ,
-then the surrounding shell gets killed by vhangup() because it's no
+then the surrounding shell gets killed by vhangup() because it\(aqs no
 longer the true owner of the tty.  This can be avoided by using
 .B exec login
 in a top-level shell or xterm.
-- 
1.9.0

