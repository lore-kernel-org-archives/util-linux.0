Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35552 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876AbcAPXXL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Jan 2016 18:23:11 -0500
Received: by mail-wm0-f49.google.com with SMTP id r129so11607088wmr.0
        for <util-linux@vger.kernel.org>; Sat, 16 Jan 2016 15:23:10 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] build-sys: remove libtermcap support
Date: Sat, 16 Jan 2016 23:23:04 +0000
Message-Id: <1452986584-14013-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It is unlikely anyone is going to build this project on system where
libtermcap is available.  Fedora project obsoleted libtermcap 2007-12-12 in
favour of ncurses.  Debian made same move 2005.

Reference: https://fedoraproject.org/wiki/Deprecated_packages
Reference: https://www.debian.org/doc/manuals/debian-faq/ch-compat.en.html#s-termcap
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac             |  11 -----
 misc-utils/Makemodule.am |   3 --
 misc-utils/cal.c         |  59 +++++--------------------
 text-utils/Makemodule.am |   4 --
 text-utils/more.c        | 110 ++++++++++-------------------------------------
 5 files changed, 34 insertions(+), 153 deletions(-)

diff --git a/configure.ac b/configure.ac
index 83b76ae..ba3597e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -579,17 +579,6 @@ AS_IF([test "x$with_util" = xno], [
 ])
 
 
-AC_ARG_WITH([termcap], AS_HELP_STRING([--without-termcap], [compile without libtermcap]),
-  [], [with_termcap=auto]
-)
-AS_IF([test "x$with_termcap" = xno], [
-  AM_CONDITIONAL([HAVE_TERMCAP], [false])
-  have_termcap=no
-], [
-  UL_CHECK_LIB([termcap], [tgetnum])
-])
-
-
 AC_CHECK_TYPES([union semun], [], [], [[
 #include <sys/sem.h>
 ]])
diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index f2aa881..5ea27e1 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -12,9 +12,6 @@ endif
 
 cal_CFLAGS = $(AM_CFLAGS) $(NCURSES_CFLAGS)
 cal_LDADD = $(LDADD) libcommon.la libtcolors.la $(NCURSES_LIBS)
-if HAVE_TERMCAP
-cal_LDADD += -ltermcap
-endif
 endif # BUILD_CAL
 
 
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 62c5818..b7f3827 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -85,78 +85,42 @@ static const char *Senter = "", *Sexit = "";	/* enter and exit standout mode */
 #  include <ncurses/ncurses.h>
 # endif
 # include <term.h>
+#endif
 
 static int setup_terminal(char *term)
 {
+#if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW)
 	int ret;
 
 	if (setupterm(term, STDOUT_FILENO, &ret) != OK || ret != 1)
 		return -1;
+#endif
 	return 0;
 }
 
 static void my_putstring(char *s)
 {
+#if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW)
 	if (has_term)
 		putp(s);
 	else
+#endif
 		fputs(s, stdout);
 }
 
-static const char *my_tgetstr(char *s __attribute__((__unused__)), char *ss)
+static const char *my_tgetstr(char *s __attribute__ ((__unused__)), char *ss)
 {
 	const char *ret = NULL;
 
+#if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW)
 	if (has_term)
 		ret = tigetstr(ss);
+#endif
 	if (!ret || ret == (char *)-1)
 		return "";
 	return ret;
 }
 
-#elif defined(HAVE_LIBTERMCAP)
-# include <termcap.h>
-
-static char termbuffer[4096];
-static char tcbuffer[4096];
-static char *strbuf = termbuffer;
-
-static int setup_terminal(char *term)
-{
-	if (tgetent(tcbuffer, term) < 0)
-		return -1;
-	return 0;
-}
-
-static void my_putstring(char *s)
-{
-	if (has_term)
-		tputs(s, 1, putchar);
-	else
-		fputs(s, stdout);
-}
-
-static const char *my_tgetstr(char *s, char *ss __attribute__((__unused__)))
-{
-	const char *ret = NULL;
-
-	if (has_term)
-		ret = tgetstr(s, &strbuf);
-	if (!ret)
-		return "";
-	return ret;
-}
-
-#else	/* ! (HAVE_LIBTERMCAP || HAVE_LIBNCURSES || HAVE_LIBNCURSESW) */
-
-static void my_putstring(char *s)
-{
-	fputs(s, stdout);
-}
-
-#endif	/* end of LIBTERMCAP / NCURSES */
-
-
 #include "widechar.h"
 
 enum {
@@ -318,15 +282,14 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-#if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW) || defined(HAVE_LIBTERMCAP)
+#if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW)
 	{
 		char *term = getenv("TERM");
-
 		if (term) {
 			has_term = setup_terminal(term) == 0;
 			if (has_term) {
-				Senter = my_tgetstr("so","smso");
-				Sexit = my_tgetstr("se","rmso");
+				Senter = my_tgetstr("so", "smso");
+				Sexit = my_tgetstr("se", "rmso");
 			}
 		}
 	}
diff --git a/text-utils/Makemodule.am b/text-utils/Makemodule.am
index 94c8c7e..957c143 100644
--- a/text-utils/Makemodule.am
+++ b/text-utils/Makemodule.am
@@ -95,10 +95,6 @@ more_CFLAGS += $(NCURSES_CFLAGS)
 more_LDADD += $(NCURSES_LIBS)
 endif
 
-if HAVE_TERMCAP
-more_LDADD += -ltermcap
-endif
-
 check_PROGRAMS += test_more
 test_more_SOURCES = $(more_SOURCES)
 test_more_CFLAGS = -DTEST_PROGRAM
diff --git a/text-utils/more.c b/text-utils/more.c
index 2ac7439..dc7414f 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -195,31 +195,29 @@ extern char PC;			/* pad character */
 #elif defined(HAVE_NCURSES_NCURSES_H)
 # include <ncurses/ncurses.h>
 #endif
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
+#include <term.h>		/* include after <curses.h> */
+
+#define TERM_AUTO_RIGHT_MARGIN    "am"
+#define TERM_CEOL                 "xhp"
+#define TERM_CLEAR                "clear"
+#define TERM_CLEAR_TO_LINE_END    "el"
+#define TERM_CLEAR_TO_SCREEN_END  "ed"
+#define TERM_COLS                 "cols"
+#define TERM_CURSOR_ADDRESS       "cup"
+#define TERM_EAT_NEW_LINE         "xenl"
+#define TERM_ENTER_UNDERLINE      "smul"
+#define TERM_EXIT_STANDARD_MODE   "rmso"
+#define TERM_EXIT_UNDERLINE       "rmul"
+#define TERM_HARD_COPY            "hc"
+#define TERM_HOME                 "home"
+#define TERM_LINE_DOWN            "cud1"
+#define TERM_LINES                "lines"
+#define TERM_OVER_STRIKE          "os"
+#define TERM_PAD_CHAR             "pad"
+#define TERM_STANDARD_MODE        "smso"
+#define TERM_STD_MODE_GLITCH      "xmc"
+#define TERM_UNDERLINE_CHAR       "uc"
+#define TERM_UNDERLINE            "ul"
 
 static void my_putstring(char *s)
 {
@@ -251,68 +249,6 @@ static char *my_tgoto(char *cap, int col, int row)
 	return tparm(cap, col, row);
 }
 
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
-
-char termbuffer[TERMINAL_BUF];
-char tcbuffer[TERMINAL_BUF];
-char *strbuf = termbuffer;
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
-
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
-- 
2.7.0

