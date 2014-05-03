Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f54.google.com ([209.85.220.54]:60314 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbaECRme (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 May 2014 13:42:34 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so7070133pab.13
        for <util-linux@vger.kernel.org>; Sat, 03 May 2014 10:42:33 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH 4/8] libsmartcols/src/table.c: implementation of 4 newly added functions
Date: Sat,  3 May 2014 23:41:24 +0600
Message-Id: <1399138888-7554-4-git-send-email-shakursmullick@gmail.com>
In-Reply-To: <1399138888-7554-1-git-send-email-shakursmullick@gmail.com>
References: <1399138888-7554-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

newly implemented functions are:
extern int scols_table_is_namesort(struct libscols_table *tb);
extern int scols_table_is_sizesort(struct libscols_table *tb);
extern int scols_table_enable_namesort(struct libscols_table *tb, int enable);
extern int scols_table_enable_sizesort(struct libscols_table *tb, int enable);

Signed-off-by: Shakur Shams Mullick <shakursmullick@gmail.com>
---
 libsmartcols/src/table.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/libsmartcols/src/table.c b/libsmartcols/src/table.c
index d4c61ee..224e7b9 100644
--- a/libsmartcols/src/table.c
+++ b/libsmartcols/src/table.c
@@ -707,6 +707,51 @@ int scols_table_enable_raw(struct libscols_table *tb, int enable)
 		tb->format = 0;
 	return 0;
 }
+/**
+ * scols_table_enable_namesort:
+ * @tb: table
+ * @enable: 1 or 0
+ *
+ * Enable/disable sorted by name output format.
+ *
+ * Returns: 0 on success, negative number in case of an error.
+ */
+ 
+int scols_table_enable_namesort(struct libscols_table *tb, int enable)
+{
+	assert(tb);
+	if (!tb)
+		return -EINVAL;
+
+	if (enable)
+		tb->sort = SCOLS_SORT_NAME;
+	else if (tb->sort == SCOLS_SORT_NAME)
+		tb->sort = 0;
+	return 0;
+}
+
+/**
+ * scols_table_enable_sizesort:
+ * @tb: table
+ * @enable: 1 or 0
+ *
+ * Enable/disable sorted by size output format.
+ *
+ * Returns: 0 on success, negative number in case of an error.
+ */
+ 
+int scols_table_enable_sizesort(struct libscols_table *tb, int enable)
+{
+	assert(tb);
+	if (!tb)
+		return -EINVAL;
+
+	if (enable)
+		tb->sort = SCOLS_SORT_SIZE;
+	else if (tb->sort == SCOLS_SORT_SIZE)
+		tb->sort = 0;
+	return 0;
+}
 
 /**
  * scols_table_enable_export:
@@ -840,6 +885,29 @@ int scols_table_is_noheadings(struct libscols_table *tb)
 }
 
 /**
+ * scols_table_is_namesort:
+ * @tb: table
+ *
+ * Returns: 1 if sorted output by name is enabled.
+ */
+int scols_table_is_namesort(struct libscols_table *tb)
+{
+	assert(tb);
+	return tb && tb->sort == SCOLS_SORT_NAME;
+}
+
+/**
+ * scols_table_is_sizesort:
+ * @tb: table
+ *
+ * Returns: 1 if sorted output by size is enabled.
+ */
+int scols_table_is_sizesort(struct libscols_table *tb)
+{
+	assert(tb);
+	return tb && tb->sort == SCOLS_SORT_SIZE;
+}
+/**
  * scols_table_is_export:
  * @tb: table
  *
-- 
1.8.3.2

