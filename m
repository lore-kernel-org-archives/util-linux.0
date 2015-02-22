Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:52497 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbbBVOou (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:50 -0500
Received: by mail-wg0-f46.google.com with SMTP id a1so21260874wgh.5
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:49 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 31/31] more: simplify initterm()
Date: Sun, 22 Feb 2015 14:43:27 +0000
Message-Id: <1424616207-747-32-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If cases without else's does not need nesting.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 167 +++++++++++++++++++++++++-----------------------------
 1 file changed, 76 insertions(+), 91 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index f349109..0ab4ade 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1791,103 +1791,13 @@ static void copy_file(FILE *f)
 
 static void initterm(struct more_control *ctl)
 {
-	int ret, tmp;
+	int ret;
 	char *term;
 	struct winsize win;
 
 #ifndef NON_INTERACTIVE_MORE
 	ctl->no_tty = tcgetattr(STDOUT_FILENO, &ctl->otty);
 #endif
-	if (!ctl->no_tty) {
-		ctl->docrterase = (ctl->otty.c_cc[VERASE] != 255);
-		ctl->docrtkill = (ctl->otty.c_cc[VKILL] != 255);
-		if ((term = getenv("TERM")) == NULL) {
-			ctl->dumb = 1;
-			ctl->ul_opt = 0;
-		}
-		my_setupterm(term, 1, &ret);
-		if (ret <= 0) {
-			ctl->dumb = 1;
-			ctl->ul_opt = 0;
-		} else {
-			if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &win) < 0) {
-				ctl->lines_per_page = my_tgetnum(TERM_LINES);
-				ctl->ncolumns = my_tgetnum(TERM_COLS);
-			} else {
-				if ((ctl->lines_per_page = win.ws_row) == 0)
-					ctl->lines_per_page = my_tgetnum(TERM_LINES);
-				if ((ctl->ncolumns = win.ws_col) == 0)
-					ctl->ncolumns = my_tgetnum(TERM_COLS);
-			}
-			if ((ctl->lines_per_page <= 0) || my_tgetflag(TERM_HARD_COPY)) {
-				ctl->hard_term = 1;
-				ctl->lines_per_page = LINES_PER_PAGE;
-			}
-
-			if (my_tgetflag(TERM_EAT_NEW_LINE))
-				/* Eat newline at last column + 1; dec, concept */
-				ctl->eatnl = 1;
-			if (ctl->ncolumns <= 0)
-				ctl->ncolumns = NUM_COLUMNS;
-
-			ctl->wrap_margin = my_tgetflag(TERM_AUTO_RIGHT_MARGIN);
-			ctl->bad_so = my_tgetflag(TERM_CEOL);
-			ctl->eraseln = my_tgetstr(TERM_CLEAR_TO_LINE_END);
-			ctl->clear = my_tgetstr(TERM_CLEAR);
-			ctl->std_enter = my_tgetstr(TERM_STANDARD_MODE);
-			ctl->std_exit = my_tgetstr(TERM_EXIT_STANDARD_MODE);
-			tmp = my_tgetnum(TERM_STD_MODE_GLITCH);
-			if (tmp < 0)
-				ctl->stdout_glitch = 0;
-			else if (0 < tmp)
-				ctl->stdout_glitch = 1;
-
-			/* Set up for underlining:  some terminals don't
-			 * need it; others have start/stop sequences,
-			 * still others have an underline char sequence
-			 * which is assumed to move the cursor forward
-			 * one character.  If underline sequence isn't
-			 * available, settle for standout sequence. */
-			if (my_tgetflag(TERM_UNDERLINE)
-			    || my_tgetflag(TERM_OVER_STRIKE))
-				ctl->ul_opt = 0;
-			if ((ctl->underlining_char = my_tgetstr(TERM_UNDERLINE_CHAR)) == NULL)
-				ctl->underlining_char = "";
-			if (((ctl->underline_enter =
-			      my_tgetstr(TERM_ENTER_UNDERLINE)) == NULL
-			     || (ctl->underline_exit =
-				 my_tgetstr(TERM_EXIT_UNDERLINE)) == NULL)
-			    && !*ctl->underlining_char) {
-				if ((ctl->underline_enter = ctl->std_enter) == NULL
-				    || (ctl->underline_exit = ctl->std_exit) == NULL) {
-					ctl->underline_enter = "";
-					ctl->underline_exit = "";
-				} else
-					ctl->ul_glitch = ctl->stdout_glitch;
-			} else {
-				ctl->ul_glitch = 0;
-			}
-
-			ctl->go_home = my_tgetstr(TERM_HOME);
-			if (ctl->go_home == NULL || *ctl->go_home == '\0') {
-				if ((ctl->cursorm =
-				     my_tgetstr(TERM_CURSOR_ADDRESS)) != NULL) {
-					const char *t =
-					    (const char *)my_tgoto(ctl->cursorm, 0,
-								   0);
-					xstrncpy(ctl->cursorhome, t,
-						 sizeof(ctl->cursorhome));
-					ctl->go_home = ctl->cursorhome;
-				}
-			}
-			ctl->end_clear = my_tgetstr(TERM_CLEAR_TO_SCREEN_END);
-			if ((ctl->backspace_char = my_tgetstr(TERM_LINE_DOWN)) == NULL)
-				ctl->backspace_char = "\b";
-
-		}
-		if ((ctl->shell = getenv("SHELL")) == NULL)
-			ctl->shell = _PATH_BSHELL;
-	}
 	ctl->no_intty = tcgetattr(STDIN_FILENO, &ctl->otty);
 	tcgetattr(STDERR_FILENO, &ctl->otty);
 	ctl->orig_tty = ctl->otty;
