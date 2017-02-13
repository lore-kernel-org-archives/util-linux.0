Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34130 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbdBMWGu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 13 Feb 2017 17:06:50 -0500
Received: by mail-wr0-f193.google.com with SMTP id c4so339552wrd.1
        for <util-linux@vger.kernel.org>; Mon, 13 Feb 2017 14:06:49 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/7] misc: unify function declarations [smatch scan]
Date: Mon, 13 Feb 2017 22:06:38 +0000
Message-Id: <20170213220641.1395-5-kerolasa@iki.fi>
In-Reply-To: <20170213220641.1395-1-kerolasa@iki.fi>
References: <20170213220641.1395-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This will fix errors similar to below.

lib/exec_shell.c:33:6: error: symbol 'exec_shell' redeclared with different
type (originally declared at ./include/exec_shell.h:1) - different modifiers

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/exec_shell.c        |  2 +-
 login-utils/su-common.c |  5 ++---
 login-utils/vipw.c      |  5 ++---
 sys-utils/hwclock.c     |  3 +--
 sys-utils/hwclock.h     |  7 ++++++-
 term-utils/agetty.c     | 16 ++++++++--------
 text-utils/more.c       |  7 ++++---
 7 files changed, 24 insertions(+), 21 deletions(-)

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
diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index 41f2b1cea..3660ed1c8 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -97,8 +97,7 @@ enum
 extern char **environ;
 #endif
 
-static void run_shell (char const *, char const *, char **, size_t)
-     __attribute__ ((__noreturn__));
+static __attribute__ ((__noreturn__)) void run_shell (char const *, char const *, char **, size_t);
 
 /* If true, pass the `-f' option to the subshell.  */
 static bool fast_startup;
@@ -612,7 +611,7 @@ change_identity (const struct passwd *pw)
    Pass ADDITIONAL_ARGS to the shell as more arguments; there
    are N_ADDITIONAL_ARGS extra arguments.  */
 
-static void
+static __attribute__ ((__noreturn__)) void
 run_shell (char const *shell, char const *command, char **additional_args,
 	   size_t n_additional_args)
 {
diff --git a/login-utils/vipw.c b/login-utils/vipw.c
index 4d8592434..58d72584f 100644
--- a/login-utils/vipw.c
+++ b/login-utils/vipw.c
@@ -85,7 +85,7 @@ static int program;
 static char orig_file[FILENAMELEN];	/* original file /etc/passwd or /etc/group */
 static char *tmp_file;			/* tmp file */
 
-void pw_error (char *, int, int);
+__attribute__((__noreturn__)) void pw_error(char *, int, int);
 
 static void copyfile(int from, int to)
 {
@@ -224,8 +224,7 @@ static void pw_edit(void)
 	free(editor);
 }
 
-void __attribute__((__noreturn__))
-pw_error(char *name, int err, int eval)
+__attribute__((__noreturn__)) void pw_error(char *name, int err, int eval)
 {
 	if (err) {
 		if (name)
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 21d1304e1..0631f4d51 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1738,8 +1738,7 @@ int main(int argc, char **argv)
 	return rc;		/* Not reached */
 }
 
-void __attribute__((__noreturn__))
-hwclock_exit(const struct hwclock_control *ctl
+__attribute__((__noreturn__)) void hwclock_exit(const struct hwclock_control *ctl
 #ifndef HAVE_LIBAUDIT
 	     __attribute__((__unused__))
 #endif
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index b08bd2d7a..6fa78a14e 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -80,6 +80,11 @@ extern void set_cmos_access(const struct hwclock_control *ctl);
 extern int get_epoch_rtc(const struct hwclock_control *ctl, unsigned long *epoch, int silent);
 extern int set_epoch_rtc(const struct hwclock_control *ctl);
 
-extern void hwclock_exit(const struct hwclock_control *ctl, int status);
+extern __attribute__((__noreturn__))
+void hwclock_exit(const struct hwclock_control *ctl,
+#ifndef HAVE_LIBAUDIT
+		  __attribute__((__unused__))
+#endif
+		  int status);
 
 #endif				/* HWCLOCK_CLOCK_H */
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 8ac08f57c..fa86ce419 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -308,11 +308,10 @@ static void termio_final(struct options *op,
 			 struct termios *tp, struct chardata *cp);
 static int caps_lock(char *s);
 static speed_t bcode(char *s);
-static void usage(FILE * out) __attribute__((__noreturn__));
-static void log_err(const char *, ...) __attribute__((__noreturn__))
-			       __attribute__((__format__(printf, 1, 2)));
-static void log_warn (const char *, ...)
-				__attribute__((__format__(printf, 1, 2)));
+static __attribute__ ((__noreturn__)) void usage(FILE *out);
+static __attribute__((__noreturn__)) __attribute__((__format__(printf, 1, 2)))
+       void log_err(const char *fmt, ...);
+static __attribute__((__format__(printf, 1, 2))) void log_warn (const char *, ...);
 static ssize_t append(char *dest, size_t len, const char  *sep, const char *src);
 static void check_username (const char* nm);
 static void login_options_to_argv(char *argv[], int *argc, char *str, char *username);
@@ -2086,7 +2085,7 @@ static speed_t bcode(char *s)
 	return 0;
 }
 
-static void __attribute__ ((__noreturn__)) usage(FILE *out)
+static __attribute__ ((__noreturn__))void  usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %1$s [options] <line> [<baud_rate>,...] [<termtype>]\n"
@@ -2182,7 +2181,8 @@ static void dolog(int priority, const char *fmt, va_list ap)
 #endif				/* USE_SYSLOG */
 }
 
-static void log_err(const char *fmt, ...)
+static __attribute__((__noreturn__)) __attribute__((__format__(printf, 1, 2)))
+void log_err(const char *fmt, ...)
 {
 	va_list ap;
 
@@ -2195,7 +2195,7 @@ static void log_err(const char *fmt, ...)
 	exit(EXIT_FAILURE);
 }
 
-static void log_warn(const char *fmt, ...)
+static __attribute__((__format__(printf, 1, 2))) void log_warn(const char *fmt, ...)
 {
 	va_list ap;
 
diff --git a/text-utils/more.c b/text-utils/more.c
index d4aba11e4..509e746d4 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -140,7 +140,8 @@ static struct termios otty, savetty0;
 static long file_pos, file_size;
 static int fnum, no_intty, no_tty, slow_tty;
 static int dum_opt, dlines;
-static void onquit(int), onsusp(int), chgwinsz(int), end_it(int);
+static void onquit(int), onsusp(int), chgwinsz(int);
+static __attribute__((__noreturn__)) void end_it(int dummy __attribute__((__unused__)));
 static int nscroll = SCROLL_LEN;	/* Number of lines scrolled by 'd' */
 static int fold_opt = 1;		/* Fold long lines */
 static int stop_opt = 1;		/* Stop after form feeds */
@@ -219,7 +220,7 @@ static void putstring(char *s)
 	tputs(s, fileno(stdout), putchar);	/* putp(s); */
 }
 
-static void __attribute__((__noreturn__)) usage(FILE *out)
+static __attribute__((__noreturn__)) void usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] <file>...\n"), program_invocation_short_name);
@@ -2101,7 +2102,7 @@ void rdline(register FILE *f)
 }
 
 /* Come here when we get a suspend signal from the terminal */
-void onsusp(int dummy __attribute__((__unused__)))
+static void onsusp(int dummy __attribute__((__unused__)))
 {
 	sigset_t signals, oldmask;
 
-- 
2.11.1

