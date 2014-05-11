Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f171.google.com ([209.85.192.171]:38804 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbaEKIVO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 04:21:14 -0400
Received: by mail-pd0-f171.google.com with SMTP id r10so5394596pdi.2
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 01:21:13 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH v2 2/8] libsmartcols/src/libsmartcols.sym: add symbols
Date: Sun, 11 May 2014 14:20:32 +0600
Message-Id: <1399796438-5495-2-git-send-email-shakursmullick@gmail.com>
In-Reply-To: <1399796438-5495-1-git-send-email-shakursmullick@gmail.com>
References: <1399796438-5495-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 libsmartcols/src/libsmartcols.sym | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libsmartcols/src/libsmartcols.sym b/libsmartcols/src/libsmartcols.sym
index 4b64f28..2c80699 100644
--- a/libsmartcols/src/libsmartcols.sym
+++ b/libsmartcols/src/libsmartcols.sym
@@ -9,6 +9,8 @@ global:
 	scols_cell_refer_data;
 	scols_cell_set_color;
 	scols_cell_set_data;
+	scols_cmpstr_cells;
+	scols_cmpnum_cells;
 	scols_column_get_color;
 	scols_column_get_flags;
 	scols_column_get_header;
@@ -21,6 +23,7 @@ global:
 	scols_column_set_color;
 	scols_column_set_flags;
 	scols_column_set_whint;
+	scols_column_set_sortcmp;
 	scols_copy_column;
 	scols_copy_line;
 	scols_copy_symbols;
@@ -97,6 +100,8 @@ global:
 	scols_table_set_line_separator;
 	scols_table_set_stream;
 	scols_table_set_symbols;
+	scols_table_set_key_column;
+	scols_table_get_key_column;
 	scols_unref_column;
 	scols_unref_line;
 	scols_unref_symbols;
-- 
1.8.3.2

