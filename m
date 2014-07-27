Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:63520 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751304AbaG0S7b (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 27 Jul 2014 14:59:31 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 6/6] docs: bring the runuser and su man pages closer to standard formatting
Date: Sun, 27 Jul 2014 20:59:00 +0200
Message-Id: <1406487540-10491-6-git-send-email-bensberg@justemail.net>
In-Reply-To: <1406487540-10491-1-git-send-email-bensberg@justemail.net>
References: <1406487540-10491-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 login-utils/runuser.1 |   77 +++++++++++++++++++++++-------------------------
 login-utils/su.1      |   49 +++++++++++++++----------------
 2 files changed, 61 insertions(+), 65 deletions(-)

diff --git a/login-utils/runuser.1 b/login-utils/runuser.1
index 34cc84d..3526c07 100644
--- a/login-utils/runuser.1
+++ b/login-utils/runuser.1
@@ -1,23 +1,19 @@
-.TH RUNUSER "1" "August 2012" "util-linux" "User Commands"
+.TH RUNUSER 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
 runuser \- run a command with substitute user and group ID
 .SH SYNOPSIS
-.B runuser
-[options] -u
-.IR user
+.BR runuser " [options] " \-u
+.I user
 .IR "command " [ argument ...]
 .LP
-.B runuser
-[options] [-]
-[
-.IR "user " [ argument ...]
-]
+.BR runuser " [options] [" \- ]
+.RI [ user " [" argument "...]]"
 .SH DESCRIPTION
 .B runuser
-allows to run commands with substitute user and group ID.
-If the option \fB\-u\fR is not given, falls back to
-.B su
-compatible semantics and a shell is executed.
+allows to run commands with a substitute user and group ID.
+If the option \fB\-u\fR is not given, it falls back to
+.BR su -compatible
+semantics and a shell is executed.
 The difference between the commands
 .B runuser
 and
@@ -35,7 +31,7 @@ When called without arguments,
 defaults to running an interactive shell as
 .IR root .
 .PP
-For backward compatibility
+For backward compatibility,
 .B runuser
 defaults to not change the current directory and to only set the
 environment variables
@@ -54,32 +50,27 @@ This version of
 uses PAM for session management.
 .SH OPTIONS
 .TP
-\fB\-c\fR \fIcommand\fR, \fB\-\-command\fR=\fIcommand\fR
+.BR \-c , " \-\-command" = \fIcommand
 Pass
 .I command
 to the shell with the
 .B \-c
 option.
 .TP
-\fB\-\-session\-command\fR=\fIcommand\fR
-Same as
-.B \-c ,
-but do not create a new session (discouraged).
-.TP
-\fB\-f\fR, \fB\-\-fast\fR
+.BR \-f , " \-\-fast"
 Pass
 .B \-f
 to the shell, which may or may not be useful depending on the
 shell.
 .TP
-\fB\-g\fR, \fB\-\-group\fR=\fIgroup\fR\fR
-specify the primary group, this option is allowed to the root user only
+.BR \-g , " \-\-group" = \fIgroup
+The primary group to be used.  This option is allowed for the root user only.
 .TP
-\fB\-G\fR, \fB\-\-supp-group\fR=\fIgroup\fR\fR
-specify a supplemental group, this option is allowed to the root user only
+.BR \-G , " \-\-supp-group" = \fIgroup
+A supplemental group to be used.  This option is allowed for the root user only.
 .TP
-\fB\-\fR, \fB\-l\fR, \fB\-\-login\fR
-Starts the shell as a login shell with an environment similar to a real
+.BR \- , " \-l" , " \-\-login"
+Start the shell as a login shell with an environment similar to a real
 login:
 .RS 10
 .TP
@@ -104,8 +95,8 @@ sets argv[0] of the shell to
 in order to make the shell a login shell
 .RE
 .TP
-\fB\-m\fR, \fB\-p\fR, \fB\-\-preserve-environment\fR
-Preserves the entire environment, i.e. does not set
+.BR \-m , " \-p" , " \-\-preserve-environment"
+Preserve the entire environment, i.e. it does not set
 .BR HOME ,
 .BR SHELL ,
 .B USER
@@ -113,9 +104,9 @@ nor
 .BR LOGNAME .
 The option is ignored if the option \fB\-\-login\fR is specified.
 .TP
-\fB\-s\fR \fISHELL\fR, \fB\-\-shell\fR=\fISHELL\fR
-Runs the specified shell instead of the default.  The shell to run is
-selected according to the following rules in order:
+.BR \-s , " \-\-shell" = \fIshell
+Run the specified \fIshell\fR instead of the default.  The shell to run is
+selected according to the following rules, in order:
 .RS 10
 .TP
 o
@@ -123,11 +114,11 @@ the shell specified with
 .B \-\-shell
 .TP
 o
-The shell specified in the environment variable
+the shell specified in the environment variable
 .B SHELL
 if the
 .B \-\-preserve-environment
-option is used.
+option is used
 .TP
 o
 the shell listed in the passwd entry of the target user
@@ -143,11 +134,16 @@ option and the
 .B SHELL
 environment variables are ignored unless the calling user is root.
 .TP
-\fB\-\-help\fR
-Display help text and exit.
+.BI \-\-session\-command= command
+Same as
+.B \-c ,
+but do not create a new session.  (Discouraged.)
 .TP
-\fB\-\-version\fR
+.BR \-V , " \-\-version"
 Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH CONFIG FILES
 .B runuser
 reads the
@@ -227,9 +223,10 @@ global logindef config file
 .BR shells (5),
 .BR login.defs (5),
 .BR su (1)
-.SH AUTHOR
-Derived from coreutils' su which was based on an implemenation by
-David MacKenzie and the Fedora runuser command by Dan Walsh.
+.SH HISTORY
+This \fB runuser\fR command was
+derived from coreutils' \fBsu\fR, which was based on an implemenation by
+David MacKenzie, and the Fedora \fBrunuser\fR command by Dan Walsh.
 .SH AVAILABILITY
 The runuser command is part of the util-linux package and is
 available from
diff --git a/login-utils/su.1 b/login-utils/su.1
index 723ba15..d063582 100644
--- a/login-utils/su.1
+++ b/login-utils/su.1
@@ -1,10 +1,8 @@
-.TH SU "1" "October 2013" "util-linux" "User Commands"
+.TH SU 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
 su \- run a command with substitute user and group ID
 .SH SYNOPSIS
-.B su
-.RI [ options ]
-.RB [ \- ]
+.BR su " [options] [" \- ]
 .RI [ user " [" argument ...]]
 .SH DESCRIPTION
 .B su
