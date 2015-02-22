Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:43169 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbbBVOnq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:43:46 -0500
Received: by mail-wi0-f174.google.com with SMTP id em10so11839329wid.1
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:43:44 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 01/31] more: remove function declarations
Date: Sun, 22 Feb 2015 14:42:57 +0000
Message-Id: <1424616207-747-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In preparation to remove of global variables.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 2621 ++++++++++++++++++++++++++---------------------------
 1 file changed, 1292 insertions(+), 1329 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 4602cba..dc7aa3f 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -89,38 +89,6 @@
 
 #define stty(fd,argp)  tcsetattr(fd,TCSANOW,argp)
 
-/* some function declarations */
-void initterm(void);
-void kill_line(void);
-void doclear(void);
-void cleareol(void);
-void clreos(void);
-void home(void);
-void more_error(char *mess);
-void do_shell(char *filename);
-int colon(char *filename, int cmd, int nlines);
-int expand(char **outbuf, char *inbuf);
-void argscan(char *s);
-void rdline(register FILE *f);
-void copy_file(register FILE *f);
-void search(char buf[], FILE *file, register int n);
-void skipf(register int nskip);
-void skiplns(register int n, register FILE *f);
-void screen(register FILE *f, register int num_lines);
-int command(char *filename, register FILE *f);
-void erasep(register int col);
-void show(register char ch);
-void set_tty(void);
-void reset_tty(void);
-void ttyin(char buf[], register int nmax, char pchar);
-int number(char *cmd);
-int readch(void);
-int get_line(register FILE *f, int *length);
-void prbuf(register char *s, register int n);
-void execute(char *filename, char *cmd, ...);
-FILE *checkf(char *, int *);
-void prepare_line_buffer(void);
-
 #define TBUFSIZ		1024
 #define LINSIZ		256	/* minimal Line buffer size */
 #define ctrl(letter)	(letter & 077)
@@ -140,7 +108,6 @@ struct termios otty, savetty0;
 long file_pos, file_size;
 int fnum, no_intty, no_tty, slow_tty;
 int dum_opt, dlines;
-void onquit(int), onsusp(int), chgwinsz(int), end_it(int);
 int nscroll = SCROLL_LEN;	/* Number of lines scrolled by 'd' */
 int fold_opt = 1;		/* Fold long lines */
 int stop_opt = 1;		/* Stop after form feeds */
@@ -183,13 +150,26 @@ int Wrap = 1;			/* set if automargins */
 int soglitch;			/* terminal has standout mode glitch */
 int ulglitch;			/* terminal has underline mode glitch */
 int pstate = 0;			/* current UL state */
-static int magic(FILE *, char *);
 char *previousre;		/* previous search() buf[] item */
 struct {
 	long chrctr, line;
 } context, screen_start;
 extern char PC;			/* pad character */
 
+static char ch;
+static int lastcmd, lastarg, lastp;
+static int lastcolon;
+char shell_line[SHELL_LINE];
+#define ringbell()	putcerr('\007')
+static char *BS = "\b";
+static char *BSB = "\b \b";
+static char *CARAT = "^";
+#define ERASEONECOLUMN \
+    if (docrterase) \
+	putserr(BSB); \
+    else \
+	putserr(BS);
+
 #ifdef HAVE_NCURSES_H
 # include <ncurses.h>
 #elif defined(HAVE_NCURSES_NCURSES_H)
@@ -337,193 +317,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-int main(int argc, char **argv)
-{
-	FILE *f;
-	char *s;
-	int ch;
-	int left;
-	int prnames = 0;
-	int initopt = 0;
-	int srchopt = 0;
-	int clearit = 0;
-	int initline = 0;
-	char *initbuf = NULL;
-
-	setlocale(LC_ALL, "");
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
-	atexit(close_stdout);
-
-	nfiles = argc;
-	fnames = argv;
-	setlocale(LC_ALL, "");
-	initterm();
-
-	/* Auto set no scroll on when binary is called page */
-	if (!(strcmp(program_invocation_short_name, "page")))
-		noscroll++;
-
-	prepare_line_buffer();
-
-	nscroll = Lpp / 2 - 1;
-	if (nscroll <= 0)
-		nscroll = 1;
-
-	if ((s = getenv("MORE")) != NULL)
-		argscan(s);
-
-	while (--nfiles > 0) {
-		if ((ch = (*++fnames)[0]) == '-') {
-			argscan(*fnames + 1);
-		} else if (ch == '+') {
-			s = *fnames;
-			if (*++s == '/') {
-				srchopt++;
-				initbuf = xstrdup(s + 1);
-			} else {
-				initopt++;
-				for (initline = 0; *s != '\0'; s++)
-					if (isdigit(*s))
-						initline =
-						    initline * 10 + *s - '0';
-				--initline;
-			}
-		} else
-			break;
-	}
-	/* allow clreol only if Home and eraseln and EodClr strings are
-	 * defined, and in that case, make sure we are in noscroll mode */
-	if (clreol) {
-		if ((Home == NULL) || (*Home == '\0') ||
-		    (eraseln == NULL) || (*eraseln == '\0') ||
-		    (EodClr == NULL) || (*EodClr == '\0'))
-			clreol = 0;
-		else
-			noscroll = 1;
-	}
-	if (dlines == 0)
-		dlines = Lpp - 1;	/* was: Lpp - (noscroll ? 1 : 2) */
-	left = dlines;
-	if (nfiles > 1)
-		prnames++;
-	if (!no_intty && nfiles == 0)
-		usage(stderr);
-	else
-		f = stdin;
-	if (!no_tty) {
-		signal(SIGQUIT, onquit);
-		signal(SIGINT, end_it);
-#ifdef SIGWINCH
-		signal(SIGWINCH, chgwinsz);
-#endif
-		if (signal(SIGTSTP, SIG_IGN) == SIG_DFL) {
-			signal(SIGTSTP, onsusp);
-			catch_susp++;
-		}
-		stty(fileno(stderr), &otty);
-	}
-	if (no_intty) {
-		if (no_tty)
-			copy_file(stdin);
-		else {
-			if ((ch = Getc(f)) == '\f')
-				doclear();
-			else {
-				Ungetc(ch, f);
-				if (noscroll && (ch != EOF)) {
-					if (clreol)
-						home();
-					else
-						doclear();
-				}
-			}
-			if (srchopt) {
-				free(previousre);
-				previousre = xstrdup(initbuf);
-				search(initbuf, stdin, 1);
-				if (noscroll)
-					left--;
-			} else if (initopt)
-				skiplns(initline, stdin);
-			screen(stdin, left);
-		}
-		no_intty = 0;
-		prnames++;
-		firstf = 0;
-	}
-
-	while (fnum < nfiles) {
-		if ((f = checkf(fnames[fnum], &clearit)) != NULL) {
-			context.line = context.chrctr = 0;
-			Currline = 0;
-			if (firstf)
-				sigsetjmp(restore, 1);
-			if (firstf) {
-				firstf = 0;
-				if (srchopt) {
-					free(previousre);
-					previousre = xstrdup(initbuf);
-					search(initbuf, f, 1);
-					if (noscroll)
-						left--;
-				} else if (initopt)
-					skiplns(initline, f);
-			} else if (fnum < nfiles && !no_tty) {
-				sigsetjmp(restore, 1);
-				left = command(fnames[fnum], f);
-			}
-			if (left != 0) {
-				if ((noscroll || clearit)
-				    && (file_size != LONG_MAX)) {
-					if (clreol)
-						home();
-					else
-						doclear();
-				}
-				if (prnames) {
-					if (bad_so)
-						erasep(0);
-					if (clreol)
-						cleareol();
-					putsout("::::::::::::::");
-					if (promptlen > 14)
-						erasep(14);
-					putchar('\n');
-					if (clreol)
-						cleareol();
-					puts(fnames[fnum]);
-					if (clreol)
-						cleareol();
-					puts("::::::::::::::");
-					if (left > Lpp - 4)
-						left = Lpp - 4;
-				}
-				if (no_tty)
-					copy_file(f);
-				else {
-					within++;
-					screen(f, left);
-					within = 0;
-				}
-			}
-			sigsetjmp(restore, 1);
-			fflush(stdout);
-			fclose(f);
-			screen_start.line = screen_start.chrctr = 0L;
-			context.line = context.chrctr = 0L;
-		}
-		fnum++;
-		firstf = 0;
-	}
-	free(previousre);
-	free(initbuf);
-	free(Line);
-	reset_tty();
-	exit(EXIT_SUCCESS);
-}
-
-void argscan(char *s)
+static void argscan(char *s)
 {
 	int seen_num = 0;
 
@@ -583,9 +377,45 @@ void argscan(char *s)
 	}
 }
 
+/* force clear to end of line */
+static void cleareol(void)
+{
+	my_putstring(eraseln);
+}
+
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
-FILE *checkf(register char *fs, int *clearfirst)
+static FILE *checkf(register char *fs, int *clearfirst)
 {
 	struct stat stbuf;
 	register FILE *f;
@@ -620,222 +450,13 @@ FILE *checkf(register char *fs, int *clearfirst)
 	return (f);
 }
 
