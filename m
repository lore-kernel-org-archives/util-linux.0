Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20329 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756036AbaDHHsy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Apr 2014 03:48:54 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s387mrjn017054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:48:54 -0400
Received: from redhat.brq.redhat.com (unused-4-202.brq.redhat.com [10.34.4.202])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s387moTk004800
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:48:53 -0400
From: Ondrej Oprala <ooprala@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 02/10] runuser: fix minor typos in the man page
Date: Tue,  8 Apr 2014 09:48:41 +0200
Message-Id: <1396943329-22347-3-git-send-email-ooprala@redhat.com>
In-Reply-To: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
References: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Ondrej Oprala <ooprala@redhat.com>
---
 login-utils/runuser.1 | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/login-utils/runuser.1 b/login-utils/runuser.1
index 7201ff0..34cc84d 100644
--- a/login-utils/runuser.1
+++ b/login-utils/runuser.1
@@ -15,22 +15,22 @@ runuser \- run a command with substitute user and group ID
 .SH DESCRIPTION
 .B runuser
 allows to run commands with substitute user and group ID.
-If the option \fB\-u\fR not given, fallback to
+If the option \fB\-u\fR is not given, falls back to
 .B su
-compatible semantic and shell is executed.
+compatible semantics and a shell is executed.
 The difference between the commands
 .B runuser
 and
 .B su
 is that
 .B runuser
-does not ask for password (because it may be executed by root user only) and
+does not ask for a password (because it may be executed by the root user only) and
 it uses a different PAM configuration.
 The command
 .B runuser
 does not have to be installed with suid permissions.
 .PP
-When called without arguments
+When called without arguments,
 .B runuser
 defaults to running an interactive shell as
 .IR root .
@@ -63,28 +63,28 @@ option.
 .TP
 \fB\-\-session\-command\fR=\fIcommand\fR
 Same as
-.B \-c
+.B \-c ,
 but do not create a new session (discouraged).
 .TP
 \fB\-f\fR, \fB\-\-fast\fR
 Pass
 .B \-f
-to the shell which may or may not be useful depending on the
+to the shell, which may or may not be useful depending on the
 shell.
 .TP
 \fB\-g\fR, \fB\-\-group\fR=\fIgroup\fR\fR
-specify the primary group, this option is allowed for root user only
+specify the primary group, this option is allowed to the root user only
 .TP
 \fB\-G\fR, \fB\-\-supp-group\fR=\fIgroup\fR\fR
-specify a supplemental group, this option is allowed for root user only
+specify a supplemental group, this option is allowed to the root user only
 .TP
 \fB\-\fR, \fB\-l\fR, \fB\-\-login\fR
-Starts the shell as login shell with an environment similar to a real
+Starts the shell as a login shell with an environment similar to a real
 login:
 .RS 10
 .TP
 o
-clears all environment variables except for
+clears all the environment variables except for
 .B TERM
 .TP
 o
@@ -105,7 +105,7 @@ in order to make the shell a login shell
 .RE
 .TP
 \fB\-m\fR, \fB\-p\fR, \fB\-\-preserve-environment\fR
-Preserves the whole environment, ie does not set
+Preserves the entire environment, i.e. does not set
 .BR HOME ,
 .BR SHELL ,
 .B USER
@@ -205,7 +205,7 @@ Generic error before executing the requested command
 The requested command could not be executed
 .TP
 127
-The requested command could was not found
+The requested command was not found
 .RE
 .SH FILES
 .PD 0
@@ -228,8 +228,8 @@ global logindef config file
 .BR login.defs (5),
 .BR su (1)
 .SH AUTHOR
-Derived from coreutils' su which was based on an implemenation from
-David MacKenzie and Fedora runuser command from Dan Walsh.
+Derived from coreutils' su which was based on an implemenation by
+David MacKenzie and the Fedora runuser command by Dan Walsh.
 .SH AVAILABILITY
 The runuser command is part of the util-linux package and is
 available from
-- 
1.8.5.1

