Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f179.google.com ([74.125.82.179]:46014 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbbBVOnu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:43:50 -0500
Received: by wesw62 with SMTP id w62so13543531wes.12
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:43:49 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 03/31] more: add struct more_control and remove global variables
Date: Sun, 22 Feb 2015 14:42:59 +0000
Message-Id: <1424616207-747-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Sorry, this is horribly long change, but there does not seem to be any
other way to do this sort of globals to control struct changes.  To keep
the as sane as it can be there are no functional changes in these lines.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 1320 +++++++++++++++++++++++++++--------------------------
 1 file changed, 680 insertions(+), 640 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 3937796..020f9b9 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -85,23 +85,23 @@
 
 #define VI	"vi"	/* found on the user's path */
 
-#define Fopen(s,m)	(Currline = 0,file_pos=0,fopen(s,m))
-#define Ftell(f)	file_pos
-#define Fseek(f,off)	(file_pos=off,fseek(f,off,0))
-#define Getc(f)		(++file_pos, getc(f))
-#define Ungetc(c,f)	(--file_pos, ungetc(c,f))
+#define Fopen(s, m)	(ctl->Currline = 0, ctl->file_pos=0, fopen(s,m))
+#define Ftell(f)	ctl->file_pos
+#define Fseek(f, off)	(ctl->file_pos=off, fseek(f, off, 0))
+#define Getc(f)		(++ctl->file_pos, getc(f))
+#define Ungetc(c, f)	(--ctl->file_pos, ungetc(c, f))
 #define putcerr(c)	fputc(c, stderr)
 #define putserr(s)	fputs(s, stderr)
 #define putsout(s)	fputs(s, stdout)
 
-#define stty(fd,argp)	tcsetattr(fd,TCSANOW,argp)
+#define stty(fd, argp)	tcsetattr(fd, TCSANOW, argp)
 #define ringbell()	putcerr('\007')
 
 static char *BS = "\b";
 static char *BSB = "\b \b";
 static char *CARAT = "^";
 #define ERASEONECOLUMN \
-    if (docrterase) \
+    if (ctl->docrterase) \
 	putserr(BSB); \
     else \
 	putserr(BS);
@@ -122,68 +122,89 @@ static char *CARAT = "^";
 #define REGERR_BUF	NUM_COLUMNS
 #define STOP		-10
 
-struct termios otty, savetty0;
-long file_pos, file_size;
-int fnum, no_intty, no_tty, slow_tty;
-int dum_opt, dlines;
-int nscroll = SCROLL_LEN;	/* Number of lines scrolled by 'd' */
-int fold_opt = 1;		/* Fold long lines */
-int stop_opt = 1;		/* Stop after form feeds */
-int ssp_opt = 0;		/* Suppress white space */
-int ul_opt = 1;			/* Underline as best we can */
-int promptlen;
-int Currline;			/* Line we are currently at */
-int startup = 1;
-int firstf = 1;
-int notell = 1;
-int docrterase = 0;
-int docrtkill = 0;
-int bad_so;			/* True if overwriting does not turn
-				   off standout */
-int inwait, Pause, errors;
-int within;			/* true if we are within a file,
-				   false if we are between files */
-int hard, dumb, noscroll, hardtabs, clreol, eatnl;
-int catch_susp;			/* We should catch the SIGTSTP signal */
-char **fnames;			/* The list of file names */
-int nfiles;			/* Number of files left to process */
-char *shell;			/* The name of the shell to use */
-int shellp;			/* A previous shell command exists */
-sigjmp_buf restore;
-char *Line;			/* Line buffer */
-size_t LineLen;			/* size of Line buffer */
-int Lpp = LINES_PER_PAGE;	/* lines per page */
-char *Clear;			/* clear screen */
-char *eraseln;			/* erase line */
-char *Senter, *Sexit;		/* enter and exit standout mode */
-char *ULenter, *ULexit;		/* enter and exit underline mode */
-char *chUL;			/* underline character */
-char *chBS;			/* backspace character */
-char *Home;			/* go to home */
-char *cursorm;			/* cursor movement */
-char cursorhome[40];		/* contains cursor movement to home */
-char *EodClr;			/* clear rest of screen */
-int Mcol = NUM_COLUMNS;		/* number of columns */
-int Wrap = 1;			/* set if automargins */
-int soglitch;			/* terminal has standout mode glitch */
-int ulglitch;			/* terminal has underline mode glitch */
-int pstate = 0;			/* current UL state */
-char *previousre;		/* previous search() buf[] item */
-struct {
-	long chrctr, line;
-} context, screen_start;
-extern char PC;			/* pad character */
-
-static char ch;
-static int lastcmd, lastarg, lastp;
-static int lastcolon;
-char shell_line[SHELL_LINE];
-
+struct more_control {
+	struct termios otty;		/* output terminal */
+	struct termios savetty0;	/* original terminal settings */
+	long file_pos;			/* file position */
+	long file_size;			/* file size */
+	int fnum;			/* position in argv[] */
+	int nscroll;			/* number of lines scrolled by 'd' */
+	int dlines;			/* screen size in lines */
+	int promptlen;			/* message prompt length */
+	int Currline;			/* line we are currently at */
+	char **fnames;			/* the list of file names */
+	int nfiles;			/* number of files left to process */
+	char *shell;			/* the name of the shell to use */
+	int shellp;			/* does previous shell command exists */
+	sigjmp_buf restore;		/* siglongjmp() destination */
+	char *Line;			/* line buffer */
+	size_t LineLen;			/* size of line buffer */
+	int Lpp;			/* lines per page */
+	char *Clear;			/* clear screen */
+	char *eraseln;			/* erase line */
+	char *Senter;			/* enter standout mode */
+	char *Sexit;			/* exit standout mode */
+	char *ULenter;			/* enter underline mode */
+	char *ULexit;			/* exit underline mode */
+	char *chUL;			/* underline character */
+	char *chBS;			/* backspace character */
+	char *Home;			/* go to screen home position */
+	char *cursorm;			/* cursor move destination */
+	char cursorhome[40];		/* contains cursor movement to home */
+	char *EodClr;			/* clear rest of screen */
+	int Mcol;			/* number of columns */
+	char *previousre;		/* previous search() buf[] item */
+	struct {
+		long chrctr;		/* row number */
+		long line;		/* line number */
+	} context,
+	  screen_start;
+	char PC;			/* pad character (instead of null) */
+	char ch;			/* temporary character. FIXME: move to function scope */
+	int lastcmd;			/* previous more key command */
+	int lastarg;			/* previous key command argument */
+	int lastcolon;			/* is a colon-prefixed key command */
+	char shell_line[SHELL_LINE];
 #if !defined(HAVE_NCURSES_H) && !defined(HAVE_NCURSES_NCURSES_H) && defined(HAVE_LIBTERMCAP)
-char termbuffer[TERMINAL_BUF];
-char tcbuffer[TERMINAL_BUF];
-char *strbuf = termbuffer;
+	char termbuffer[TERMINAL_BUF];	/* FIXME: remove, not in use */
+	char *strbuf = termbuffer;	/* FIXME: remove, not in use */
+	char tcbuffer[TERMINAL_BUF];	/* buffer for my_setupterm() in more-term.h */
 #endif
+	unsigned int
+		bad_so:1,		/* true if overwriting does not turn off standout */
+		catch_susp:1,		/* should SIGTSTP signal be caught */
+		clreol:1,		/* do not scroll, paint each screen from the top */
+		docrterase:1,		/* is erase previous supported */
+		docrtkill:1,		/* is erase input supported */
+		dumb:1,			/* is terminal type known */
+		dum_opt:1,		/* suppress bell */
+		eatnl:1,		/* is newline ignored after 80 cols */
+		errors:1,		/* is an error reported */
+		firstf:1,		/* is the input file the first in list */
+		fold_opt:1,		/* fold long lines */
+		hard:1,			/* is this hard copy terminal */
+		hardtabs:1,		/* print spaces instead of '\t' */
+		inwait:1,		/* is waiting user input */
+		lastp:1,		/* run previous key command */
+		noscroll:1,		/* do not scroll, clear the screen and then display text */
+		notell:1,		/* suppress quit dialog */
+		no_intty:1,		/* is input in interactive mode */
+		no_tty:1,		/* is output in interactive mode */
+		Pause:1,		/* is output paused */
+		pstate:1,		/* is underlining going on */
+		slow_tty:1,		/* is output speed slow. FIXME: remove */
+		soglitch:1,		/* terminal has standout mode glitch */
+		ssp_opt:1,		/* suppress white space */
+		startup:1,		/* is startup completed */
+		stop_opt:1,		/* stop after form feeds */
+		ulglitch:1,		/* terminal is underlining in glitch mode */
+		ul_opt:1,		/* underline as best we can */
+		within:1,		/* true if we are within a file, false if we are between files */
+		Wrap:1;			/* set if automargins */
+};
+/* FIXME: the global_ctl is used in signal handlers, until the signal
+ * handling is corrected to use signalfd().  */
+struct more_control *global_ctl;
 
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
@@ -209,7 +230,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-static void argscan(char *s)
+static void argscan(struct more_control *ctl, char *s)
 {
 	int seen_num = 0;
 
@@ -226,31 +247,31 @@ static void argscan(char *s)
 		case '8':
 		case '9':
 			if (!seen_num) {
-				dlines = 0;
+				ctl->dlines = 0;
 				seen_num = 1;
 			}
-			dlines = dlines * 10 + *s - '0';
+			ctl->dlines = ctl->dlines * 10 + *s - '0';
 			break;
 		case 'd':
-			dum_opt = 1;
+			ctl->dum_opt = 1;
 			break;
 		case 'l':
-			stop_opt = 0;
+			ctl->stop_opt = 0;
 			break;
 		case 'f':
-			fold_opt = 0;
+			ctl->fold_opt = 0;
 			break;
 		case 'p':
-			noscroll++;
+			ctl->noscroll = 1;
 			break;
 		case 'c':
-			clreol++;
+			ctl->clreol = 1;
 			break;
 		case 's':
-			ssp_opt = 1;
+			ctl->ssp_opt = 1;
 			break;
 		case 'u':
-			ul_opt = 0;
+			ctl->ul_opt = 0;
 			break;
 		case '-':
 		case ' ':
@@ -270,9 +291,9 @@ static void argscan(char *s)
 }
 
 /* force clear to end of line */
