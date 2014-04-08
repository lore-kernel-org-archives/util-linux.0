Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15367 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755308AbaDHHsy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Apr 2014 03:48:54 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s387msmw008372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:48:54 -0400
Received: from redhat.brq.redhat.com (unused-4-202.brq.redhat.com [10.34.4.202])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s387moTl004800
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:48:54 -0400
From: Ondrej Oprala <ooprala@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 03/10] su: fix minor typos in the man page
Date: Tue,  8 Apr 2014 09:48:42 +0200
Message-Id: <1396943329-22347-4-git-send-email-ooprala@redhat.com>
In-Reply-To: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
References: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Ondrej Oprala <ooprala@redhat.com>
---
 login-utils/su.1 | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/login-utils/su.1 b/login-utils/su.1
index 55c0b8b..723ba15 100644
--- a/login-utils/su.1
+++ b/login-utils/su.1
@@ -39,7 +39,7 @@ This version of
 uses PAM for authentication, account and session management.  Some
 configuration options found in other
 .B su
-implementations, such as support of a wheel group, have to be
+implementations, such as support for a wheel group, have to be
 configured via PAM.
 .SH OPTIONS
 .TP
@@ -61,18 +61,18 @@ Pass
 to the shell, which may or may not be useful, depending on the shell.
 .TP
 \fB\-g\fR, \fB\-\-group\fR=\fIgroup\fR\fR
-Specify the primary group.  This option is available for the root user only.
+Specify the primary group.  This option is available to the root user only.
 .TP
 \fB\-G\fR, \fB\-\-supp-group\fR=\fIgroup\fR\fR
-Specify a supplemental group.  This option is available for the root user only.
+Specify a supplemental group.  This option is available to the root user only.
 .TP
 \fB\-\fR, \fB\-l\fR, \fB\-\-login\fR
-Starts the shell as login shell with an environment similar to a real
+Starts the shell as a login shell with an environment similar to a real
 login:
 .RS 10
 .TP
 o
-clears all environment variables except
+clears all the environment variables except
 .B TERM
 .TP
 o
@@ -93,7 +93,7 @@ in order to make the shell a login shell
 .RE
 .TP
 \fB\-m\fR, \fB\-p\fR, \fB\-\-preserve-environment\fR
-Preserves the whole environment, i.e. it does not set
+Preserves the entire environment, i.e. it does not set
 .BR HOME ,
 .BR SHELL ,
 .B USER
@@ -158,7 +158,7 @@ for
 .B FAIL_DELAY
 (number)
 .RS 4
-Delay in seconds in case of authentication failure.  Number must be
+Delay in seconds in case of an authentication failure. The number must be
 a non-negative integer.
 .RE
 .PP
@@ -209,7 +209,7 @@ Generic error before executing the requested command
 The requested command could not be executed
 .TP
 127
-The requested command could was not found
+The requested command was not found
 .RE
 .SH FILES
 .PD 0
@@ -234,7 +234,7 @@ the lastlog file at all.  This solution allows to control
 .B su
 behavior by PAM configuration.  If you want to use the pam_lastlog module to
 print warning message about failed log-in attempts then the pam_lastlog has to
-be configured to update lastlog file too. For example by:
+be configured to update the lastlog file as well. For example by:
 
 .RS
 .br
@@ -246,7 +246,7 @@ session  required  pam_lastlog.so nowtmp
 .BR shells (5),
 .BR login.defs (5)
 .SH AUTHOR
-Derived from coreutils' su which was based on an implementation from
+Derived from coreutils' su which was based on an implementation by
 David MacKenzie.
 .SH AVAILABILITY
 The su command is part of the util-linux package and is
-- 
1.8.5.1

