Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f51.google.com ([74.125.82.51]:56958 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbbBVOn5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:43:57 -0500
Received: by mail-wg0-f51.google.com with SMTP id y19so21183685wgg.10
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:43:56 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 04/31] more: remove dead code and useless comments
Date: Sun, 22 Feb 2015 14:43:00 +0000
Message-Id: <1424616207-747-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Removed code did not do anything (added features that where never
completed?) and comments mostly mislead anyone who read them.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more-term.h |   2 -
 text-utils/more.c      | 109 ++++++++++++++-----------------------------------
 2 files changed, 31 insertions(+), 80 deletions(-)

diff --git a/text-utils/more-term.h b/text-utils/more-term.h
index f3577f4..b78da5e 100644
--- a/text-utils/more-term.h
+++ b/text-utils/more-term.h
@@ -17,7 +17,6 @@
 # define TERM_LINES			"lines"
 # define TERM_LINE_DOWN			"cud1"
 # define TERM_OVER_STRIKE		"os"
-# define TERM_PAD_CHAR			"pad"
 # define TERM_STANDARD_MODE		"smso"
 # define TERM_STD_MODE_GLITCH		"xmc"
 # define TERM_UNDERLINE			"ul"
@@ -72,7 +71,6 @@ static inline char *my_tgoto(char *cap, int col, int row)
 # define TERM_LINES			"li"
 # define TERM_LINE_DOWN			"le"
 # define TERM_OVER_STRIKE		"os"
-# define TERM_PAD_CHAR			"pc"
 # define TERM_STANDARD_MODE		"so"
 # define TERM_STD_MODE_GLITCH		"sg"
 # define TERM_UNDERLINE			"ul"
diff --git a/text-utils/more.c b/text-utils/more.c
index 020f9b9..7743570 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -49,9 +49,9 @@
 #include <regex.h>
 #include <setjmp.h>
 #include <signal.h>
-#include <stdarg.h>		/* for va_start() etc */
+#include <stdarg.h>
 #include <stdio.h>
-#include <stdlib.h>		/* for alloca() */
+#include <stdlib.h>
 #include <string.h>
 #include <sys/file.h>
 #include <sys/ioctl.h>
@@ -159,15 +159,11 @@ struct more_control {
 		long line;		/* line number */
 	} context,
 	  screen_start;
-	char PC;			/* pad character (instead of null) */
-	char ch;			/* temporary character. FIXME: move to function scope */
 	int lastcmd;			/* previous more key command */
 	int lastarg;			/* previous key command argument */
 	int lastcolon;			/* is a colon-prefixed key command */
 	char shell_line[SHELL_LINE];
 #if !defined(HAVE_NCURSES_H) && !defined(HAVE_NCURSES_NCURSES_H) && defined(HAVE_LIBTERMCAP)
-	char termbuffer[TERMINAL_BUF];	/* FIXME: remove, not in use */
-	char *strbuf = termbuffer;	/* FIXME: remove, not in use */
 	char tcbuffer[TERMINAL_BUF];	/* buffer for my_setupterm() in more-term.h */
 #endif
 	unsigned int