-static void cleareol(void)
+static void cleareol(struct more_control *ctl)
 {
-	my_putstring(eraseln);
+	my_putstring(ctl->eraseln);
 }
 
 /* magic --
@@ -307,7 +328,7 @@ static int magic(FILE *f, char *fs)
 
 /* Check whether the file named by fs is an ASCII file which the user may
  * access.  If it is, return the opened file.  Otherwise return NULL. */
-static FILE *checkf(register char *fs, int *clearfirst)
+static FILE *checkf(struct more_control *ctl, register char *fs, int *clearfirst)
 {
 	struct stat stbuf;
 	register FILE *f;
@@ -315,8 +336,8 @@ static FILE *checkf(register char *fs, int *clearfirst)
 
 	if (stat(fs, &stbuf) == -1) {
 		fflush(stdout);
-		if (clreol)
-			cleareol();
+		if (ctl->clreol)
+			cleareol(ctl);
 		warn(_("stat of %s failed"), fs);
 		return ((FILE *)NULL);
 	}
@@ -337,30 +358,30 @@ static FILE *checkf(register char *fs, int *clearfirst)
 	c = Getc(f);
 	*clearfirst = (c == '\f');
 	Ungetc(c, f);
-	if ((file_size = stbuf.st_size) == 0)
-		file_size = LONG_MAX;
+	if ((ctl->file_size = stbuf.st_size) == 0)
+		ctl->file_size = LONG_MAX;
 	return (f);
 }
 
-static void prepare_line_buffer(void)
+static void prepare_line_buffer(struct more_control *ctl)
 {
 	char *nline;
-	size_t nsz = Mcol * 4;
+	size_t nsz = ctl->Mcol * 4;
 
-	if (LineLen >= nsz)
+	if (ctl->LineLen >= nsz)
 		return;
 
 	if (nsz < LINSIZ)
 		nsz = LINSIZ;
 
 	/* alloc nsz and extra space for \n\0 */
-	nline = xrealloc(Line, nsz + 2);
-	Line = nline;
-	LineLen = nsz;
+	nline = xrealloc(ctl->Line, nsz + 2);
+	ctl->Line = nline;
+	ctl->LineLen = nsz;
 }
 
 /* Get a logical line */
