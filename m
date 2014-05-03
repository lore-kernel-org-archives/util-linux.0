Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33184 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbaECRms (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 May 2014 13:42:48 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so7070385pab.13
        for <util-linux@vger.kernel.org>; Sat, 03 May 2014 10:42:48 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH 8/8] disk-utils/partx.c: add sorting support for partx command
Date: Sat,  3 May 2014 23:41:28 +0600
Message-Id: <1399138888-7554-8-git-send-email-shakursmullick@gmail.com>
In-Reply-To: <1399138888-7554-1-git-send-email-shakursmullick@gmail.com>
References: <1399138888-7554-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

usage is similar to that of lsblk

Signed-off-by: Shakur Shams Mullick <shakursmullick@gmail.com>
---
 disk-utils/partx.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/disk-utils/partx.c b/disk-utils/partx.c
index 830af1f..ef7872d 100644
--- a/disk-utils/partx.c
+++ b/disk-utils/partx.c
@@ -41,9 +41,11 @@
 
 /* basic table settings */
 enum {
-	PARTX_RAW =		(1 << 0),
+	PARTX_RAW =		    (1 << 0),
 	PARTX_NOHEADINGS =	(1 << 1),
 	PARTX_EXPORT =		(1 << 2),
+	PARTX_NSORTED =		(1 << 3),
+	PARTX_SZSORTED =	(1 << 4),
 };
 
 /* all the columns (-o option) */
@@ -634,6 +636,8 @@ static int show_parts(blkid_partlist ls, int scols_flags, int lower, int upper)
 	scols_table_enable_raw(table, !!(scols_flags & PARTX_RAW));
 	scols_table_enable_export(table, !!(scols_flags & PARTX_EXPORT));
 	scols_table_enable_noheadings(table, !!(scols_flags & PARTX_NOHEADINGS));
+	scols_table_enable_namesort(table, !!(scols_flags & PARTX_NSORTED));
+	scols_table_enable_sizesort(table, !!(scols_flags & PARTX_SZSORTED));
 
 	for (i = 0; i < ncolumns; i++) {
 		struct colinfo *col = get_column_info(i);
@@ -717,6 +721,10 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -d, --delete         delete specified partitions or all of them\n"), out);
 	fputs(_(" -u, --update         update specified partitions or all of them\n"), out);
 	fputs(_(" -s, --show           list partitions\n\n"), out);
+	fputs(_(" -z,                  show list sorted  by size\n"), out);
+	fputs(_(" -c,                  show list sorted  by name\n"), out);
+	fputs(_(" -q  --sort WORD      sort by WORD: size -z, name -c\n"), out);
+	fputs(_(" 					   e.g. --sort size\n"), out);
 	fputs(_(" -b, --bytes          print SIZE in bytes rather than in human readable format\n"), out);
 	fputs(_(" -g, --noheadings     don't print headings for --show\n"), out);
 	fputs(_(" -n, --nr <n:m>       specify the range of partitions (e.g. --nr 2:4)\n"), out);
@@ -766,6 +774,9 @@ int main(int argc, char **argv)
 		{ "help",	no_argument,       NULL, 'h' },
 		{ "version",    no_argument,       NULL, 'V' },
 		{ "verbose",	no_argument,       NULL, 'v' },
+		{ "sort",       1,             NULL, 'q' },
+		{ NULL,       no_argument,     NULL, 'z' },
+		{ NULL,       no_argument,     NULL, 'c' },
 		{ NULL, 0, NULL, 0 }
 	};
 
@@ -781,7 +792,7 @@ int main(int argc, char **argv)
 	atexit(close_stdout);
 
 	while ((c = getopt_long(argc, argv,
-				"abdglrsuvn:t:o:PhV", long_opts, NULL)) != -1) {
+				"abdglrsuvn:t:o:PhVq:zc", long_opts, NULL)) != -1) {
 
 		err_exclusive_options(c, long_opts, excl, excl_st);
 
@@ -801,6 +812,26 @@ int main(int argc, char **argv)
 		case 'l':
 			what = ACT_LIST;
 			break;
+		case 'q':
+			if(strncasecmp(optarg, "size", 4) == 0)
+			{
+				what = ACT_SHOW;
+				scols_flags |= PARTX_SZSORTED;
+			}
+			else if(strncasecmp(optarg, "name", 4) == 0)
+			{
+				what = ACT_SHOW;
+			    scols_flags |= PARTX_NSORTED;
+			}
+			break;
+		case 'z':
+			what = ACT_SHOW;
+			scols_flags |= PARTX_SZSORTED;
+			break;
+		case 'c':
+			what = ACT_SHOW;
+			scols_flags |= PARTX_NSORTED;
+			break;
 		case 'n':
 			if (parse_range(optarg, &lower, &upper, 0))
 				errx(EXIT_FAILURE, _("failed to parse --nr <M-N> range"));
-- 
1.8.3.2

