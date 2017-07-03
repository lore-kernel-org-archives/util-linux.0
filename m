Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:65177 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753240AbdGCLxF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 3 Jul 2017 07:53:05 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MUUWN-1dIxeX45Yp-00RJq7 for <util-linux@vger.kernel.org>; Mon, 03 Jul 2017
 13:53:03 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/6] path: use openat()
Date: Mon,  3 Jul 2017 13:52:56 +0200
Message-Id: <1499082781-16968-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1499082781-16968-1-git-send-email-sweet_f_a@gmx.de>
References: <1499082781-16968-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

path_vcreate_with_prefix() is going to be removed.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 lib/path.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 96 insertions(+), 15 deletions(-)

diff --git a/lib/path.c b/lib/path.c
index 79c1e7a..94181fe 100644
--- a/lib/path.c
+++ b/lib/path.c
@@ -26,18 +26,60 @@
 #include <stdio.h>
 #include <inttypes.h>
 #include <errno.h>
+#include <sys/stat.h>
 
 #include "all-io.h"
 #include "path.h"
 #include "nls.h"
 #include "c.h"
 
+static int rootfd = -1;
 static size_t prefixlen;
+static char pathbuf_prefix[PATH_MAX];
 static char pathbuf[PATH_MAX];
 
+/* It's a programming error if they try us to use with relative paths. */
+#define PATH_REQUIRE_ABSOLUTE(path) \
+	assert( !path || *path == '/' )
+
+static inline const char *
+path_relative_if_sysroot(const char *p)
+{
+	/* Convert to relative path if we have a prefix (sysroot). Otherwise
+	 * openat() functions would ignore the dirfd. */
+	if(p && rootfd >= 0)
+		while(*p && *p == '/') ++p;
+	return p;
+}
+
 static const char *
 path_vcreate(const char *path, va_list ap)
 {
+	const char * p = pathbuf;
+	int rc = vsnprintf(
+		pathbuf, sizeof(pathbuf), path, ap);
+
+	if (rc < 0)
+		goto err;
+	if ((size_t)rc >= sizeof(pathbuf)) {
+		errno = ENAMETOOLONG;
+		goto err;
+	}
+
+	PATH_REQUIRE_ABSOLUTE(p);
+	p = path_relative_if_sysroot(p);
+
+	return p;
+err:
+	/* Only for error messages when we could not construct a path. */
+	strcpy(pathbuf, "path");
+	return NULL;
+}
+
+static const char *
+path_vcreate_with_prefix(const char *path, va_list ap)
+{
+	strcpy(pathbuf, pathbuf_prefix);
 	int rc = vsnprintf(
 		pathbuf + prefixlen, sizeof(pathbuf) - prefixlen, path, ap);
 
@@ -55,30 +97,60 @@ path_get(const char *path, ...)
 {
 	const char *p;
 	va_list ap;
+	static char userbuf[sizeof(pathbuf)];
 
 	va_start(ap, path);
-	p = path_vcreate(path, ap);
+	p = path_vcreate_with_prefix(path, ap);
 	va_end(ap);
 
+	if (p) {
+		/* do not hand out our global buffer to the user to avoid overlapping
+		 * problems in case we get this string back from the user */
+		p = strcpy(userbuf, p);
+	}
+
 	return p;
 }
 
+/* Get the last used path. Only for error messages. */
+static const char *
+path_last_path(void)
+{
+	if (rootfd < 0) {
+		return pathbuf;
+	} else {
+		char prfx[] = "[sysroot]/"; /* we could also add the real prefix */
+		size_t n = sizeof(prfx) - 1 ;
+		memmove(pathbuf+n, pathbuf, sizeof(pathbuf)-n);
+		pathbuf[sizeof(pathbuf)-1] = '\0';
+		strncpy(pathbuf, prfx, n);
+		return pathbuf;
+	}
+}
+
 static FILE *
 path_vfopen(const char *mode, int exit_on_error, const char *path, va_list ap)
 {
+	int fd;
 	FILE *f;
 	const char *p = path_vcreate(path, ap);
 	if (!p)
 		goto err;
 
-	f = fopen(p, mode);
-	if (!f)
+	fd = openat(rootfd, p, O_RDONLY);
+	if (fd == -1)
+		goto err;
+
+	f = fdopen(fd, mode);
+	if (!f) {
+		close(fd);
 		goto err;
+	}
 
 	return f;
 err:
 	if (exit_on_error)
-		err(EXIT_FAILURE, _("cannot open %s"), p ? p : "path");
+		err(EXIT_FAILURE, _("cannot open %s"), path_last_path());
 	return NULL;
 }
 
@@ -90,13 +162,13 @@ path_vopen(int flags, const char *path, va_list ap)
 	if (!p)
 		goto err;
 
-	fd = open(p, flags);
+	fd = openat(rootfd, p, flags);
 	if (fd == -1)
 		goto err;
 
 	return fd;
 err:
-	err(EXIT_FAILURE, _("cannot open %s"), p ? p : "path");
+	err(EXIT_FAILURE, _("cannot open %s"), path_last_path());
 }
 
 FILE *
