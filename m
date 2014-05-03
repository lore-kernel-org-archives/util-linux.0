Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f174.google.com ([209.85.192.174]:40905 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbaECRml (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 May 2014 13:42:41 -0400
Received: by mail-pd0-f174.google.com with SMTP id w10so5137457pde.33
        for <util-linux@vger.kernel.org>; Sat, 03 May 2014 10:42:41 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH 6/8] misc-utils/lsblk.c: add sorting support for lsblk command
Date: Sat,  3 May 2014 23:41:26 +0600
Message-Id: <1399138888-7554-6-git-send-email-shakursmullick@gmail.com>
In-Reply-To: <1399138888-7554-1-git-send-email-shakursmullick@gmail.com>
References: <1399138888-7554-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It adds support for sorting in lsblk command. sorting can be done by name(-c) or size(-z). For longoptions use --sort name or --sort size

e.g. lsblk -c
     lsblk -q name
     lsblk --sort size

Signed-off-by: Shakur Shams Mullick <shakursmullick@gmail.com>
---
 misc-utils/lsblk.c | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 2efb2ec..2d9c9c7 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -110,11 +110,13 @@ enum {
 
 /* basic table settings */
 enum {
-	LSBLK_ASCII =		(1 << 0),
-	LSBLK_RAW =		(1 << 1),
-	LSBLK_NOHEADINGS =	(1 << 2),
-	LSBLK_EXPORT =		(1 << 3),
-	LSBLK_TREE =		(1 << 4),
+	LSBLK_ASCII       =	(1 << 0),
+	LSBLK_RAW         =	(1 << 1),
+	LSBLK_NOHEADINGS  =	(1 << 2),
+	LSBLK_EXPORT      =	(1 << 3),
+	LSBLK_TREE        =	(1 << 4),
+	LSBLK_NSORTED  =  (1 << 5),   /* sort by name */
+	LSBLK_SZSORTED  =  (1 << 6),   /* sort by size */
 };
 
 /* column names */
@@ -1355,6 +1357,10 @@ static void __attribute__((__noreturn__)) help(FILE *out)
 	fputs(_(" -i, --ascii          use ascii characters only\n"), out);
 	fputs(_(" -I, --include <list> show only devices with specified major numbers\n"), out);
 	fputs(_(" -l, --list           use list format output\n"), out);
+	fputs(_(" -z,                  show list sorted  by size\n"), out);
+	fputs(_(" -c,                  show list sorted  by name\n"), out);
+	fputs(_(" -q  --sort WORD      sort by WORD: size -z, name -c\n"), out);
+	fputs(_(" 					   e.g. --sort size\n"), out);
 	fputs(_(" -m, --perms          output info about permissions\n"), out);
 	fputs(_(" -n, --noheadings     don't print headings\n"), out);
 	fputs(_(" -o, --output <list>  output columns\n"), out);
@@ -1413,6 +1419,9 @@ int main(int argc, char *argv[])
 		{ "pairs",      0, 0, 'P' },
 		{ "scsi",       0, 0, 'S' },
 		{ "version",    0, 0, 'V' },
+		{ "sort",       1, 0, 'q' },
+		{ NULL,         0, 0, 'z' },
+		{ NULL,         0, 0, 'c' },
 		{ NULL, 0, 0, 0 },
 	};
 
@@ -1432,7 +1441,7 @@ int main(int argc, char *argv[])
 	memset(lsblk, 0, sizeof(*lsblk));
 
 	while((c = getopt_long(argc, argv,
-			       "abdDe:fhlnmo:pPiI:rstVS", longopts, NULL)) != -1) {
+			       "abdDe:fhlnmo:pPiI:rstVSq:zc", longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
 
@@ -1462,6 +1471,26 @@ int main(int argc, char *argv[])
 		case 'l':
 			scols_flags &= ~LSBLK_TREE; /* disable the default */
 			break;
+		case 'q':
+			if(strncasecmp(optarg, "size", 4) == 0)
+			{
+				scols_flags |= LSBLK_SZSORTED;
+				scols_flags &= ~LSBLK_TREE; /* disable the default */
+			}
+			else if(strncasecmp(optarg, "name", 4) == 0)
+			{
+				scols_flags |= LSBLK_NSORTED;
+				scols_flags &= ~LSBLK_TREE; /* disable the default */
+			}
+			break;
+		case 'c':
+			scols_flags |= LSBLK_NSORTED;
+			scols_flags &= ~LSBLK_TREE; /* disable the default */
+			break;
+		case 'z':
+			scols_flags |= LSBLK_SZSORTED;
+			scols_flags &= ~LSBLK_TREE; /* disable the default */
+			break;
 		case 'n':
 			scols_flags |= LSBLK_NOHEADINGS;
 			break;
@@ -1564,6 +1593,8 @@ int main(int argc, char *argv[])
 	scols_table_enable_export(lsblk->table, !!(scols_flags & LSBLK_EXPORT));
 	scols_table_enable_ascii(lsblk->table, !!(scols_flags & LSBLK_ASCII));
 	scols_table_enable_noheadings(lsblk->table, !!(scols_flags & LSBLK_NOHEADINGS));
+	scols_table_enable_namesort(lsblk->table, !!(scols_flags & LSBLK_NSORTED));
+	scols_table_enable_sizesort(lsblk->table, !!(scols_flags & LSBLK_SZSORTED));
 
 	for (i = 0; i < ncolumns; i++) {
 		struct colinfo *ci = get_column_info(i);
-- 
1.8.3.2

