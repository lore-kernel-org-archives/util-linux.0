Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:55548 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753089AbcBZDIm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 25 Feb 2016 22:08:42 -0500
Received: from tenfore.ga-group.nl ([95.114.239.233]) by mail.gmx.com
 (mrgmx003) with ESMTPSA (Nemesis) id 0Lymoh-1ZtT6F0Km7-016AGG for
 <util-linux@vger.kernel.org>; Fri, 26 Feb 2016 04:08:40 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 12/14] lib: provide mkostemp fallback function
Date: Fri, 26 Feb 2016 04:08:36 +0100
Message-Id: <1456456118-19584-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456456118-19584-1-git-send-email-sweet_f_a@gmx.de>
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
 <1456456118-19584-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

It's missing on OSX.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac        |  1 +
 include/fileutils.h |  4 ++++
 lib/fileutils.c     | 27 +++++++++++++++++++++++++++
 libblkid/src/save.c |  1 +
 4 files changed, 33 insertions(+)

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
index ba8da7f..7c5594e 100644
--- a/include/fileutils.h
+++ b/include/fileutils.h
@@ -8,6 +8,10 @@
 
 #include "c.h"
 
+#ifndef HAVE_MKOSTEMP
+extern int mkostemp(char *template, int flags);
+#endif
+
 extern int xmkstemp(char **tmpname, const char *dir, const char *prefix);
 
 static inline FILE *xfmkstemp(char **tmpname, const char *dir, const char *prefix)
diff --git a/lib/fileutils.c b/lib/fileutils.c
index bf8e60a..05a8c02 100644
--- a/lib/fileutils.c
+++ b/lib/fileutils.c
@@ -13,6 +13,33 @@
 #include "fileutils.h"
 #include "pathnames.h"
 
+#ifndef HAVE_MKOSTEMP
+int mkostemp(char *template, int flags)
+{
+	int fd, old_flags, errno_save;
+
+	fd = mkstemp(template);
+	if (fd < 0)
+		return fd;
+
+	old_flags = fcntl(fd, F_GETFD);
+	if (old_flags < 0)
+		goto unwind;
+	if (fcntl(fd, F_SETFD, old_flags | flags) < 0)
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
+}
+#endif
+
 /* Create open temporary file in safe way.  Please notice that the
  * file permissions are -rw------- by default. */
 int xmkstemp(char **tmpname, const char *dir, const char *prefix)
diff --git a/libblkid/src/save.c b/libblkid/src/save.c
index 5e8bbee..b9f447a 100644
--- a/libblkid/src/save.c
+++ b/libblkid/src/save.c
@@ -23,6 +23,7 @@
 #endif
 
 #include "closestream.h"
+#include "fileutils.h"
 
 #include "blkidP.h"
 
-- 
1.8.4.5

