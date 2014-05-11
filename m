Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f179.google.com ([209.85.192.179]:62998 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbaEKIVJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 04:21:09 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so5354612pdj.38
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 01:21:09 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH v2 1/8] libsmartcols/src/libsmartcols.h.in: add library functions
Date: Sun, 11 May 2014 14:20:31 +0600
Message-Id: <1399796438-5495-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 libsmartcols/src/libsmartcols.h.in | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/libsmartcols/src/libsmartcols.h.in b/libsmartcols/src/libsmartcols.h.in
index 9468226..c2adc34 100644
--- a/libsmartcols/src/libsmartcols.h.in
+++ b/libsmartcols/src/libsmartcols.h.in
@@ -83,6 +83,7 @@ enum {
 	SCOLS_FL_RIGHT	     = (1 << 2),   /* align to the right */
 	SCOLS_FL_STRICTWIDTH = (1 << 3),   /* don't reduce width if column is empty */
 	SCOLS_FL_NOEXTREMES  = (1 << 4),   /* ignore extreme fields when count column width*/
+
 };
 
 extern struct libscols_iter *scols_new_iter(int direction);
@@ -115,6 +116,8 @@ extern int scols_cell_refer_data(struct libscols_cell *ce, char *str);
 extern const char *scols_cell_get_data(const struct libscols_cell *ce);
 extern int scols_cell_set_color(struct libscols_cell *ce, const char *color);
 extern const char *scols_cell_get_color(const struct libscols_cell *ce);
+extern int scols_cmpstr_cells(struct libscols_cell *a, struct libscols_cell *b, void *data);
+extern int scols_cmpnum_cells(struct libscols_cell *a, struct libscols_cell *b, void *data);
 
 /* column.c */
 extern int scols_column_is_tree(struct libscols_column *cl);
@@ -134,7 +137,10 @@ extern double scols_column_get_whint(struct libscols_column *cl);
 extern struct libscols_cell *scols_column_get_header(struct libscols_column *cl);
 extern int scols_column_set_color(struct libscols_column *cl, const char *color);
 extern const char *scols_column_get_color(struct libscols_column *cl);
+extern int scols_column_set_sortcmp(struct libscols_column *cl, 
+	int (*compar)(struct libscols_cell *a, struct libscols_cell *b, void *), void *data);
 
+ 
 /* line.c */
 extern struct libscols_line *scols_new_line(void);
 extern void scols_ref_line(struct libscols_line *ln);
@@ -157,7 +163,7 @@ extern int scols_line_set_data(struct libscols_line *ln, size_t n, const char *d
 extern int scols_line_refer_data(struct libscols_line *ln, size_t n, char *data);
 extern struct libscols_line *scols_copy_line(struct libscols_line *ln);
 
-/* table */
+/* table.c */
 extern int scols_table_colors_wanted(struct libscols_table *tb);
 extern int scols_table_is_raw(struct libscols_table *tb);
 extern int scols_table_is_ascii(struct libscols_table *tb);
@@ -202,6 +208,8 @@ extern int scols_table_set_symbols(struct libscols_table *tb, struct libscols_sy
 extern int scols_table_set_stream(struct libscols_table *tb, FILE *stream);
 extern FILE *scols_table_get_stream(struct libscols_table *tb);
 extern int scols_table_reduce_termwidth(struct libscols_table *tb, size_t reduce);
+extern int scols_table_set_key_column(struct libscols_table *tb, struct libscols_column *cl);
+struct libscols_column *scols_table_get_key_column(struct libscols_table *tb);
 
 /* table_print.c */
 extern int scols_print_table(struct libscols_table *tb);
-- 
1.8.3.2

