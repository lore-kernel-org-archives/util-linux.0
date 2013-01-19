Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33003 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248Ab3ASAJi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:09:38 -0500
Received: by mail-wg0-f45.google.com with SMTP id dq12so2474123wgb.0
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:09:37 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/22] more: allow non-interactive invocation of the command
Date: Sat, 19 Jan 2013 00:08:58 +0000
Message-Id: <1358554151-25985-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Needed for testing.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.1 |  5 +++++
 text-utils/more.c | 17 +++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/text-utils/more.1 b/text-utils/more.1
index 479f037..b50fdfc 100644
--- a/text-utils/more.1
+++ b/text-utils/more.1
@@ -97,6 +97,11 @@ remainder of each line as it is displayed.
 .B \-s
 Squeeze multiple blank lines into one.
 .TP
+.B \-n
+Allow non-interactive terminal to behave like a normal terminal.  Useful
+for more tests scripts.  The switch will effect properly only when it is
+part of MORE options.
+.TP
 .B \-u
 Suppress underlining.
 .TP
diff --git a/text-utils/more.c b/text-utils/more.c
index 41caeb1..b115539 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -134,7 +134,7 @@ void prepare_line_buffer(void);
 
 struct termios otty, savetty0;
 long file_pos, file_size;
-int fnum, no_intty, no_tty, slow_tty;
+int fnum, no_intty, no_tty, slow_tty, non_interactive;
 int dum_opt, dlines;
 void onquit(int), onsusp(int), chgwinsz(int), end_it(int);
 int nscroll = SCROLL_LEN;	/* Number of lines scrolled by 'd' */
@@ -323,6 +323,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		  "  -c        suppress scroll, display text and clean line ends\n"
 		  "  -u        suppress underlining\n"
 		  "  -s        squeeze multiple blank lines into one\n"
+		  "  -n        allow non-interactive terminal\n"
 		  "  -NUM      specify the number of lines per screenful\n"
 		  "  +NUM      display file beginning from line number NUM\n"
 		  "  +/STRING  display file beginning from search string match\n"
@@ -351,6 +352,10 @@ int main(int argc, char **argv)
 	nfiles = argc;
 	fnames = argv;
 	setlocale(LC_ALL, "");
+
+	if ((s = getenv("MORE")) != NULL)
+		argscan(s);
+
 	initterm();
 
 	/* Auto set no scroll on when binary is called page */
@@ -362,10 +367,6 @@ int main(int argc, char **argv)
 	nscroll = Lpp / 2 - 1;
 	if (nscroll <= 0)
 		nscroll = 1;
-
-	if ((s = getenv("MORE")) != NULL)
-		argscan(s);
-
 	while (--nfiles > 0) {
 		if ((ch = (*++fnames)[0]) == '-') {
 			argscan(*fnames + 1);
@@ -556,6 +557,9 @@ void argscan(char *s)
 		case 's':
 			ssp_opt = 1;
 			break;
+		case 'n':
+			non_interactive = 1;
+			break;
 		case 'u':
 			ul_opt = 0;
 			break;
@@ -1759,7 +1763,8 @@ void initterm(void)
 #ifdef do_SIGTTOU
  retry:
 #endif
-	no_tty = tcgetattr(fileno(stdout), &otty);
+	if (non_interactive == 0)
+		no_tty = tcgetattr(fileno(stdout), &otty);
 	if (!no_tty) {
 		docrterase = (otty.c_cc[VERASE] != 255);
 		docrtkill = (otty.c_cc[VKILL] != 255);
-- 
1.8.1.1

