Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:61501 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbbBVOot (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:49 -0500
Received: by mail-wg0-f48.google.com with SMTP id l18so21217900wgh.7
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:48 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 30/31] more: remove TIOCGWINSZ preprocessor #ifdef checks
Date: Sun, 22 Feb 2015 14:43:26 +0000
Message-Id: <1424616207-747-31-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The change_window_sz(), that used to be chgwinsz(), has done assumption
TIOCGWINSZ without check for long time.  It is time to remove the rest of
the #ifdefs.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 449f9cd..f349109 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1793,9 +1793,7 @@ static void initterm(struct more_control *ctl)
 {
 	int ret, tmp;
 	char *term;
-#ifdef TIOCGWINSZ
 	struct winsize win;
-#endif
 
 #ifndef NON_INTERACTIVE_MORE
 	ctl->no_tty = tcgetattr(STDOUT_FILENO, &ctl->otty);
@@ -1812,19 +1810,15 @@ static void initterm(struct more_control *ctl)
 			ctl->dumb = 1;
 			ctl->ul_opt = 0;
 		} else {
-#ifdef TIOCGWINSZ
 			if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &win) < 0) {
-#endif
 				ctl->lines_per_page = my_tgetnum(TERM_LINES);
 				ctl->ncolumns = my_tgetnum(TERM_COLS);
-#ifdef TIOCGWINSZ
 			} else {
 				if ((ctl->lines_per_page = win.ws_row) == 0)
 					ctl->lines_per_page = my_tgetnum(TERM_LINES);
 				if ((ctl->ncolumns = win.ws_col) == 0)
 					ctl->ncolumns = my_tgetnum(TERM_COLS);
 			}
-#endif
 			if ((ctl->lines_per_page <= 0) || my_tgetflag(TERM_HARD_COPY)) {
 				ctl->hard_term = 1;
 				ctl->lines_per_page = LINES_PER_PAGE;
-- 
2.3.0

