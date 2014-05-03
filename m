Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f51.google.com ([209.85.220.51]:54144 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbaECRmV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 May 2014 13:42:21 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so216787pab.24
        for <util-linux@vger.kernel.org>; Sat, 03 May 2014 10:42:21 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH 1/8] libsmartcols/src/libsmartcols.h.in: add function name
Date: Sat,  3 May 2014 23:41:21 +0600
Message-Id: <1399138888-7554-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Shakur Shams Mullick <shakursmullick@gmail.com>
---
 libsmartcols/src/libsmartcols.h.in | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libsmartcols/src/libsmartcols.h.in b/libsmartcols/src/libsmartcols.h.in
index 9468226..da27262 100644
--- a/libsmartcols/src/libsmartcols.h.in
+++ b/libsmartcols/src/libsmartcols.h.in
@@ -157,7 +157,7 @@ extern int scols_line_set_data(struct libscols_line *ln, size_t n, const char *d
 extern int scols_line_refer_data(struct libscols_line *ln, size_t n, char *data);
 extern struct libscols_line *scols_copy_line(struct libscols_line *ln);
 
-/* table */
+/* table.c */
 extern int scols_table_colors_wanted(struct libscols_table *tb);
 extern int scols_table_is_raw(struct libscols_table *tb);
 extern int scols_table_is_ascii(struct libscols_table *tb);
@@ -166,6 +166,8 @@ extern int scols_table_is_empty(struct libscols_table *tb);
 extern int scols_table_is_export(struct libscols_table *tb);
 extern int scols_table_is_maxout(struct libscols_table *tb);
 extern int scols_table_is_tree(struct libscols_table *tb);
+extern int scols_table_is_namesort(struct libscols_table *tb);
+extern int scols_table_is_sizesort(struct libscols_table *tb);
 
 extern int scols_table_enable_colors(struct libscols_table *tb, int enable);
 extern int scols_table_enable_raw(struct libscols_table *tb, int enable);
@@ -173,6 +175,8 @@ extern int scols_table_enable_ascii(struct libscols_table *tb, int enable);
 extern int scols_table_enable_noheadings(struct libscols_table *tb, int enable);
 extern int scols_table_enable_export(struct libscols_table *tb, int enable);
 extern int scols_table_enable_maxout(struct libscols_table *tb, int enable);
+extern int scols_table_enable_namesort(struct libscols_table *tb, int enable);
+extern int scols_table_enable_sizesort(struct libscols_table *tb, int enable);
 
 extern int scols_table_set_column_separator(struct libscols_table *tb, const char *sep);
 extern int scols_table_set_line_separator(struct libscols_table *tb, const char *sep);
-- 
1.8.3.2

