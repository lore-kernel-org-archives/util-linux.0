Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f177.google.com ([74.125.82.177]:41908 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbbBVOod (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:33 -0500
Received: by wevm14 with SMTP id m14so13592407wev.8
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:32 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 21/31] more: replace siglongjmp() and signal() calls with signalfd()
Date: Sun, 22 Feb 2015 14:43:17 +0000
Message-Id: <1424616207-747-22-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>From man siglongjmp(3) 'longjmp() and siglongjmp() make programs hard to
understand and maintain.  If possible, an alternative should be used.'

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 246 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 133 insertions(+), 113 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 5586e69..9a3d96b 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -43,12 +43,13 @@
  *	modified mem allocation handling for util-linux
  */
 
+#include <assert.h>
 #include <ctype.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <paths.h>
+#include <poll.h>
 #include <regex.h>
-#include <setjmp.h>
 #include <signal.h>
 #include <stdarg.h>
 #include <stdio.h>
@@ -57,6 +58,7 @@
 #include <sys/file.h>
 #include <sys/ioctl.h>
 #include <sys/param.h>
+#include <sys/signalfd.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
 #include <termios.h>
@@ -72,6 +74,7 @@
 
 #include "closestream.h"
 #include "nls.h"
+#include "rpmatch.h"
 #include "strutils.h"
 #include "widechar.h"
 #include "xalloc.h"
@@ -99,6 +102,7 @@
 #define COMMAND_BUF	200
 #define REGERR_BUF	NUM_COLUMNS
 #define STOP		-10
+#define SEARCH_TIMEOUT	10
 
 struct more_control {
 	struct termios otty;		/* output terminal */
@@ -115,7 +119,7 @@ struct more_control {
 	int nfiles;			/* number of files left to process */
 	char *shell;			/* the name of the shell to use */
 	int shellp;			/* does previous shell command exists */
-	sigjmp_buf restore;		/* siglongjmp() destination */
+	int sigfd;			/* signalfd() file descriptor */
 	char *Line;			/* line buffer */
 	size_t LineLen;			/* size of line buffer */
 	int Lpp;			/* lines per page */
@@ -161,7 +165,6 @@ struct more_control {
 		hard:1,			/* is this hard copy terminal */
 		hardtabs:1,		/* print spaces instead of '\t' */
 		jumpopt:1,		/* is jumpline defined */
-		inwait:1,		/* is waiting user input */
 		lastp:1,		/* run previous key command */
 		noscroll:1,		/* do not scroll, clear the screen and then display text */
 		notell:1,		/* suppress quit dialog */
@@ -172,17 +175,14 @@ struct more_control {
 		pstate:1,		/* is underlining going on */
 		soglitch:1,		/* terminal has standout mode glitch */
 		srchopt:1,		/* is init search pattern defined */
+		search_called:1,	/* previous more command was a search */
 		ssp_opt:1,		/* suppress white space */
-		startup:1,		/* is startup completed */
 		stop_opt:1,		/* stop after form feeds */
 		ulglitch:1,		/* terminal is underlining in glitch mode */
 		ul_opt:1,		/* underline as best we can */
 		within:1,		/* true if we are within a file, false if we are between files */
 		Wrap:1;			/* set if automargins */
 };
-/* FIXME: the global_ctl is used in signal handlers, until the signal
- * handling is corrected to use signalfd().  */
-struct more_control *global_ctl;
 
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
@@ -696,7 +696,6 @@ static void prompt(struct more_control *ctl, char *filename)
 		fflush(stdout);
 	} else
 		fputc('\a', stderr);
-	ctl->inwait = 1;
 }
 
 static void reset_tty(struct more_control *ctl)
@@ -715,20 +714,20 @@ static void reset_tty(struct more_control *ctl)
 }
 
 /* Clean up terminal state and exit. Also come here if interrupt signal received */
-static void __attribute__((__noreturn__)) end_it(int dummy __attribute__((__unused__)))
+static void __attribute__((__noreturn__)) end_it(struct more_control *ctl)
 {
-	reset_tty(global_ctl);
-	if (global_ctl->clreol) {
+	reset_tty(ctl);
+	if (ctl->clreol) {
 		putchar('\r');
-		my_putstring(global_ctl->EodClr);
+		my_putstring(ctl->EodClr);
 		fflush(stdout);
-	} else if (!global_ctl->clreol && (global_ctl->promptlen > 0)) {
-		kill_line(global_ctl);
+	} else if (!ctl->clreol && (ctl->promptlen > 0)) {
+		kill_line(ctl);
 		fflush(stdout);
 	} else
 		fputc('\n', stderr);
-	free(global_ctl->previousre);
-	free(global_ctl->Line);
+	free(ctl->previousre);
+	free(ctl->Line);
 	_exit(EXIT_SUCCESS);
 }
 
@@ -739,7 +738,7 @@ static int readch(struct more_control *ctl)
 	errno = 0;
 	if (read(STDERR_FILENO, &c, 1) <= 0) {
 		if (errno != EINTR)
-			end_it(0);
+			end_it(ctl);
 		else
 			c = ctl->otty.c_cc[VKILL];
 	}
@@ -822,7 +821,6 @@ static void more_error(struct more_control *ctl, char *mess)
 		fputs(mess, stdout);
 	fflush(stdout);
 	ctl->errors++;
-	siglongjmp(ctl->restore, 1);
 }
 
 static void erase_one_column(struct more_control *ctl)
@@ -911,7 +909,6 @@ static void ttyin(struct more_control *ctl, char buf[], int nmax, char pchar)
 			} else {
 				if (!ctl->eraseln)
 					ctl->promptlen = maxlen;
-				siglongjmp(ctl->restore, 1);
 			}
 		} else if (((cc_t) c == ctl->otty.c_cc[VKILL]) && !slash) {
 			if (ctl->hard) {
@@ -1019,51 +1016,23 @@ static void set_tty(struct more_control *ctl)
 }
 
 /* Come here if a quit signal is received */
-static void onquit(int dummy __attribute__((__unused__)))
+static void onquit(struct more_control *ctl)
 {
-	signal(SIGQUIT, SIG_IGN);
-	if (!global_ctl->inwait) {
-		putchar('\n');
-		if (!global_ctl->startup) {
-			signal(SIGQUIT, onquit);
-			siglongjmp(global_ctl->restore, 1);
-		} else
-			global_ctl->Pause = 1;
-	} else if (!global_ctl->dum_opt && global_ctl->notell) {
-		global_ctl->promptlen += fprintf(stderr, _("[Use q or Q to quit]"));
-		global_ctl->notell = 0;
-	}
-	signal(SIGQUIT, onquit);
+	if (!ctl->dum_opt && ctl->notell) {
+		ctl->promptlen += fprintf(stderr, _("[Use q or Q to quit]"));
+		ctl->notell = 0;
+	} else
+		end_it(ctl);
 }
 
 /* Come here when we get a suspend signal from the terminal */
-static void onsusp(int dummy __attribute__((__unused__)))
+static void onsusp(struct more_control *ctl)
 {
-	sigset_t signals, oldmask;
-
-	/* ignore SIGTTOU so we don't get stopped if csh grabs the tty */
-	signal(SIGTTOU, SIG_IGN);
-	reset_tty(global_ctl);
+	reset_tty(ctl);
 	fflush(stdout);
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
+	kill(0, SIGSTOP);
 	/* We're back */
-	signal(SIGTSTP, onsusp);
-	set_tty(global_ctl);
-	if (global_ctl->inwait)
-		siglongjmp(global_ctl->restore, 1);
+	set_tty(ctl);
 }
 
 static void execute(struct more_control *ctl, char *filename, char *cmd, ...)
@@ -1115,15 +1084,8 @@ static void execute(struct more_control *ctl, char *filename, char *cmd, ...)
 		exit(EXIT_FAILURE);
 	}
 	if (id > 0) {
-		signal(SIGINT, SIG_IGN);
-		signal(SIGQUIT, SIG_IGN);
-		if (ctl->catch_susp)
-			signal(SIGTSTP, SIG_DFL);
 		while (wait(0) > 0)
 			/* nothing */ ;
-		signal(SIGQUIT, onquit);
-		if (ctl->catch_susp)
-			signal(SIGTSTP, onsusp);
 	} else
 		fputs(_("can't fork\n"), stderr);
 	set_tty(ctl);
