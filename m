Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:46637 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbbBVOoG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:06 -0500
Received: by mail-wi0-f175.google.com with SMTP id r20so11867554wiv.2
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:04 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 07/31] more: remove function like preprocessor defines
Date: Sun, 22 Feb 2015 14:43:03 +0000
Message-Id: <1424616207-747-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This sort of weird abstraction makes code readability worse without much
of any sort of gain.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 266 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 147 insertions(+), 119 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index ba5459a..01c999e 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -84,27 +84,6 @@
 # define XTABS	TAB3
 #endif
 
-#define Fopen(s, m)	(ctl->Currline = 0, ctl->file_pos=0, fopen(s,m))
-#define Ftell(f)	ctl->file_pos
-#define Fseek(f, off)	(ctl->file_pos=off, fseek(f, off, 0))
-#define Getc(f)		(++ctl->file_pos, getc(f))
-#define Ungetc(c, f)	(--ctl->file_pos, ungetc(c, f))
-#define putcerr(c)	fputc(c, stderr)
-#define putserr(s)	fputs(s, stderr)
-#define putsout(s)	fputs(s, stdout)
-
-#define stty(fd, argp)	tcsetattr(fd, TCSANOW, argp)
-#define ringbell()	putcerr('\007')
-
-static char *BS = "\b";
-static char *BSB = "\b \b";
-static char *CARAT = "^";
-#define ERASEONECOLUMN \
-    if (ctl->docrterase) \
-	putserr(BSB); \
-    else \
-	putserr(BS);
-
 #define TBUFSIZ		1024
 #define LINSIZ		256	/* minimal Line buffer size */
 #define ctrl(letter)	(letter & 077)
@@ -320,6 +299,24 @@ static int magic(FILE *f, char *fs)
 	return 0;
 }
 
+static void set_pos_fseek(struct more_control *ctl, FILE *stream, long pos)
+{
+	ctl->file_pos = pos;
+	fseek(stream, pos, 0);
+}
+
+static int more_getc(struct more_control *ctl, FILE *stream)
+{
+	ctl->file_pos++;
+	return getc(stream);
+}
+
+static int more_ungetc(struct more_control *ctl, int c, FILE *stream)
+{
+	ctl->file_pos--;
+	return ungetc(c, stream);
+}
+
 /* Check whether the file named by fs is an ASCII file which the user may
  * access.  If it is, return the opened file.  Otherwise return NULL. */
 static FILE *checkf(struct more_control *ctl, register char *fs, int *clearfirst)
@@ -339,7 +336,9 @@ static FILE *checkf(struct more_control *ctl, register char *fs, int *clearfirst
 		printf(_("\n*** %s: directory ***\n\n"), fs);
 		return NULL;
 	}
