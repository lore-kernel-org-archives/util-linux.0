Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f44.google.com ([209.85.160.44]:44045 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaF0FRH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 27 Jun 2014 01:17:07 -0400
Received: by mail-pb0-f44.google.com with SMTP id md12so4127635pbc.3
        for <util-linux@vger.kernel.org>; Thu, 26 Jun 2014 22:17:06 -0700 (PDT)
From: "Eric Rannaud" <e@nanocritical.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Eric Rannaud <e@nanocritical.com>
Subject: [PATCH 3/4] libmount: mnt_resolve_target: tiptoe around active mount points
Date: Thu, 26 Jun 2014 22:17:18 -0700
Message-Id: <7e7cf36d4dfbcd8785972819445df77c5da98bb9.1403845374.git.e@nanocritical.com>
In-Reply-To: <747e9f8de90dc1e906d2f84f3952a801e70ef3d0.1403845374.git.e@nanocritical.com>
References: <747e9f8de90dc1e906d2f84f3952a801e70ef3d0.1403845374.git.e@nanocritical.com>
In-Reply-To: <747e9f8de90dc1e906d2f84f3952a801e70ef3d0.1403845374.git.e@nanocritical.com>
References: <747e9f8de90dc1e906d2f84f3952a801e70ef3d0.1403845374.git.e@nanocritical.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Current code in mnt_fs_match_target() and mnt_table_find_target()
already does not canonicalize active mount points (when read from
mountinfo), because they are already canonicalized by the kernel.
Calling realpath(fs->target) on a mount point can hang -- e.g. if the
NFS server is unreachable.

This patch optionally extends this strategy to the general case, that is
when @fs does not directly come from the kernel through mountinfo (for
instance, it may have been parsed from /etc/fstab).

Given @mtab parsed from mountinfo, and if mnt_cache_set_targets(cache,
mtab) is used, then mnt_fs_match_target() and mnt_table_find_target()
check whether @fs->target is a known mount point in the cached
mountinfo, before attempting to canonicalize @fs->target, no matter
where @fs itself comes from. If found in the cached mountinfo,
@fs->target is not canonicalized.

Signed-off-by: Eric Rannaud <e@nanocritical.com>
---
 libmount/src/cache.c       | 124 ++++++++++++++++++++++++++++++++++++++-------
 libmount/src/fs.c          |   6 ++-
 libmount/src/libmount.h.in |   4 ++
 libmount/src/libmount.sym  |   2 +
 libmount/src/tab.c         |   8 +--
 5 files changed, 121 insertions(+), 23 deletions(-)

diff --git a/libmount/src/cache.c b/libmount/src/cache.c
index 2fe41b3a4e87..e10710b2c290 100644
--- a/libmount/src/cache.c
+++ b/libmount/src/cache.c
@@ -60,6 +60,8 @@ struct libmnt_cache {
 	 *    better to reuse the blkid_cache.
 	 */
 	blkid_cache		bc;
+
+	struct libmnt_table	*mtab;
 };
 
 /**
@@ -131,11 +133,27 @@ void mnt_unref_cache(struct libmnt_cache *cache)
 	if (cache) {
 		cache->refcount--;
 		/*DBG(CACHE, ul_debugobj(cache, "unref=%d", cache->refcount));*/
-		if (cache->refcount <= 0)
+		if (cache->refcount <= 0) {
+			mnt_unref_table(cache->mtab);
+
 			mnt_free_cache(cache);
+		}
 	}
 }
 
+int mnt_cache_set_targets(struct libmnt_cache *cache,
+				struct libmnt_table *mtab)
+{
+	assert(cache);
+	if (!cache)
+		return -EINVAL;
+
+	mnt_ref_table(mtab);
+	mnt_unref_table(cache->mtab);
+	cache->mtab = mtab;
+	return 0;
+}
+
 
 /* note that the @key could be the same pointer as @value */
 static int cache_add_entry(struct libmnt_cache *cache, char *key,
@@ -468,6 +486,35 @@ char *mnt_get_fstype(const char *devname, int *ambi, struct libmnt_cache *cache)
 	return type;
 }
 