@@ -123,7 +195,7 @@ path_read_str(char *result, size_t len, const char *path, ...)
 	va_end(ap);
 
 	if (!fgets(result, len, fd))
-		err(EXIT_FAILURE, _("cannot read %s"), pathbuf);
+		err(EXIT_FAILURE, _("cannot read %s"), path_last_path());
 	fclose(fd);
 
 	len = strlen(result);
@@ -144,9 +216,9 @@ path_read_s32(const char *path, ...)
 
 	if (fscanf(fd, "%d", &result) != 1) {
 		if (ferror(fd))
-			err(EXIT_FAILURE, _("cannot read %s"), pathbuf);
+			err(EXIT_FAILURE, _("cannot read %s"), path_last_path());
 		else
-			errx(EXIT_FAILURE, _("parse error: %s"), pathbuf);
+			errx(EXIT_FAILURE, _("parse error: %s"), path_last_path());
 	}
 	fclose(fd);
 	return result;
@@ -165,9 +237,9 @@ path_read_u64(const char *path, ...)
 
 	if (fscanf(fd, "%"SCNu64, &result) != 1) {
 		if (ferror(fd))
-			err(EXIT_FAILURE, _("cannot read %s"), pathbuf);
+			err(EXIT_FAILURE, _("cannot read %s"), path_last_path());
 		else
-			errx(EXIT_FAILURE, _("parse error: %s"), pathbuf);
+			errx(EXIT_FAILURE, _("parse error: %s"), path_last_path());
 	}
 	fclose(fd);
 	return result;
@@ -197,7 +269,7 @@ path_exist(const char *path, ...)
 	p = path_vcreate(path, ap);
 	va_end(ap);
 
-	return p && access(p, F_OK) == 0;
+	return p && faccessat(rootfd, p, F_OK, 0) == 0;
 }
 
 #ifdef HAVE_CPU_SET_T
@@ -213,7 +285,7 @@ path_cpuparse(int maxcpus, int islist, const char *path, va_list ap)
 	fd = path_vfopen("r" UL_CLOEXECSTR, 1, path, ap);
 
 	if (!fgets(buf, len, fd))
-		err(EXIT_FAILURE, _("cannot read %s"), pathbuf);
+		err(EXIT_FAILURE, _("cannot read %s"), path_last_path());
 	fclose(fd);
 
 	len = strlen(buf);
@@ -265,12 +337,21 @@ path_set_prefix(const char *prefix)
 {
 	size_t len = strlen(prefix);
 
-	if (len >= sizeof(pathbuf) - 1) {
+	/* ignore trivial prefix */
+	if (len == 0)
+		return 0;
+
+	if (len >= sizeof(pathbuf_prefix) - 1) {
 		errno = ENAMETOOLONG;
 		return -1;
 	}
+
+	rootfd = open(prefix, O_RDONLY|O_DIRECTORY|O_CLOEXEC);
+	if (rootfd < 0)
+		return -1;
+
 	prefixlen = len;
-	strcpy(pathbuf, prefix);
+	strcpy(pathbuf_prefix, prefix);
 	return 0;
 }
 
-- 
1.8.5.6