@@ -1195,7 +1157,7 @@ static int colon(struct more_control *ctl, char *filename, int cmd, int nlines)
 	case 'n':
 		if (nlines == 0) {
 			if (ctl->fnum >= ctl->nfiles - 1)
-				end_it(0);
+				end_it(ctl);
 			nlines++;
 		}
 		putchar('\r');
@@ -1218,7 +1180,7 @@ static int colon(struct more_control *ctl, char *filename, int cmd, int nlines)
 		return -1;
 	case 'q':
 	case 'Q':
-		end_it(0);
+		end_it(ctl);
 	default:
 		fputc('\a', stderr);
 		return -1;
@@ -1267,6 +1229,26 @@ static void rdline(struct more_control *ctl, FILE *f)
 	*p = '\0';
 }
 
+volatile sig_atomic_t alarm_received;
+
+static void sig_alarm_handler(int sig __attribute__((__unused__)))
+{
+	alarm_received = 1;
+}
+
+static int stop_search(struct more_control *ctl)
+{
+	char buf[2];
+
+	ctl->promptlen = printf(_("No search results in %d seconds, stop searching?"), SEARCH_TIMEOUT);
+	buf[0] = getchar();
+	buf[1] = '\0';
+	erasep(ctl, 0);
+	alarm(SEARCH_TIMEOUT);
+	alarm_received = 0;
+	return rpmatch(buf);
+}
+
 /* Search for nth occurrence of regular expression contained in buf in
  * the file */
 static void search(struct more_control *ctl, char buf[], FILE *file, int n)
