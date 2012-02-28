Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48599 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964951Ab2B1Qpb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Feb 2012 11:45:31 -0500
Received: by mail-vx0-f174.google.com with SMTP id p1so2644946vcq.19
        for <util-linux@vger.kernel.org>; Tue, 28 Feb 2012 08:45:31 -0800 (PST)
MIME-Version: 1.0
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 03/13] sulogin.8: refactor manpage
Date: Tue, 28 Feb 2012 11:45:11 -0500
Message-Id: <1330447521-886-4-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

- Use a more standard layout using .IP macros for options
- Avoid direct references to sysvinit

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 login-utils/sulogin.8 |   69 +++++++++++++++----------------------------------
 1 file changed, 21 insertions(+), 48 deletions(-)

diff --git a/login-utils/sulogin.8 b/login-utils/sulogin.8
index 4b5d153..e5d2f28 100644
--- a/login-utils/sulogin.8
+++ b/login-utils/sulogin.8
@@ -15,73 +15,46 @@
 .\" along with this program; if not, write to the Free Software
 .\" Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 .\"
-.TH SULOGIN 8 "17 Jan 2006" "" "Linux System Administrator's Manual"
+.TH SULOGIN 8 "28 Feb 2012" "" "Linux System Administrator's Manual"
 .SH NAME
 sulogin \- Single-user login
 .SH SYNOPSIS
 .B sulogin
-[ \fB\-e\fP ]
-[ \fB\-p\fP ]
-[ \fB\-t\fP \fISECONDS\fP ]
-[ \fITTY\fP ]
+.RB [ options ]
+.RB [ tty ]
 .SH DESCRIPTION
 .I sulogin
-is invoked by \fBinit(8)\fP when the system goes into single user mode.
-(This is done through an entry in \fIinittab(5)\fP.)
-\fBInit\fP also
-tries to execute \fIsulogin\fP when
-the boot loader (e.g., \fBgrub\fP(8))
-passes it the \fB\-b\fP option.
+is invoked by \fBinit\fP when the system goes into single user mode.
 .PP
-The user is prompted
+The user is prompted:
 .IP "" .5i
 Give root password for system maintenance
 .br
 (or type Control\-D for normal startup):
 .PP
 \fIsulogin\fP will be connected to the current terminal, or to the
-optional device that can be specified on the command line
+optional tty device that can be specified on the command line
 (typically \fB/dev/console\fP).
 .PP
-If the \fB\-t\fP option is used then the program only waits
-the given number of seconds for user input.
-.PP
-If the \fB\-p\fP option is used then the single-user shell is invoked
-with a \fIdash\fP as the first character in \fIargv[0]\fP.
-This causes the shell process to behave as a login shell.
-The default is \fInot\fP to do this,
-so that the shell will \fInot\fP read \fB/etc/profile\fP
-or \fB$HOME/.profile\fP at startup.
-.PP
-After the user exits the single-user shell,
-or presses control\-D at the prompt,
-the system will (continue to) boot to the default runlevel.
+After the user exits the single-user shell or presses control\-D at the
+prompt, the system will continue to boot.
+.SH OPTIONS
+.IP "\fB\-t \fIseconds\fP"
+Specify the maximum amount of time to wait for user input. By default,
+sulogin will wait forever.
+.IP "\fB\-p\fP"
+Specifying this option causes sulogin to start the shell process as a
+login shell.
+.IP "\fB\-e\fP"
+If the default method of obtaining the root password via \fBgetpwnam\fP(3) from
+the system fails, manually examine /etc/passwd and /etc/shadow to get the
+password. If they are damaged or nonexistent, sulogin will start a root shell
+without asking for a password. Only use the \fB\-e\fP option if you are sure
+the console is physically protected against unauthorized access.
 .SH ENVIRONMENT VARIABLES
 \fIsulogin\fP looks for the environment variable \fBSUSHELL\fP or
 \fBsushell\fP to determine what shell to start. If the environment variable
 is not set, it will try to execute root's shell from /etc/passwd. If that
 fails it will fall back to \fB/bin/sh\fP.
-.PP
-This is very valuable together with the \fB\-b\fP option to init. To boot
-the system into single user mode, with the root file system mounted read/write,
-using a special "fail safe" shell that is statically linked (this example
-is valid for the LILO bootprompt)
-.PP
-boot: linux \-b rw sushell=/sbin/sash
-.SH FALLBACK METHODS
-\fIsulogin\fP checks the root password using the standard method (getpwnam)
-first.
-Then, if the \fB\-e\fP option was specified,
-\fIsulogin\fP examines these files directly to find the root password:
-.PP
-/etc/passwd,
-.br
-/etc/shadow (if present)
-.PP
-If they are damaged or nonexistent, sulogin will start a root shell
-without asking for a password. Only use the \fB\-e\fP option if you
-are sure the console is physically protected against unauthorized access.
 .SH AUTHOR
 Miquel van Smoorenburg <miquels@cistron.nl>
-.SH SEE ALSO
-init(8), inittab(5).
-- 
1.7.9.2

