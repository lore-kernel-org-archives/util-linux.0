Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36537 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdDBIOp (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 2 Apr 2017 04:14:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id x124so5825508wmf.3
        for <util-linux@vger.kernel.org>; Sun, 02 Apr 2017 01:14:44 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/3] agetty: make --remote to forward --nohostname as -H to login
Date: Sun,  2 Apr 2017 09:14:36 +0100
Message-Id: <20170402081436.861-3-kerolasa@iki.fi>
In-Reply-To: <20170402081436.861-1-kerolasa@iki.fi>
References: <20170402081436.861-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Without this change an attempt to remove hostname printing required following
rather clumsy agetty invocation.

  /sbin/agetty --nohostname --login-options '/bin/login -H -- \u'

After the change --nohostname behaves similar way with --host option, that
is when combined with --remote the effect is passed to login(1).

In same go improve manual page a little bit.  This includes small mistake in
commit 01095ae33c that claimed option -r is added to command line when
passing hostname login while it should have been -h.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/agetty.8 | 27 +++++++++++++++++----------
 term-utils/agetty.c |  9 ++++++---
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
index 40be8b46c..bdb1a7d35 100644
--- a/term-utils/agetty.8
+++ b/term-utils/agetty.8
@@ -90,18 +90,22 @@ Assume that the tty is 8-bit clean, hence disable parity detection.
 .TP
 \-a, \-\-autologin \fIusername\fP
 Log the specified user automatically in without asking for a login name and
-password.  The \-f \fIusername\fP option is added to the \fB/bin/login\fP
-command line by default.  The \-\-login\-options option changes this default
-behavior and then only \\u is replaced by the \fIusername\fP and no other
-option is added to the login command line.
+password.  The \-f \fIusername\fP option and argument are added to the
+\fB/bin/login\fP command line by default.  The \-\-login\-options option
+changes this default behavior and then only \\u is replaced by the
+\fIusername\fP and no other option is added to the login command line.
 .TP
 \-c, \-\-noreset
 Don't reset terminal cflags (control modes).  See \fBtermios\fP(3) for more
 details.
 .TP
 \-E, \-\-remote
-If an \fB\-H\fP \fIfakehost\fP option is given, then an \fB\-r\fP
-\fIfakehost\fP option is added to the \fB/bin/login\fP command line.
+If an \fB\-\-host\fP \fIfakehost\fP option is given, then an \fB\-h\fP
+\fIfakehost\fP option and argument are added to the \fB/bin/login\fP
+command line.
+.IP
+If an \fB\-\-nohost\fR option is given, then an \fB\-H\fP option
+is added to the \fB/bin/login\fP command line.
 .TP
 \-f, \-\-issue\-file \fIissue_file\fP
 Display the contents of \fIissue_file\fP instead of \fI/etc/issue\fP.
@@ -184,9 +188,11 @@ Do not print a newline before writing out /etc/issue.
 .TP
 \-o, \-\-login\-options "\fIlogin_options\fP"
 Options  that  are passed to the login program.  \\u is replaced
-by the login name.  The default \fB/bin/login\fP command line
-is "/bin/login -- <username>".
-
+by the login name.  The default login options string is
+"/bin/login -- \\u".
+.IP
+See also \fB\-\-autologin\fR and \fB\-\-remote\fR options.
+.IP
 Please read the SECURITY NOTICE below if you want to use this.
 .TP
 \-p, \-\-login\-pause
@@ -217,7 +223,8 @@ Note that this has no support for any Unicode characters.
 \-w, \-\-wait\-cr
 Wait for the user or the modem to send a carriage-return or a
 linefeed character before sending the \fI/etc/issue\fP (or other) file
-and the login prompt.  Very useful in connection with the \-I option.
+and the login prompt.  Very useful in connection with the \-\-init\-string
+option.
 .TP
 \-\-nohints
 Do not print hints about Num, Caps and Scroll Locks.
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 6a2085a3c..93a3843c7 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -493,9 +493,12 @@ int main(int argc, char **argv)
 		login_options_to_argv(login_argv, &login_argc,
 				      options.logopt, username);
 	} else {
-		if (fakehost && (options.flags & F_REMOTE)) {
-			login_argv[login_argc++] = "-h";
-			login_argv[login_argc++] = fakehost;
+		if (options.flags & F_REMOTE) {
+			if (fakehost) {
+				login_argv[login_argc++] = "-h";
+				login_argv[login_argc++] = fakehost;
+			} else if (options.flags & F_NOHOSTNAME)
+				login_argv[login_argc++] = "-H";
 		}
 		if (username) {
 			if (options.autolog)
-- 
2.12.2

