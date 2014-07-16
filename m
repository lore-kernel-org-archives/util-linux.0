Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:59024 "EHLO
	cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751016AbaGPLKE (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Jul 2014 07:10:04 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/3] docs: improve the formatting and wording of two man pages
Date: Wed, 16 Jul 2014 13:09:51 +0200
Message-Id: <1405508993-8097-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 login-utils/sulogin.8  |   39 ++++++++++++++++++++-------------------
 login-utils/utmpdump.1 |   16 ++++++++--------
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/login-utils/sulogin.8 b/login-utils/sulogin.8
index 57a7118..17b07da 100644
--- a/login-utils/sulogin.8
+++ b/login-utils/sulogin.8
@@ -1,4 +1,3 @@
-'\" -*- coding: UTF-8 -*-
 .\" Copyright (C) 1998-2006 Miquel van Smoorenburg.
 .\" Copyright (C) 2012 Karel Zak <kzak@redhat.com>
 .\"
@@ -16,18 +15,17 @@
 .\" along with this program; if not, write to the Free Software
 .\" Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 .\"
-.TH SULOGIN "8" "Jul 2012" "util-linux" "System Administration"
+.TH SULOGIN "8" "July 2014" "util-linux" "System Administration"
 .SH NAME
-sulogin \- Single-user login
+sulogin \- single-user login
 .SH SYNOPSIS
-.B sulogin
-.RB [ options ]
-.RB [ tty ]
+.BR sulogin " [options]"
+.RI [ tty ]
 .SH DESCRIPTION
-.I sulogin
+.B sulogin
 is invoked by
 .B init
-when the system goes into single user mode.
+when the system goes into single-user mode.
 .PP
 The user is prompted:
 .IP "" .5i
@@ -35,40 +33,43 @@ Give root password for system maintenance
 .br
 (or type Control\-D for normal startup):
 .PP
-.I sulogin
-will be connected to the current terminal, or to the optional tty device that
+.B sulogin
+will be connected to the current terminal, or to the optional \fItty\fR device that
 can be specified on the command line (typically
 .BR /dev/console ).
 .PP
-After the user exits the single-user shell or presses control\-D at the
+When the user exits from the single-user shell, or presses control\-D at the
 prompt, the system will continue to boot.
 .SH OPTIONS
 .IP "\fB\-e\fR, \fB\-\-force\fP"
-If the default method of obtaining the root password via
+If the default method of obtaining the root password from the system via
 .BR getpwnam (3)
-from the system fails, manually examine
+fails, then examine
 .I /etc/passwd
 and
 .I /etc/shadow
-to get the password.  If they are damaged or nonexistent, sulogin will start
-a root shell without asking for a password.
+to get the password.  If these files are damaged or nonexistent,
+.B sulogin
+will start a root shell without asking for a password.
 .IP
 Only use the
 .B \-e
 option if you are sure the console is physically protected against
 unauthorized access.
 .IP "\fB\-p\fR, \fB\-\-login\-shell\fP"
-Specifying this option causes sulogin to start the shell process as a login
-shell.
+Specifying this option causes
+.B sulogin
+to start the shell process as a login shell.
 .IP "\fB\-t\fR, \fB\-\-timeout \fIseconds\fP"
 Specify the maximum amount of time to wait for user input.  By default,
-sulogin will wait forever.
+.B sulogin
+will wait forever.
 .IP "\fB\-h\fR, \fB\-\-help\fP"
 Display help text and exit.
 .IP "\fB\-V\fR, \fB\-\-version\fP"
 Display version information and exit.
 .SH ENVIRONMENT VARIABLES
-.I sulogin
+.B sulogin
 looks for the environment variable
 .B SUSHELL
 or
diff --git a/login-utils/utmpdump.1 b/login-utils/utmpdump.1
index 7a7442a..933a3c9 100644
--- a/login-utils/utmpdump.1
+++ b/login-utils/utmpdump.1
@@ -1,4 +1,3 @@
-'\" -*- coding: UTF-8 -*-
 .\" Copyright (C) 2010 Michael Krapp
 .\"
 .\" This program is free software; you can redistribute it and/or modify
@@ -19,7 +18,8 @@
 .SH NAME
 utmpdump \- dump UTMP and WTMP files in raw format
 .SH SYNOPSIS
-utmpdump [\-frohV] [ filename ]
+.BR utmpdump " [options]"
+.RI [ filename ]
 .SH DESCRIPTION
 .B utmpdump
 is a simple program to dump UTMP and WTMP files in raw format, so they
@@ -31,10 +31,10 @@ is passed.
 .SH OPTIONS
 .IP "\fB\-f\fR, \fB\-\-follow\fP"
 Output appended data as the file grows.
-.IP "\fB\-r\fR, \fB\-\-reverse\fP
-Undump, write back edited login information into the utmp or wtmp files.
 .IP "\fB\-o\fR, \fB\-\-output\fP \fIfile\fR
 Write command output to \fIfile\fR instead of standard output.
+.IP "\fB\-r\fR, \fB\-\-reverse\fP
+Undump, write back edited login information into the utmp or wtmp files.
 .IP "\fB\-h\fR, \fB\-\-help\fP"
 Display help text and exit.
 .IP "\fB\-V\fR, \fB\-\-version\fP"
@@ -42,14 +42,14 @@ Display version information and exit.
 .SH NOTES
 .B utmpdump
 can be useful in cases of corrupted utmp or wtmp entries.  It can dump
-out utmp/wtmp to an ASCII file, whic can then be edited to remove
-bogus entries and reintegrated, using
+out utmp/wtmp to an ASCII file, which can then be edited to remove
+bogus entries, and reintegrated using:
 .PP
 .RS
-utmpdump -r < ascii_file > wtmp
+.B utmpdump -r < ascii_file > wtmp
 .RE
 .PP
-but be warned, as
+But be warned,
 .B utmpdump
 was written for debugging purposes only.
 .SH BUGS
-- 
1.7.0.4