-static int get_line(register FILE *f, int *length)
+static int get_line(struct more_control *ctl, register FILE *f, int *length)
 {
 	int c;
 	char *p;
@@ -382,18 +403,18 @@ static int get_line(register FILE *f, int *length)
 	memset(&state, '\0', sizeof(mbstate_t));
 #endif
 
-	prepare_line_buffer();
+	prepare_line_buffer(ctl);
 
-	p = Line;
+	p = ctl->Line;
 	column = 0;
 	c = Getc(f);
 	if (colflg && c == '\n') {
-		Currline++;
+		ctl->Currline++;
 		c = Getc(f);
 	}
-	while (p < &Line[LineLen - 1]) {
+	while (p < &ctl->Line[ctl->LineLen - 1]) {
 #ifdef HAVE_WIDECHAR
-		if (fold_opt && use_mbc_buffer_flag && MB_CUR_MAX > 1) {
+		if (ctl->fold_opt && use_mbc_buffer_flag && MB_CUR_MAX > 1) {
 			use_mbc_buffer_flag = 0;
 			state_bak = state;
 			mbc[mbc_pos++] = c;
@@ -412,7 +433,7 @@ static int get_line(register FILE *f, int *length)
 				column++;
 				file_pos_bak++;
 
-				if (column >= Mcol) {
+				if (column >= ctl->Mcol) {
 					Fseek(f, file_pos_bak);
 				} else {
 					memmove(mbc, mbc + 1, --mbc_pos);
@@ -426,11 +447,11 @@ static int get_line(register FILE *f, int *length)
 			default:
 				wc_width = wcwidth(wc);
 
-				if (column + wc_width > Mcol) {
+				if (column + wc_width > ctl->Mcol) {
 					Fseek(f, file_pos_bak);
 					break_flag = 1;
 				} else {
-					for (i = 0; p < &Line[LineLen - 1] &&
+					for (i = 0; p < &ctl->Line[ctl->LineLen - 1] &&
 						    i < mbc_pos; i++)
 						*p++ = mbc[i];
 					if (wc_width > 0)
@@ -438,7 +459,7 @@ static int get_line(register FILE *f, int *length)
 				}
 			}
 
-			if (break_flag || column >= Mcol)
+			if (break_flag || column >= ctl->Mcol)
 				break;
 
 			c = Getc(f);
@@ -446,16 +467,16 @@ static int get_line(register FILE *f, int *length)
 		}
 #endif	/* HAVE_WIDECHAR */
 		if (c == EOF) {
-			if (p > Line) {
+			if (p > ctl->Line) {
 				*p = '\0';
-				*length = p - Line;
+				*length = p - ctl->Line;
 				return (column);
 			}
-			*length = p - Line;
+			*length = p - ctl->Line;
 			return (EOF);
 		}
 		if (c == '\n') {
-			Currline++;
+			ctl->Currline++;
 			break;
 		}
 
@@ -475,19 +496,19 @@ static int get_line(register FILE *f, int *length)
 		}
 #endif	/* 0 */
 		if (c == '\t') {
-			if (!hardtabs || (column < promptlen && !hard)) {
-				if (hardtabs && eraseln && !dumb) {
+			if (!ctl->hardtabs || (column < ctl->promptlen && !ctl->hard)) {
+				if (ctl->hardtabs && ctl->eraseln && !ctl->dumb) {
 					column = 1 + (column | 7);
-					my_putstring(eraseln);
-					promptlen = 0;
+					my_putstring(ctl->eraseln);
+					ctl->promptlen = 0;
 				} else {
-					for (--p; p < &Line[LineLen - 1];) {
+					for (--p; p < &ctl->Line[ctl->LineLen - 1];) {
 						*p++ = ' ';
 						if ((++column & 7) == 0)
 							break;
 					}
-					if (column >= promptlen)
-						promptlen = 0;
+					if (column >= ctl->promptlen)
+						ctl->promptlen = 0;
 				}
 			} else
 				column = 1 + (column | 7);
@@ -497,22 +518,22 @@ static int get_line(register FILE *f, int *length)
 			int next = Getc(f);
 			if (next == '\n') {
 				p--;
-				Currline++;
+				ctl->Currline++;
 				break;
 			}
 			Ungetc(next, f);
 			column = 0;
-		} else if (c == '\f' && stop_opt) {
+		} else if (c == '\f' && ctl->stop_opt) {
 			p[-1] = '^';
 			*p++ = 'L';
 			column += 2;
-			Pause++;
+			ctl->Pause = 1;
 		} else if (c == EOF) {
-			*length = p - Line;
+			*length = p - ctl->Line;
 			return (column);
 		} else {
 #ifdef HAVE_WIDECHAR
-			if (fold_opt && MB_CUR_MAX > 1) {
+			if (ctl->fold_opt && MB_CUR_MAX > 1) {
 				memset(mbc, '\0', MB_LEN_MAX);
 				mbc_pos = 0;
 				mbc[mbc_pos++] = c;
@@ -546,52 +567,52 @@ static int get_line(register FILE *f, int *length)
 			}
 		}
 
-		if (column >= Mcol && fold_opt)
+		if (column >= ctl->Mcol && ctl->fold_opt)
 			break;
 #ifdef HAVE_WIDECHAR
-		if (use_mbc_buffer_flag == 0 && p >= &Line[LineLen - 1 - 4])
+		if (use_mbc_buffer_flag == 0 && p >= &ctl->Line[ctl->LineLen - 1 - 4])
 			/* don't read another char if there is no space for
 			 * whole multibyte sequence */
 			break;
 #endif
 		c = Getc(f);
 	}
-	if (column >= Mcol && Mcol > 0) {
-		if (!Wrap) {
+	if (column >= ctl->Mcol && ctl->Mcol > 0) {
+		if (!ctl->Wrap) {
 			*p++ = '\n';
 		}
 	}
-	colflg = column == Mcol && fold_opt;
-	if (colflg && eatnl && Wrap) {
+	colflg = column == ctl->Mcol && ctl->fold_opt;
+	if (colflg && ctl->eatnl && ctl->Wrap) {
 		*p++ = '\n';	/* simulate normal wrap */
 	}
-	*length = p - Line;
+	*length = p - ctl->Line;
 	*p = 0;
 	return (column);
 }
 
 /* Erase the rest of the prompt, assuming we are starting at column col. */
-static void erasep(register int col)
+static void erasep(struct more_control *ctl, register int col)
 {
 
-	if (promptlen == 0)
+	if (ctl->promptlen == 0)
 		return;
-	if (hard) {
+	if (ctl->hard) {
 		putchar('\n');
 	} else {
 		if (col == 0)
 			putchar('\r');
-		if (!dumb && eraseln)
-			my_putstring(eraseln);
+		if (!ctl->dumb && ctl->eraseln)
+			my_putstring(ctl->eraseln);
 		else
-			printf("%*s", promptlen - col, "");
+			printf("%*s", ctl->promptlen - col, "");
 	}
-	promptlen = 0;
+	ctl->promptlen = 0;
 }
 
-static void clreos(void)
+static void clreos(struct more_control *ctl)
 {
-	my_putstring(EodClr);
+	my_putstring(ctl->EodClr);
 }
 
 static UL_ASAN_BLACKLIST size_t xmbrtowc(wchar_t *wc, const char *s, size_t n,
@@ -604,17 +625,17 @@ static UL_ASAN_BLACKLIST size_t xmbrtowc(wchar_t *wc, const char *s, size_t n,
 }
 
 /* Print a buffer of n characters */
-static void prbuf(register char *s, register int n)
+static void prbuf(struct more_control *ctl, register char *s, register int n)
 {
 	register char c;	/* next output character */
 	register int state;	/* next output char's UL state */
 #define wouldul(s,n)	((n) >= 2 && (((s)[0] == '_' && (s)[1] == '\b') || ((s)[1] == '\b' && (s)[2] == '_')))
 
 	while (--n >= 0)
-		if (!ul_opt)
+		if (!ctl->ul_opt)
 			putchar(*s++);
 		else {
-			if (*s == ' ' && pstate == 0 && ulglitch
+			if (*s == ' ' && ctl->pstate == 0 && ctl->ulglitch
 			    && wouldul(s + 1, n - 1)) {
 				s++;
 				continue;
@@ -625,15 +646,15 @@ static void prbuf(register char *s, register int n)
 				s += 3;
 			} else
 				c = *s++;
-			if (state != pstate) {
-				if (c == ' ' && state == 0 && ulglitch
+			if (state != ctl->pstate) {
+				if (c == ' ' && state == 0 && ctl->ulglitch
 				    && wouldul(s, n - 1))
 					state = 1;
 				else
-					my_putstring(state ? ULenter : ULexit);
+					my_putstring(state ? ctl->ULenter : ctl->ULexit);
 			}
-			if (c != ' ' || pstate == 0 || state != 0
-			    || ulglitch == 0)
+			if (c != ' ' || ctl->pstate == 0 || state != 0
+			    || ctl->ulglitch == 0)
 #ifdef HAVE_WIDECHAR
 			{
 				wchar_t wc;
@@ -650,56 +671,56 @@ static void prbuf(register char *s, register int n)
 #else
 				putchar(c);
 #endif				/* HAVE_WIDECHAR */
-			if (state && *chUL) {
-				putsout(chBS);
-				my_putstring(chUL);
+			if (state && *ctl->chUL) {
+				putsout(ctl->chBS);
+				my_putstring(ctl->chUL);
 			}
-			pstate = state;
+			ctl->pstate = state;
 		}
 }
 
 /* Erase the current line entirely */
-static void kill_line(void)
+static void kill_line(struct more_control *ctl)
 {
-	erasep(0);
-	if (!eraseln || dumb)
+	erasep(ctl, 0);
+	if (!ctl->eraseln || ctl->dumb)
 		putchar('\r');
 }
 
-static void prompt(char *filename)
+static void prompt(struct more_control *ctl, char *filename)
 {
-	if (clreol)
-		cleareol();
-	else if (promptlen > 0)
-		kill_line();
-	if (!hard) {
-		promptlen = 0;
-		if (Senter && Sexit) {
-			my_putstring(Senter);
-			promptlen += (2 * soglitch);
+	if (ctl->clreol)
+		cleareol(ctl);
+	else if (ctl->promptlen > 0)
+		kill_line(ctl);
+	if (!ctl->hard) {
+		ctl->promptlen = 0;
+		if (ctl->Senter && ctl->Sexit) {
+			my_putstring(ctl->Senter);
+			ctl->promptlen += (2 * ctl->soglitch);
 		}
-		if (clreol)
-			cleareol();
-		promptlen += printf(_("--More--"));
+		if (ctl->clreol)
+			cleareol(ctl);
+		ctl->promptlen += printf(_("--More--"));
 		if (filename != NULL) {
-			promptlen += printf(_("(Next file: %s)"), filename);
-		} else if (!no_intty) {
-			promptlen +=
+			ctl->promptlen += printf(_("(Next file: %s)"), filename);
+		} else if (!ctl->no_intty) {
+			ctl->promptlen +=
 			    printf("(%d%%)",
-				   (int)((file_pos * 100) / file_size));
+				   (int)((ctl->file_pos * 100) / ctl->file_size));
 		}
-		if (dum_opt) {
-			promptlen +=
+		if (ctl->dum_opt) {
+			ctl->promptlen +=
 			    printf(_("[Press space to continue, 'q' to quit.]"));
 		}
-		if (Senter && Sexit)
-			my_putstring(Sexit);
-		if (clreol)
-			clreos();
+		if (ctl->Senter && ctl->Sexit)
+			my_putstring(ctl->Sexit);
+		if (ctl->clreol)
+			clreos(ctl);
 		fflush(stdout);
 	} else
 		ringbell();
-	inwait++;
+	ctl->inwait = 1;
 }
 
 static int ourputch(int c)
@@ -707,41 +728,41 @@ static int ourputch(int c)
 	return putc(c, stdout);
 }
 
-static void reset_tty(void)
+static void reset_tty(struct more_control *ctl)
 {
-	if (no_tty)
+	if (ctl->no_tty)
 		return;
-	if (pstate) {
+	if (ctl->pstate) {
 		/* putchar - if that isn't a macro */
-		tputs(ULexit, fileno(stdout), ourputch);
+		tputs(ctl->ULexit, fileno(stdout), ourputch);
 		fflush(stdout);
-		pstate = 0;
+		ctl->pstate = 0;
 	}
-	otty.c_lflag |= ICANON | ECHO;
-	otty.c_cc[VMIN] = savetty0.c_cc[VMIN];
-	otty.c_cc[VTIME] = savetty0.c_cc[VTIME];
-	stty(fileno(stderr), &savetty0);
+	ctl->otty.c_lflag |= ICANON | ECHO;
+	ctl->otty.c_cc[VMIN] = ctl->savetty0.c_cc[VMIN];
+	ctl->otty.c_cc[VTIME] = ctl->savetty0.c_cc[VTIME];
+	stty(fileno(stderr), &ctl->savetty0);
 }
 
 /* Clean up terminal state and exit. Also come here if interrupt signal received */
 static void __attribute__((__noreturn__)) end_it(int dummy __attribute__((__unused__)))
 {
-	reset_tty();
-	if (clreol) {
+	reset_tty(global_ctl);
+	if (global_ctl->clreol) {
 		putchar('\r');
-		clreos();
+		clreos(global_ctl);
 		fflush(stdout);
-	} else if (!clreol && (promptlen > 0)) {
-		kill_line();
+	} else if (!global_ctl->clreol && (global_ctl->promptlen > 0)) {
+		kill_line(global_ctl);
 		fflush(stdout);
 	} else
 		putcerr('\n');
-	free(previousre);
-	free(Line);
+	free(global_ctl->previousre);
+	free(global_ctl->Line);
 	_exit(EXIT_SUCCESS);
 }
 
-static int readch(void)
+static int readch(struct more_control *ctl)
 {
 	unsigned char c;
 
@@ -750,27 +771,27 @@ static int readch(void)
 		if (errno != EINTR)
 			end_it(0);
 		else
-			c = otty.c_cc[VKILL];
+			c = ctl->otty.c_cc[VKILL];
 	}
 	return (c);
 }
 
 /* Read a decimal number from the terminal.  Set cmd to the non-digit
  * which terminates the number. */
-static int number(char *cmd)
+static int number(struct more_control *ctl, char *cmd)
 {
 	register int i;
 
 	i = 0;
-	ch = otty.c_cc[VKILL];
+	ctl->ch = ctl->otty.c_cc[VKILL];
 	for (;;) {
-		ch = readch();
-		if (isdigit(ch))
-			i = i * 10 + ch - '0';
-		else if ((cc_t) ch == otty.c_cc[VKILL])
+		ctl->ch = readch(ctl);
+		if (isdigit(ctl->ch))
+			i = i * 10 + ctl->ch - '0';
+		else if ((cc_t) ctl->ch == ctl->otty.c_cc[VKILL])
 			i = 0;
 		else {
-			*cmd = ch;
+			*cmd = ctl->ch;
 			break;
 		}
 	}
@@ -779,62 +800,62 @@ static int number(char *cmd)
 
 /* Skip nskip files in the file list (from the command line).  Nskip may
  * be negative. */
-static void skipf(register int nskip)
+static void skipf(struct more_control *ctl, register int nskip)
 {
 	if (nskip == 0)
 		return;
 	if (nskip > 0) {
-		if (fnum + nskip > nfiles - 1)
-			nskip = nfiles - fnum - 1;
-	} else if (within)
-		++fnum;
-	fnum += nskip;
-	if (fnum < 0)
-		fnum = 0;
+		if (ctl->fnum + nskip > ctl->nfiles - 1)
+			nskip = ctl->nfiles - ctl->fnum - 1;
+	} else if (ctl->within)
+		ctl->fnum++;
+	ctl->fnum += nskip;
+	if (ctl->fnum < 0)
+		ctl->fnum = 0;
 	puts(_("\n...Skipping "));
-	if (clreol)
-		cleareol();
+	if (ctl->clreol)
+		cleareol(ctl);
 	if (nskip > 0)
 		putsout(_("...Skipping to file "));
 	else
 		putsout(_("...Skipping back to file "));
-	puts(fnames[fnum]);
-	if (clreol)
-		cleareol();
+	puts(ctl->fnames[ctl->fnum]);
+	if (ctl->clreol)
+		cleareol(ctl);
 	putchar('\n');
-	--fnum;
+	ctl->fnum--;
 }
 
-static void show(char c)
+static void show(struct more_control *ctl, char c)
 {
 	if ((c < ' ' && c != '\n' && c != ESC) || c == RUBOUT) {
 		c += (c == RUBOUT) ? -0100 : 0100;
 		putserr(CARAT);
-		promptlen++;
+		ctl->promptlen++;
 	}
 	putcerr(c);
-	promptlen++;
+	ctl->promptlen++;
 }
 
-static void more_error(char *mess)
+static void more_error(struct more_control *ctl, char *mess)
 {
-	if (clreol)
-		cleareol();
+	if (ctl->clreol)
+		cleareol(ctl);
 	else
-		kill_line();
-	promptlen += strlen(mess);
-	if (Senter && Sexit) {
-		my_putstring(Senter);
+		kill_line(ctl);
+	ctl->promptlen += strlen(mess);
+	if (ctl->Senter && ctl->Sexit) {
+		my_putstring(ctl->Senter);
 		putsout(mess);
-		my_putstring(Sexit);
+		my_putstring(ctl->Sexit);
 	} else
 		putsout(mess);
 	fflush(stdout);
-	errors++;
-	siglongjmp(restore, 1);
+	ctl->errors++;
+	siglongjmp(ctl->restore, 1);
 }
 
-static void ttyin(char buf[], register int nmax, char pchar)
+static void ttyin(struct more_control *ctl, char buf[], register int nmax, char pchar)
 {
 	char *sp;
 	int c;
@@ -844,12 +865,12 @@ static void ttyin(char buf[], register int nmax, char pchar)
 	sp = buf;
 	maxlen = 0;
 	while (sp - buf < nmax) {
-		if (promptlen > maxlen)
-			maxlen = promptlen;
-		c = readch();
+		if (ctl->promptlen > maxlen)
+			maxlen = ctl->promptlen;
+		c = readch(ctl);
 		if (c == '\\') {
 			slash++;
-		} else if (((cc_t) c == otty.c_cc[VERASE]) && !slash) {
+		} else if (((cc_t) c == ctl->otty.c_cc[VERASE]) && !slash) {
 			if (sp > buf) {
 #ifdef HAVE_WIDECHAR
 				if (MB_CUR_MAX > 1) {
@@ -893,46 +914,46 @@ static void ttyin(char buf[], register int nmax, char pchar)
 					}
 
 					while (mblength--) {
-						--promptlen;
+						ctl->promptlen--;
 						--sp;
 					}
 				} else
 #endif	/* HAVE_WIDECHAR */
 				{
-					--promptlen;
+					ctl->promptlen--;
 					ERASEONECOLUMN-- sp;
 				}
 
 				if ((*sp < ' ' && *sp != '\n') || *sp == RUBOUT) {
-					--promptlen;
+					ctl->promptlen--;
 				ERASEONECOLUMN}
 				continue;
 			} else {
-				if (!eraseln)
-					promptlen = maxlen;
-				siglongjmp(restore, 1);
+				if (!ctl->eraseln)
+					ctl->promptlen = maxlen;
+				siglongjmp(ctl->restore, 1);
 			}
-		} else if (((cc_t) c == otty.c_cc[VKILL]) && !slash) {
-			if (hard) {
-				show(c);
+		} else if (((cc_t) c == ctl->otty.c_cc[VKILL]) && !slash) {
+			if (ctl->hard) {
+				show(ctl, c);
 				putchar('\n');
 				putchar(pchar);
 			} else {
 				putchar('\r');
 				putchar(pchar);
-				if (eraseln)
-					erasep(1);
-				else if (docrtkill)
-					while (promptlen-- > 1)
+				if (ctl->eraseln)
+					erasep(ctl, 1);
+				else if (ctl->docrtkill)
+					while (ctl->promptlen-- > 1)
 						putserr(BSB);
-				promptlen = 1;
+				ctl->promptlen = 1;
 			}
 			sp = buf;
 			fflush(stdout);
 			continue;
 		}
-		if (slash && ((cc_t) c == otty.c_cc[VKILL]
-			      || (cc_t) c == otty.c_cc[VERASE])) {
+		if (slash && ((cc_t) c == ctl->otty.c_cc[VKILL]
+			      || (cc_t) c == ctl->otty.c_cc[VERASE])) {
 			ERASEONECOLUMN-- sp;
 		}
 		if (c != '\\')
@@ -941,23 +962,23 @@ static void ttyin(char buf[], register int nmax, char pchar)
 		if ((c < ' ' && c != '\n' && c != ESC) || c == RUBOUT) {
 			c += (c == RUBOUT) ? -0100 : 0100;
 			putserr(CARAT);
-			promptlen++;
+			ctl->promptlen++;
 		}
 		if (c != '\n' && c != ESC) {
 			putcerr(c);
-			promptlen++;
+			ctl->promptlen++;
 		} else
 			break;
 	}
 	*--sp = '\0';
-	if (!eraseln)
-		promptlen = maxlen;
+	if (!ctl->eraseln)
+		ctl->promptlen = maxlen;
 	if (sp - buf >= nmax - 1)
-		more_error(_("Line too long"));
+		more_error(ctl, _("Line too long"));
 }
 
 /* return: 0 - unchanged, 1 - changed, -1 - overflow (unchanged) */
-static int expand(char **outbuf, char *inbuf)
+static int expand(struct more_control *ctl, char **outbuf, char *inbuf)
 {
 	char *inpstr;
 	char *outstr;
@@ -966,7 +987,7 @@ static int expand(char **outbuf, char *inbuf)
 	int changed = 0;
 	int tempsz, xtra, offset;
 
-	xtra = strlen(fnames[fnum]) + strlen(shell_line) + 1;
+	xtra = strlen(ctl->fnames[ctl->fnum]) + strlen(ctl->shell_line) + 1;
 	tempsz = 200 + xtra;
 	temp = xmalloc(tempsz);
 	inpstr = inbuf;
@@ -980,19 +1001,19 @@ static int expand(char **outbuf, char *inbuf)
 		}
 		switch (c) {
 		case '%':
-			if (!no_intty) {
-				strcpy(outstr, fnames[fnum]);
-				outstr += strlen(fnames[fnum]);
+			if (!ctl->no_intty) {
+				strcpy(outstr, ctl->fnames[ctl->fnum]);
+				outstr += strlen(ctl->fnames[ctl->fnum]);
 				changed++;
 			} else
 				*outstr++ = c;
 			break;
 		case '!':
-			if (!shellp)
-				more_error(_
+			if (!ctl->shellp)
+				more_error(ctl, _
 					   ("No previous command to substitute for"));
-			strcpy(outstr, shell_line);
-			outstr += strlen(shell_line);
+			strcpy(outstr, ctl->shell_line);
+			outstr += strlen(ctl->shell_line);
 			changed++;
 			break;
 		case '\\':
@@ -1009,28 +1030,28 @@ static int expand(char **outbuf, char *inbuf)
 	return (changed);
 }
 
-static void set_tty(void)
+static void set_tty(struct more_control *ctl)
 {
-	otty.c_lflag &= ~(ICANON | ECHO);
-	otty.c_cc[VMIN] = 1;	/* read at least 1 char */
-	otty.c_cc[VTIME] = 0;	/* no timeout */
-	stty(fileno(stderr), &otty);
+	ctl->otty.c_lflag &= ~(ICANON | ECHO);
+	ctl->otty.c_cc[VMIN] = 1;	/* read at least 1 char */
+	ctl->otty.c_cc[VTIME] = 0;	/* no timeout */
+	stty(fileno(stderr), &ctl->otty);
 }
 
 /* Come here if a quit signal is received */
 static void onquit(int dummy __attribute__((__unused__)))
 {
 	signal(SIGQUIT, SIG_IGN);
-	if (!inwait) {
+	if (!global_ctl->inwait) {
 		putchar('\n');
-		if (!startup) {
+		if (!global_ctl->startup) {
 			signal(SIGQUIT, onquit);
-			siglongjmp(restore, 1);
+			siglongjmp(global_ctl->restore, 1);
 		} else
-			Pause++;
-	} else if (!dum_opt && notell) {
-		promptlen += fprintf(stderr, _("[Use q or Q to quit]"));
-		notell = 0;
+			global_ctl->Pause = 1;
+	} else if (!global_ctl->dum_opt && global_ctl->notell) {
+		global_ctl->promptlen += fprintf(stderr, _("[Use q or Q to quit]"));
+		global_ctl->notell = 0;
 	}
 	signal(SIGQUIT, onquit);
 }
@@ -1042,7 +1063,7 @@ static void onsusp(int dummy __attribute__((__unused__)))
 
 	/* ignore SIGTTOU so we don't get stopped if csh grabs the tty */
 	signal(SIGTTOU, SIG_IGN);
-	reset_tty();
+	reset_tty(global_ctl);
 	fflush(stdout);
 	signal(SIGTTOU, SIG_DFL);
 	/* Send the TSTP signal to suspend our process group */
@@ -1060,12 +1081,12 @@ static void onsusp(int dummy __attribute__((__unused__)))
 
 	/* We're back */
 	signal(SIGTSTP, onsusp);
-	set_tty();
-	if (inwait)
-		siglongjmp(restore, 1);
+	set_tty(global_ctl);
+	if (global_ctl->inwait)
+		siglongjmp(global_ctl->restore, 1);
 }
 
-static void execute(char *filename, char *cmd, ...)
+static void execute(struct more_control *ctl, char *filename, char *cmd, ...)
 {
 	int id;
 	int n;
@@ -1075,7 +1096,7 @@ static void execute(char *filename, char *cmd, ...)
 	int argcount;
 
 	fflush(stdout);
-	reset_tty();
+	reset_tty(ctl);
 	for (n = 10; (id = fork()) < 0 && n > 0; n--)
 		sleep(5);
 	if (id == 0) {
@@ -1113,101 +1134,101 @@ static void execute(char *filename, char *cmd, ...)
 	if (id > 0) {
 		signal(SIGINT, SIG_IGN);
 		signal(SIGQUIT, SIG_IGN);
-		if (catch_susp)
+		if (ctl->catch_susp)
 			signal(SIGTSTP, SIG_DFL);
 		while (wait(0) > 0) ;
 		signal(SIGINT, end_it);
 		signal(SIGQUIT, onquit);
-		if (catch_susp)
+		if (ctl->catch_susp)
 			signal(SIGTSTP, onsusp);
 	} else
 		putserr(_("can't fork\n"));
-	set_tty();
+	set_tty(ctl);
 	puts("------------------------");
-	prompt(filename);
+	prompt(ctl, filename);
 }
 
-static void do_shell(char *filename)
+static void do_shell(struct more_control *ctl, char *filename)
 {
 	char cmdbuf[COMMAND_BUF];
 	int rc;
 	char *expanded;
 
-	kill_line();
+	kill_line(ctl);
 	putchar('!');
 	fflush(stdout);
-	promptlen = 1;
-	if (lastp)
-		putsout(shell_line);
+	ctl->promptlen = 1;
+	if (ctl->lastp)
+		putsout(ctl->shell_line);
 	else {
-		ttyin(cmdbuf, sizeof(cmdbuf) - 2, '!');
+		ttyin(ctl, cmdbuf, sizeof(cmdbuf) - 2, '!');
 		expanded = 0;
-		rc = expand(&expanded, cmdbuf);
+		rc = expand(ctl, &expanded, cmdbuf);
 		if (expanded) {
-			if (strlen(expanded) < sizeof(shell_line))
-				strcpy(shell_line, expanded);
+			if (strlen(expanded) < sizeof(ctl->shell_line))
+				strcpy(ctl->shell_line, expanded);
 			else
 				rc = -1;
 			free(expanded);
 		}
 		if (rc < 0) {
 			putserr(_("  Overflow\n"));
-			prompt(filename);
+			prompt(ctl, filename);
 			return;
 		} else if (rc > 0) {
-			kill_line();
-			promptlen = printf("!%s", shell_line);
+			kill_line(ctl);
+			ctl->promptlen = printf("!%s", ctl->shell_line);
 		}
 	}
 	fflush(stdout);
 	putcerr('\n');
-	promptlen = 0;
-	shellp = 1;
-	execute(filename, shell, shell, "-c", shell_line, 0);
+	ctl->promptlen = 0;
+	ctl->shellp = 1;
+	execute(ctl, filename, ctl->shell, ctl->shell, "-c", ctl->shell_line, 0);
 }
 
 /* Execute a colon-prefixed command.  Returns <0 if not a command that
  * should cause more of the file to be printed. */
-static int colon(char *filename, int cmd, int nlines)
+static int colon(struct more_control *ctl, char *filename, int cmd, int nlines)
 {
 	if (cmd == 0)
-		ch = readch();
+		ctl->ch = readch(ctl);
 	else
-		ch = cmd;
-	lastcolon = ch;
-	switch (ch) {
+		ctl->ch = cmd;
+	ctl->lastcolon = ctl->ch;
+	switch (ctl->ch) {
 	case 'f':
-		kill_line();
-		if (!no_intty)
-			promptlen =
-			    printf(_("\"%s\" line %d"), fnames[fnum], Currline);
+		kill_line(ctl);
+		if (!ctl->no_intty)
+			ctl->promptlen =
+			    printf(_("\"%s\" line %d"), ctl->fnames[ctl->fnum], ctl->Currline);
 		else
-			promptlen = printf(_("[Not a file] line %d"), Currline);
+			ctl->promptlen = printf(_("[Not a file] line %d"), ctl->Currline);
 		fflush(stdout);
 		return (-1);
 	case 'n':
 		if (nlines == 0) {
-			if (fnum >= nfiles - 1)
+			if (ctl->fnum >= ctl->nfiles - 1)
 				end_it(0);
 			nlines++;
 		}
 		putchar('\r');
-		erasep(0);
-		skipf(nlines);
+		erasep(ctl, 0);
+		skipf(ctl, nlines);
 		return (0);
 	case 'p':
-		if (no_intty) {
+		if (ctl->no_intty) {
 			ringbell();
 			return (-1);
 		}
 		putchar('\r');
-		erasep(0);
+		erasep(ctl, 0);
 		if (nlines == 0)
 			nlines++;
-		skipf(-nlines);
+		skipf(ctl, -nlines);
 		return (0);
 	case '!':
-		do_shell(filename);
+		do_shell(ctl, filename);
 		return (-1);
 	case 'q':
 	case 'Q':
@@ -1219,7 +1240,7 @@ static int colon(char *filename, int cmd, int nlines)
 }
 
 /* Skip n lines in the file f */
-static void skiplns(register int n, register FILE *f)
+static void skiplns(struct more_control *ctl, register int n, register FILE *f)
 {
 	register int c;
 
@@ -1228,47 +1249,47 @@ static void skiplns(register int n, register FILE *f)
 			if (c == EOF)
 				return;
 		n--;
-		Currline++;
+		ctl->Currline++;
 	}
 }
 
 /*  Clear the screen */
-static void doclear(void)
+static void doclear(struct more_control *ctl)
 {
-	if (Clear && !hard) {
-		my_putstring(Clear);
+	if (ctl->Clear && !ctl->hard) {
+		my_putstring(ctl->Clear);
 		/* Put out carriage return so that system doesn't get
 		 * confused by escape sequences when expanding tabs */
 		putchar('\r');
-		promptlen = 0;
+		ctl->promptlen = 0;
 	}
 }
 
-static void rdline(register FILE *f)
+static void rdline(struct more_control *ctl, register FILE *f)
 {
 	register int c;
 	register char *p;
 
-	prepare_line_buffer();
+	prepare_line_buffer(ctl);
 
-	p = Line;
+	p = ctl->Line;
 	while ((c = Getc(f)) != '\n' && c != EOF
-	       && (size_t)(p - Line) < LineLen - 1)
+	       && (size_t)(p - ctl->Line) < ctl->LineLen - 1)
 		*p++ = c;
 	if (c == '\n')
-		Currline++;
+		ctl->Currline++;
 	*p = '\0';
 }
 
 /* Go to home position */
-static void home(void)
+static void home(struct more_control *ctl)
 {
-	my_putstring(Home);
+	my_putstring(ctl->Home);
 }
 
 /* Search for nth occurrence of regular expression contained in buf in
  * the file */
-static void search(char buf[], FILE *file, register int n)
+static void search(struct more_control *ctl, char buf[], FILE *file, register int n)
 {
 	long startline = Ftell(file);
 	register long line1 = startline;
@@ -1278,51 +1299,51 @@ static void search(char buf[], FILE *file, register int n)
 	int saveln, rc;
 	regex_t re;
 
-	context.line = saveln = Currline;
-	context.chrctr = startline;
+	ctl->context.line = saveln = ctl->Currline;
+	ctl->context.chrctr = startline;
 	lncount = 0;
 	if (!buf)
 		goto notfound;
 	if ((rc = regcomp(&re, buf, REG_NOSUB)) != 0) {
 		char s[REGERR_BUF];
 		regerror(rc, &re, s, sizeof s);
-		more_error(s);
+		more_error(ctl, s);
 	}
 	while (!feof(file)) {
 		line3 = line2;
 		line2 = line1;
 		line1 = Ftell(file);
-		rdline(file);
+		rdline(ctl, file);
 		lncount++;
-		if (regexec(&re, Line, 0, NULL, 0) == 0) {
+		if (regexec(&re, ctl->Line, 0, NULL, 0) == 0) {
 			if (--n == 0) {
-				if (lncount > 3 || (lncount > 1 && no_intty)) {
+				if (lncount > 3 || (lncount > 1 && ctl->no_intty)) {
 					putchar('\n');
-					if (clreol)
-						cleareol();
+					if (ctl->clreol)
+						cleareol(ctl);
 					putsout(_("...skipping\n"));
 				}
-				if (!no_intty) {
-					Currline -=
+				if (!ctl->no_intty) {
+					ctl->Currline -=
 					    (lncount >= 3 ? 3 : lncount);
 					Fseek(file, line3);
-					if (noscroll) {
-						if (clreol) {
-							home();
-							cleareol();
+					if (ctl->noscroll) {
+						if (ctl->clreol) {
+							home(ctl);
+							cleareol(ctl);
 						} else
-							doclear();
+							doclear(ctl);
 					}
 				} else {
-					kill_line();
-					if (noscroll) {
-						if (clreol) {
-							home();
-							cleareol();
+					kill_line(ctl);
+					if (ctl->noscroll) {
+						if (ctl->clreol) {
+							home(ctl);
+							cleareol(ctl);
 						} else
-							doclear();
+							doclear(ctl);
 					}
-					puts(Line);
+					puts(ctl->Line);
 				}
 				break;
 			}
@@ -1330,17 +1351,17 @@ static void search(char buf[], FILE *file, register int n)
 	}
 	regfree(&re);
 	if (feof(file)) {
-		if (!no_intty) {
-			Currline = saveln;
+		if (!ctl->no_intty) {
+			ctl->Currline = saveln;
 			Fseek(file, startline);
 		} else {
 			putsout(_("\nPattern not found\n"));
 			end_it(0);
 		}
-		free(previousre);
-		previousre = NULL;
+		free(ctl->previousre);
+		ctl->previousre = NULL;
 notfound:
-		more_error(_("Pattern not found"));
+		more_error(ctl, _("Pattern not found"));
 	}
 }
 
@@ -1348,7 +1369,7 @@ notfound:
  * argument followed by the command character.  Return the number of
  * lines to display in the next screenful.  If there is nothing more to
  * display in the current file, zero is returned. */
-static int command(char *filename, register FILE *f)
+static int command(struct more_control *ctl, char *filename, register FILE *f)
 {
 	register int nlines;
 	register int retval = 0;
@@ -1360,30 +1381,30 @@ static int command(char *filename, register FILE *f)
 #define ret(val) retval=val;done++;break
 
 	done = 0;
-	if (!errors)
-		prompt(filename);
+	if (!ctl->errors)
+		prompt(ctl, filename);
 	else
-		errors = 0;
+		ctl->errors = 0;
 	for (;;) {
-		nlines = number(&comchar);
-		lastp = colonch = 0;
+		nlines = number(ctl, &comchar);
+		ctl->lastp = colonch = 0;
 		if (comchar == '.') {	/* Repeat last command */
-			lastp++;
-			comchar = lastcmd;
-			nlines = lastarg;
-			if (lastcmd == ':')
-				colonch = lastcolon;
+			ctl->lastp++;
+			comchar = ctl->lastcmd;
+			nlines = ctl->lastarg;
+			if (ctl->lastcmd == ':')
+				colonch = ctl->lastcolon;
 		}
-		lastcmd = comchar;
-		lastarg = nlines;
-		if ((cc_t) comchar == otty.c_cc[VERASE]) {
-			kill_line();
-			prompt(filename);
+		ctl->lastcmd = comchar;
+		ctl->lastarg = nlines;
+		if ((cc_t) comchar == ctl->otty.c_cc[VERASE]) {
+			kill_line(ctl);
+			prompt(ctl, filename);
 			continue;
 		}
 		switch (comchar) {
 		case ':':
-			retval = colon(filename, colonch, nlines);
+			retval = colon(ctl, filename, colonch, nlines);
 			if (retval >= 0)
 				done++;
 			break;
@@ -1392,7 +1413,7 @@ static int command(char *filename, register FILE *f)
 			{
 				register int initline;
 
-				if (no_intty) {
+				if (ctl->no_intty) {
 					ringbell();
 					return (-1);
 				}
@@ -1401,43 +1422,43 @@ static int command(char *filename, register FILE *f)
 					nlines++;
 
 				putchar('\r');
-				erasep(0);
+				erasep(ctl, 0);
 				putchar('\n');
-				if (clreol)
-					cleareol();
+				if (ctl->clreol)
+					cleareol(ctl);
 				printf(P_("...back %d page",
 					"...back %d pages", nlines),
 					nlines);
-				if (clreol)
-					cleareol();
+				if (ctl->clreol)
+					cleareol(ctl);
 				putchar('\n');
 
-				initline = Currline - dlines * (nlines + 1);
-				if (!noscroll)
+				initline = ctl->Currline - ctl->dlines * (nlines + 1);
+				if (!ctl->noscroll)
 					--initline;
 				if (initline < 0)
 					initline = 0;
 				Fseek(f, 0L);
-				Currline = 0;	/* skiplns() will make Currline correct */
-				skiplns(initline, f);
-				if (!noscroll) {
-					ret(dlines + 1);
+				ctl->Currline = 0;	/* skiplns() will make Currline correct */
+				skiplns(ctl, initline, f);
+				if (!ctl->noscroll) {
+					ret(ctl->dlines + 1);
 				} else {
-					ret(dlines);
+					ret(ctl->dlines);
 				}
 			}
 		case ' ':
 		case 'z':
 			if (nlines == 0)
-				nlines = dlines;
+				nlines = ctl->dlines;
 			else if (comchar == 'z')
-				dlines = nlines;
+				ctl->dlines = nlines;
 			ret(nlines);
 		case 'd':
 		case ctrl('D'):
 			if (nlines != 0)
-				nscroll = nlines;
-			ret(nscroll);
+				ctl->nscroll = nlines;
+			ret(ctl->nscroll);
 		case 'q':
 		case 'Q':
 			end_it(0);
@@ -1447,18 +1468,18 @@ static int command(char *filename, register FILE *f)
 			if (nlines == 0)
 				nlines++;
 			if (comchar == 'f')
-				nlines *= dlines;
+				nlines *= ctl->dlines;
 			putchar('\r');
-			erasep(0);
+			erasep(ctl, 0);
 			putchar('\n');
-			if (clreol)
-				cleareol();
+			if (ctl->clreol)
+				cleareol(ctl);
 			printf(P_("...skipping %d line",
 				"...skipping %d lines", nlines),
 				nlines);
 
-			if (clreol)
-				cleareol();
+			if (ctl->clreol)
+				cleareol(ctl);
 			putchar('\n');
 
 			while (nlines > 0) {
@@ -1468,74 +1489,74 @@ static int command(char *filename, register FILE *f)
 						done++;
 						goto endsw;
 					}
-				Currline++;
+				ctl->Currline++;
 				nlines--;
 			}
-			ret(dlines);
+			ret(ctl->dlines);
 		case '\n':
 			if (nlines != 0)
-				dlines = nlines;
+				ctl->dlines = nlines;
 			else
 				nlines = 1;
 			ret(nlines);
 		case '\f':
-			if (!no_intty) {
-				doclear();
-				Fseek(f, screen_start.chrctr);
-				Currline = screen_start.line;
-				ret(dlines);
+			if (!ctl->no_intty) {
+				doclear(ctl);
+				Fseek(f, ctl->screen_start.chrctr);
+				ctl->Currline = ctl->screen_start.line;
+				ret(ctl->dlines);
 			} else {
 				ringbell();
 				break;
 			}
 		case '\'':
-			if (!no_intty) {
-				kill_line();
+			if (!ctl->no_intty) {
+				kill_line(ctl);
 				putsout(_("\n***Back***\n\n"));
-				Fseek(f, context.chrctr);
-				Currline = context.line;
-				ret(dlines);
+				Fseek(f, ctl->context.chrctr);
+				ctl->Currline = ctl->context.line;
+				ret(lines);
 			} else {
 				ringbell();
 				break;
 			}
 		case '=':
-			kill_line();
-			promptlen = printf("%d", Currline);
+			kill_line(ctl);
+			ctl->promptlen = printf("%d", ctl->Currline);
 			fflush(stdout);
 			break;
 		case 'n':
-			if (!previousre) {
-				more_error(_("No previous regular expression"));
+			if (!ctl->previousre) {
+				more_error(ctl, _("No previous regular expression"));
 				break;
 			}
-			lastp++;
+			ctl->lastp = 1;
 			/* fall through */
 		case '/':
 			if (nlines == 0)
 				nlines++;
-			kill_line();
+			kill_line(ctl);
 			putchar('/');
-			promptlen = 1;
+			ctl->promptlen = 1;
 			fflush(stdout);
-			if (lastp) {
+			if (ctl->lastp) {
 				putcerr('\r');
-				search(previousre, f, nlines);
+				search(ctl, ctl->previousre, f, nlines);
 			} else {
-				ttyin(cmdbuf, sizeof(cmdbuf) - 2, '/');
+				ttyin(ctl, cmdbuf, sizeof(cmdbuf) - 2, '/');
 				putcerr('\r');
-				free(previousre);
-				previousre = xstrdup(cmdbuf);
-				search(cmdbuf, f, nlines);
+				free(ctl->previousre);
+				ctl->previousre = xstrdup(cmdbuf);
+				search(ctl, cmdbuf, f, nlines);
 			}
-			ret(dlines - 1);
+			ret(ctl->dlines - 1);
 		case '!':
-			do_shell(filename);
+			do_shell(ctl, filename);
 			break;
 		case '?':
 		case 'h':
-			if (noscroll)
-				doclear();
+			if (ctl->noscroll)
+				doclear(ctl);
 			putsout(_("\n"
 				  "Most commands optionally preceded by integer argument k.  "
 				  "Defaults in brackets.\n"
@@ -1564,16 +1585,16 @@ static int command(char *filename, register FILE *f)
 				 ".                       Repeat previous command\n"));
 			puts("---------------------------------------"
 			     "----------------------------------------");
-			prompt(filename);
+			prompt(ctl, filename);
 			break;
 		case 'v':	/* This case should go right before default */
-			if (!no_intty) {
+			if (!ctl->no_intty) {
 				/* Earlier: call vi +n file. This also
 				 * works for emacs.  POSIX: call vi -c n
 				 * file (when editor is vi or ex). */
 				char *editor, *p;
-				int n = (Currline - dlines <= 0 ? 1 :
-					 Currline - (dlines + 1) / 2);
+				int n = (ctl->Currline - ctl->dlines <= 0 ? 1 :
+					 ctl->Currline - (ctl->dlines + 1) / 2);
 				int split = 0;
 
 				editor = getenv("VISUAL");
@@ -1594,33 +1615,33 @@ static int command(char *filename, register FILE *f)
 					sprintf(cmdbuf, "+%d", n);
 				}
 
-				kill_line();
+				kill_line(ctl);
 				printf("%s %s %s", editor, cmdbuf,
-				       fnames[fnum]);
+				       ctl->fnames[ctl->fnum]);
 				if (split) {
 					cmdbuf[2] = 0;
-					execute(filename, editor, editor,
+					execute(ctl, filename, editor, editor,
 						cmdbuf, cmdbuf + 3,
-						fnames[fnum], (char *)0);
+						ctl->fnames[ctl->fnum], (char *)0);
 				} else
-					execute(filename, editor, editor,
-						cmdbuf, fnames[fnum],
+					execute(ctl, filename, editor, editor,
+						cmdbuf, ctl->fnames[ctl->fnum],
 						(char *)0);
 				break;
 			}
 			/* fall through */
 		default:
-			if (dum_opt) {
-				kill_line();
-				if (Senter && Sexit) {
-					my_putstring(Senter);
-					promptlen =
+			if (ctl->dum_opt) {
+				kill_line(ctl);
+				if (ctl->Senter && ctl->Sexit) {
+					my_putstring(ctl->Senter);
+					ctl->promptlen =
 					    printf(_
 						   ("[Press 'h' for instructions.]"))
-					    + 2 * soglitch;
-					my_putstring(Sexit);
+					    + 2 * ctl->soglitch;
+					my_putstring(ctl->Sexit);
 				} else
-					promptlen =
+					ctl->promptlen =
 					    printf(_
 						   ("[Press 'h' for instructions.]"));
 				fflush(stdout);
@@ -1633,13 +1654,13 @@ static int command(char *filename, register FILE *f)
 	}
 	putchar('\r');
  endsw:
-	inwait = 0;
-	notell++;
+	ctl->inwait = 0;
+	ctl->notell = 1;
 	return (retval);
 }
 
 /* Print out the contents of the file f, one screenful at a time. */
-static void screen(register FILE *f, register int num_lines)
+static void screen(struct more_control *ctl, register FILE *f, register int num_lines)
 {
 	register int c;
 	register int nchars;
@@ -1647,67 +1668,67 @@ static void screen(register FILE *f, register int num_lines)
 	static int prev_len = 1;	/* length of previous line */
 
 	for (;;) {
-		while (num_lines > 0 && !Pause) {
-			if ((nchars = get_line(f, &length)) == EOF) {
-				if (clreol)
-					clreos();
+		while (num_lines > 0 && !ctl->Pause) {
+			if ((nchars = get_line(ctl, f, &length)) == EOF) {
+				if (ctl->clreol)
+					clreos(ctl);
 				return;
 			}
-			if (ssp_opt && length == 0 && prev_len == 0)
+			if (ctl->ssp_opt && length == 0 && prev_len == 0)
 				continue;
 			prev_len = length;
-			if (bad_so
-			    || ((Senter && *Senter == ' ') && (promptlen > 0)))
-				erasep(0);
+			if (ctl->bad_so
+			    || ((ctl->Senter && *ctl->Senter == ' ') && (ctl->promptlen > 0)))
+				erasep(ctl, 0);
 			/* must clear before drawing line since tabs on
 			 * some terminals do not erase what they tab
 			 * over. */
-			if (clreol)
-				cleareol();
-			prbuf(Line, length);
-			if (nchars < promptlen)
-				erasep(nchars);	/* erasep () sets promptlen to 0 */
+			if (ctl->clreol)
+				cleareol(ctl);
+			prbuf(ctl, ctl->Line, length);
+			if (nchars < ctl->promptlen)
+				erasep(ctl, nchars);	/* erasep () sets promptlen to 0 */
 			else
-				promptlen = 0;
+				ctl->promptlen = 0;
 			/* is this needed?
 			 * if (clreol)
 			 *	cleareol();     * must clear again in case we wrapped *
 			 */
-			if (nchars < Mcol || !fold_opt)
-				prbuf("\n", 1);	/* will turn off UL if necessary */
+			if (nchars < ctl->Mcol || !ctl->fold_opt)
+				prbuf(ctl, "\n", 1);	/* will turn off UL if necessary */
 			if (nchars == STOP)
 				break;
 			num_lines--;
 		}
-		if (pstate) {
-			my_putstring(ULexit);
-			pstate = 0;
+		if (ctl->pstate) {
+			my_putstring(ctl->ULexit);
+			ctl->pstate = 0;
 		}
 		fflush(stdout);
 		if ((c = Getc(f)) == EOF) {
-			if (clreol)
-				clreos();
+			if (ctl->clreol)
+				clreos(ctl);
 			return;
 		}
 
-		if (Pause && clreol)
-			clreos();
+		if (ctl->Pause && ctl->clreol)
+			clreos(ctl);
 		Ungetc(c, f);
-		sigsetjmp(restore, 1);
-		Pause = 0;
-		startup = 0;
-		if ((num_lines = command(NULL, f)) == 0)
+		sigsetjmp(ctl->restore, 1);
+		ctl->Pause = 0;
+		ctl->startup = 0;
+		if ((num_lines = command(ctl, NULL, f)) == 0)
 			return;
-		if (hard && promptlen > 0)
-			erasep(0);
-		if (noscroll && num_lines >= dlines) {
-			if (clreol)
-				home();
+		if (ctl->hard && ctl->promptlen > 0)
+			erasep(ctl, 0);
+		if (ctl->noscroll && num_lines >= ctl->dlines) {
+			if (ctl->clreol)
+				home(ctl);
 			else
-				doclear();
+				doclear(ctl);
 		}
-		screen_start.line = Currline;
-		screen_start.chrctr = Ftell(f);
+		ctl->screen_start.line = ctl->Currline;
+		ctl->screen_start.chrctr = Ftell(f);
 	}
 }
 
@@ -1720,14 +1741,14 @@ static void chgwinsz(int dummy __attribute__((__unused__)))
 	signal(SIGWINCH, SIG_IGN);
 	if (ioctl(fileno(stdout), TIOCGWINSZ, &win) != -1) {
 		if (win.ws_row != 0) {
-			Lpp = win.ws_row;
-			nscroll = Lpp / 2 - 1;
-			if (nscroll <= 0)
-				nscroll = 1;
-			dlines = Lpp - 1;	/* was: Lpp - (noscroll ? 1 : 2) */
+			global_ctl->Lpp = win.ws_row;
+			global_ctl->nscroll = global_ctl->Lpp / 2 - 1;
+			if (global_ctl->nscroll <= 0)
+				global_ctl->nscroll = 1;
+			global_ctl->dlines = global_ctl->Lpp - 1;	/* was: Lpp - (noscroll ? 1 : 2) */
 		}
 		if (win.ws_col != 0)
-			Mcol = win.ws_col;
+			global_ctl->Mcol = win.ws_col;
 	}
 	signal(SIGWINCH, chgwinsz);
 }
@@ -1743,9 +1764,9 @@ static void copy_file(register FILE *f)
 }
 
 /*----------------------------- Terminal I/O -------------------------------*/
-static void initterm(void)
+static void initterm(struct more_control *ctl)
 {
-	int ret;
+	int ret, tmp;
 	char *padstr;
 	char *term;
 	struct winsize win;
@@ -1755,11 +1776,11 @@ static void initterm(void)
 #endif
 
 #ifndef NON_INTERACTIVE_MORE
-	no_tty = tcgetattr(fileno(stdout), &otty);
+	ctl->no_tty = tcgetattr(fileno(stdout), &ctl->otty);
 #endif
-	if (!no_tty) {
-		docrterase = (otty.c_cc[VERASE] != 255);
-		docrtkill = (otty.c_cc[VKILL] != 255);
+	if (!ctl->no_tty) {
+		ctl->docrterase = (ctl->otty.c_cc[VERASE] != 255);
+		ctl->docrtkill = (ctl->otty.c_cc[VKILL] != 255);
 #ifdef do_SIGTTOU
 		{
 			int tgrp;
@@ -1774,46 +1795,49 @@ static void initterm(void)
 		}
 #endif	/* do_SIGTTOU */
 		if ((term = getenv("TERM")) == NULL) {
-			dumb++;
-			ul_opt = 0;
+			ctl->dumb = 1;
+			ctl->ul_opt = 0;
 		}
 		my_setupterm(term, 1, &ret);
 		if (ret <= 0) {
-			dumb++;
-			ul_opt = 0;
+			ctl->dumb = 1;
+			ctl->ul_opt = 0;
 		} else {
 #ifdef TIOCGWINSZ
 			if (ioctl(fileno(stdout), TIOCGWINSZ, &win) < 0) {
 #endif
-				Lpp = my_tgetnum(TERM_LINES);
-				Mcol = my_tgetnum(TERM_COLS);
+				ctl->Lpp = my_tgetnum(TERM_LINES);
+				ctl->Mcol = my_tgetnum(TERM_COLS);
 #ifdef TIOCGWINSZ
 			} else {
-				if ((Lpp = win.ws_row) == 0)
-					Lpp = my_tgetnum(TERM_LINES);
-				if ((Mcol = win.ws_col) == 0)
-					Mcol = my_tgetnum(TERM_COLS);
+				if ((ctl->Lpp = win.ws_row) == 0)
+					ctl->Lpp = my_tgetnum(TERM_LINES);
+				if ((ctl->Mcol = win.ws_col) == 0)
+					ctl->Mcol = my_tgetnum(TERM_COLS);
 			}
 #endif
-			if ((Lpp <= 0) || my_tgetflag(TERM_HARD_COPY)) {
-				hard++;	/* Hard copy terminal */
-				Lpp = LINES_PER_PAGE;
+			if ((ctl->Lpp <= 0) || my_tgetflag(TERM_HARD_COPY)) {
+				ctl->hard = 1;	/* Hard copy terminal */
+				ctl->Lpp = LINES_PER_PAGE;
 			}
 
 			if (my_tgetflag(TERM_EAT_NEW_LINE))
 				/* Eat newline at last column + 1; dec, concept */
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
+				ctl->eatnl = 1;
+			if (ctl->Mcol <= 0)
+				ctl->Mcol = NUM_COLUMNS;
+
+			ctl->Wrap = my_tgetflag(TERM_AUTO_RIGHT_MARGIN);
+			ctl->bad_so = my_tgetflag(TERM_CEOL);
+			ctl->eraseln = my_tgetstr(TERM_CLEAR_TO_LINE_END);
+			ctl->Clear = my_tgetstr(TERM_CLEAR);
+			ctl->Senter = my_tgetstr(TERM_STANDARD_MODE);
+			ctl->Sexit = my_tgetstr(TERM_EXIT_STANDARD_MODE);
+			tmp = my_tgetnum(TERM_STD_MODE_GLITCH);
+			if (tmp < 0)
+				ctl->soglitch = 0;
+			else if (0 < tmp)
+				ctl->soglitch = 1;
 
 			/* Set up for underlining:  some terminals don't
 			 * need it; others have start/stop sequences,
@@ -1823,55 +1847,55 @@ static void initterm(void)
 			 * available, settle for standout sequence. */
 			if (my_tgetflag(TERM_UNDERLINE)
 			    || my_tgetflag(TERM_OVER_STRIKE))
-				ul_opt = 0;
-			if ((chUL = my_tgetstr(TERM_UNDERLINE_CHAR)) == NULL)
-				chUL = "";
-			if (((ULenter =
+				ctl->ul_opt = 0;
+			if ((ctl->chUL = my_tgetstr(TERM_UNDERLINE_CHAR)) == NULL)
+				ctl->chUL = "";
+			if (((ctl->ULenter =
 			      my_tgetstr(TERM_ENTER_UNDERLINE)) == NULL
-			     || (ULexit =
+			     || (ctl->ULexit =
 				 my_tgetstr(TERM_EXIT_UNDERLINE)) == NULL)
-			    && !*chUL) {
-				if ((ULenter = Senter) == NULL
-				    || (ULexit = Sexit) == NULL) {
-					ULenter = "";
-					ULexit = "";
+			    && !*ctl->chUL) {
+				if ((ctl->ULenter = ctl->Senter) == NULL
+				    || (ctl->ULexit = ctl->Sexit) == NULL) {
+					ctl->ULenter = "";
+					ctl->ULexit = "";
 				} else
-					ulglitch = soglitch;
+					ctl->ulglitch = ctl->soglitch;
 			} else {
-				ulglitch = 0;
+				ctl->ulglitch = 0;
 			}
 
 			if ((padstr = my_tgetstr(TERM_PAD_CHAR)) != NULL)
-				PC = *padstr;
-			Home = my_tgetstr(TERM_HOME);
-			if (Home == NULL || *Home == '\0') {
-				if ((cursorm =
+				ctl->PC = *padstr;
+			ctl->Home = my_tgetstr(TERM_HOME);
+			if (ctl->Home == NULL || *ctl->Home == '\0') {
+				if ((ctl->cursorm =
 				     my_tgetstr(TERM_CURSOR_ADDRESS)) != NULL) {
 					const char *t =
-					    (const char *)my_tgoto(cursorm, 0,
+					    (const char *)my_tgoto(ctl->cursorm, 0,
 								   0);
-					xstrncpy(cursorhome, t,
-						 sizeof(cursorhome));
-					Home = cursorhome;
+					xstrncpy(ctl->cursorhome, t,
+						 sizeof(ctl->cursorhome));
+					ctl->Home = ctl->cursorhome;
 				}
 			}
-			EodClr = my_tgetstr(TERM_CLEAR_TO_SCREEN_END);
-			if ((chBS = my_tgetstr(TERM_LINE_DOWN)) == NULL)
-				chBS = "\b";
+			ctl->EodClr = my_tgetstr(TERM_CLEAR_TO_SCREEN_END);
+			if ((ctl->chBS = my_tgetstr(TERM_LINE_DOWN)) == NULL)
+				ctl->chBS = "\b";
 
 		}
-		if ((shell = getenv("SHELL")) == NULL)
-			shell = "/bin/sh";
+		if ((ctl->shell = getenv("SHELL")) == NULL)
+			ctl->shell = "/bin/sh";
 	}
-	no_intty = tcgetattr(fileno(stdin), &otty);
-	tcgetattr(fileno(stderr), &otty);
-	savetty0 = otty;
-	slow_tty = cfgetispeed(&otty) < B1200;
-	hardtabs = (otty.c_oflag & TABDLY) != XTABS;
-	if (!no_tty) {
-		otty.c_lflag &= ~(ICANON | ECHO);
-		otty.c_cc[VMIN] = 1;
-		otty.c_cc[VTIME] = 0;
+	ctl->no_intty = tcgetattr(fileno(stdin), &ctl->otty);
+	tcgetattr(fileno(stderr), &ctl->otty);
+	ctl->savetty0 = ctl->otty;
+	ctl->slow_tty = cfgetispeed(&ctl->otty) < B1200 ? 1 : 0;
+	ctl->hardtabs = (ctl->otty.c_oflag & TABDLY) != XTABS;
+	if (!ctl->no_tty) {
+		ctl->otty.c_lflag &= ~(ICANON | ECHO);
+		ctl->otty.c_cc[VMIN] = 1;
+		ctl->otty.c_cc[VTIME] = 0;
 	}
 }
 
@@ -1887,35 +1911,49 @@ int main(int argc, char **argv)
 	int clearit = 0;
 	int initline = 0;
 	char *initbuf = NULL;
+	struct more_control ctl = {
+		.firstf = 1,
+		.fold_opt = 1,
+		.notell = 1,
+		.startup = 1,
+		.stop_opt = 1,
+		.ul_opt = 1,
+		.Wrap = 1,
+		.Lpp = LINES_PER_PAGE,
+		.Mcol = NUM_COLUMNS,
+		.nscroll = SCROLL_LEN,
+		0
+	};
+	global_ctl = &ctl;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	nfiles = argc;
-	fnames = argv;
+	ctl.nfiles = argc;
+	ctl.fnames = argv;
 	setlocale(LC_ALL, "");
-	initterm();
+	initterm(&ctl);
 
 	/* Auto set no scroll on when binary is called page */
 	if (!(strcmp(program_invocation_short_name, "page")))
-		noscroll++;
+		ctl.noscroll = 1;
 
-	prepare_line_buffer();
+	prepare_line_buffer(&ctl);
 
-	nscroll = Lpp / 2 - 1;
-	if (nscroll <= 0)
-		nscroll = 1;
+	ctl.nscroll = ctl.Lpp / 2 - 1;
+	if (ctl.nscroll <= 0)
+		ctl.nscroll = 1;
 
 	if ((s = getenv("MORE")) != NULL)
-		argscan(s);
+		argscan(&ctl, s);
 
-	while (--nfiles > 0) {
-		if ((c = (*++fnames)[0]) == '-') {
-			argscan(*fnames + 1);
+	while (--ctl.nfiles > 0) {
+		if ((c = (*++ctl.fnames)[0]) == '-') {
+			argscan(&ctl, *ctl.fnames + 1);
 		} else if (c == '+') {
-			s = *fnames;
+			s = *ctl.fnames;
 			if (*++s == '/') {
 				srchopt++;
 				initbuf = xstrdup(s + 1);
@@ -1932,24 +1970,24 @@ int main(int argc, char **argv)
 	}
 	/* allow clreol only if Home and eraseln and EodClr strings are
 	 * defined, and in that case, make sure we are in noscroll mode */
-	if (clreol) {
-		if ((Home == NULL) || (*Home == '\0') ||
-		    (eraseln == NULL) || (*eraseln == '\0') ||
-		    (EodClr == NULL) || (*EodClr == '\0'))
-			clreol = 0;
+	if (ctl.clreol) {
+		if ((ctl.Home == NULL) || (*ctl.Home == '\0') ||
+		    (ctl.eraseln == NULL) || (*ctl.eraseln == '\0') ||
+		    (ctl.EodClr == NULL) || (*ctl.EodClr == '\0'))
+			ctl.clreol = 0;
 		else
-			noscroll = 1;
+			ctl.noscroll = 1;
 	}
-	if (dlines == 0)
-		dlines = Lpp - 1;	/* was: Lpp - (noscroll ? 1 : 2) */
-	left = dlines;
-	if (nfiles > 1)
+	if (ctl.dlines == 0)
+		ctl.dlines = ctl.Lpp - 1;	/* was: Lpp - (noscroll ? 1 : 2) */
+	left = ctl.dlines;
+	if (ctl.nfiles > 1)
 		prnames++;
-	if (!no_intty && nfiles == 0)
+	if (!ctl.no_intty && ctl.nfiles == 0)
 		usage(stderr);
 	else
 		f = stdin;
-	if (!no_tty) {
+	if (!ctl.no_tty) {
 		signal(SIGQUIT, onquit);
 		signal(SIGINT, end_it);
 #ifdef SIGWINCH
@@ -1957,106 +1995,108 @@ int main(int argc, char **argv)
 #endif
 		if (signal(SIGTSTP, SIG_IGN) == SIG_DFL) {
 			signal(SIGTSTP, onsusp);
-			catch_susp++;
+			ctl.catch_susp = 1;
 		}
-		stty(fileno(stderr), &otty);
+		stty(fileno(stderr), &ctl.otty);
 	}
-	if (no_intty) {
-		if (no_tty)
+	if (ctl.no_intty) {
+		if (ctl.no_tty)
 			copy_file(stdin);
 		else {
-			if ((c = Getc(f)) == '\f')
-				doclear();
+			ctl.file_pos++;
+			if ((c = getc(f)) == '\f')
+				doclear(&ctl);
 			else {
-				Ungetc(c, f);
-				if (noscroll && (c != EOF)) {
-					if (clreol)
-						home();
+				ctl.file_pos--;
+				ungetc(c, f);
+				if (ctl.noscroll && (c != EOF)) {
+					if (ctl.clreol)
+						home(&ctl);
 					else
-						doclear();
+						doclear(&ctl);
 				}
 			}
 			if (srchopt) {
-				free(previousre);
-				previousre = xstrdup(initbuf);
-				search(initbuf, stdin, 1);
-				if (noscroll)
+				free(ctl.previousre);
+				ctl.previousre = xstrdup(initbuf);
+				search(&ctl, initbuf, stdin, 1);
+				if (ctl.noscroll)
 					left--;
 			} else if (initopt)
-				skiplns(initline, stdin);
-			screen(stdin, left);
+				skiplns(&ctl, initline, stdin);
+			screen(&ctl, stdin, left);
 		}
-		no_intty = 0;
+		ctl.no_intty = 0;
 		prnames++;
-		firstf = 0;
+		ctl.firstf = 0;
 	}
 
-	while (fnum < nfiles) {
-		if ((f = checkf(fnames[fnum], &clearit)) != NULL) {
-			context.line = context.chrctr = 0;
-			Currline = 0;
-			if (firstf)
-				sigsetjmp(restore, 1);
-			if (firstf) {
-				firstf = 0;
+	while (ctl.fnum < ctl.nfiles) {
+		if ((f = checkf(&ctl, ctl.fnames[ctl.fnum], &clearit)) != NULL) {
+			ctl.context.line = ctl.context.chrctr = 0;
+			ctl.Currline = 0;
+			if (ctl.firstf)
+				sigsetjmp(ctl.restore, 1);
+			if (ctl.firstf) {
+				ctl.firstf = 0;
 				if (srchopt) {
-					free(previousre);
-					previousre = xstrdup(initbuf);
-					search(initbuf, f, 1);
-					if (noscroll)
+					free(ctl.previousre);
+					ctl.previousre = xstrdup(initbuf);
+					search(&ctl, initbuf, f, 1);
+					if (ctl.noscroll)
 						left--;
 				} else if (initopt)
-					skiplns(initline, f);
-			} else if (fnum < nfiles && !no_tty) {
-				sigsetjmp(restore, 1);
-				left = command(fnames[fnum], f);
+					skiplns(&ctl, initline, f);
+			} else if (ctl.fnum < ctl.nfiles && !ctl.no_tty) {
+				sigsetjmp(ctl.restore, 1);
+				left = command(&ctl, ctl.fnames[ctl.fnum], f);
 			}
 			if (left != 0) {
-				if ((noscroll || clearit)
-				    && (file_size != LONG_MAX)) {
-					if (clreol)
-						home();
+				if ((ctl.noscroll || clearit)
+				    && (ctl.file_size != LONG_MAX)) {
+					if (ctl.clreol)
+						home(&ctl);
 					else
-						doclear();
+						doclear(&ctl);
 				}
 				if (prnames) {
-					if (bad_so)
-						erasep(0);
-					if (clreol)
-						cleareol();
+					if (ctl.bad_so)
+						erasep(&ctl, 0);
+					if (ctl.clreol)
+						cleareol(&ctl);
 					putsout("::::::::::::::");
-					if (promptlen > 14)
-						erasep(14);
+					if (ctl.promptlen > 14)
+						erasep(&ctl, 14);
 					putchar('\n');
-					if (clreol)
-						cleareol();
-					puts(fnames[fnum]);
-					if (clreol)
-						cleareol();
+					if (ctl.clreol)
+						cleareol(&ctl);
+					puts(ctl.fnames[ctl.fnum]);
+					if (ctl.clreol)
+						cleareol(&ctl);
 					puts("::::::::::::::");
-					if (left > Lpp - 4)
-						left = Lpp - 4;
+					if (left > ctl.Lpp - 4)
+						left = ctl.Lpp - 4;
 				}
-				if (no_tty)
+				if (ctl.no_tty)
 					copy_file(f);
 				else {
-					within++;
-					screen(f, left);
-					within = 0;
+					ctl.within = 1;
+					screen(&ctl, f, left);
+					ctl.within = 0;
 				}
 			}
-			sigsetjmp(restore, 1);
+			sigsetjmp(ctl.restore, 1);
 			fflush(stdout);
 			fclose(f);
-			screen_start.line = screen_start.chrctr = 0L;
-			context.line = context.chrctr = 0L;
+			ctl.screen_start.line = ctl.screen_start.chrctr = 0L;
+			ctl.context.line = ctl.context.chrctr = 0L;
 		}
-		fnum++;
-		firstf = 0;
+		ctl.fnum++;
+		ctl.firstf = 0;
 	}
-	free(previousre);
+	free(ctl.previousre);
 	free(initbuf);
-	free(Line);
-	reset_tty();
+	free(ctl.Line);
+	reset_tty(&ctl);
 	exit(EXIT_SUCCESS);
 }
-- 
2.3.0

