Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f49.google.com ([209.85.220.49]:55797 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbaENFLF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 14 May 2014 01:11:05 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so1184744pab.22
        for <util-linux@vger.kernel.org>; Tue, 13 May 2014 22:11:04 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH v3 4/5] misc-utils/lsblk.c: add sorting support for lsblk command
Date: Wed, 14 May 2014 11:09:59 +0600
Message-Id: <1400044200-9196-4-git-send-email-shakursmullick@gmail.com>
In-Reply-To: <1400044200-9196-1-git-send-email-shakursmullick@gmail.com>
References: <1400044200-9196-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Shakur Shams Mullick <shakursmullick@gmail.com>
---
 misc-utils/lsblk.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 24853dc..7cc03e8 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -117,6 +117,12 @@ enum {
 	LSBLK_TREE =		(1 << 4),
 };
 
+enum {
+	sort_none = -1,
+	sort_name,
+	sort_size
+};
+
 /* column names */
 struct colinfo {
 	const char	*name;		/* header */
@@ -1355,6 +1361,7 @@ static void __attribute__((__noreturn__)) help(FILE *out)
 	fputs(_(" -i, --ascii          use ascii characters only\n"), out);
 	fputs(_(" -I, --include <list> show only devices with specified major numbers\n"), out);
 	fputs(_(" -l, --list           use list format output\n"), out);
+	fputs(_(" -c, --order-by <column> show list sorted  by column property\n"), out);
 	fputs(_(" -m, --perms          output info about permissions\n"), out);
 	fputs(_(" -n, --noheadings     don't print headings\n"), out);
 	fputs(_(" -o, --output <list>  output columns\n"), out);
@@ -1389,7 +1396,9 @@ static void check_sysdevblock(void)
 int main(int argc, char *argv[])
 {
 	struct lsblk _ls;
+	struct libscols_column *cl, *tmp;
 	int scols_flags = LSBLK_TREE;
+	int sort_flags = sort_none;
 	int i, c, status = EXIT_FAILURE;
 	char *outarg = NULL;
 
@@ -1415,6 +1424,7 @@ int main(int argc, char *argv[])
 		{ "pairs",      0, 0, 'P' },
 		{ "scsi",       0, 0, 'S' },
 		{ "version",    0, 0, 'V' },
+		{ "order-by",   1, 0, 'c' },
 		{ NULL, 0, 0, 0 },
 	};
 
@@ -1439,7 +1449,7 @@ int main(int argc, char *argv[])
 	memset(lsblk, 0, sizeof(*lsblk));
 
 	while((c = getopt_long(argc, argv,
-			       "abdDe:fhlnmo:OpPiI:rstVS", longopts, NULL)) != -1) {
+			       "abdDe:fhlnmo:OpPiI:rstVc:S", longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
 
@@ -1469,6 +1479,13 @@ int main(int argc, char *argv[])
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
@@ -1576,6 +1593,7 @@ int main(int argc, char *argv[])
 	scols_table_enable_ascii(lsblk->table, !!(scols_flags & LSBLK_ASCII));
 	scols_table_enable_noheadings(lsblk->table, !!(scols_flags & LSBLK_NOHEADINGS));
 
+	cl = tmp = NULL;
 	for (i = 0; i < ncolumns; i++) {
 		struct colinfo *ci = get_column_info(i);
 		int fl = ci->flags;
@@ -1583,16 +1601,34 @@ int main(int argc, char *argv[])
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
+		
+	if((sort_flags == sort_name || sort_flags == sort_size) && !cl)
+		sort_flags = sort_none; /* sorting column not found. Do not sort */
+	
+	if(sort_flags != sort_none)
+	{
+		if(sort_flags == sort_name)
+			scols_column_set_sortcmp(cl, scols_cmpstr_cells, NULL);
+			
+		else if(sort_flags == sort_size)
+			scols_column_set_sortcmp(cl, scols_cmpnum_cells, NULL);
+			
+		scols_sort_table(lsblk->table, cl);
+	}
 
 	scols_print_table(lsblk->table);
 
-- 
1.8.3.2

