Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f182.google.com ([209.85.192.182]:44188 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896AbaEKIVZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 04:21:25 -0400
Received: by mail-pd0-f182.google.com with SMTP id v10so5359211pde.13
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 01:21:24 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH 4/8] libsmartcols/src/cell.c: add two functions to compare number and string cells
Date: Sun, 11 May 2014 14:20:34 +0600
Message-Id: <1399796438-5495-4-git-send-email-shakursmullick@gmail.com>
In-Reply-To: <1399796438-5495-1-git-send-email-shakursmullick@gmail.com>
References: <1399796438-5495-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

scols_cmpstr_cells and scols_cmpnum_cells compare string and number cells.
When comparing data of two cells for the purpose of sorting, it is not
necessary to use these two library functions. Developers can use their
own implementation of cell comparison function.

Furthermore these two functions can be extended to fascilitate sorting
in reverse order.
These two functions could be modified to fascilitate sorting in reverse order.
---
 libsmartcols/src/cell.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/libsmartcols/src/cell.c b/libsmartcols/src/cell.c
index 491b8a1..9304d2a 100644
--- a/libsmartcols/src/cell.c
+++ b/libsmartcols/src/cell.c
@@ -25,6 +25,7 @@
 #include <ctype.h>
 
 #include "smartcolsP.h"
+#include "strutils.h"
 
 /*
  * The cell has no ref-counting, free() and new() functions. All is
@@ -181,3 +182,33 @@ int scols_cell_copy_content(struct libscols_cell *dest,
 		rc = scols_cell_set_color(dest, scols_cell_get_color(src));
 	return rc;
 }
+
+int scols_cmpstr_cells(struct libscols_cell *a, struct libscols_cell *b, void *data)
+{
+	int n, m;
+	const char *adata, *bdata;
+
+	adata = scols_cell_get_data(a);
+	bdata = scols_cell_get_data(b);
+	
+	n = strlen(adata);
+	m = strlen(bdata);
+	
+	return strncmp(adata, bdata, (n>=m ? n : m));
+}
+
+int scols_cmpnum_cells(struct libscols_cell *a, struct libscols_cell *b, void *data)
+{
+	uint64_t n, m;
+	const char *adata, *bdata;
+
+	adata = scols_cell_get_data(a);
+	bdata = scols_cell_get_data(b);
+	
+	strtosize(adata, &n);
+	strtosize(bdata, &m);
+	
+	if (n >= m)
+		return 1;
+	return -1;
+}
-- 
1.8.3.2

