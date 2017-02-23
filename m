Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:48181 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750916AbdBWOE4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 23 Feb 2017 09:04:56 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DBE06ABCD
        for <util-linux@vger.kernel.org>; Thu, 23 Feb 2017 14:04:54 +0000 (UTC)
From: Petr Vorel <pvorel@suse.cz>
To: util-linux@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 1/2] libmount: add mnt_fs_is_btrfs()
Date: Thu, 23 Feb 2017 15:04:43 +0100
Message-Id: <20170223140444.17916-1-pvorel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
I exported mnt_fs_is_btrfs() even it's not necessary for second patch as I
consider useful to have it available. I'd like to have
btrfs_get_default_subvol_id() exported as well.
---
 libmount/docs/libmount-sections.txt |  1 +
 libmount/src/fs.c                   | 11 +++++++++++
 libmount/src/libmount.h.in          |  1 +
 libmount/src/libmount.sym           |  7 ++++++-
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/libmount/docs/libmount-sections.txt b/libmount/docs/libmount-sections.txt
index 78d89cae7..65f774c2c 100644
--- a/libmount/docs/libmount-sections.txt
+++ b/libmount/docs/libmount-sections.txt
@@ -209,6 +209,7 @@ mnt_fs_get_usedsize
 mnt_fs_get_userdata
 mnt_fs_get_user_options
 mnt_fs_get_vfs_options
+mnt_fs_is_btrfs
 mnt_fs_is_kernel
 mnt_fs_is_netfs
 mnt_fs_is_pseudofs
diff --git a/libmount/src/fs.c b/libmount/src/fs.c
index 1c4ba1aab..e1bb9cde4 100644
--- a/libmount/src/fs.c
+++ b/libmount/src/fs.c
@@ -616,6 +616,17 @@ int mnt_fs_is_netfs(struct libmnt_fs *fs)
 }
 
 /**
+ * mnt_fs_is_btrfs:
+ * @fs: filesystem
+ *
+ * Returns: 1 if the filesystem is a btrfs fs type
+ */
+int mnt_fs_is_btrfs(struct libmnt_fs *fs)
+{
+	return !strcmp(fs->fstype, "btrfs");
+}
+
+/**
  * mnt_fs_get_fstype:
  * @fs: fstab/mtab/mountinfo entry pointer
  *
diff --git a/libmount/src/libmount.h.in b/libmount/src/libmount.h.in
index f191a52fe..7196430ef 100644
--- a/libmount/src/libmount.h.in
+++ b/libmount/src/libmount.h.in
@@ -411,6 +411,7 @@ extern int mnt_fs_match_fstype(struct libmnt_fs *fs, const char *types);
 extern int mnt_fs_match_options(struct libmnt_fs *fs, const char *options);
 extern int mnt_fs_print_debug(struct libmnt_fs *fs, FILE *file);
 
+extern int mnt_fs_is_btrfs(struct libmnt_fs *fs);
 extern int mnt_fs_is_kernel(struct libmnt_fs *fs);
 extern int mnt_fs_is_swaparea(struct libmnt_fs *fs);
 extern int mnt_fs_is_netfs(struct libmnt_fs *fs);
diff --git a/libmount/src/libmount.sym b/libmount/src/libmount.sym
index f0210c240..72c9caa78 100644
--- a/libmount/src/libmount.sym
+++ b/libmount/src/libmount.sym
@@ -4,7 +4,7 @@
  *
  * Version info can't enforce this since we never change the SONAME.
  *
- * Copyright (C) 2011-2014 Karel Zak <kzak@redhat.com> 
+ * Copyright (C) 2011-2014 Karel Zak <kzak@redhat.com>
  */
 MOUNT_2.19 {
 global:
@@ -315,3 +315,8 @@ MOUNT_2.28 {
 	mnt_table_find_target_with_option;
 	mnt_fs_set_priority;
 } MOUNT_2.26;
+
+MOUNT_2.30 {
+global:
+	mnt_fs_is_btrfs;
+} MOUNT_2.28;
-- 
2.11.0