+static char *canonicalize_path_and_cache(const char *path,
+						struct libmnt_cache *cache)
+{
+	char *p = NULL;
+	char *key = NULL;
+	char *value = NULL;
+
+	p = canonicalize_path(path);
+
+	if (p && cache) {
+		value = p;
+		key = strcmp(path, p) == 0 ? value : strdup(path);
+
+		if (!key || !value)
+			goto error;
+
+		if (cache_add_entry(cache, key, value,
+				MNT_CACHE_ISPATH))
+			goto error;
+	}
+
+	return p;
+error:
+	if (value != key)
+		free(value);
+	free(key);
+	return NULL;
+}
+
 /**
  * mnt_resolve_path:
  * @path: "native" path
@@ -483,8 +530,6 @@ char *mnt_get_fstype(const char *devname, int *ambi, struct libmnt_cache *cache)
 char *mnt_resolve_path(const char *path, struct libmnt_cache *cache)
 {
 	char *p = NULL;
-	char *key = NULL;
-	char *value = NULL;
 
 	/*DBG(CACHE, ul_debugobj(cache, "resolving path %s", path));*/
 
@@ -493,28 +538,71 @@ char *mnt_resolve_path(const char *path, struct libmnt_cache *cache)
 	if (cache)
 		p = (char *) cache_find_path(cache, path);
 
-	if (!p) {
-		p = canonicalize_path(path);
+	if (!p)
+		p = canonicalize_path_and_cache(path, cache);
 
-		if (p && cache) {
-			value = p;
-			key = strcmp(path, p) == 0 ? value : strdup(path);
+	return p;
+}
 
-			if (!key || !value)
-				goto error;
+/**
+ * mnt_resolve_target:
+ * @path: "native" path, a potential mount point
+ * @cache: cache for results or NULL.
+ *
+ * Like mnt_resolve_path(), unless @cache is not NULL and
+ * mnt_cache_set_targets(cache, mtab) was called: if @path is found in the
+ * cached @mtab and the matching entry was provided by the kernel, assume
+ * that @path is already canonicalized. By avoiding a call to
+ * canonicalize_path() on known mount points, there is a lower risk of
+ * stepping on a stale mount point, which can result in an application
+ * freeze. This is also faster in general, as stat(2) on a mount point is
+ * slower than on a regular file.
+ *
+ * Returns: absolute path or NULL in case of error. The result has to be
+ * deallocated by free() if @cache is NULL.
+ */
+char *mnt_resolve_target(const char *path, struct libmnt_cache *cache)
+{
+	char *p = NULL;
+	struct libmnt_iter *itr = NULL;
+	struct libmnt_fs *fs = NULL;
 
-			if (cache_add_entry(cache, key, value,
-							MNT_CACHE_ISPATH))
-				goto error;
+	/*DBG(CACHE, ul_debugobj(cache, "resolving path %s", path));*/
+
+	if (!path)
+		return NULL;
+	if (cache)
+		p = (char *) cache_find_path(cache, path);
+
+	if (cache && cache->mtab) {
+		itr = mnt_new_iter(MNT_ITER_FORWARD);
+		if (!itr)
+			goto skip_mtab;
+
+		while(mnt_table_next_fs(cache->mtab, itr, &fs) == 0) {
+			if (!mnt_fs_is_kernel(fs)
+                            || mnt_fs_is_swaparea(fs)
+                            || !mnt_fs_streq_target(fs, path))
+				continue;
+
+			p = strdup(path);
+			if (cache_add_entry(cache, p, p,
+					MNT_CACHE_ISPATH)) {
+				free(p);
+				goto done;
+			}
+			break;
 		}
 	}
 
+skip_mtab:
+	if (!p) {
+		p = canonicalize_path_and_cache(path, cache);
+	}
+
+done:
+	mnt_free_iter(itr);
 	return p;
-error:
-	if (value != key)
-		free(value);
-	free(key);
-	return NULL;
 }
 
 /**
diff --git a/libmount/src/fs.c b/libmount/src/fs.c
index 21ef0f7479fd..82541083a792 100644
--- a/libmount/src/fs.c
+++ b/libmount/src/fs.c
@@ -1413,7 +1413,9 @@ int mnt_fs_append_comment(struct libmnt_fs *fs, const char *comm)
  *	1) compare @target with @fs->target
  *	2) realpath(@target) with @fs->target
  *	3) realpath(@target) with realpath(@fs->target) if @fs is not from
- *	   /proc/self/mountinfo.
+ *	   /proc/self/mountinfo. However, if mnt_cache_set_targets(cache,
+ *	   mtab) was called, and the path @fs->target is found in @mtab,
+ *	   this comparison is not performed (see mnt_resolve_target()).
  *
  * The 2nd and 3rd attempts are not performed when @cache is NULL.
  *
@@ -1438,7 +1440,7 @@ int mnt_fs_match_target(struct libmnt_fs *fs, const char *target,
 
 		/* 3) - canonicalized and canonicalized */
 		if (!rc && cn && !mnt_fs_is_kernel(fs) && !mnt_fs_is_swaparea(fs)) {
-			char *tcn = mnt_resolve_path(fs->target, cache);
+			char *tcn = mnt_resolve_target(fs->target, cache);
 			rc = (tcn && strcmp(cn, tcn) == 0);
 		}
 	}
