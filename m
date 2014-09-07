Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:64165 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382AbaIGMng (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Sep 2014 08:43:36 -0400
Received: by mail-we0-f174.google.com with SMTP id w61so2240008wes.19
        for <util-linux@vger.kernel.org>; Sun, 07 Sep 2014 05:43:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/17] mkfs.minix: fix couple compiler warnings
Date: Sun,  7 Sep 2014 13:42:58 +0100
Message-Id: <1410093785-17537-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

disk-utils/mkfs.minix.c:366:3: warning: ISO C forbids 'return' with
expression, in function returning void [-Wpedantic]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.minix.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 9fdfc63..2dafc86 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -362,9 +362,11 @@ static void make_bad_inode_v2_v3 (void)
 
 static void make_bad_inode(void)
 {
-	if (fs_version < 2)
-		return make_bad_inode_v1();
-	return make_bad_inode_v2_v3();
+	if (fs_version < 2) {
+		make_bad_inode_v1();
+		return;
+	}
+	make_bad_inode_v2_v3();
 }
 
 static void make_root_inode_v1(void) {
@@ -412,9 +414,11 @@ static void make_root_inode_v2_v3 (void) {
 
 static void make_root_inode(void)
 {
-	if (fs_version < 2)
-		return make_root_inode_v1();
-	return make_root_inode_v2_v3();
+	if (fs_version < 2) {
+		make_root_inode_v1();
+		return;
+	}
+	make_root_inode_v2_v3();
 }
 
 static void super_set_nzones(void)
-- 
2.1.0

