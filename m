Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f53.google.com ([209.85.216.53]:37647 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125Ab2BVEQj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 21 Feb 2012 23:16:39 -0500
Received: by qafk1 with SMTP id k1so7883328qaf.19
        for <util-linux@vger.kernel.org>; Tue, 21 Feb 2012 20:16:39 -0800 (PST)
MIME-Version: 1.0
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] libmount: remove teaser proto for mnt_table_get_name
Date: Tue, 21 Feb 2012 23:16:34 -0500
Message-Id: <1329884194-7269-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This function was never implemented, but the proto has existed since the
inception of the library. As the libmnt_table struct doesn't include a
member necessary to carry the name of the table, simply discard this
prototype. If ever a need to break ABI comes up, perhaps this could be
revisited.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
I want my money back! I really wanted to use this function in an error
callback. =P

 libmount/docs/libmount-sections.txt |    1 -
 libmount/src/libmount.h.in          |    1 -
 libmount/src/libmount.sym           |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/libmount/docs/libmount-sections.txt b/libmount/docs/libmount-sections.txt
index 99b81c2..65f2859 100644
--- a/libmount/docs/libmount-sections.txt
+++ b/libmount/docs/libmount-sections.txt
@@ -246,7 +246,6 @@ mnt_table_find_srcpath
 mnt_table_find_tag
 mnt_table_find_target
 mnt_table_get_cache
-mnt_table_get_name
 mnt_table_get_nents
 mnt_table_get_root_fs
 mnt_table_is_fs_mounted
diff --git a/libmount/src/libmount.h.in b/libmount/src/libmount.h.in
index c407b98..ae8b99e 100644
--- a/libmount/src/libmount.h.in
+++ b/libmount/src/libmount.h.in
@@ -292,7 +292,6 @@ extern int mnt_reset_table(struct libmnt_table *tb);
 extern int mnt_table_get_nents(struct libmnt_table *tb);
 extern int mnt_table_set_cache(struct libmnt_table *tb, struct libmnt_cache *mpc);
 extern struct libmnt_cache *mnt_table_get_cache(struct libmnt_table *tb);
-extern const char *mnt_table_get_name(struct libmnt_table *tb);
 extern int mnt_table_add_fs(struct libmnt_table *tb, struct libmnt_fs *fs);
 extern int mnt_table_remove_fs(struct libmnt_table *tb, struct libmnt_fs *fs);
 extern int mnt_table_next_fs(struct libmnt_table *tb, struct libmnt_iter *itr,
diff --git a/libmount/src/libmount.sym b/libmount/src/libmount.sym
index d4e0056..6889d9d 100644
--- a/libmount/src/libmount.sym
+++ b/libmount/src/libmount.sym
@@ -163,7 +163,6 @@ global:
 	mnt_table_find_tag;
 	mnt_table_find_target;
 	mnt_table_get_cache;
-	mnt_table_get_name;
 	mnt_table_get_nents;
 	mnt_table_get_root_fs;
 	mnt_table_next_child_fs;
-- 
1.7.9.1

