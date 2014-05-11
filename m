Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f175.google.com ([209.85.192.175]:60481 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896AbaEKIV2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 04:21:28 -0400
Received: by mail-pd0-f175.google.com with SMTP id x10so5327177pdj.34
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 01:21:27 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH 5/8] libsmartcols/src/column.c: add function to set comparison function scols_column_set_sortcmp() sets the cell comparison function to use
Date: Sun, 11 May 2014 14:20:35 +0600
Message-Id: <1399796438-5495-5-git-send-email-shakursmullick@gmail.com>
In-Reply-To: <1399796438-5495-1-git-send-email-shakursmullick@gmail.com>
References: <1399796438-5495-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 libsmartcols/src/column.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/libsmartcols/src/column.c b/libsmartcols/src/column.c
index 4ee782f..f2ff0a7 100644
--- a/libsmartcols/src/column.c
+++ b/libsmartcols/src/column.c
@@ -313,3 +313,15 @@ int scols_column_is_noextremes(struct libscols_column *cl)
 		return -EINVAL;
 	return cl->flags & SCOLS_FL_NOEXTREMES;
 }
+
+int scols_column_set_sortcmp(struct libscols_column *cl, 
+                             int (*compar)(struct libscols_cell *a, struct libscols_cell *b, void *data), 
+                             void *data)
+{
+	assert(cl);
+	if (!cl)
+		return -EINVAL;
+	cl->compar = compar;
+	
+	return 0;
+}
-- 
1.8.3.2

