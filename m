Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:47952 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbbBVOog (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:36 -0500
Received: by mail-wi0-f179.google.com with SMTP id hi2so11715547wib.0
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:35 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 23/31] more: rename variable and function names easier to understand
Date: Sun, 22 Feb 2015 14:43:19 +0000
Message-Id: <1424616207-747-24-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 714 +++++++++++++++++++++++++++---------------------------
 1 file changed, 357 insertions(+), 357 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index e9c123c..15fd3a0 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -106,39 +106,39 @@
 
 struct more_control {
 	struct termios otty;		/* output terminal */
-	struct termios savetty0;	/* original terminal settings */
+	struct termios orig_tty;	/* original terminal settings */
 	long file_pos;			/* file position */
 	long file_size;			/* file size */
-	int fnum;			/* position in argv[] */
+	int argv_position;		/* position in argv[] */
 	int nscroll;			/* number of lines scrolled by 'd' */
-	int dlines;			/* screen size in lines */
+	int lines_per_screen;		/* screen size in lines */
 	int promptlen;			/* message prompt length */
 	int jumpline;			/* line number to jump */
-	int Currline;			/* line we are currently at */
+	int current_line;		/* line we are currently at */
 	char **fnames;			/* the list of file names */
 	int nfiles;			/* number of files left to process */
 	char *shell;			/* the name of the shell to use */
 	int shellp;			/* does previous shell command exists */
 	int sigfd;			/* signalfd() file descriptor */
-	char *Line;			/* line buffer */
-	size_t LineLen;			/* size of line buffer */
-	int Lpp;			/* lines per page */
-	char *Clear;			/* clear screen */
+	char *linebuf;			/* line buffer */
+	size_t linesz;			/* size of line buffer */
+	int lines_per_page;		/* lines per page */
+	char *clear;			/* clear screen */
 	char *eraseln;			/* erase line */
-	char *Senter;			/* enter standout mode */
-	char *Sexit;			/* exit standout mode */
-	char *ULenter;			/* enter underline mode */
-	char *ULexit;			/* exit underline mode */
-	char *chUL;			/* underline character */
-	char *chBS;			/* backspace character */
-	char *Home;			/* go to screen home position */
+	char *std_enter;		/* enter standout mode */
+	char *std_exit;			/* exit standout mode */
+	char *underline_enter;		/* enter underline mode */
+	char *underline_exit;		/* exit underline mode */
+	char *underlining_char;		/* underline character */
+	char *backspace_char;		/* backspace character */
+	char *go_home;			/* go to screen home position */
 	char *cursorm;			/* cursor move destination */
 	char cursorhome[40];		/* contains cursor movement to home */
-	char *EodClr;			/* clear rest of screen */
-	int Mcol;			/* number of columns */
+	char *end_clear;		/* clear rest of screen */
+	int ncolumns;			/* number of columns */
 	char *previousre;		/* previous search() buf[] item */
 	struct {
-		long chrctr;		/* row number */
+		long nrow;		/* row number */
 		long line;		/* line number */
 	} context,
 	  screen_start;
@@ -152,36 +152,36 @@ struct more_control {
 	unsigned int
 		bad_so:1,		/* true if overwriting does not turn off standout */
 		catch_susp:1,		/* should SIGTSTP signal be caught */
-		clreol:1,		/* do not scroll, paint each screen from the top */
 		clearfirst:1,		/* is first character in file \f */
+		clreol_opt:1,		/* do not scroll, paint each screen from the top */
 		docrterase:1,		/* is erase previous supported */
 		docrtkill:1,		/* is erase input supported */
 		dumb:1,			/* is terminal type known */
-		dum_opt:1,		/* suppress bell */
 		eatnl:1,		/* is newline ignored after 80 cols */
 		errors:1,		/* is an error reported */
-		firstf:1,		/* is the input file the first in list */
+		first_file:1,		/* is the input file the first in list */
 		fold_opt:1,		/* fold long lines */
-		hard:1,			/* is this hard copy terminal */
+		hard_term:1,		/* is this hard copy terminal */
 		hardtabs:1,		/* print spaces instead of '\t' */
 		jumpopt:1,		/* is jumpline defined */
-		lastp:1,		/* run previous key command */
-		noscroll:1,		/* do not scroll, clear the screen and then display text */
-		notell:1,		/* suppress quit dialog */
+		no_bell:1,		/* suppress bell */
 		no_intty:1,		/* is input in interactive mode */
 		no_tty:1,		/* is output in interactive mode */
-		Pause:1,		/* is output paused */
-		prnames:1,		/* print file name banner */
-		pstate:1,		/* is underlining going on */
-		soglitch:1,		/* terminal has standout mode glitch */
-		srchopt:1,		/* is init search pattern defined */
+		noscroll_opt:1,		/* do not scroll, clear the screen and then display text */
+		notell:1,		/* suppress quit dialog */
+		pause:1,		/* is output paused */
+		print_names:1,		/* print file name banner */
+		rerun_command:1,	/* run previous key command */
 		search_called:1,	/* previous more command was a search */
-		ssp_opt:1,		/* suppress white space */
+		search_opt:1,		/* is init search pattern defined */
+		squeeze_opt:1,		/* suppress white space */
+		stdout_glitch:1,	/* terminal has standout mode glitch */
 		stop_opt:1,		/* stop after form feeds */
-		ulglitch:1,		/* terminal is underlining in glitch mode */
+		ul_glitch:1,		/* terminal is underlining in glitch mode */
 		ul_opt:1,		/* underline as best we can */
+		underlining:1,		/* is underlining going on */
 		within:1,		/* true if we are within a file, false if we are between files */
-		Wrap:1;			/* set if automargins */
+		wrap_margin:1;		/* set if automargins */
 };
 
 static void __attribute__((__noreturn__)) usage(FILE *out)
@@ -225,13 +225,13 @@ static void argscan(struct more_control *ctl, char *s)
 		case '8':
 		case '9':
 			if (!seen_num) {
-				ctl->dlines = 0;
+				ctl->lines_per_screen = 0;
 				seen_num = 1;
 			}
-			ctl->dlines = ctl->dlines * 10 + *s - '0';
+			ctl->lines_per_screen = ctl->lines_per_screen * 10 + *s - '0';
 			break;
 		case 'd':
-			ctl->dum_opt = 1;
+			ctl->no_bell = 1;
 			break;
 		case 'l':
 			ctl->stop_opt = 0;
@@ -240,13 +240,13 @@ static void argscan(struct more_control *ctl, char *s)
 			ctl->fold_opt = 0;
 			break;
 		case 'p':
-			ctl->noscroll = 1;
+			ctl->noscroll_opt = 1;
 			break;
 		case 'c':
-			ctl->clreol = 1;
+			ctl->clreol_opt = 1;
 			break;
 		case 's':
-			ctl->ssp_opt = 1;
+			ctl->squeeze_opt = 1;
 			break;
 		case 'u':
 			ctl->ul_opt = 0;
@@ -268,11 +268,11 @@ static void argscan(struct more_control *ctl, char *s)
 	}
 }
 
-/* magic --
+/* check_magic --
  *	check for file magic numbers.  This code would best be shared
  *	with the file(1) program or, perhaps, more should not try to be
  *	so smart. */
-static int magic(FILE *f, char *fs)
+static int check_magic(FILE *f, char *fs)
 {
 	signed char twobytes[2];
 
@@ -298,7 +298,7 @@ static int magic(FILE *f, char *fs)
 	return 0;
 }
 
