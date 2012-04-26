Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:40834 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932682Ab2DZAaz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Apr 2012 20:30:55 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 1/2] libmount: expose mnt_get_mountpoint as external API
Date: Wed, 25 Apr 2012 20:30:51 -0400
Message-Id: <1335400252-17929-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 libmount/src/libmount.h.in |    1 +
 libmount/src/libmount.sym  |    1 +
 libmount/src/mountP.h      |    1 -
 libmount/src/utils.c       |    9 +++++++++
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/libmount/src/libmount.h.in b/libmount/src/libmount.h.in
index 5c5edbb..e11c0c0 100644
--- a/libmount/src/libmount.h.in
+++ b/libmount/src/libmount.h.in
@@ -146,6 +146,7 @@ extern const char *mnt_get_fstab_path(void);
 extern const char *mnt_get_swaps_path(void);
 extern const char *mnt_get_mtab_path(void);
 extern int mnt_has_regular_mtab(const char **mtab, int *writable);
+extern char *mnt_get_mountpoint(const char *path);
 
 /* cache.c */
 extern struct libmnt_cache *mnt_new_cache(void);
diff --git a/libmount/src/libmount.sym b/libmount/src/libmount.sym
index ca7a305..d4d5b84 100644
--- a/libmount/src/libmount.sym
+++ b/libmount/src/libmount.sym
@@ -237,6 +237,7 @@ global:
 	mnt_context_is_nohelpers;
 	mnt_table_find_devno;
 	mnt_table_parse_swaps;
+	mnt_get_mountpoint;
 	mnt_get_swaps_path;
 	mnt_fs_get_swaptype;
 	mnt_fs_get_size;
diff --git a/libmount/src/mountP.h b/libmount/src/mountP.h
index ee5e94f..c7d378e 100644
--- a/libmount/src/mountP.h
+++ b/libmount/src/mountP.h
@@ -139,7 +139,6 @@ extern int mnt_get_uid(const char *username, uid_t *uid);
 extern int mnt_get_gid(const char *groupname, gid_t *gid);
 extern int mnt_in_group(gid_t gid);
 
-extern char *mnt_get_mountpoint(const char *path);
 extern char *mnt_get_fs_root(const char *path, const char *mountpoint);
 extern int mnt_open_uniq_filename(const char *filename, char **name);
 extern int mnt_has_regular_utab(const char **utab, int *writable);
diff --git a/libmount/src/utils.c b/libmount/src/utils.c
index e740d83..b824edc 100644
--- a/libmount/src/utils.c
+++ b/libmount/src/utils.c
@@ -785,6 +785,15 @@ int mnt_open_uniq_filename(const char *filename, char **name)
 	return fd < 0 ? -errno : fd;
 }
 
+/**
+ * mnt_get_mountpoint:
+ * @path: pathname
+ *
+ * This function finds the mountpoint that a given path resides in. @path
+ * should be canonicalized. The returned pointer should be freed by the caller.
+ *
+ * Returns: target of mounted device or NULL on error
+ */
 char *mnt_get_mountpoint(const char *path)
 {
 	char *mnt = strdup(path);
-- 
1.7.10

