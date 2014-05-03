Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f44.google.com ([209.85.220.44]:42412 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbaECRmp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 May 2014 13:42:45 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so1967111pab.3
        for <util-linux@vger.kernel.org>; Sat, 03 May 2014 10:42:44 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH 7/8] misc-utils/lslocks.c: add sorting support for lslocks command
Date: Sat,  3 May 2014 23:41:27 +0600
Message-Id: <1399138888-7554-7-git-send-email-shakursmullick@gmail.com>
In-Reply-To: <1399138888-7554-1-git-send-email-shakursmullick@gmail.com>
References: <1399138888-7554-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

usage is similar to that of lsblk.

Signed-off-by: Shakur Shams Mullick <shakursmullick@gmail.com>
---
 misc-utils/lslocks.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/misc-utils/lslocks.c b/misc-utils/lslocks.c
index 1495bd4..0d6aa16 100644
--- a/misc-utils/lslocks.c
+++ b/misc-utils/lslocks.c
@@ -89,6 +89,8 @@ static struct libmnt_table *tab;		/* /proc/self/mountinfo */
 /* basic output flags */
 static int no_headings;
 static int raw;
+static int nsort;
+static int szsort;
 
 struct lock {
 	struct list_head locks;
@@ -462,6 +464,8 @@ static int show_locks(struct list_head *locks)
 	}
 	scols_table_enable_raw(table, raw);
 	scols_table_enable_noheadings(table, no_headings);
+	scols_table_enable_namesort(table, nsort);
+	scols_table_enable_sizesort(table, szsort);
 
 	for (i = 0; i < ncolumns; i++) {
 		struct colinfo *col = get_column_info(i);
@@ -511,6 +515,10 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 		" -n, --noheadings       don't print headings\n"
 		" -r, --raw              use the raw output format\n"
 		" -u, --notruncate       don't truncate text in columns\n"
+		" -z,                    show list sorted  by size\n"
+	    " -c,                    show list sorted  by name\n"
+	    " -q  --sort WORD        sort by WORD: size -z, name -c\n"
+	    " 					     e.g. --sort size\n"
 		" -h, --help             display this help and exit\n"
 		" -V, --version          output version information and exit\n"), out);
 
@@ -534,6 +542,9 @@ int main(int argc, char *argv[])
 		{ "help",	no_argument,       NULL, 'h' },
 		{ "output",     required_argument, NULL, 'o' },
 		{ "notruncate", no_argument,       NULL, 'u' },
+		{ "sort",       1,                 NULL, 'q' },
+		{ NULL,         no_argument,       NULL, 'z' },
+		{ NULL,         no_argument,       NULL, 'c' },		
 		{ "version",    no_argument,       NULL, 'V' },
 		{ "noheadings", no_argument,       NULL, 'n' },
 		{ "raw",        no_argument,       NULL, 'r' },
@@ -546,7 +557,7 @@ int main(int argc, char *argv[])
 	atexit(close_stdout);
 
 	while ((c = getopt_long(argc, argv,
-				"p:o:nruhV", long_opts, NULL)) != -1) {
+				"p:o:nruhVq:zc", long_opts, NULL)) != -1) {
 
 		switch(c) {
 		case 'p':
@@ -566,6 +577,18 @@ int main(int argc, char *argv[])
 		case 'r':
 			raw = 1;
 			break;
+		case 'q':
+			if(strncasecmp(optarg, "size", 4) == 0)
+				szsort = 1;				
+			else if(strncasecmp(optarg, "name", 4) == 0)
+				nsort = 1;			
+			break;			
+		case 'c':
+			nsort = 1;
+			break;
+		case 'z':
+			szsort = 1;
+			break;
 		case 'u':
 			disable_columns_truncate();
 			break;
-- 
1.8.3.2

