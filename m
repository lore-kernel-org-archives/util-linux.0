Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f170.google.com ([74.125.82.170]:36773 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbbBVOoI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:08 -0500
Received: by wevk48 with SMTP id k48so13641200wev.3
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:06 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 08/31] more: remove pointless functions
Date: Sun, 22 Feb 2015 14:43:04 +0000
Message-Id: <1424616207-747-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 78 ++++++++++++++++++++-----------------------------------
 1 file changed, 28 insertions(+), 50 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 01c999e..52ec23f 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -263,12 +263,6 @@ static void argscan(struct more_control *ctl, char *s)
 	}
 }
 
-/* force clear to end of line */
-static void cleareol(struct more_control *ctl)
-{
-	my_putstring(ctl->eraseln);
-}
-
 /* magic --
  *	check for file magic numbers.  This code would best be shared
  *	with the file(1) program or, perhaps, more should not try to be
@@ -328,7 +322,7 @@ static FILE *checkf(struct more_control *ctl, register char *fs, int *clearfirst
 	if (stat(fs, &stbuf) == -1) {
 		fflush(stdout);
 		if (ctl->clreol)
-			cleareol(ctl);
+			my_putstring(ctl->eraseln);
 		warn(_("stat of %s failed"), fs);
 		return NULL;
 	}
@@ -586,11 +580,6 @@ static void erasep(struct more_control *ctl, register int col)
 	ctl->promptlen = 0;
 }
 
-static void clreos(struct more_control *ctl)
-{
-	my_putstring(ctl->EodClr);
-}
-
 static UL_ASAN_BLACKLIST size_t xmbrtowc(wchar_t *wc, const char *s, size_t n,
 				  mbstate_t *mbstate)
 {
@@ -675,7 +664,7 @@ static void kill_line(struct more_control *ctl)
 static void prompt(struct more_control *ctl, char *filename)
 {
 	if (ctl->clreol)
-		cleareol(ctl);
+		my_putstring(ctl->eraseln);
 	else if (ctl->promptlen > 0)
 		kill_line(ctl);
 	if (!ctl->hard) {
@@ -685,7 +674,7 @@ static void prompt(struct more_control *ctl, char *filename)
 			ctl->promptlen += (2 * ctl->soglitch);
 		}
 		if (ctl->clreol)
-			cleareol(ctl);
+			my_putstring(ctl->eraseln);
 		ctl->promptlen += printf(_("--More--"));
 		if (filename != NULL) {
 			ctl->promptlen += printf(_("(Next file: %s)"), filename);
@@ -701,24 +690,19 @@ static void prompt(struct more_control *ctl, char *filename)
 		if (ctl->Senter && ctl->Sexit)
 			my_putstring(ctl->Sexit);
 		if (ctl->clreol)
-			clreos(ctl);
+			my_putstring(ctl->EodClr);
 		fflush(stdout);
 	} else
 		fputc('\a', stderr);
 	ctl->inwait = 1;
 }
 
-static int ourputch(int c)
-{
-	return putc(c, stdout);
-}
-
 static void reset_tty(struct more_control *ctl)
 {
 	if (ctl->no_tty)
 		return;
 	if (ctl->pstate) {
-		tputs(ctl->ULexit, fileno(stdout), ourputch);
+		tputs(ctl->ULexit, fileno(stdout), putchar);
 		fflush(stdout);
 		ctl->pstate = 0;
 	}
@@ -734,7 +718,7 @@ static void __attribute__((__noreturn__)) end_it(int dummy __attribute__((__unus
 	reset_tty(global_ctl);
 	if (global_ctl->clreol) {
 		putchar('\r');
-		clreos(global_ctl);
+		my_putstring(global_ctl->EodClr);
 		fflush(stdout);
 	} else if (!global_ctl->clreol && (global_ctl->promptlen > 0)) {
 		kill_line(global_ctl);
@@ -798,14 +782,14 @@ static void skipf(struct more_control *ctl, register int nskip)
 		ctl->fnum = 0;
 	puts(_("\n...Skipping "));
 	if (ctl->clreol)
-		cleareol(ctl);
+		my_putstring(ctl->eraseln);
 	if (nskip > 0)
 		fputs(_("...Skipping to file "), stdout);
 	else
 		fputs(_("...Skipping back to file "), stdout);
 	puts(ctl->fnames[ctl->fnum]);
 	if (ctl->clreol)
-		cleareol(ctl);
+		my_putstring(ctl->eraseln);
 	putchar('\n');
 	ctl->fnum--;
 }
@@ -824,7 +808,7 @@ static void show(struct more_control *ctl, char c)
 static void more_error(struct more_control *ctl, char *mess)
 {
 	if (ctl->clreol)
-		cleareol(ctl);
+		my_putstring(ctl->eraseln);
 	else
 		kill_line(ctl);
 	ctl->promptlen += strlen(mess);
@@ -1277,12 +1261,6 @@ static void rdline(struct more_control *ctl, register FILE *f)
 	*p = '\0';
 }
 
-/* Go to home position */
-static void home(struct more_control *ctl)
-{
-	my_putstring(ctl->Home);
-}
-
 /* Search for nth occurrence of regular expression contained in buf in
  * the file */
 static void search(struct more_control *ctl, char buf[], FILE *file, register int n)