@@ -15,7 +13,7 @@ When called without arguments,
 defaults to running an interactive shell as
 .IR root .
 .PP
-For backward compatibility
+For backward compatibility,
 .B su
 defaults to not change the current directory and to only set the
 environment variables
@@ -43,31 +41,26 @@ implementations, such as support for a wheel group, have to be
 configured via PAM.
 .SH OPTIONS
 .TP
-\fB\-c\fR, \fB\-\-command\fR=\fIcommand\fR
+.BR \-c , " \-\-command" = \fIcommand
 Pass
 .I command
 to the shell with the
 .B \-c
 option.
 .TP
-\fB\-\-session\-command\fR=\fIcommand\fR
-Same as
-.B \-c
-but do not create a new session (discouraged).
-.TP
-\fB\-f\fR, \fB\-\-fast\fR
+.BR \-f , " \-\-fast"
 Pass
 .B \-f
 to the shell, which may or may not be useful, depending on the shell.
 .TP
-\fB\-g\fR, \fB\-\-group\fR=\fIgroup\fR\fR
+.BR \-g , " \-\-group" = \fIgroup
 Specify the primary group.  This option is available to the root user only.
 .TP
-\fB\-G\fR, \fB\-\-supp-group\fR=\fIgroup\fR\fR
+.BR \-G , " \-\-supp-group" = \fIgroup
 Specify a supplemental group.  This option is available to the root user only.
 .TP
-\fB\-\fR, \fB\-l\fR, \fB\-\-login\fR
-Starts the shell as a login shell with an environment similar to a real
+.BR \- , " \-l" , " \-\-login"
+Start the shell as a login shell with an environment similar to a real
 login:
 .RS 10
 .TP
@@ -92,8 +85,8 @@ sets argv[0] of the shell to
 in order to make the shell a login shell
 .RE
 .TP
-\fB\-m\fR, \fB\-p\fR, \fB\-\-preserve-environment\fR
-Preserves the entire environment, i.e. it does not set
+.BR \-m , " \-p" , " \-\-preserve-environment"
+Preserve the entire environment, i.e. it does not set
 .BR HOME ,
 .BR SHELL ,
 .B USER
@@ -101,8 +94,8 @@ nor
 .BR LOGNAME .
 This option is ignored if the option \fB\-\-login\fR is specified.
 .TP
-\fB\-s\fR, \fB\-\-shell\fR=\fIshell\fR
-Runs the specified \fIshell\fR instead of the default.  The shell to run is
+.BR \-s , " \-\-shell" = \fIshell
+Run the specified \fIshell\fR instead of the default.  The shell to run is
 selected according to the following rules, in order:
 .RS 10
 .TP
@@ -131,11 +124,16 @@ option and the
 .B SHELL
 environment variables are ignored unless the calling user is root.
 .TP
-\fB\-\-help\fR
-Display help text and exit.
+.BI \-\-session-command= command
+Same as
+.B \-c
+but do not create a new session.  (Discouraged.)
 .TP
-\fB\-\-version\fR
+.BR \-V , " \-\-version"
 Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .SH SIGNALS
 Upon receiving either
 .BR SIGINT ,
@@ -245,8 +243,9 @@ session  required  pam_lastlog.so nowtmp
 .BR pam (8),
 .BR shells (5),
 .BR login.defs (5)
-.SH AUTHOR
-Derived from coreutils' su which was based on an implementation by
+.SH HISTORY
+This \fBsu\fR command was
+derived from coreutils' \fBsu\fR, which was based on an implementation by
 David MacKenzie.
 .SH AVAILABILITY
 The su command is part of the util-linux package and is
-- 
1.7.0.4

