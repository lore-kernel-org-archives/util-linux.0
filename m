Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f51.google.com ([74.125.82.51]:64245 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbbBVOoe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:34 -0500
Received: by mail-wg0-f51.google.com with SMTP id y19so21185181wgg.10
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:33 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 22/31] more: init function variables at declaration
Date: Sun, 22 Feb 2015 14:43:18 +0000
Message-Id: <1424616207-747-23-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Two lines expressions, such as example below, is more readable when
done with a single line that combines declaration and init.

int i;
i = 0;

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 9a3d96b..e9c123c 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -372,8 +372,8 @@ static void prepare_line_buffer(struct more_control *ctl)
 static int get_line(struct more_control *ctl, FILE *f, int *length)
 {
 	int c;
-	char *p;
-	int column;
+	char *p = ctl->Line;
+	int column = 0;
 	static int colflg;
 
 #ifdef HAVE_WIDECHAR
@@ -392,8 +392,6 @@ static int get_line(struct more_control *ctl, FILE *f, int *length)
 #endif
 	prepare_line_buffer(ctl);
 
-	p = ctl->Line;
-	column = 0;
 	c = more_getc(ctl, f);
 	if (colflg && c == '\n') {
 		ctl->Currline++;
@@ -749,10 +747,9 @@ static int readch(struct more_control *ctl)
  * which terminates the number. */
 static int number(struct more_control *ctl, char *cmd)
 {
-	int i;
+	int i = 0;
 	char ch;
 
-	i = 0;
 	for (;;) {
 		ch = readch(ctl);
 		if (isdigit(ch))
@@ -833,13 +830,11 @@ static void erase_one_column(struct more_control *ctl)
 
 static void ttyin(struct more_control *ctl, char buf[], int nmax, char pchar)
 {
-	char *sp;
+	char *sp = buf;
 	int c;
 	int slash = 0;
-	int maxlen;
+	int maxlen = 0;
 
-	sp = buf;
-	maxlen = 0;
 	while (sp - buf < nmax) {
 		if (ctl->promptlen > maxlen)
 			maxlen = ctl->promptlen;
@@ -957,7 +952,7 @@ static void ttyin(struct more_control *ctl, char buf[], int nmax, char pchar)
 
 static int expand(struct more_control *ctl, char **outbuf, char *inbuf)
 {
-	char *inpstr;
+	char *inpstr = inbuf;
 	char *outstr;
 	char c;
 	char *temp;
@@ -967,7 +962,6 @@ static int expand(struct more_control *ctl, char **outbuf, char *inbuf)
 	xtra = strlen(ctl->fnames[ctl->fnum]) + strlen(ctl->shell_line) + 1;
 	tempsz = 200 + xtra;
 	temp = xmalloc(tempsz);
-	inpstr = inbuf;
 	outstr = temp;
 	while ((c = *inpstr++) != '\0') {
 		offset = outstr - temp;
@@ -1098,7 +1092,7 @@ static void do_shell(struct more_control *ctl, char *filename)
 {
 	char cmdbuf[COMMAND_BUF];
 	int rc;
-	char *expanded;
+	char *expanded = NULL;
 
 	kill_line(ctl);
 	putchar('!');
@@ -1108,7 +1102,6 @@ static void do_shell(struct more_control *ctl, char *filename)
 		fputs(ctl->shell_line, stdout);
 	else {
 		ttyin(ctl, cmdbuf, sizeof(cmdbuf) - 2, '!');
-		expanded = 0;
 		rc = expand(ctl, &expanded, cmdbuf);
 		if (expanded) {
 			if (strlen(expanded) < sizeof(ctl->shell_line))
@@ -1257,13 +1250,12 @@ static void search(struct more_control *ctl, char buf[], FILE *file, int n)
 	long line1 = startline;
 	long line2 = startline;
 	long line3;
-	int lncount;
+	int lncount = 0;
 	int saveln, rc;
 	regex_t re;
 
 	ctl->context.line = saveln = ctl->Currline;
 	ctl->context.chrctr = startline;
-	lncount = 0;
 	if (!buf)
 		goto notfound;
 	if ((rc = regcomp(&re, buf, REG_NOSUB)) != 0) {
-- 
2.3.0

