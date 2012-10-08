Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:56911 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729Ab2JHHJG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Oct 2012 03:09:06 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so3448340wib.1
        for <util-linux@vger.kernel.org>; Mon, 08 Oct 2012 00:09:06 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/14] more: align void in functions with prototypes, and remove void casts
Date: Mon,  8 Oct 2012 08:08:18 +0100
Message-Id: <1349680100-18120-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
References: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If there is void in argument list at function prototype it is reasonable
to expect to see it also where the function is wrote.  This change also
removes unnecessary return value void casting.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index d056393..2ecb218 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -582,7 +582,7 @@ FILE *checkf(register char *fs, int *clearfirst)
 	int c;
 
 	if (stat(fs, &stbuf) == -1) {
-		(void)fflush(stdout);
+		fflush(stdout);
 		if (clreol)
 			cleareol();
 		perror(fs);
@@ -593,7 +593,7 @@ FILE *checkf(register char *fs, int *clearfirst)
 		return ((FILE *)NULL);
 	}
 	if ((f = Fopen(fs, "r")) == NULL) {
-		(void)fflush(stdout);
+		fflush(stdout);
 		perror(fs);
 		return ((FILE *)NULL);
 	}
@@ -631,11 +631,11 @@ static int magic(FILE *f, char *fs)
 		case 0x457f:	/* simple ELF detection */
 			printf(_("\n******** %s: Not a text file ********\n\n"),
 			       fs);
-			(void)fclose(f);
+			fclose(f);
 			return 1;
 		}
 	}
-	(void)fseek(f, 0L, SEEK_SET);	/* rewind() not necessary */
+	fseek(f, 0L, SEEK_SET);	/* rewind() not necessary */
 	return 0;
 }
 
@@ -749,7 +749,7 @@ void chgwinsz(int dummy __attribute__((__unused__)))
 		if (win.ws_col != 0)
 			Mcol = win.ws_col;
 	}
-	(void)signal(SIGWINCH, chgwinsz);
+	signal(SIGWINCH, chgwinsz);
 }
 #endif				/* SIGWINCH */
 
@@ -1056,7 +1056,7 @@ void erasep(register int col)
 }
 
 /* Erase the current line entirely */
-void kill_line()
+void kill_line(void)
 {
 	erasep(0);
 	if (!eraseln || dumb)
@@ -1064,12 +1064,12 @@ void kill_line()
 }
 
 /* force clear to end of line */
-void cleareol()
+void cleareol(void)
 {
 	my_putstring(eraseln);
 }
 
-void clreos()
+void clreos(void)
 {
 	my_putstring(EodClr);
 }
@@ -1133,7 +1133,7 @@ void prbuf(register char *s, register int n)
 }
 
 /*  Clear the screen */
-void doclear()
+void doclear(void)
 {
 	if (Clear && !hard) {
 		my_putstring(Clear);
@@ -1145,7 +1145,7 @@ void doclear()
 }
 
 /* Go to home position */
-void home()
+void home(void)
 {
 	my_putstring(Home);
 }
@@ -1743,7 +1743,7 @@ void skipf(register int nskip)
 }
 
 /*----------------------------- Terminal I/O -------------------------------*/
-void initterm()
+void initterm(void)
 {
 	int ret;
 	char *padstr;
@@ -1874,7 +1874,7 @@ void initterm()
 	}
 }
 
-int readch()
+int readch(void)
 {
 	unsigned char c;
 
@@ -2101,7 +2101,7 @@ void more_error(char *mess)
 	siglongjmp(restore, 1);
 }
 
-void set_tty()
+void set_tty(void)
 {
 	otty.c_lflag &= ~(ICANON | ECHO);
 	otty.c_cc[VMIN] = 1;	/* read at least 1 char */
@@ -2114,7 +2114,7 @@ static int ourputch(int c)
 	return putc(c, stdout);
 }
 
-void reset_tty()
+void reset_tty(void)
 {
 	if (no_tty)
 		return;
-- 
1.7.12.2