-static void set_pos_fseek(struct more_control *ctl, FILE *stream, long pos)
+static void more_fseek(struct more_control *ctl, FILE *stream, long pos)
 {
 	ctl->file_pos = pos;
 	fseek(stream, pos, 0);
@@ -318,7 +318,7 @@ static int more_ungetc(struct more_control *ctl, int c, FILE *stream)
 
 /* Check whether the file named by fs is an ASCII file which the user may
  * access.  If it is, return the opened file.  Otherwise return NULL. */
-static FILE *checkf(struct more_control *ctl, char *fs)
+static FILE *more_fopen(struct more_control *ctl, char *fs)
 {
 	struct stat stbuf;
 	FILE *f;
@@ -326,7 +326,7 @@ static FILE *checkf(struct more_control *ctl, char *fs)
 
 	if (stat(fs, &stbuf) == -1) {
 		fflush(stdout);
-		if (ctl->clreol)
+		if (ctl->clreol_opt)
 			my_putstring(ctl->eraseln);
 		warn(_("stat of %s failed"), fs);
 		return NULL;
@@ -340,7 +340,7 @@ static FILE *checkf(struct more_control *ctl, char *fs)
 		warn(_("cannot open %s"), fs);
 		return NULL;
 	}
-	if (magic(f, fs)) {
+	if (check_magic(f, fs)) {
 		fclose(f);
 		return NULL;
 	}
@@ -355,24 +355,24 @@ static FILE *checkf(struct more_control *ctl, char *fs)
 
 static void prepare_line_buffer(struct more_control *ctl)
 {
-	size_t nsz = ctl->Mcol * 4;
+	size_t nsz = ctl->ncolumns * 4;
 
-	if (ctl->LineLen >= nsz)
+	if (ctl->linesz >= nsz)
 		return;
 
 	if (nsz < LINSIZ)
 		nsz = LINSIZ;
 
 	/* alloc nsz and extra space for \n\0 */
-	ctl->Line = xrealloc(ctl->Line, nsz + 2);
-	ctl->LineLen = nsz;
+	ctl->linebuf = xrealloc(ctl->linebuf, nsz + 2);
+	ctl->linesz = nsz;
 }
 
 /* Get a logical line */
 static int get_line(struct more_control *ctl, FILE *f, int *length)
 {
 	int c;
-	char *p = ctl->Line;
+	char *p = ctl->linebuf;
 	int column = 0;
 	static int colflg;
 
@@ -394,10 +394,10 @@ static int get_line(struct more_control *ctl, FILE *f, int *length)
 
 	c = more_getc(ctl, f);
 	if (colflg && c == '\n') {
-		ctl->Currline++;
+		ctl->current_line++;
 		c = more_getc(ctl, f);
 	}
-	while (p < &ctl->Line[ctl->LineLen - 1]) {
+	while (p < &ctl->linebuf[ctl->linesz - 1]) {
 #ifdef HAVE_WIDECHAR
 		if (ctl->fold_opt && use_mbc_buffer_flag && MB_CUR_MAX > 1) {
 			use_mbc_buffer_flag = 0;
@@ -418,8 +418,8 @@ static int get_line(struct more_control *ctl, FILE *f, int *length)
 				column++;
 				file_pos_bak++;
 
-				if (column >= ctl->Mcol)
-					set_pos_fseek(ctl, f, file_pos_bak);
+				if (column >= ctl->ncolumns)
+					more_fseek(ctl, f, file_pos_bak);
 				else {
 					memmove(mbc, mbc + 1, --mbc_pos);
 					if (mbc_pos > 0) {
@@ -432,11 +432,11 @@ static int get_line(struct more_control *ctl, FILE *f, int *length)
 			default:
 				wc_width = wcwidth(wc);
 
-				if (column + wc_width > ctl->Mcol) {
-					set_pos_fseek(ctl, f, file_pos_bak);
+				if (column + wc_width > ctl->ncolumns) {
+					more_fseek(ctl, f, file_pos_bak);
 					break_flag = 1;
 				} else {
-					for (i = 0; p < &ctl->Line[ctl->LineLen - 1] &&
+					for (i = 0; p < &ctl->linebuf[ctl->linesz - 1] &&
 						    i < mbc_pos; i++)
 						*p++ = mbc[i];
 					if (wc_width > 0)
@@ -444,7 +444,7 @@ static int get_line(struct more_control *ctl, FILE *f, int *length)
 				}
 			}
 
-			if (break_flag || column >= ctl->Mcol)
+			if (break_flag || column >= ctl->ncolumns)
 				break;
 
 			c = more_getc(ctl, f);
@@ -452,28 +452,28 @@ static int get_line(struct more_control *ctl, FILE *f, int *length)
 		}
 #endif	/* HAVE_WIDECHAR */
 		if (c == EOF) {
-			if (p > ctl->Line) {
+			if (p > ctl->linebuf) {
 				*p = '\0';
-				*length = p - ctl->Line;
+				*length = p - ctl->linebuf;
 				return column;
 			}
-			*length = p - ctl->Line;
+			*length = p - ctl->linebuf;
 			return EOF;
 		}
 		if (c == '\n') {
-			ctl->Currline++;
+			ctl->current_line++;
 			break;
 		}
 
 		*p++ = c;
 		if (c == '\t') {
-			if (!ctl->hardtabs || (column < ctl->promptlen && !ctl->hard)) {
+			if (!ctl->hardtabs || (column < ctl->promptlen && !ctl->hard_term)) {
 				if (ctl->hardtabs && ctl->eraseln && !ctl->dumb) {
 					column = 1 + (column | 7);
 					my_putstring(ctl->eraseln);
 					ctl->promptlen = 0;
 				} else {
-					for (--p; p < &ctl->Line[ctl->LineLen - 1];) {
+					for (--p; p < &ctl->linebuf[ctl->linesz - 1];) {
 						*p++ = ' ';
 						if ((++column & 7) == 0)
 							break;
@@ -489,7 +489,7 @@ static int get_line(struct more_control *ctl, FILE *f, int *length)
 			int next = more_getc(ctl, f);
 			if (next == '\n') {
 				p--;
-				ctl->Currline++;
+				ctl->current_line++;
 				break;
 			}
 			more_ungetc(ctl, next, f);
@@ -498,9 +498,9 @@ static int get_line(struct more_control *ctl, FILE *f, int *length)
 			p[-1] = '^';
 			*p++ = 'L';
 			column += 2;
-			ctl->Pause = 1;
+			ctl->pause = 1;
 		} else if (c == EOF) {
-			*length = p - ctl->Line;
+			*length = p - ctl->linebuf;
 			return column;
 		} else {
 #ifdef HAVE_WIDECHAR
@@ -538,34 +538,34 @@ static int get_line(struct more_control *ctl, FILE *f, int *length)
 			}
 		}
 
-		if (column >= ctl->Mcol && ctl->fold_opt)
+		if (column >= ctl->ncolumns && ctl->fold_opt)
 			break;
 #ifdef HAVE_WIDECHAR
-		if (use_mbc_buffer_flag == 0 && p >= &ctl->Line[ctl->LineLen - 1 - 4])
+		if (use_mbc_buffer_flag == 0 && p >= &ctl->linebuf[ctl->linesz - 1 - 4])
 			/* don't read another char if there is no space for
 			 * whole multibyte sequence */
 			break;
 #endif
 		c = more_getc(ctl, f);
 	}
-	if (column >= ctl->Mcol && ctl->Mcol > 0)
-		if (!ctl->Wrap)
+	if (column >= ctl->ncolumns && ctl->ncolumns > 0)
+		if (!ctl->wrap_margin)
 			*p++ = '\n';
-	colflg = column == ctl->Mcol && ctl->fold_opt;
-	if (colflg && ctl->eatnl && ctl->Wrap)
+	colflg = column == ctl->ncolumns && ctl->fold_opt;
+	if (colflg && ctl->eatnl && ctl->wrap_margin)
 		*p++ = '\n';	/* simulate normal wrap */
-	*length = p - ctl->Line;
+	*length = p - ctl->linebuf;
 	*p = 0;
 	return column;
 }
 
 /* Erase the rest of the prompt, assuming we are starting at column col. */
-static void erasep(struct more_control *ctl, int col)
+static void erase_prompt(struct more_control *ctl, int col)
 {
 
 	if (ctl->promptlen == 0)
 		return;
-	if (ctl->hard)
+	if (ctl->hard_term)
 		putchar('\n');
 	else {
 		if (col == 0)
@@ -587,7 +587,7 @@ static UL_ASAN_BLACKLIST size_t xmbrtowc(wchar_t *wc, const char *s, size_t n,
 	return mblength;
 }
 
-static int wouldul(char *s, int n)
+static int would_underline(char *s, int n)
 {
 	if (n < 2)
 		return 0;
@@ -597,7 +597,7 @@ static int wouldul(char *s, int n)
 }
 
 /* Print a buffer of n characters */
-static void prbuf(struct more_control *ctl, char *s, int n)
+static void print_buffer(struct more_control *ctl, char *s, int n)
 {
 	char c;			/* next output character */
 	int state;		/* next output char's UL state */
@@ -607,27 +607,27 @@ static void prbuf(struct more_control *ctl, char *s, int n)
 			putchar(*s++);
 			continue;
 		}
-		if (*s == ' ' && ctl->pstate == 0 && ctl->ulglitch
-		    && wouldul(s + 1, n - 1)) {
+		if (*s == ' ' && ctl->underlining == 0 && ctl->ul_glitch
+		    && would_underline(s + 1, n - 1)) {
 			s++;
 			continue;
 		}
-		if ((state = wouldul(s, n)) != 0) {
+		if ((state = would_underline(s, n)) != 0) {
 			c = (*s == '_') ? s[2] : *s;
 			n -= 2;
 			s += 3;
 		} else
 			c = *s++;
-		if (state != ctl->pstate) {
-			if (c == ' ' && state == 0 && ctl->ulglitch
-			    && wouldul(s, n - 1))
+		if (state != ctl->underlining) {
+			if (c == ' ' && state == 0 && ctl->ul_glitch
+			    && would_underline(s, n - 1))
 				state = 1;
 			else
-				my_putstring(state ? ctl->ULenter : ctl->
-					     ULexit);
+				my_putstring(state ? ctl->underline_enter : ctl->
+					     underline_exit);
 		}
-		if (c != ' ' || ctl->pstate == 0 || state != 0
-		    || ctl->ulglitch == 0)
+		if (c != ' ' || ctl->underlining == 0 || state != 0
+		    || ctl->ul_glitch == 0)
 #ifdef HAVE_WIDECHAR
 		{
 			wchar_t wc;
@@ -645,35 +645,35 @@ static void prbuf(struct more_control *ctl, char *s, int n)
 #else
 			putchar(c);
 #endif				/* HAVE_WIDECHAR */
-		if (state && *ctl->chUL) {
-			fputs(ctl->chBS, stdout);
-			my_putstring(ctl->chUL);
+		if (state && *ctl->underlining_char) {
+			fputs(ctl->backspace_char, stdout);
+			my_putstring(ctl->underlining_char);
 		}
-		ctl->pstate = state;
+		ctl->underlining = state;
 	}
 }
 
 /* Erase the current line entirely */
 static void kill_line(struct more_control *ctl)
 {
-	erasep(ctl, 0);
+	erase_prompt(ctl, 0);
 	if (!ctl->eraseln || ctl->dumb)
 		putchar('\r');
 }
 
-static void prompt(struct more_control *ctl, char *filename)
+static void output_prompt(struct more_control *ctl, char *filename)
 {
-	if (ctl->clreol)
+	if (ctl->clreol_opt)
 		my_putstring(ctl->eraseln);
 	else if (ctl->promptlen > 0)
 		kill_line(ctl);
-	if (!ctl->hard) {
+	if (!ctl->hard_term) {
 		ctl->promptlen = 0;
-		if (ctl->Senter && ctl->Sexit) {
-			my_putstring(ctl->Senter);
-			ctl->promptlen += (2 * ctl->soglitch);
+		if (ctl->std_enter && ctl->std_exit) {
+			my_putstring(ctl->std_enter);
+			ctl->promptlen += (2 * ctl->stdout_glitch);
 		}
-		if (ctl->clreol)
+		if (ctl->clreol_opt)
 			my_putstring(ctl->eraseln);
 		ctl->promptlen += printf(_("--More--"));
 		if (filename != NULL)
@@ -683,14 +683,14 @@ static void prompt(struct more_control *ctl, char *filename)
 			    printf("(%d%%)",
 				   (int)((ctl->file_pos * 100) / ctl->file_size));
 		}
-		if (ctl->dum_opt) {
+		if (ctl->no_bell) {
 			ctl->promptlen +=
 			    printf(_("[Press space to continue, 'q' to quit.]"));
 		}
-		if (ctl->Senter && ctl->Sexit)
-			my_putstring(ctl->Sexit);
-		if (ctl->clreol)
-			my_putstring(ctl->EodClr);
+		if (ctl->std_enter && ctl->std_exit)
+			my_putstring(ctl->std_exit);
+		if (ctl->clreol_opt)
+			my_putstring(ctl->end_clear);
 		fflush(stdout);
 	} else
 		fputc('\a', stderr);
@@ -700,43 +700,43 @@ static void reset_tty(struct more_control *ctl)
 {
 	if (ctl->no_tty)
 		return;
-	if (ctl->pstate) {
-		tputs(ctl->ULexit, STDOUT_FILENO, putchar);
+	if (ctl->underlining) {
+		tputs(ctl->underline_exit, STDOUT_FILENO, putchar);
 		fflush(stdout);
-		ctl->pstate = 0;
+		ctl->underlining = 0;
 	}
 	ctl->otty.c_lflag |= ICANON | ECHO;
-	ctl->otty.c_cc[VMIN] = ctl->savetty0.c_cc[VMIN];
-	ctl->otty.c_cc[VTIME] = ctl->savetty0.c_cc[VTIME];
-	tcsetattr(STDERR_FILENO, TCSANOW, &ctl->savetty0);
+	ctl->otty.c_cc[VMIN] = ctl->orig_tty.c_cc[VMIN];
+	ctl->otty.c_cc[VTIME] = ctl->orig_tty.c_cc[VTIME];
+	tcsetattr(STDERR_FILENO, TCSANOW, &ctl->orig_tty);
 }
 
 /* Clean up terminal state and exit. Also come here if interrupt signal received */
-static void __attribute__((__noreturn__)) end_it(struct more_control *ctl)
+static void __attribute__((__noreturn__)) exit_more(struct more_control *ctl)
 {
 	reset_tty(ctl);
-	if (ctl->clreol) {
+	if (ctl->clreol_opt) {
 		putchar('\r');
-		my_putstring(ctl->EodClr);
+		my_putstring(ctl->end_clear);
 		fflush(stdout);
-	} else if (!ctl->clreol && (ctl->promptlen > 0)) {
+	} else if (!ctl->clreol_opt && (ctl->promptlen > 0)) {
 		kill_line(ctl);
 		fflush(stdout);
 	} else
 		fputc('\n', stderr);
 	free(ctl->previousre);
-	free(ctl->Line);
+	free(ctl->linebuf);
 	_exit(EXIT_SUCCESS);
 }
 
-static int readch(struct more_control *ctl)
+static int read_char(struct more_control *ctl)
 {
 	unsigned char c;
 
 	errno = 0;
 	if (read(STDERR_FILENO, &c, 1) <= 0) {
 		if (errno != EINTR)
-			end_it(ctl);
+			exit_more(ctl);
 		else
 			c = ctl->otty.c_cc[VKILL];
 	}
@@ -745,13 +745,13 @@ static int readch(struct more_control *ctl)
 
 /* Read a decimal number from the terminal.  Set cmd to the non-digit
  * which terminates the number. */
-static int number(struct more_control *ctl, char *cmd)
+static int read_number(struct more_control *ctl, char *cmd)
 {
 	int i = 0;
 	char ch;
 
 	for (;;) {
-		ch = readch(ctl);
+		ch = read_char(ctl);
 		if (isdigit(ch))
 			i = i * 10 + ch - '0';
 		else if ((cc_t)ch == ctl->otty.c_cc[VKILL])
@@ -766,30 +766,30 @@ static int number(struct more_control *ctl, char *cmd)
 
 /* Skip nskip files in the file list (from the command line).  Nskip may
  * be negative. */
-static void skipf(struct more_control *ctl, int nskip)
+static void change_file(struct more_control *ctl, int nskip)
 {
 	if (nskip == 0)
 		return;
 	if (nskip > 0) {
-		if (ctl->fnum + nskip > ctl->nfiles - 1)
-			nskip = ctl->nfiles - ctl->fnum - 1;
+		if (ctl->argv_position + nskip > ctl->nfiles - 1)
+			nskip = ctl->nfiles - ctl->argv_position - 1;
 	} else if (ctl->within)
-		ctl->fnum++;
-	ctl->fnum += nskip;
-	if (ctl->fnum < 0)
-		ctl->fnum = 0;
+		ctl->argv_position++;
+	ctl->argv_position += nskip;
+	if (ctl->argv_position < 0)
+		ctl->argv_position = 0;
 	puts(_("\n...Skipping "));
-	if (ctl->clreol)
+	if (ctl->clreol_opt)
 		my_putstring(ctl->eraseln);
 	if (nskip > 0)
 		fputs(_("...Skipping to file "), stdout);
 	else
 		fputs(_("...Skipping back to file "), stdout);
-	puts(ctl->fnames[ctl->fnum]);
-	if (ctl->clreol)
+	puts(ctl->fnames[ctl->argv_position]);
+	if (ctl->clreol_opt)
 		my_putstring(ctl->eraseln);
 	putchar('\n');
-	ctl->fnum--;
+	ctl->argv_position--;
 }
 
 static void show(struct more_control *ctl, char c)
@@ -805,15 +805,15 @@ static void show(struct more_control *ctl, char c)
 
 static void more_error(struct more_control *ctl, char *mess)
 {
-	if (ctl->clreol)
+	if (ctl->clreol_opt)
 		my_putstring(ctl->eraseln);
 	else
 		kill_line(ctl);
 	ctl->promptlen += strlen(mess);
-	if (ctl->Senter && ctl->Sexit) {
-		my_putstring(ctl->Senter);
+	if (ctl->std_enter && ctl->std_exit) {
+		my_putstring(ctl->std_enter);
 		fputs(mess, stdout);
-		my_putstring(ctl->Sexit);
+		my_putstring(ctl->std_exit);
 	} else
 		fputs(mess, stdout);
 	fflush(stdout);
@@ -838,7 +838,7 @@ static void ttyin(struct more_control *ctl, char buf[], int nmax, char pchar)
 	while (sp - buf < nmax) {
 		if (ctl->promptlen > maxlen)
 			maxlen = ctl->promptlen;
-		c = readch(ctl);
+		c = read_char(ctl);
 		if (c == '\\')
 			slash++;
 		else if (((cc_t) c == ctl->otty.c_cc[VERASE]) && !slash) {
@@ -906,7 +906,7 @@ static void ttyin(struct more_control *ctl, char buf[], int nmax, char pchar)
 					ctl->promptlen = maxlen;
 			}
 		} else if (((cc_t) c == ctl->otty.c_cc[VKILL]) && !slash) {
-			if (ctl->hard) {
+			if (ctl->hard_term) {
 				show(ctl, c);
 				putchar('\n');
 				putchar(pchar);
@@ -914,7 +914,7 @@ static void ttyin(struct more_control *ctl, char buf[], int nmax, char pchar)
 				putchar('\r');
 				putchar(pchar);
 				if (ctl->eraseln)
-					erasep(ctl, 1);
+					erase_prompt(ctl, 1);
 				else if (ctl->docrtkill)
 					while (ctl->promptlen-- > 1)
 						fputs("\b \b", stderr);
@@ -950,7 +950,7 @@ static void ttyin(struct more_control *ctl, char buf[], int nmax, char pchar)
 		more_error(ctl, _("Line too long"));
 }
 
-static int expand(struct more_control *ctl, char **outbuf, char *inbuf)
+static int command_expansion(struct more_control *ctl, char **outbuf, char *inbuf)
 {
 	char *inpstr = inbuf;
 	char *outstr;
@@ -959,7 +959,7 @@ static int expand(struct more_control *ctl, char **outbuf, char *inbuf)
 	int changed = 0;
 	int tempsz, xtra, offset;
 
-	xtra = strlen(ctl->fnames[ctl->fnum]) + strlen(ctl->shell_line) + 1;
+	xtra = strlen(ctl->fnames[ctl->argv_position]) + strlen(ctl->shell_line) + 1;
 	tempsz = 200 + xtra;
 	temp = xmalloc(tempsz);
 	outstr = temp;
@@ -973,8 +973,8 @@ static int expand(struct more_control *ctl, char **outbuf, char *inbuf)
 		switch (c) {
 		case '%':
 			if (!ctl->no_intty) {
-				strcpy(outstr, ctl->fnames[ctl->fnum]);
-				outstr += strlen(ctl->fnames[ctl->fnum]);
+				strcpy(outstr, ctl->fnames[ctl->argv_position]);
+				outstr += strlen(ctl->fnames[ctl->argv_position]);
 				changed = 1;
 			} else
 				*outstr++ = c;
@@ -1010,17 +1010,17 @@ static void set_tty(struct more_control *ctl)
 }
 
 /* Come here if a quit signal is received */
-static void onquit(struct more_control *ctl)
+static void quit_more(struct more_control *ctl)
 {
-	if (!ctl->dum_opt && ctl->notell) {
+	if (!ctl->no_bell && ctl->notell) {
 		ctl->promptlen += fprintf(stderr, _("[Use q or Q to quit]"));
 		ctl->notell = 0;
 	} else
-		end_it(ctl);
+		exit_more(ctl);
 }
 
 /* Come here when we get a suspend signal from the terminal */
-static void onsusp(struct more_control *ctl)
+static void suspend_more(struct more_control *ctl)
 {
 	reset_tty(ctl);
 	fflush(stdout);
@@ -1085,7 +1085,7 @@ static void execute(struct more_control *ctl, char *filename, char *cmd, ...)
 	set_tty(ctl);
 	puts("------------------------");
 err:
-	prompt(ctl, filename);
+	output_prompt(ctl, filename);
 }
 
 static void do_shell(struct more_control *ctl, char *filename)
@@ -1098,11 +1098,11 @@ static void do_shell(struct more_control *ctl, char *filename)
 	putchar('!');
 	fflush(stdout);
 	ctl->promptlen = 1;
-	if (ctl->lastp)
+	if (ctl->rerun_command)
 		fputs(ctl->shell_line, stdout);
 	else {
 		ttyin(ctl, cmdbuf, sizeof(cmdbuf) - 2, '!');
-		rc = expand(ctl, &expanded, cmdbuf);
+		rc = command_expansion(ctl, &expanded, cmdbuf);
 		if (expanded) {
 			if (strlen(expanded) < sizeof(ctl->shell_line))
 				strcpy(ctl->shell_line, expanded);
@@ -1112,7 +1112,7 @@ static void do_shell(struct more_control *ctl, char *filename)
 		}
 		if (rc < 0) {
 			fputs(_("  Overflow\n"), stderr);
-			prompt(ctl, filename);
+			output_prompt(ctl, filename);
 			return;
 		} else if (rc > 0) {
 			kill_line(ctl);
@@ -1128,12 +1128,12 @@ static void do_shell(struct more_control *ctl, char *filename)
 
 /* Execute a colon-prefixed command.  Returns <0 if not a command that
  * should cause more of the file to be printed. */
-static int colon(struct more_control *ctl, char *filename, int cmd, int nlines)
+static int colon_command(struct more_control *ctl, char *filename, int cmd, int nlines)
 {
 	char ch;
 
 	if (cmd == 0)
-		ch = readch(ctl);
+		ch = read_char(ctl);
 	else
 		ch = cmd;
 	ctl->lastcolon = ch;
@@ -1142,20 +1142,20 @@ static int colon(struct more_control *ctl, char *filename, int cmd, int nlines)
 		kill_line(ctl);
 		if (!ctl->no_intty)
 			ctl->promptlen =
-			    printf(_("\"%s\" line %d"), ctl->fnames[ctl->fnum], ctl->Currline);
+			    printf(_("\"%s\" line %d"), ctl->fnames[ctl->argv_position], ctl->current_line);
 		else
-			ctl->promptlen = printf(_("[Not a file] line %d"), ctl->Currline);
+			ctl->promptlen = printf(_("[Not a file] line %d"), ctl->current_line);
 		fflush(stdout);
 		return -1;
 	case 'n':
 		if (nlines == 0) {
-			if (ctl->fnum >= ctl->nfiles - 1)
-				end_it(ctl);
+			if (ctl->argv_position >= ctl->nfiles - 1)
+				exit_more(ctl);
 			nlines++;
 		}
 		putchar('\r');
-		erasep(ctl, 0);
-		skipf(ctl, nlines);
+		erase_prompt(ctl, 0);
+		change_file(ctl, nlines);
 		return 0;
 	case 'p':
 		if (ctl->no_intty) {
@@ -1163,17 +1163,17 @@ static int colon(struct more_control *ctl, char *filename, int cmd, int nlines)
 			return -1;
 		}
 		putchar('\r');
-		erasep(ctl, 0);
+		erase_prompt(ctl, 0);
 		if (nlines == 0)
 			nlines++;
-		skipf(ctl, -nlines);
+		change_file(ctl, -nlines);
 		return 0;
 	case '!':
 		do_shell(ctl, filename);
 		return -1;
 	case 'q':
 	case 'Q':
-		end_it(ctl);
+		exit_more(ctl);
 	default:
 		fputc('\a', stderr);
 		return -1;
@@ -1181,7 +1181,7 @@ static int colon(struct more_control *ctl, char *filename, int cmd, int nlines)
 }
 
 /* Skip n lines in the file f */
-static void skiplns(struct more_control *ctl, FILE *f)
+static void skip_lines(struct more_control *ctl, FILE *f)
 {
 	int c, n = ctl->jumpline;
 
@@ -1190,15 +1190,15 @@ static void skiplns(struct more_control *ctl, FILE *f)
 			if (c == EOF)
 				return;
 		n--;
-		ctl->Currline++;
+		ctl->current_line++;
 	}
 }
 
 /*  Clear the screen */
-static void doclear(struct more_control *ctl)
+static void clear_tty(struct more_control *ctl)
 {
-	if (ctl->Clear && !ctl->hard) {
-		my_putstring(ctl->Clear);
+	if (ctl->clear && !ctl->hard_term) {
+		my_putstring(ctl->clear);
 		/* Put out carriage return so that system doesn't get
 		 * confused by escape sequences when expanding tabs */
 		putchar('\r');
@@ -1206,19 +1206,19 @@ static void doclear(struct more_control *ctl)
 	}
 }
 
-static void rdline(struct more_control *ctl, FILE *f)
+static void read_line(struct more_control *ctl, FILE *f)
 {
 	int c;
 	char *p;
 
 	prepare_line_buffer(ctl);
 
-	p = ctl->Line;
+	p = ctl->linebuf;
 	while ((c = more_getc(ctl, f)) != '\n' && c != EOF
-	       && (size_t)(p - ctl->Line) < ctl->LineLen - 1)
+	       && (size_t)(p - ctl->linebuf) < ctl->linesz - 1)
 		*p++ = c;
 	if (c == '\n')
-		ctl->Currline++;
+		ctl->current_line++;
 	*p = '\0';
 }
 
@@ -1236,7 +1236,7 @@ static int stop_search(struct more_control *ctl)
 	ctl->promptlen = printf(_("No search results in %d seconds, stop searching?"), SEARCH_TIMEOUT);
 	buf[0] = getchar();
 	buf[1] = '\0';
-	erasep(ctl, 0);
+	erase_prompt(ctl, 0);
 	alarm(SEARCH_TIMEOUT);
 	alarm_received = 0;
 	return rpmatch(buf);
@@ -1254,8 +1254,8 @@ static void search(struct more_control *ctl, char buf[], FILE *file, int n)
 	int saveln, rc;
 	regex_t re;
 
-	ctl->context.line = saveln = ctl->Currline;
-	ctl->context.chrctr = startline;
+	ctl->context.line = saveln = ctl->current_line;
+	ctl->context.nrow = startline;
 	if (!buf)
 		goto notfound;
 	if ((rc = regcomp(&re, buf, REG_NOSUB)) != 0) {
@@ -1273,37 +1273,37 @@ static void search(struct more_control *ctl, char buf[], FILE *file, int n)
 		line3 = line2;
 		line2 = line1;
 		line1 = ctl->file_pos;
-		rdline(ctl, file);
+		read_line(ctl, file);
 		lncount++;
-		if (regexec(&re, ctl->Line, 0, NULL, 0) == 0) {
+		if (regexec(&re, ctl->linebuf, 0, NULL, 0) == 0) {
 			if (--n == 0) {
 				if (lncount > 3 || (lncount > 1 && ctl->no_intty)) {
 					putchar('\n');
-					if (ctl->clreol)
+					if (ctl->clreol_opt)
 						my_putstring(ctl->eraseln);
 					fputs(_("...skipping\n"), stdout);
 				}
 				if (!ctl->no_intty) {
-					ctl->Currline -=
+					ctl->current_line -=
 					    (lncount >= 3 ? 3 : lncount);
-					set_pos_fseek(ctl, file, line3);
-					if (ctl->noscroll) {
-						if (ctl->clreol) {
-							my_putstring(ctl->Home);
+					more_fseek(ctl, file, line3);
+					if (ctl->noscroll_opt) {
+						if (ctl->clreol_opt) {
+							my_putstring(ctl->go_home);
 							my_putstring(ctl->eraseln);
 						} else
-							doclear(ctl);
+							clear_tty(ctl);
 					}
 				} else {
 					kill_line(ctl);
-					if (ctl->noscroll) {
-						if (ctl->clreol) {
-							my_putstring(ctl->Home);
+					if (ctl->noscroll_opt) {
+						if (ctl->clreol_opt) {
+							my_putstring(ctl->go_home);
 							my_putstring(ctl->eraseln);
 						} else
-							doclear(ctl);
+							clear_tty(ctl);
 					}
-					puts(ctl->Line);
+					puts(ctl->linebuf);
 				}
 				break;
 			}
@@ -1314,11 +1314,11 @@ static void search(struct more_control *ctl, char buf[], FILE *file, int n)
 	regfree(&re);
 	if (feof(file)) {
 		if (!ctl->no_intty) {
-			ctl->Currline = saveln;
-			set_pos_fseek(ctl, file, startline);
+			ctl->current_line = saveln;
+			more_fseek(ctl, file, startline);
 		} else {
 			fputs(_("\nPattern not found\n"), stdout);
-			end_it(ctl);
+			exit_more(ctl);
 		}
 		free(ctl->previousre);
 		ctl->previousre = NULL;
@@ -1371,7 +1371,7 @@ static void runtime_usage(void)
 static void execute_editor(struct more_control *ctl, char *cmdbuf, char *filename)
 {
 	char *editor, *p;
-	int n = (ctl->Currline - ctl->dlines <= 0 ? 1 : ctl->Currline - (ctl->dlines + 1) / 2);
+	int n = (ctl->current_line - ctl->lines_per_screen <= 0 ? 1 : ctl->current_line - (ctl->lines_per_screen + 1) / 2);
 	int split = 0;
 
 	editor = find_editor();
@@ -1388,13 +1388,13 @@ static void execute_editor(struct more_control *ctl, char *cmdbuf, char *filenam
 	} else
 		sprintf(cmdbuf, "+%d", n);
 	kill_line(ctl);
-	printf("%s %s %s", editor, cmdbuf, ctl->fnames[ctl->fnum]);
+	printf("%s %s %s", editor, cmdbuf, ctl->fnames[ctl->argv_position]);
 	if (split) {
 		cmdbuf[2] = 0;
 		execute(ctl, filename, editor, editor,
-			cmdbuf, cmdbuf + 3, ctl->fnames[ctl->fnum], (char *)0);
+			cmdbuf, cmdbuf + 3, ctl->fnames[ctl->argv_position], (char *)0);
 	} else
-		execute(ctl, filename, editor, editor, cmdbuf, ctl->fnames[ctl->fnum], (char *)0);
+		execute(ctl, filename, editor, editor, cmdbuf, ctl->fnames[ctl->argv_position], (char *)0);
 }
 
 static int skip_backwards(struct more_control *ctl, FILE *f, int nlines)
@@ -1402,25 +1402,25 @@ static int skip_backwards(struct more_control *ctl, FILE *f, int nlines)
 	if (nlines == 0)
 		nlines++;
 	putchar('\r');
-	erasep(ctl, 0);
+	erase_prompt(ctl, 0);
 	putchar('\n');
-	if (ctl->clreol)
+	if (ctl->clreol_opt)
 		my_putstring(ctl->eraseln);
 	printf(P_("...back %d page", "...back %d pages", nlines), nlines);
-	if (ctl->clreol)
+	if (ctl->clreol_opt)
 		my_putstring(ctl->eraseln);
 	putchar('\n');
-	ctl->jumpline = ctl->Currline - ctl->dlines * (nlines + 1);
-	if (!ctl->noscroll)
+	ctl->jumpline = ctl->current_line - ctl->lines_per_screen * (nlines + 1);
+	if (!ctl->noscroll_opt)
 		ctl->jumpline--;
 	if (ctl->jumpline < 0)
 		ctl->jumpline = 0;
-	set_pos_fseek(ctl, f, 0);
-	ctl->Currline = 0;	/* skiplns() will make Currline correct */
-	skiplns(ctl, f);
-	if (!ctl->noscroll)
-		return ctl->dlines + 1;
-	return ctl->dlines;
+	more_fseek(ctl, f, 0);
+	ctl->current_line = 0;	/* skip_lines() will make current_line correct */
+	skip_lines(ctl, f);
+	if (!ctl->noscroll_opt)
+		return ctl->lines_per_screen + 1;
+	return ctl->lines_per_screen;
 }
 
 static int skip_forwards(struct more_control *ctl, FILE *f, int nlines, char comchar)
@@ -1428,14 +1428,14 @@ static int skip_forwards(struct more_control *ctl, FILE *f, int nlines, char com
 	if (nlines == 0)
 		nlines++;
 	if (comchar == 'f')
-		nlines *= ctl->dlines;
+		nlines *= ctl->lines_per_screen;
 	putchar('\r');
-	erasep(ctl, 0);
+	erase_prompt(ctl, 0);
 	putchar('\n');
-	if (ctl->clreol)
+	if (ctl->clreol_opt)
 		my_putstring(ctl->eraseln);
 	printf(P_("...skipping %d line", "...skipping %d lines", nlines), nlines);
-	if (ctl->clreol)
+	if (ctl->clreol_opt)
 		my_putstring(ctl->eraseln);
 	putchar('\n');
 	while (nlines > 0) {
@@ -1443,7 +1443,7 @@ static int skip_forwards(struct more_control *ctl, FILE *f, int nlines, char com
 		while ((c = more_getc(ctl, f)) != '\n')
 			if (c == EOF)
 				return 0;
-		ctl->Currline++;
+		ctl->current_line++;
 		nlines--;
 	}
 	return 1;
@@ -1451,20 +1451,20 @@ static int skip_forwards(struct more_control *ctl, FILE *f, int nlines, char com
 
 /* Come here if a signal for a window size change is received */
 #ifdef SIGWINCH
-static void chgwinsz(struct more_control *ctl)
+static void change_window_sz(struct more_control *ctl)
 {
 	struct winsize win;
 
 	if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &win) != -1) {
 		if (win.ws_row != 0) {
-			ctl->Lpp = win.ws_row;
-			ctl->nscroll = ctl->Lpp / 2 - 1;
+			ctl->lines_per_page = win.ws_row;
+			ctl->nscroll = ctl->lines_per_page / 2 - 1;
 			if (ctl->nscroll <= 0)
 				ctl->nscroll = 1;
-			ctl->dlines = ctl->Lpp - 1;
+			ctl->lines_per_screen = ctl->lines_per_page - 1;
 		}
 		if (win.ws_col != 0)
-			ctl->Mcol = win.ws_col;
+			ctl->ncolumns = win.ws_col;
 	}
 }
 #endif				/* SIGWINCH */
@@ -1487,7 +1487,7 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 	pfd[1].fd = STDIN_FILENO;
 	pfd[1].events = POLLIN;
 	if (!ctl->errors)
-		prompt(ctl, filename);
+		output_prompt(ctl, filename);
 	else
 		ctl->errors = 0;
 	ctl->search_called = 0;
@@ -1506,17 +1506,17 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 			assert(sz == sizeof(info));
 			switch (info.ssi_signo) {
 			case SIGINT:
-				end_it(ctl);
+				exit_more(ctl);
 				break;
 			case SIGQUIT:
-				onquit(ctl);
+				quit_more(ctl);
 				break;
 			case SIGTSTP:
-				onsusp(ctl);
+				suspend_more(ctl);
 				break;
 #ifdef SIGWINCH
 			case SIGWINCH:
-				chgwinsz(ctl);
+				change_window_sz(ctl);
 				break;
 #endif
 			default:
@@ -1525,10 +1525,10 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 		}
 		if (pfd[1].revents == 0)
 			continue;
-		nlines = number(ctl, &comchar);
-		ctl->lastp = colonch = 0;
+		nlines = read_number(ctl, &comchar);
+		ctl->rerun_command = colonch = 0;
 		if (comchar == '.') {	/* Repeat last command */
-			ctl->lastp++;
+			ctl->rerun_command++;
 			comchar = ctl->lastcmd;
 			nlines = ctl->lastarg;
 			if (ctl->lastcmd == ':')
@@ -1538,12 +1538,12 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 		ctl->lastarg = nlines;
 		if ((cc_t) comchar == ctl->otty.c_cc[VERASE]) {
 			kill_line(ctl);
-			prompt(ctl, filename);
+			output_prompt(ctl, filename);
 			continue;
 		}
 		switch (comchar) {
 		case ':':
-			retval = colon(ctl, filename, colonch, nlines);
+			retval = colon_command(ctl, filename, colonch, nlines);
 			if (retval >= 0)
 				done++;
 			break;
@@ -1559,9 +1559,9 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 		case ' ':
 		case 'z':
 			if (nlines == 0)
-				nlines = ctl->dlines;
+				nlines = ctl->lines_per_screen;
 			else if (comchar == 'z')
-				ctl->dlines = nlines;
+				ctl->lines_per_screen = nlines;
 			retval = nlines;
 			done = 1;
 			break;
@@ -1574,19 +1574,19 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 			break;
 		case 'q':
 		case 'Q':
-			end_it(ctl);
+			exit_more(ctl);
 		case 's':
 		case 'f':
 		case ctrl('F'):
 			if (skip_forwards(ctl, f, nlines, comchar))
-				retval = ctl->dlines;
+				retval = ctl->lines_per_screen;
 			else
 				retval = 0;
 			done = 1;
 			break;
 		case '\n':
 			if (nlines != 0)
-				ctl->dlines = nlines;
+				ctl->lines_per_screen = nlines;
 			else
 				nlines = 1;
 			retval = nlines;
@@ -1594,10 +1594,10 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 			break;
 		case '\f':
 			if (!ctl->no_intty) {
-				doclear(ctl);
-				set_pos_fseek(ctl, f, ctl->screen_start.chrctr);
-				ctl->Currline = ctl->screen_start.line;
-				retval = ctl->dlines;
+				clear_tty(ctl);
+				more_fseek(ctl, f, ctl->screen_start.nrow);
+				ctl->current_line = ctl->screen_start.line;
+				retval = ctl->lines_per_screen;
 				done = 1;
 				break;
 			}
@@ -1607,8 +1607,8 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 			if (!ctl->no_intty) {
 				kill_line(ctl);
 				fputs(_("\n***Back***\n\n"), stdout);
-				set_pos_fseek(ctl, f, ctl->context.chrctr);
-				ctl->Currline = ctl->context.line;
+				more_fseek(ctl, f, ctl->context.nrow);
+				ctl->current_line = ctl->context.line;
 				retval = lines;
 				done = 1;
 				break;
@@ -1617,7 +1617,7 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 			break;
 		case '=':
 			kill_line(ctl);
-			ctl->promptlen = printf("%d", ctl->Currline);
+			ctl->promptlen = printf("%d", ctl->current_line);
 			fflush(stdout);
 			break;
 		case 'n':
@@ -1625,7 +1625,7 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 				more_error(ctl, _("No previous regular expression"));
 				break;
 			}
-			ctl->lastp = 1;
+			ctl->rerun_command = 1;
 			/* fall through */
 		case '/':
 			ctl->search_called = 1;
@@ -1635,7 +1635,7 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 			putchar('/');
 			ctl->promptlen = 1;
 			fflush(stdout);
-			if (ctl->lastp) {
+			if (ctl->rerun_command) {
 				fputc('\r', stderr);
 				search(ctl, ctl->previousre, f, nlines);
 			} else {
@@ -1645,7 +1645,7 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 				ctl->previousre = xstrdup(cmdbuf);
 				search(ctl, cmdbuf, f, nlines);
 			}
-			retval = ctl->dlines - 1;
+			retval = ctl->lines_per_screen - 1;
 			done = 1;
 			break;
 		case '!':
@@ -1653,10 +1653,10 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 			break;
 		case '?':
 		case 'h':
-			if (ctl->noscroll)
-				doclear(ctl);
+			if (ctl->noscroll_opt)
+				clear_tty(ctl);
 			runtime_usage();
-			prompt(ctl, filename);
+			output_prompt(ctl, filename);
 			break;
 		case 'v':	/* This case should go right before default */
 			if (!ctl->no_intty) {
@@ -1665,15 +1665,15 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 			}
 			/* fall through */
 		default:
-			if (ctl->dum_opt) {
+			if (ctl->no_bell) {
 				kill_line(ctl);
-				if (ctl->Senter && ctl->Sexit) {
-					my_putstring(ctl->Senter);
+				if (ctl->std_enter && ctl->std_exit) {
+					my_putstring(ctl->std_enter);
 					ctl->promptlen =
 					    printf(_
 						   ("[Press 'h' for instructions.]"))
-					    + 2 * ctl->soglitch;
-					my_putstring(ctl->Sexit);
+					    + 2 * ctl->stdout_glitch;
+					my_putstring(ctl->std_exit);
 				} else
 					ctl->promptlen =
 					    printf(_
@@ -1698,63 +1698,63 @@ static void screen(struct more_control *ctl, FILE *f, int num_lines)
 	static int prev_len = 1;	/* length of previous line */
 
 	for (;;) {
-		while (num_lines > 0 && !ctl->Pause) {
+		while (num_lines > 0 && !ctl->pause) {
 			if ((nchars = get_line(ctl, f, &length)) == EOF) {
-				if (ctl->clreol)
-					my_putstring(ctl->EodClr);
+				if (ctl->clreol_opt)
+					my_putstring(ctl->end_clear);
 				return;
 			}
-			if (ctl->ssp_opt && length == 0 && prev_len == 0)
+			if (ctl->squeeze_opt && length == 0 && prev_len == 0)
 				continue;
 			prev_len = length;
 			if (ctl->bad_so
-			    || ((ctl->Senter && *ctl->Senter == ' ') && (ctl->promptlen > 0)))
-				erasep(ctl, 0);
+			    || ((ctl->std_enter && *ctl->std_enter == ' ') && (ctl->promptlen > 0)))
+				erase_prompt(ctl, 0);
 			/* must clear before drawing line since tabs on
 			 * some terminals do not erase what they tab
 			 * over. */
-			if (ctl->clreol)
+			if (ctl->clreol_opt)
 				my_putstring(ctl->eraseln);
-			prbuf(ctl, ctl->Line, length);
+			print_buffer(ctl, ctl->linebuf, length);
 			if (nchars < ctl->promptlen)
-				erasep(ctl, nchars);	/* erasep () sets promptlen to 0 */
+				erase_prompt(ctl, nchars);	/* erase_prompt () sets promptlen to 0 */
 			else
 				ctl->promptlen = 0;
-			if (nchars < ctl->Mcol || !ctl->fold_opt)
-				prbuf(ctl, "\n", 1);	/* will turn off UL if necessary */
+			if (nchars < ctl->ncolumns || !ctl->fold_opt)
+				print_buffer(ctl, "\n", 1);	/* will turn off UL if necessary */
 			if (nchars == STOP)
 				break;
 			num_lines--;
 		}
-		if (ctl->pstate) {
-			my_putstring(ctl->ULexit);
-			ctl->pstate = 0;
+		if (ctl->underlining) {
+			my_putstring(ctl->underline_exit);
+			ctl->underlining = 0;
 		}
 		fflush(stdout);
 		if ((c = more_getc(ctl, f)) == EOF) {
-			if (ctl->clreol)
-				my_putstring(ctl->EodClr);
+			if (ctl->clreol_opt)
+				my_putstring(ctl->end_clear);
 			return;
 		}
 
-		if (ctl->Pause && ctl->clreol)
-			my_putstring(ctl->EodClr);
+		if (ctl->pause && ctl->clreol_opt)
+			my_putstring(ctl->end_clear);
 		more_ungetc(ctl, c, f);
-		ctl->Pause = 0;
+		ctl->pause = 0;
 		do {
 			if ((num_lines = command(ctl, NULL, f)) == 0)
 				return;
 		} while (ctl->search_called && !ctl->previousre);
-		if (ctl->hard && ctl->promptlen > 0)
-			erasep(ctl, 0);
-		if (ctl->noscroll && num_lines >= ctl->dlines) {
-			if (ctl->clreol)
-				my_putstring(ctl->Home);
+		if (ctl->hard_term && ctl->promptlen > 0)
+			erase_prompt(ctl, 0);
+		if (ctl->noscroll_opt && num_lines >= ctl->lines_per_screen) {
+			if (ctl->clreol_opt)
+				my_putstring(ctl->go_home);
 			else
-				doclear(ctl);
+				clear_tty(ctl);
 		}
-		ctl->screen_start.line = ctl->Currline;
-		ctl->screen_start.chrctr = ctl->file_pos;
+		ctl->screen_start.line = ctl->current_line;
+		ctl->screen_start.nrow = ctl->file_pos;
 	}
 }
 
@@ -1793,38 +1793,38 @@ static void initterm(struct more_control *ctl)
 #ifdef TIOCGWINSZ
 			if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &win) < 0) {
 #endif
-				ctl->Lpp = my_tgetnum(TERM_LINES);
-				ctl->Mcol = my_tgetnum(TERM_COLS);
+				ctl->lines_per_page = my_tgetnum(TERM_LINES);
+				ctl->ncolumns = my_tgetnum(TERM_COLS);
 #ifdef TIOCGWINSZ
 			} else {
-				if ((ctl->Lpp = win.ws_row) == 0)
-					ctl->Lpp = my_tgetnum(TERM_LINES);
-				if ((ctl->Mcol = win.ws_col) == 0)
-					ctl->Mcol = my_tgetnum(TERM_COLS);
+				if ((ctl->lines_per_page = win.ws_row) == 0)
+					ctl->lines_per_page = my_tgetnum(TERM_LINES);
+				if ((ctl->ncolumns = win.ws_col) == 0)
+					ctl->ncolumns = my_tgetnum(TERM_COLS);
 			}
 #endif
-			if ((ctl->Lpp <= 0) || my_tgetflag(TERM_HARD_COPY)) {
-				ctl->hard = 1;
-				ctl->Lpp = LINES_PER_PAGE;
+			if ((ctl->lines_per_page <= 0) || my_tgetflag(TERM_HARD_COPY)) {
+				ctl->hard_term = 1;
+				ctl->lines_per_page = LINES_PER_PAGE;
 			}
 
 			if (my_tgetflag(TERM_EAT_NEW_LINE))
 				/* Eat newline at last column + 1; dec, concept */
 				ctl->eatnl = 1;
-			if (ctl->Mcol <= 0)
-				ctl->Mcol = NUM_COLUMNS;
+			if (ctl->ncolumns <= 0)
+				ctl->ncolumns = NUM_COLUMNS;
 
-			ctl->Wrap = my_tgetflag(TERM_AUTO_RIGHT_MARGIN);
+			ctl->wrap_margin = my_tgetflag(TERM_AUTO_RIGHT_MARGIN);
 			ctl->bad_so = my_tgetflag(TERM_CEOL);
 			ctl->eraseln = my_tgetstr(TERM_CLEAR_TO_LINE_END);
-			ctl->Clear = my_tgetstr(TERM_CLEAR);
-			ctl->Senter = my_tgetstr(TERM_STANDARD_MODE);
-			ctl->Sexit = my_tgetstr(TERM_EXIT_STANDARD_MODE);
+			ctl->clear = my_tgetstr(TERM_CLEAR);
+			ctl->std_enter = my_tgetstr(TERM_STANDARD_MODE);
+			ctl->std_exit = my_tgetstr(TERM_EXIT_STANDARD_MODE);
 			tmp = my_tgetnum(TERM_STD_MODE_GLITCH);
 			if (tmp < 0)
-				ctl->soglitch = 0;
+				ctl->stdout_glitch = 0;
 			else if (0 < tmp)
-				ctl->soglitch = 1;
+				ctl->stdout_glitch = 1;
 
 			/* Set up for underlining:  some terminals don't
 			 * need it; others have start/stop sequences,
@@ -1835,25 +1835,25 @@ static void initterm(struct more_control *ctl)
 			if (my_tgetflag(TERM_UNDERLINE)
 			    || my_tgetflag(TERM_OVER_STRIKE))
 				ctl->ul_opt = 0;
-			if ((ctl->chUL = my_tgetstr(TERM_UNDERLINE_CHAR)) == NULL)
-				ctl->chUL = "";
-			if (((ctl->ULenter =
+			if ((ctl->underlining_char = my_tgetstr(TERM_UNDERLINE_CHAR)) == NULL)
+				ctl->underlining_char = "";
+			if (((ctl->underline_enter =
 			      my_tgetstr(TERM_ENTER_UNDERLINE)) == NULL
-			     || (ctl->ULexit =
+			     || (ctl->underline_exit =
 				 my_tgetstr(TERM_EXIT_UNDERLINE)) == NULL)
-			    && !*ctl->chUL) {
-				if ((ctl->ULenter = ctl->Senter) == NULL
-				    || (ctl->ULexit = ctl->Sexit) == NULL) {
-					ctl->ULenter = "";
-					ctl->ULexit = "";
+			    && !*ctl->underlining_char) {
+				if ((ctl->underline_enter = ctl->std_enter) == NULL
+				    || (ctl->underline_exit = ctl->std_exit) == NULL) {
+					ctl->underline_enter = "";
+					ctl->underline_exit = "";
 				} else
-					ctl->ulglitch = ctl->soglitch;
+					ctl->ul_glitch = ctl->stdout_glitch;
 			} else {
-				ctl->ulglitch = 0;
+				ctl->ul_glitch = 0;
 			}
 
-			ctl->Home = my_tgetstr(TERM_HOME);
-			if (ctl->Home == NULL || *ctl->Home == '\0') {
+			ctl->go_home = my_tgetstr(TERM_HOME);
+			if (ctl->go_home == NULL || *ctl->go_home == '\0') {
 				if ((ctl->cursorm =
 				     my_tgetstr(TERM_CURSOR_ADDRESS)) != NULL) {
 					const char *t =
@@ -1861,12 +1861,12 @@ static void initterm(struct more_control *ctl)
 								   0);
 					xstrncpy(ctl->cursorhome, t,
 						 sizeof(ctl->cursorhome));
-					ctl->Home = ctl->cursorhome;
+					ctl->go_home = ctl->cursorhome;
 				}
 			}
-			ctl->EodClr = my_tgetstr(TERM_CLEAR_TO_SCREEN_END);
-			if ((ctl->chBS = my_tgetstr(TERM_LINE_DOWN)) == NULL)
-				ctl->chBS = "\b";
+			ctl->end_clear = my_tgetstr(TERM_CLEAR_TO_SCREEN_END);
+			if ((ctl->backspace_char = my_tgetstr(TERM_LINE_DOWN)) == NULL)
+				ctl->backspace_char = "\b";
 
 		}
 		if ((ctl->shell = getenv("SHELL")) == NULL)
@@ -1874,7 +1874,7 @@ static void initterm(struct more_control *ctl)
 	}
 	ctl->no_intty = tcgetattr(STDIN_FILENO, &ctl->otty);
 	tcgetattr(STDERR_FILENO, &ctl->otty);
-	ctl->savetty0 = ctl->otty;
+	ctl->orig_tty = ctl->otty;
 	ctl->hardtabs = (ctl->otty.c_oflag & TABDLY) != XTABS;
 	if (!ctl->no_tty) {
 		ctl->otty.c_lflag &= ~(ICANON | ECHO);
@@ -1885,46 +1885,46 @@ static void initterm(struct more_control *ctl)
 
 static void display_file(struct more_control *ctl, FILE *f, char *initbuf, int left)
 {
-	ctl->context.line = ctl->context.chrctr = 0;
-	ctl->Currline = 0;
+	ctl->context.line = ctl->context.nrow = 0;
+	ctl->current_line = 0;
 	ctl->file_pos = 0;
-	if (ctl->firstf) {
-		ctl->firstf = 0;
-		if (ctl->srchopt) {
+	if (ctl->first_file) {
+		ctl->first_file = 0;
+		if (ctl->search_opt) {
 			free(ctl->previousre);
 			ctl->previousre = xstrdup(initbuf);
 			search(ctl, initbuf, f, 1);
-			if (ctl->noscroll)
+			if (ctl->noscroll_opt)
 				left--;
 		} else if (ctl->jumpopt)
-			skiplns(ctl, f);
-	} else if (ctl->fnum < ctl->nfiles && !ctl->no_tty)
-		left = command(ctl, ctl->fnames[ctl->fnum], f);
+			skip_lines(ctl, f);
+	} else if (ctl->argv_position < ctl->nfiles && !ctl->no_tty)
+		left = command(ctl, ctl->fnames[ctl->argv_position], f);
 	if (left != 0) {
-		if ((ctl->noscroll || ctl->clearfirst)
+		if ((ctl->noscroll_opt || ctl->clearfirst)
 		    && (ctl->file_size != LONG_MAX)) {
-			if (ctl->clreol)
-				my_putstring(ctl->Home);
+			if (ctl->clreol_opt)
+				my_putstring(ctl->go_home);
 			else
-				doclear(ctl);
+				clear_tty(ctl);
 		}
-		if (ctl->prnames) {
+		if (ctl->print_names) {
 			if (ctl->bad_so)
-				erasep(ctl, 0);
-			if (ctl->clreol)
+				erase_prompt(ctl, 0);
+			if (ctl->clreol_opt)
 				my_putstring(ctl->eraseln);
 			fputs("::::::::::::::", stdout);
 			if (ctl->promptlen > 14)
-				erasep(ctl, 14);
+				erase_prompt(ctl, 14);
 			putchar('\n');
-			if (ctl->clreol)
+			if (ctl->clreol_opt)
 				my_putstring(ctl->eraseln);
-			puts(ctl->fnames[ctl->fnum]);
-			if (ctl->clreol)
+			puts(ctl->fnames[ctl->argv_position]);
+			if (ctl->clreol_opt)
 				my_putstring(ctl->eraseln);
 			puts("::::::::::::::");
-			if (left > ctl->Lpp - 4)
-				left = ctl->Lpp - 4;
+			if (left > ctl->lines_per_page - 4)
+				left = ctl->lines_per_page - 4;
 		}
 		if (ctl->no_tty)
 			copy_file(f);
@@ -1936,8 +1936,8 @@ static void display_file(struct more_control *ctl, FILE *f, char *initbuf, int l
 	}
 	fflush(stdout);
 	fclose(f);
-	ctl->screen_start.line = ctl->screen_start.chrctr = 0L;
-	ctl->context.line = ctl->context.chrctr = 0L;
+	ctl->screen_start.line = ctl->screen_start.nrow = 0L;
+	ctl->context.line = ctl->context.nrow = 0L;
 }
 
 int main(int argc, char **argv)
@@ -1949,14 +1949,14 @@ int main(int argc, char **argv)
 	char *initbuf = NULL;
 	sigset_t sigset;
 	struct more_control ctl = {
-		.firstf = 1,
+		.first_file = 1,
 		.fold_opt = 1,
 		.notell = 1,
 		.stop_opt = 1,
 		.ul_opt = 1,
-		.Wrap = 1,
-		.Lpp = LINES_PER_PAGE,
-		.Mcol = NUM_COLUMNS,
+		.wrap_margin = 1,
+		.lines_per_page = LINES_PER_PAGE,
+		.ncolumns = NUM_COLUMNS,
 		.nscroll = SCROLL_LEN,
 		0
 	};
@@ -1973,11 +1973,11 @@ int main(int argc, char **argv)
 
 	/* Auto set no scroll on when binary is called page */
 	if (!(strcmp(program_invocation_short_name, "page")))
-		ctl.noscroll = 1;
+		ctl.noscroll_opt = 1;
 
 	prepare_line_buffer(&ctl);
 
-	ctl.nscroll = ctl.Lpp / 2 - 1;
+	ctl.nscroll = ctl.lines_per_page / 2 - 1;
 	if (ctl.nscroll <= 0)
 		ctl.nscroll = 1;
 
@@ -1990,7 +1990,7 @@ int main(int argc, char **argv)
 		} else if (c == '+') {
 			s = *ctl.fnames;
 			if (*++s == '/') {
-				ctl.srchopt = 1;
+				ctl.search_opt = 1;
 				initbuf = xstrdup(s + 1);
 			} else {
 				ctl.jumpopt = 1;
@@ -2003,21 +2003,21 @@ int main(int argc, char **argv)
 		} else
 			break;
 	}
-	/* allow clreol only if Home and eraseln and EodClr strings are
+	/* allow clreol only if go_home and eraseln and end_clear strings are
 	 * defined, and in that case, make sure we are in noscroll mode */
-	if (ctl.clreol) {
-		if ((ctl.Home == NULL) || (*ctl.Home == '\0') ||
+	if (ctl.clreol_opt) {
+		if ((ctl.go_home == NULL) || (*ctl.go_home == '\0') ||
 		    (ctl.eraseln == NULL) || (*ctl.eraseln == '\0') ||
-		    (ctl.EodClr == NULL) || (*ctl.EodClr == '\0'))
-			ctl.clreol = 0;
+		    (ctl.end_clear == NULL) || (*ctl.end_clear == '\0'))
+			ctl.clreol_opt = 0;
 		else
-			ctl.noscroll = 1;
+			ctl.noscroll_opt = 1;
 	}
-	if (ctl.dlines == 0)
-		ctl.dlines = ctl.Lpp - 1;
-	left = ctl.dlines;
+	if (ctl.lines_per_screen == 0)
+		ctl.lines_per_screen = ctl.lines_per_page - 1;
+	left = ctl.lines_per_screen;
 	if (ctl.nfiles > 1)
-		ctl.prnames = 1;
+		ctl.print_names = 1;
 	if (!ctl.no_intty && ctl.nfiles == 0)
 		usage(stderr);
 	if (!ctl.no_tty)
@@ -2038,20 +2038,20 @@ int main(int argc, char **argv)
 			f = stdin;
 			display_file(&ctl, f, initbuf, left);
 		}
-		ctl.firstf = 0;
+		ctl.first_file = 0;
 		ctl.no_intty = 0;
-		ctl.prnames = 1;
+		ctl.print_names = 1;
 	}
 
-	for (/* nothing */; ctl.fnum < ctl.nfiles; ctl.fnum++) {
-		if ((f = checkf(&ctl, ctl.fnames[ctl.fnum])) == NULL)
+	for (/* nothing */; ctl.argv_position < ctl.nfiles; ctl.argv_position++) {
+		if ((f = more_fopen(&ctl, ctl.fnames[ctl.argv_position])) == NULL)
 			continue;
 		display_file(&ctl, f, initbuf, left);
-		ctl.firstf = 0;
+		ctl.first_file = 0;
 	}
 	free(ctl.previousre);
 	free(initbuf);
-	free(ctl.Line);
+	free(ctl.linebuf);
 	reset_tty(&ctl);
 	return EXIT_SUCCESS;
 }
-- 
2.3.0

