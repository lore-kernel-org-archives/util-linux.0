Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f53.google.com ([209.85.220.53]:55203 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbaECRmi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 May 2014 13:42:38 -0400
Received: by mail-pa0-f53.google.com with SMTP id kp14so2608240pab.26
        for <util-linux@vger.kernel.org>; Sat, 03 May 2014 10:42:37 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH 5/8] libsmartcols/src/table_print.c: sort table before printing
Date: Sat,  3 May 2014 23:41:25 +0600
Message-Id: <1399138888-7554-5-git-send-email-shakursmullick@gmail.com>
In-Reply-To: <1399138888-7554-1-git-send-email-shakursmullick@gmail.com>
References: <1399138888-7554-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It fascilitates sorting before printing the table. Sorting can be done by size or name.

Signed-off-by: Shakur Shams Mullick <shakursmullick@gmail.com>
---
 libsmartcols/src/table_print.c | 60 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/libsmartcols/src/table_print.c b/libsmartcols/src/table_print.c
index 2942053..b256198 100644
--- a/libsmartcols/src/table_print.c
+++ b/libsmartcols/src/table_print.c
@@ -20,6 +20,7 @@
 #include <string.h>
 #include <termios.h>
 #include <ctype.h>
+#include <list.h>
 
 #include "nls.h"
 #include "mbsalign.h"
@@ -27,6 +28,7 @@
 #include "ttyutils.h"
 #include "carefulputc.h"
 #include "smartcolsP.h"
+#include "strutils.h"
 
 /* This is private struct to work with output data */
 struct libscols_buffer {
@@ -38,6 +40,8 @@ struct libscols_buffer {
 	size_t	art_idx;	/* begin of the tree ascii art or zero */
 };
 
+static uint sq;
+
 static struct libscols_buffer *new_buffer(size_t sz)
 {
 	struct libscols_buffer *buf = malloc(sz + sizeof(struct libscols_buffer));
@@ -694,7 +698,35 @@ static size_t strlen_line(struct libscols_line *ln)
 	return sz;
 }
 
+int size_comparison(struct list_head *a, struct list_head *b, void *data)
+{
+	struct libscols_line *ra, *rb;
+	uint64_t n, m;
+	
+	ra = list_entry(a, struct libscols_line, ln_lines);
+	rb = list_entry(b, struct libscols_line, ln_lines);
+		
+	strtosize(ra->cells[sq].data, &n);
+	strtosize(rb->cells[sq].data, &m);
+
+	if (n >= m)
+		return 1;
+	return -1;
+}
 
+int name_comparison(struct list_head *a, struct list_head *b, void *data)
+{
+	struct libscols_line *ra, *rb;
+	int n, m;
+	
+	ra = list_entry(a, struct libscols_line, ln_lines);
+	rb = list_entry(b, struct libscols_line, ln_lines);
+
+	n = strlen(ra->cells[sq].data);
+	m = strlen(rb->cells[sq].data);
+	 
+	return strncmp(ra->cells[sq].data, rb->cells[sq].data, (n>=m ? n : m));
+}
 
 /**
  * scols_print_table:
@@ -711,7 +743,9 @@ int scols_print_table(struct libscols_table *tb)
 	struct libscols_line *ln;
 	struct libscols_iter itr;
 	struct libscols_buffer *buf;
-
+	struct list_head *p;
+	char *sdata;
+	
 	assert(tb);
 	if (!tb)
 		return -1;
@@ -743,6 +777,30 @@ int scols_print_table(struct libscols_table *tb)
 
 	if (scols_table_is_tree(tb))
 		rc = print_tree(tb, buf);
+	else if (scols_table_is_namesort(tb))
+	{
+		list_for_each(p, &tb->tb_columns) {
+			struct libscols_column *cl = list_entry(p, struct libscols_column, cl_columns);
+			if(strncmp(cl->header.data, "NAME", 4) == 0){
+				sq = cl->seqnum;
+				break;
+			}
+		}
+		list_sort(&tb->tb_lines, name_comparison, NULL);
+		print_table(tb, buf);
+	}
+	else if (scols_table_is_sizesort(tb))
+	{
+		list_for_each(p, &tb->tb_columns) {
+			struct libscols_column *cl = list_entry(p, struct libscols_column, cl_columns);
+			if(strncmp(cl->header.data, "SIZE", 4) == 0){
+				sq = cl->seqnum;
+				break;
+			}
+		}
+		list_sort(&tb->tb_lines, size_comparison, NULL);
+		print_table(tb, buf);
+	}
 	else
 		rc = print_table(tb, buf);
 
-- 
1.8.3.2

