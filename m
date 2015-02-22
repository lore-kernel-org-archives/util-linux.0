Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f49.google.com ([74.125.82.49]:62657 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbbBVOnr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:43:47 -0500
Received: by mail-wg0-f49.google.com with SMTP id l18so21237141wgh.8
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:43:46 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 02/31] more: reorder includes, declarations, and global variables
Date: Sun, 22 Feb 2015 14:42:58 +0000
Message-Id: <1424616207-747-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/Makemodule.am |   2 +-
 text-utils/more-term.h   | 112 +++++++++++++++++++++++++++++
 text-utils/more.c        | 179 +++++++++--------------------------------------
 3 files changed, 148 insertions(+), 145 deletions(-)
 create mode 100644 text-utils/more-term.h

diff --git a/text-utils/Makemodule.am b/text-utils/Makemodule.am
index bd3d53f..a24c10b 100644
--- a/text-utils/Makemodule.am
+++ b/text-utils/Makemodule.am
@@ -84,7 +84,7 @@ endif # BUILD_UL
 if BUILD_MORE
 bin_PROGRAMS += more
 dist_man_MANS += text-utils/more.1
-more_SOURCES = text-utils/more.c
+more_SOURCES = text-utils/more.c text-utils/more-term.h
 more_CFLAGS = $(AM_CFLAGS) $(BSD_WARN_CFLAGS)
 more_LDADD = $(LDADD)
 if HAVE_TINFO
diff --git a/text-utils/more-term.h b/text-utils/more-term.h
new file mode 100644
index 0000000..f3577f4
--- /dev/null
+++ b/text-utils/more-term.h
@@ -0,0 +1,112 @@
+#if defined(HAVE_NCURSES_H) || defined(HAVE_NCURSES_NCURSES_H)
+
+# include <term.h>
+# define TERM_AUTO_RIGHT_MARGIN		"am"
+# define TERM_CEOL			"xhp"
+# define TERM_CLEAR			"clear"
+# define TERM_CLEAR_TO_LINE_END		"el"
+# define TERM_CLEAR_TO_SCREEN_END	"ed"
+# define TERM_COLS			"cols"
+# define TERM_CURSOR_ADDRESS		"cup"
+# define TERM_EAT_NEW_LINE		"xenl"
+# define TERM_ENTER_UNDERLINE		"smul"
+# define TERM_EXIT_STANDARD_MODE	"rmso"
+# define TERM_EXIT_UNDERLINE		"rmul"
+# define TERM_HARD_COPY			"hc"
+# define TERM_HOME			"home"
+# define TERM_LINES			"lines"
+# define TERM_LINE_DOWN			"cud1"
+# define TERM_OVER_STRIKE		"os"
+# define TERM_PAD_CHAR			"pad"
+# define TERM_STANDARD_MODE		"smso"
+# define TERM_STD_MODE_GLITCH		"xmc"
+# define TERM_UNDERLINE			"ul"
+# define TERM_UNDERLINE_CHAR		"uc"
+
+static inline void my_putstring(char *s)
+{
+	tputs(s, fileno(stdout), putchar);	/* putp(s); */
+}
+
+static inline void my_setupterm(char *term, int fildes, int *errret)
+{
+	setupterm(term, fildes, errret);
+}
+
+static inline int my_tgetnum(char *s)
+{
+	return tigetnum(s);
+}
+
+static inline int my_tgetflag(char *s)
+{
+	return tigetflag(s);
+}
+
+static inline char *my_tgetstr(char *s)
+{
+	return tigetstr(s);
+}
+
+static inline char *my_tgoto(char *cap, int col, int row)
+{
+	return tparm(cap, col, row);
+}
+
+#elif defined(HAVE_LIBTERMCAP)	/* ncurses not found */
+
+# include <termcap.h>
+# define TERM_AUTO_RIGHT_MARGIN		"am"
+# define TERM_CEOL			"xs"
+# define TERM_CLEAR			"cl"
+# define TERM_CLEAR_TO_LINE_END		"ce"
+# define TERM_CLEAR_TO_SCREEN_END	"cd"
+# define TERM_COLS			"co"
+# define TERM_CURSOR_ADDRESS		"cm"
+# define TERM_EAT_NEW_LINE		"xn"
+# define TERM_ENTER_UNDERLINE		"us"
+# define TERM_EXIT_STANDARD_MODE	"se"
+# define TERM_EXIT_UNDERLINE		"ue"
+# define TERM_HARD_COPY			"hc"
+# define TERM_HOME			"ho"
+# define TERM_LINES			"li"
+# define TERM_LINE_DOWN			"le"
+# define TERM_OVER_STRIKE		"os"
+# define TERM_PAD_CHAR			"pc"
+# define TERM_STANDARD_MODE		"so"
+# define TERM_STD_MODE_GLITCH		"sg"
+# define TERM_UNDERLINE			"ul"
+# define TERM_UNDERLINE_CHAR		"uc"
+
+static inline void my_putstring(char *s)
+{
+	tputs(s, fileno(stdout), putchar);
+}
+
+static inline void my_setupterm(char *term, int fildes
+				__attribute__ ((__unused__)), int *errret)
+{
+	*errret = tgetent(tcbuffer, term);
+}
+
+static inline int my_tgetnum(char *s)
+{
+	return tgetnum(s);
+}
+
+static inline int my_tgetflag(char *s)
+{
+	return tgetflag(s);
+}
+
+static inline char *my_tgetstr(char *s)
+{
+	return tgetstr(s, &strbuf);
+}
+
+static inline char *my_tgoto(char *cap, int col, int row)
+{
+	return tgoto(cap, col, row);
+}
+
+#endif				/* HAVE_LIBTERMCAP */
diff --git a/text-utils/more.c b/text-utils/more.c
index dc7aa3f..3937796 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -43,30 +43,37 @@
  *	modified mem allocation handling for util-linux
  */
 
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include <stdlib.h>		/* for alloca() */
-#include <stdarg.h>		/* for va_start() etc */
-#include <sys/param.h>
 #include <ctype.h>