@@ -1288,8 +1270,14 @@ static void search(struct more_control *ctl, char buf[], FILE *file, int n)
 		char s[REGERR_BUF];
 		regerror(rc, &re, s, sizeof s);
 		more_error(ctl, s);
+		return;
 	}
+	alarm_received = 0;
+	signal(SIGALRM, sig_alarm_handler);
+	alarm(SEARCH_TIMEOUT);
 	while (!feof(file)) {
+		if (alarm_received && stop_search(ctl))
+			break;
 		line3 = line2;
 		line2 = line1;
 		line1 = ctl->file_pos;
@@ -1329,6 +1317,8 @@ static void search(struct more_control *ctl, char buf[], FILE *file, int n)
 			}
 		}
 	}
+	alarm(0);
+	signal(SIGALRM, SIG_DFL);
 	regfree(&re);
 	if (feof(file)) {
 		if (!ctl->no_intty) {
@@ -1336,7 +1326,7 @@ static void search(struct more_control *ctl, char buf[], FILE *file, int n)
 			set_pos_fseek(ctl, file, startline);
 		} else {
 			fputs(_("\nPattern not found\n"), stdout);
-			end_it(0);
+			end_it(ctl);
 		}
 		free(ctl->previousre);
 		ctl->previousre = NULL;
@@ -1467,6 +1457,26 @@ static int skip_forwards(struct more_control *ctl, FILE *f, int nlines, char com
 	return 1;
 }
 
+/* Come here if a signal for a window size change is received */
+#ifdef SIGWINCH
+static void chgwinsz(struct more_control *ctl)
+{
+	struct winsize win;
+
+	if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &win) != -1) {
+		if (win.ws_row != 0) {
+			ctl->Lpp = win.ws_row;
+			ctl->nscroll = ctl->Lpp / 2 - 1;
+			if (ctl->nscroll <= 0)
+				ctl->nscroll = 1;
+			ctl->dlines = ctl->Lpp - 1;
+		}
+		if (win.ws_col != 0)
+			ctl->Mcol = win.ws_col;
+	}
+}
+#endif				/* SIGWINCH */
+
 /* Read a command and do it.  A command consists of an optional integer
  * argument followed by the command character.  Return the number of
  * lines to display in the next screenful.  If there is nothing more to
@@ -1478,12 +1488,51 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 	char colonch;
 	int done = 0;
 	char comchar, cmdbuf[INIT_BUF];
+	struct pollfd pfd[2];
 
+	pfd[0].fd = ctl->sigfd;
+	pfd[0].events = POLLIN | POLLERR | POLLHUP;
+	pfd[1].fd = STDIN_FILENO;
+	pfd[1].events = POLLIN;
 	if (!ctl->errors)
 		prompt(ctl, filename);
 	else
 		ctl->errors = 0;
+	ctl->search_called = 0;
 	while (!done) {
+		if (poll(pfd, 2, -1) < 0) {
+			if (errno == EAGAIN)
+				continue;
+			more_error(ctl, _("poll failed"));
+			continue;
+		}
+		if (pfd[0].revents != 0) {
+			struct signalfd_siginfo info;
+			ssize_t sz;
+
+			sz = read(pfd[0].fd, &info, sizeof(info));
+			assert(sz == sizeof(info));
+			switch (info.ssi_signo) {
+			case SIGINT:
+				end_it(ctl);
+				break;
+			case SIGQUIT:
+				onquit(ctl);
+				break;
+			case SIGTSTP:
+				onsusp(ctl);
+				break;
+#ifdef SIGWINCH
+			case SIGWINCH:
+				chgwinsz(ctl);
+				break;
+#endif
+			default:
+				abort();
+			}
+		}
+		if (pfd[1].revents == 0)
+			continue;
 		nlines = number(ctl, &comchar);
 		ctl->lastp = colonch = 0;
 		if (comchar == '.') {	/* Repeat last command */
