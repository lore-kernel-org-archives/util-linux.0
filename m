Return-Path: util-linux-owner@vger.kernel.org
Received: from damascus.uab.es ([158.109.168.135]:15458 "EHLO damascus.uab.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932751Ab1JZLzO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 26 Oct 2011 07:55:14 -0400
Received: from damascus.uab.es ([127.0.0.1])
 by damascus.uab.es (Sun Java System Messaging Server 6.1 HotFix 0.10 (built
 Jan  6 2005)) with ESMTP id <0LTO001TB93CSVA0@damascus.uab.es> for
 util-linux@vger.kernel.org; Wed, 26 Oct 2011 13:54:49 +0200 (CEST)
Received: from aomail.uab.es ([158.109.65.1])
 by damascus.uab.es (Sun Java	System Messaging Server 6.1 HotFix 0.10 (builtJan
 6 2005)) with ESMTP id	<0LTO008HD93CDL40@damascus.uab.es>
 forutil-linux@vger.kernel.org; Wed, 26 Oct 2011 13:54:48 +0200 (CEST)
Date: Wed, 26 Oct 2011 15:57:38 +0200
From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH 1/2] partx: remove __NCOLUMNS
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1319637458.3771.11.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

We use ARRAY_SIZE() instead to define the amount of available columns.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 partx/partx.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/partx/partx.c b/partx/partx.c
index bf18a4e..b12eebc 100644
--- a/partx/partx.c
+++ b/partx/partx.c
@@ -49,7 +49,6 @@ enum {
 	COL_TYPE,
 	COL_FLAGS,
 	COL_SCHEME,
-	__NCOLUMNS
 };
 
 enum {
@@ -72,7 +71,7 @@ struct colinfo {
 };
 
 /* columns descriptions */
-struct colinfo infos[__NCOLUMNS] = {
+struct colinfo infos[] = {
 	[COL_PARTNO]   = { "NR",    0.25, TT_FL_RIGHT, N_("partition number") },
 	[COL_START]    = { "START",   0.30, TT_FL_RIGHT, N_("start of the partition in sectors") },
 	[COL_END]      = { "END",     0.30, TT_FL_RIGHT, N_("end of the partition in sectors") },
@@ -84,8 +83,11 @@ struct colinfo infos[__NCOLUMNS] = {
 	[COL_FLAGS]    = { "FLAGS",   0.1, TT_FL_TRUNC, N_("partition flags")},
 	[COL_TYPE]     = { "TYPE",    1, TT_FL_RIGHT, N_("partition type hex or uuid")},
 };
+
+#define NCOLS ARRAY_SIZE(infos)
+
 /* array with IDs of enabled columns */
-static int columns[__NCOLUMNS], ncolumns;
+static int columns[NCOLS], ncolumns;
 
 static int verbose;
 static int partx_flags;
@@ -137,9 +139,9 @@ static void assoc_loopdev(const char *fname)
 
 static inline int get_column_id(int num)
 {
-	assert(ARRAY_SIZE(columns) == __NCOLUMNS);
+	assert(ARRAY_SIZE(columns) == NCOLS);
 	assert(num < ncolumns);
-	assert(columns[num] < __NCOLUMNS);
+	assert(columns[num] < NCOLS);
 	return columns[num];
 }
 
@@ -154,7 +156,7 @@ static int column_name_to_id(const char *name, size_t namesz)
 
 	assert(name);
 
-	for (i = 0; i < __NCOLUMNS; i++) {
+	for (i = 0; i < NCOLS; i++) {
 		const char *cn = infos[i].name;
 
 		if (!strncasecmp(name, cn, namesz) && !*(cn + namesz))
@@ -624,7 +626,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 
 	fputs(_("\nAvailable columns (for --show, --raw or --pairs):\n"), out);
 
-	for (i = 0; i < __NCOLUMNS; i++)
+	for (i = 0; i < NCOLS; i++)
 		fprintf(out, " %10s  %s\n", infos[i].name, _(infos[i].help));
 
 	fprintf(out, _("\nFor more information see partx(8).\n"));
-- 
1.7.7



