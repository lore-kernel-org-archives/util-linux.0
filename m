Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43377 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934779AbeEWWYk (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 23 May 2018 18:24:40 -0400
Received: by mail-wr0-f194.google.com with SMTP id r13-v6so16894256wrj.10
        for <util-linux@vger.kernel.org>; Wed, 23 May 2018 15:24:39 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/2] more: move couple functions
Date: Wed, 23 May 2018 23:24:35 +0100
Message-Id: <20180523222436.28823-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier commit moved lots of functions to work without declarations, but to
be able to get rid of global variables few more moves is needed.

Reference: a8f98304e6d2f4627ca31f6c661934c92b1095f7
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 246 +++++++++++++++++++++++-----------------------
 1 file changed, 123 insertions(+), 123 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index d3317cf9c..603c79003 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -306,6 +306,36 @@ static void cleareol(void)
 	putstring(eraseln);
 }
 
+/* magic --
+ *	check for file magic numbers.  This code would best be shared
+ *	with the file(1) program or, perhaps, more should not try to be
+ *	so smart. */
+static int magic(FILE *f, char *fs)
+{
+	signed char twobytes[2];
+
+	/* don't try to look ahead if the input is unseekable */
+	if (fseek(f, 0L, SEEK_SET))
+		return 0;
+
+	if (fread(twobytes, 2, 1, f) == 1) {
+		switch (twobytes[0] + (twobytes[1] << 8)) {
+		case 0407:	/* a.out obj */
+		case 0410:	/* a.out exec */
+		case 0413:	/* a.out demand exec */
+		case 0405:
+		case 0411:
+		case 0177545:
+		case 0x457f:	/* simple ELF detection */
+			printf(_("\n******** %s: Not a text file ********\n\n"),
+			       fs);
+			return 1;
+		}
+	}
+	fseek(f, 0L, SEEK_SET);	/* rewind() not necessary */
+	return 0;
+}
+
 /* Check whether the file named by fs is an ASCII file which the user may
  * access.  If it is, return the opened file.  Otherwise return NULL. */
 static FILE *checkf(register char *fs, int *clearfirst)
@@ -343,36 +373,6 @@ static FILE *checkf(register char *fs, int *clearfirst)
 	return (f);
 }
 
-/* magic --
- *	check for file magic numbers.  This code would best be shared
- *	with the file(1) program or, perhaps, more should not try to be
- *	so smart. */
-static int magic(FILE *f, char *fs)
-{
-	signed char twobytes[2];
-
-	/* don't try to look ahead if the input is unseekable */
-	if (fseek(f, 0L, SEEK_SET))
-		return 0;
-
-	if (fread(twobytes, 2, 1, f) == 1) {
-		switch (twobytes[0] + (twobytes[1] << 8)) {
-		case 0407:	/* a.out obj */
-		case 0410:	/* a.out exec */
-		case 0413:	/* a.out demand exec */
-		case 0405:
-		case 0411:
-		case 0177545:
-		case 0x457f:	/* simple ELF detection */
-			printf(_("\n******** %s: Not a text file ********\n\n"),
-			       fs);
-			return 1;
-		}
-	}
-	fseek(f, 0L, SEEK_SET);	/* rewind() not necessary */
-	return 0;
-}
-
 static void prepare_line_buffer(void)
 {
 	char *nline;
@@ -737,6 +737,53 @@ static void prompt(char *filename)
 	inwait++;
 }
 
+static int ourputch(int c)
+{
+	return putc(c, stdout);
+}
+
+static void reset_tty(void)
+{
+	if (no_tty)
+		return;
+	if (pstate) {
+		/* putchar - if that isn't a macro */
+		tputs(ULexit, fileno(stdout), ourputch);
+		fflush(stdout);
+		pstate = 0;
+	}
+	otty.c_lflag |= ICANON | ECHO;
+	otty.c_cc[VMIN] = savetty0.c_cc[VMIN];
+	otty.c_cc[VTIME] = savetty0.c_cc[VTIME];
+	stty(fileno(stderr), &savetty0);
+}
+
+/* Clean up terminal state and exit. Also come here if interrupt signal received */
+static void __attribute__((__noreturn__)) end_it(int dummy __attribute__((__unused__)))
+{
+	/* May be executed as a signal handler as well as by main process.
+	 *
+	 * The _exit() may wait for pending I/O for really long time, be sure
+	 * that signal handler is not executed in this time to avoid double
+	 * de-initialization (free() calls, etc.).
+	 */
+	signal(SIGINT, SIG_IGN);
+
+	reset_tty();
+	if (clreol) {
+		putchar('\r');
+		clreos();
+		fflush(stdout);
+	} else if (!clreol && (promptlen > 0)) {
+		kill_line();
+		fflush(stdout);
+	} else
+		putcerr('\n');
+	free(previousre);
+	free(Line);
+	_exit(EXIT_SUCCESS);
+}
+
 static int readch(void)
 {
 	unsigned char c;
@@ -1011,33 +1058,60 @@ static int expand(char **outbuf, char *inbuf)
 	return (changed);
 }
 
-static int ourputch(int c)
+static void set_tty(void)
 {
-	return putc(c, stdout);
+	otty.c_lflag &= ~(ICANON | ECHO);
+	otty.c_cc[VMIN] = 1;	/* read at least 1 char */
+	otty.c_cc[VTIME] = 0;	/* no timeout */
+	stty(fileno(stderr), &otty);
 }
 
