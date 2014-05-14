Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f51.google.com ([209.85.220.51]:37393 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbaENFKW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 14 May 2014 01:10:22 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so1181047pab.24
        for <util-linux@vger.kernel.org>; Tue, 13 May 2014 22:10:21 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH v3 1/5] libsmartcols/src/libsmartcols.h.in: add function
Date: Wed, 14 May 2014 11:09:56 +0600
Message-Id: <1400044200-9196-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Shakur Shams Mullick <shakursmullick@gmail.com>
---
 libsmartcols/src/libsmartcols.h.in | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/libsmartcols/src/libsmartcols.h.in b/libsmartcols/src/libsmartcols.h.in
index 9468226..5ead53f 100644
--- a/libsmartcols/src/libsmartcols.h.in
+++ b/libsmartcols/src/libsmartcols.h.in
@@ -115,6 +115,8 @@ extern int scols_cell_refer_data(struct libscols_cell *ce, char *str);
 extern const char *scols_cell_get_data(const struct libscols_cell *ce);
 extern int scols_cell_set_color(struct libscols_cell *ce, const char *color);
 extern const char *scols_cell_get_color(const struct libscols_cell *ce);
+extern int scols_cmpstr_cells(struct libscols_cell *a, struct libscols_cell *b, void *data);
+extern int scols_cmpnum_cells(struct libscols_cell *a, struct libscols_cell *b, void *data);
 
 /* column.c */
 extern int scols_column_is_tree(struct libscols_column *cl);
@@ -134,7 +136,9 @@ extern double scols_column_get_whint(struct libscols_column *cl);
 extern struct libscols_cell *scols_column_get_header(struct libscols_column *cl);
 extern int scols_column_set_color(struct libscols_column *cl, const char *color);
 extern const char *scols_column_get_color(struct libscols_column *cl);
-
+extern int scols_column_set_sortcmp(struct libscols_column *cl, 
+	int (*compar)(struct libscols_cell *a, struct libscols_cell *b, void *), void *data);
+	
 /* line.c */
 extern struct libscols_line *scols_new_line(void);
 extern void scols_ref_line(struct libscols_line *ln);
@@ -206,6 +210,7 @@ extern int scols_table_reduce_termwidth(struct libscols_table *tb, size_t reduce
 /* table_print.c */
 extern int scols_print_table(struct libscols_table *tb);
 extern int scols_print_table_to_string(struct libscols_table *tb, char **data);
+extern void scols_sort_table(struct libscols_table *tb, struct libscols_column *cl);
 
 #ifdef __cplusplus
 }
-- 
1.8.3.2

