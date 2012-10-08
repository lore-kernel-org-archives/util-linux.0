Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:56911 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549Ab2JHHJD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Oct 2012 03:09:03 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so3448340wib.1
        for <util-linux@vger.kernel.org>; Mon, 08 Oct 2012 00:09:02 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/14] pg: fix coding style
Date: Mon,  8 Oct 2012 08:08:16 +0100
Message-Id: <1349680100-18120-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
References: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/pg.c | 699 ++++++++++++++++++++++++--------------------------------
 1 file changed, 296 insertions(+), 403 deletions(-)

diff --git a/text-utils/pg.c b/text-utils/pg.c
index 3d278bf..cdee117 100644
--- a/text-utils/pg.c
+++ b/text-utils/pg.c
@@ -35,7 +35,7 @@
 #include <sys/wait.h>
 #include <sys/stat.h>
 #ifndef	TIOCGWINSZ
-#include <sys/ioctl.h>
+# include <sys/ioctl.h>
 #endif
 #include <sys/termios.h>
 #include <fcntl.h>
@@ -52,9 +52,9 @@
 #include <libgen.h>
 
 #ifdef HAVE_NCURSES_H
-#include <ncurses.h>
+# include <ncurses.h>
 #elif defined(HAVE_NCURSES_NCURSES_H)
-#include <ncurses/ncurses.h>
+# include <ncurses/ncurses.h>
 #endif
 
 #include <term.h>
@@ -75,9 +75,7 @@
 enum { FORWARD = 1, BACKWARD = 2 };	/* search direction */
 enum { TOP, MIDDLE, BOTTOM };		/* position of matching line */
 