@@ -1316,7 +1294,7 @@ static void search(struct more_control *ctl, char buf[], FILE *file, register in
 				if (lncount > 3 || (lncount > 1 && ctl->no_intty)) {
 					putchar('\n');
 					if (ctl->clreol)
-						cleareol(ctl);
+						my_putstring(ctl->eraseln);
 					fputs(_("...skipping\n"), stdout);
 				}
 				if (!ctl->no_intty) {
@@ -1325,8 +1303,8 @@ static void search(struct more_control *ctl, char buf[], FILE *file, register in
 					set_pos_fseek(ctl, file, line3);
 					if (ctl->noscroll) {
 						if (ctl->clreol) {
-							home(ctl);
-							cleareol(ctl);
+							my_putstring(ctl->Home);
+							my_putstring(ctl->eraseln);
 						} else
 							doclear(ctl);
 					}
@@ -1334,8 +1312,8 @@ static void search(struct more_control *ctl, char buf[], FILE *file, register in
 					kill_line(ctl);
 					if (ctl->noscroll) {
 						if (ctl->clreol) {
-							home(ctl);
-							cleareol(ctl);
+							my_putstring(ctl->Home);
+							my_putstring(ctl->eraseln);
 						} else
 							doclear(ctl);
 					}
@@ -1418,12 +1396,12 @@ static int command(struct more_control *ctl, char *filename, register FILE *f)
 				erasep(ctl, 0);
 				putchar('\n');
 				if (ctl->clreol)
-					cleareol(ctl);
+					my_putstring(ctl->eraseln);
 				printf(P_("...back %d page",
 					"...back %d pages", nlines),
 					nlines);
 				if (ctl->clreol)
-					cleareol(ctl);
+					my_putstring(ctl->eraseln);
 				putchar('\n');
 
 				initline = ctl->Currline - ctl->dlines * (nlines + 1);
@@ -1473,13 +1451,13 @@ static int command(struct more_control *ctl, char *filename, register FILE *f)
 			erasep(ctl, 0);
 			putchar('\n');
 			if (ctl->clreol)
-				cleareol(ctl);
+				my_putstring(ctl->eraseln);
 			printf(P_("...skipping %d line",
 				"...skipping %d lines", nlines),
 				nlines);
 
 			if (ctl->clreol)
-				cleareol(ctl);
+				my_putstring(ctl->eraseln);
 			putchar('\n');
 
 			while (nlines > 0) {
@@ -1677,7 +1655,7 @@ static void screen(struct more_control *ctl, register FILE *f, register int num_
 		while (num_lines > 0 && !ctl->Pause) {
 			if ((nchars = get_line(ctl, f, &length)) == EOF) {
 				if (ctl->clreol)
-					clreos(ctl);
+					my_putstring(ctl->EodClr);
 				return;
 			}
 			if (ctl->ssp_opt && length == 0 && prev_len == 0)
@@ -1690,7 +1668,7 @@ static void screen(struct more_control *ctl, register FILE *f, register int num_
 			 * some terminals do not erase what they tab
 			 * over. */
 			if (ctl->clreol)
-				cleareol(ctl);
+				my_putstring(ctl->eraseln);
 			prbuf(ctl, ctl->Line, length);
 			if (nchars < ctl->promptlen)
 				erasep(ctl, nchars);	/* erasep () sets promptlen to 0 */
@@ -1709,12 +1687,12 @@ static void screen(struct more_control *ctl, register FILE *f, register int num_
 		fflush(stdout);
 		if ((c = more_getc(ctl, f)) == EOF) {
 			if (ctl->clreol)
-				clreos(ctl);
+				my_putstring(ctl->EodClr);
 			return;
 		}
 
 		if (ctl->Pause && ctl->clreol)
-			clreos(ctl);
+			my_putstring(ctl->EodClr);
 		more_ungetc(ctl, c, f);
 		sigsetjmp(ctl->restore, 1);
 		ctl->Pause = 0;
@@ -1725,7 +1703,7 @@ static void screen(struct more_control *ctl, register FILE *f, register int num_
 			erasep(ctl, 0);
 		if (ctl->noscroll && num_lines >= ctl->dlines) {
 			if (ctl->clreol)
-				home(ctl);
+				my_putstring(ctl->Home);
 			else
 				doclear(ctl);
 		}
@@ -1991,7 +1969,7 @@ int main(int argc, char **argv)
 				more_ungetc(&ctl, c, f);
 				if (ctl.noscroll && (c != EOF)) {
 					if (ctl.clreol)
-						home(&ctl);
+						my_putstring(ctl.Home);
 					else
 						doclear(&ctl);
 				}
@@ -2035,7 +2013,7 @@ int main(int argc, char **argv)
 				if ((ctl.noscroll || clearit)
 				    && (ctl.file_size != LONG_MAX)) {
 					if (ctl.clreol)
-						home(&ctl);
+						my_putstring(ctl.Home);
 					else
 						doclear(&ctl);
 				}
@@ -2043,16 +2021,16 @@ int main(int argc, char **argv)
 					if (ctl.bad_so)
 						erasep(&ctl, 0);
 					if (ctl.clreol)
-						cleareol(&ctl);
+						my_putstring(ctl.eraseln);
 					fputs("::::::::::::::", stdout);
 					if (ctl.promptlen > 14)
 						erasep(&ctl, 14);
 					putchar('\n');
 					if (ctl.clreol)
-						cleareol(&ctl);
+						my_putstring(ctl.eraseln);
 					puts(ctl.fnames[ctl.fnum]);
 					if (ctl.clreol)
-						cleareol(&ctl);
+						my_putstring(ctl.eraseln);
 					puts("::::::::::::::");
 					if (left > ctl.Lpp - 4)
 						left = ctl.Lpp - 4;
-- 
2.3.0

