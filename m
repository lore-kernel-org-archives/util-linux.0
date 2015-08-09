Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38374 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933120AbbHISTL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Aug 2015 14:19:11 -0400
Received: by wibxm9 with SMTP id xm9so123360991wib.1
        for <util-linux@vger.kernel.org>; Sun, 09 Aug 2015 11:19:10 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/3] colcrt: use #define in place of magic constants
Date: Sun,  9 Aug 2015 19:19:04 +0100
Message-Id: <1439144346-5647-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1439144346-5647-1-git-send-email-kerolasa@iki.fi>
References: <1439144346-5647-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/colcrt.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/text-utils/colcrt.c b/text-utils/colcrt.c
index 567e7b5..cf630c4 100644
--- a/text-utils/colcrt.c
+++ b/text-utils/colcrt.c
@@ -68,7 +68,10 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out);
  * Option -2 forces printing of all half lines.
  */
 
-wchar_t	page[267][132];
+#define FLUSH_SIZE 62
+#define PAGE_ARRAY_ROWS 267
+#define PAGE_ARRAY_COLS 132
+wchar_t	page[PAGE_ARRAY_ROWS][PAGE_ARRAY_COLS];
 
 int	outline = 1;
 int	outcol;
@@ -158,8 +161,8 @@ void colcrt(FILE *f) {
 		}
 		switch (c) {
 		case '\n':
-			if (outline >= 265)
-				pflush(62);
+			if (outline >= (PAGE_ARRAY_ROWS - 2))
+				pflush(FLUSH_SIZE);
 			outline += 2;
 			outcol = 0;
 			continue;
@@ -170,8 +173,8 @@ void colcrt(FILE *f) {
 			c = getwc(f);
 			switch (c) {
 			case '9':
-				if (outline >= 266)
-					pflush(62);
+				if (outline >= (PAGE_ARRAY_ROWS - 1))
+					pflush(FLUSH_SIZE);
 				outline++;
 				continue;
 			case '8':
@@ -198,7 +201,7 @@ void colcrt(FILE *f) {
 			/* fallthrough */
 		default:
 			w = wcwidth(c);
-			if (outcol + w > 132) {
+			if (outcol + w > PAGE_ARRAY_COLS) {
 				outcol++;
 				continue;
 			}
@@ -207,7 +210,7 @@ void colcrt(FILE *f) {
 			if (c == '_') {
 				if (suppresul)
 					continue;
-				cp += 132;
+				cp += PAGE_ARRAY_COLS;
 				c = '-';
 			}
 			if (*cp == 0) {
@@ -250,8 +253,8 @@ void pflush(int ol)
 
 	l = ol;
 	lastomit = 0;
-	if (l > 266)
-		l = 266;
+	if (l > (PAGE_ARRAY_ROWS - 1))
+		l = PAGE_ARRAY_ROWS - 1;
 	else
 		l |= 1;
 	for (i = first | 1; i < l; i++) {
@@ -274,8 +277,8 @@ void pflush(int ol)
 		}
 		putwchar('\n');
 	}
-	memmove(page, page[ol], (267 - ol) * 132 * sizeof(wchar_t));
-	memset(page[267 - ol], '\0', ol * 132 * sizeof(wchar_t));
+	memmove(page, page[ol], (PAGE_ARRAY_ROWS - ol) * PAGE_ARRAY_COLS * sizeof(wchar_t));
+	memset(page[PAGE_ARRAY_ROWS - ol], '\0', ol * PAGE_ARRAY_COLS * sizeof(wchar_t));
 	outline -= ol;
 	outcol = 0;
 	first = 1;
-- 
2.5.0

