Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:50005 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbbBVOoT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:19 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so11689553wid.5
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:18 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 14/31] more: move skipping forewards to a function from command()
Date: Sun, 22 Feb 2015 14:43:10 +0000
Message-Id: <1424616207-747-15-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The command() function was too long.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 60 +++++++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index a502716..0c1bc96 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1431,6 +1431,32 @@ static int skip_backwards(struct more_control *ctl, FILE *f, int nlines)
 	return ctl->dlines;
 }
 
+static int skip_forwards(struct more_control *ctl, FILE *f, int nlines, char comchar)
+{
+	if (nlines == 0)
+		nlines++;
+	if (comchar == 'f')
+		nlines *= ctl->dlines;
+	putchar('\r');
+	erasep(ctl, 0);
+	putchar('\n');
+	if (ctl->clreol)
+		my_putstring(ctl->eraseln);
+	printf(P_("...skipping %d line", "...skipping %d lines", nlines), nlines);
+	if (ctl->clreol)
+		my_putstring(ctl->eraseln);
+	putchar('\n');
+	while (nlines > 0) {
+		int c;
+		while ((c = more_getc(ctl, f)) != '\n')
+			if (c == EOF)
+				return 0;
+		ctl->Currline++;
+		nlines--;
+	}
+	return 1;
+}
+
 /* Read a command and do it.  A command consists of an optional integer
  * argument followed by the command character.  Return the number of
  * lines to display in the next screenful.  If there is nothing more to
@@ -1439,7 +1465,6 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 {
 	int nlines;
 	int retval = 0;
-	int c;
 	char colonch;
 	int done = 0;
 	char comchar, cmdbuf[INIT_BUF];
@@ -1502,34 +1527,10 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 		case 's':
 		case 'f':
 		case ctrl('F'):
-			if (nlines == 0)
-				nlines++;
-			if (comchar == 'f')
-				nlines *= ctl->dlines;
-			putchar('\r');
-			erasep(ctl, 0);
-			putchar('\n');
-			if (ctl->clreol)
-				my_putstring(ctl->eraseln);
-			printf(P_("...skipping %d line",
-				"...skipping %d lines", nlines),
-				nlines);
-
-			if (ctl->clreol)
-				my_putstring(ctl->eraseln);
-			putchar('\n');
-
-			while (nlines > 0) {
-				while ((c = more_getc(ctl, f)) != '\n')
-					if (c == EOF) {
-						retval = 0;
-						done++;
-						goto endsw;
-					}
-				ctl->Currline++;
-				nlines--;
-			}
-			retval = ctl->dlines;
+			if (skip_forwards(ctl, f, nlines, comchar))
+				retval = ctl->dlines;
+			else
+				retval = 0;
 			done = 1;
 			break;
 		case '\n':
@@ -1632,7 +1633,6 @@ static int command(struct more_control *ctl, char *filename, FILE *f)
 		}
 	}
 	putchar('\r');
- endsw:
 	ctl->inwait = 0;
 	ctl->notell = 1;
 	return retval;
-- 
2.3.0