@@ -1533,7 +1582,7 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 			break;
 		case 'q':
 		case 'Q':
-			end_it(0);
+			end_it(ctl);
 		case 's':
 		case 'f':
 		case ctrl('F'):
@@ -1587,6 +1636,7 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 			ctl->lastp = 1;
 			/* fall through */
 		case '/':
+			ctl->search_called = 1;
 			if (nlines == 0)
 				nlines++;
 			kill_line(ctl);
@@ -1643,7 +1693,6 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 		}
 	}
 	putchar('\r');
-	ctl->inwait = 0;
 	ctl->notell = 1;
 	return retval;
 }
@@ -1699,11 +1748,11 @@ static void screen(struct more_control *ctl, FILE *f, int num_lines)
 		if (ctl->Pause && ctl->clreol)
 			my_putstring(ctl->EodClr);
 		more_ungetc(ctl, c, f);
-		sigsetjmp(ctl->restore, 1);
 		ctl->Pause = 0;
-		ctl->startup = 0;
-		if ((num_lines = command(ctl, NULL, f)) == 0)
-			return;
+		do {
+			if ((num_lines = command(ctl, NULL, f)) == 0)
+				return;
+		} while (ctl->search_called && !ctl->previousre);
 		if (ctl->hard && ctl->promptlen > 0)
 			erasep(ctl, 0);
 		if (ctl->noscroll && num_lines >= ctl->dlines) {
@@ -1717,28 +1766,6 @@ static void screen(struct more_control *ctl, FILE *f, int num_lines)
 	}
 }
 
