Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:57030 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634Ab2JHHIt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Oct 2012 03:08:49 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2368146wey.19
        for <util-linux@vger.kernel.org>; Mon, 08 Oct 2012 00:08:49 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/14] column: add --output-separator option
Date: Mon,  8 Oct 2012 08:08:08 +0100
Message-Id: <1349680100-18120-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
References: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The --output-separator option will allow user to define table column
separator.  This will allow for example to write back same delimeter as
which was used as input separator, for example

column -t -s : -o : /etc/passwd

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/column.1 |  2 ++
 text-utils/column.c | 20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/text-utils/column.1 b/text-utils/column.1
index 993f737..3727048 100644
--- a/text-utils/column.1
+++ b/text-utils/column.1
@@ -54,6 +54,8 @@ Columns are delimited with whitespace, by default, or with the characters
 supplied using the separator. Table output is useful for pretty-printing.
 .IP "\fB\-s, \-\-separator\fP \fIseparators\fP"
 Specify possible table delimiters (default is whitespace).
+.IP "\fB\-o, \-\-output-separator\fP \fIseparators\fP"
+Specify table output delimiter (default is two whitespaces).
 .IP "\fB\-x, \-\-fillrows\fP"
 Fill columns before filling rows.
 .IP "\fB\-h, \-\-help\fP"
diff --git a/text-utils/column.c b/text-utils/column.c
index d230979..33bc28d 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -76,7 +76,7 @@ static int input(FILE *fp, int *maxlength, wchar_t ***list, int *entries);
 static void c_columnate(int maxlength, long termwidth, wchar_t **list, int entries);
 static void r_columnate(int maxlength, long termwidth, wchar_t **list, int entries);
 static wchar_t *local_wcstok(wchar_t *p, const wchar_t *separator, int greedy, wchar_t **wcstok_state);
-static void maketbl(wchar_t **list, int entries, wchar_t *separator, int greedy);
+static void maketbl(wchar_t **list, int entries, wchar_t *separator, int greedy, wchar_t *colsep);
 static void print(wchar_t **list, int entries);
 
 typedef struct _tbl {
@@ -98,6 +98,8 @@ static void __attribute__((__noreturn__)) usage(int rc)
 	" -c, --columns <width>    width of output in number of characters\n"
 	" -t, --table              create a table\n"
 	" -s, --separator <string> possible table delimiters\n"
+	" -o, --output-separator <string>\n"
+	"                          table output column separator, default is two spaces\n"
 	" -x, --fillrows           fill rows before columns\n"));
 
 	fprintf(out, _("\nFor more information see column(1).\n"));
@@ -114,6 +116,7 @@ int main(int argc, char **argv)
 	int maxlength = 0;		/* longest record */
 	wchar_t **list = NULL;		/* array of pointers to records */
 	int greedy = 1;
+	wchar_t *colsep;		/* table column output separator */
 
 	/* field separator for table option */
 	wchar_t default_separator[] = { '\t', ' ', 0 };
@@ -126,6 +129,7 @@ int main(int argc, char **argv)
 		{ "columns",	1, 0, 'c' },
 		{ "table",	0, 0, 't' },
 		{ "separator",	1, 0, 's' },
+		{ "output-separator", 1, 0, 'o' },
 		{ "fillrows",	0, 0, 'x' },
 		{ NULL,		0, 0, 0 },
 	};
@@ -138,8 +142,9 @@ int main(int argc, char **argv)
 	termwidth = get_terminal_width();
 	if (termwidth <= 0)
 		termwidth = 80;
+	colsep = mbs_to_wcs("  ");
 
-	while ((ch = getopt_long(argc, argv, "hVc:s:tx", longopts, NULL)) != -1)
+	while ((ch = getopt_long(argc, argv, "hVc:s:txo:", longopts, NULL)) != -1)
 		switch(ch) {
 		case 'h':
 			usage(EXIT_SUCCESS);
@@ -155,6 +160,10 @@ int main(int argc, char **argv)
 			separator = mbs_to_wcs(optarg);
 			greedy = 0;
 			break;
+		case 'o':
+			free(colsep);
+			colsep = mbs_to_wcs(optarg);
+			break;
 		case 't':
 			tflag = 1;
 			break;
@@ -186,7 +195,7 @@ int main(int argc, char **argv)
 		exit(eval);
 
 	if (tflag)
-		maketbl(list, entries, separator, greedy);
+		maketbl(list, entries, separator, greedy, colsep);
 	else if (maxlength >= termwidth)
 		print(list, entries);
 	else if (xflag)
@@ -297,7 +306,7 @@ wchar_t *local_wcstok(wchar_t * p, const wchar_t * separator, int greedy,
 	return result;
 }
 
-static void maketbl(wchar_t **list, int entries, wchar_t *separator, int greedy)
+static void maketbl(wchar_t **list, int entries, wchar_t *separator, int greedy, wchar_t *colsep)
 {
 	TBL *t;
 	int cnt, i;
@@ -339,8 +348,9 @@ static void maketbl(wchar_t **list, int entries, wchar_t *separator, int greedy)
 	for (t = tbl, cnt = 0; cnt < entries; ++cnt, ++t) {
 		for (coloff = 0; coloff < t->cols - 1; ++coloff) {
 			fputws(t->list[coloff], stdout);
-			for (i = lens[coloff] - t->len[coloff] + 2; i > 0; i--)
+			for (i = lens[coloff] - t->len[coloff]; i > 0; i--)
 				putwchar(' ');
+			fputws(colsep, stdout);
 		}
 		if (coloff < t->cols) {
 			fputws(t->list[coloff], stdout);
-- 
1.7.12.2

