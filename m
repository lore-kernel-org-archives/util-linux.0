Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:8718 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777AbaD0FSy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 27 Apr 2014 01:18:54 -0400
From: Masatake YAMATO <yamato@redhat.com>
To: util-linux@vger.kernel.org
Cc: yamato@redhat.com
Subject: [PATCH] lsblk: add -O option to show all available columns
Date: Sun, 27 Apr 2014 14:18:41 +0900
Message-Id: <1398575921-7592-1-git-send-email-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Simple command line for gathering information as many
as possible is useful when understanding a system,
especially when trouble shooting.

This patch introduces -O option which enables all
available columns.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 misc-utils/lsblk.8 |  3 +++
 misc-utils/lsblk.c | 27 +++++++++++++++++++--------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index ea7e7be..e87689b 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -83,6 +83,9 @@ to get a list of all supported columns.
 The default list of columns may be extended if \fIlist\fP is
 specified in the format \fI+list\fP (e.g. \fBlsblk -o +UUID\fP).
 .TP
+.BR \-O , " \-\-output-all "
+Output all available columns.
+.TP
 .BR \-P , " \-\-pairs"
 Produce output in the form of key="value" pairs.
 All potentially unsafe characters are hex-escaped (\\x<code>).
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 2efb2ec..ea4dc60 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -115,6 +115,7 @@ enum {
 	LSBLK_NOHEADINGS =	(1 << 2),
 	LSBLK_EXPORT =		(1 << 3),
 	LSBLK_TREE =		(1 << 4),
+	LSBLK_ALL_COL =		(1 << 5),
 };
 
 /* column names */
@@ -1358,6 +1359,7 @@ static void __attribute__((__noreturn__)) help(FILE *out)
 	fputs(_(" -m, --perms          output info about permissions\n"), out);
 	fputs(_(" -n, --noheadings     don't print headings\n"), out);
 	fputs(_(" -o, --output <list>  output columns\n"), out);
+	fputs(_(" -O, --output-all     output all columns\n"), out);
 	fputs(_(" -p, --paths          print complete device path\n"), out);
 	fputs(_(" -P, --pairs          use key=\"value\" output format\n"), out);
 	fputs(_(" -r, --raw            use raw output format\n"), out);
@@ -1399,6 +1401,7 @@ int main(int argc, char *argv[])
 		{ "discard",    0, 0, 'D' },
 		{ "help",	0, 0, 'h' },
 		{ "output",     1, 0, 'o' },
+		{ "output-all", 0, 0, 'O' },
 		{ "perms",      0, 0, 'm' },
 		{ "noheadings",	0, 0, 'n' },
 		{ "list",       0, 0, 'l' },
@@ -1432,7 +1435,7 @@ int main(int argc, char *argv[])
 	memset(lsblk, 0, sizeof(*lsblk));
 
 	while((c = getopt_long(argc, argv,
-			       "abdDe:fhlnmo:pPiI:rstVS", longopts, NULL)) != -1) {
+			       "abdDe:fhlnmo:OpPiI:rstVS", longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
 
@@ -1468,6 +1471,9 @@ int main(int argc, char *argv[])
 		case 'o':
 			outarg = optarg;
 			break;
+		case 'O':
+			scols_flags |= LSBLK_ALL_COL;
+			break;
 		case 'p':
 			lsblk->paths = 1;
 			break;
@@ -1537,13 +1543,18 @@ int main(int argc, char *argv[])
 	check_sysdevblock();
 
 	if (!ncolumns) {
-		columns[ncolumns++] = COL_NAME;
-		columns[ncolumns++] = COL_MAJMIN;
-		columns[ncolumns++] = COL_RM;
-		columns[ncolumns++] = COL_SIZE;
-		columns[ncolumns++] = COL_RO;
-		columns[ncolumns++] = COL_TYPE;
-		columns[ncolumns++] = COL_TARGET;
+		if ((scols_flags & LSBLK_ALL_COL)) {
+			for ( ; ncolumns < NCOLS; ncolumns++)
+				columns[ncolumns] = ncolumns;
+		} else {
+			columns[ncolumns++] = COL_NAME;
+			columns[ncolumns++] = COL_MAJMIN;
+			columns[ncolumns++] = COL_RM;
+			columns[ncolumns++] = COL_SIZE;
+			columns[ncolumns++] = COL_RO;
+			columns[ncolumns++] = COL_TYPE;
+			columns[ncolumns++] = COL_TARGET;
+		}
 	}
 
 	if (outarg && string_add_to_idarray(outarg, columns, ARRAY_SIZE(columns),
-- 
1.9.0

