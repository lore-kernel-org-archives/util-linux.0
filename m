Return-Path: util-linux-owner@vger.kernel.org
Received: from archy.org.uk ([80.82.115.118]:34234 "EHLO archy.org.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759431AbdKQRDv (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 17 Nov 2017 12:03:51 -0500
Date: Fri, 17 Nov 2017 08:44:33 -0800
From: Steven Smith <sos22@archy.org.uk>
To: util-linux@vger.kernel.org
Cc: sos22@srcf.ucam.org
Subject: [PATCH] Fix a use of uninitialised memory in an agetty error path.
Message-ID: <20171117164433.xtsgma2vdppjpio4@adrian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

get_logname() assumes that when it calls read() it initializes c and
errno, which isn't always true if we hit a whitelisted error or end of
file. This occasionally shows up as agetty going into an infinite
loop. Fix it by just delaying ten seconds and exiting when things go
wrong, similarly to the behavior after a non-whitelisted error.

Signed-off-by: Steven Smith <sos22@srcf.ucam.org>
---
 term-utils/agetty.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 9763fcd30..bc848a25a 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -317,6 +317,7 @@ static void termio_final(struct options *op,
 static int caps_lock(char *s);
 static speed_t bcode(char *s);
 static void usage(void) __attribute__((__noreturn__));
+static void exit_slowly(int code) __attribute__((__noreturn__));
 static void log_err(const char *, ...) __attribute__((__noreturn__))
 			       __attribute__((__format__(printf, 1, 2)));
 static void log_warn (const char *, ...)
@@ -1983,9 +1984,11 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
 		while (cp->eol == '\0') {
 
 			char key;
+			ssize_t readres;
 
 			debug("read from FD\n");
-			if (read(STDIN_FILENO, &c, 1) < 1) {
+			readres = read(STDIN_FILENO, &c, 1);
+			if (readres < 0) {
 				debug("read failed\n");
 
 				/* The terminal could be open with O_NONBLOCK when
@@ -2000,12 +2003,15 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
 				case ESRCH:
 				case EINVAL:
 				case ENOENT:
-					break;
+					exit_slowly(EXIT_SUCCESS);
 				default:
 					log_err(_("%s: read: %m"), op->tty);
 				}
 			}
 
+			if (readres == 0)
+				exit_slowly(EXIT_SUCCESS);
+
 			/* Do parity bit handling. */
 			if (eightbit)
 				ascval = c;
@@ -2317,6 +2323,13 @@ static void dolog(int priority, const char *fmt, va_list ap)
 #endif				/* USE_SYSLOG */
 }
 
+static void exit_slowly(int code)
+{
+	/* Be kind to init(8). */
+	sleep(10);
+	exit(code);
+}
+
 static void log_err(const char *fmt, ...)
 {
 	va_list ap;
@@ -2325,9 +2338,7 @@ static void log_err(const char *fmt, ...)
 	dolog(LOG_ERR, fmt, ap);
 	va_end(ap);
 
-	/* Be kind to init(8). */
-	sleep(10);
-	exit(EXIT_FAILURE);
+	exit_slowly(EXIT_FAILURE);
 }
 
 static void log_warn(const char *fmt, ...)
-- 
2.11.0

