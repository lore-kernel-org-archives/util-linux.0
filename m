Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f179.google.com ([74.125.82.179]:33653 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbbBVOob (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:31 -0500
Received: by wevk48 with SMTP id k48so13653031wev.0
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:30 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 20/31] more: add display_file() to be shared with files and stdin input
Date: Sun, 22 Feb 2015 14:43:16 +0000
Message-Id: <1424616207-747-21-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This allows removing two code segments from main() that perform the same
tasks.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 201 ++++++++++++++++++++++++------------------------------
 1 file changed, 91 insertions(+), 110 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 524ce44..5586e69 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -109,6 +109,7 @@ struct more_control {
 	int nscroll;			/* number of lines scrolled by 'd' */
 	int dlines;			/* screen size in lines */
 	int promptlen;			/* message prompt length */
+	int jumpline;			/* line number to jump */
 	int Currline;			/* line we are currently at */
 	char **fnames;			/* the list of file names */
 	int nfiles;			/* number of files left to process */
@@ -148,6 +149,7 @@ struct more_control {
 		bad_so:1,		/* true if overwriting does not turn off standout */
 		catch_susp:1,		/* should SIGTSTP signal be caught */
 		clreol:1,		/* do not scroll, paint each screen from the top */
+		clearfirst:1,		/* is first character in file \f */
 		docrterase:1,		/* is erase previous supported */
 		docrtkill:1,		/* is erase input supported */
 		dumb:1,			/* is terminal type known */
@@ -158,6 +160,7 @@ struct more_control {
 		fold_opt:1,		/* fold long lines */
 		hard:1,			/* is this hard copy terminal */
 		hardtabs:1,		/* print spaces instead of '\t' */
+		jumpopt:1,		/* is jumpline defined */
 		inwait:1,		/* is waiting user input */
 		lastp:1,		/* run previous key command */
 		noscroll:1,		/* do not scroll, clear the screen and then display text */
@@ -165,8 +168,10 @@ struct more_control {
 		no_intty:1,		/* is input in interactive mode */
 		no_tty:1,		/* is output in interactive mode */
 		Pause:1,		/* is output paused */
+		prnames:1,		/* print file name banner */
 		pstate:1,		/* is underlining going on */
 		soglitch:1,		/* terminal has standout mode glitch */
+		srchopt:1,		/* is init search pattern defined */
 		ssp_opt:1,		/* suppress white space */
 		startup:1,		/* is startup completed */
 		stop_opt:1,		/* stop after form feeds */
@@ -313,7 +318,7 @@ static int more_ungetc(struct more_control *ctl, int c, FILE *stream)
 
 /* Check whether the file named by fs is an ASCII file which the user may
  * access.  If it is, return the opened file.  Otherwise return NULL. */
-static FILE *checkf(struct more_control *ctl, char *fs, int *clearfirst)
+static FILE *checkf(struct more_control *ctl, char *fs)
 {
 	struct stat stbuf;
 	FILE *f;
@@ -330,8 +335,6 @@ static FILE *checkf(struct more_control *ctl, char *fs, int *clearfirst)
 		printf(_("\n*** %s: directory ***\n\n"), fs);
 		return NULL;
 	}
-	ctl->Currline = 0;
-	ctl->file_pos = 0;
 	if ((f = fopen(fs, "r")) == NULL) {
 		fflush(stdout);
 		warn(_("cannot open %s"), fs);
@@ -343,7 +346,7 @@ static FILE *checkf(struct more_control *ctl, char *fs, int *clearfirst)
 	}
 	fcntl(fileno(f), F_SETFD, FD_CLOEXEC);
 	c = more_getc(ctl, f);
-	*clearfirst = (c == '\f');
+	ctl->clearfirst = (c == '\f');
 	more_ungetc(ctl, c, f);
 	if ((ctl->file_size = stbuf.st_size) == 0)
 		ctl->file_size = LONG_MAX;
@@ -1223,9 +1226,9 @@ static int colon(struct more_control *ctl, char *filename, int cmd, int nlines)
 }
 
 /* Skip n lines in the file f */
-static void skiplns(struct more_control *ctl, int n, FILE *f)
+static void skiplns(struct more_control *ctl, FILE *f)
 {
-	int c;
+	int c, n = ctl->jumpline;
 
 	while (n > 0) {
 		while ((c = more_getc(ctl, f)) != '\n')
@@ -1414,8 +1417,6 @@ static void execute_editor(struct more_control *ctl, char *cmdbuf, char *filenam
 
 static int skip_backwards(struct more_control *ctl, FILE *f, int nlines)
 {
-	int initline;
-
 	if (nlines == 0)
 		nlines++;
 	putchar('\r');
@@ -1427,14 +1428,14 @@ static int skip_backwards(struct more_control *ctl, FILE *f, int nlines)
 	if (ctl->clreol)
 		my_putstring(ctl->eraseln);
 	putchar('\n');
-	initline = ctl->Currline - ctl->dlines * (nlines + 1);
+	ctl->jumpline = ctl->Currline - ctl->dlines * (nlines + 1);
 	if (!ctl->noscroll)
-		--initline;
-	if (initline < 0)
-		initline = 0;
+		ctl->jumpline--;
+	if (ctl->jumpline < 0)
+		ctl->jumpline = 0;
 	set_pos_fseek(ctl, f, 0);
 	ctl->Currline = 0;	/* skiplns() will make Currline correct */
-	skiplns(ctl, initline, f);
+	skiplns(ctl, f);
 	if (!ctl->noscroll)
 		return ctl->dlines + 1;
 	return ctl->dlines;
@@ -1863,17 +1864,74 @@ static void initterm(struct more_control *ctl)
 	}
 }
 
+static void display_file(struct more_control *ctl, FILE *f, char *initbuf, int left)
+{
+	ctl->context.line = ctl->context.chrctr = 0;
+	ctl->Currline = 0;
+	ctl->file_pos = 0;
+	if (ctl->firstf)
+		sigsetjmp(ctl->restore, 1);
+	if (ctl->firstf) {
+		ctl->firstf = 0;
+		if (ctl->srchopt) {
+			free(ctl->previousre);
+			ctl->previousre = xstrdup(initbuf);
+			search(ctl, initbuf, f, 1);
+			if (ctl->noscroll)
+				left--;
+		} else if (ctl->jumpopt)
+			skiplns(ctl, f);
+	} else if (ctl->fnum < ctl->nfiles && !ctl->no_tty) {
+		sigsetjmp(ctl->restore, 1);
+		left = command(ctl, ctl->fnames[ctl->fnum], f);
+	}
+	if (left != 0) {
+		if ((ctl->noscroll || ctl->clearfirst)
+		    && (ctl->file_size != LONG_MAX)) {
+			if (ctl->clreol)
+				my_putstring(ctl->Home);
+			else
+				doclear(ctl);
+		}
+		if (ctl->prnames) {
+			if (ctl->bad_so)
+				erasep(ctl, 0);
+			if (ctl->clreol)
+				my_putstring(ctl->eraseln);
+			fputs("::::::::::::::", stdout);
+			if (ctl->promptlen > 14)
+				erasep(ctl, 14);
+			putchar('\n');
+			if (ctl->clreol)
+				my_putstring(ctl->eraseln);
+			puts(ctl->fnames[ctl->fnum]);
+			if (ctl->clreol)
+				my_putstring(ctl->eraseln);
+			puts("::::::::::::::");
+			if (left > ctl->Lpp - 4)
+				left = ctl->Lpp - 4;
+		}
+		if (ctl->no_tty)
+			copy_file(f);
+		else {
+			ctl->within = 1;
+			screen(ctl, f, left);
+			ctl->within = 0;
+		}
+	}
+	sigsetjmp(ctl->restore, 1);
+	fflush(stdout);
+	fclose(f);
+	ctl->screen_start.line = ctl->screen_start.chrctr = 0L;
+	ctl->context.line = ctl->context.chrctr = 0L;
+}
+
 int main(int argc, char **argv)
 {
 	FILE *f;
 	char *s;
 	int c;
 	int left;
-	int prnames = 0;
-	int initopt = 0;
-	int srchopt = 0;
-	int clearit = 0;
-	int initline = 0;
 	char *initbuf = NULL;
 	struct more_control ctl = {
 		.firstf = 1,
@@ -1919,15 +1977,15 @@ int main(int argc, char **argv)
 		} else if (c == '+') {
 			s = *ctl.fnames;
 			if (*++s == '/') {
-				srchopt++;
+				ctl.srchopt = 1;
 				initbuf = xstrdup(s + 1);
 			} else {
-				initopt++;
-				for (initline = 0; *s != '\0'; s++)
+				ctl.jumpopt = 1;
+				for (ctl.jumpline = 0; *s != '\0'; s++)
 					if (isdigit(*s))
-						initline =
-						    initline * 10 + *s - '0';
-				--initline;
+						ctl.jumpline =
+						    ctl.jumpline * 10 + *s - '0';
+				ctl.jumpline--;
 			}
 		} else
 			break;
@@ -1946,11 +2004,9 @@ int main(int argc, char **argv)
 		ctl.dlines = ctl.Lpp - 1;
 	left = ctl.dlines;
 	if (ctl.nfiles > 1)
-		prnames++;
+		ctl.prnames = 1;
 	if (!ctl.no_intty && ctl.nfiles == 0)
 		usage(stderr);
-	else
-		f = stdin;
 	if (!ctl.no_tty) {
 		signal(SIGQUIT, onquit);
 		signal(SIGINT, end_it);
@@ -1967,93 +2023,18 @@ int main(int argc, char **argv)
 		if (ctl.no_tty)
 			copy_file(stdin);
 		else {
-			if ((c = more_getc(&ctl, f)) == '\f')
-				doclear(&ctl);
-			else {
-				more_ungetc(&ctl, c, f);
-				if (ctl.noscroll && (c != EOF)) {
-					if (ctl.clreol)
-						my_putstring(ctl.Home);
-					else
-						doclear(&ctl);
-				}
-			}
-			if (srchopt) {
-				free(ctl.previousre);
-				ctl.previousre = xstrdup(initbuf);
-				search(&ctl, initbuf, stdin, 1);
-				if (ctl.noscroll)
-					left--;
-			} else if (initopt)
-				skiplns(&ctl, initline, stdin);
-			screen(&ctl, stdin, left);
+			f = stdin;
+			display_file(&ctl, f, initbuf, left);
 		}
-		ctl.no_intty = 0;
-		prnames++;
 		ctl.firstf = 0;
+		ctl.no_intty = 0;
+		ctl.prnames = 1;
 	}
 
-	while (ctl.fnum < ctl.nfiles) {
-		if ((f = checkf(&ctl, ctl.fnames[ctl.fnum], &clearit)) != NULL) {
-			ctl.context.line = ctl.context.chrctr = 0;
-			ctl.Currline = 0;
-			if (ctl.firstf)
-				sigsetjmp(ctl.restore, 1);
-			if (ctl.firstf) {
-				ctl.firstf = 0;
-				if (srchopt) {
-					free(ctl.previousre);
-					ctl.previousre = xstrdup(initbuf);
-					search(&ctl, initbuf, f, 1);
-					if (ctl.noscroll)
-						left--;
-				} else if (initopt)
-					skiplns(&ctl, initline, f);
-			} else if (ctl.fnum < ctl.nfiles && !ctl.no_tty) {
-				sigsetjmp(ctl.restore, 1);
-				left = command(&ctl, ctl.fnames[ctl.fnum], f);
-			}
-			if (left != 0) {
-				if ((ctl.noscroll || clearit)
-				    && (ctl.file_size != LONG_MAX)) {
-					if (ctl.clreol)
-						my_putstring(ctl.Home);
-					else
-						doclear(&ctl);
-				}
-				if (prnames) {
-					if (ctl.bad_so)
-						erasep(&ctl, 0);
-					if (ctl.clreol)
-						my_putstring(ctl.eraseln);
-					fputs("::::::::::::::", stdout);
-					if (ctl.promptlen > 14)
-						erasep(&ctl, 14);
-					putchar('\n');
-					if (ctl.clreol)
-						my_putstring(ctl.eraseln);
-					puts(ctl.fnames[ctl.fnum]);
-					if (ctl.clreol)
-						my_putstring(ctl.eraseln);
-					puts("::::::::::::::");
-					if (left > ctl.Lpp - 4)
-						left = ctl.Lpp - 4;
-				}
-				if (ctl.no_tty)
-					copy_file(f);
-				else {
-					ctl.within = 1;
-					screen(&ctl, f, left);
-					ctl.within = 0;
-				}
-			}
-			sigsetjmp(ctl.restore, 1);
-			fflush(stdout);
-			fclose(f);
-			ctl.screen_start.line = ctl.screen_start.chrctr = 0L;
-			ctl.context.line = ctl.context.chrctr = 0L;
-		}
-		ctl.fnum++;
+	for (/* nothing */; ctl.fnum < ctl.nfiles; ctl.fnum++) {
+		if ((f = checkf(&ctl, ctl.fnames[ctl.fnum])) == NULL)
+			continue;
+		display_file(&ctl, f, initbuf, left);
 		ctl.firstf = 0;
 	}
 	free(ctl.previousre);
-- 
2.3.0

