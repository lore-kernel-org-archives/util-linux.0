Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60445 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754748Ab2CBDrG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 1 Mar 2012 22:47:06 -0500
Received: by mail-vw0-f46.google.com with SMTP id ff1so1153773vbb.19
        for <util-linux@vger.kernel.org>; Thu, 01 Mar 2012 19:47:06 -0800 (PST)
MIME-Version: 1.0
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 2/2] libmount: don't treat "none" differently
Date: Thu,  1 Mar 2012 22:47:00 -0500
Message-Id: <1330660020-32542-2-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1330660020-32542-1-git-send-email-dreisner@archlinux.org>
References: <1330660020-32542-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This causes more problems than it solves. In the latest edition:

  # mount -t proc none foo
  mount: foo: mount failed: Invalid argument

A check for source and target fails in mnt_context_apply_fstab()
because, even though they were indeed specified on the cmdline,
__mnt_fs_set_source_ptr() altered this and NULL'd out the source.

If you're able to mount this device via other means, other tools start
reporting oddities, such as mount's output:

  (null) on /foo type proc (rw,relatime)

or findmnt:

  TARGET      SOURCE FSTYPE OPTIONS
  /foo               proc   rw,relatime

Simply treat "none" like any other source when passed in. We still keep
conventions to allow NULL as a valid source and replace it with "none".

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
There may be some history here I'm not aware of that makes this all a silly
idea...

 libmount/src/fs.c        |   14 ++++----------
 libmount/src/tab.c       |    7 +++----
 libmount/src/tab_parse.c |    7 +------
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/libmount/src/fs.c b/libmount/src/fs.c
index a28e66c..048f0e2 100644
--- a/libmount/src/fs.c
+++ b/libmount/src/fs.c
@@ -304,11 +304,7 @@ int __mnt_fs_set_source_ptr(struct libmnt_fs *fs, char *source)
 
 	assert(fs);
 
-	if (source && !strcmp(source, "none")) {
-		free(source);
-		source = NULL;
-
-	} else if (source && strchr(source, '=')) {
+	if (source && strchr(source, '=')) {
 		if (blkid_parse_tag_string(source, &t, &v) != 0)
 			return -1;
 	}
@@ -341,11 +337,9 @@ int mnt_fs_set_source(struct libmnt_fs *fs, const char *source)
 
 	if (!fs)
 		return -EINVAL;
-	if (source) {
-		p = strdup(source);
-		if (!p)
-			return -ENOMEM;
-	}
+	p = strdup(source ? source : "none");
+	if (!p)
+		return -ENOMEM;
 
 	rc = __mnt_fs_set_source_ptr(fs, p);
 	if (rc)
diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 21b05c7..7dd9654 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -480,9 +480,8 @@ struct libmnt_fs *mnt_table_find_target(struct libmnt_table *tb, const char *pat
  * The 2nd, 3rd and 4th iterations are not performed when @tb cache is not
  * set (see mnt_table_set_cache()).
  *
- * Note that valid source path is NULL; the libmount uses NULL instead of
- * "none".  The "none" is used in /proc/{mounts,self/mountninfo} for pseudo
- * filesystems.
+ * Note that NULL is a valid source path; it will be replaced with "none". The
+ * "none" is used in /proc/{mounts,self/mountinfo} for pseudo filesystems.
  *
  * Returns: a tab entry or NULL.
  */
@@ -505,7 +504,7 @@ struct libmnt_fs *mnt_table_find_srcpath(struct libmnt_table *tb, const char *pa
 
 		p = mnt_fs_get_srcpath(fs);
 
-		if (path == NULL && src == NULL)
+		if (path == NULL && (src == NULL || !strcmp(src, "none")))
 			return fs;			/* source is "none" */
 		if (path && p && streq_except_trailing_slash(p, path))
 			return fs;
diff --git a/libmount/src/tab_parse.c b/libmount/src/tab_parse.c
index 0f618bb..5bc55ae 100644
--- a/libmount/src/tab_parse.c
+++ b/libmount/src/tab_parse.c
@@ -180,12 +180,7 @@ static int mnt_parse_mountinfo_line(struct libmnt_fs *fs, char *s)
 		unmangle_string(fs->vfs_optstr);
 		unmangle_string(fstype);
 		unmangle_string(src);
-
-		if (!strcmp(fs->fs_optstr, "none")) {
-			free(fs->fs_optstr);
-			fs->fs_optstr = NULL;
-		} else
-			unmangle_string(fs->fs_optstr);
+		unmangle_string(fs->fs_optstr);
 
 		rc = __mnt_fs_set_fstype_ptr(fs, fstype);
 		if (!rc) {
-- 
1.7.9.2

