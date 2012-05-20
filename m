Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:60813 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315Ab2ETAjY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 19 May 2012 20:39:24 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 3/3] libmount/utils: Use binary search to compare pseudofs
Date: Sat, 19 May 2012 20:39:21 -0400
Message-Id: <1337474361-22429-3-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1337474361-22429-1-git-send-email-dreisner@archlinux.org>
References: <1337474361-22429-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

While we're at it, expand this list of known pseudofs types.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 libmount/src/utils.c |   68 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 25 deletions(-)

diff --git a/libmount/src/utils.c b/libmount/src/utils.c
index b824edc..77557f2 100644
--- a/libmount/src/utils.c
+++ b/libmount/src/utils.c
@@ -72,6 +72,15 @@ int mnt_parse_offset(const char *str, size_t len, uintmax_t *res)
 	return rc;
 }
 
+/* used as a callback by bsearch in mnt_fstype_is_pseudofs() */
+static int fstype_cmp(const void *v1, const void *v2)
+{
+	const char *s1 = *(const char **)v1;
+	const char *s2 = *(const char **)v2;
+
+	return strcmp(s1, s2);
+}
+
 /* returns basename and keeps dirname in the @path, if @path is "/" (root)
  * then returns empty string */
 static char *stripoff_last_component(char *path)
@@ -214,31 +223,40 @@ char *mnt_unmangle(const char *str)
  */
 int mnt_fstype_is_pseudofs(const char *type)
 {
-	if (!type)
-		return 0;
-	if (strcmp(type, "none")  == 0 ||
-	    strcmp(type, "proc")  == 0 ||
-	    strcmp(type, "tmpfs") == 0 ||
-	    strcmp(type, "sysfs") == 0 ||
-	    strcmp(type, "autofs") == 0 ||
-	    strcmp(type, "devpts") == 0||
-	    strcmp(type, "cgroup") == 0 ||
-	    strcmp(type, "devtmpfs") == 0 ||
-	    strcmp(type, "devfs") == 0 ||
-	    strcmp(type, "dlmfs") == 0 ||
-	    strcmp(type, "cpuset") == 0 ||
-	    strcmp(type, "configfs") == 0 ||
-	    strcmp(type, "securityfs") == 0 ||
-	    strcmp(type, "hugetlbfs") == 0 ||
-	    strcmp(type, "rpc_pipefs") == 0 ||
-	    strcmp(type, "fusectl") == 0 ||
-	    strcmp(type, "mqueue") == 0 ||
-	    strcmp(type, "binfmt_misc") == 0 ||
-	    strcmp(type, "fuse.gvfs-fuse-daemon") == 0 ||
-	    strcmp(type, "debugfs") == 0 ||
-	    strcmp(type, "spufs") == 0)
-		return 1;
-	return 0;
+	static const char *pseudofs[] = {
+		"anon_inodefs",
+		"autofs",
+		"bdev",
+		"binfmt_misc",
+		"cgroup",
+		"configfs",
+		"cpuset",
+		"debugfs",
+		"devfs",
+		"devpts",
+		"devtmpfs",
+		"dlmfs",
+		"fuse.gvfs-fuse-daemon",
+		"fusectl",
+		"hugetlbfs",
+		"mqueue",
+		"nfsd",
+		"none",
+		"pipefs",
+		"proc",
+		"pstore",
+		"ramfs",
+		"rootfs",
+		"rpc_pipefs",
+		"securityfs",
+		"sockfs",
+		"spufs",
+		"sysfs",
+		"tmpfs"
+	};
+
+	return !(bsearch(&type, pseudofs, ARRAY_SIZE(pseudofs),
+				sizeof(char*), fstype_cmp) == NULL);
 }
 
 /**
-- 
1.7.10.2

