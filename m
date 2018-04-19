Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38109 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753492AbeDSVqj (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 19 Apr 2018 17:46:39 -0400
Received: by mail-wr0-f196.google.com with SMTP id h3-v6so17788421wrh.5
        for <util-linux@vger.kernel.org>; Thu, 19 Apr 2018 14:46:38 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/2] more: reorder global declarations
Date: Thu, 19 Apr 2018 22:46:27 +0100
Message-Id: <20180419214627.6313-2-kerolasa@iki.fi>
In-Reply-To: <20180419214627.6313-1-kerolasa@iki.fi>
References: <20180419214627.6313-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Group include, defines and such together, and move items inbetween functions
on top of the source file so that everything can be seen easily.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 96 +++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 7df04de7b..d3317cf9c 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -59,6 +59,15 @@
 #include <sys/stat.h>
 #include <sys/file.h>
 #include <sys/wait.h>
+#include <regex.h>
+
+#if defined(HAVE_NCURSESW_TERM_H)
+# include <ncursesw/term.h>
+#elif defined(HAVE_NCURSES_TERM_H)
+# include <ncurses/term.h>
+#elif defined(HAVE_TERM_H)
+# include <term.h>
+#endif
 
 #include "strutils.h"
 #include "nls.h"
@@ -66,8 +75,6 @@
 #include "widechar.h"
 #include "closestream.h"
 
-#include <regex.h>
-
 #ifdef TEST_PROGRAM
 # define NON_INTERACTIVE_MORE 1
 #endif
@@ -89,6 +96,14 @@
 
 #define stty(fd,argp)  tcsetattr(fd,TCSANOW,argp)
 
+#define ERASEONECOLUMN(x) \
+		do { \
+		    if (x) \
+			putserr(BSB); \
+		    else \
+			putserr(BS); \
+		} while(0)
+
 #define TBUFSIZ		1024
 #define LINSIZ		256	/* minimal Line buffer size */
 #define ctrl(letter)	(letter & 077)
@@ -103,6 +118,29 @@
 #define SHELL_LINE	1000
 #define COMMAND_BUF	200
 #define REGERR_BUF	NUM_COLUMNS
+#define STOP		-10
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
 
 static struct termios otty, savetty0;
 static long file_pos, file_size;
@@ -158,35 +196,15 @@ static struct {
 } context, screen_start;
 extern char PC;			/* pad character */
 
-#if defined(HAVE_NCURSESW_TERM_H)
-# include <ncursesw/term.h>
-#elif defined(HAVE_NCURSES_TERM_H)
-# include <ncurses/term.h>
-#elif defined(HAVE_TERM_H)
-# include <term.h>
-#endif
+static char *BS = "\b";
+static char *BSB = "\b \b";
+static char *CARAT = "^";
+
+static char ch;
+static int lastcmd, lastarg, lastp;
+static int lastcolon;
+static char shell_line[SHELL_LINE];
 
-#define TERM_AUTO_RIGHT_MARGIN    "am"
-#define TERM_CEOL                 "xhp"
-#define TERM_CLEAR                "clear"
-#define TERM_CLEAR_TO_LINE_END    "el"
-#define TERM_CLEAR_TO_SCREEN_END  "ed"
-#define TERM_COLS                 "cols"
-#define TERM_CURSOR_ADDRESS       "cup"
-#define TERM_EAT_NEW_LINE         "xenl"
-#define TERM_ENTER_UNDERLINE      "smul"
-#define TERM_EXIT_STANDARD_MODE   "rmso"
-#define TERM_EXIT_UNDERLINE       "rmul"
-#define TERM_HARD_COPY            "hc"
-#define TERM_HOME                 "home"
-#define TERM_LINE_DOWN            "cud1"
-#define TERM_LINES                "lines"
-#define TERM_OVER_STRIKE          "os"
-#define TERM_PAD_CHAR             "pad"
-#define TERM_STANDARD_MODE        "smso"
-#define TERM_STD_MODE_GLITCH      "xmc"
-#define TERM_UNDERLINE_CHAR       "uc"
-#define TERM_UNDERLINE            "ul"
 
 static void putstring(char *s)
 {
@@ -733,8 +751,6 @@ static int readch(void)
 	return (c);
 }
 
-static char ch;
-
 /* Read a decimal number from the terminal.  Set cmd to the non-digit
  * which terminates the number. */
 static int number(char *cmd)
@@ -785,17 +801,6 @@ static void skipf(register int nskip)
 	--fnum;
 }
 
-static char *BS = "\b";
-static char *BSB = "\b \b";
-static char *CARAT = "^";
-#define ERASEONECOLUMN(x) \
-		do { \
-		    if (x) \
-			putserr(BSB); \
-		    else \
-			putserr(BS); \
-		} while(0)
-
 static void show(char c)
 {
 	if ((c < ' ' && c != '\n' && c != ESC) || c == RUBOUT) {
@@ -952,10 +957,6 @@ static void ttyin(char buf[], register int nmax, char pchar)
 		more_error(_("Line too long"));
 }
 
-static int lastcmd, lastarg, lastp;
-static int lastcolon;
-static char shell_line[SHELL_LINE];
-
 /* return: 0 - unchanged, 1 - changed, -1 - overflow (unchanged) */
 static int expand(char **outbuf, char *inbuf)
 {
@@ -1615,7 +1616,6 @@ static int command(char *filename, register FILE *f)
 }
 
 /* Print out the contents of the file f, one screenful at a time. */
-#define STOP -10
 static void screen(register FILE *f, register int num_lines)
 {
 	register int c;
-- 
2.17.0

