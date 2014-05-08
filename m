Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50685 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601AbaEHKKe (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 8 May 2014 06:10:34 -0400
From: Werner Fink <werner@suse.de>
To: util-linux@vger.kernel.org
Cc: Werner Fink <werner@suse.de>, Ruediger Meier <sweet_f_a@gmx.de>
Subject: [PATCH 4/4] Beside virtual consoles support xvc and hvc device lines as well
Date: Thu,  8 May 2014 12:09:25 +0200
Message-Id: <1399543765-31106-4-git-send-email-werner@suse.de>
In-Reply-To: <1399543765-31106-1-git-send-email-werner@suse.de>
References: <1399543765-31106-1-git-send-email-werner@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

For this approach do not use the ioctl TIOCMGET anymore as this
is for real serial lines only. But switch over to use the ioctl
KDGKBMODE as this is unique to the virtual console lines only.

Signed-off-by: Werner Fink <werner@suse.de>
---
 login-utils/sulogin.c |   17 ++++++++++++-----
 term-utils/agetty.c   |   23 +++++++++++------------
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git login-utils/sulogin.c login-utils/sulogin.c
index 147e633..222d40e 100644
--- login-utils/sulogin.c
+++ login-utils/sulogin.c
@@ -49,6 +49,11 @@
 # include <selinux/get_context_list.h>
 #endif
 
+#ifdef __linux__
+# include <sys/kd.h>
+# include <sys/param.h>
+#endif
+
 #include "c.h"
 #include "closestream.h"
 #include "nls.h"
@@ -142,10 +147,14 @@ static void tcinit(struct console *con)
 		return;
 	}
 
-	/* Handle serial lines here */
-	if (ioctl(fd, TIOCMGET, (char *) &mode) == 0) {
+	/* Handle lines other than virtual consoles here */
+#if defined(KDGKBMODE)
+	if (ioctl(fd, KDGKBMODE, &mode) < 0)
+#endif
+	{
 		speed_t ispeed, ospeed;
 		struct winsize ws;
+		errno = 0;
 
 		/* this is a modem line */
 		con->flags |= CON_SERIAL;
@@ -191,9 +200,7 @@ static void tcinit(struct console *con)
 		goto setattr;
 	}
 #if defined(IUTF8) && defined(KDGKBMODE)
-	/* Detect mode of current keyboard setup, e.g. for UTF-8 */
-	if (ioctl(fd, KDGKBMODE, &mode) < 0)
-		mode = K_RAW;
+	/* Handle mode of current keyboard setup, e.g. for UTF-8 */
 	switch(mode) {
 	case K_UNICODE:
 		setlocale(LC_CTYPE, "C.UTF-8");
diff --git term-utils/agetty.c term-utils/agetty.c
index 24c9366..a706836 100644
--- term-utils/agetty.c
+++ term-utils/agetty.c
@@ -140,6 +140,7 @@ struct options {
 	int nice;			/* Run login with this priority */
 	int numspeed;			/* number of baud rates to try */
 	int clocal;			/* CLOCAL_MODE_* */
+	int kbmode;			/* Keyboard mode if virtual console */
 	speed_t speeds[MAX_SPEED];	/* baud rates to be tried */
 };
 
@@ -936,7 +937,7 @@ static void update_utmp(struct options *op)
 static void open_tty(char *tty, struct termios *tp, struct options *op)
 {
 	const pid_t pid = getpid();
-	int serial, closed = 0;
+	int closed = 0;
 
 	/* Set up new standard input, unless we are given an already opened port. */
 
@@ -1082,15 +1083,18 @@ static void open_tty(char *tty, struct termios *tp, struct options *op)
 #endif
 	/*
 	 * Detect if this is a virtual console or serial/modem line.
-	 * In case of a virtual console the ioctl TIOCMGET fails and
-	 * the error number will be set to EINVAL.
+	 * In case of a virtual console the ioctl KDGKBMODE succeeds
+	 * whereas on other lines it will fails.
 	 */
-	if (ioctl(STDIN_FILENO, TIOCMGET, &serial) < 0 && (errno == EINVAL)) {
+	if (ioctl(STDIN_FILENO, KDGKBMODE, &op->kbmode) == 0) {
 		op->flags |= F_VCONSOLE;
 		if (!op->term)
 			op->term = DEFAULT_VCTERM;
-	} else if (!op->term)
-		op->term = DEFAULT_STERM;
+	} else {
+		op->kbmode = K_RAW;
+		if (!op->term)
+			op->term = DEFAULT_STERM;
+	}
 
 	setenv("TERM", op->term, 1);
 }
@@ -1124,12 +1128,7 @@ static void termio_init(struct options *op, struct termios *tp)
 
 	if (op->flags & F_VCONSOLE) {
 #if defined(IUTF8) && defined(KDGKBMODE)
-		int mode;
-
-		/* Detect mode of current keyboard setup, e.g. for UTF-8 */
-		if (ioctl(STDIN_FILENO, KDGKBMODE, &mode) < 0)
-			mode = K_RAW;
-		switch(mode) {
+		switch(op->kbmode) {
 		case K_UNICODE:
 			setlocale(LC_CTYPE, "C.UTF-8");
 			op->flags |= F_UTF8;
-- 
1.7.9.2