-/*
- * States for syntax-aware command line editor.
- */
+/* States for syntax-aware command line editor. */
 enum {
 	COUNT,
 	SIGN,
@@ -89,9 +87,7 @@ enum {
 	INVALID
 };
 
-/*
- * Current command
- */
+/* Current command */
 struct {
 	char cmdline[CMDBUF];
 	size_t cmdlen;
@@ -101,42 +97,40 @@ struct {
 	char addon;
 } cmd;
 
-/*
- * Position of file arguments on argv[] to main()
- */
+/* Position of file arguments on argv[] to main() */
 struct {
 	int first;
 	int current;
 	int last;
 } files;
 
-void		(*oldint)(int);		/* old SIGINT handler */
-void		(*oldquit)(int);	/* old SIGQUIT handler */
-void		(*oldterm)(int);	/* old SIGTERM handler */
-char		*tty;			/* result of ttyname(1) */
-unsigned	ontty;			/* whether running on tty device */
-unsigned	exitstatus;		/* exit status */
-int		pagelen = 23;		/* lines on a single screen page */
-int		ttycols = 79;		/* screen columns (starting at 0) */
-struct termios	otio;			/* old termios settings */
-int		tinfostat = -1;		/* terminfo routines initialized */
-int		searchdisplay = TOP;	/* matching line position */
-regex_t		re;			/* regular expression to search for */
-int		remembered;		/* have a remembered search string */
-int		cflag;			/* clear screen before each page */
-int		eflag;			/* suppress (EOF) */
-int		fflag;			/* do not split lines */
-int		nflag;			/* no newline for commands required */
-int		rflag;			/* "restricted" pg */
-int		sflag;			/* use standout mode */
-const char	*pstring = ":";		/* prompt string */
-char		*searchfor;		/* search pattern from argv[] */
-int		havepagelen;		/* page length is manually defined */
-long		startline;		/* start line from argv[] */
-int		nextfile = 1;		/* files to advance */
-jmp_buf		jmpenv;			/* jump from signal handlers */
-int		canjump;		/* jmpenv is valid */
-wchar_t		wbuf[READBUF];		/* used in several widechar routines */
+void (*oldint) (int);		/* old SIGINT handler */
+void (*oldquit) (int);		/* old SIGQUIT handler */
+void (*oldterm) (int);		/* old SIGTERM handler */
+char *tty;			/* result of ttyname(1) */
+unsigned ontty;			/* whether running on tty device */
+unsigned exitstatus;		/* exit status */
+int pagelen = 23;		/* lines on a single screen page */
+int ttycols = 79;		/* screen columns (starting at 0) */
+struct termios otio;		/* old termios settings */
+int tinfostat = -1;		/* terminfo routines initialized */
+int searchdisplay = TOP;	/* matching line position */
+regex_t re;			/* regular expression to search for */
+int remembered;			/* have a remembered search string */
+int cflag;			/* clear screen before each page */
+int eflag;			/* suppress (EOF) */
+int fflag;			/* do not split lines */
+int nflag;			/* no newline for commands required */
+int rflag;			/* "restricted" pg */
+int sflag;			/* use standout mode */
+const char *pstring = ":";	/* prompt string */
+char *searchfor;		/* search pattern from argv[] */
+int havepagelen;		/* page length is manually defined */
+long startline;			/* start line from argv[] */
+int nextfile = 1;		/* files to advance */
+jmp_buf jmpenv;			/* jump from signal handlers */
+int canjump;			/* jmpenv is valid */
+wchar_t wbuf[READBUF];		/* used in several widechar routines */
 
 char *copyright;
 const char *helpscreen = N_("\
@@ -164,28 +158,34 @@ See pg(1) for more information.\n\
 -------------------------------------------------------\n");
 
 #ifndef HAVE_FSEEKO
-  static int fseeko(FILE *f, off_t off, int whence) {
-	return fseek(f, (long) off, whence);
-  }
-  static off_t ftello(FILE *f) {
+static int fseeko(FILE *f, off_t off, int whence)
+{
+	return fseek(f, (long)off, whence);
+}
+
+static off_t ftello(FILE *f)
+{
 	return (off_t) ftell(f);
-  }
+}
 #endif
 
 #ifdef USE_SIGSET	/* never defined */
 /* sigset and sigrelse are obsolete - use when POSIX stuff is unavailable */
-#define my_sigset	sigset
-#define my_sigrelse	sigrelse
+# define my_sigset	sigset
+# define my_sigrelse	sigrelse
 #else
-static int my_sigrelse(int sig) {
+static int my_sigrelse(int sig)
+{
 	sigset_t sigs;
 
 	if (sigemptyset(&sigs) || sigaddset(&sigs, sig))
 		return -1;
 	return sigprocmask(SIG_UNBLOCK, &sigs, NULL);
 }
-typedef void (*my_sighandler_t)(int);
-static my_sighandler_t my_sigset(int sig, my_sighandler_t disp) {
+
+typedef void (*my_sighandler_t) (int);
+static my_sighandler_t my_sigset(int sig, my_sighandler_t disp)
+{
 	struct sigaction act, oact;
 
 	act.sa_handler = disp;
@@ -198,25 +198,20 @@ static my_sighandler_t my_sigset(int sig, my_sighandler_t disp) {
 		return SIG_ERR;
 	return oact.sa_handler;
 }
-#endif
+#endif	/* USE_SIGSET */
 
-/*
- * Quit pg.
- */
-static void __attribute__((__noreturn__))
-quit(int status)
+/* Quit pg. */
+static void __attribute__((__noreturn__)) quit(int status)
 {
 	exit(status < 0100 ? status : 077);
 }
 
-/*
- * Usage message and similar routines.
- */
-static void __attribute__((__noreturn__)) usage(FILE * out)
+/* Usage message and similar routines. */
+static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
-	      _(" %s [options] [+line] [+/pattern/] [files]\n"),
+		_(" %s [options] [+line] [+/pattern/] [files]\n"),
 		program_invocation_short_name);
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -number      lines per page\n"), out);
@@ -235,31 +230,27 @@ static void __attribute__((__noreturn__)) usage(FILE * out)
 	quit(out == stderr ? 2 : 0);
 }
 
-static void __attribute__((__noreturn__))
-needarg(const char *s)
+static void __attribute__((__noreturn__)) needarg(const char *s)
 {
 	warnx(_("option requires an argument -- %s"), s);
 	usage(stderr);
 }
 
-static void __attribute__((__noreturn__))
-invopt(const char *s)
+static void __attribute__((__noreturn__)) invopt(const char *s)
 {
 	warnx(_("illegal option -- %s"), s);
 	usage(stderr);
 }
 
 #ifdef HAVE_WIDECHAR
-/*
- * A mbstowcs()-alike function that transparently handles invalid sequences.
- */
-static size_t
-xmbstowcs(wchar_t *pwcs, const char *s, size_t nwcs)
+/* A mbstowcs()-alike function that transparently handles invalid
+ * sequences. */
+static size_t xmbstowcs(wchar_t * pwcs, const char *s, size_t nwcs)
 {
 	size_t n = nwcs;
 	int c;
 
-	ignore_result( mbtowc(pwcs, NULL, MB_CUR_MAX) );	/* reset shift state */
+	ignore_result(mbtowc(pwcs, NULL, MB_CUR_MAX));	/* reset shift state */
 	while (*s && n) {
 		if ((c = mbtowc(pwcs, s, MB_CUR_MAX)) < 0) {
 			s++;
@@ -271,26 +262,20 @@ xmbstowcs(wchar_t *pwcs, const char *s, size_t nwcs)
 	}
 	if (n)
 		*pwcs = L'\0';
-	ignore_result( mbtowc(pwcs, NULL, MB_CUR_MAX) );
+	ignore_result(mbtowc(pwcs, NULL, MB_CUR_MAX));
 	return nwcs - n;
 }
 #endif
 
-/*
- * Helper function for tputs().
- */
-static int
-outcap(int i)
+/* Helper function for tputs(). */
+static int outcap(int i)
 {
 	char c = i;
 	return write_all(STDOUT_FILENO, &c, 1) == 0 ? 1 : -1;
 }
 
-/*
- * Write messages to terminal.
- */
-static void
-mesg(const char *message)
+/* Write messages to terminal. */
+static void mesg(const char *message)
 {
 	if (ontty == 0)
 		return;
@@ -301,11 +286,8 @@ mesg(const char *message)
 		vidputs(A_NORMAL, outcap);
 }
 
-/*
- * Get the window size.
- */
-static void
-getwinsize(void)
+/* Get the window size. */
+static void getwinsize(void)
 {
 	static int initialized, envlines, envcols, deflines, defcols;
 #ifdef	TIOCGWINSZ
@@ -355,11 +337,8 @@ getwinsize(void)
 	}
 }
 
-/*
- * Message if skipping parts of files.
- */
-static void
-skip(int direction)
+/* Message if skipping parts of files. */
+static void skip(int direction)
 {
 	if (direction > 0)
 		mesg(_("...skipping forward\n"));
@@ -367,11 +346,8 @@ skip(int direction)
 		mesg(_("...skipping backward\n"));
 }
 
-/*
- * Signal handler while reading from input file.
- */
-static void
-sighandler(int signum)
+/* Signal handler while reading from input file. */
+static void sighandler(int signum)
 {
 	if (canjump && (signum == SIGINT || signum == SIGQUIT))
 		longjmp(jmpenv, signum);
@@ -379,11 +355,8 @@ sighandler(int signum)
 	quit(exitstatus);
 }
 
-/*
- * Check whether the requested file was specified on the command line.
- */
-static int
-checkf(void)
+/* Check whether the requested file was specified on the command line. */
+static int checkf(void)
 {
 	if (files.current + nextfile >= files.last) {
 		mesg(_("No next file"));
@@ -397,12 +370,9 @@ checkf(void)
 }
 
 #ifdef HAVE_WIDECHAR
-/*
- * Return the last character that will fit on the line at col columns
- * in case MB_CUR_MAX > 1.
- */
-static char *
-endline_for_mb(unsigned col, char *s)
+/* Return the last character that will fit on the line at col columns in
+ * case MB_CUR_MAX > 1. */
+static char *endline_for_mb(unsigned col, char *s)
 {
 	size_t pos = 0;
 	wchar_t *p = wbuf;
@@ -415,30 +385,22 @@ endline_for_mb(unsigned col, char *s)
 	wbuf[wl] = L'\0';
 	while (*p != L'\0') {
 		switch (*p) {
-			/*
-			 * Cursor left.
-			 */
+			/* Cursor left. */
 		case L'\b':
 			if (pos > 0)
 				pos--;
 			break;
-			/*
-			 * No cursor movement.
-			 */
+			/* No cursor movement. */
 		case L'\a':
 			break;
-			/*
-			 * Special.
-			 */
+			/* Special. */
 		case L'\r':
 			pos = 0;
 			break;
 		case L'\n':
 			end = p + 1;
 			goto ended;
-			/*
-			 * Cursor right.
-			 */
+			/* Cursor right. */
 		case L'\t':
 			pos += TABSIZE - (pos % TABSIZE);
 			break;
@@ -452,13 +414,10 @@ endline_for_mb(unsigned col, char *s)
 			if (*p == L'\t')
 				p++;
 			else if (pos > col + 1)
-				/*
-				 * wcwidth() found a character that
-				 * has multiple columns. What happens
-				 * now? Assume the terminal will print
-				 * the entire character onto the next
-				 * row.
-				 */
+				/* wcwidth() found a character that has
+				 * multiple columns.  What happens now?
+				 * Assume the terminal will print the
+				 * entire character onto the next row. */
 				p--;
 			if (*++p == L'\n')
 				p++;
@@ -471,17 +430,14 @@ endline_for_mb(unsigned col, char *s)
  ended:
 	*end = L'\0';
 	p = wbuf;
-	if ((pos = wcstombs(NULL, p, READBUF)) == (size_t) -1)
+	if ((pos = wcstombs(NULL, p, READBUF)) == (size_t)-1)
 		return s + 1;
 	return s + pos;
 }
-#endif
+#endif	/* HAVE_WIDECHAR */
 
-/*
- * Return the last character that will fit on the line at col columns.
- */
-static char *
-endline(unsigned col, char *s)
+/* Return the last character that will fit on the line at col columns. */
+static char *endline(unsigned col, char *s)
 {
 	unsigned pos = 0;
 	char *t = s;
@@ -493,30 +449,22 @@ endline(unsigned col, char *s)
 
 	while (*s != '\0') {
 		switch (*s) {
-			/*
-			 * Cursor left.
-			 */
+			/* Cursor left. */
 		case '\b':
 			if (pos > 0)
 				pos--;
 			break;
-			/*
-			 * No cursor movement.
-			 */
+			/* No cursor movement. */
 		case '\a':
 			break;
-			/*
-			 * Special.
-			 */
+			/* Special. */
 		case '\r':
 			pos = 0;
 			break;
 		case '\n':
 			t = s + 1;
 			goto cend;
-			/*
-			 * Cursor right.
-			 */
+			/* Cursor right. */
 		case '\t':
 			pos += TABSIZE - (pos % TABSIZE);
 			break;
@@ -538,11 +486,8 @@ endline(unsigned col, char *s)
 	return t;
 }
 
-/*
- * Clear the current line on the terminal's screen.
- */
-static void
-cline(void)
+/* Clear the current line on the terminal's screen. */
+static void cline(void)
 {
 	char *buf = xmalloc(ttycols + 2);
 	memset(buf, ' ', ttycols + 2);
@@ -552,43 +497,62 @@ cline(void)
 	free(buf);
 }
 
-/*
- * Evaluate a command character's semantics.
- */
-static int
-getstate(int c)
+/* Evaluate a command character's semantics. */
+static int getstate(int c)
 {
 	switch (c) {
-	case '1': case '2': case '3': case '4': case '5':
-	case '6': case '7': case '8': case '9': case '0':
+	case '1':
+	case '2':
+	case '3':
+	case '4':
+	case '5':
+	case '6':
+	case '7':
+	case '8':
+	case '9':
+	case '0':
 	case '\0':
 		return COUNT;
-	case '-': case '+':
+	case '-':
+	case '+':
 		return SIGN;
-	case 'l': case 'd': case '\004': case 'f': case 'z':
-	case '.': case '\014': case '$': case 'n': case 'p':
-	case 'w': case 'h': case 'q': case 'Q':
+	case 'l':
+	case 'd':
+	case '\004':
+	case 'f':
+	case 'z':
+	case '.':
+	case '\014':
+	case '$':
+	case 'n':
+	case 'p':
+	case 'w':
+	case 'h':
+	case 'q':
+	case 'Q':
 		return CMD_FIN;
-	case '/': case '?': case '^':
+	case '/':
+	case '?':
+	case '^':
 		return SEARCH;
-	case 's': case '!':
+	case 's':
+	case '!':
 		return STRING;
-	case 'm': case 'b': case 't':
+	case 'm':
+	case 'b':
+	case 't':
 		return ADDON_FIN;
 	default:
 #ifdef PG_BELL
 		if (bell)
 			tputs(bell, STDOUT_FILENO, outcap);
-#endif  /*  PG_BELL  */
+#endif
 		return INVALID;
 	}
 }
 
-/*
- * Get the count and ignore last character of string.
- */
-static int
-getcount(char *cmdstr)
+/* Get the count and ignore last character of string. */
+static int getcount(char *cmdstr)
 {
 	char *buf;
 	char *p;
@@ -619,12 +583,9 @@ getcount(char *cmdstr)
 	return i;
 }
 
-/*
- * Read what the user writes at the prompt. This is tricky because
- * we check for valid input.
- */
-static void
-prompt(long long pageno)
+/* Read what the user writes at the prompt. This is tricky because we
+ * check for valid input. */
+static void prompt(long long pageno)
 {
 	struct termios tio;
 	char key;
@@ -652,9 +613,11 @@ prompt(long long pageno)
 	tcflush(STDOUT_FILENO, TCIFLUSH);
 	for (;;) {
 		switch (read(STDOUT_FILENO, &key, 1)) {
-		case 0: quit(0);
-			/*NOTREACHED*/
-		case -1: quit(1);
+		case 0:
+			quit(0);
+			/* NOTREACHED */
+		case -1:
+			quit(1);
 		}
 		if (key == tio.c_cc[VERASE]) {
 			if (cmd.cmdlen) {
@@ -671,20 +634,19 @@ prompt(long long pageno)
 					break;
 				case SEARCH_FIN:
 					state = SEARCH;
-					/*FALLTHRU*/
+					/* FALLTHRU */
 				case SEARCH:
-					if (cmd.cmdline[cmd.cmdlen - 1]
-							== '\\') {
+					if (cmd.cmdline[cmd.cmdlen - 1] == '\\') {
 						escape = 1;
-						while(cmd.cmdline[cmd.cmdlen
-								- escape - 1]
-							== '\\') escape++;
+						while (cmd.cmdline[cmd.cmdlen
+								   - escape - 1]
+						       == '\\')
+							escape++;
 						escape %= 2;
-					}
-					else {
+					} else {
 						escape = 0;
 						if (strchr(cmd.cmdline, cmd.key)
-							== NULL) {
+						    == NULL) {
 							cmd.key = '\0';
 							state = COUNT;
 						}
@@ -751,7 +713,7 @@ prompt(long long pageno)
 					continue;
 				}
 				state = COUNT;
-				/*FALLTHRU*/
+				/* FALLTHRU */
 			case COUNT:
 				break;
 			case ADDON_FIN:
@@ -767,19 +729,15 @@ prompt(long long pageno)
 		if (nflag && state == CMD_FIN)
 			goto endprompt;
 	}
-endprompt:
+ endprompt:
 	tcsetattr(STDOUT_FILENO, TCSADRAIN, &otio);
 	cline();
 	cmd.count = getcount(cmd.cmdline);
 }
 
 #ifdef HAVE_WIDECHAR
-/*
- * Remove backspace formatting, for searches
- * in case MB_CUR_MAX > 1.
- */
-static char *
-colb_for_mb(char *s)
+/* Remove backspace formatting, for searches in case MB_CUR_MAX > 1. */
+static char *colb_for_mb(char *s)
 {
 	char *p = s;
 	wchar_t *wp, *wq;
@@ -788,8 +746,7 @@ colb_for_mb(char *s)
 
 	if ((wl = xmbstowcs(wbuf, p, sizeof wbuf)) == (size_t)-1)
 		return s;
-	for (wp = wbuf, wq = wbuf, i = 0; *wp != L'\0' && i < wl;
-	     wp++, wq++) {
+	for (wp = wbuf, wq = wbuf, i = 0; *wp != L'\0' && i < wl; wp++, wq++) {
 		if (*wp == L'\b') {
 			if (wq != wbuf)
 				wq -= 2;
@@ -806,11 +763,8 @@ colb_for_mb(char *s)
 }
 #endif
 
-/*
- * Remove backspace formatting, for searches.
- */
-static char *
-colb(char *s)
+/* Remove backspace formatting, for searches. */
+static char *colb(char *s)
 {
 	char *p = s, *q;
 
@@ -834,12 +788,8 @@ colb(char *s)
 }
 
 #ifdef HAVE_WIDECHAR
-/*
- * Convert nonprintable characters to spaces
- * in case MB_CUR_MAX > 1.
- */
-static void
-makeprint_for_mb(char *s, size_t l)
+/* Convert nonprintable characters to spaces in case MB_CUR_MAX > 1.  */
+static void makeprint_for_mb(char *s, size_t l)
 {
 	char *t = s;
 	wchar_t *wp = wbuf;
@@ -858,11 +808,8 @@ makeprint_for_mb(char *s, size_t l)
 }
 #endif
 
-/*
- * Convert nonprintable characters to spaces.
- */
-static void
-makeprint(char *s, size_t l)
+/* Convert nonprintable characters to spaces. */
+static void makeprint(char *s, size_t l)
 {
 #ifdef HAVE_WIDECHAR
 	if (MB_CUR_MAX > 1) {
@@ -879,11 +826,8 @@ makeprint(char *s, size_t l)
 	}
 }
 
-/*
- * Strip backslash characters from the given string.
- */
-static void
-striprs(char *s)
+/* Strip backslash characters from the given string. */
+static void striprs(char *s)
 {
 	char *p = s;
 
@@ -895,11 +839,8 @@ striprs(char *s)
 	} while (*s++ != '\0');
 }
 
-/*
- * Extract the search pattern off the command line.
- */
-static char *
-makepat(void)
+/* Extract the search pattern off the command line. */
+static char *makepat(void)
 {
 	char *p;
 
@@ -918,73 +859,52 @@ makepat(void)
 	return p;
 }
 
-/*
- * Process errors that occurred in temporary file operations.
- */
-static void __attribute__((__noreturn__))
-tmperr(FILE *f, const char *ftype)
+/* Process errors that occurred in temporary file operations. */
+static void __attribute__((__noreturn__)) tmperr(FILE *f, const char *ftype)
 {
 	if (ferror(f))
 		warn(_("Read error from %s file"), ftype);
 	else if (feof(f))
-		/*
-		 * Most likely '\0' in input.
-		 */
+		/* Most likely '\0' in input. */
 		warnx(_("Unexpected EOF in %s file"), ftype);
 	else
 		warn(_("Unknown error in %s file"), ftype);
 	quit(++exitstatus);
 }
 
-/*
- * Read the file and respond to user input.
- * Beware: long and ugly.
- */
-static void
-pgfile(FILE *f, const char *name)
+/* Read the file and respond to user input.  Beware: long and ugly. */
+static void pgfile(FILE *f, const char *name)
 {
 	off_t pos, oldpos, fpos;
+	/* These are the line counters:
+	 *   line	the line desired to display
+	 *   fline	the current line of the input file
+	 *   bline	the current line of the file buffer
+	 *   oldline	the line before a search was started
+	 *   eofline	the last line of the file if it is already reached
+	 *   dline	the line on the display */
 	off_t line = 0, fline = 0, bline = 0, oldline = 0, eofline = 0;
 	int dline = 0;
-	/*
-	 * These are the line counters:
-	 * line		the line desired to display
-	 * fline	the current line of the input file
-	 * bline	the current line of the file buffer
-	 * oldline	the line before a search was started
-	 * eofline	the last line of the file if it is already reached
-	 * dline	the line on the display
-	 */
 	int search = 0;
 	unsigned searchcount = 0;
-	/*
-	 * Advance to EOF immediately.
-	 */
+	/* Advance to EOF immediately. */
 	int seekeof = 0;
-	/*
-	 * EOF has been reached by `line'.
-	 */
+	/* EOF has been reached by `line'. */
 	int eof = 0;
-	/*
-	 * f and fbuf refer to the same file.
-	 */
+	/* f and fbuf refer to the same file. */
 	int nobuf = 0;
 	int sig;
 	int rerror;
 	size_t sz;
 	char b[READBUF + 1];
 	char *p;
-	/*
-	 * fbuf		an exact copy of the input file as it gets read
-	 * find		index table for input, one entry per line
-	 * save		for the s command, to save to a file
-	 */
+	/*   fbuf	an exact copy of the input file as it gets read
+	 *   find	index table for input, one entry per line
+	 *   save	for the s command, to save to a file */
 	FILE *fbuf, *find, *save;
 
 	if (ontty == 0) {
-		/*
-		 * Just copy stdin to stdout.
-		 */
+		/* Just copy stdin to stdout. */
 		while ((sz = fread(b, sizeof *b, READBUF, f)) != 0)
 			write_all(STDOUT_FILENO, b, sz);
 		if (ferror(f)) {
@@ -1018,10 +938,8 @@ pgfile(FILE *f, const char *name)
 		remembered = 1;
 	}
 
-	for (line = startline; ; ) {
-		/*
-		 * Get a line from input file or buffer.
-		 */
+	for (line = startline;;) {
+		/* Get a line from input file or buffer. */
 		if (line < bline) {
 			fseeko(find, line * sizeof pos, SEEK_SET);
 			if (fread(&pos, sizeof pos, 1, find) == 0)
@@ -1037,9 +955,7 @@ pgfile(FILE *f, const char *name)
 					fseeko(fbuf, (off_t)0, SEEK_END);
 				pos = ftello(fbuf);
 				if ((sig = setjmp(jmpenv)) != 0) {
-					/*
-					 * We got a signal.
-					 */
+					/* We got a signal. */
 					canjump = 0;
 					my_sigrelse(sig);
 					fseeko(fbuf, pos, SEEK_SET);
@@ -1070,12 +986,12 @@ pgfile(FILE *f, const char *name)
 						oldpos = pos;
 						p = b;
 						while (*(p = endline(ttycols,
-									p))
-								!= '\0') {
+								     p))
+						       != '\0') {
 							pos = oldpos + (p - b);
 							fwrite_all(&pos,
-								sizeof pos,
-								1, find);
+								   sizeof pos,
+								   1, find);
 							fline++;
 							bline++;
 						}
@@ -1084,9 +1000,7 @@ pgfile(FILE *f, const char *name)
 				}
 			} while (line > bline++);
 		} else {
-			/*
-			 * eofline != 0
-			 */
+			/* eofline != 0 */
 			eof = 1;
 		}
 		if (search == FORWARD && remembered == 1) {
@@ -1118,15 +1032,15 @@ pgfile(FILE *f, const char *name)
 				skip(1);
 			}
 			continue;
-		} else if (eof)	{	/*
-					 * We are not searching.
-					 */
+		} else if (eof) {
+			/* We are not searching. */
 			line = bline;
 		} else if (*b != '\0') {
 			if (cflag && clear_screen) {
 				switch (dline) {
 				case 0:
-					tputs(clear_screen, STDOUT_FILENO, outcap);
+					tputs(clear_screen, STDOUT_FILENO,
+					      outcap);
 					dline = 0;
 				}
 			}
@@ -1135,9 +1049,7 @@ pgfile(FILE *f, const char *name)
 				eof = 1;
 			dline++;
 			if ((sig = setjmp(jmpenv)) != 0) {
-				/*
-				 * We got a signal.
-				 */
+				/* We got a signal. */
 				canjump = 0;
 				my_sigrelse(sig);
 				dline = pagelen;
@@ -1151,9 +1063,7 @@ pgfile(FILE *f, const char *name)
 			}
 		}
 		if (dline >= pagelen || eof) {
-			/*
-			 * Time for prompting!
-			 */
+			/* Time for prompting! */
 			if (eof && seekeof) {
 				eof = seekeof = 0;
 				if (line >= pagelen)
@@ -1163,7 +1073,7 @@ pgfile(FILE *f, const char *name)
 				dline = -1;
 				continue;
 			}
-newcmd:
+ newcmd:
 			if (eof) {
 				if (fline == 0 || eflag)
 					break;
@@ -1172,9 +1082,7 @@ newcmd:
 			prompt((line - 1) / pagelen + 1);
 			switch (cmd.key) {
 			case '/':
-				/*
-				 * Search forward.
-				 */
+				/* Search forward. */
 				search = FORWARD;
 				oldline = line;
 				searchcount = cmd.count;
@@ -1183,11 +1091,12 @@ newcmd:
 					if (remembered == 1)
 						regfree(&re);
 					rerror = regcomp(&re, p,
-						REG_NOSUB | REG_NEWLINE);
+							 REG_NOSUB |
+							 REG_NEWLINE);
 					if (rerror != 0) {
 						mesg(_("RE error: "));
 						sz = regerror(rerror, &re,
-								b, READBUF);
+							      b, READBUF);
 						mesg(b);
 						goto newcmd;
 					}
@@ -1199,9 +1108,7 @@ newcmd:
 				continue;
 			case '?':
 			case '^':
-				/*
-				 * Search backward.
-				 */
+				/* Search backward. */
 				search = BACKWARD;
 				oldline = line;
 				searchcount = cmd.count;
@@ -1210,11 +1117,12 @@ newcmd:
 					if (remembered == 1)
 						regfree(&re);
 					rerror = regcomp(&re, p,
-						REG_NOSUB | REG_NEWLINE);
+							 REG_NOSUB |
+							 REG_NEWLINE);
 					if (rerror != 0) {
 						mesg(_("RE error: "));
 						regerror(rerror, &re,
-								b, READBUF);
+							 b, READBUF);
 						mesg(b);
 						goto newcmd;
 					}
@@ -1228,8 +1136,9 @@ newcmd:
 					goto notfound_bw;
 				while (line) {
 					fseeko(find, --line * sizeof pos,
-							SEEK_SET);
-					if(fread(&pos, sizeof pos, 1,find)==0)
+					       SEEK_SET);
+					if (fread(&pos, sizeof pos, 1, find) ==
+					    0)
 						tmperr(find, "index");
 					fseeko(find, (off_t)0, SEEK_END);
 					fseeko(fbuf, pos, SEEK_SET);
@@ -1241,12 +1150,12 @@ newcmd:
 					if (searchcount == 0)
 						goto found_bw;
 				}
-notfound_bw:
+ notfound_bw:
 				line = oldline;
 				search = searchcount = 0;
 				mesg(_("Pattern not found"));
 				goto newcmd;
-found_bw:
+ found_bw:
 				eof = search = dline = 0;
 				skip(-1);
 				switch (searchdisplay) {
@@ -1266,11 +1175,9 @@ found_bw:
 					line = 0;
 				continue;
 			case 's':
-				/*
-				 * Save to file.
-				 */
+				/* Save to file. */
 				p = cmd.cmdline;
-				while (*++p == ' ');
+				while (*++p == ' ') ;
 				if (*p == '\0')
 					goto newcmd;
 				save = fopen(p, "wb");
@@ -1282,13 +1189,12 @@ found_bw:
 					mesg(strerror(cmd.count));
 					goto newcmd;
 				}
-				/*
-				 * Advance to EOF.
-				 */
+				/* Advance to EOF. */
 				fseeko(find, (off_t)0, SEEK_END);
 				for (;;) {
 					if (!nobuf)
-						fseeko(fbuf,(off_t)0,SEEK_END);
+						fseeko(fbuf, (off_t)0,
+						       SEEK_END);
 					pos = ftello(fbuf);
 					if (fgets(b, READBUF, f) == NULL) {
 						eofline = fline;
@@ -1301,12 +1207,12 @@ found_bw:
 						oldpos = pos;
 						p = b;
 						while (*(p = endline(ttycols,
-									p))
-								!= '\0') {
+								     p))
+						       != '\0') {
 							pos = oldpos + (p - b);
 							fwrite_all(&pos,
-								sizeof pos,
-								1, find);
+								   sizeof pos,
+								   1, find);
 							fline++;
 							bline++;
 						}
@@ -1316,10 +1222,8 @@ found_bw:
 				}
 				fseeko(fbuf, (off_t)0, SEEK_SET);
 				while ((sz = fread(b, sizeof *b, READBUF,
-							fbuf)) != 0) {
-					/*
-					 * No error check for compat.
-					 */
+						   fbuf)) != 0) {
+					/* No error check for compat. */
 					fwrite_all(b, sizeof *b, sz, save);
 				}
 				fclose(save);
@@ -1327,48 +1231,39 @@ found_bw:
 				mesg(_("saved"));
 				goto newcmd;
 			case 'l':
-				/*
-				 * Next line.
-				 */
+				/* Next line. */
 				if (*cmd.cmdline != 'l')
 					eof = 0;
 				if (cmd.count == 0)
-					cmd.count = 1; /* compat */
+					cmd.count = 1;	/* compat */
 				if (isdigit(cuc(*cmd.cmdline))) {
 					line = cmd.count - 2;
 					dline = 0;
 				} else {
 					if (cmd.count != 1) {
-						line += cmd.count - 1
-							- pagelen;
+						line += cmd.count - 1 - pagelen;
 						dline = -1;
 						skip(cmd.count);
 					}
-					/*
-					 * Nothing to do if count==1.
-					 */
+					/* Nothing to do if (count == 1) */
 				}
 				break;
 			case 'd':
-				/*
-				 * Half screen forward.
-				 */
+				/* Half screen forward. */
 			case '\004':	/* ^D */
 				if (*cmd.cmdline != cmd.key)
 					eof = 0;
 				if (cmd.count == 0)
-					cmd.count = 1; /* compat */
+					cmd.count = 1;	/* compat */
 				line += (cmd.count * pagelen / 2)
-					- pagelen - 1;
+				    - pagelen - 1;
 				dline = -1;
 				skip(cmd.count);
 				break;
 			case 'f':
-				/*
-				 * Skip forward.
-				 */
+				/* Skip forward. */
 				if (cmd.count <= 0)
-					cmd.count = 1; /* compat */
+					cmd.count = 1;	/* compat */
 				line += cmd.count * pagelen - 2;
 				if (eof)
 					line += 2;
@@ -1382,16 +1277,14 @@ found_bw:
 				skip(cmd.count);
 				break;
 			case '\0':
-				/*
-				 * Just a number, or '-', or <newline>.
-				 */
+				/* Just a number, or '-', or <newline>. */
 				if (cmd.count == 0)
-					cmd.count = 1; /* compat */
+					cmd.count = 1;	/* compat */
 				if (isdigit(cuc(*cmd.cmdline)))
 					line = (cmd.count - 1) * pagelen - 2;
 				else
 					line += (cmd.count - 1)
-						* (pagelen - 1) - 2;
+					    * (pagelen - 1) - 2;
 				if (*cmd.cmdline != '\0')
 					eof = 0;
 				if (cmd.count != 1) {
@@ -1403,9 +1296,7 @@ found_bw:
 				}
 				break;
 			case '$':
-				/*
-				 * Advance to EOF.
-				 */
+				/* Advance to EOF. */
 				if (!eof)
 					skip(1);
 				eof = 0;
@@ -1414,10 +1305,8 @@ found_bw:
 				dline = -1;
 				break;
 			case '.':
-			case '\014': /* ^L */
-				/*
-				 * Repaint screen.
-				 */
+			case '\014':	/* ^L */
+				/* Repaint screen. */
 				eof = 0;
 				if (line >= pagelen)
 					line -= pagelen;
@@ -1426,9 +1315,7 @@ found_bw:
 				dline = 0;
 				break;
 			case '!':
-				/*
-				 * Shell escape.
-				 */
+				/* Shell escape. */
 				if (rflag) {
 					mesg(program_invocation_short_name);
 					mesg(_(": !command not allowed in "
@@ -1437,14 +1324,15 @@ found_bw:
 					pid_t cpid;
 
 					write_all(STDOUT_FILENO, cmd.cmdline,
-					      strlen(cmd.cmdline));
+						  strlen(cmd.cmdline));
 					write_all(STDOUT_FILENO, "\n", 1);
 					my_sigset(SIGINT, SIG_IGN);
 					my_sigset(SIGQUIT, SIG_IGN);
 					switch (cpid = fork()) {
 					case 0:
 						p = getenv("SHELL");
-						if (p == NULL) p = xstrdup("/bin/sh");
+						if (p == NULL)
+							p = xstrdup("/bin/sh");
 						if (!nobuf)
 							fclose(fbuf);
 						fclose(find);
@@ -1458,16 +1346,16 @@ found_bw:
 						my_sigset(SIGQUIT, oldquit);
 						my_sigset(SIGTERM, oldterm);
 						execl(p, p, "-c",
-							cmd.cmdline + 1, NULL);
+						      cmd.cmdline + 1, NULL);
 						warn("%s", p);
 						_exit(0177);
-						/*NOTREACHED*/
+						/* NOTREACHED */
 					case -1:
 						mesg(_("fork() failed, "
 						       "try again later\n"));
 						break;
 					default:
-						while (wait(NULL) != cpid);
+						while (wait(NULL) != cpid) ;
 					}
 					my_sigset(SIGINT, sighandler);
 					my_sigset(SIGQUIT, sighandler);
@@ -1475,19 +1363,17 @@ found_bw:
 				}
 				goto newcmd;
 			case 'h':
-			{
-				/*
-				 * Help!
-				 */
-				const char *help = _(helpscreen);
-				write_all(STDOUT_FILENO, copyright, strlen(copyright));
-				write_all(STDOUT_FILENO, help, strlen(help));
-				goto newcmd;
-			}
+				{
+					/* Help! */
+					const char *help = _(helpscreen);
+					write_all(STDOUT_FILENO, copyright,
+						  strlen(copyright));
+					write_all(STDOUT_FILENO, help,
+						  strlen(help));
+					goto newcmd;
+				}
 			case 'n':
-				/*
-				 * Next file.
-				 */
+				/* Next file. */
 				if (cmd.count == 0)
 					cmd.count = 1;
 				nextfile = cmd.count;
@@ -1498,9 +1384,7 @@ found_bw:
 				eof = 1;
 				break;
 			case 'p':
-				/*
-				 * Previous file.
-				 */
+				/* Previous file. */
 				if (cmd.count == 0)
 					cmd.count = 1;
 				nextfile = 0 - cmd.count;
@@ -1512,16 +1396,12 @@ found_bw:
 				break;
 			case 'q':
 			case 'Q':
-				/*
-				 * Exit pg.
-				 */
+				/* Exit pg. */
 				quit(exitstatus);
-				/*NOTREACHED*/
+				/* NOTREACHED */
 			case 'w':
 			case 'z':
-				/*
-				 * Set window size.
-				 */
+				/* Set window size. */
 				if (cmd.count < 0)
 					cmd.count = 0;
 				if (*cmd.cmdline != cmd.key)
@@ -1546,8 +1426,7 @@ found_bw:
 		fclose(fbuf);
 }
 
-static int
-parse_arguments(int arg, int argc, char **argv)
+static int parse_arguments(int arg, int argc, char **argv)
 {
 	FILE *input;
 
@@ -1568,9 +1447,7 @@ parse_arguments(int arg, int argc, char **argv)
 					prompt(-1);
 					switch (cmd.key) {
 					case 'n':
-						/*
-						 * Next file.
-						 */
+						/* Next file. */
 						if (cmd.count == 0)
 							cmd.count = 1;
 						nextfile = cmd.count;
@@ -1581,9 +1458,7 @@ parse_arguments(int arg, int argc, char **argv)
 						}
 						continue;
 					case 'p':
-						/*
-						 * Previous file.
-						 */
+						/* Previous file. */
 						if (cmd.count == 0)
 							cmd.count = 1;
 						nextfile = 0 - cmd.count;
@@ -1612,9 +1487,7 @@ parse_arguments(int arg, int argc, char **argv)
 			}
 		}
 		if (ontty == 0 && argc > 2) {
-			/*
-			 * Use the prefix as specified by SUSv2.
-			 */
+			/* Use the prefix as specified by SUSv2. */
 			write_all(STDOUT_FILENO, "::::::::::::::\n", 15);
 			write_all(STDOUT_FILENO, argv[arg], strlen(argv[arg]));
 			write_all(STDOUT_FILENO, "\n::::::::::::::\n", 16);
@@ -1626,8 +1499,7 @@ parse_arguments(int arg, int argc, char **argv)
 	return exitstatus;
 }
 
-int
-main(int argc, char **argv)
+int main(int argc, char **argv)
 {
 	int arg, i;
 	char *p;
@@ -1665,9 +1537,19 @@ main(int argc, char **argv)
 				if (i != 1 || argv[arg][i + 1])
 					invopt(&argv[arg][i]);
 				goto endargs;
-			case '1': case '2': case '3': case '4': case '5':
-			case '6': case '7': case '8': case '9': case '0':
-				pagelen = strtol_or_err(argv[arg] + 1, _("failed to parse argument"));
+			case '1':
+			case '2':
+			case '3':
+			case '4':
+			case '5':
+			case '6':
+			case '7':
+			case '8':
+			case '9':
+			case '0':
+				pagelen =
+				    strtol_or_err(argv[arg] + 1,
+						  _("failed to parse argument"));
 				havepagelen = 1;
 				goto nextarg;
 			case 'c':
@@ -1706,10 +1588,10 @@ main(int argc, char **argv)
 				invopt(&argv[arg][i]);
 			}
 		}
-nextarg:
+ nextarg:
 		;
 	}
-endargs:
+ endargs:
 	for (arg = 1; argv[arg]; arg++) {
 		if (*argv[arg] == '-') {
 			if (argv[arg][1] == '-') {
@@ -1728,17 +1610,28 @@ endargs:
 		switch (*(argv[arg] + 1)) {
 		case '\0':
 			needarg("+");
-			/*NOTREACHED*/
-		case '1': case '2': case '3': case '4': case '5':
-		case '6': case '7': case '8': case '9': case '0':
-			startline = strtol_or_err(argv[arg] + 1, _("failed to parse argument"));
+			/* NOTREACHED */
+		case '1':
+		case '2':
+		case '3':
+		case '4':
+		case '5':
+		case '6':
+		case '7':
+		case '8':
+		case '9':
+		case '0':
+			startline =
+			    strtol_or_err(argv[arg] + 1,
+					  _("failed to parse argument"));
 			break;
 		case '/':
 			searchfor = argv[arg] + 2;
 			if (*searchfor == '\0')
 				needarg("+/");
 			p = searchfor + strlen(searchfor) - 1;
-			if (*p == '/') *p = '\0';
+			if (*p == '/')
+				*p = '\0';
 			if (*searchfor == '\0')
 				needarg("+/");
 			break;
@@ -1752,6 +1645,6 @@ endargs:
 		exitstatus = parse_arguments(arg, argc, argv);
 
 	quit(exitstatus);
-	/*NOTREACHED*/
+	/* NOTREACHED */
 	return 0;
 }
-- 
1.7.12.2

