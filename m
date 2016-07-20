Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:49349 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728AbcGTMgX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 20 Jul 2016 08:36:23 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id BD4BCAD61
	for <util-linux@vger.kernel.org>; Wed, 20 Jul 2016 12:36:21 +0000 (UTC)
From: Ales Novak <alnovak@suse.cz>
To: util-linux@vger.kernel.org
Cc: nfbrown@suse.com, jeffm@suse.com, Ales Novak <alnovak@suse.cz>
Subject: [PATCH] libmount: after colon, ignore double slashes in path start
Date: Wed, 20 Jul 2016 14:36:09 +0200
Message-Id: <1469018169-5650-2-git-send-email-alnovak@suse.cz>
In-Reply-To: <1469018169-5650-1-git-send-email-alnovak@suse.cz>
References: <1469018169-5650-1-git-send-email-alnovak@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

With NFSv4, the path appearing in /proc/mounts may further differ from
the one for which it was asked (say in /etc/fstab) and /run/mount/utab.
That causes problems at least for applying userspace-stored flags (like
"user").

server exports | client mounts | /proc/mounts | utab        | ->
               |               |              |             |
/tmp           | euler://tmp   | euler:/tmp   | euler://tmp | ERR
               | euler:/tmp    | euler:/tmp   | euler:/tmp  | OK
               |               |              |             |
/              | euler://tmp   | euler://tmp  | euler://tmp | OK
               | euler:/tmp    | euler://tmp  | euler:/tmp  | ERR

It surely would be better if kernel was behaving differently, yet after
discussing that with NFS people it sounds unlikely to be fixed in the
near future.

This patch modifies path comparison to treat paths as identical, if they
contain ':' and directly after it one has / and the other // - and the
rest is the same, except for the trailing slashes.

Signed-off-by: Ales Novak <alnovak@suse.cz>
---
 include/strutils.h |  1 +
 lib/strutils.c     | 36 ++++++++++++++++++++++++++++++++++++
 libmount/src/fs.c  |  2 +-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/include/strutils.h b/include/strutils.h
index f303450..c9b4ab4 100644
--- a/include/strutils.h
+++ b/include/strutils.h
@@ -112,6 +112,7 @@ extern int parse_range(const char *str, int *lower, int *upper, int def);
 
 extern int streq_except_trailing_slash(const char *s1, const char *s2);
 
+extern int streq_except_redundant_slashes(const char *s1, const char *s2);
 /*
  * Match string beginning.
  */
diff --git a/lib/strutils.c b/lib/strutils.c
index 8c47c81..a2ac70c 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -780,6 +780,42 @@ int streq_except_trailing_slash(const char *s1, const char *s2)
 	return equal;
 }
 
+/*
+ * Compare two strings for equality, ignoring at most one trailing
+ * slash, and furthermore if there are double slashes right after
+ * the ':' in the string, it ignores them. That is, these strings
+ * are equal:
+ *   host:/path
+ *   host://path
+ *   host:/path/
+ *   host://path/
+ */
+int streq_except_redundant_slashes(const char *s1, const char *s2)
+{
+	const char *l1, *l2;
+
+	if (!s1 && !s2)
+		return 1;
+	if (!s1 || !s2)
+		return 0;
+
+	if ((l1 = strchr(s1, ':'))
+		&& (l2 = strchr(s2, ':'))
+		&& ((l1 - s1) == (l2 - s2))) {
+
+		if (strncmp(s1, s2, l1 - s1))
+			return 0;
+
+		l1++;
+		l2++;
+
+		if (*l1 == '/' && *(l1+1) == '/') l1++;
+		if (*l2 == '/' && *(l2+1) == '/') l2++;
+
+		return (streq_except_trailing_slash(l1, l2));
+	} else
+		return (streq_except_trailing_slash(s1, s2));
+}
 
 char *strnappend(const char *s, const char *suffix, size_t b)
 {
diff --git a/libmount/src/fs.c b/libmount/src/fs.c
index 9cb3293..1352481 100644
--- a/libmount/src/fs.c
+++ b/libmount/src/fs.c
@@ -437,7 +437,7 @@ int mnt_fs_streq_srcpath(struct libmnt_fs *fs, const char *path)
 	p = mnt_fs_get_srcpath(fs);
 
 	if (!mnt_fs_is_pseudofs(fs))
-		return streq_except_trailing_slash(p, path);
+		return streq_except_redundant_slashes(p, path);
 
 	if (!p && !path)
 		return 1;
-- 
2.7.0