diff --git a/libmount/src/libmount.h.in b/libmount/src/libmount.h.in
index 08ddd659600d..ac0c790f2abe 100644
--- a/libmount/src/libmount.h.in
+++ b/libmount/src/libmount.h.in
@@ -220,6 +220,8 @@ extern void mnt_free_cache(struct libmnt_cache *cache);
 extern void mnt_ref_cache(struct libmnt_cache *cache);
 extern void mnt_unref_cache(struct libmnt_cache *cache);
 
+extern int mnt_cache_set_targets(struct libmnt_cache *cache,
+				struct libmnt_table *mtab);
 extern int mnt_cache_read_tags(struct libmnt_cache *cache, const char *devname);
 
 extern int mnt_cache_device_has_tag(struct libmnt_cache *cache,
@@ -235,6 +237,8 @@ extern char *mnt_get_fstype(const char *devname, int *ambi,
 			__ul_attribute__((warn_unused_result));
 extern char *mnt_resolve_path(const char *path, struct libmnt_cache *cache)
 			__ul_attribute__((warn_unused_result));
+extern char *mnt_resolve_target(const char *path, struct libmnt_cache *cache)
+			__ul_attribute__((warn_unused_result));
 extern char *mnt_resolve_tag(const char *token, const char *value,
 			     struct libmnt_cache *cache)
 			__ul_attribute__((warn_unused_result));
diff --git a/libmount/src/libmount.sym b/libmount/src/libmount.sym
index 088db7749434..d827c310139d 100644
--- a/libmount/src/libmount.sym
+++ b/libmount/src/libmount.sym
@@ -289,6 +289,8 @@ global:
 } MOUNT_2.23;
 
 MOUNT_2.25 {
+	mnt_cache_set_targets;
+	mnt_resolve_target;
 	mnt_table_uniq_fs;
 	mnt_tag_is_valid;
 } MOUNT_2.24;
diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 77260ab96c35..fd6a7d8e2451 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -880,8 +880,10 @@ struct libmnt_fs *mnt_table_find_mountpoint(struct libmnt_table *tb,
  *
  * Try to lookup an entry in the given tab, three iterations are possible, the first
  * with @path, the second with realpath(@path) and the third with realpath(@path)
- * against realpath(fs->target). The 2nd and 3rd iterations are not performed
- * when the @tb cache is not set (see mnt_table_set_cache()).
+ * against realpath(fs->target). The 2nd and 3rd iterations are not performed when
+ * the @tb cache is not set (see mnt_table_set_cache()). If
+ * mnt_cache_set_targets(cache, mtab) was called, the 3rd iteration skips any
+ * @fs->target found in @mtab (see mnt_resolve_target()).
  *
  * Returns: a tab entry or NULL.
  */
@@ -933,7 +935,7 @@ struct libmnt_fs *mnt_table_find_target(struct libmnt_table *tb, const char *pat
 		    || (*fs->target == '/' && *(fs->target + 1) == '\0'))
 		       continue;
 
-		p = mnt_resolve_path(fs->target, tb->cache);
+		p = mnt_resolve_target(fs->target, tb->cache);
 		/* both canonicalized, strcmp() is fine here */
 		if (p && strcmp(cn, p) == 0)
 			return fs;
-- 
2.0.1

