Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f50.google.com ([209.85.220.50]:59659 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896AbaEKIVi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 04:21:38 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so6182629pad.9
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 01:21:37 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH v2 8/8] misc-utils/lsblk.c: adds sorting support for lsblk
Date: Sun, 11 May 2014 14:20:38 +0600
Message-Id: <1399796438-5495-8-git-send-email-shakursmullick@gmail.com>
In-Reply-To: <1399796438-5495-1-git-send-email-shakursmullick@gmail.com>
References: <1399796438-5495-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

lsblk --order-by <column>
---
 misc-utils/lsblk.c | 55 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 2efb2ec..9fa54e7 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -61,6 +61,7 @@
 #include "closestream.h"
 #include "mangle.h"
 #include "optutils.h"
+#include "list.h"
 
 /* column IDs */
 enum {
@@ -110,18 +111,24 @@ enum {
 
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
+};
+
+enum {
+	sort_none = -1,
+	sort_name,
+	sort_size
 };
 
 /* column names */
 struct colinfo {
 	const char	*name;		/* header */
 	double		whint;		/* width hint (N < 1 is in percent of termwidth) */
-	int		flags;		/* SCOLS_FL_* */
+	int		flags;		/* SCOLS_FL_* */ 
 	const char      *help;
 };
 
@@ -1355,6 +1362,7 @@ static void __attribute__((__noreturn__)) help(FILE *out)
 	fputs(_(" -i, --ascii          use ascii characters only\n"), out);
 	fputs(_(" -I, --include <list> show only devices with specified major numbers\n"), out);
 	fputs(_(" -l, --list           use list format output\n"), out);
+	fputs(_(" -c, --order-by <column> show list sorted  by name\n"), out);
 	fputs(_(" -m, --perms          output info about permissions\n"), out);
 	fputs(_(" -n, --noheadings     don't print headings\n"), out);
 	fputs(_(" -o, --output <list>  output columns\n"), out);
@@ -1388,21 +1396,23 @@ static void check_sysdevblock(void)
 int main(int argc, char *argv[])
 {
 	struct lsblk _ls;
+	struct libscols_column *cl, *tmp;
 	int scols_flags = LSBLK_TREE;
+	int sort_flags = sort_none;
 	int i, c, status = EXIT_FAILURE;
 	char *outarg = NULL;
 
 	static const struct option longopts[] = {
-		{ "all",	0, 0, 'a' },
+		{ "all",	    0, 0, 'a' },
 		{ "bytes",      0, 0, 'b' },
 		{ "nodeps",     0, 0, 'd' },
 		{ "discard",    0, 0, 'D' },
-		{ "help",	0, 0, 'h' },
+		{ "help",	    0, 0, 'h' },
 		{ "output",     1, 0, 'o' },
 		{ "perms",      0, 0, 'm' },
 		{ "noheadings",	0, 0, 'n' },
 		{ "list",       0, 0, 'l' },
-		{ "ascii",	0, 0, 'i' },
+		{ "ascii",	    0, 0, 'i' },
 		{ "raw",        0, 0, 'r' },
 		{ "inverse",	0, 0, 's' },
 		{ "fs",         0, 0, 'f' },
@@ -1413,6 +1423,7 @@ int main(int argc, char *argv[])
 		{ "pairs",      0, 0, 'P' },
 		{ "scsi",       0, 0, 'S' },
 		{ "version",    0, 0, 'V' },
+		{ "order-by",   1, 0, 'c' },
 		{ NULL, 0, 0, 0 },
 	};
 
@@ -1432,7 +1443,7 @@ int main(int argc, char *argv[])
 	memset(lsblk, 0, sizeof(*lsblk));
 
 	while((c = getopt_long(argc, argv,
-			       "abdDe:fhlnmo:pPiI:rstVS", longopts, NULL)) != -1) {
+			       "abdDe:fhlnmo:pPiI:rstVc:S", longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
 
@@ -1462,6 +1473,13 @@ int main(int argc, char *argv[])
 		case 'l':
 			scols_flags &= ~LSBLK_TREE; /* disable the default */
 			break;
+		case 'c':
+			if(strncasecmp(optarg, "size", 4) == 0)
+				sort_flags = sort_size;				
+			else if(strncasecmp(optarg, "name", 4) == 0)
+				sort_flags = sort_name;
+			scols_flags &= ~LSBLK_TREE; /* disable the default */
+			break;
 		case 'n':
 			scols_flags |= LSBLK_NOHEADINGS;
 			break;
@@ -1565,6 +1583,7 @@ int main(int argc, char *argv[])
 	scols_table_enable_ascii(lsblk->table, !!(scols_flags & LSBLK_ASCII));
 	scols_table_enable_noheadings(lsblk->table, !!(scols_flags & LSBLK_NOHEADINGS));
 
+	cl = tmp = NULL;
 	for (i = 0; i < ncolumns; i++) {
 		struct colinfo *ci = get_column_info(i);
 		int fl = ci->flags;
@@ -1572,17 +1591,29 @@ int main(int argc, char *argv[])
 		if (!(scols_flags & LSBLK_TREE) && get_column_id(i) == COL_NAME)
 			fl &= ~SCOLS_FL_TREE;
 
-		if (!scols_table_new_column(lsblk->table, ci->name, ci->whint, fl)) {
+		if (!(tmp = scols_table_new_column(lsblk->table, ci->name, ci->whint, fl))) {
 			warn(_("failed to initialize output column"));
 			goto leave;
 		}
+		if(((sort_flags == sort_name) && get_column_id(i) == COL_NAME) ||
+			((sort_flags == sort_size) && get_column_id(i) == COL_SIZE)){
+			cl = tmp;
+		}
 	}
 
 	if (optind == argc)
 		status = iterate_block_devices();
 	else while (optind < argc)
 		status = process_one_device(argv[optind++]);
-
+	
+	
+	if(sort_flags == sort_name)
+		scols_column_set_sortcmp(cl, scols_cmpstr_cells, NULL);
+		
+	else if(sort_flags == sort_size)
+		scols_column_set_sortcmp(cl, scols_cmpnum_cells, NULL);
+		
+	scols_table_set_key_column(lsblk->table, cl);
 	scols_print_table(lsblk->table);
 
 leave:
-- 
1.8.3.2

