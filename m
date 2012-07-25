Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:50845 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab2GYTQL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:16:11 -0400
Received: by wibhm11 with SMTP id hm11so5657330wib.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:16:10 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/5] docs: clean up sulogin.8 manual
Date: Wed, 25 Jul 2012 21:15:42 +0200
Message-Id: <1343243745-1172-25-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Align with Documentation/howto-man-page.txt

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/sulogin.8 | 70 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 26 deletions(-)

diff --git a/login-utils/sulogin.8 b/login-utils/sulogin.8
index 24c120d..b9dec16 100644
--- a/login-utils/sulogin.8
+++ b/login-utils/sulogin.8
@@ -16,7 +16,7 @@
 .\" along with this program; if not, write to the Free Software
 .\" Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 .\"
-.TH SULOGIN 8 "Mar 2012" "" "Linux System Administrator's Manual"
+.TH SULOGIN "8" "Jul 2012" "util-linux" "System Administration"
 .SH NAME
 sulogin \- Single-user login
 .SH SYNOPSIS
@@ -25,7 +25,9 @@ sulogin \- Single-user login
 .RB [ tty ]
 .SH DESCRIPTION
 .I sulogin
-is invoked by \fBinit\fP when the system goes into single user mode.
+is invoked by
+.B init
+when the system goes into single user mode.
 .PP
 The user is prompted:
 .IP "" .5i
@@ -33,40 +35,56 @@ Give root password for system maintenance
 .br
 (or type Control\-D for normal startup):
 .PP
-\fIsulogin\fP will be connected to the current terminal, or to the
-optional tty device that can be specified on the command line
-(typically \fB/dev/console\fP).
+.I sulogin
+will be connected to the current terminal, or to the optional tty device that
+can be specified on the command line (typically
+.BR /dev/console ).
 .PP
 After the user exits the single-user shell or presses control\-D at the
 prompt, the system will continue to boot.
 .SH OPTIONS
-.IP "\fB\-e, \-\-force\fP"
-If the default method of obtaining the root password via \fBgetpwnam\fP(3) from
-the system fails, manually examine /etc/passwd and /etc/shadow to get the
-password. If they are damaged or nonexistent, sulogin will start a root shell
-without asking for a password.
-
-Only use the \fB\-e\fP option if you are sure the console is physically
-protected against unauthorized access.
-.IP "\fB\-h, \-\-help\fP"
-Print a help message.
-.IP "\fB\-p, \-\-login\-shell\fP"
-Specifying this option causes sulogin to start the shell process as a
-login shell.
-.IP "\fB\-t, \-\-timeout \fIseconds\fP"
-Specify the maximum amount of time to wait for user input. By default,
+.IP "\fB\-e\fR, \fB\-\-force\fP"
+If the default method of obtaining the root password via
+.BR getpwnam (3)
+from the system fails, manually examine
+.I /etc/passwd
+and
+.I /etc/shadow
+to get the password.  If they are damaged or nonexistent, sulogin will start
+a root shell without asking for a password.
+.IP
+Only use the
+.B \-e
+option if you are sure the console is physically protected against
+unauthorized access.
+.IP "\fB\-p\fR, \fB\-\-login\-shell\fP"
+Specifying this option causes sulogin to start the shell process as a login
+shell.
+.IP "\fB\-t\fR, \fB\-\-timeout \fIseconds\fP"
+Specify the maximum amount of time to wait for user input.  By default,
 sulogin will wait forever.
-.IP "\fB\-V, \-\-version\fP"
+.IP "\fB\-h\fR, \fB\-\-help\fP"
+Print a help message.
+.IP "\fB\-V\fR, \fB\-\-version\fP"
 Output version.
 .SH ENVIRONMENT VARIABLES
-\fIsulogin\fP looks for the environment variable \fBSUSHELL\fP or
-\fBsushell\fP to determine what shell to start. If the environment variable
-is not set, it will try to execute root's shell from /etc/passwd. If that
-fails it will fall back to \fB/bin/sh\fP.
+.I sulogin
+looks for the environment variable
+.B SUSHELL
+or
+.B sushell
+to determine what shell to start.  If the environment variable is not set, it
+will try to execute root's shell from
+.IR /etc/passwd .
+If that fails it
+will fall back to
+.IR /bin/sh .
 .SH AUTHOR
 .B sulogin
 was written by Miquel van Smoorenburg for sysvinit and later ported
 to util-linux by Dave Reisner and Karel Zak.
 .SH AVAILABILITY
 The sulogin command is part of the util-linux package and is available from
-ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
+.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
-- 
1.7.11.3

