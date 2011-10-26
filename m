Return-Path: util-linux-owner@vger.kernel.org
Received: from damascus.uab.es ([158.109.168.135]:15650 "EHLO damascus.uab.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932751Ab1JZLzx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 26 Oct 2011 07:55:53 -0400
Received: from damascus.uab.es ([127.0.0.1])
 by damascus.uab.es (Sun Java System Messaging Server 6.1 HotFix 0.10 (built
 Jan  6 2005)) with ESMTP id <0LTO001KH94GSAA0@damascus.uab.es> for
 util-linux@vger.kernel.org; Wed, 26 Oct 2011 13:55:28 +0200 (CEST)
Received: from aomail.uab.es ([158.109.65.1])
 by damascus.uab.es (Sun Java	System Messaging Server 6.1 HotFix 0.10 (builtJan
 6 2005)) with ESMTP id	<0LTO008IT94GDL40@damascus.uab.es>
 forutil-linux@vger.kernel.org; Wed, 26 Oct 2011 13:55:28 +0200 (CEST)
Date: Wed, 26 Oct 2011 15:58:18 +0200
From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH 2/2] lsblk: remove __NCOLUMNS
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1319637498.3771.12.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

We use ARRAY_SIZE() instead to define the amount of available columns.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 misc-utils/lsblk.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 74a1850..24e0d05 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -88,8 +88,6 @@ enum {
 	COL_DGRAN,
 	COL_DMAX,
 	COL_DZERO,
-
-	__NCOLUMNS
 };
 
 /* column names */
@@ -101,7 +99,7 @@ struct colinfo {
 };
 
 /* columns descriptions */
-static struct colinfo infos[__NCOLUMNS] = {
+static struct colinfo infos[] = {
 	[COL_NAME]   = { "NAME",    0.25, TT_FL_TREE, N_("device name") },
 	[COL_KNAME]  = { "KNAME",   0.3, 0, N_("internal kernel device name") },
 	[COL_MAJMIN] = { "MAJ:MIN", 6, 0, N_("major:minor device number") },
@@ -140,7 +138,9 @@ struct lsblk {
 };
 
 struct lsblk *lsblk;	/* global handler */
-int columns[__NCOLUMNS];/* enabled columns */
+
+#define NCOLS ARRAY_SIZE(infos)
+int columns[NCOLS];/* enabled columns */
 int ncolumns;		/* number of enabled columns */
 
 int excludes[256];
@@ -190,9 +190,9 @@ static int is_maj_excluded(int maj)
 /* array with IDs of enabled columns */
 static int get_column_id(int num)
 {
-	assert(ARRAY_SIZE(columns) == __NCOLUMNS);
+	assert(ARRAY_SIZE(columns) == NCOLS);
 	assert(num < ncolumns);
-	assert(columns[num] < __NCOLUMNS);
+	assert(columns[num] < NCOLS);
 	return columns[num];
 }
 
@@ -205,7 +205,7 @@ static int column_name_to_id(const char *name, size_t namesz)
 {
 	int i;
 
-	for (i = 0; i < __NCOLUMNS; i++) {
+	for (i = 0; i < NCOLS; i++) {
 		const char *cn = infos[i].name;
 
 		if (!strncasecmp(name, cn, namesz) && !*(cn + namesz))
@@ -933,7 +933,7 @@ static void __attribute__((__noreturn__)) help(FILE *out)
 
 	fprintf(out, _("\nAvailable columns:\n"));
 
-	for (i = 0; i < __NCOLUMNS; i++)
+	for (i = 0; i < NCOLS; i++)
 		fprintf(out, " %10s  %s\n", infos[i].name, _(infos[i].help));
 
 	fprintf(out, _("\nFor more information see lsblk(8).\n"));
-- 
1.7.7



