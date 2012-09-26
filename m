Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:59381 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033Ab2IZUpp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 26 Sep 2012 16:45:45 -0400
Received: by weyt9 with SMTP id t9so231386wey.19
        for <util-linux@vger.kernel.org>; Wed, 26 Sep 2012 13:45:44 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] column: make defined separator to be non-greedy
Date: Wed, 26 Sep 2012 21:45:36 +0100
Message-Id: <1348692336-21301-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch changes interpretation of subsequent delimeter interpretation.
Earlier version merged columns that had null string as content together,
which lead to output as visualized below.

$ printf "a:b:c\n1::3\n" | column  -t -s ':'
a  b  c
1  3

The number 3 has wrong column, which this patch takes care of, and alters
the output following way.

$ printf "a:b:c\n1::3\n" | column  -t -s ':'
a  b  c
1     3

This patch does not alter the default case, e.g., subsequent white spaces
are understood as separator of the same field, and the beginning of line
white spaces are being ignored together.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/column.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/text-utils/column.c b/text-utils/column.c
index 61668fd..7eea66a 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -75,7 +75,8 @@ static char *mtsafe_strtok(char *, const char *, char **);
 static int input(FILE *fp, int *maxlength, wchar_t ***list, int *entries);
 static void c_columnate(int maxlength, long termwidth, wchar_t **list, int entries);
 static void r_columnate(int maxlength, long termwidth, wchar_t **list, int entries);
-static void maketbl(wchar_t **list, int entries, wchar_t *separator);
+static wchar_t *local_wcstok(wchar_t *p, const wchar_t *separator, int greedy, wchar_t **wcstok_state);
+static void maketbl(wchar_t **list, int entries, wchar_t *separator, int greedy);
 static void print(wchar_t **list, int entries);
 
 typedef struct _tbl {
@@ -112,6 +113,7 @@ int main(int argc, char **argv)
 	unsigned int eval = 0;		/* exit value */
 	int maxlength = 0;		/* longest record */
 	wchar_t **list = NULL;		/* array of pointers to records */
+	int greedy = 1;
 
 	/* field separator for table option */
 	wchar_t default_separator[] = { '\t', ' ', 0 };
@@ -151,6 +153,7 @@ int main(int argc, char **argv)
 			break;
 		case 's':
 			separator = mbs_to_wcs(optarg);
+			greedy = 0;
 			break;
 		case 't':
 			tflag = 1;
@@ -183,7 +186,7 @@ int main(int argc, char **argv)
 		exit(eval);
 
 	if (tflag)
-		maketbl(list, entries, separator);
+		maketbl(list, entries, separator, greedy);
 	else if (maxlength >= termwidth)
 		print(list, entries);
 	else if (xflag)
@@ -270,7 +273,31 @@ static void print(wchar_t **list, int entries)
 	}
 }
 
-static void maketbl(wchar_t **list, int entries, wchar_t *separator)
+wchar_t *local_wcstok(wchar_t * p, const wchar_t * separator, int greedy,
+		      wchar_t ** wcstok_state)
+{
+	wchar_t *result;
+	if (greedy)
+		return wcstok(p, separator, wcstok_state);
+
+	if (p == NULL) {
+		if (*wcstok_state == NULL)
+			return NULL;
+		else
+			p = *wcstok_state;
+	}
+	result = p;
+	p = wcspbrk(result, separator);
+	if (p == NULL)
+		*wcstok_state = NULL;
+	else {
+		*p = '\0';
+		*wcstok_state = p + 1;
+	}
+	return result;
+}
+
+static void maketbl(wchar_t **list, int entries, wchar_t *separator, int greedy)
 {
 	TBL *t;
 	int cnt, i;
@@ -279,7 +306,7 @@ static void maketbl(wchar_t **list, int entries, wchar_t *separator)
 	ssize_t maxcols = DEFCOLS, coloff;
 	TBL *tbl;
 	wchar_t **cols;
-	wchar_t *wcstok_state;
+	wchar_t *wcstok_state = NULL;
 
 	t = tbl = xcalloc(entries, sizeof(TBL));
 	cols = xcalloc(maxcols, sizeof(wchar_t *));
@@ -288,7 +315,7 @@ static void maketbl(wchar_t **list, int entries, wchar_t *separator)
 	for (lp = list, cnt = 0; cnt < entries; ++cnt, ++lp, ++t) {
 		coloff = 0;
 		p = *lp;
-		while ((cols[coloff] = wcstok(p, separator, &wcstok_state)) != NULL) {
+		while ((cols[coloff] = local_wcstok(p, separator, greedy, &wcstok_state)) != NULL) {
 			if (++coloff == maxcols) {
 				maxcols += DEFCOLS;
 				cols = xrealloc(cols, maxcols * sizeof(wchar_t *));
-- 
1.7.12.1

