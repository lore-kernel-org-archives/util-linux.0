Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:45340 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303Ab3HCXP1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 Aug 2013 19:15:27 -0400
Received: by mail-wg0-f50.google.com with SMTP id m15so1460257wgh.17
        for <util-linux@vger.kernel.org>; Sat, 03 Aug 2013 16:15:26 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/3] column: use variable lenght printf field width to wprint blanks
Date: Sun,  4 Aug 2013 00:15:19 +0100
Message-Id: <1375571721-30008-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This makes program to run a little faster.  My test input show about 20%
speed improvement.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/column.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/text-utils/column.c b/text-utils/column.c
index 2084ba6..2430ede 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -308,7 +308,7 @@ wchar_t *local_wcstok(wchar_t * p, const wchar_t * separator, int greedy,
 static void maketbl(wchar_t **list, int entries, wchar_t *separator, int greedy, wchar_t *colsep)
 {
 	TBL *t;
-	int cnt, i;
+	int cnt;
 	wchar_t *p, **lp;
 	ssize_t *lens;
 	ssize_t maxcols = DEFCOLS, coloff;
@@ -347,8 +347,7 @@ static void maketbl(wchar_t **list, int entries, wchar_t *separator, int greedy,
 	for (t = tbl, cnt = 0; cnt < entries; ++cnt, ++t) {
 		for (coloff = 0; coloff < t->cols - 1; ++coloff) {
 			fputws(t->list[coloff], stdout);
-			for (i = lens[coloff] - t->len[coloff]; i > 0; i--)
-				putwchar(' ');
+			wprintf(L"%*s", lens[coloff] - t->len[coloff], "");
 			fputws(colsep, stdout);
 		}
 		if (coloff < t->cols) {
-- 
1.8.3.4

