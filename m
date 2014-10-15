Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:49362 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbaJOVTu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 15 Oct 2014 17:19:50 -0400
Received: by mail-wi0-f175.google.com with SMTP id d1so14158278wiv.2
        for <util-linux@vger.kernel.org>; Wed, 15 Oct 2014 14:19:49 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/4] ul: fix filter() indentation
Date: Wed, 15 Oct 2014 22:19:27 +0100
Message-Id: <1413407968-2289-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1413407968-2289-1-git-send-email-kerolasa@iki.fi>
References: <1413407968-2289-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Content of the while() loop missed one indentation step.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/ul.c | 160 ++++++++++++++++++++++++++------------------------------
 1 file changed, 75 insertions(+), 85 deletions(-)

diff --git a/text-utils/ul.c b/text-utils/ul.c
index 054f7b9..20a0551 100644
--- a/text-utils/ul.c
+++ b/text-utils/ul.c
@@ -281,94 +281,84 @@ static void filter(FILE *f)
 	wint_t c;
 	int i, w;
 
-	while ((c = getwc(f)) != WEOF)
-	switch (c) {
-
-	case '\b':
-		setcol(col - 1);
-		continue;
-
-	case '\t':
-		setcol((col+8) & ~07);
-		continue;
-
-	case '\r':
-		setcol(0);
-		continue;
-
-	case SO:
-		mode |= ALTSET;
-		continue;
-
-	case SI:
-		mode &= ~ALTSET;
-		continue;
-
-	case IESC:
-		if(handle_escape(f)) {
-			c = getwc(f);
-			errx(EXIT_FAILURE,
-				_("unknown escape sequence in input: %o, %o"),
-				IESC, c);
-		}
-		continue;
-
-	case '_':
-		if (obuf[col].c_char || obuf[col].c_width < 0) {
-			while(col > 0 && obuf[col].c_width < 0)
-				col--;
-			w = obuf[col].c_width;
-			for (i = 0; i < w; i++)
-				obuf[col++].c_mode |= UNDERL | mode;
-			setcol(col);
+	while ((c = getwc(f)) != WEOF) {
+		switch (c) {
+		case '\b':
+			setcol(col - 1);
 			continue;
-		}
-		obuf[col].c_char = '_';
-		obuf[col].c_width = 1;
-		/* fall through */
-	case ' ':
-		setcol(col + 1);
-		continue;
-
-	case '\n':
-		flushln();
-		continue;
-
-	case '\f':
-		flushln();
-		putwchar('\f');
-		continue;
-
-	default:
-		if (!iswprint(c))
-			/* non printable */
+		case '\t':
+			setcol((col + 8) & ~07);
+			continue;
+		case '\r':
+			setcol(0);
+			continue;
+		case SO:
+			mode |= ALTSET;
+			continue;
+		case SI:
+			mode &= ~ALTSET;
+			continue;
+		case IESC:
+			if (handle_escape(f)) {
+				c = getwc(f);
+				errx(EXIT_FAILURE,
+				     _("unknown escape sequence in input: %o, %o"), IESC, c);
+			}
+			continue;
+		case '_':
+			if (obuf[col].c_char || obuf[col].c_width < 0) {
+				while (col > 0 && obuf[col].c_width < 0)
+					col--;
+				w = obuf[col].c_width;
+				for (i = 0; i < w; i++)
+					obuf[col++].c_mode |= UNDERL | mode;
+				setcol(col);
+				continue;
+			}
+			obuf[col].c_char = '_';
+			obuf[col].c_width = 1;
+			/* fall through */
+		case ' ':
+			setcol(col + 1);
+			continue;
+		case '\n':
+			flushln();
+			continue;
+		case '\f':
+			flushln();
+			putwchar('\f');
+			continue;
+		default:
+			if (!iswprint(c))
+				/* non printable */
+				continue;
+			w = wcwidth(c);
+			needcol(col + w);
+			if (obuf[col].c_char == '\0') {
+				obuf[col].c_char = c;
+				for (i = 0; i < w; i++)
+					obuf[col + i].c_mode = mode;
+				obuf[col].c_width = w;
+				for (i = 1; i < w; i++)
+					obuf[col + i].c_width = -1;
+			} else if (obuf[col].c_char == '_') {
+				obuf[col].c_char = c;
+				for (i = 0; i < w; i++)
+					obuf[col + i].c_mode |= UNDERL | mode;
+				obuf[col].c_width = w;
+				for (i = 1; i < w; i++)
+					obuf[col + i].c_width = -1;
+			} else if ((wint_t) obuf[col].c_char == c) {
+				for (i = 0; i < w; i++)
+					obuf[col + i].c_mode |= BOLD | mode;
+			} else {
+				w = obuf[col].c_width;
+				for (i = 0; i < w; i++)
+					obuf[col + i].c_mode = mode;
+			}
+			setcol(col + w);
 			continue;
-		w = wcwidth(c);
-		needcol(col + w);
-		if (obuf[col].c_char == '\0') {
-			obuf[col].c_char = c;
-			for (i = 0; i < w; i++)
-				obuf[col+i].c_mode = mode;
-			obuf[col].c_width = w;
-			for (i = 1; i < w; i++)
-				obuf[col+i].c_width = -1;
-		} else if (obuf[col].c_char == '_') {
-			obuf[col].c_char = c;
-			for (i = 0; i < w; i++)
-				obuf[col+i].c_mode |= UNDERL|mode;
-			obuf[col].c_width = w;
-			for (i = 1; i < w; i++)
-				obuf[col+i].c_width = -1;
-		} else if ((wint_t) obuf[col].c_char == c) {
-			for (i = 0; i < w; i++)
-				obuf[col+i].c_mode |= BOLD|mode;
-		} else {
-			w = obuf[col].c_width;
-			for (i = 0; i < w; i++)
-				obuf[col+i].c_mode = mode;
 		}
-		setcol(col + w);
-		continue;
 	}
 	if (maxcol)
 		flushln();
-- 
2.1.2