-#include <signal.h>
 #include <errno.h>
 #include <fcntl.h>
-#include <termios.h>
+#include <regex.h>
 #include <setjmp.h>
+#include <signal.h>
+#include <stdarg.h>		/* for va_start() etc */
+#include <stdio.h>
+#include <stdlib.h>		/* for alloca() */
+#include <string.h>
+#include <sys/file.h>
 #include <sys/ioctl.h>
+#include <sys/param.h>
 #include <sys/stat.h>
-#include <sys/file.h>
 #include <sys/wait.h>
+#include <termios.h>
+#include <unistd.h>
 
-#include "strutils.h"
+#ifdef HAVE_NCURSES_H
+# include <ncurses.h>
+#elif defined(HAVE_NCURSES_NCURSES_H)
+# include <ncurses/ncurses.h>
+#endif
+
+#include "more-term.h"		/* include after <curses.h> */
+
+#include "closestream.h"
 #include "nls.h"
-#include "xalloc.h"
+#include "strutils.h"
 #include "widechar.h"
-#include "closestream.h"
-
-#include <regex.h>
+#include "xalloc.h"
 
 #ifdef TEST_PROGRAM
 # define NON_INTERACTIVE_MORE 1
@@ -87,7 +94,17 @@
 #define putserr(s)	fputs(s, stderr)
 #define putsout(s)	fputs(s, stdout)
 
-#define stty(fd,argp)  tcsetattr(fd,TCSANOW,argp)
+#define stty(fd,argp)	tcsetattr(fd,TCSANOW,argp)
+#define ringbell()	putcerr('\007')
+
+static char *BS = "\b";
+static char *BSB = "\b \b";
+static char *CARAT = "^";
+#define ERASEONECOLUMN \
+    if (docrterase) \
+	putserr(BSB); \
+    else \
+	putserr(BS);
 
 #define TBUFSIZ		1024
 #define LINSIZ		256	/* minimal Line buffer size */
@@ -103,6 +120,7 @@
 #define SHELL_LINE	1000
 #define COMMAND_BUF	200
 #define REGERR_BUF	NUM_COLUMNS
+#define STOP		-10
 
 struct termios otty, savetty0;
 long file_pos, file_size;
@@ -160,138 +178,12 @@ static char ch;
 static int lastcmd, lastarg, lastp;
 static int lastcolon;
 char shell_line[SHELL_LINE];
