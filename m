Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f174.google.com ([209.85.192.174]:50148 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896AbaEKIVe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 04:21:34 -0400
Received: by mail-pd0-f174.google.com with SMTP id w10so5318879pde.19
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 01:21:34 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH v2 7/8] libsmartcols/src/table_print.c: sort the list before printing
Date: Sun, 11 May 2014 14:20:37 +0600
Message-Id: <1399796438-5495-7-git-send-email-shakursmullick@gmail.com>
In-Reply-To: <1399796438-5495-1-git-send-email-shakursmullick@gmail.com>
References: <1399796438-5495-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 libsmartcols/src/table_print.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/libsmartcols/src/table_print.c b/libsmartcols/src/table_print.c
index 2942053..44c4525 100644
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
@@ -694,7 +698,22 @@ static size_t strlen_line(struct libscols_line *ln)
 	return sz;
 }
 
-
+int comparison_func(struct list_head *a, struct list_head *b, void *data)
+{
+	struct libscols_column *cl;
+	struct libscols_line *ra, *rb;
+	struct libscols_cell *ca, *cb;
+	
+	cl = (struct libscols_column *)(data);
+	
+	ra = list_entry(a, struct libscols_line, ln_lines);
+	rb = list_entry(b, struct libscols_line, ln_lines);
+	
+	ca = scols_line_get_cell(ra, cl->seqnum);
+	cb = scols_line_get_cell(rb, cl->seqnum);
+
+	return cl->compar(ca, cb, NULL);
+}
 
 /**
  * scols_print_table:
@@ -709,9 +728,12 @@ int scols_print_table(struct libscols_table *tb)
 	int rc = 0;
 	size_t bufsz;
 	struct libscols_line *ln;
+	struct libscols_column *cl;
 	struct libscols_iter itr;
 	struct libscols_buffer *buf;
-
+	struct list_head *p;
+	char *sdata;
+	
 	assert(tb);
 	if (!tb)
 		return -1;
@@ -742,10 +764,15 @@ int scols_print_table(struct libscols_table *tb)
 		rc = recount_widths(tb, buf);
 
 	if (scols_table_is_tree(tb))
-		rc = print_tree(tb, buf);
+		rc = print_tree(tb, buf);	
+	else if (!scols_table_get_key_column(tb))
+		rc = print_table(tb, buf);	
 	else
+	{
+		cl = scols_table_get_key_column(tb);
+		list_sort(&tb->tb_lines, comparison_func, cl);
 		rc = print_table(tb, buf);
-
+	}
 	free_buffer(buf);
 	return rc;
 }
-- 
1.8.3.2

