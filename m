Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33437 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439AbaLVLrm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Dec 2014 06:47:42 -0500
Received: by mail-wi0-f174.google.com with SMTP id h11so7774471wiw.7
        for <util-linux@vger.kernel.org>; Mon, 22 Dec 2014 03:47:41 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 13/14] script: remove function prototypes
Date: Mon, 22 Dec 2014 11:47:16 +0000
Message-Id: <1419248837-4619-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
References: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c | 497 +++++++++++++++++++++++++---------------------------
 1 file changed, 242 insertions(+), 255 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 78d7a30..0eaa73f 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -80,18 +80,6 @@
 
 #define DEFAULT_OUTPUT "typescript"
 
-void sig_finish(int);
-void finish(int);
-void done(void);
-void fail(void);
-void resize(int);
-void fixtty(void);
-void getmaster(void);
-void getslave(void);
-void doinput(void);
-void dooutput(void);
-void doshell(void);
-
 char	*shell;
 FILE	*fscript;
 FILE	*timingfd;
@@ -123,21 +111,7 @@ sigset_t block_mask, unblock_mask;
 int die;
 int resized;
 
-static void
-die_if_link(char *fn) {
-	struct stat s;
-
-	if (forceflg)
-		return;
-	if (lstat(fn, &s) == 0 && (S_ISLNK(s.st_mode) || s.st_nlink > 1))
-		errx(EXIT_FAILURE,
-		     _("output file `%s' is a link\n"
-		       "Use --force if you really want to use it.\n"
-		       "Program not started."), fn);
-}
-
-static void __attribute__((__noreturn__))
-usage(FILE *out)
+static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
@@ -158,145 +132,81 @@ usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-/*
- * script -t prints time delays as floating point numbers
- * The example program (scriptreplay) that we provide to handle this
- * timing output is a perl script, and does not handle numbers in
- * locale format (not even when "use locale;" is added).
- * So, since these numbers are not for human consumption, it seems
- * easiest to set LC_NUMERIC here.
- */
-
-int
-main(int argc, char **argv) {
-	struct sigaction sa;
-	int ch;
+static void die_if_link(char *fn)
+{
+	struct stat s;
 
-	enum { FORCE_OPTION = CHAR_MAX + 1 };
+	if (forceflg)
+		return;
+	if (lstat(fn, &s) == 0 && (S_ISLNK(s.st_mode) || s.st_nlink > 1))
+		errx(EXIT_FAILURE,
+		     _("output file `%s' is a link\n"
+		       "Use --force if you really want to use it.\n"
+		       "Program not started."), fn);
+}
 
-	static const struct option longopts[] = {
-		{ "append",	no_argument,	   NULL, 'a' },
-		{ "command",	required_argument, NULL, 'c' },
-		{ "return",	no_argument,	   NULL, 'e' },
-		{ "flush",	no_argument,	   NULL, 'f' },
-		{ "force",	no_argument,	   NULL, FORCE_OPTION, },
-		{ "quiet",	no_argument,	   NULL, 'q' },
-		{ "timing",	optional_argument, NULL, 't' },
-		{ "version",	no_argument,	   NULL, 'V' },
-		{ "help",	no_argument,	   NULL, 'h' },
-		{ NULL,		0, NULL, 0 }
-	};
+/*
+ * Stop extremely silly gcc complaint on %c:
+ *  warning: `%c' yields only last 2 digits of year in some locales
+ */
+static void my_strftime(char *buf, size_t len, const char *fmt, const struct tm *tm)
+{
+	strftime(buf, len, fmt, tm);
+}
 
-	setlocale(LC_ALL, "");
-	setlocale(LC_NUMERIC, "C");	/* see comment above */
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
-	atexit(close_stdout);
+static void __attribute__((__noreturn__)) done(void)
+{
+	time_t tvec;
 
-	while ((ch = getopt_long(argc, argv, "ac:efqt::Vh", longopts, NULL)) != -1)
-		switch(ch) {
-		case 'a':
-			aflg = 1;
-			break;
-		case 'c':
-			cflg = optarg;
-			break;
-		case 'e':
-			eflg = 1;
-			break;
-		case 'f':
-			fflg = 1;
-			break;
-		case FORCE_OPTION:
-			forceflg = 1;
-			break;
-		case 'q':
-			qflg = 1;
-			break;
-		case 't':
-			if (optarg && !(timingfd = fopen(optarg, "w")))
-				err(EXIT_FAILURE, _("cannot open %s"), optarg);
-			tflg = 1;
-			break;
-		case 'V':
-			printf(UTIL_LINUX_VERSION);
-			exit(EXIT_SUCCESS);
-			break;
-		case 'h':
-			usage(stdout);
-			break;
-		case '?':
-		default:
-			usage(stderr);
+	if (subchild) {
+		/* output process */
+		if (fscript) {
+			if (!qflg) {
+				char buf[BUFSIZ];
+				tvec = time((time_t *)NULL);
+				my_strftime(buf, sizeof buf, "%c\n", localtime(&tvec));
+				fprintf(fscript, _("\nScript done on %s"), buf);
+			}
+			if (close_stream(fscript) != 0)
+				errx(EXIT_FAILURE, _("write error"));
+			fscript = NULL;
 		}
-	argc -= optind;
-	argv += optind;
-
-	if (argc > 0)
-		fname = argv[0];
-	else {
-		fname = DEFAULT_OUTPUT;
-		die_if_link(fname);
-	}
-
-	if ((fscript = fopen(fname, aflg ? "a" : "w")) == NULL) {
-		warn(_("cannot open %s"), fname);
-		fail();
-	}
-
-	shell = getenv("SHELL");
-	if (shell == NULL)
-		shell = _PATH_BSHELL;
-
-	getmaster();
-	if (!qflg)
-		printf(_("Script started, file is %s\n"), fname);
-	fixtty();
+		if (timingfd && close_stream(timingfd) != 0)
+			errx(EXIT_FAILURE, _("write error"));
+		timingfd = NULL;
 
+		close(master);
+		master = -1;
+	} else {
+		/* input process */
+		if (isterm)
+			tcsetattr(STDIN_FILENO, TCSADRAIN, &tt);
+		if (!qflg)
+			printf(_("Script done, file is %s\n"), fname);
 #ifdef HAVE_LIBUTEMPTER
-	utempter_add_record(master, NULL);
+		if (master >= 0)
+			utempter_remove_record(master);
 #endif
-	/* setup SIGCHLD handler */
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = 0;
-	sa.sa_handler = sig_finish;
-	sigaction(SIGCHLD, &sa, NULL);
-
-	/* init mask for SIGCHLD */
-	sigprocmask(SIG_SETMASK, NULL, &block_mask);
-	sigaddset(&block_mask, SIGCHLD);
-
-	sigprocmask(SIG_SETMASK, &block_mask, &unblock_mask);
-	child = fork();
-	sigprocmask(SIG_SETMASK, &unblock_mask, NULL);
-
-	if (child < 0) {
-		warn(_("fork failed"));
-		fail();
+		kill(child, SIGTERM);	/* make sure we don't create orphans */
 	}
-	if (child == 0) {
-
-		sigprocmask(SIG_SETMASK, &block_mask, NULL);
-		subchild = child = fork();
-		sigprocmask(SIG_SETMASK, &unblock_mask, NULL);
 
-		if (child < 0) {
-			warn(_("fork failed"));
-			fail();
-		}
-		if (child)
-			dooutput();
+	if(eflg) {
+		if (WIFSIGNALED(childstatus))
+			exit(WTERMSIG(childstatus) + 0x80);
 		else
-			doshell();
-	} else {
-		sa.sa_handler = resize;
-		sigaction(SIGWINCH, &sa, NULL);
+			exit(WEXITSTATUS(childstatus));
 	}
-	doinput();
+	exit(EXIT_SUCCESS);
+}
 
-	return EXIT_SUCCESS;
+static void
+fail(void) {
+
+	kill(0, SIGTERM);
+	done();
 }
 
+
 static void wait_for_empty_fd(int fd)
 {
 	struct pollfd fds[] = {
@@ -306,8 +216,24 @@ static void wait_for_empty_fd(int fd)
 	while (die == 0 && poll(fds, 1, 100) == 1);
 }
 
-void
-doinput(void) {
+static void finish(int wait)
+{
+	int status;
+	pid_t pid;
+	int errsv = errno;
+	int options = wait ? 0 : WNOHANG;
+
+	while ((pid = wait3(&status, options, 0)) > 0)
+		if (pid == child) {
+			childstatus = status;
+			die = 1;
+		}
+
+	errno = errsv;
+}
+
+static void doinput(void)
+{
 	int errsv = 0;
 	ssize_t cc = 0;
 	char ibuf[BUFSIZ];
@@ -390,43 +316,18 @@ doinput(void) {
 	done();
 }
 
-void
-finish(int wait) {
-	int status;
-	pid_t pid;
-	int errsv = errno;
-	int options = wait ? 0 : WNOHANG;
-
-	while ((pid = wait3(&status, options, 0)) > 0)
-		if (pid == child) {
-			childstatus = status;
-			die = 1;
-		}
-
-	errno = errsv;
-}
-
-void
-sig_finish(int dummy __attribute__ ((__unused__))) {
+static void sig_finish(int dummy __attribute__ ((__unused__)))
+{
 	finish(0);
 }
 
-void
-resize(int dummy __attribute__ ((__unused__))) {
+static void resize(int dummy __attribute__ ((__unused__)))
+{
 	resized = 1;
 }
 
-/*
- * Stop extremely silly gcc complaint on %c:
- *  warning: `%c' yields only last 2 digits of year in some locales
- */
-static void
-my_strftime(char *buf, size_t len, const char *fmt, const struct tm *tm) {
-	strftime(buf, len, fmt, tm);
-}
-
-void
-dooutput(void) {
+static void dooutput(void)
+{
 	ssize_t cc;
 	char obuf[BUFSIZ];
 	struct timeval tv;
@@ -503,8 +404,26 @@ dooutput(void) {
 	done();
 }
 
-void
-doshell(void) {
+static void getslave(void)
+{
+#ifndef HAVE_LIBUTIL
+	line[strlen("/dev/")] = 't';
+	slave = open(line, O_RDWR);
+	if (slave < 0) {
+		warn(_("cannot open %s"), line);
+		fail();
+	}
+	if (isterm) {
+		tcsetattr(slave, TCSANOW, &tt);
+		ioctl(slave, TIOCSWINSZ, (char *)&win);
+	}
+#endif
+	setsid();
+	ioctl(slave, TIOCSCTTY, 0);
+}
+
+static void doshell(void)
+{
 	char *shname;
 
 	getslave();
@@ -555,8 +474,8 @@ doshell(void) {
 	fail();
 }
 
-void
-fixtty(void) {
+static void fixtty(void)
+{
 	struct termios rtt;
 
 	if (!isterm)
@@ -568,60 +487,8 @@ fixtty(void) {
 	tcsetattr(STDIN_FILENO, TCSANOW, &rtt);
 }
 
-void
-fail(void) {
-
-	kill(0, SIGTERM);
-	done();
-}
-
-void __attribute__((__noreturn__))
-done(void) {
-	time_t tvec;
-
-	if (subchild) {
-		/* output process */
-		if (fscript) {
-			if (!qflg) {
-				char buf[BUFSIZ];
-				tvec = time((time_t *)NULL);
-				my_strftime(buf, sizeof buf, "%c\n", localtime(&tvec));
-				fprintf(fscript, _("\nScript done on %s"), buf);
-			}
-			if (close_stream(fscript) != 0)
-				errx(EXIT_FAILURE, _("write error"));
-			fscript = NULL;
-		}
-		if (timingfd && close_stream(timingfd) != 0)
-			errx(EXIT_FAILURE, _("write error"));
-		timingfd = NULL;
-
-		close(master);
-		master = -1;
-	} else {
-		/* input process */
-		if (isterm)
-			tcsetattr(STDIN_FILENO, TCSADRAIN, &tt);
-		if (!qflg)
-			printf(_("Script done, file is %s\n"), fname);
-#ifdef HAVE_LIBUTEMPTER
-		if (master >= 0)
-			utempter_remove_record(master);
-#endif
-		kill(child, SIGTERM);	/* make sure we don't create orphans */
-	}
-
-	if(eflg) {
-		if (WIFSIGNALED(childstatus))
-			exit(WTERMSIG(childstatus) + 0x80);
-		else
-			exit(WEXITSTATUS(childstatus));
-	}
-	exit(EXIT_SUCCESS);
-}
-
-void
-getmaster(void) {
+static void getmaster(void)
+{
 #if defined(HAVE_LIBUTIL) && defined(HAVE_PTY_H)
 	int rc;
 
@@ -681,20 +548,140 @@ getmaster(void) {
 #endif /* not HAVE_LIBUTIL */
 }
 
-void
-getslave(void) {
-#ifndef HAVE_LIBUTIL
-	line[strlen("/dev/")] = 't';
-	slave = open(line, O_RDWR);
-	if (slave < 0) {
-		warn(_("cannot open %s"), line);
-		fail();
+/*
+ * script -t prints time delays as floating point numbers
+ * The example program (scriptreplay) that we provide to handle this
+ * timing output is a perl script, and does not handle numbers in
+ * locale format (not even when "use locale;" is added).
+ * So, since these numbers are not for human consumption, it seems
+ * easiest to set LC_NUMERIC here.
+ */
+int main(int argc, char **argv)
+{
+	struct sigaction sa;
+	int ch;
+
+	enum { FORCE_OPTION = CHAR_MAX + 1 };
+
+	static const struct option longopts[] = {
+		{ "append",	no_argument,	   NULL, 'a' },
+		{ "command",	required_argument, NULL, 'c' },
+		{ "return",	no_argument,	   NULL, 'e' },
+		{ "flush",	no_argument,	   NULL, 'f' },
+		{ "force",	no_argument,	   NULL, FORCE_OPTION, },
+		{ "quiet",	no_argument,	   NULL, 'q' },
+		{ "timing",	optional_argument, NULL, 't' },
+		{ "version",	no_argument,	   NULL, 'V' },
+		{ "help",	no_argument,	   NULL, 'h' },
+		{ NULL,		0, NULL, 0 }
+	};
+
+	setlocale(LC_ALL, "");
+	setlocale(LC_NUMERIC, "C");	/* see comment above */
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	while ((ch = getopt_long(argc, argv, "ac:efqt::Vh", longopts, NULL)) != -1)
+		switch(ch) {
+		case 'a':
+			aflg = 1;
+			break;
+		case 'c':
+			cflg = optarg;
+			break;
+		case 'e':
+			eflg = 1;
+			break;
+		case 'f':
+			fflg = 1;
+			break;
+		case FORCE_OPTION:
+			forceflg = 1;
+			break;
+		case 'q':
+			qflg = 1;
+			break;
+		case 't':
+			if (optarg && !(timingfd = fopen(optarg, "w")))
+				err(EXIT_FAILURE, _("cannot open %s"), optarg);
+			tflg = 1;
+			break;
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			exit(EXIT_SUCCESS);
+			break;
+		case 'h':
+			usage(stdout);
+			break;
+		case '?':
+		default:
+			usage(stderr);
+		}
+	argc -= optind;
+	argv += optind;
+
+	if (argc > 0)
+		fname = argv[0];
+	else {
+		fname = DEFAULT_OUTPUT;
+		die_if_link(fname);
 	}
-	if (isterm) {
-		tcsetattr(slave, TCSANOW, &tt);
-		ioctl(slave, TIOCSWINSZ, (char *)&win);
+
+	if ((fscript = fopen(fname, aflg ? "a" : "w")) == NULL) {
+		warn(_("cannot open %s"), fname);
+		fail();
 	}
+
+	shell = getenv("SHELL");
+	if (shell == NULL)
+		shell = _PATH_BSHELL;
+
+	getmaster();
+	if (!qflg)
+		printf(_("Script started, file is %s\n"), fname);
+	fixtty();
+
+#ifdef HAVE_LIBUTEMPTER
+	utempter_add_record(master, NULL);
 #endif
-	setsid();
-	ioctl(slave, TIOCSCTTY, 0);
+	/* setup SIGCHLD handler */
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = 0;
+	sa.sa_handler = sig_finish;
+	sigaction(SIGCHLD, &sa, NULL);
+
+	/* init mask for SIGCHLD */
+	sigprocmask(SIG_SETMASK, NULL, &block_mask);
+	sigaddset(&block_mask, SIGCHLD);
+
+	sigprocmask(SIG_SETMASK, &block_mask, &unblock_mask);
+	child = fork();
+	sigprocmask(SIG_SETMASK, &unblock_mask, NULL);
+
+	if (child < 0) {
+		warn(_("fork failed"));
+		fail();
+	}
+	if (child == 0) {
+
+		sigprocmask(SIG_SETMASK, &block_mask, NULL);
+		subchild = child = fork();
+		sigprocmask(SIG_SETMASK, &unblock_mask, NULL);
+
+		if (child < 0) {
+			warn(_("fork failed"));
+			fail();
+		}
+		if (child)
+			dooutput();
+		else
+			doshell();
+	} else {
+		sa.sa_handler = resize;
+		sigaction(SIGWINCH, &sa, NULL);
+	}
+	doinput();
+
+	return EXIT_SUCCESS;
 }
-- 
2.2.1

