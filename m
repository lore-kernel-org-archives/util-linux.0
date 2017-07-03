Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:60396 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753689AbdGCLxF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 3 Jul 2017 07:53:05 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Mh5h7-1d6KK60aun-00MNtZ for <util-linux@vger.kernel.org>; Mon, 03 Jul 2017
 13:53:03 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/6] path: add some standard functions
Date: Mon,  3 Jul 2017 13:52:57 +0200
Message-Id: <1499082781-16968-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1499082781-16968-1-git-send-email-sweet_f_a@gmx.de>
References: <1499082781-16968-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 include/path.h | 15 +++++++++++++++
 lib/path.c     | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/include/path.h b/include/path.h
index ae36d7f..30c1133 100644
--- a/include/path.h
+++ b/include/path.h
@@ -3,6 +3,11 @@
 
 #include <stdio.h>
 #include <stdint.h>
+#include <dirent.h>
+
+/* Check your code: Absolute paths must be used with path_* functions! */
+#define PATH_REQUIRE_RELATIVE(path) \
+	assert( *path != '/' )
 
 /* Returns a pointer to a static buffer which may be destroyed by any later
 path_* function call. NULL means error and errno will be set. */
@@ -23,6 +28,16 @@ extern uint64_t path_read_u64(const char *path, ...)
 extern int path_exist(const char *path, ...)
 		      __attribute__ ((__format__ (__printf__, 1, 2)));
 
+extern int path_stat(const char *pathname, struct stat *buf);
+extern int path_open(const char *pathname, int flags);
+extern FILE *path_fopenP(const char *path, const char *mode);
+extern size_t path_readlink(const char *pathname, char *buf, size_t bufsiz);
+extern DIR *path_opendir(const char *dirname);
+extern int path_scandir(const char *dir, struct dirent ***namelist,
+	int (*sel)(const struct dirent *),
+	int (*compar)(const struct dirent **, const struct dirent **));
+
+
 #ifdef HAVE_CPU_SET_T
 # include "cpuset.h"
 
diff --git a/lib/path.c b/lib/path.c
index 94181fe..c286709 100644
--- a/lib/path.c
+++ b/lib/path.c
@@ -27,6 +27,7 @@
 #include <inttypes.h>
 #include <errno.h>
 #include <sys/stat.h>
+#include <dirent.h>
 
 #include "all-io.h"
 #include "path.h"
@@ -272,6 +273,56 @@ path_exist(const char *path, ...)
 	return p && faccessat(rootfd, p, F_OK, 0) == 0;
 }
 
+int
+path_stat(const char *p, struct stat *buf)
+{
+	PATH_REQUIRE_ABSOLUTE(p);
+	p = path_relative_if_sysroot(p);
+	return fstatat(rootfd, p, buf, 0);
+}
+
+int
+path_open(const char *p, int flags)
+{
+	PATH_REQUIRE_ABSOLUTE(p);
+	p = path_relative_if_sysroot(p);
+	return openat(rootfd, p, flags);
+}
+
+FILE*
+path_fopenP(const char *path, const char *mode)
+{
+	return path_fopen(mode, 0, path);
+}
+
+size_t
+path_readlink(const char *p, char *buf, size_t bufsiz)
+{
+	PATH_REQUIRE_ABSOLUTE(p);
+	p = path_relative_if_sysroot(p);
+	return readlinkat(rootfd, p, buf, bufsiz);
+}
+
+DIR *
+path_opendir(const char *dirname)
+{
+	int fd = path_open(dirname, O_RDONLY|O_CLOEXEC|O_DIRECTORY);
+	if (fd < 0) {
+		return NULL;
+	}
+	return fdopendir(fd);
+}
+
+int
+path_scandir(const char *p, struct dirent ***namelist,
+	int (*sel)(const struct dirent *),
+	int (*compar)(const struct dirent **, const struct dirent **))
+{
+	PATH_REQUIRE_ABSOLUTE(p);
+	p = path_relative_if_sysroot(p);
+	return scandirat(rootfd, p, namelist, sel, compar);
+}
+
 #ifdef HAVE_CPU_SET_T
 
 static cpu_set_t *
-- 
1.8.5.6

