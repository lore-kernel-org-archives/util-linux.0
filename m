Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:53323 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756710AbcB0UCd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 27 Feb 2016 15:02:33 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Subject: [PATCH v2 12/14] lib: provide fallback if mkostemp(3) missing
Date: Sat, 27 Feb 2016 21:02:28 +0100
Message-Id: <1456603348-4940-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456456118-19584-3-git-send-email-sweet_f_a@gmx.de>
References: <1456456118-19584-3-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

It's missing on OSX.

CC: Yuriy M. Kaminskiy <yumkam@gmail.com>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac        |  1 +
 include/fileutils.h |  2 ++
 lib/fileutils.c     | 31 ++++++++++++++++++++++++++++++-
 libblkid/src/save.c |  3 ++-
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 727a875..64a16ff 100644
--- a/configure.ac
+++ b/configure.ac
@@ -368,6 +368,7 @@ AC_CHECK_FUNCS([ \
 	llseek \
 	lseek64 \
 	mempcpy \
+	mkostemp \
 	nanosleep \
 	ntp_gettime \
 	personality \
diff --git a/include/fileutils.h b/include/fileutils.h
index ba8da7f..79dd012 100644
--- a/include/fileutils.h
+++ b/include/fileutils.h
@@ -8,6 +8,8 @@
 
 #include "c.h"
 
+extern int mkstemp_cloexec(char *template);
+
 extern int xmkstemp(char **tmpname, const char *dir, const char *prefix);
 
 static inline FILE *xfmkstemp(char **tmpname, const char *dir, const char *prefix)
diff --git a/lib/fileutils.c b/lib/fileutils.c
index bf8e60a..15cc925 100644
--- a/lib/fileutils.c
+++ b/lib/fileutils.c
@@ -13,6 +13,35 @@
 #include "fileutils.h"
 #include "pathnames.h"
 
+int mkstemp_cloexec(char *template)
+{
+#ifdef HAVE_MKOSTEMP
+	return mkostemp(template, O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC);
+#else
+	int fd, old_flags, errno_save;
+
+	fd = mkstemp(template);
+	if (fd < 0)
+		return fd;
+
+	old_flags = fcntl(fd, F_GETFD, 0);
+	if (old_flags < 0)
+		goto unwind;
+	if (fcntl(fd, F_SETFD, old_flags | O_CLOEXEC) < 0)
+		goto unwind;
+
+	return fd;
+
+unwind:
+	errno_save = errno;
+	unlink(template);
+	close(fd);
+	errno = errno_save;
+
+	return -1;
+#endif
+}
+
 /* Create open temporary file in safe way.  Please notice that the
  * file permissions are -rw------- by default. */
 int xmkstemp(char **tmpname, const char *dir, const char *prefix)
@@ -33,7 +62,7 @@ int xmkstemp(char **tmpname, const char *dir, const char *prefix)
 		return -1;
 
 	old_mode = umask(077);
-	fd = mkostemp(localtmp, O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC);
+	fd = mkstemp_cloexec(localtmp);
 	umask(old_mode);
 	if (fd == -1) {
 		free(localtmp);
diff --git a/libblkid/src/save.c b/libblkid/src/save.c
index 5e8bbee..3070530 100644
--- a/libblkid/src/save.c
+++ b/libblkid/src/save.c
@@ -23,6 +23,7 @@
 #endif
 
 #include "closestream.h"
+#include "fileutils.h"
 
 #include "blkidP.h"
 
@@ -133,7 +134,7 @@ int blkid_flush_cache(blkid_cache cache)
 		tmp = malloc(strlen(filename) + 8);
 		if (tmp) {
 			sprintf(tmp, "%s-XXXXXX", filename);
-			fd = mkostemp(tmp, O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC);
+			fd = mkstemp_cloexec(tmp);
 			if (fd >= 0) {
 				if (fchmod(fd, 0644) != 0)
 					DBG(SAVE, ul_debug("%s: fchmod failed", filename));
-- 
1.9.1