-	if ((f = Fopen(fs, "r")) == NULL) {
+	ctl->Currline = 0;
+	ctl->file_pos = 0;
+	if ((f = fopen(fs, "r")) == NULL) {
 		fflush(stdout);
 		warn(_("cannot open %s"), fs);
 		return NULL;
@@ -349,9 +348,9 @@ static FILE *checkf(struct more_control *ctl, register char *fs, int *clearfirst
 		return NULL;
 	}
 	fcntl(fileno(f), F_SETFD, FD_CLOEXEC);
-	c = Getc(f);
+	c = more_getc(ctl, f);
 	*clearfirst = (c == '\f');
-	Ungetc(c, f);
+	more_ungetc(ctl, c, f);
 	if ((ctl->file_size = stbuf.st_size) == 0)
 		ctl->file_size = LONG_MAX;
 	return f;
@@ -390,7 +389,7 @@ static int get_line(struct more_control *ctl, register FILE *f, int *length)
 	size_t mbc_pos = 0;		/* Position of the MBC. */
 	int use_mbc_buffer_flag = 0;	/* If 1, mbc has data. */
 	int break_flag = 0;		/* If 1, exit while(). */
-	long file_pos_bak = Ftell(f);
+	long file_pos_bak = ctl->file_pos;
 
 	memset(&state, 0, sizeof state);
 #endif
@@ -398,10 +397,10 @@ static int get_line(struct more_control *ctl, register FILE *f, int *length)
 
 	p = ctl->Line;
 	column = 0;
-	c = Getc(f);
+	c = more_getc(ctl, f);
 	if (colflg && c == '\n') {
 		ctl->Currline++;
-		c = Getc(f);
+		c = more_getc(ctl, f);
 	}
 	while (p < &ctl->Line[ctl->LineLen - 1]) {
 #ifdef HAVE_WIDECHAR
@@ -424,9 +423,9 @@ static int get_line(struct more_control *ctl, register FILE *f, int *length)
 				column++;
 				file_pos_bak++;
 
-				if (column >= ctl->Mcol) {
-					Fseek(f, file_pos_bak);
-				} else {
+				if (column >= ctl->Mcol)
+					set_pos_fseek(ctl, f, file_pos_bak);
+				else {
 					memmove(mbc, mbc + 1, --mbc_pos);
 					if (mbc_pos > 0) {
 						mbc[mbc_pos] = '\0';
@@ -439,7 +438,7 @@ static int get_line(struct more_control *ctl, register FILE *f, int *length)
 				wc_width = wcwidth(wc);
 
 				if (column + wc_width > ctl->Mcol) {
-					Fseek(f, file_pos_bak);
+					set_pos_fseek(ctl, f, file_pos_bak);
 					break_flag = 1;
 				} else {
 					for (i = 0; p < &ctl->Line[ctl->LineLen - 1] &&
@@ -453,7 +452,7 @@ static int get_line(struct more_control *ctl, register FILE *f, int *length)
 			if (break_flag || column >= ctl->Mcol)
 				break;
 
-			c = Getc(f);
+			c = more_getc(ctl, f);
 			continue;
 		}
 #endif	/* HAVE_WIDECHAR */
@@ -492,13 +491,13 @@ static int get_line(struct more_control *ctl, register FILE *f, int *length)
 		} else if (c == '\b' && column > 0) {
 			column--;
 		} else if (c == '\r') {
-			int next = Getc(f);
+			int next = more_getc(ctl, f);
 			if (next == '\n') {
 				p--;
 				ctl->Currline++;
 				break;
 			}
-			Ungetc(next, f);
+			more_ungetc(ctl, next, f);
 			column = 0;
 		} else if (c == '\f' && ctl->stop_opt) {
 			p[-1] = '^';
@@ -521,7 +520,7 @@ static int get_line(struct more_control *ctl, register FILE *f, int *length)
 				switch (mblength) {
 				case (size_t)-2:
 					p--;
-					file_pos_bak = Ftell(f) - 1;
+					file_pos_bak = ctl->file_pos - 1;
 					state = state_bak;
 					use_mbc_buffer_flag = 1;
 					break;
@@ -552,7 +551,7 @@ static int get_line(struct more_control *ctl, register FILE *f, int *length)
 			 * whole multibyte sequence */
 			break;
 #endif
-		c = Getc(f);
+		c = more_getc(ctl, f);
 	}
 	if (column >= ctl->Mcol && ctl->Mcol > 0) {
 		if (!ctl->Wrap) {
@@ -601,12 +600,20 @@ static UL_ASAN_BLACKLIST size_t xmbrtowc(wchar_t *wc, const char *s, size_t n,
 	return mblength;
 }
 
+static int wouldul(char *s, int n)
+{
+	if (n < 2)
+		return 0;
+	if ((s[0] == '_' && s[1] == '\b') || (s[1] == '\b' && s[2] == '_'))
+		return 1;
+	return 0;
+}
+
 /* Print a buffer of n characters */
 static void prbuf(struct more_control *ctl, register char *s, register int n)
 {
 	register char c;	/* next output character */
 	register int state;	/* next output char's UL state */
-#define wouldul(s,n)	((n) >= 2 && (((s)[0] == '_' && (s)[1] == '\b') || ((s)[1] == '\b' && (s)[2] == '_')))
 
 	while (--n >= 0)
 		if (!ctl->ul_opt)
@@ -650,7 +657,7 @@ static void prbuf(struct more_control *ctl, register char *s, register int n)
 				putchar(c);
 #endif				/* HAVE_WIDECHAR */
 			if (state && *ctl->chUL) {
-				putsout(ctl->chBS);
+				fputs(ctl->chBS, stdout);
 				my_putstring(ctl->chUL);
 			}
 			ctl->pstate = state;
@@ -697,7 +704,7 @@ static void prompt(struct more_control *ctl, char *filename)
 			clreos(ctl);
 		fflush(stdout);
 	} else
-		ringbell();
+		fputc('\a', stderr);
 	ctl->inwait = 1;
 }
 
@@ -718,7 +725,7 @@ static void reset_tty(struct more_control *ctl)
 	ctl->otty.c_lflag |= ICANON | ECHO;
 	ctl->otty.c_cc[VMIN] = ctl->savetty0.c_cc[VMIN];
 	ctl->otty.c_cc[VTIME] = ctl->savetty0.c_cc[VTIME];
-	stty(fileno(stderr), &ctl->savetty0);
+	tcsetattr(STDERR_FILENO, TCSANOW, &ctl->savetty0);
 }
 
 /* Clean up terminal state and exit. Also come here if interrupt signal received */
@@ -733,7 +740,7 @@ static void __attribute__((__noreturn__)) end_it(int dummy __attribute__((__unus
 		kill_line(global_ctl);
 		fflush(stdout);
 	} else
-		putcerr('\n');
+		fputc('\n', stderr);
 	free(global_ctl->previousre);
 	free(global_ctl->Line);
 	_exit(EXIT_SUCCESS);
@@ -793,9 +800,9 @@ static void skipf(struct more_control *ctl, register int nskip)
 	if (ctl->clreol)
 		cleareol(ctl);
 	if (nskip > 0)
-		putsout(_("...Skipping to file "));
+		fputs(_("...Skipping to file "), stdout);
 	else
-		putsout(_("...Skipping back to file "));
+		fputs(_("...Skipping back to file "), stdout);
 	puts(ctl->fnames[ctl->fnum]);
 	if (ctl->clreol)
 		cleareol(ctl);
@@ -807,10 +814,10 @@ static void show(struct more_control *ctl, char c)
 {
 	if ((c < ' ' && c != '\n' && c != ESC) || c == RUBOUT) {
 		c += (c == RUBOUT) ? -0100 : 0100;
-		putserr(CARAT);
+		fputs("^", stderr);
 		ctl->promptlen++;
 	}
-	putcerr(c);
+	fputc(c, stderr);
 	ctl->promptlen++;
 }
 
@@ -823,15 +830,23 @@ static void more_error(struct more_control *ctl, char *mess)
 	ctl->promptlen += strlen(mess);
 	if (ctl->Senter && ctl->Sexit) {
 		my_putstring(ctl->Senter);
-		putsout(mess);
+		fputs(mess, stdout);
 		my_putstring(ctl->Sexit);
 	} else
-		putsout(mess);
+		fputs(mess, stdout);
 	fflush(stdout);
 	ctl->errors++;
 	siglongjmp(ctl->restore, 1);
 }
 
+static void erase_one_column(struct more_control *ctl)
+{
+	if (ctl->docrterase)
+		fputs("\b \b", stderr);
+	else
+		fputs("\b", stderr);
+}
+
 static void ttyin(struct more_control *ctl, char buf[], register int nmax, char pchar)
 {
 	char *sp;
@@ -878,15 +893,16 @@ static void ttyin(struct more_control *ctl, char buf[], register int nmax, char
 						pos += mblength;
 					}
 
-					if (mblength == 1) {
-					ERASEONECOLUMN} else {
+					if (mblength == 1)
+						erase_one_column(ctl);
+					else {
 						int wc_width;
 						wc_width = wcwidth(wc);
 						wc_width =
 						    (wc_width <
 						     1) ? 1 : wc_width;
-						while (wc_width--) {
-						ERASEONECOLUMN}
+						while (wc_width--)
+							erase_one_column(ctl);
 					}
 
 					while (mblength--) {
@@ -897,12 +913,14 @@ static void ttyin(struct more_control *ctl, char buf[], register int nmax, char
 #endif	/* HAVE_WIDECHAR */
 				{
 					ctl->promptlen--;
-					ERASEONECOLUMN-- sp;
+					erase_one_column(ctl);
+					sp--;
 				}
 
 				if ((*sp < ' ' && *sp != '\n') || *sp == RUBOUT) {
 					ctl->promptlen--;
-				ERASEONECOLUMN}
+					erase_one_column(ctl);
+				}
 				continue;
 			} else {
 				if (!ctl->eraseln)
@@ -921,7 +939,7 @@ static void ttyin(struct more_control *ctl, char buf[], register int nmax, char
 					erasep(ctl, 1);
 				else if (ctl->docrtkill)
 					while (ctl->promptlen-- > 1)
-						putserr(BSB);
+						fputs("\b \b", stderr);
 				ctl->promptlen = 1;
 			}
 			sp = buf;
@@ -930,18 +948,19 @@ static void ttyin(struct more_control *ctl, char buf[], register int nmax, char
 		}
 		if (slash && ((cc_t) c == ctl->otty.c_cc[VKILL]
 			      || (cc_t) c == ctl->otty.c_cc[VERASE])) {
-			ERASEONECOLUMN-- sp;
+			erase_one_column(ctl);
+			sp--;
 		}
 		if (c != '\\')
 			slash = 0;
 		*sp++ = c;
 		if ((c < ' ' && c != '\n' && c != ESC) || c == RUBOUT) {
 			c += (c == RUBOUT) ? -0100 : 0100;
-			putserr(CARAT);
+			fputs("^", stderr);
 			ctl->promptlen++;
 		}
 		if (c != '\n' && c != ESC) {
-			putcerr(c);
+			fputc(c, stderr);
 			ctl->promptlen++;
 		} else
 			break;
@@ -1010,7 +1029,7 @@ static void set_tty(struct more_control *ctl)
 	ctl->otty.c_lflag &= ~(ICANON | ECHO);
 	ctl->otty.c_cc[VMIN] = 1;	/* read at least 1 char */
 	ctl->otty.c_cc[VTIME] = 0;	/* no timeout */
-	stty(fileno(stderr), &ctl->otty);
+	tcsetattr(STDERR_FILENO, TCSANOW, &ctl->otty);
 }
 
 /* Come here if a quit signal is received */
@@ -1103,7 +1122,7 @@ static void execute(struct more_control *ctl, char *filename, char *cmd, ...)
 		va_end(argp);
 
 		execvp(cmd, args);
-		putserr(_("exec failed\n"));
+		fputs(_("exec failed\n"), stderr);
 		exit(EXIT_FAILURE);
 	}
 	if (id > 0) {
@@ -1117,7 +1136,7 @@ static void execute(struct more_control *ctl, char *filename, char *cmd, ...)
 		if (ctl->catch_susp)
 			signal(SIGTSTP, onsusp);
 	} else
-		putserr(_("can't fork\n"));
+		fputs(_("can't fork\n"), stderr);
 	set_tty(ctl);
 	puts("------------------------");
 	prompt(ctl, filename);
@@ -1134,7 +1153,7 @@ static void do_shell(struct more_control *ctl, char *filename)
 	fflush(stdout);
 	ctl->promptlen = 1;
 	if (ctl->lastp)
-		putsout(ctl->shell_line);
+		fputs(ctl->shell_line, stdout);
 	else {
 		ttyin(ctl, cmdbuf, sizeof(cmdbuf) - 2, '!');
 		expanded = 0;
@@ -1147,7 +1166,7 @@ static void do_shell(struct more_control *ctl, char *filename)
 			free(expanded);
 		}
 		if (rc < 0) {
-			putserr(_("  Overflow\n"));
+			fputs(_("  Overflow\n"), stderr);
 			prompt(ctl, filename);
 			return;
 		} else if (rc > 0) {
@@ -1156,7 +1175,7 @@ static void do_shell(struct more_control *ctl, char *filename)
 		}
 	}
 	fflush(stdout);
-	putcerr('\n');
+	fputc('\n', stderr);
 	ctl->promptlen = 0;
 	ctl->shellp = 1;
 	execute(ctl, filename, ctl->shell, ctl->shell, "-c", ctl->shell_line, 0);
@@ -1195,7 +1214,7 @@ static int colon(struct more_control *ctl, char *filename, int cmd, int nlines)
 		return 0;
 	case 'p':
 		if (ctl->no_intty) {
-			ringbell();
+			fputc('\a', stderr);
 			return -1;
 		}
 		putchar('\r');
@@ -1211,7 +1230,7 @@ static int colon(struct more_control *ctl, char *filename, int cmd, int nlines)
 	case 'Q':
 		end_it(0);
 	default:
-		ringbell();
+		fputc('\a', stderr);
 		return -1;
 	}
 }
@@ -1222,7 +1241,7 @@ static void skiplns(struct more_control *ctl, register int n, register FILE *f)
 	register int c;
 
 	while (n > 0) {
-		while ((c = Getc(f)) != '\n')
+		while ((c = more_getc(ctl, f)) != '\n')
 			if (c == EOF)
 				return;
 		n--;
@@ -1250,7 +1269,7 @@ static void rdline(struct more_control *ctl, register FILE *f)
 	prepare_line_buffer(ctl);
 
 	p = ctl->Line;
-	while ((c = Getc(f)) != '\n' && c != EOF
+	while ((c = more_getc(ctl, f)) != '\n' && c != EOF
 	       && (size_t)(p - ctl->Line) < ctl->LineLen - 1)
 		*p++ = c;
 	if (c == '\n')
@@ -1268,7 +1287,7 @@ static void home(struct more_control *ctl)
  * the file */
 static void search(struct more_control *ctl, char buf[], FILE *file, register int n)
 {
-	long startline = Ftell(file);
+	long startline = ctl->file_pos;
 	register long line1 = startline;
 	register long line2 = startline;
 	register long line3;
@@ -1289,7 +1308,7 @@ static void search(struct more_control *ctl, char buf[], FILE *file, register in
 	while (!feof(file)) {
 		line3 = line2;
 		line2 = line1;
-		line1 = Ftell(file);
+		line1 = ctl->file_pos;
 		rdline(ctl, file);
 		lncount++;
 		if (regexec(&re, ctl->Line, 0, NULL, 0) == 0) {
@@ -1298,12 +1317,12 @@ static void search(struct more_control *ctl, char buf[], FILE *file, register in
 					putchar('\n');
 					if (ctl->clreol)
 						cleareol(ctl);
-					putsout(_("...skipping\n"));
+					fputs(_("...skipping\n"), stdout);
 				}
 				if (!ctl->no_intty) {
 					ctl->Currline -=
 					    (lncount >= 3 ? 3 : lncount);
-					Fseek(file, line3);
+					set_pos_fseek(ctl, file, line3);
 					if (ctl->noscroll) {
 						if (ctl->clreol) {
 							home(ctl);
@@ -1330,9 +1349,9 @@ static void search(struct more_control *ctl, char buf[], FILE *file, register in
 	if (feof(file)) {
 		if (!ctl->no_intty) {
 			ctl->Currline = saveln;
-			Fseek(file, startline);
+			set_pos_fseek(ctl, file, startline);
 		} else {
-			putsout(_("\nPattern not found\n"));
+			fputs(_("\nPattern not found\n"), stdout);
 			end_it(0);
 		}
 		free(ctl->previousre);
@@ -1352,17 +1371,14 @@ static int command(struct more_control *ctl, char *filename, register FILE *f)
 	register int retval = 0;
 	register int c;
 	char colonch;
-	int done;
+	int done = 0;
 	char comchar, cmdbuf[INIT_BUF];
 
-#define ret(val) retval=val;done++;break
-
-	done = 0;
 	if (!ctl->errors)
 		prompt(ctl, filename);
 	else
 		ctl->errors = 0;
-	for (;;) {
+	while (!done) {
 		nlines = number(ctl, &comchar);
 		ctl->lastp = colonch = 0;
 		if (comchar == '.') {	/* Repeat last command */
@@ -1391,7 +1407,7 @@ static int command(struct more_control *ctl, char *filename, register FILE *f)
 				register int initline;
 
 				if (ctl->no_intty) {
-					ringbell();
+					fputc('\a', stderr);
 					return -1;
 				}
 
@@ -1415,13 +1431,17 @@ static int command(struct more_control *ctl, char *filename, register FILE *f)
 					--initline;
 				if (initline < 0)
 					initline = 0;
-				Fseek(f, 0L);
+				set_pos_fseek(ctl, f, 0);
 				ctl->Currline = 0;	/* skiplns() will make Currline correct */
 				skiplns(ctl, initline, f);
 				if (!ctl->noscroll) {
-					ret(ctl->dlines + 1);
+					retval = ctl->dlines + 1;
+					done = 1;
+					break;
 				}
-				ret(ctl->dlines);
+				retval = ctl->dlines;
+				done = 1;
+				break;
 			}
 		case ' ':
 		case 'z':
@@ -1429,12 +1449,16 @@ static int command(struct more_control *ctl, char *filename, register FILE *f)
 				nlines = ctl->dlines;
 			else if (comchar == 'z')
 				ctl->dlines = nlines;
-			ret(nlines);
+			retval = nlines;
+			done = 1;
+			break;
 		case 'd':
 		case ctrl('D'):
 			if (nlines != 0)
 				ctl->nscroll = nlines;
-			ret(ctl->nscroll);
+			retval = ctl->nscroll;
+			done = 1;
+			break;
 		case 'q':
 		case 'Q':
 			end_it(0);
@@ -1459,7 +1483,7 @@ static int command(struct more_control *ctl, char *filename, register FILE *f)
 			putchar('\n');
 
 			while (nlines > 0) {
-				while ((c = Getc(f)) != '\n')
+				while ((c = more_getc(ctl, f)) != '\n')
 					if (c == EOF) {
 						retval = 0;
 						done++;
@@ -1468,34 +1492,40 @@ static int command(struct more_control *ctl, char *filename, register FILE *f)
 				ctl->Currline++;
 				nlines--;
 			}
-			ret(ctl->dlines);
+			retval = ctl->dlines;
+			done = 1;
+			break;
 		case '\n':
 			if (nlines != 0)
 				ctl->dlines = nlines;
 			else
 				nlines = 1;
-			ret(nlines);
+			retval = nlines;
+			done = 1;
+			break;
 		case '\f':
 			if (!ctl->no_intty) {
 				doclear(ctl);
-				Fseek(f, ctl->screen_start.chrctr);
+				set_pos_fseek(ctl, f, ctl->screen_start.chrctr);
 				ctl->Currline = ctl->screen_start.line;
-				ret(ctl->dlines);
-			} else {
-				ringbell();
+				retval = ctl->dlines;
+				done = 1;
 				break;
 			}
+			fputc('\a', stderr);
+			break;
 		case '\'':
 			if (!ctl->no_intty) {
 				kill_line(ctl);
-				putsout(_("\n***Back***\n\n"));
-				Fseek(f, ctl->context.chrctr);
+				fputs(_("\n***Back***\n\n"), stdout);
+				set_pos_fseek(ctl, f, ctl->context.chrctr);
 				ctl->Currline = ctl->context.line;
-				ret(lines);
-			} else {
-				ringbell();
+				retval = lines;
+				done = 1;
 				break;
 			}
+			fputc('\a', stderr);
+			break;
 		case '=':
 			kill_line(ctl);
 			ctl->promptlen = printf("%d", ctl->Currline);
@@ -1516,16 +1546,18 @@ static int command(struct more_control *ctl, char *filename, register FILE *f)
 			ctl->promptlen = 1;
 			fflush(stdout);
 			if (ctl->lastp) {
-				putcerr('\r');
+				fputc('\r', stderr);
 				search(ctl, ctl->previousre, f, nlines);
 			} else {
 				ttyin(ctl, cmdbuf, sizeof(cmdbuf) - 2, '/');
-				putcerr('\r');
+				fputc('\r', stderr);
 				free(ctl->previousre);
 				ctl->previousre = xstrdup(cmdbuf);
 				search(ctl, cmdbuf, f, nlines);
 			}
-			ret(ctl->dlines - 1);
+			retval = ctl->dlines - 1;
+			done = 1;
+			break;
 		case '!':
 			do_shell(ctl, filename);
 			break;
@@ -1533,13 +1565,13 @@ static int command(struct more_control *ctl, char *filename, register FILE *f)
 		case 'h':
 			if (ctl->noscroll)
 				doclear(ctl);
-			putsout(_("\n"
+			fputs(_("\n"
 				  "Most commands optionally preceded by integer argument k.  "
 				  "Defaults in brackets.\n"
-				  "Star (*) indicates argument becomes new default.\n"));
-			puts("---------------------------------------"
-			     "----------------------------------------");
-			putsout(_
+				  "Star (*) indicates argument becomes new default.\n"), stdout);
+			fputs("---------------------------------------"
+			     "----------------------------------------", stdout);
+			fputs(_
 				("<space>                 Display next k lines of text [current screen size]\n"
 				 "z                       Display next k lines of text [current screen size]*\n"
 				 "<return>                Display next k lines of text [1]*\n"
@@ -1558,9 +1590,9 @@ static int command(struct more_control *ctl, char *filename, register FILE *f)
 				 ":n                      Go to kth next file [1]\n"
 				 ":p                      Go to kth previous file [1]\n"
 				 ":f                      Display current file name and line number\n"
-				 ".                       Repeat previous command\n"));
-			puts("---------------------------------------"
-			     "----------------------------------------");
+				 ".                       Repeat previous command\n"), stdout);
+			fputs("---------------------------------------"
+			      "----------------------------------------", stdout);
 			prompt(ctl, filename);
 			break;
 		case 'v':	/* This case should go right before default */
@@ -1622,11 +1654,9 @@ static int command(struct more_control *ctl, char *filename, register FILE *f)
 						   ("[Press 'h' for instructions.]"));
 				fflush(stdout);
 			} else
-				ringbell();
+				fputc('\a', stderr);
 			break;
 		}
-		if (done)
-			break;
 	}
 	putchar('\r');
  endsw:
@@ -1677,7 +1707,7 @@ static void screen(struct more_control *ctl, register FILE *f, register int num_
 			ctl->pstate = 0;
 		}
 		fflush(stdout);
-		if ((c = Getc(f)) == EOF) {
+		if ((c = more_getc(ctl, f)) == EOF) {
 			if (ctl->clreol)
 				clreos(ctl);
 			return;
@@ -1685,7 +1715,7 @@ static void screen(struct more_control *ctl, register FILE *f, register int num_
 
 		if (ctl->Pause && ctl->clreol)
 			clreos(ctl);
-		Ungetc(c, f);
+		more_ungetc(ctl, c, f);
 		sigsetjmp(ctl->restore, 1);
 		ctl->Pause = 0;
 		ctl->startup = 0;
@@ -1700,7 +1730,7 @@ static void screen(struct more_control *ctl, register FILE *f, register int num_
 				doclear(ctl);
 		}
 		ctl->screen_start.line = ctl->Currline;
-		ctl->screen_start.chrctr = Ftell(f);
+		ctl->screen_start.chrctr = ctl->file_pos;
 	}
 }
 
@@ -1949,18 +1979,16 @@ int main(int argc, char **argv)
 			signal(SIGTSTP, onsusp);
 			ctl.catch_susp = 1;
 		}
-		stty(fileno(stderr), &ctl.otty);
+		tcsetattr(STDERR_FILENO, TCSANOW, &ctl.otty);
 	}
 	if (ctl.no_intty) {
 		if (ctl.no_tty)
 			copy_file(stdin);
 		else {
-			ctl.file_pos++;
-			if ((c = getc(f)) == '\f')
+			if ((c = more_getc(&ctl, f)) == '\f')
 				doclear(&ctl);
 			else {
-				ctl.file_pos--;
-				ungetc(c, f);
+				more_ungetc(&ctl, c, f);
 				if (ctl.noscroll && (c != EOF)) {
 					if (ctl.clreol)
 						home(&ctl);
@@ -2016,7 +2044,7 @@ int main(int argc, char **argv)
 						erasep(&ctl, 0);
 					if (ctl.clreol)
 						cleareol(&ctl);
-					putsout("::::::::::::::");
+					fputs("::::::::::::::", stdout);
 					if (ctl.promptlen > 14)
 						erasep(&ctl, 14);
 					putchar('\n');
-- 
2.3.0

