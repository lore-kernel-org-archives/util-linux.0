Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:52251 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758525AbcHDMvZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 4 Aug 2016 08:51:25 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 8DCEAADB1
	for <util-linux@vger.kernel.org>; Thu,  4 Aug 2016 12:51:24 +0000 (UTC)
From: Ales Novak <alnovak@suse.cz>
To: util-linux@vger.kernel.org
Cc: nfbrown@suse.com, jeffm@suse.com, Ales Novak <alnovak@suse.cz>
Subject: [PATCH] libmount: after colon, ignore double slashes in path start
Date: Thu,  4 Aug 2016 14:51:21 +0200
Message-Id: <1470315081-5953-1-git-send-email-alnovak@suse.cz>
In-Reply-To: <1469018169-5650-2-git-send-email-alnovak@suse.cz>
References: <1469018169-5650-2-git-send-email-alnovak@suse.cz>
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

This patch adds function streq_path() which compares the paths in a way
that any positive count of slashes equals to 1, and any count of
slashes at the end equals (but not if there are only slashes), i.e.:
   home//user//path == home/user/path// == home/user/path
   /mnt/home == //mnt/home == //mnt//home///

Comparison of paths in mnt_fs_streq_srcpath() was switched to use that
function.

Signed-off-by: Ales Novak <alnovak@suse.cz>
---
 include/strutils.h |  2 ++
 lib/strutils.c     | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 libmount/src/fs.c  |  2 +-
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/include/strutils.h b/include/strutils.h
index f303450..cba896a 100644
--- a/include/strutils.h
+++ b/include/strutils.h
@@ -112,6 +112,8 @@ extern int parse_range(const char *str, int *lower, int *upper, int def);
 
 extern int streq_except_trailing_slash(const char *s1, const char *s2);
 
+extern int streq_path(const char *s1, const char *s2);
+
 /*
  * Match string beginning.
  */
diff --git a/lib/strutils.c b/lib/strutils.c
index 8c47c81..3edb140 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -780,6 +780,53 @@ int streq_except_trailing_slash(const char *s1, const char *s2)
 	return equal;
 }
 
+/**
+ * Compare two paths for equality, any positive number of slashes 
+ * equals to one, i.e.:
+ *
+ * home//user//path == home/user/path// == home/user/path
+ * /mnt/home == //mnt/home == //mnt//home///
+ */
+int streq_path(const char *p1, const char *p2)
+{
+	int c1, c2;
+
+	if (!p1 && !p2)
+		return 1;
+	if (!p1 || !p2)
+		return 0;
+
+	do {
+		c1 = *p1;
+		c2 = *p2;
+
+		if (! c1 || ! c2) break;
+
+		if (c1 == '/') {
+			while (*(++p1) == '/');
+		} else p1++;
+		if (c2 == '/') {
+			while (*(++p2) == '/');
+		} else p2++;
+
+		if (c1 > c2) return 1;
+		else if (c1 < c2) return -1;
+	} while (1);
+
+	if (! c1) {
+		if (! c2) return 0;
+
+		while ((c2 = *(++p2)) == '/');
+
+		if (! c2) return 0;
+		else return 1;
+	} else {
+		while ((c1 = *(++p1)) == '/');
+
+		if (! c1) return 0;
+		else return -1;
+	}
+}
 
 char *strnappend(const char *s, const char *suffix, size_t b)
 {
diff --git a/libmount/src/fs.c b/libmount/src/fs.c
index c92b6ab..4af98c5 100644
--- a/libmount/src/fs.c
+++ b/libmount/src/fs.c
@@ -437,7 +437,7 @@ int mnt_fs_streq_srcpath(struct libmnt_fs *fs, const char *path)
 	p = mnt_fs_get_srcpath(fs);
 
 	if (!mnt_fs_is_pseudofs(fs))
-		return streq_except_trailing_slash(p, path);
+		return streq_path(p, path);
 
 	if (!p && !path)
 		return 1;
-- 
2.7.0

