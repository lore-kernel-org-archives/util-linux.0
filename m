Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f179.google.com ([209.85.192.179]:44889 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbaECRm0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 May 2014 13:42:26 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so4032121pdj.10
        for <util-linux@vger.kernel.org>; Sat, 03 May 2014 10:42:25 -0700 (PDT)
From: Shakur Shams Mullick <shakursmullick@gmail.com>
To: util-linux@vger.kernel.org
Cc: Shakur Shams Mullick <shakursmullick@gmail.com>
Subject: [PATCH 2/8] libsmartcols/src/libsmartcols.sym: add function symbol
Date: Sat,  3 May 2014 23:41:22 +0600
Message-Id: <1399138888-7554-2-git-send-email-shakursmullick@gmail.com>
In-Reply-To: <1399138888-7554-1-git-send-email-shakursmullick@gmail.com>
References: <1399138888-7554-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Shakur Shams Mullick <shakursmullick@gmail.com>
---
 libsmartcols/src/libsmartcols.sym | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsmartcols/src/libsmartcols.sym b/libsmartcols/src/libsmartcols.sym
index 4b64f28..fe7f36c 100644
--- a/libsmartcols/src/libsmartcols.sym
+++ b/libsmartcols/src/libsmartcols.sym
@@ -70,6 +70,8 @@ global:
 	scols_table_enable_maxout;
 	scols_table_enable_noheadings;
 	scols_table_enable_raw;
+	scols_table_enable_namesort;
+	scols_table_enable_sizesort;
 	scols_table_get_column;
 	scols_table_get_column_separator;
 	scols_table_get_line;
@@ -84,6 +86,8 @@ global:
 	scols_table_is_noheadings;
 	scols_table_is_raw;
 	scols_table_is_tree;
+	scols_table_is_namesort;
+	scols_table_is_sizesort;
 	scols_table_new_column;
 	scols_table_new_line;
 	scols_table_next_column;
-- 
1.8.3.2