-/* magic --
- *	check for file magic numbers.  This code would best be shared
- *	with the file(1) program or, perhaps, more should not try to be
- *	so smart. */
-static int magic(FILE *f, char *fs)
+static void prepare_line_buffer(void)
 {
-	signed char twobytes[2];
+	char *nline;
+	size_t nsz = Mcol * 4;
 
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
-/* Print out the contents of the file f, one screenful at a time. */
-#define STOP -10
-void screen(register FILE *f, register int num_lines)
-{
-	register int c;
-	register int nchars;
-	int length;			/* length of current line */
-	static int prev_len = 1;	/* length of previous line */
-
-	for (;;) {
-		while (num_lines > 0 && !Pause) {
-			if ((nchars = get_line(f, &length)) == EOF) {
-				if (clreol)
-					clreos();
-				return;
-			}
-			if (ssp_opt && length == 0 && prev_len == 0)
-				continue;
-			prev_len = length;
-			if (bad_so
-			    || ((Senter && *Senter == ' ') && (promptlen > 0)))
-				erasep(0);
-			/* must clear before drawing line since tabs on
-			 * some terminals do not erase what they tab
-			 * over. */
-			if (clreol)
-				cleareol();
-			prbuf(Line, length);
-			if (nchars < promptlen)
-				erasep(nchars);	/* erasep () sets promptlen to 0 */
-			else
-				promptlen = 0;
-			/* is this needed?
-			 * if (clreol)
-			 *	cleareol();     * must clear again in case we wrapped *
-			 */
-			if (nchars < Mcol || !fold_opt)
-				prbuf("\n", 1);	/* will turn off UL if necessary */
-			if (nchars == STOP)
-				break;
-			num_lines--;
-		}
-		if (pstate) {
-			my_putstring(ULexit);
-			pstate = 0;
-		}
-		fflush(stdout);
-		if ((c = Getc(f)) == EOF) {
-			if (clreol)
-				clreos();
-			return;
-		}
-
-		if (Pause && clreol)
-			clreos();
-		Ungetc(c, f);
-		sigsetjmp(restore, 1);
-		Pause = 0;
-		startup = 0;
-		if ((num_lines = command(NULL, f)) == 0)
-			return;
-		if (hard && promptlen > 0)
-			erasep(0);
-		if (noscroll && num_lines >= dlines) {
-			if (clreol)
-				home();
-			else
-				doclear();
-		}
-		screen_start.line = Currline;
-		screen_start.chrctr = Ftell(f);
-	}
-}
-
-/* Come here if a quit signal is received */
-void onquit(int dummy __attribute__((__unused__)))
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
-/* Come here if a signal for a window size change is received */
-#ifdef SIGWINCH
-void chgwinsz(int dummy __attribute__((__unused__)))
-{
-	struct winsize win;
-
-	signal(SIGWINCH, SIG_IGN);
-	if (ioctl(fileno(stdout), TIOCGWINSZ, &win) != -1) {
-		if (win.ws_row != 0) {
-			Lpp = win.ws_row;
-			nscroll = Lpp / 2 - 1;
-			if (nscroll <= 0)
-				nscroll = 1;
-			dlines = Lpp - 1;	/* was: Lpp - (noscroll ? 1 : 2) */
-		}
-		if (win.ws_col != 0)
-			Mcol = win.ws_col;
-	}
-	signal(SIGWINCH, chgwinsz);
-}
-#endif				/* SIGWINCH */
-
-/* Clean up terminal state and exit. Also come here if interrupt signal received */
-void __attribute__((__noreturn__)) end_it(int dummy __attribute__((__unused__)))
-{
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
-void copy_file(register FILE *f)
-{
-	char buf[BUFSIZ];
-	size_t sz;
-
-	while ((sz = fread(&buf, sizeof(char), sizeof(buf), f)) > 0)
-		fwrite(&buf, sizeof(char), sz, stdout);
-}
-
-#define ringbell()	putcerr('\007')
-
-static void prompt(char *filename)
-{
-	if (clreol)
-		cleareol();
-	else if (promptlen > 0)
-		kill_line();
-	if (!hard) {
-		promptlen = 0;
-		if (Senter && Sexit) {
-			my_putstring(Senter);
-			promptlen += (2 * soglitch);
-		}
-		if (clreol)
-			cleareol();
-		promptlen += printf(_("--More--"));
-		if (filename != NULL) {
-			promptlen += printf(_("(Next file: %s)"), filename);
-		} else if (!no_intty) {
-			promptlen +=
-			    printf("(%d%%)",
-				   (int)((file_pos * 100) / file_size));
-		}
-		if (dum_opt) {
-			promptlen +=
-			    printf(_("[Press space to continue, 'q' to quit.]"));
-		}
-		if (Senter && Sexit)
-			my_putstring(Sexit);
-		if (clreol)
-			clreos();
-		fflush(stdout);
-	} else
-		ringbell();
-	inwait++;
-}
-
-void prepare_line_buffer(void)
-{
-	char *nline;
-	size_t nsz = Mcol * 4;
-
-	if (LineLen >= nsz)
-		return;
+	if (LineLen >= nsz)
+		return;
 
 	if (nsz < LINSIZ)
 		nsz = LINSIZ;
@@ -847,7 +468,7 @@ void prepare_line_buffer(void)
 }
 
 /* Get a logical line */
-int get_line(register FILE *f, int *length)
+static int get_line(register FILE *f, int *length)
 {
 	int c;
 	char *p;
@@ -1058,7 +679,7 @@ int get_line(register FILE *f, int *length)
 }
 
 /* Erase the rest of the prompt, assuming we are starting at column col. */
-void erasep(register int col)
+static void erasep(register int col)
 {
 
 	if (promptlen == 0)
@@ -1076,26 +697,11 @@ void erasep(register int col)
 	promptlen = 0;
 }
 
-/* Erase the current line entirely */
-void kill_line(void)
-{
-	erasep(0);
-	if (!eraseln || dumb)
-		putchar('\r');
-}
-
-/* force clear to end of line */
-void cleareol(void)
-{
-	my_putstring(eraseln);
-}
-
-void clreos(void)
+static void clreos(void)
 {
 	my_putstring(EodClr);
 }
 
-
 static UL_ASAN_BLACKLIST size_t xmbrtowc(wchar_t *wc, const char *s, size_t n,
 				  mbstate_t *mbstate)
 {
@@ -1106,7 +712,7 @@ static UL_ASAN_BLACKLIST size_t xmbrtowc(wchar_t *wc, const char *s, size_t n,
 }
 
 /* Print a buffer of n characters */
-void prbuf(register char *s, register int n)
+static void prbuf(register char *s, register int n)
 {
 	register char c;	/* next output character */
 	register int state;	/* next output char's UL state */
@@ -1160,515 +766,414 @@ void prbuf(register char *s, register int n)
 		}
 }
 
-/*  Clear the screen */
-void doclear(void)
+/* Erase the current line entirely */
+static void kill_line(void)
 {
-	if (Clear && !hard) {
-		my_putstring(Clear);
-		/* Put out carriage return so that system doesn't get
-		 * confused by escape sequences when expanding tabs */
+	erasep(0);
+	if (!eraseln || dumb)
 		putchar('\r');
-		promptlen = 0;
-	}
 }
 
-/* Go to home position */
-void home(void)
+static void prompt(char *filename)
 {
-	my_putstring(Home);
+	if (clreol)
+		cleareol();
+	else if (promptlen > 0)
+		kill_line();
+	if (!hard) {
+		promptlen = 0;
+		if (Senter && Sexit) {
+			my_putstring(Senter);
+			promptlen += (2 * soglitch);
+		}
+		if (clreol)
+			cleareol();
+		promptlen += printf(_("--More--"));
+		if (filename != NULL) {
+			promptlen += printf(_("(Next file: %s)"), filename);
+		} else if (!no_intty) {
+			promptlen +=
+			    printf("(%d%%)",
+				   (int)((file_pos * 100) / file_size));
+		}
+		if (dum_opt) {
+			promptlen +=
+			    printf(_("[Press space to continue, 'q' to quit.]"));
+		}
+		if (Senter && Sexit)
+			my_putstring(Sexit);
+		if (clreol)
+			clreos();
+		fflush(stdout);
+	} else
+		ringbell();
+	inwait++;
 }
 
-static int lastcmd, lastarg, lastp;
-static int lastcolon;
-char shell_line[SHELL_LINE];
+static int ourputch(int c)
+{
+	return putc(c, stdout);
+}
 
-/* Read a command and do it.  A command consists of an optional integer
- * argument followed by the command character.  Return the number of
- * lines to display in the next screenful.  If there is nothing more to
- * display in the current file, zero is returned. */
-int command(char *filename, register FILE *f)
+static void reset_tty(void)
 {
-	register int nlines;
-	register int retval = 0;
-	register int c;
-	char colonch;
-	int done;
-	char comchar, cmdbuf[INIT_BUF];
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
 
-#define ret(val) retval=val;done++;break
+/* Clean up terminal state and exit. Also come here if interrupt signal received */
+static void __attribute__((__noreturn__)) end_it(int dummy __attribute__((__unused__)))
+{
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
 
-	done = 0;
-	if (!errors)
-		prompt(filename);
-	else
-		errors = 0;
+static int readch(void)
+{
+	unsigned char c;
+
+	errno = 0;
+	if (read(fileno(stderr), &c, 1) <= 0) {
+		if (errno != EINTR)
+			end_it(0);
+		else
+			c = otty.c_cc[VKILL];
+	}
+	return (c);
+}
+
+/* Read a decimal number from the terminal.  Set cmd to the non-digit
+ * which terminates the number. */
+static int number(char *cmd)
+{
+	register int i;
+
+	i = 0;
+	ch = otty.c_cc[VKILL];
 	for (;;) {
-		nlines = number(&comchar);
-		lastp = colonch = 0;
-		if (comchar == '.') {	/* Repeat last command */
-			lastp++;
-			comchar = lastcmd;
-			nlines = lastarg;
-			if (lastcmd == ':')
-				colonch = lastcolon;
-		}
-		lastcmd = comchar;
-		lastarg = nlines;
-		if ((cc_t) comchar == otty.c_cc[VERASE]) {
-			kill_line();
-			prompt(filename);
-			continue;
-		}
-		switch (comchar) {
-		case ':':
-			retval = colon(filename, colonch, nlines);
-			if (retval >= 0)
-				done++;
+		ch = readch();
+		if (isdigit(ch))
+			i = i * 10 + ch - '0';
+		else if ((cc_t) ch == otty.c_cc[VKILL])
+			i = 0;
+		else {
+			*cmd = ch;
 			break;
-		case 'b':
-		case ctrl('B'):
-			{
-				register int initline;
+		}
+	}
+	return (i);
+}
 
-				if (no_intty) {
-					ringbell();
-					return (-1);
-				}
+/* Skip nskip files in the file list (from the command line).  Nskip may
+ * be negative. */
+static void skipf(register int nskip)
+{
+	if (nskip == 0)
+		return;
+	if (nskip > 0) {
+		if (fnum + nskip > nfiles - 1)
+			nskip = nfiles - fnum - 1;
+	} else if (within)
+		++fnum;
+	fnum += nskip;
+	if (fnum < 0)
+		fnum = 0;
+	puts(_("\n...Skipping "));
+	if (clreol)
+		cleareol();
+	if (nskip > 0)
+		putsout(_("...Skipping to file "));
+	else
+		putsout(_("...Skipping back to file "));
+	puts(fnames[fnum]);
+	if (clreol)
+		cleareol();
+	putchar('\n');
+	--fnum;
+}
 
-				if (nlines == 0)
-					nlines++;
+static void show(char c)
+{
+	if ((c < ' ' && c != '\n' && c != ESC) || c == RUBOUT) {
+		c += (c == RUBOUT) ? -0100 : 0100;
+		putserr(CARAT);
+		promptlen++;
+	}
+	putcerr(c);
+	promptlen++;
+}
 
-				putchar('\r');
-				erasep(0);
-				putchar('\n');
-				if (clreol)
-					cleareol();
-				printf(P_("...back %d page",
-					"...back %d pages", nlines),
-					nlines);
-				if (clreol)
-					cleareol();
-				putchar('\n');
+static void more_error(char *mess)
+{
+	if (clreol)
+		cleareol();
+	else
+		kill_line();
+	promptlen += strlen(mess);
+	if (Senter && Sexit) {
+		my_putstring(Senter);
+		putsout(mess);
+		my_putstring(Sexit);
+	} else
+		putsout(mess);
+	fflush(stdout);
+	errors++;
+	siglongjmp(restore, 1);
+}
 
-				initline = Currline - dlines * (nlines + 1);
-				if (!noscroll)
-					--initline;
-				if (initline < 0)
-					initline = 0;
-				Fseek(f, 0L);
-				Currline = 0;	/* skiplns() will make Currline correct */
-				skiplns(initline, f);
-				if (!noscroll) {
-					ret(dlines + 1);
-				} else {
-					ret(dlines);
-				}
-			}
-		case ' ':
-		case 'z':
-			if (nlines == 0)
-				nlines = dlines;
-			else if (comchar == 'z')
-				dlines = nlines;
-			ret(nlines);
-		case 'd':
-		case ctrl('D'):
-			if (nlines != 0)
-				nscroll = nlines;
-			ret(nscroll);
-		case 'q':
-		case 'Q':
-			end_it(0);
-		case 's':
-		case 'f':
-		case ctrl('F'):
-			if (nlines == 0)
-				nlines++;
-			if (comchar == 'f')
-				nlines *= dlines;
-			putchar('\r');
-			erasep(0);
-			putchar('\n');
-			if (clreol)
-				cleareol();
-			printf(P_("...skipping %d line",
-				"...skipping %d lines", nlines),
-				nlines);
+static void ttyin(char buf[], register int nmax, char pchar)
+{
+	char *sp;
+	int c;
+	int slash = 0;
+	int maxlen;
 
-			if (clreol)
-				cleareol();
-			putchar('\n');
+	sp = buf;
+	maxlen = 0;
+	while (sp - buf < nmax) {
+		if (promptlen > maxlen)
+			maxlen = promptlen;
+		c = readch();
+		if (c == '\\') {
+			slash++;
+		} else if (((cc_t) c == otty.c_cc[VERASE]) && !slash) {
+			if (sp > buf) {
+#ifdef HAVE_WIDECHAR
+				if (MB_CUR_MAX > 1) {
+					wchar_t wc;
+					size_t pos = 0, mblength;
+					mbstate_t state, state_bak;
 
-			while (nlines > 0) {
-				while ((c = Getc(f)) != '\n')
-					if (c == EOF) {
-						retval = 0;
-						done++;
-						goto endsw;
-					}
-				Currline++;
-				nlines--;
-			}
-			ret(dlines);
-		case '\n':
-			if (nlines != 0)
-				dlines = nlines;
-			else
-				nlines = 1;
-			ret(nlines);
-		case '\f':
-			if (!no_intty) {
-				doclear();
-				Fseek(f, screen_start.chrctr);
-				Currline = screen_start.line;
-				ret(dlines);
-			} else {
-				ringbell();
-				break;
-			}
-		case '\'':
-			if (!no_intty) {
-				kill_line();
-				putsout(_("\n***Back***\n\n"));
-				Fseek(f, context.chrctr);
-				Currline = context.line;
-				ret(dlines);
-			} else {
-				ringbell();
-				break;
-			}
-		case '=':
-			kill_line();
-			promptlen = printf("%d", Currline);
-			fflush(stdout);
-			break;
-		case 'n':
-			if (!previousre) {
-				more_error(_("No previous regular expression"));
-				break;
-			}
-			lastp++;
-			/* fall through */
-		case '/':
-			if (nlines == 0)
-				nlines++;
-			kill_line();
-			putchar('/');
-			promptlen = 1;
-			fflush(stdout);
-			if (lastp) {
-				putcerr('\r');
-				search(previousre, f, nlines);
-			} else {
-				ttyin(cmdbuf, sizeof(cmdbuf) - 2, '/');
-				putcerr('\r');
-				free(previousre);
-				previousre = xstrdup(cmdbuf);
-				search(cmdbuf, f, nlines);
-			}
-			ret(dlines - 1);
-		case '!':
-			do_shell(filename);
-			break;
-		case '?':
-		case 'h':
-			if (noscroll)
-				doclear();
-			putsout(_("\n"
-				  "Most commands optionally preceded by integer argument k.  "
-				  "Defaults in brackets.\n"
-				  "Star (*) indicates argument becomes new default.\n"));
-			puts("---------------------------------------"
-			     "----------------------------------------");
-			putsout(_
-				("<space>                 Display next k lines of text [current screen size]\n"
-				 "z                       Display next k lines of text [current screen size]*\n"
-				 "<return>                Display next k lines of text [1]*\n"
-				 "d or ctrl-D             Scroll k lines [current scroll size, initially 11]*\n"
-				 "q or Q or <interrupt>   Exit from more\n"
-				 "s                       Skip forward k lines of text [1]\n"
-				 "f                       Skip forward k screenfuls of text [1]\n"
-				 "b or ctrl-B             Skip backwards k screenfuls of text [1]\n"
-				 "'                       Go to place where previous search started\n"
-				 "=                       Display current line number\n"
-				 "/<regular expression>   Search for kth occurrence of regular expression [1]\n"
-				 "n                       Search for kth occurrence of last r.e [1]\n"
-				 "!<cmd> or :!<cmd>       Execute <cmd> in a subshell\n"
-				 "v                       Start up /usr/bin/vi at current line\n"
-				 "ctrl-L                  Redraw screen\n"
-				 ":n                      Go to kth next file [1]\n"
-				 ":p                      Go to kth previous file [1]\n"
-				 ":f                      Display current file name and line number\n"
-				 ".                       Repeat previous command\n"));
-			puts("---------------------------------------"
-			     "----------------------------------------");
-			prompt(filename);
-			break;
-		case 'v':	/* This case should go right before default */
-			if (!no_intty) {
-				/* Earlier: call vi +n file. This also
-				 * works for emacs.  POSIX: call vi -c n
-				 * file (when editor is vi or ex). */
-				char *editor, *p;
-				int n = (Currline - dlines <= 0 ? 1 :
-					 Currline - (dlines + 1) / 2);
-				int split = 0;
+					memset(&state, '\0', sizeof(mbstate_t));
 
-				editor = getenv("VISUAL");
-				if (editor == NULL || *editor == '\0')
-					editor = getenv("EDITOR");
-				if (editor == NULL || *editor == '\0')
-					editor = VI;
+					while (1) {
+						state_bak = state;
+						mblength =
+						    mbrtowc(&wc, buf + pos,
+							    sp - buf, &state);
 
-				p = strrchr(editor, '/');
-				if (p)
-					p++;
-				else
-					p = editor;
-				if (!strcmp(p, "vi") || !strcmp(p, "ex")) {
-					sprintf(cmdbuf, "-c %d", n);
-					split = 1;
-				} else {
-					sprintf(cmdbuf, "+%d", n);
-				}
+						state = (mblength == (size_t)-2
+							 || mblength ==
+							 (size_t)-1) ? state_bak
+						    : state;
+						mblength =
+						    (mblength == (size_t)-2
+						     || mblength == (size_t)-1
+						     || mblength ==
+						     0) ? 1 : mblength;
 
-				kill_line();
-				printf("%s %s %s", editor, cmdbuf,
-				       fnames[fnum]);
-				if (split) {
-					cmdbuf[2] = 0;
-					execute(filename, editor, editor,
-						cmdbuf, cmdbuf + 3,
-						fnames[fnum], (char *)0);
+						if (buf + pos + mblength >= sp)
+							break;
+
+						pos += mblength;
+					}
+
+					if (mblength == 1) {
+					ERASEONECOLUMN} else {
+						int wc_width;
+						wc_width = wcwidth(wc);
+						wc_width =
+						    (wc_width <
+						     1) ? 1 : wc_width;
+						while (wc_width--) {
+						ERASEONECOLUMN}
+					}
+
+					while (mblength--) {
+						--promptlen;
+						--sp;
+					}
 				} else
-					execute(filename, editor, editor,
-						cmdbuf, fnames[fnum],
-						(char *)0);
-				break;
+#endif	/* HAVE_WIDECHAR */
+				{
+					--promptlen;
+					ERASEONECOLUMN-- sp;
+				}
+
+				if ((*sp < ' ' && *sp != '\n') || *sp == RUBOUT) {
+					--promptlen;
+				ERASEONECOLUMN}
+				continue;
+			} else {
+				if (!eraseln)
+					promptlen = maxlen;
+				siglongjmp(restore, 1);
 			}
-			/* fall through */
-		default:
-			if (dum_opt) {
-				kill_line();
-				if (Senter && Sexit) {
-					my_putstring(Senter);
-					promptlen =
-					    printf(_
-						   ("[Press 'h' for instructions.]"))
-					    + 2 * soglitch;
-					my_putstring(Sexit);
-				} else
-					promptlen =
-					    printf(_
-						   ("[Press 'h' for instructions.]"));
-				fflush(stdout);
-			} else
-				ringbell();
-			break;
+		} else if (((cc_t) c == otty.c_cc[VKILL]) && !slash) {
+			if (hard) {
+				show(c);
+				putchar('\n');
+				putchar(pchar);
+			} else {
+				putchar('\r');
+				putchar(pchar);
+				if (eraseln)
+					erasep(1);
+				else if (docrtkill)
+					while (promptlen-- > 1)
+						putserr(BSB);
+				promptlen = 1;
+			}
+			sp = buf;
+			fflush(stdout);
+			continue;
 		}
-		if (done)
+		if (slash && ((cc_t) c == otty.c_cc[VKILL]
+			      || (cc_t) c == otty.c_cc[VERASE])) {
+			ERASEONECOLUMN-- sp;
+		}
+		if (c != '\\')
+			slash = 0;
+		*sp++ = c;
+		if ((c < ' ' && c != '\n' && c != ESC) || c == RUBOUT) {
+			c += (c == RUBOUT) ? -0100 : 0100;
+			putserr(CARAT);
+			promptlen++;
+		}
+		if (c != '\n' && c != ESC) {
+			putcerr(c);
+			promptlen++;
+		} else
 			break;
 	}
-	putchar('\r');
- endsw:
-	inwait = 0;
-	notell++;
-	return (retval);
+	*--sp = '\0';
+	if (!eraseln)
+		promptlen = maxlen;
+	if (sp - buf >= nmax - 1)
+		more_error(_("Line too long"));
 }
 
-static char ch;
-/* Execute a colon-prefixed command.  Returns <0 if not a command that
- * should cause more of the file to be printed. */
-int colon(char *filename, int cmd, int nlines)
+/* return: 0 - unchanged, 1 - changed, -1 - overflow (unchanged) */
+static int expand(char **outbuf, char *inbuf)
 {
-	if (cmd == 0)
-		ch = readch();
-	else
-		ch = cmd;
-	lastcolon = ch;
-	switch (ch) {
-	case 'f':
-		kill_line();
-		if (!no_intty)
-			promptlen =
-			    printf(_("\"%s\" line %d"), fnames[fnum], Currline);
-		else
-			promptlen = printf(_("[Not a file] line %d"), Currline);
-		fflush(stdout);
-		return (-1);
-	case 'n':
-		if (nlines == 0) {
-			if (fnum >= nfiles - 1)
-				end_it(0);
-			nlines++;
-		}
-		putchar('\r');
-		erasep(0);
-		skipf(nlines);
-		return (0);
-	case 'p':
-		if (no_intty) {
-			ringbell();
-			return (-1);
+	char *inpstr;
+	char *outstr;
+	char c;
+	char *temp;
+	int changed = 0;
+	int tempsz, xtra, offset;
+
+	xtra = strlen(fnames[fnum]) + strlen(shell_line) + 1;
+	tempsz = 200 + xtra;
+	temp = xmalloc(tempsz);
+	inpstr = inbuf;
+	outstr = temp;
+	while ((c = *inpstr++) != '\0') {
+		offset = outstr - temp;
+		if (tempsz - offset - 1 < xtra) {
+			tempsz += 200 + xtra;
+			temp = xrealloc(temp, tempsz);
+			outstr = temp + offset;
+		}
+		switch (c) {
+		case '%':
+			if (!no_intty) {
+				strcpy(outstr, fnames[fnum]);
+				outstr += strlen(fnames[fnum]);
+				changed++;
+			} else
+				*outstr++ = c;
+			break;
+		case '!':
+			if (!shellp)
+				more_error(_
+					   ("No previous command to substitute for"));
+			strcpy(outstr, shell_line);
+			outstr += strlen(shell_line);
+			changed++;
+			break;
+		case '\\':
+			if (*inpstr == '%' || *inpstr == '!') {
+				*outstr++ = *inpstr++;
+				break;
+			}
+		default:
+			*outstr++ = c;
 		}
-		putchar('\r');
-		erasep(0);
-		if (nlines == 0)
-			nlines++;
-		skipf(-nlines);
-		return (0);
-	case '!':
-		do_shell(filename);
-		return (-1);
-	case 'q':
-	case 'Q':
-		end_it(0);
-	default:
-		ringbell();
-		return (-1);
 	}
+	*outstr++ = '\0';
+	*outbuf = temp;
+	return (changed);
 }
 
-/* Read a decimal number from the terminal.  Set cmd to the non-digit
- * which terminates the number. */
-int number(char *cmd)
+static void set_tty(void)
 {
-	register int i;
+	otty.c_lflag &= ~(ICANON | ECHO);
+	otty.c_cc[VMIN] = 1;	/* read at least 1 char */
+	otty.c_cc[VTIME] = 0;	/* no timeout */
+	stty(fileno(stderr), &otty);
+}
 
-	i = 0;
-	ch = otty.c_cc[VKILL];
-	for (;;) {
-		ch = readch();
-		if (isdigit(ch))
-			i = i * 10 + ch - '0';
-		else if ((cc_t) ch == otty.c_cc[VKILL])
-			i = 0;
-		else {
-			*cmd = ch;
-			break;
-		}
+/* Come here if a quit signal is received */
+static void onquit(int dummy __attribute__((__unused__)))
+{
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
-	return (i);
+	signal(SIGQUIT, onquit);
 }
 
-void do_shell(char *filename)
+/* Come here when we get a suspend signal from the terminal */
+static void onsusp(int dummy __attribute__((__unused__)))
 {
-	char cmdbuf[COMMAND_BUF];
-	int rc;
-	char *expanded;
+	sigset_t signals, oldmask;
 
-	kill_line();
-	putchar('!');
-	fflush(stdout);
-	promptlen = 1;
-	if (lastp)
-		putsout(shell_line);
-	else {
-		ttyin(cmdbuf, sizeof(cmdbuf) - 2, '!');
-		expanded = 0;
-		rc = expand(&expanded, cmdbuf);
-		if (expanded) {
-			if (strlen(expanded) < sizeof(shell_line))
-				strcpy(shell_line, expanded);
-			else
-				rc = -1;
-			free(expanded);
-		}
-		if (rc < 0) {
-			putserr(_("  Overflow\n"));
-			prompt(filename);
-			return;
-		} else if (rc > 0) {
-			kill_line();
-			promptlen = printf("!%s", shell_line);
-		}
-	}
+	/* ignore SIGTTOU so we don't get stopped if csh grabs the tty */
+	signal(SIGTTOU, SIG_IGN);
+	reset_tty();
 	fflush(stdout);
-	putcerr('\n');
-	promptlen = 0;
-	shellp = 1;
-	execute(filename, shell, shell, "-c", shell_line, 0);
-}
+	signal(SIGTTOU, SIG_DFL);
+	/* Send the TSTP signal to suspend our process group */
+	signal(SIGTSTP, SIG_DFL);
 
-/* Search for nth occurrence of regular expression contained in buf in
- * the file */
-void search(char buf[], FILE *file, register int n)
-{
-	long startline = Ftell(file);
-	register long line1 = startline;
-	register long line2 = startline;
-	register long line3;
-	register int lncount;
-	int saveln, rc;
-	regex_t re;
+	/* unblock SIGTSTP or we won't be able to suspend ourself */
+	sigemptyset(&signals);
+	sigaddset(&signals, SIGTSTP);
+	sigprocmask(SIG_UNBLOCK, &signals, &oldmask);
 
-	context.line = saveln = Currline;
-	context.chrctr = startline;
-	lncount = 0;
-	if (!buf)
-		goto notfound;
-	if ((rc = regcomp(&re, buf, REG_NOSUB)) != 0) {
-		char s[REGERR_BUF];
-		regerror(rc, &re, s, sizeof s);
-		more_error(s);
-	}
-	while (!feof(file)) {
-		line3 = line2;
-		line2 = line1;
-		line1 = Ftell(file);
-		rdline(file);
-		lncount++;
-		if (regexec(&re, Line, 0, NULL, 0) == 0) {
-			if (--n == 0) {
-				if (lncount > 3 || (lncount > 1 && no_intty)) {
-					putchar('\n');
-					if (clreol)
-						cleareol();
-					putsout(_("...skipping\n"));
-				}
-				if (!no_intty) {
-					Currline -=
-					    (lncount >= 3 ? 3 : lncount);
-					Fseek(file, line3);
-					if (noscroll) {
-						if (clreol) {
-							home();
-							cleareol();
-						} else
-							doclear();
-					}
-				} else {
-					kill_line();
-					if (noscroll) {
-						if (clreol) {
-							home();
-							cleareol();
-						} else
-							doclear();
-					}
-					puts(Line);
-				}
-				break;
-			}
-		}
-	}
-	regfree(&re);
-	if (feof(file)) {
-		if (!no_intty) {
-			Currline = saveln;
-			Fseek(file, startline);
-		} else {
-			putsout(_("\nPattern not found\n"));
-			end_it(0);
-		}
-		free(previousre);
-		previousre = NULL;
-notfound:
-		more_error(_("Pattern not found"));
-	}
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
 
-void execute(char *filename, char *cmd, ...)
+static void execute(char *filename, char *cmd, ...)
 {
 	int id;
 	int n;
@@ -1730,479 +1235,937 @@ void execute(char *filename, char *cmd, ...)
 	prompt(filename);
 }
 
-/* Skip n lines in the file f */
-void skiplns(register int n, register FILE *f)
+static void do_shell(char *filename)
 {
-	register int c;
-
-	while (n > 0) {
-		while ((c = Getc(f)) != '\n')
-			if (c == EOF)
-				return;
-		n--;
-		Currline++;
-	}
-}
+	char cmdbuf[COMMAND_BUF];
+	int rc;
+	char *expanded;
 
-/* Skip nskip files in the file list (from the command line).  Nskip may
- * be negative. */
-void skipf(register int nskip)
-{
-	if (nskip == 0)
-		return;
-	if (nskip > 0) {
-		if (fnum + nskip > nfiles - 1)
-			nskip = nfiles - fnum - 1;
-	} else if (within)
-		++fnum;
-	fnum += nskip;
-	if (fnum < 0)
-		fnum = 0;
-	puts(_("\n...Skipping "));
-	if (clreol)
-		cleareol();
-	if (nskip > 0)
-		putsout(_("...Skipping to file "));
-	else
-		putsout(_("...Skipping back to file "));
-	puts(fnames[fnum]);
-	if (clreol)
-		cleareol();
-	putchar('\n');
-	--fnum;
+	kill_line();
+	putchar('!');
+	fflush(stdout);
+	promptlen = 1;
+	if (lastp)
+		putsout(shell_line);
+	else {
+		ttyin(cmdbuf, sizeof(cmdbuf) - 2, '!');
+		expanded = 0;
+		rc = expand(&expanded, cmdbuf);
+		if (expanded) {
+			if (strlen(expanded) < sizeof(shell_line))
+				strcpy(shell_line, expanded);
+			else
+				rc = -1;
+			free(expanded);
+		}
+		if (rc < 0) {
+			putserr(_("  Overflow\n"));
+			prompt(filename);
+			return;
+		} else if (rc > 0) {
+			kill_line();
+			promptlen = printf("!%s", shell_line);
+		}
+	}
+	fflush(stdout);
+	putcerr('\n');
+	promptlen = 0;
+	shellp = 1;
+	execute(filename, shell, shell, "-c", shell_line, 0);
 }
 
-/*----------------------------- Terminal I/O -------------------------------*/
-void initterm(void)
+/* Execute a colon-prefixed command.  Returns <0 if not a command that
+ * should cause more of the file to be printed. */
+static int colon(char *filename, int cmd, int nlines)
 {
-	int ret;
-	char *padstr;
-	char *term;
-	struct winsize win;
-
-#ifdef do_SIGTTOU
- retry:
-#endif
-
-#ifndef NON_INTERACTIVE_MORE
-	no_tty = tcgetattr(fileno(stdout), &otty);
-#endif
-	if (!no_tty) {
-		docrterase = (otty.c_cc[VERASE] != 255);
-		docrtkill = (otty.c_cc[VKILL] != 255);
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
-		if ((term = getenv("TERM")) == NULL) {
-			dumb++;
-			ul_opt = 0;
+	if (cmd == 0)
+		ch = readch();
+	else
+		ch = cmd;
+	lastcolon = ch;
+	switch (ch) {
+	case 'f':
+		kill_line();
+		if (!no_intty)
+			promptlen =
+			    printf(_("\"%s\" line %d"), fnames[fnum], Currline);
+		else
+			promptlen = printf(_("[Not a file] line %d"), Currline);
+		fflush(stdout);
+		return (-1);
+	case 'n':
+		if (nlines == 0) {
+			if (fnum >= nfiles - 1)
+				end_it(0);
+			nlines++;
 		}
-		my_setupterm(term, 1, &ret);
-		if (ret <= 0) {
-			dumb++;
-			ul_opt = 0;
-		} else {
-#ifdef TIOCGWINSZ
-			if (ioctl(fileno(stdout), TIOCGWINSZ, &win) < 0) {
-#endif
-				Lpp = my_tgetnum(TERM_LINES);
-				Mcol = my_tgetnum(TERM_COLS);
-#ifdef TIOCGWINSZ
-			} else {
-				if ((Lpp = win.ws_row) == 0)
-					Lpp = my_tgetnum(TERM_LINES);
-				if ((Mcol = win.ws_col) == 0)
-					Mcol = my_tgetnum(TERM_COLS);
-			}
-#endif
-			if ((Lpp <= 0) || my_tgetflag(TERM_HARD_COPY)) {
-				hard++;	/* Hard copy terminal */
-				Lpp = LINES_PER_PAGE;
-			}
-
-			if (my_tgetflag(TERM_EAT_NEW_LINE))
-				/* Eat newline at last column + 1; dec, concept */
-				eatnl++;
-			if (Mcol <= 0)
-				Mcol = NUM_COLUMNS;
-
-			Wrap = my_tgetflag(TERM_AUTO_RIGHT_MARGIN);
-			bad_so = my_tgetflag(TERM_CEOL);
-			eraseln = my_tgetstr(TERM_CLEAR_TO_LINE_END);
-			Clear = my_tgetstr(TERM_CLEAR);
-			Senter = my_tgetstr(TERM_STANDARD_MODE);
-			Sexit = my_tgetstr(TERM_EXIT_STANDARD_MODE);
-			if ((soglitch = my_tgetnum(TERM_STD_MODE_GLITCH)) < 0)
-				soglitch = 0;
-
-			/* Set up for underlining:  some terminals don't
-			 * need it; others have start/stop sequences,
-			 * still others have an underline char sequence
-			 * which is assumed to move the cursor forward
-			 * one character.  If underline sequence isn't
-			 * available, settle for standout sequence. */
-			if (my_tgetflag(TERM_UNDERLINE)
-			    || my_tgetflag(TERM_OVER_STRIKE))
-				ul_opt = 0;
-			if ((chUL = my_tgetstr(TERM_UNDERLINE_CHAR)) == NULL)
-				chUL = "";
-			if (((ULenter =
-			      my_tgetstr(TERM_ENTER_UNDERLINE)) == NULL
-			     || (ULexit =
-				 my_tgetstr(TERM_EXIT_UNDERLINE)) == NULL)
-			    && !*chUL) {
-				if ((ULenter = Senter) == NULL
-				    || (ULexit = Sexit) == NULL) {
-					ULenter = "";
-					ULexit = "";
-				} else
-					ulglitch = soglitch;
-			} else {
-				ulglitch = 0;
-			}
-
-			if ((padstr = my_tgetstr(TERM_PAD_CHAR)) != NULL)
-				PC = *padstr;
-			Home = my_tgetstr(TERM_HOME);
-			if (Home == NULL || *Home == '\0') {
-				if ((cursorm =
-				     my_tgetstr(TERM_CURSOR_ADDRESS)) != NULL) {
-					const char *t =
-					    (const char *)my_tgoto(cursorm, 0,
-								   0);
-					xstrncpy(cursorhome, t,
-						 sizeof(cursorhome));
-					Home = cursorhome;
-				}
-			}
-			EodClr = my_tgetstr(TERM_CLEAR_TO_SCREEN_END);
-			if ((chBS = my_tgetstr(TERM_LINE_DOWN)) == NULL)
-				chBS = "\b";
-
+		putchar('\r');
+		erasep(0);
+		skipf(nlines);
+		return (0);
+	case 'p':
+		if (no_intty) {
+			ringbell();
+			return (-1);
 		}
-		if ((shell = getenv("SHELL")) == NULL)
-			shell = "/bin/sh";
-	}
-	no_intty = tcgetattr(fileno(stdin), &otty);
-	tcgetattr(fileno(stderr), &otty);
-	savetty0 = otty;
-	slow_tty = cfgetispeed(&otty) < B1200;
-	hardtabs = (otty.c_oflag & TABDLY) != XTABS;
-	if (!no_tty) {
-		otty.c_lflag &= ~(ICANON | ECHO);
-		otty.c_cc[VMIN] = 1;
-		otty.c_cc[VTIME] = 0;
+		putchar('\r');
+		erasep(0);
+		if (nlines == 0)
+			nlines++;
+		skipf(-nlines);
+		return (0);
+	case '!':
+		do_shell(filename);
+		return (-1);
+	case 'q':
+	case 'Q':
+		end_it(0);
+	default:
+		ringbell();
+		return (-1);
 	}
 }
 
-int readch(void)
+/* Skip n lines in the file f */
+static void skiplns(register int n, register FILE *f)
 {
-	unsigned char c;
+	register int c;
 
-	errno = 0;
-	if (read(fileno(stderr), &c, 1) <= 0) {
-		if (errno != EINTR)
-			end_it(0);
-		else
-			c = otty.c_cc[VKILL];
+	while (n > 0) {
+		while ((c = Getc(f)) != '\n')
+			if (c == EOF)
+				return;
+		n--;
+		Currline++;
 	}
-	return (c);
 }
 
-static char *BS = "\b";
-static char *BSB = "\b \b";
-static char *CARAT = "^";
-#define ERASEONECOLUMN \
-    if (docrterase) \
-	putserr(BSB); \
-    else \
-	putserr(BS);
+/*  Clear the screen */
+static void doclear(void)
+{
+	if (Clear && !hard) {
+		my_putstring(Clear);
+		/* Put out carriage return so that system doesn't get
+		 * confused by escape sequences when expanding tabs */
+		putchar('\r');
+		promptlen = 0;
+	}
+}
 
-void ttyin(char buf[], register int nmax, char pchar)
+static void rdline(register FILE *f)
 {
-	char *sp;
-	int c;
-	int slash = 0;
-	int maxlen;
-
-	sp = buf;
-	maxlen = 0;
-	while (sp - buf < nmax) {
-		if (promptlen > maxlen)
-			maxlen = promptlen;
-		c = readch();
-		if (c == '\\') {
-			slash++;
-		} else if (((cc_t) c == otty.c_cc[VERASE]) && !slash) {
-			if (sp > buf) {
-#ifdef HAVE_WIDECHAR
-				if (MB_CUR_MAX > 1) {
-					wchar_t wc;
-					size_t pos = 0, mblength;
-					mbstate_t state, state_bak;
+	register int c;
+	register char *p;
 
-					memset(&state, '\0', sizeof(mbstate_t));
+	prepare_line_buffer();
 
-					while (1) {
-						state_bak = state;
-						mblength =
-						    mbrtowc(&wc, buf + pos,
-							    sp - buf, &state);
+	p = Line;
+	while ((c = Getc(f)) != '\n' && c != EOF
+	       && (size_t)(p - Line) < LineLen - 1)
+		*p++ = c;
+	if (c == '\n')
+		Currline++;
+	*p = '\0';
+}
 
-						state = (mblength == (size_t)-2
-							 || mblength ==
-							 (size_t)-1) ? state_bak
-						    : state;
-						mblength =
-						    (mblength == (size_t)-2
-						     || mblength == (size_t)-1
-						     || mblength ==
-						     0) ? 1 : mblength;
+/* Go to home position */
+static void home(void)
+{
+	my_putstring(Home);
+}
 
-						if (buf + pos + mblength >= sp)
-							break;
+/* Search for nth occurrence of regular expression contained in buf in
+ * the file */
+static void search(char buf[], FILE *file, register int n)
+{
+	long startline = Ftell(file);
+	register long line1 = startline;
+	register long line2 = startline;
+	register long line3;
+	register int lncount;
+	int saveln, rc;
+	regex_t re;
 
-						pos += mblength;
+	context.line = saveln = Currline;
+	context.chrctr = startline;
+	lncount = 0;
+	if (!buf)
+		goto notfound;
+	if ((rc = regcomp(&re, buf, REG_NOSUB)) != 0) {
+		char s[REGERR_BUF];
+		regerror(rc, &re, s, sizeof s);
+		more_error(s);
+	}
+	while (!feof(file)) {
+		line3 = line2;
+		line2 = line1;
+		line1 = Ftell(file);
+		rdline(file);
+		lncount++;
+		if (regexec(&re, Line, 0, NULL, 0) == 0) {
+			if (--n == 0) {
+				if (lncount > 3 || (lncount > 1 && no_intty)) {
+					putchar('\n');
+					if (clreol)
+						cleareol();
+					putsout(_("...skipping\n"));
+				}
+				if (!no_intty) {
+					Currline -=
+					    (lncount >= 3 ? 3 : lncount);
+					Fseek(file, line3);
+					if (noscroll) {
+						if (clreol) {
+							home();
+							cleareol();
+						} else
+							doclear();
 					}
-
-					if (mblength == 1) {
-					ERASEONECOLUMN} else {
-						int wc_width;
-						wc_width = wcwidth(wc);
-						wc_width =
-						    (wc_width <
-						     1) ? 1 : wc_width;
-						while (wc_width--) {
-						ERASEONECOLUMN}
+				} else {
+					kill_line();
+					if (noscroll) {
+						if (clreol) {
+							home();
+							cleareol();
+						} else
+							doclear();
 					}
+					puts(Line);
+				}
+				break;
+			}
+		}
+	}
+	regfree(&re);
+	if (feof(file)) {
+		if (!no_intty) {
+			Currline = saveln;
+			Fseek(file, startline);
+		} else {
+			putsout(_("\nPattern not found\n"));
+			end_it(0);
+		}
+		free(previousre);
+		previousre = NULL;
+notfound:
+		more_error(_("Pattern not found"));
+	}
+}
 
-					while (mblength--) {
-						--promptlen;
-						--sp;
-					}
-				} else
-#endif	/* HAVE_WIDECHAR */
-				{
-					--promptlen;
-					ERASEONECOLUMN-- sp;
+/* Read a command and do it.  A command consists of an optional integer
+ * argument followed by the command character.  Return the number of
+ * lines to display in the next screenful.  If there is nothing more to
+ * display in the current file, zero is returned. */
+static int command(char *filename, register FILE *f)
+{
+	register int nlines;
+	register int retval = 0;
+	register int c;
+	char colonch;
+	int done;
+	char comchar, cmdbuf[INIT_BUF];
+
+#define ret(val) retval=val;done++;break
+
+	done = 0;
+	if (!errors)
+		prompt(filename);
+	else
+		errors = 0;
+	for (;;) {
+		nlines = number(&comchar);
+		lastp = colonch = 0;
+		if (comchar == '.') {	/* Repeat last command */
+			lastp++;
+			comchar = lastcmd;
+			nlines = lastarg;
+			if (lastcmd == ':')
+				colonch = lastcolon;
+		}
+		lastcmd = comchar;
+		lastarg = nlines;
+		if ((cc_t) comchar == otty.c_cc[VERASE]) {
+			kill_line();
+			prompt(filename);
+			continue;
+		}
+		switch (comchar) {
+		case ':':
+			retval = colon(filename, colonch, nlines);
+			if (retval >= 0)
+				done++;
+			break;
+		case 'b':
+		case ctrl('B'):
+			{
+				register int initline;
+
+				if (no_intty) {
+					ringbell();
+					return (-1);
 				}
 
-				if ((*sp < ' ' && *sp != '\n') || *sp == RUBOUT) {
-					--promptlen;
-				ERASEONECOLUMN}
-				continue;
+				if (nlines == 0)
+					nlines++;
+
+				putchar('\r');
+				erasep(0);
+				putchar('\n');
+				if (clreol)
+					cleareol();
+				printf(P_("...back %d page",
+					"...back %d pages", nlines),
+					nlines);
+				if (clreol)
+					cleareol();
+				putchar('\n');
+
+				initline = Currline - dlines * (nlines + 1);
+				if (!noscroll)
+					--initline;
+				if (initline < 0)
+					initline = 0;
+				Fseek(f, 0L);
+				Currline = 0;	/* skiplns() will make Currline correct */
+				skiplns(initline, f);
+				if (!noscroll) {
+					ret(dlines + 1);
+				} else {
+					ret(dlines);
+				}
+			}
+		case ' ':
+		case 'z':
+			if (nlines == 0)
+				nlines = dlines;
+			else if (comchar == 'z')
+				dlines = nlines;
+			ret(nlines);
+		case 'd':
+		case ctrl('D'):
+			if (nlines != 0)
+				nscroll = nlines;
+			ret(nscroll);
+		case 'q':
+		case 'Q':
+			end_it(0);
+		case 's':
+		case 'f':
+		case ctrl('F'):
+			if (nlines == 0)
+				nlines++;
+			if (comchar == 'f')
+				nlines *= dlines;
+			putchar('\r');
+			erasep(0);
+			putchar('\n');
+			if (clreol)
+				cleareol();
+			printf(P_("...skipping %d line",
+				"...skipping %d lines", nlines),
+				nlines);
+
+			if (clreol)
+				cleareol();
+			putchar('\n');
+
+			while (nlines > 0) {
+				while ((c = Getc(f)) != '\n')
+					if (c == EOF) {
+						retval = 0;
+						done++;
+						goto endsw;
+					}
+				Currline++;
+				nlines--;
+			}
+			ret(dlines);
+		case '\n':
+			if (nlines != 0)
+				dlines = nlines;
+			else
+				nlines = 1;
+			ret(nlines);
+		case '\f':
+			if (!no_intty) {
+				doclear();
+				Fseek(f, screen_start.chrctr);
+				Currline = screen_start.line;
+				ret(dlines);
 			} else {
-				if (!eraseln)
-					promptlen = maxlen;
-				siglongjmp(restore, 1);
+				ringbell();
+				break;
 			}
-		} else if (((cc_t) c == otty.c_cc[VKILL]) && !slash) {
-			if (hard) {
-				show(c);
-				putchar('\n');
-				putchar(pchar);
+		case '\'':
+			if (!no_intty) {
+				kill_line();
+				putsout(_("\n***Back***\n\n"));
+				Fseek(f, context.chrctr);
+				Currline = context.line;
+				ret(dlines);
 			} else {
-				putchar('\r');
-				putchar(pchar);
-				if (eraseln)
-					erasep(1);
-				else if (docrtkill)
-					while (promptlen-- > 1)
-						putserr(BSB);
-				promptlen = 1;
+				ringbell();
+				break;
 			}
-			sp = buf;
+		case '=':
+			kill_line();
+			promptlen = printf("%d", Currline);
 			fflush(stdout);
-			continue;
-		}
-		if (slash && ((cc_t) c == otty.c_cc[VKILL]
-			      || (cc_t) c == otty.c_cc[VERASE])) {
-			ERASEONECOLUMN-- sp;
-		}
-		if (c != '\\')
-			slash = 0;
-		*sp++ = c;
-		if ((c < ' ' && c != '\n' && c != ESC) || c == RUBOUT) {
-			c += (c == RUBOUT) ? -0100 : 0100;
-			putserr(CARAT);
-			promptlen++;
-		}
-		if (c != '\n' && c != ESC) {
-			putcerr(c);
-			promptlen++;
-		} else
 			break;
-	}
-	*--sp = '\0';
-	if (!eraseln)
-		promptlen = maxlen;
-	if (sp - buf >= nmax - 1)
-		more_error(_("Line too long"));
+		case 'n':
+			if (!previousre) {
+				more_error(_("No previous regular expression"));
+				break;
+			}
+			lastp++;
+			/* fall through */
+		case '/':
+			if (nlines == 0)
+				nlines++;
+			kill_line();
+			putchar('/');
+			promptlen = 1;
+			fflush(stdout);
+			if (lastp) {
+				putcerr('\r');
+				search(previousre, f, nlines);
+			} else {
+				ttyin(cmdbuf, sizeof(cmdbuf) - 2, '/');
+				putcerr('\r');
+				free(previousre);
+				previousre = xstrdup(cmdbuf);
+				search(cmdbuf, f, nlines);
+			}
+			ret(dlines - 1);
+		case '!':
+			do_shell(filename);
+			break;
+		case '?':
+		case 'h':
+			if (noscroll)
+				doclear();
+			putsout(_("\n"
+				  "Most commands optionally preceded by integer argument k.  "
+				  "Defaults in brackets.\n"
+				  "Star (*) indicates argument becomes new default.\n"));
+			puts("---------------------------------------"
+			     "----------------------------------------");
+			putsout(_
+				("<space>                 Display next k lines of text [current screen size]\n"
+				 "z                       Display next k lines of text [current screen size]*\n"
+				 "<return>                Display next k lines of text [1]*\n"
+				 "d or ctrl-D             Scroll k lines [current scroll size, initially 11]*\n"
+				 "q or Q or <interrupt>   Exit from more\n"
+				 "s                       Skip forward k lines of text [1]\n"
+				 "f                       Skip forward k screenfuls of text [1]\n"
+				 "b or ctrl-B             Skip backwards k screenfuls of text [1]\n"
+				 "'                       Go to place where previous search started\n"
+				 "=                       Display current line number\n"
+				 "/<regular expression>   Search for kth occurrence of regular expression [1]\n"
+				 "n                       Search for kth occurrence of last r.e [1]\n"
+				 "!<cmd> or :!<cmd>       Execute <cmd> in a subshell\n"
+				 "v                       Start up /usr/bin/vi at current line\n"
+				 "ctrl-L                  Redraw screen\n"
+				 ":n                      Go to kth next file [1]\n"
+				 ":p                      Go to kth previous file [1]\n"
+				 ":f                      Display current file name and line number\n"
+				 ".                       Repeat previous command\n"));
+			puts("---------------------------------------"
+			     "----------------------------------------");
+			prompt(filename);
+			break;
+		case 'v':	/* This case should go right before default */
+			if (!no_intty) {
+				/* Earlier: call vi +n file. This also
+				 * works for emacs.  POSIX: call vi -c n
+				 * file (when editor is vi or ex). */
+				char *editor, *p;
+				int n = (Currline - dlines <= 0 ? 1 :
+					 Currline - (dlines + 1) / 2);
+				int split = 0;
+
+				editor = getenv("VISUAL");
+				if (editor == NULL || *editor == '\0')
+					editor = getenv("EDITOR");
+				if (editor == NULL || *editor == '\0')
+					editor = VI;
+
+				p = strrchr(editor, '/');
+				if (p)
+					p++;
+				else
+					p = editor;
+				if (!strcmp(p, "vi") || !strcmp(p, "ex")) {
+					sprintf(cmdbuf, "-c %d", n);
+					split = 1;
+				} else {
+					sprintf(cmdbuf, "+%d", n);
+				}
+
+				kill_line();
+				printf("%s %s %s", editor, cmdbuf,
+				       fnames[fnum]);
+				if (split) {
+					cmdbuf[2] = 0;
+					execute(filename, editor, editor,
+						cmdbuf, cmdbuf + 3,
+						fnames[fnum], (char *)0);
+				} else
+					execute(filename, editor, editor,
+						cmdbuf, fnames[fnum],
+						(char *)0);
+				break;
+			}
+			/* fall through */
+		default:
+			if (dum_opt) {
+				kill_line();
+				if (Senter && Sexit) {
+					my_putstring(Senter);
+					promptlen =
+					    printf(_
+						   ("[Press 'h' for instructions.]"))
+					    + 2 * soglitch;
+					my_putstring(Sexit);
+				} else
+					promptlen =
+					    printf(_
+						   ("[Press 'h' for instructions.]"));
+				fflush(stdout);
+			} else
+				ringbell();
+			break;
+		}
+		if (done)
+			break;
+	}
+	putchar('\r');
+ endsw:
+	inwait = 0;
+	notell++;
+	return (retval);
 }
 
-/* return: 0 - unchanged, 1 - changed, -1 - overflow (unchanged) */
-int expand(char **outbuf, char *inbuf)
+/* Print out the contents of the file f, one screenful at a time. */
+#define STOP -10
+static void screen(register FILE *f, register int num_lines)
 {
-	char *inpstr;
-	char *outstr;
-	char c;
-	char *temp;
-	int changed = 0;
-	int tempsz, xtra, offset;
+	register int c;
+	register int nchars;
+	int length;			/* length of current line */
+	static int prev_len = 1;	/* length of previous line */
 
-	xtra = strlen(fnames[fnum]) + strlen(shell_line) + 1;
-	tempsz = 200 + xtra;
-	temp = xmalloc(tempsz);
-	inpstr = inbuf;
-	outstr = temp;
-	while ((c = *inpstr++) != '\0') {
-		offset = outstr - temp;
-		if (tempsz - offset - 1 < xtra) {
-			tempsz += 200 + xtra;
-			temp = xrealloc(temp, tempsz);
-			outstr = temp + offset;
-		}
-		switch (c) {
-		case '%':
-			if (!no_intty) {
-				strcpy(outstr, fnames[fnum]);
-				outstr += strlen(fnames[fnum]);
-				changed++;
-			} else
-				*outstr++ = c;
-			break;
-		case '!':
-			if (!shellp)
-				more_error(_
-					   ("No previous command to substitute for"));
-			strcpy(outstr, shell_line);
-			outstr += strlen(shell_line);
-			changed++;
-			break;
-		case '\\':
-			if (*inpstr == '%' || *inpstr == '!') {
-				*outstr++ = *inpstr++;
-				break;
+	for (;;) {
+		while (num_lines > 0 && !Pause) {
+			if ((nchars = get_line(f, &length)) == EOF) {
+				if (clreol)
+					clreos();
+				return;
 			}
-		default:
-			*outstr++ = c;
+			if (ssp_opt && length == 0 && prev_len == 0)
+				continue;
+			prev_len = length;
+			if (bad_so
+			    || ((Senter && *Senter == ' ') && (promptlen > 0)))
+				erasep(0);
+			/* must clear before drawing line since tabs on
+			 * some terminals do not erase what they tab
+			 * over. */
+			if (clreol)
+				cleareol();
+			prbuf(Line, length);
+			if (nchars < promptlen)
+				erasep(nchars);	/* erasep () sets promptlen to 0 */
+			else
+				promptlen = 0;
+			/* is this needed?
+			 * if (clreol)
+			 *	cleareol();     * must clear again in case we wrapped *
+			 */
+			if (nchars < Mcol || !fold_opt)
+				prbuf("\n", 1);	/* will turn off UL if necessary */
+			if (nchars == STOP)
+				break;
+			num_lines--;
+		}
+		if (pstate) {
+			my_putstring(ULexit);
+			pstate = 0;
+		}
+		fflush(stdout);
+		if ((c = Getc(f)) == EOF) {
+			if (clreol)
+				clreos();
+			return;
+		}
+
+		if (Pause && clreol)
+			clreos();
+		Ungetc(c, f);
+		sigsetjmp(restore, 1);
+		Pause = 0;
+		startup = 0;
+		if ((num_lines = command(NULL, f)) == 0)
+			return;
+		if (hard && promptlen > 0)
+			erasep(0);
+		if (noscroll && num_lines >= dlines) {
+			if (clreol)
+				home();
+			else
+				doclear();
 		}
+		screen_start.line = Currline;
+		screen_start.chrctr = Ftell(f);
 	}
-	*outstr++ = '\0';
-	*outbuf = temp;
-	return (changed);
 }
 
-void show(char c)
+/* Come here if a signal for a window size change is received */
+#ifdef SIGWINCH
+static void chgwinsz(int dummy __attribute__((__unused__)))
 {
-	if ((c < ' ' && c != '\n' && c != ESC) || c == RUBOUT) {
-		c += (c == RUBOUT) ? -0100 : 0100;
-		putserr(CARAT);
-		promptlen++;
+	struct winsize win;
+
+	signal(SIGWINCH, SIG_IGN);
+	if (ioctl(fileno(stdout), TIOCGWINSZ, &win) != -1) {
+		if (win.ws_row != 0) {
+			Lpp = win.ws_row;
+			nscroll = Lpp / 2 - 1;
+			if (nscroll <= 0)
+				nscroll = 1;
+			dlines = Lpp - 1;	/* was: Lpp - (noscroll ? 1 : 2) */
+		}
+		if (win.ws_col != 0)
+			Mcol = win.ws_col;
 	}
-	putcerr(c);
-	promptlen++;
+	signal(SIGWINCH, chgwinsz);
 }
+#endif				/* SIGWINCH */
 
-void more_error(char *mess)
+static void copy_file(register FILE *f)
 {
-	if (clreol)
-		cleareol();
-	else
-		kill_line();
-	promptlen += strlen(mess);
-	if (Senter && Sexit) {
-		my_putstring(Senter);
-		putsout(mess);
-		my_putstring(Sexit);
-	} else
-		putsout(mess);
-	fflush(stdout);
-	errors++;
-	siglongjmp(restore, 1);
+	char buf[BUFSIZ];
+	size_t sz;
+
+	while ((sz = fread(&buf, sizeof(char), sizeof(buf), f)) > 0)
+		fwrite(&buf, sizeof(char), sz, stdout);
 }
 
-void set_tty(void)
+/*----------------------------- Terminal I/O -------------------------------*/
+static void initterm(void)
 {
-	otty.c_lflag &= ~(ICANON | ECHO);
-	otty.c_cc[VMIN] = 1;	/* read at least 1 char */
-	otty.c_cc[VTIME] = 0;	/* no timeout */
-	stty(fileno(stderr), &otty);
-}
+	int ret;
+	char *padstr;
+	char *term;
+	struct winsize win;
+
+#ifdef do_SIGTTOU
+ retry:
+#endif
+
+#ifndef NON_INTERACTIVE_MORE
+	no_tty = tcgetattr(fileno(stdout), &otty);
+#endif
+	if (!no_tty) {
+		docrterase = (otty.c_cc[VERASE] != 255);
+		docrtkill = (otty.c_cc[VKILL] != 255);
+#ifdef do_SIGTTOU
+		{
+			int tgrp;
+			/* Wait until we're in the foreground before we
+			 * save the terminal modes. */
+			if ((tgrp = tcgetpgrp(fileno(stdout))) < 0)
+				err(EXIT_FAILURE, "tcgetpgrp");
+			if (tgrp != getpgrp(0)) {
+				kill(0, SIGTTOU);
+				goto retry;
+			}
+		}
+#endif	/* do_SIGTTOU */
+		if ((term = getenv("TERM")) == NULL) {
+			dumb++;
+			ul_opt = 0;
+		}
+		my_setupterm(term, 1, &ret);
+		if (ret <= 0) {
+			dumb++;
+			ul_opt = 0;
+		} else {
+#ifdef TIOCGWINSZ
+			if (ioctl(fileno(stdout), TIOCGWINSZ, &win) < 0) {
+#endif
+				Lpp = my_tgetnum(TERM_LINES);
+				Mcol = my_tgetnum(TERM_COLS);
+#ifdef TIOCGWINSZ
+			} else {
+				if ((Lpp = win.ws_row) == 0)
+					Lpp = my_tgetnum(TERM_LINES);
+				if ((Mcol = win.ws_col) == 0)
+					Mcol = my_tgetnum(TERM_COLS);
+			}
+#endif
+			if ((Lpp <= 0) || my_tgetflag(TERM_HARD_COPY)) {
+				hard++;	/* Hard copy terminal */
+				Lpp = LINES_PER_PAGE;
+			}
+
+			if (my_tgetflag(TERM_EAT_NEW_LINE))
+				/* Eat newline at last column + 1; dec, concept */
+				eatnl++;
+			if (Mcol <= 0)
+				Mcol = NUM_COLUMNS;
+
+			Wrap = my_tgetflag(TERM_AUTO_RIGHT_MARGIN);
+			bad_so = my_tgetflag(TERM_CEOL);
+			eraseln = my_tgetstr(TERM_CLEAR_TO_LINE_END);
+			Clear = my_tgetstr(TERM_CLEAR);
+			Senter = my_tgetstr(TERM_STANDARD_MODE);
+			Sexit = my_tgetstr(TERM_EXIT_STANDARD_MODE);
+			if ((soglitch = my_tgetnum(TERM_STD_MODE_GLITCH)) < 0)
+				soglitch = 0;
+
+			/* Set up for underlining:  some terminals don't
+			 * need it; others have start/stop sequences,
+			 * still others have an underline char sequence
+			 * which is assumed to move the cursor forward
+			 * one character.  If underline sequence isn't
+			 * available, settle for standout sequence. */
+			if (my_tgetflag(TERM_UNDERLINE)
+			    || my_tgetflag(TERM_OVER_STRIKE))
+				ul_opt = 0;
+			if ((chUL = my_tgetstr(TERM_UNDERLINE_CHAR)) == NULL)
+				chUL = "";
+			if (((ULenter =
+			      my_tgetstr(TERM_ENTER_UNDERLINE)) == NULL
+			     || (ULexit =
+				 my_tgetstr(TERM_EXIT_UNDERLINE)) == NULL)
+			    && !*chUL) {
+				if ((ULenter = Senter) == NULL
+				    || (ULexit = Sexit) == NULL) {
+					ULenter = "";
+					ULexit = "";
+				} else
+					ulglitch = soglitch;
+			} else {
+				ulglitch = 0;
+			}
 
-static int ourputch(int c)
-{
-	return putc(c, stdout);
-}
+			if ((padstr = my_tgetstr(TERM_PAD_CHAR)) != NULL)
+				PC = *padstr;
+			Home = my_tgetstr(TERM_HOME);
+			if (Home == NULL || *Home == '\0') {
+				if ((cursorm =
+				     my_tgetstr(TERM_CURSOR_ADDRESS)) != NULL) {
+					const char *t =
+					    (const char *)my_tgoto(cursorm, 0,
+								   0);
+					xstrncpy(cursorhome, t,
+						 sizeof(cursorhome));
+					Home = cursorhome;
+				}
+			}
+			EodClr = my_tgetstr(TERM_CLEAR_TO_SCREEN_END);
+			if ((chBS = my_tgetstr(TERM_LINE_DOWN)) == NULL)
+				chBS = "\b";
 
-void reset_tty(void)
-{
-	if (no_tty)
-		return;
-	if (pstate) {
-		/* putchar - if that isn't a macro */
-		tputs(ULexit, fileno(stdout), ourputch);
-		fflush(stdout);
-		pstate = 0;
+		}
+		if ((shell = getenv("SHELL")) == NULL)
+			shell = "/bin/sh";
+	}
+	no_intty = tcgetattr(fileno(stdin), &otty);
+	tcgetattr(fileno(stderr), &otty);
+	savetty0 = otty;
+	slow_tty = cfgetispeed(&otty) < B1200;
+	hardtabs = (otty.c_oflag & TABDLY) != XTABS;
+	if (!no_tty) {
+		otty.c_lflag &= ~(ICANON | ECHO);
+		otty.c_cc[VMIN] = 1;
+		otty.c_cc[VTIME] = 0;
 	}
-	otty.c_lflag |= ICANON | ECHO;
-	otty.c_cc[VMIN] = savetty0.c_cc[VMIN];
-	otty.c_cc[VTIME] = savetty0.c_cc[VTIME];
-	stty(fileno(stderr), &savetty0);
 }
 
-void rdline(register FILE *f)
+int main(int argc, char **argv)
 {
-	register int c;
-	register char *p;
+	FILE *f;
+	char *s;
+	int c;
+	int left;
+	int prnames = 0;
+	int initopt = 0;
+	int srchopt = 0;
+	int clearit = 0;
+	int initline = 0;
+	char *initbuf = NULL;
 
-	prepare_line_buffer();
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
 
-	p = Line;
-	while ((c = Getc(f)) != '\n' && c != EOF
-	       && (size_t)(p - Line) < LineLen - 1)
-		*p++ = c;
-	if (c == '\n')
-		Currline++;
-	*p = '\0';
-}
+	nfiles = argc;
+	fnames = argv;
+	setlocale(LC_ALL, "");
+	initterm();
 
-/* Come here when we get a suspend signal from the terminal */
-void onsusp(int dummy __attribute__((__unused__)))
-{
-	sigset_t signals, oldmask;
+	/* Auto set no scroll on when binary is called page */
+	if (!(strcmp(program_invocation_short_name, "page")))
+		noscroll++;
 
-	/* ignore SIGTTOU so we don't get stopped if csh grabs the tty */
-	signal(SIGTTOU, SIG_IGN);
-	reset_tty();
-	fflush(stdout);
-	signal(SIGTTOU, SIG_DFL);
-	/* Send the TSTP signal to suspend our process group */
-	signal(SIGTSTP, SIG_DFL);
+	prepare_line_buffer();
 
-	/* unblock SIGTSTP or we won't be able to suspend ourself */
-	sigemptyset(&signals);
-	sigaddset(&signals, SIGTSTP);
-	sigprocmask(SIG_UNBLOCK, &signals, &oldmask);
+	nscroll = Lpp / 2 - 1;
+	if (nscroll <= 0)
+		nscroll = 1;
 
-	kill(0, SIGTSTP);
-	/* Pause for station break */
+	if ((s = getenv("MORE")) != NULL)
+		argscan(s);
 
-	sigprocmask(SIG_SETMASK, &oldmask, NULL);
+	while (--nfiles > 0) {
+		if ((c = (*++fnames)[0]) == '-') {
+			argscan(*fnames + 1);
+		} else if (c == '+') {
+			s = *fnames;
+			if (*++s == '/') {
+				srchopt++;
+				initbuf = xstrdup(s + 1);
+			} else {
+				initopt++;
+				for (initline = 0; *s != '\0'; s++)
+					if (isdigit(*s))
+						initline =
+						    initline * 10 + *s - '0';
+				--initline;
+			}
+		} else
+			break;
+	}
+	/* allow clreol only if Home and eraseln and EodClr strings are
+	 * defined, and in that case, make sure we are in noscroll mode */
+	if (clreol) {
+		if ((Home == NULL) || (*Home == '\0') ||
+		    (eraseln == NULL) || (*eraseln == '\0') ||
+		    (EodClr == NULL) || (*EodClr == '\0'))
+			clreol = 0;
+		else
+			noscroll = 1;
+	}
+	if (dlines == 0)
+		dlines = Lpp - 1;	/* was: Lpp - (noscroll ? 1 : 2) */
+	left = dlines;
+	if (nfiles > 1)
+		prnames++;
+	if (!no_intty && nfiles == 0)
+		usage(stderr);
+	else
+		f = stdin;
+	if (!no_tty) {
+		signal(SIGQUIT, onquit);
+		signal(SIGINT, end_it);
+#ifdef SIGWINCH
+		signal(SIGWINCH, chgwinsz);
+#endif
+		if (signal(SIGTSTP, SIG_IGN) == SIG_DFL) {
+			signal(SIGTSTP, onsusp);
+			catch_susp++;
+		}
+		stty(fileno(stderr), &otty);
+	}
+	if (no_intty) {
+		if (no_tty)
+			copy_file(stdin);
+		else {
+			if ((c = Getc(f)) == '\f')
+				doclear();
+			else {
+				Ungetc(c, f);
+				if (noscroll && (c != EOF)) {
+					if (clreol)
+						home();
+					else
+						doclear();
+				}
+			}
+			if (srchopt) {
+				free(previousre);
+				previousre = xstrdup(initbuf);
+				search(initbuf, stdin, 1);
+				if (noscroll)
+					left--;
+			} else if (initopt)
+				skiplns(initline, stdin);
+			screen(stdin, left);
+		}
+		no_intty = 0;
+		prnames++;
+		firstf = 0;
+	}
 
-	/* We're back */
-	signal(SIGTSTP, onsusp);
-	set_tty();
-	if (inwait)
-		siglongjmp(restore, 1);
+	while (fnum < nfiles) {
+		if ((f = checkf(fnames[fnum], &clearit)) != NULL) {
+			context.line = context.chrctr = 0;
+			Currline = 0;
+			if (firstf)
+				sigsetjmp(restore, 1);
+			if (firstf) {
+				firstf = 0;
+				if (srchopt) {
+					free(previousre);
+					previousre = xstrdup(initbuf);
+					search(initbuf, f, 1);
+					if (noscroll)
+						left--;
+				} else if (initopt)
+					skiplns(initline, f);
+			} else if (fnum < nfiles && !no_tty) {
+				sigsetjmp(restore, 1);
+				left = command(fnames[fnum], f);
+			}
+			if (left != 0) {
+				if ((noscroll || clearit)
+				    && (file_size != LONG_MAX)) {
+					if (clreol)
+						home();
+					else
+						doclear();
+				}
+				if (prnames) {
+					if (bad_so)
+						erasep(0);
+					if (clreol)
+						cleareol();
+					putsout("::::::::::::::");
+					if (promptlen > 14)
+						erasep(14);
+					putchar('\n');
+					if (clreol)
+						cleareol();
+					puts(fnames[fnum]);
+					if (clreol)
+						cleareol();
+					puts("::::::::::::::");
+					if (left > Lpp - 4)
+						left = Lpp - 4;
+				}
+				if (no_tty)
+					copy_file(f);
+				else {
+					within++;
+					screen(f, left);
+					within = 0;
+				}
+			}
+			sigsetjmp(restore, 1);
+			fflush(stdout);
+			fclose(f);
+			screen_start.line = screen_start.chrctr = 0L;
+			context.line = context.chrctr = 0L;
+		}
+		fnum++;
+		firstf = 0;
+	}
+	free(previousre);
+	free(initbuf);
+	free(Line);
+	reset_tty();
+	exit(EXIT_SUCCESS);
 }
-- 
2.3.0