-/* Come here if a signal for a window size change is received */
-#ifdef SIGWINCH
-static void chgwinsz(int dummy __attribute__((__unused__)))
-{
-	struct winsize win;
-
-	signal(SIGWINCH, SIG_IGN);
-	if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &win) != -1) {
-		if (win.ws_row != 0) {
-			global_ctl->Lpp = win.ws_row;
-			global_ctl->nscroll = global_ctl->Lpp / 2 - 1;
-			if (global_ctl->nscroll <= 0)
-				global_ctl->nscroll = 1;
-			global_ctl->dlines = global_ctl->Lpp - 1;
-		}
-		if (win.ws_col != 0)
-			global_ctl->Mcol = win.ws_col;
-	}
-	signal(SIGWINCH, chgwinsz);
-}
-#endif				/* SIGWINCH */
-
 static void copy_file(FILE *f)
 {
 	char buf[BUFSIZ];
@@ -1869,8 +1896,6 @@ static void display_file(struct more_control *ctl, FILE *f, char *initbuf, int l
 	ctl->context.line = ctl->context.chrctr = 0;
 	ctl->Currline = 0;
 	ctl->file_pos = 0;
-	if (ctl->firstf)
-		sigsetjmp(ctl->restore, 1);
 	if (ctl->firstf) {
 		ctl->firstf = 0;
 		if (ctl->srchopt) {
@@ -1881,10 +1906,8 @@ static void display_file(struct more_control *ctl, FILE *f, char *initbuf, int l
 				left--;
 		} else if (ctl->jumpopt)
 			skiplns(ctl, f);
-	} else if (ctl->fnum < ctl->nfiles && !ctl->no_tty) {
-		sigsetjmp(ctl->restore, 1);
+	} else if (ctl->fnum < ctl->nfiles && !ctl->no_tty)
 		left = command(ctl, ctl->fnames[ctl->fnum], f);
-	}
 	if (left != 0) {
 		if ((ctl->noscroll || ctl->clearfirst)
 		    && (ctl->file_size != LONG_MAX)) {
@@ -1919,7 +1942,6 @@ static void display_file(struct more_control *ctl, FILE *f, char *initbuf, int l
 			ctl->within = 0;
 		}
 	}
-	sigsetjmp(ctl->restore, 1);
 	fflush(stdout);
 	fclose(f);
 	ctl->screen_start.line = ctl->screen_start.chrctr = 0L;
@@ -1933,11 +1955,11 @@ int main(int argc, char **argv)
 	int c;
 	int left;
 	char *initbuf = NULL;
+	sigset_t sigset;
 	struct more_control ctl = {
 		.firstf = 1,
 		.fold_opt = 1,
 		.notell = 1,
-		.startup = 1,
 		.stop_opt = 1,
 		.ul_opt = 1,
 		.Wrap = 1,
@@ -1946,7 +1968,6 @@ int main(int argc, char **argv)
 		.nscroll = SCROLL_LEN,
 		0
 	};
-	global_ctl = &ctl;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -2007,18 +2028,17 @@ int main(int argc, char **argv)
 		ctl.prnames = 1;
 	if (!ctl.no_intty && ctl.nfiles == 0)
 		usage(stderr);
-	if (!ctl.no_tty) {
-		signal(SIGQUIT, onquit);
-		signal(SIGINT, end_it);
+	if (!ctl.no_tty)
+		tcsetattr(STDERR_FILENO, TCSANOW, &ctl.otty);
+	sigemptyset(&sigset);
+	sigaddset(&sigset, SIGINT);
+	sigaddset(&sigset, SIGQUIT);
+	sigaddset(&sigset, SIGTSTP);
 #ifdef SIGWINCH
-		signal(SIGWINCH, chgwinsz);
+	sigaddset(&sigset, SIGWINCH);
 #endif
-		if (signal(SIGTSTP, SIG_IGN) == SIG_DFL) {
-			signal(SIGTSTP, onsusp);
-			ctl.catch_susp = 1;
-		}
-		tcsetattr(STDERR_FILENO, TCSANOW, &ctl.otty);
-	}
+	sigprocmask(SIG_BLOCK, &sigset, NULL);
+	ctl.sigfd = signalfd(-1, &sigset, SFD_CLOEXEC);
 	if (ctl.no_intty) {
 		if (ctl.no_tty)
 			copy_file(stdin);
-- 
2.3.0

