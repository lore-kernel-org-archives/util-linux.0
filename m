Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:39139 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbaBPN6P (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Feb 2014 08:58:15 -0500
From: =?UTF-8?q?Thomas=20B=C3=A4chler?= <thomas@archlinux.org>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20B=C3=A4chler?= <thomas@archlinux.org>
Subject: [PATCH] libmount: initialize *root to NULL in mnt_table_get_root_fs
Date: Sun, 16 Feb 2014 14:58:06 +0100
Message-Id: <1392559086-4010-1-git-send-email-thomas@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

mnt_table_get_root_fs only works when *root is set to NULL. This
is not only undocumented, but also unintuitive. Fix it by initializing
*root inside mnt_table_get_root_fs.
---
 libmount/src/tab.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 8ae49c8..7a253e8 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -501,6 +501,7 @@ int mnt_table_get_root_fs(struct libmnt_table *tb, struct libmnt_fs **root)
 	struct libmnt_iter itr;
 	struct libmnt_fs *fs;
 	int root_id = 0;
+	*root = NULL;
 
 	assert(tb);
 	assert(root);
-- 
1.8.5.4