@@ -1897,6 +1807,81 @@ static void initterm(struct more_control *ctl)
 		ctl->otty.c_cc[VMIN] = 1;
 		ctl->otty.c_cc[VTIME] = 0;
 	}
+	if (ctl->no_tty)
+		return;
+	ctl->docrterase = (ctl->otty.c_cc[VERASE] != 255);
+	ctl->docrtkill = (ctl->otty.c_cc[VKILL] != 255);
+	if ((term = getenv("TERM")) == NULL) {
+		ctl->dumb = 1;
+		ctl->ul_opt = 0;
+	}
+	if ((ctl->shell = getenv("SHELL")) == NULL)
+		ctl->shell = _PATH_BSHELL;
+	my_setupterm(term, 1, &ret);
+	if (ret < 1) {
+		ctl->dumb = 1;
+		ctl->ul_opt = 0;
+		return;
+	}
+	if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &win) < 0) {
+		ctl->lines_per_page = my_tgetnum(TERM_LINES);
+		ctl->ncolumns = my_tgetnum(TERM_COLS);
+	} else {
+		if ((ctl->lines_per_page = win.ws_row) == 0)
+			ctl->lines_per_page = my_tgetnum(TERM_LINES);
+		if ((ctl->ncolumns = win.ws_col) == 0)
+			ctl->ncolumns = my_tgetnum(TERM_COLS);
+	}
+	if ((ctl->lines_per_page < 1) || my_tgetflag(TERM_HARD_COPY)) {
+		ctl->hard_term = 1;
+		ctl->lines_per_page = LINES_PER_PAGE;
+	}
+	if (ctl->ncolumns < 1)
+		ctl->ncolumns = NUM_COLUMNS;
+	if (my_tgetflag(TERM_EAT_NEW_LINE))
+		/* Eat newline at last column + 1; dec, concept */
+		ctl->eatnl = 1;
+	ctl->wrap_margin = my_tgetflag(TERM_AUTO_RIGHT_MARGIN);
+	ctl->bad_so = my_tgetflag(TERM_CEOL);
+	ctl->eraseln = my_tgetstr(TERM_CLEAR_TO_LINE_END);
+	ctl->clear = my_tgetstr(TERM_CLEAR);
+	ctl->std_enter = my_tgetstr(TERM_STANDARD_MODE);
+	ctl->std_exit = my_tgetstr(TERM_EXIT_STANDARD_MODE);
+	if (0 < my_tgetnum(TERM_STD_MODE_GLITCH))
+		ctl->stdout_glitch = 1;
+	/* Set up for underlining:  some terminals don't need it; others have
+	 * start/stop sequences, still others have an underline char sequence
+	 * which is assumed to move the cursor forward one character.  If
+	 * underline sequence isn't available, settle for standout sequence.
+	 */
+	if (my_tgetflag(TERM_UNDERLINE)
+	    || my_tgetflag(TERM_OVER_STRIKE))
+		ctl->ul_opt = 0;
+	if ((ctl->underlining_char = my_tgetstr(TERM_UNDERLINE_CHAR)) == NULL)
+		ctl->underlining_char = "";
+	if (((ctl->underline_enter = my_tgetstr(TERM_ENTER_UNDERLINE)) == NULL
+	     || (ctl->underline_exit = my_tgetstr(TERM_EXIT_UNDERLINE)) == NULL)
+	    && !*ctl->underlining_char) {
+		if ((ctl->underline_enter = ctl->std_enter) == NULL
+		    || (ctl->underline_exit = ctl->std_exit) == NULL) {
+			ctl->underline_enter = "";
+			ctl->underline_exit = "";
+		} else
+			ctl->ul_glitch = ctl->stdout_glitch;
+	} else {
+		ctl->ul_glitch = 0;
+	}
+	ctl->go_home = my_tgetstr(TERM_HOME);
+	if (ctl->go_home == NULL || *ctl->go_home == '\0') {
+		if ((ctl->cursorm = my_tgetstr(TERM_CURSOR_ADDRESS)) != NULL) {
+			const char *t = my_tgoto(ctl->cursorm, 0, 0);
+			xstrncpy(ctl->cursorhome, t, sizeof(ctl->cursorhome));
+			ctl->go_home = ctl->cursorhome;
+		}
+	}
+	ctl->end_clear = my_tgetstr(TERM_CLEAR_TO_SCREEN_END);
+	if ((ctl->backspace_char = my_tgetstr(TERM_LINE_DOWN)) == NULL)
+		ctl->backspace_char = "\b";
 }
 
 static void display_file(struct more_control *ctl, FILE *f, char *initbuf, int left)
-- 
2.3.0