-static void reset_tty(void)
+/* Come here if a quit signal is received */
+static void onquit(int dummy __attribute__((__unused__)))
 {
-	if (no_tty)
-		return;
-	if (pstate) {
-		/* putchar - if that isn't a macro */
-		tputs(ULexit, fileno(stdout), ourputch);
-		fflush(stdout);
-		pstate = 0;
+	signal(SIGQUIT, SIG_IGN);
+	if (!inwait) {
+		putchar('\n');
+		if (!startup) {
+			signal(SIGQUIT, onquit);
+			siglongjmp(restore, 1);
+		} else
+			Pause++;
+	} else if (!dum_opt && notell) {
+		promptlen += fprintf(stderr, _("[Use q or Q to quit]"));
+		notell = 0;
 	}
-	otty.c_lflag |= ICANON | ECHO;
-	otty.c_cc[VMIN] = savetty0.c_cc[VMIN];
-	otty.c_cc[VTIME] = savetty0.c_cc[VTIME];
-	stty(fileno(stderr), &savetty0);
+	signal(SIGQUIT, onquit);
 }
 
-static void set_tty(void)
+/* Come here when we get a suspend signal from the terminal */
+static void onsusp(int dummy __attribute__((__unused__)))
 {
-	otty.c_lflag &= ~(ICANON | ECHO);
-	otty.c_cc[VMIN] = 1;	/* read at least 1 char */
-	otty.c_cc[VTIME] = 0;	/* no timeout */
-	stty(fileno(stderr), &otty);
+	sigset_t signals, oldmask;
+
+	/* ignore SIGTTOU so we don't get stopped if csh grabs the tty */
+	signal(SIGTTOU, SIG_IGN);
+	reset_tty();
+	fflush(stdout);
+	signal(SIGTTOU, SIG_DFL);
+	/* Send the TSTP signal to suspend our process group */
+	signal(SIGTSTP, SIG_DFL);
+
+	/* unblock SIGTSTP or we won't be able to suspend ourself */
+	sigemptyset(&signals);
+	sigaddset(&signals, SIGTSTP);
+	sigprocmask(SIG_UNBLOCK, &signals, &oldmask);
+
+	kill(0, SIGTSTP);
+	/* Pause for station break */
+
+	sigprocmask(SIG_SETMASK, &oldmask, NULL);
+
+	/* We're back */
+	signal(SIGTSTP, onsusp);
+	set_tty();
+	if (inwait)
+		siglongjmp(restore, 1);
 }
 
 static void execute(char *filename, char *cmd, ...)
@@ -1688,24 +1762,6 @@ static void screen(register FILE *f, register int num_lines)
 	}
 }
 
-/* Come here if a quit signal is received */
-static void onquit(int dummy __attribute__((__unused__)))
-{
-	signal(SIGQUIT, SIG_IGN);
-	if (!inwait) {
-		putchar('\n');
-		if (!startup) {
-			signal(SIGQUIT, onquit);
-			siglongjmp(restore, 1);
-		} else
-			Pause++;
-	} else if (!dum_opt && notell) {
-		promptlen += fprintf(stderr, _("[Use q or Q to quit]"));
-		notell = 0;
-	}
-	signal(SIGQUIT, onquit);
-}
-
 /* Come here if a signal for a window size change is received */
 #ifdef SIGWINCH
 static void chgwinsz(int dummy __attribute__((__unused__)))
@@ -1728,32 +1784,6 @@ static void chgwinsz(int dummy __attribute__((__unused__)))
 }
 #endif				/* SIGWINCH */
 
-/* Clean up terminal state and exit. Also come here if interrupt signal received */
-static void __attribute__((__noreturn__)) end_it(int dummy __attribute__((__unused__)))
-{
-	/* May be executed as a signal handler as well as by main process.
-	 *
-	 * The _exit() may wait for pending I/O for really long time, be sure
-	 * that signal handler is not executed in this time to avoid double
-	 * de-initialization (free() calls, etc.).
-	 */
-	signal(SIGINT, SIG_IGN);
-
-	reset_tty();
-	if (clreol) {
-		putchar('\r');
-		clreos();
-		fflush(stdout);
-	} else if (!clreol && (promptlen > 0)) {
-		kill_line();
-		fflush(stdout);
-	} else
-		putcerr('\n');
-	free(previousre);
-	free(Line);
-	_exit(EXIT_SUCCESS);
-}
-
 static void copy_file(register FILE *f)
 {
 	char buf[BUFSIZ];
@@ -1896,36 +1926,6 @@ static void initterm(void)
 	}
 }
 
-/* Come here when we get a suspend signal from the terminal */
-static void onsusp(int dummy __attribute__((__unused__)))
-{
-	sigset_t signals, oldmask;
-
-	/* ignore SIGTTOU so we don't get stopped if csh grabs the tty */
-	signal(SIGTTOU, SIG_IGN);
-	reset_tty();
-	fflush(stdout);
-	signal(SIGTTOU, SIG_DFL);
-	/* Send the TSTP signal to suspend our process group */
-	signal(SIGTSTP, SIG_DFL);
-
-	/* unblock SIGTSTP or we won't be able to suspend ourself */
-	sigemptyset(&signals);
-	sigaddset(&signals, SIGTSTP);
-	sigprocmask(SIG_UNBLOCK, &signals, &oldmask);
-
-	kill(0, SIGTSTP);
-	/* Pause for station break */
-
-	sigprocmask(SIG_SETMASK, &oldmask, NULL);
-
-	/* We're back */
-	signal(SIGTSTP, onsusp);
-	set_tty();
-	if (inwait)
-		siglongjmp(restore, 1);
-}
-
 int main(int argc, char **argv)
 {
 	FILE *f;
-- 
2.17.0