@@ -192,7 +188,6 @@ struct more_control {
 		no_tty:1,		/* is output in interactive mode */
 		Pause:1,		/* is output paused */
 		pstate:1,		/* is underlining going on */
-		slow_tty:1,		/* is output speed slow. FIXME: remove */
 		soglitch:1,		/* terminal has standout mode glitch */
 		ssp_opt:1,		/* suppress white space */
 		startup:1,		/* is startup completed */
@@ -365,7 +360,6 @@ static FILE *checkf(struct more_control *ctl, register char *fs, int *clearfirst
 
 static void prepare_line_buffer(struct more_control *ctl)
 {
-	char *nline;
 	size_t nsz = ctl->Mcol * 4;
 
 	if (ctl->LineLen >= nsz)
@@ -375,8 +369,7 @@ static void prepare_line_buffer(struct more_control *ctl)
 		nsz = LINSIZ;
 
 	/* alloc nsz and extra space for \n\0 */
-	nline = xrealloc(ctl->Line, nsz + 2);
-	ctl->Line = nline;
+	ctl->Line = xrealloc(ctl->Line, nsz + 2);
 	ctl->LineLen = nsz;
 }
 
@@ -400,9 +393,8 @@ static int get_line(struct more_control *ctl, register FILE *f, int *length)
 	int break_flag = 0;		/* If 1, exit while(). */
 	long file_pos_bak = Ftell(f);
 
-	memset(&state, '\0', sizeof(mbstate_t));
+	memset(&state, 0, sizeof state);
 #endif
-
 	prepare_line_buffer(ctl);
 
 	p = ctl->Line;
@@ -481,20 +473,6 @@ static int get_line(struct more_control *ctl, register FILE *f, int *length)
 		}
 
 		*p++ = c;
-#if 0
-		if (c == '\033') {	/* ESC */
-			c = Getc(f);
-			while (c > ' ' && c < '0' && p < &Line[LineLen - 1]) {
-				*p++ = c;
-				c = Getc(f);
-			}
-			if (c >= '0' && c < '\177' && p < &Line[LineLen - 1]) {
-				*p++ = c;
-				c = Getc(f);
-				continue;
-			}
-		}
-#endif	/* 0 */
 		if (c == '\t') {
 			if (!ctl->hardtabs || (column < ctl->promptlen && !ctl->hard)) {
 				if (ctl->hardtabs && ctl->eraseln && !ctl->dumb) {
@@ -534,7 +512,7 @@ static int get_line(struct more_control *ctl, register FILE *f, int *length)
 		} else {
 #ifdef HAVE_WIDECHAR
 			if (ctl->fold_opt && MB_CUR_MAX > 1) {
-				memset(mbc, '\0', MB_LEN_MAX);
+				memset(mbc, 0, MB_LEN_MAX);
 				mbc_pos = 0;
 				mbc[mbc_pos++] = c;
 				state_bak = state;
@@ -660,7 +638,8 @@ static void prbuf(struct more_control *ctl, register char *s, register int n)
 				wchar_t wc;
 				size_t mblength;
 				mbstate_t mbstate;
-				memset(&mbstate, '\0', sizeof(mbstate_t));
+
+				memset(&mbstate, 0, sizeof mbstate);
 				s--;
 				n++;
 				mblength = xmbrtowc(&wc, s, n, &mbstate);
@@ -733,7 +712,6 @@ static void reset_tty(struct more_control *ctl)
 	if (ctl->no_tty)
 		return;
 	if (ctl->pstate) {
-		/* putchar - if that isn't a macro */
 		tputs(ctl->ULexit, fileno(stdout), ourputch);
 		fflush(stdout);
 		ctl->pstate = 0;
@@ -781,17 +759,17 @@ static int readch(struct more_control *ctl)
 static int number(struct more_control *ctl, char *cmd)
 {
 	register int i;
+	char ch;
 
 	i = 0;
-	ctl->ch = ctl->otty.c_cc[VKILL];
 	for (;;) {
-		ctl->ch = readch(ctl);
-		if (isdigit(ctl->ch))
-			i = i * 10 + ctl->ch - '0';
-		else if ((cc_t) ctl->ch == ctl->otty.c_cc[VKILL])
+		ch = readch(ctl);
+		if (isdigit(ch))
+			i = i * 10 + ch - '0';
+		else if ((cc_t)ch == ctl->otty.c_cc[VKILL])
 			i = 0;
 		else {
-			*cmd = ctl->ch;
+			*cmd = ch;
 			break;
 		}
 	}
@@ -878,8 +856,7 @@ static void ttyin(struct more_control *ctl, char buf[], register int nmax, char
 					size_t pos = 0, mblength;
 					mbstate_t state, state_bak;
 
-					memset(&state, '\0', sizeof(mbstate_t));
-
+					memset(&state, 0, sizeof state);
 					while (1) {
 						state_bak = state;
 						mblength =
@@ -977,7 +954,6 @@ static void ttyin(struct more_control *ctl, char buf[], register int nmax, char
 		more_error(ctl, _("Line too long"));
 }
 
-/* return: 0 - unchanged, 1 - changed, -1 - overflow (unchanged) */
 static int expand(struct more_control *ctl, char **outbuf, char *inbuf)
 {
 	char *inpstr;
@@ -1004,7 +980,7 @@ static int expand(struct more_control *ctl, char **outbuf, char *inbuf)
 			if (!ctl->no_intty) {
 				strcpy(outstr, ctl->fnames[ctl->fnum]);
 				outstr += strlen(ctl->fnames[ctl->fnum]);
-				changed++;
+				changed = 1;
 			} else
 				*outstr++ = c;
 			break;
@@ -1014,7 +990,7 @@ static int expand(struct more_control *ctl, char **outbuf, char *inbuf)
 					   ("No previous command to substitute for"));
 			strcpy(outstr, ctl->shell_line);
 			outstr += strlen(ctl->shell_line);
-			changed++;
+			changed = 1;
 			break;
 		case '\\':
 			if (*inpstr == '%' || *inpstr == '!') {
@@ -1100,8 +1076,8 @@ static void execute(struct more_control *ctl, char *filename, char *cmd, ...)
 	for (n = 10; (id = fork()) < 0 && n > 0; n--)
 		sleep(5);
 	if (id == 0) {
-		if (!isatty(0)) {
-			close(0);
+		if (!isatty(STDIN_FILENO)) {
+			close(STDIN_FILENO);
 			open("/dev/tty", 0);
 		}
 
@@ -1136,8 +1112,8 @@ static void execute(struct more_control *ctl, char *filename, char *cmd, ...)
 		signal(SIGQUIT, SIG_IGN);
 		if (ctl->catch_susp)
 			signal(SIGTSTP, SIG_DFL);
-		while (wait(0) > 0) ;
-		signal(SIGINT, end_it);
+		while (wait(0) > 0)
+			/* nothing */ ;
 		signal(SIGQUIT, onquit);
 		if (ctl->catch_susp)
 			signal(SIGTSTP, onsusp);
@@ -1191,12 +1167,14 @@ static void do_shell(struct more_control *ctl, char *filename)
  * should cause more of the file to be printed. */
 static int colon(struct more_control *ctl, char *filename, int cmd, int nlines)
 {
+	char ch;
+
 	if (cmd == 0)
-		ctl->ch = readch(ctl);
+		ch = readch(ctl);
 	else
-		ctl->ch = cmd;
-	ctl->lastcolon = ctl->ch;
-	switch (ctl->ch) {
+		ch = cmd;
+	ctl->lastcolon = ch;
+	switch (ch) {
 	case 'f':
 		kill_line(ctl);
 		if (!ctl->no_intty)
@@ -1443,9 +1421,8 @@ static int command(struct more_control *ctl, char *filename, register FILE *f)
 				skiplns(ctl, initline, f);
 				if (!ctl->noscroll) {
 					ret(ctl->dlines + 1);
-				} else {
-					ret(ctl->dlines);
 				}
+				ret(ctl->dlines);
 			}
 		case ' ':
 		case 'z':
@@ -1690,10 +1667,6 @@ static void screen(struct more_control *ctl, register FILE *f, register int num_
 				erasep(ctl, nchars);	/* erasep () sets promptlen to 0 */
 			else
 				ctl->promptlen = 0;
-			/* is this needed?
-			 * if (clreol)
-			 *	cleareol();     * must clear again in case we wrapped *
-			 */
 			if (nchars < ctl->Mcol || !ctl->fold_opt)
 				prbuf(ctl, "\n", 1);	/* will turn off UL if necessary */
 			if (nchars == STOP)
@@ -1745,7 +1718,7 @@ static void chgwinsz(int dummy __attribute__((__unused__)))
 			global_ctl->nscroll = global_ctl->Lpp / 2 - 1;
 			if (global_ctl->nscroll <= 0)
 				global_ctl->nscroll = 1;
-			global_ctl->dlines = global_ctl->Lpp - 1;	/* was: Lpp - (noscroll ? 1 : 2) */
+			global_ctl->dlines = global_ctl->Lpp - 1;
 		}
 		if (win.ws_col != 0)
 			global_ctl->Mcol = win.ws_col;
@@ -1763,16 +1736,12 @@ static void copy_file(register FILE *f)
 		fwrite(&buf, sizeof(char), sz, stdout);
 }
 
-/*----------------------------- Terminal I/O -------------------------------*/
 static void initterm(struct more_control *ctl)
 {
 	int ret, tmp;
-	char *padstr;
 	char *term;
+#ifdef TIOCGWINSZ
 	struct winsize win;
-
-#ifdef do_SIGTTOU
- retry:
 #endif
 
 #ifndef NON_INTERACTIVE_MORE
@@ -1781,19 +1750,6 @@ static void initterm(struct more_control *ctl)
 	if (!ctl->no_tty) {
 		ctl->docrterase = (ctl->otty.c_cc[VERASE] != 255);
 		ctl->docrtkill = (ctl->otty.c_cc[VKILL] != 255);
-#ifdef do_SIGTTOU
-		{
-			int tgrp;
-			/* Wait until we're in the foreground before we
-			 * save the terminal modes. */
-			if ((tgrp = tcgetpgrp(fileno(stdout))) < 0)
-				err(EXIT_FAILURE, "tcgetpgrp");
-			if (tgrp != getpgrp(0)) {
-				kill(0, SIGTTOU);
-				goto retry;
-			}
-		}
-#endif	/* do_SIGTTOU */
 		if ((term = getenv("TERM")) == NULL) {
 			ctl->dumb = 1;
 			ctl->ul_opt = 0;
@@ -1817,7 +1773,7 @@ static void initterm(struct more_control *ctl)
 			}
 #endif
 			if ((ctl->Lpp <= 0) || my_tgetflag(TERM_HARD_COPY)) {
-				ctl->hard = 1;	/* Hard copy terminal */
+				ctl->hard = 1;
 				ctl->Lpp = LINES_PER_PAGE;
 			}
 
@@ -1865,8 +1821,6 @@ static void initterm(struct more_control *ctl)
 				ctl->ulglitch = 0;
 			}
 
-			if ((padstr = my_tgetstr(TERM_PAD_CHAR)) != NULL)
-				ctl->PC = *padstr;
 			ctl->Home = my_tgetstr(TERM_HOME);
 			if (ctl->Home == NULL || *ctl->Home == '\0') {
 				if ((ctl->cursorm =
@@ -1890,7 +1844,6 @@ static void initterm(struct more_control *ctl)
 	ctl->no_intty = tcgetattr(fileno(stdin), &ctl->otty);
 	tcgetattr(fileno(stderr), &ctl->otty);
 	ctl->savetty0 = ctl->otty;
-	ctl->slow_tty = cfgetispeed(&ctl->otty) < B1200 ? 1 : 0;
 	ctl->hardtabs = (ctl->otty.c_oflag & TABDLY) != XTABS;
 	if (!ctl->no_tty) {
 		ctl->otty.c_lflag &= ~(ICANON | ECHO);
@@ -1979,7 +1932,7 @@ int main(int argc, char **argv)
 			ctl.noscroll = 1;
 	}
 	if (ctl.dlines == 0)
-		ctl.dlines = ctl.Lpp - 1;	/* was: Lpp - (noscroll ? 1 : 2) */
+		ctl.dlines = ctl.Lpp - 1;
 	left = ctl.dlines;
 	if (ctl.nfiles > 1)
 		prnames++;
-- 
2.3.0

