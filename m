Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37545 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932238AbeAXVHe (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 24 Jan 2018 16:07:34 -0500
Received: by mail-wr0-f194.google.com with SMTP id f11so5467023wre.4
        for <util-linux@vger.kernel.org>; Wed, 24 Jan 2018 13:07:33 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] various: fix redeclared with different type warnings [smatch]
Date: Wed, 24 Jan 2018 21:07:30 +0000
Message-Id: <20180124210730.17034-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

These warnings look like this:
lib/exec_shell.c:33:6: error: symbol 'exec_shell' redeclared with different
type (originally declared at ./include/exec_shell.h:1) - different modifiers

In same go move attributes in front of these functions, this is how they
should be.  Related smatch message is: error: attributes should be specified
before the declarator in a function definition.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/exec_shell.h |  2 +-
 lib/exec_shell.c     |  2 +-
 term-utils/agetty.c  | 14 ++++++++------
 text-utils/more.c    |  5 +++--
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/exec_shell.h b/include/exec_shell.h
index a2aa757de..f155f380f 100644
--- a/include/exec_shell.h
+++ b/include/exec_shell.h
@@ -1 +1 @@
-extern void __attribute__((__noreturn__)) exec_shell(void);
+__attribute__((__noreturn__)) extern void exec_shell(void);
diff --git a/lib/exec_shell.c b/lib/exec_shell.c
index a7374bd33..481184394 100644
--- a/lib/exec_shell.c
+++ b/lib/exec_shell.c
@@ -30,7 +30,7 @@
 
 #define DEFAULT_SHELL "/bin/sh"
 
-void exec_shell(void)
+__attribute__((__noreturn__)) void exec_shell(void)
 {
 	const char *shell = getenv("SHELL");
 	char *shellc = xstrdup(shell);
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 844220401..c51ef5413 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -316,10 +316,10 @@ static void termio_final(struct options *op,
 			 struct termios *tp, struct chardata *cp);
 static int caps_lock(char *s);
 static speed_t bcode(char *s);
-static void usage(void) __attribute__((__noreturn__));
-static void exit_slowly(int code) __attribute__((__noreturn__));
-static void log_err(const char *, ...) __attribute__((__noreturn__))
-			       __attribute__((__format__(printf, 1, 2)));
+__attribute__((__noreturn__)) static void usage(void);
+__attribute__((__noreturn__)) static void exit_slowly(int code);
+__attribute__((__noreturn__)) __attribute__((__format__(printf, 1, 2)))
+  static void log_err(const char *, ...);
 static void log_warn (const char *, ...)
 				__attribute__((__format__(printf, 1, 2)));
 static ssize_t append(char *dest, size_t len, const char  *sep, const char *src);
@@ -2218,7 +2218,7 @@ static speed_t bcode(char *s)
 	return 0;
 }
 
-static void __attribute__((__noreturn__)) usage(void)
+__attribute__((__noreturn__)) static void usage(void)
 {
 	FILE *out = stdout;
 
@@ -2325,13 +2325,15 @@ static void dolog(int priority, const char *fmt, va_list ap)
 #endif				/* USE_SYSLOG */
 }
 
-static void exit_slowly(int code)
+__attribute__((__noreturn__)) static void exit_slowly(int code)
 {
 	/* Be kind to init(8). */
 	sleep(10);
 	exit(code);
 }
 
+__attribute__((__noreturn__))
+__attribute__((__format__(printf, 1, 2)))
 static void log_err(const char *fmt, ...)
 {
 	va_list ap;
diff --git a/text-utils/more.c b/text-utils/more.c
index cbff39b11..68916b8b1 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -140,7 +140,8 @@ static struct termios otty, savetty0;
 static long file_pos, file_size;
 static int fnum, no_intty, no_tty;
 static int dum_opt, dlines;
-static void onquit(int), onsusp(int), chgwinsz(int), end_it(int);
+static void onquit(int), onsusp(int), chgwinsz(int);
+__attribute__((__noreturn__)) static void end_it(int dummy __attribute__((__unused__)));
 static int nscroll = SCROLL_LEN;	/* Number of lines scrolled by 'd' */
 static int fold_opt = 1;		/* Fold long lines */
 static int stop_opt = 1;		/* Stop after form feeds */
@@ -692,7 +693,7 @@ static void chgwinsz(int dummy __attribute__((__unused__)))
 #endif				/* SIGWINCH */
 
 /* Clean up terminal state and exit. Also come here if interrupt signal received */
-static void __attribute__((__noreturn__)) end_it(int dummy __attribute__((__unused__)))
+__attribute__((__noreturn__)) static void end_it(int dummy __attribute__((__unused__)))
 {
 	/* May be executed as a signal handler as well as by main process.
 	 *
-- 
2.16.1

