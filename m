Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37506 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbbBVOo2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:28 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so11689979wid.5
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:27 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 17/31] more: do not call fileno() for std{in,out,err} streams
Date: Sun, 22 Feb 2015 14:43:13 +0000
Message-Id: <1424616207-747-18-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

File descriptor numbers are well known for these, use them from unistd.h

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more-term.h |  4 ++--
 text-utils/more.c      | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/text-utils/more-term.h b/text-utils/more-term.h
index b78da5e..31b8c02 100644
--- a/text-utils/more-term.h
+++ b/text-utils/more-term.h
@@ -24,7 +24,7 @@
 
 static inline void my_putstring(char *s)
 {
-	tputs(s, fileno(stdout), putchar);	/* putp(s); */
+	tputs(s, STDOUT_FILENO, putchar);	/* putp(s); */
 }
 
 static inline void my_setupterm(char *term, int fildes, int *errret)
@@ -78,7 +78,7 @@ static inline char *my_tgoto(char *cap, int col, int row)
 
 static inline void my_putstring(char *s)
 {
-	tputs(s, fileno(stdout), putchar);
+	tputs(s, STDOUT_FILENO, putchar);
 }
 
 static inline void my_setupterm(char *term, int fildes
diff --git a/text-utils/more.c b/text-utils/more.c
index bf3ab9c..1afb593 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -701,7 +701,7 @@ static void reset_tty(struct more_control *ctl)
 	if (ctl->no_tty)
 		return;
 	if (ctl->pstate) {
-		tputs(ctl->ULexit, fileno(stdout), putchar);
+		tputs(ctl->ULexit, STDOUT_FILENO, putchar);
 		fflush(stdout);
 		ctl->pstate = 0;
 	}
@@ -734,7 +734,7 @@ static int readch(struct more_control *ctl)
 	unsigned char c;
 
 	errno = 0;
-	if (read(fileno(stderr), &c, 1) <= 0) {
+	if (read(STDERR_FILENO, &c, 1) <= 0) {
 		if (errno != EINTR)
 			end_it(0);
 		else
@@ -1715,7 +1715,7 @@ static void chgwinsz(int dummy __attribute__((__unused__)))
 	struct winsize win;
 
 	signal(SIGWINCH, SIG_IGN);
-	if (ioctl(fileno(stdout), TIOCGWINSZ, &win) != -1) {
+	if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &win) != -1) {
 		if (win.ws_row != 0) {
 			global_ctl->Lpp = win.ws_row;
 			global_ctl->nscroll = global_ctl->Lpp / 2 - 1;
@@ -1748,7 +1748,7 @@ static void initterm(struct more_control *ctl)
 #endif
 
 #ifndef NON_INTERACTIVE_MORE
-	ctl->no_tty = tcgetattr(fileno(stdout), &ctl->otty);
+	ctl->no_tty = tcgetattr(STDOUT_FILENO, &ctl->otty);
 #endif
 	if (!ctl->no_tty) {
 		ctl->docrterase = (ctl->otty.c_cc[VERASE] != 255);
@@ -1763,7 +1763,7 @@ static void initterm(struct more_control *ctl)
 			ctl->ul_opt = 0;
 		} else {
 #ifdef TIOCGWINSZ
-			if (ioctl(fileno(stdout), TIOCGWINSZ, &win) < 0) {
+			if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &win) < 0) {
 #endif
 				ctl->Lpp = my_tgetnum(TERM_LINES);
 				ctl->Mcol = my_tgetnum(TERM_COLS);
@@ -1844,8 +1844,8 @@ static void initterm(struct more_control *ctl)
 		if ((ctl->shell = getenv("SHELL")) == NULL)
 			ctl->shell = _PATH_BSHELL;
 	}
-	ctl->no_intty = tcgetattr(fileno(stdin), &ctl->otty);
-	tcgetattr(fileno(stderr), &ctl->otty);
+	ctl->no_intty = tcgetattr(STDIN_FILENO, &ctl->otty);
+	tcgetattr(STDERR_FILENO, &ctl->otty);
 	ctl->savetty0 = ctl->otty;
 	ctl->hardtabs = (ctl->otty.c_oflag & TABDLY) != XTABS;
 	if (!ctl->no_tty) {
-- 
2.3.0

