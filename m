Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:51004 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751442AbbARUud (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 18 Jan 2015 15:50:33 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] docs: fix two "maybe be" duplications in program comments
Date: Sun, 18 Jan 2015 21:50:27 +0100
Message-Id: <1421614227-5938-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also improve the grammar of the comments and some neighbours.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 lib/path.c                     |    7 ++-----
 libsmartcols/src/table_print.c |   30 ++++++++++++++----------------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/lib/path.c b/lib/path.c
index 42d321c..316af47 100644
--- a/lib/path.c
+++ b/lib/path.c
@@ -1,9 +1,6 @@
 /*
- * Simple functions to access files, paths maybe be globally prefixed by a
- * global prefix to read data from alternative destination (e.g. /proc dump for
- * regression tests).
- *
- * Taken from lscpu.c
+ * Simple functions to access files. Paths can be globally prefixed to read
+ * data from an alternative source (e.g. a /proc dump for regression tests).
  *
  * Copyright (C) 2008 Cai Qian <qcai@redhat.com>
  * Copyright (C) 2008-2012 Karel Zak <kzak@redhat.com>
diff --git a/libsmartcols/src/table_print.c b/libsmartcols/src/table_print.c
index 647692c..f08560c 100644
--- a/libsmartcols/src/table_print.c
+++ b/libsmartcols/src/table_print.c
@@ -219,10 +219,10 @@ static void print_empty_cell(struct libscols_table *tb,
 		fputc(' ', tb->out);
 }
 
-/* fill-in all line with padding (or tree asci-art)
+/* Fill the start of a line with padding (or with tree ascii-art).
  *
- * This is necessary after long non-truncated colum where next column
- * is printed in next line. For example (see 'DDD'):
+ * This is necessary after a long non-truncated column, as this requires the
+ * next column to be printed on the next line. For example (see 'DDD'):
  *
  * aaa bbb ccc ddd eee
  * AAA BBB CCCCCCC
@@ -401,8 +401,8 @@ static int cell_to_buffer(struct libscols_table *tb,
 }
 
 /*
- * Prints data, data maybe be printed in more formats (raw, NAME=xxx pairs) and
- * control and non-printable chars maybe encoded in \x?? hex encoding.
+ * Prints data. Data can be printed in more formats (raw, NAME=xxx pairs), and
+ * control and non-printable characters can be encoded in the \x?? encoding.
  */
 static int print_line(struct libscols_table *tb,
 		      struct libscols_line *ln,
@@ -445,8 +445,7 @@ static int print_header(struct libscols_table *tb, struct libscols_buffer *buf)
 
 	DBG(TAB, ul_debugobj(tb, "printing header"));
 
-	/* set width according to the size of data
-	 */
+	/* set the width according to the size of the data */
 	scols_reset_iter(&itr, SCOLS_ITER_FORWARD);
 	while (rc == 0 && scols_table_next_column(tb, &itr, &cl) == 0) {
 		rc = buffer_set_data(buf, scols_cell_get_data(&cl->header));
@@ -551,11 +550,11 @@ static void dbg_columns(struct libscols_table *tb)
 /*
  * This function counts column width.
  *
- * For the SCOLS_FL_NOEXTREMES columns is possible to call this function two
- * times.  The first pass counts width and average width. If the column
- * contains too large fields (width greater than 2 * average) then the column
- * is marked as "extreme". In the second pass all extreme fields are ignored
- * and column width is counted from non-extreme fields only.
+ * For the SCOLS_FL_NOEXTREMES columns it is possible to call this function
+ * two times. The first pass counts the width and average width. If the column
+ * contains fields that are too large (a width greater than 2 * average) then
+ * the column is marked as "extreme". In the second pass all extreme fields
+ * are ignored and the column width is counted from non-extreme fields only.
  */
 static int count_column_width(struct libscols_table *tb,
 			      struct libscols_column *cl,
@@ -653,8 +652,7 @@ static int recount_widths(struct libscols_table *tb, struct libscols_buffer *buf
 	if (!tb->is_term)
 		return 0;
 
-	/* reduce columns with extreme fields
-	 */
+	/* reduce columns with extreme fields */
 	if (width > tb->termwidth && extremes) {
 		DBG(TAB, ul_debugobj(tb, "   reduce width (extreme columns)"));
 
@@ -710,7 +708,7 @@ static int recount_widths(struct libscols_table *tb, struct libscols_buffer *buf
 		if (width < tb->termwidth && scols_table_is_maxout(tb)) {
 			DBG(TAB, ul_debugobj(tb, "   enlarge width (max-out)"));
 
-			/* try enlarge all columns */
+			/* try enlarging all columns */
 			while (width < tb->termwidth) {
 				scols_reset_iter(&itr, SCOLS_ITER_FORWARD);
 				while (scols_table_next_column(tb, &itr, &cl) == 0) {
@@ -735,7 +733,7 @@ static int recount_widths(struct libscols_table *tb, struct libscols_buffer *buf
 	}
 
 	/* bad, we have to reduce output width, this is done in two steps:
-	 * 1/ reduce columns with a relative width and with truncate flag
+	 * 1) reduce columns with a relative width and with truncate flag
 	 * 2) reduce columns with a relative width without truncate flag
 	 */
 	trunc_only = 1;
-- 
1.7.0.4

