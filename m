Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50682 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753570AbaEHKK1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 8 May 2014 06:10:27 -0400
From: Werner Fink <werner@suse.de>
To: util-linux@vger.kernel.org
Cc: Werner Fink <werner@suse.de>, Ruediger Meier <sweet_f_a@gmx.de>
Subject: [PATCH 3/4] Better support of the special system consoles on S390
Date: Thu,  8 May 2014 12:09:24 +0200
Message-Id: <1399543765-31106-3-git-send-email-werner@suse.de>
In-Reply-To: <1399543765-31106-1-git-send-email-werner@suse.de>
References: <1399543765-31106-1-git-send-email-werner@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

That is that there are several consoles, the /dev/ttyS0 which
is type of ibm3215 and a dumb terminal, then there is the device
/dev/3270/tty1 which can handle ANSI color escape sequences and is
a ibm327x terminal, and the /dev/ttyS1 which is a vt220 terminal.

The macro is_speed() in agetty.c allows to distinguish between the
terminal line (/dev)3270/tty1 and the speed options on the command
line used in

/run/systemd/generator/getty.target.wants/serial-getty@3270-tty1.service

which is a symbolic link to /usr/lib/systemd/system/serial-getty@.service

Signed-off-by: Werner Fink <werner@suse.de>
---
 login-utils/sulogin.c |    8 +++++++-
 term-utils/agetty.c   |   15 ++++++++++-----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git login-utils/sulogin.c login-utils/sulogin.c
index 1e227a8..147e633 100644
--- login-utils/sulogin.c
+++ login-utils/sulogin.c
@@ -231,10 +231,16 @@ static void tcfinal(struct console *con)
 		setenv("TERM", "linux", 1);
 		return;
 	}
-	if (con->flags & CON_NOTTY)
+	if (con->flags & CON_NOTTY) {
+		setenv("TERM", "dumb", 1);
 		return;
+	}
 
+#if defined (__s390__) || defined (__s390x__)
+	setenv("TERM", "dumb", 1);
+#else
 	setenv("TERM", "vt102", 1);
+#endif
 	tio = &con->tio;
 	fd = con->fd;
 
diff --git term-utils/agetty.c term-utils/agetty.c
index fe671a9..24c9366 100644
--- term-utils/agetty.c
+++ term-utils/agetty.c
@@ -51,7 +51,8 @@
 #    define DEFAULT_VCTERM "linux"
 #  endif
 #  if defined (__s390__) || defined (__s390x__)
-#    define DEFAULT_TTYS0  "ibm327x"
+#    define DEFAULT_TTYS0  "dumb"
+#    define DEFAULT_TTY32  "ibm327x"
 #    define DEFAULT_TTYS1  "vt220"
 #  endif
 #  ifndef DEFAULT_STERM
@@ -569,6 +570,8 @@ static void login_options_to_argv(char *argv[], int *argc,
 	*argc = i;
 }
 
+#define is_speed(str) (strlen((str)) == strspn((str), "0123456789,"))
+
 /* Parse command-line arguments. */
 static void parse_args(int argc, char **argv, struct options *op)
 {
@@ -747,7 +750,7 @@ static void parse_args(int argc, char **argv, struct options *op)
 	}
 
 	/* Accept "tty", "baudrate tty", and "tty baudrate". */
-	if ('0' <= argv[optind][0] && argv[optind][0] <= '9') {
+	if (is_speed(argv[optind])) {
 		/* Assume BSD style speed. */
 		parse_speeds(op, argv[optind++]);
 		if (argc < optind + 1) {
@@ -759,7 +762,7 @@ static void parse_args(int argc, char **argv, struct options *op)
 		op->tty = argv[optind++];
 		if (argc > optind) {
 			char *v = argv[optind++];
-			if ('0' <= *v && *v <= '9')
+			if (is_speed(v))
 				parse_speeds(op, v);
 			else
 				op->speeds[op->numspeed++] = bcode("9600");
@@ -1069,9 +1072,11 @@ static void open_tty(char *tty, struct termios *tp, struct options *op)
 		 * higher.  Whereas the second serial line on a S/390(x) is
 		 * a real character terminal which is compatible with VT220.
 		 */
-		if (strcmp(op->tty, "ttyS0") == 0)
+		if (strcmp(op->tty, "ttyS0") == 0)		/* linux/drivers/s390/char/con3215.c */
 			op->term = DEFAULT_TTYS0;
-		else if (strcmp(op->tty, "ttyS1") == 0)
+		else if (strncmp(op->tty, "3270/tty", 8) == 0)	/* linux/drivers/s390/char/con3270.c */
+			op->term = DEFAULT_TTY32;
+		else if (strcmp(op->tty, "ttyS1") == 0)		/* linux/drivers/s390/char/sclp_vt220.c */
 			op->term = DEFAULT_TTYS1;
 	}
 #endif
-- 
1.7.9.2

