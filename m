Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33034 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896AbaEKIVb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 04:21:31 -0400
Received: by mail-pd0-f171.google.com with SMTP id r10so5424585pdi.30
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 01:21:31 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH v2 6/8] libsmartcols/src/table.c: set and get key column to use for sorting scols_table_set_key_column() sets the column to use scols_table_get_key_column() returns the column being used
Date: Sun, 11 May 2014 14:20:36 +0600
Message-Id: <1399796438-5495-6-git-send-email-shakursmullick@gmail.com>
In-Reply-To: <1399796438-5495-1-git-send-email-shakursmullick@gmail.com>
References: <1399796438-5495-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 libsmartcols/src/table.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/libsmartcols/src/table.c b/libsmartcols/src/table.c
index d4c61ee..549442a 100644
--- a/libsmartcols/src/table.c
+++ b/libsmartcols/src/table.c
@@ -229,7 +229,12 @@ struct libscols_column *scols_table_new_column(struct libscols_table *tb,
 		goto err;
 	if (scols_cell_set_data(hr, name))
 		goto err;
-
+	/*if(strncmp(name,"NAME", 4) == 0)
+		scols_column_set_sortcmp(cl, scols_cmpstr_cells, &cl->seqnum);
+		
+	else if(strncmp(name,"SIZE", 4) == 0)
+		scols_column_set_sortcmp(cl, scols_cmpnum_cells, &cl->seqnum);*/
+	
 	scols_column_set_whint(cl, whint);
 	scols_column_set_flags(cl, flags);
 
@@ -977,3 +982,17 @@ char *scols_table_get_line_separator(struct libscols_table *tb)
 	return tb->linesep;
 
 }
+
+int scols_table_set_key_column(struct libscols_table *tb, struct libscols_column *cl)
+{
+	assert (tb);
+	if (!tb)
+		return -EINVAL;
+	tb->key_cl = cl;
+}
+
+struct libscols_column *scols_table_get_key_column(struct libscols_table *tb)
+{
+	assert (tb);
+	return tb ? tb->key_cl : NULL;
+}
-- 
1.8.3.2

