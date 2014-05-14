Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f43.google.com ([209.85.160.43]:33455 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873AbaENFKr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 14 May 2014 01:10:47 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so1208544pbc.2
        for <util-linux@vger.kernel.org>; Tue, 13 May 2014 22:10:47 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH v3 2/5] libsmartcols/src/libsmartcols.sym: add function symbol
Date: Wed, 14 May 2014 11:09:57 +0600
Message-Id: <1400044200-9196-2-git-send-email-shakursmullick@gmail.com>
In-Reply-To: <1400044200-9196-1-git-send-email-shakursmullick@gmail.com>
References: <1400044200-9196-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Shakur Shams Mullick <shakursmullick@gmail.com>
---
 libsmartcols/src/libsmartcols.sym | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsmartcols/src/libsmartcols.sym b/libsmartcols/src/libsmartcols.sym
index 4b64f28..c4ca8b8 100644
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
@@ -51,6 +54,7 @@ global:
 	scols_new_table;
 	scols_parse_version_string;
 	scols_print_table;
+	scols_sort_table;
 	scols_print_table_to_string;
 	scols_ref_column;
 	scols_ref_line;
-- 
1.8.3.2