-#define ringbell()	putcerr('\007')
-static char *BS = "\b";
-static char *BSB = "\b \b";
-static char *CARAT = "^";
-#define ERASEONECOLUMN \
-    if (docrterase) \
-	putserr(BSB); \
-    else \
-	putserr(BS);
-
-#ifdef HAVE_NCURSES_H
-# include <ncurses.h>
-#elif defined(HAVE_NCURSES_NCURSES_H)
-# include <ncurses/ncurses.h>
-#endif
-
-#if defined(HAVE_NCURSES_H) || defined(HAVE_NCURSES_NCURSES_H)
-# include <term.h>		/* include after <curses.h> */
-
-# define TERM_AUTO_RIGHT_MARGIN    "am"
-# define TERM_CEOL                 "xhp"
-# define TERM_CLEAR                "clear"
-# define TERM_CLEAR_TO_LINE_END    "el"
-# define TERM_CLEAR_TO_SCREEN_END  "ed"
-# define TERM_COLS                 "cols"
-# define TERM_CURSOR_ADDRESS       "cup"
-# define TERM_EAT_NEW_LINE         "xenl"
-# define TERM_ENTER_UNDERLINE      "smul"
-# define TERM_EXIT_STANDARD_MODE   "rmso"
-# define TERM_EXIT_UNDERLINE       "rmul"
-# define TERM_HARD_COPY            "hc"
-# define TERM_HOME                 "home"
-# define TERM_LINE_DOWN            "cud1"
-# define TERM_LINES                "lines"
-# define TERM_OVER_STRIKE          "os"
-# define TERM_PAD_CHAR             "pad"
-# define TERM_STANDARD_MODE        "smso"
-# define TERM_STD_MODE_GLITCH      "xmc"
-# define TERM_UNDERLINE_CHAR       "uc"
-# define TERM_UNDERLINE            "ul"
-
-static void my_putstring(char *s)
-{
-	tputs(s, fileno(stdout), putchar);	/* putp(s); */
-}
-
-static void my_setupterm(char *term, int fildes, int *errret)
-{
-	setupterm(term, fildes, errret);
-}
-
-static int my_tgetnum(char *s)
-{
-	return tigetnum(s);
-}
-
-static int my_tgetflag(char *s)
-{
-	return tigetflag(s);
-}
-
-static char *my_tgetstr(char *s)
-{
-	return tigetstr(s);
-}
-
-static char *my_tgoto(char *cap, int col, int row)
-{
-	return tparm(cap, col, row);
-}
-
-#elif defined(HAVE_LIBTERMCAP)	/* ncurses not found */
-
-# include <termcap.h>
-
-# define TERM_AUTO_RIGHT_MARGIN    "am"
-# define TERM_CEOL                 "xs"
-# define TERM_CLEAR                "cl"
-# define TERM_CLEAR_TO_LINE_END    "ce"
-# define TERM_CLEAR_TO_SCREEN_END  "cd"
-# define TERM_COLS                 "co"
-# define TERM_CURSOR_ADDRESS       "cm"
-# define TERM_EAT_NEW_LINE         "xn"
-# define TERM_ENTER_UNDERLINE      "us"
-# define TERM_EXIT_STANDARD_MODE   "se"
-# define TERM_EXIT_UNDERLINE       "ue"
-# define TERM_HARD_COPY            "hc"
-# define TERM_HOME                 "ho"
-# define TERM_LINE_DOWN            "le"
-# define TERM_LINES                "li"
-# define TERM_OVER_STRIKE          "os"
-# define TERM_PAD_CHAR             "pc"
-# define TERM_STANDARD_MODE        "so"
-# define TERM_STD_MODE_GLITCH      "sg"
-# define TERM_UNDERLINE_CHAR       "uc"
-# define TERM_UNDERLINE            "ul"
 
+#if !defined(HAVE_NCURSES_H) && !defined(HAVE_NCURSES_NCURSES_H) && defined(HAVE_LIBTERMCAP)
 char termbuffer[TERMINAL_BUF];
 char tcbuffer[TERMINAL_BUF];
 char *strbuf = termbuffer;
-
-static void my_putstring(char *s)
-{
-	tputs(s, fileno(stdout), putchar);
-}
-
-static void my_setupterm(char *term, int fildes __attribute__((__unused__)), int *errret)
-{
-	*errret = tgetent(tcbuffer, term);
-}
-
-static int my_tgetnum(char *s)
-{
-	return tgetnum(s);
-}
-
-static int my_tgetflag(char *s)
-{
-	return tgetflag(s);
-}
-
-static char *my_tgetstr(char *s)
-{
-	return tgetstr(s, &strbuf);
-}
-
-static char *my_tgoto(char *cap, int col, int row)
-{
-	return tgoto(cap, col, row);
-}
-
-#endif	/* HAVE_LIBTERMCAP */
+#endif
 
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
@@ -1747,7 +1639,6 @@ static int command(char *filename, register FILE *f)
 }
 
 /* Print out the contents of the file f, one screenful at a time. */
-#define STOP -10
 static void screen(register FILE *f, register int num_lines)
 {
 	register int c;
-- 
2.3.0

