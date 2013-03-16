Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f51.google.com ([74.125.82.51]:54630 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab3CPXkg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Mar 2013 19:40:36 -0400
Received: by mail-wg0-f51.google.com with SMTP id 8so672746wgl.6
        for <util-linux@vger.kernel.org>; Sat, 16 Mar 2013 16:40:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 5/7] docs: generic whereis.1 clean up
Date: Sat, 16 Mar 2013 23:40:17 +0000
Message-Id: <1363477219-29245-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1363477219-29245-1-git-send-email-kerolasa@iki.fi>
References: <1363477219-29245-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Align with howto-man-page.txt, and more importantly remove out dated 'SEE
ALSO' and 'BUGS' sections.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/whereis.1 | 61 +++++++++++++++++++++-------------------------------
 1 file changed, 25 insertions(+), 36 deletions(-)

diff --git a/misc-utils/whereis.1 b/misc-utils/whereis.1
index 4ce7a07..fde0dd7 100644
--- a/misc-utils/whereis.1
+++ b/misc-utils/whereis.1
@@ -42,8 +42,8 @@ whereis \- locate the binary, source, and manual page files for a command
 .SH DESCRIPTION
 .B whereis
 locates the binary, source and manual files for the specified command names.
-The supplied names are first stripped of leading pathname components
-and any (single) trailing extension of the form
+The supplied names are first stripped of leading pathname components and any
+(single) trailing extension of the form
 .BI . ext
 (for example:
 .BR .c )
@@ -51,25 +51,26 @@ Prefixes of
 .B s.
 resulting from use of source code control are also dealt with.
 .B whereis
-then attempts to locate the desired program in
-the standard Linux places, and in the places specified by
-.BR $PATH .
-
+then attempts to locate the desired program in the standard Linux places, and
+in the places specified by
+.B $PATH
+and
+.BR $MANPATH .
 .SH OPTIONS
 .TP
-.IP "\fB\-b\fP"
+.IP \fB\-b\fP
 Search only for binaries.
-.IP "\fB\-m\fP"
+.IP \fB\-m\fP
 Search only for manuals.
-.IP "\fB\-s\fP"
+.IP \fB\-s\fP
 Search only for sources.
-.IP "\fB\-u\fP"
-Only show the command names that have unusual entries.  A command
-is said to be unusual if it does
-not have just one entry of each explicitly requested type.  Thus
-.RB ` "whereis\ \ \-m\ \ \-u\ \ *" '
-asks for those files in the current
-directory which have no documentation file, or more than one.
+.IP \fB\-u\fP
+Only show the command names that have unusual entries.  A command is said to be
+unusual if it does not have just one entry of each explicitly requested type.
+Thus
+.RB ' "whereis \-m \-u *" '
+asks for those files in the current directory which have no documentation file,
+or more than one.
 .IP "\fB\-B \fIlist\fP"
 Limit the places where
 .B whereis
@@ -99,16 +100,16 @@ is using.  When non of
 .BR \-M ,
 or
 .BR \-S
-is specified the option will out hard coded paths that the command was
-able to find on system.
+is specified the option will out hard coded paths that the command was able to
+find on system.
 .SH EXAMPLE
 To find all files in
-.B /usr/bin
+.B /usr/\:bin
 which are not documented
 in
-.B /usr/man/man1
+.B /usr/\:man/\:man1
 or have no source in
-.BR /usr/src :
+.BR /usr/\:src :
 .IP
 .B $ cd /usr/bin
 .br
@@ -131,21 +132,9 @@ and
 .BR \-S
 are display with
 .BR \-l .
-.SH "SEE ALSO"
-.BR chdir (2)
-.SH BUGS
-Since
-.B whereis
-uses
-.BR chdir (2)
-to run faster, pathnames given with the
-.BR \-B ,
-.BR \-M ,
-or
-.BR \-S
-options must be full; that is, they must begin with a
-.RB ` / '.
 .PP
 .SH AVAILABILITY
 The whereis command is part of the util-linux package and is available from
-ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
+.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
-- 
1.8.2

