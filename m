Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:51233 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbbBVOn6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:43:58 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so11688522wid.5
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:43:57 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 05/31] more: return is statement, not a function
Date: Sun, 22 Feb 2015 14:43:01 +0000
Message-Id: <1424616207-747-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 7743570..940d429 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -334,20 +334,20 @@ static FILE *checkf(struct more_control *ctl, register char *fs, int *clearfirst
 		if (ctl->clreol)
 			cleareol(ctl);
 		warn(_("stat of %s failed"), fs);
-		return ((FILE *)NULL);
+		return NULL;
 	}
 	if ((stbuf.st_mode & S_IFMT) == S_IFDIR) {
 		printf(_("\n*** %s: directory ***\n\n"), fs);
-		return ((FILE *)NULL);
+		return NULL;
 	}
 	if ((f = Fopen(fs, "r")) == NULL) {
 		fflush(stdout);
 		warn(_("cannot open %s"), fs);
-		return ((FILE *)NULL);
+		return NULL;
 	}
 	if (magic(f, fs)) {
 		fclose(f);
-		return ((FILE *)NULL);
+		return NULL;
 	}
 	fcntl(fileno(f), F_SETFD, FD_CLOEXEC);
 	c = Getc(f);
@@ -355,7 +355,7 @@ static FILE *checkf(struct more_control *ctl, register char *fs, int *clearfirst
 	Ungetc(c, f);
 	if ((ctl->file_size = stbuf.st_size) == 0)
 		ctl->file_size = LONG_MAX;
-	return (f);
+	return f;
 }
 
 static void prepare_line_buffer(struct more_control *ctl)
@@ -462,10 +462,10 @@ static int get_line(struct more_control *ctl, register FILE *f, int *length)
 			if (p > ctl->Line) {
 				*p = '\0';
 				*length = p - ctl->Line;
-				return (column);
+				return column;
 			}
 			*length = p - ctl->Line;
-			return (EOF);
+			return EOF;
 		}
 		if (c == '\n') {
 			ctl->Currline++;
@@ -508,7 +508,7 @@ static int get_line(struct more_control *ctl, register FILE *f, int *length)
 			ctl->Pause = 1;
 		} else if (c == EOF) {
 			*length = p - ctl->Line;
-			return (column);
+			return column;
 		} else {
 #ifdef HAVE_WIDECHAR
 			if (ctl->fold_opt && MB_CUR_MAX > 1) {
@@ -566,7 +566,7 @@ static int get_line(struct more_control *ctl, register FILE *f, int *length)
 	}
 	*length = p - ctl->Line;
 	*p = 0;
-	return (column);
+	return column;
 }
 
 /* Erase the rest of the prompt, assuming we are starting at column col. */
@@ -751,7 +751,7 @@ static int readch(struct more_control *ctl)
 		else
 			c = ctl->otty.c_cc[VKILL];
 	}
-	return (c);
+	return c;
 }
 
 /* Read a decimal number from the terminal.  Set cmd to the non-digit
@@ -773,7 +773,7 @@ static int number(struct more_control *ctl, char *cmd)
 			break;
 		}
 	}
-	return (i);
+	return i;
 }
 
 /* Skip nskip files in the file list (from the command line).  Nskip may
@@ -1003,7 +1003,7 @@ static int expand(struct more_control *ctl, char **outbuf, char *inbuf)
 	}
 	*outstr++ = '\0';
 	*outbuf = temp;
-	return (changed);
+	return changed;
 }
 
 static void set_tty(struct more_control *ctl)
@@ -1183,7 +1183,7 @@ static int colon(struct more_control *ctl, char *filename, int cmd, int nlines)
 		else
 			ctl->promptlen = printf(_("[Not a file] line %d"), ctl->Currline);
 		fflush(stdout);
-		return (-1);
+		return -1;
 	case 'n':
 		if (nlines == 0) {
 			if (ctl->fnum >= ctl->nfiles - 1)
@@ -1193,27 +1193,27 @@ static int colon(struct more_control *ctl, char *filename, int cmd, int nlines)
 		putchar('\r');
 		erasep(ctl, 0);
 		skipf(ctl, nlines);
-		return (0);
+		return 0;
 	case 'p':
 		if (ctl->no_intty) {
 			ringbell();
-			return (-1);
+			return -1;
 		}
 		putchar('\r');
 		erasep(ctl, 0);
 		if (nlines == 0)
 			nlines++;
 		skipf(ctl, -nlines);
-		return (0);
+		return 0;
 	case '!':
 		do_shell(ctl, filename);
-		return (-1);
+		return -1;
 	case 'q':
 	case 'Q':
 		end_it(0);
 	default:
 		ringbell();
-		return (-1);
+		return -1;
 	}
 }
 
@@ -1393,7 +1393,7 @@ static int command(struct more_control *ctl, char *filename, register FILE *f)
 
 				if (ctl->no_intty) {
 					ringbell();
-					return (-1);
+					return -1;
 				}
 
 				if (nlines == 0)
@@ -1633,7 +1633,7 @@ static int command(struct more_control *ctl, char *filename, register FILE *f)
  endsw:
 	ctl->inwait = 0;
 	ctl->notell = 1;
-	return (retval);
+	return retval;
 }
 
 /* Print out the contents of the file f, one screenful at a time. */
@@ -2051,5 +2051,5 @@ int main(int argc, char **argv)
 	free(initbuf);
 	free(ctl.Line);
 	reset_tty(&ctl);
-	exit(EXIT_SUCCESS);
+	return EXIT_SUCCESS;
 }
-- 
2.3.0

