Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f43.google.com ([209.85.220.43]:51099 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020AbaENFLJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 14 May 2014 01:11:09 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so1189739pad.16
        for <util-linux@vger.kernel.org>; Tue, 13 May 2014 22:11:08 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH v3 5/5] libsmartcols/src/table_print.c: add sorting for table
Date: Wed, 14 May 2014 11:10:00 +0600
Message-Id: <1400044200-9196-5-git-send-email-shakursmullick@gmail.com>
In-Reply-To: <1400044200-9196-1-git-send-email-shakursmullick@gmail.com>
References: <1400044200-9196-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Shakur Shams Mullick <shakursmullick@gmail.com>
---
 libsmartcols/src/table_print.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/libsmartcols/src/table_print.c b/libsmartcols/src/table_print.c
index 24b73f9..fed0305 100644
--- a/libsmartcols/src/table_print.c
+++ b/libsmartcols/src/table_print.c
@@ -694,7 +694,28 @@ static size_t strlen_line(struct libscols_line *ln)
 	return sz;
 }
 
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
+	return cl->compare_data(ca, cb, NULL);
+}
 
+void scols_sort_table(struct libscols_table *tb, struct libscols_column *cl)
+{		
+	assert(tb);
+	list_sort(&tb->tb_lines, comparison_func, cl);
+}
 
 /**
  * scols_print_table:
-- 
1.8.3.2

