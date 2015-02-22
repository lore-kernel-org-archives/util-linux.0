Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:41974 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbbBVOoI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:08 -0500
Received: by mail-wi0-f174.google.com with SMTP id em10so11840304wid.1
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:07 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 09/31] more: remove 'register' keywords
Date: Sun, 22 Feb 2015 14:43:05 +0000
Message-Id: <1424616207-747-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

More is text pager these sorts of speed-ups does not make sense.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 58 +++++++++++++++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 52ec23f..651a34e 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -313,10 +313,10 @@ static int more_ungetc(struct more_control *ctl, int c, FILE *stream)
 
 /* Check whether the file named by fs is an ASCII file which the user may
  * access.  If it is, return the opened file.  Otherwise return NULL. */
-static FILE *checkf(struct more_control *ctl, register char *fs, int *clearfirst)
+static FILE *checkf(struct more_control *ctl, char *fs, int *clearfirst)
 {
 	struct stat stbuf;
-	register FILE *f;
+	FILE *f;
 	int c;
 
 	if (stat(fs, &stbuf) == -1) {
@@ -366,7 +366,7 @@ static void prepare_line_buffer(struct more_control *ctl)
 }
 
 /* Get a logical line */
-static int get_line(struct more_control *ctl, register FILE *f, int *length)
+static int get_line(struct more_control *ctl, FILE *f, int *length)
 {
 	int c;
 	char *p;
@@ -562,7 +562,7 @@ static int get_line(struct more_control *ctl, register FILE *f, int *length)
 }
 
 /* Erase the rest of the prompt, assuming we are starting at column col. */
-static void erasep(struct more_control *ctl, register int col)
+static void erasep(struct more_control *ctl, int col)
 {
 
 	if (ctl->promptlen == 0)
@@ -599,10 +599,10 @@ static int wouldul(char *s, int n)
 }
 
 /* Print a buffer of n characters */
-static void prbuf(struct more_control *ctl, register char *s, register int n)
+static void prbuf(struct more_control *ctl, char *s, int n)
 {
-	register char c;	/* next output character */
-	register int state;	/* next output char's UL state */
+	char c;	/* next output character */
+	int state;	/* next output char's UL state */
 
 	while (--n >= 0)
 		if (!ctl->ul_opt)
@@ -748,7 +748,7 @@ static int readch(struct more_control *ctl)
  * which terminates the number. */
 static int number(struct more_control *ctl, char *cmd)
 {
-	register int i;
+	int i;
 	char ch;
 
 	i = 0;
@@ -768,7 +768,7 @@ static int number(struct more_control *ctl, char *cmd)
 
 /* Skip nskip files in the file list (from the command line).  Nskip may
  * be negative. */
-static void skipf(struct more_control *ctl, register int nskip)
+static void skipf(struct more_control *ctl, int nskip)
 {
 	if (nskip == 0)
 		return;
@@ -831,7 +831,7 @@ static void erase_one_column(struct more_control *ctl)
 		fputs("\b", stderr);
 }
 
-static void ttyin(struct more_control *ctl, char buf[], register int nmax, char pchar)
+static void ttyin(struct more_control *ctl, char buf[], int nmax, char pchar)
 {
 	char *sp;
 	int c;
@@ -1220,9 +1220,9 @@ static int colon(struct more_control *ctl, char *filename, int cmd, int nlines)
 }
 
 /* Skip n lines in the file f */
-static void skiplns(struct more_control *ctl, register int n, register FILE *f)
+static void skiplns(struct more_control *ctl, int n, FILE *f)
 {
-	register int c;
+	int c;
 
 	while (n > 0) {
 		while ((c = more_getc(ctl, f)) != '\n')
@@ -1245,10 +1245,10 @@ static void doclear(struct more_control *ctl)
 	}
 }
 
-static void rdline(struct more_control *ctl, register FILE *f)
+static void rdline(struct more_control *ctl, FILE *f)
 {
-	register int c;
-	register char *p;
+	int c;
+	char *p;
 
 	prepare_line_buffer(ctl);
 
@@ -1263,13 +1263,13 @@ static void rdline(struct more_control *ctl, register FILE *f)
 
 /* Search for nth occurrence of regular expression contained in buf in
  * the file */
-static void search(struct more_control *ctl, char buf[], FILE *file, register int n)
+static void search(struct more_control *ctl, char buf[], FILE *file, int n)
 {
 	long startline = ctl->file_pos;
-	register long line1 = startline;
-	register long line2 = startline;
-	register long line3;
-	register int lncount;
+	long line1 = startline;
+	long line2 = startline;
+	long line3;
+	int lncount;
 	int saveln, rc;
 	regex_t re;
 
@@ -1343,11 +1343,11 @@ notfound:
  * argument followed by the command character.  Return the number of
  * lines to display in the next screenful.  If there is nothing more to
  * display in the current file, zero is returned. */
-static int command(struct more_control *ctl, char *filename, register FILE *f)
+static int command(struct more_control *ctl, char *filename, FILE *f)
 {
-	register int nlines;
-	register int retval = 0;
-	register int c;
+	int nlines;
+	int retval = 0;
+	int c;
 	char colonch;
 	int done = 0;
 	char comchar, cmdbuf[INIT_BUF];
@@ -1382,7 +1382,7 @@ static int command(struct more_control *ctl, char *filename, register FILE *f)
 		case 'b':
 		case ctrl('B'):
 			{
-				register int initline;
+				int initline;
 
 				if (ctl->no_intty) {
 					fputc('\a', stderr);
@@ -1644,10 +1644,10 @@ static int command(struct more_control *ctl, char *filename, register FILE *f)
 }
 
 /* Print out the contents of the file f, one screenful at a time. */
-static void screen(struct more_control *ctl, register FILE *f, register int num_lines)
+static void screen(struct more_control *ctl, FILE *f, int num_lines)
 {
-	register int c;
-	register int nchars;
+	int c;
+	int nchars;
 	int length;			/* length of current line */
 	static int prev_len = 1;	/* length of previous line */
 
@@ -1734,7 +1734,7 @@ static void chgwinsz(int dummy __attribute__((__unused__)))
 }
 #endif				/* SIGWINCH */
 
-static void copy_file(register FILE *f)
+static void copy_file(FILE *f)
 {
 	char buf[BUFSIZ];
 	size_t sz;
-- 
2.3.0

