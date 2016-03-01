Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:53352 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636AbcCALoT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 1 Mar 2016 06:44:19 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0M7m0a-1ZfTKi1zG4-00vP1G for
 <util-linux@vger.kernel.org>; Tue, 01 Mar 2016 12:44:16 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/4] lib: move fopen_at() to fileutils.h, remove at.h
Date: Tue,  1 Mar 2016 12:44:12 +0100
Message-Id: <1456832654-11268-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456832654-11268-1-git-send-email-sweet_f_a@gmx.de>
References: <1456832654-11268-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 include/Makemodule.am    |  1 -
 include/at.h             | 22 ----------------------
 include/fileutils.h      | 10 ++++++++++
 lib/Makemodule.am        |  3 +--
 lib/at.c                 | 25 -------------------------
 lib/procutils.c          |  2 +-
 libmount/src/tab_parse.c |  2 +-
 7 files changed, 13 insertions(+), 52 deletions(-)
 delete mode 100644 include/at.h
 delete mode 100644 lib/at.c

diff --git a/include/Makemodule.am b/include/Makemodule.am
index 0a41a94..5cdf29a 100644
--- a/include/Makemodule.am
+++ b/include/Makemodule.am
@@ -1,7 +1,6 @@
 
 dist_noinst_HEADERS += \
 	include/all-io.h \
-	include/at.h \
 	include/bitops.h \
 	include/blkdev.h \
 	include/canonicalize.h \
diff --git a/include/at.h b/include/at.h
deleted file mode 100644
index a1c6a8b..0000000
--- a/include/at.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * wrappers for "at" functions.
- *
- * Copyright (C) 2010 Karel Zak <kzak@redhat.com>
- *
- * This file may be redistributed under the terms of the
- * GNU Lesser General Public License.
- */
-#ifndef UTIL_LINUX_AT_H
-#define UTIL_LINUX_AT_H
-
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-
-#include "c.h"
-
-extern FILE *fopen_at(int dir, const char *filename,
-			int flags, const char *mode);
-
-#endif /* UTIL_LINUX_AT_H */
diff --git a/include/fileutils.h b/include/fileutils.h
index ba8da7f..e016f99 100644
--- a/include/fileutils.h
+++ b/include/fileutils.h
@@ -26,6 +26,16 @@ static inline FILE *xfmkstemp(char **tmpname, const char *dir, const char *prefi
 	return ret;
 }
 
+static inline FILE *fopen_at(int dir, const char *filename,
+                             int flags, const char *mode)
+{
+	int fd = openat(dir, filename, flags);
+	if (fd < 0)
+		return NULL;
+
+	return fdopen(fd, mode);
+}
+
 static inline int is_same_inode(const int fd, const struct stat *st)
 {
 	struct stat f;
diff --git a/lib/Makemodule.am b/lib/Makemodule.am
index 25e1ba0..81504b9 100644
--- a/lib/Makemodule.am
+++ b/lib/Makemodule.am
@@ -2,7 +2,6 @@
 noinst_LTLIBRARIES += libcommon.la
 libcommon_la_CFLAGS = $(AM_CFLAGS)
 libcommon_la_SOURCES = \
-	lib/at.c \
 	lib/blkdev.c \
 	lib/canonicalize.c \
 	lib/crc32.c \
@@ -100,7 +99,7 @@ test_colors_LDADD = $(LDADD) $(TINFO_LIBS)
 test_randutils_SOURCES = lib/randutils.c
 test_randutils_CFLAGS = $(AM_CFLAGS) -DTEST_PROGRAM
 
-test_procutils_SOURCES = lib/procutils.c lib/at.c
+test_procutils_SOURCES = lib/procutils.c
 test_procutils_CFLAGS = $(AM_CFLAGS) -DTEST_PROGRAM
 
 if LINUX
diff --git a/lib/at.c b/lib/at.c
deleted file mode 100644
index 438b865..0000000
--- a/lib/at.c
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * Portable xxxat() functions.
- *
- * No copyright is claimed.  This code is in the public domain; do with
- * it what you wish.
- *
- * Written by Karel Zak <kzak@redhat.com>
- */
-#include <stdio.h>
-#include <fcntl.h>
-
-#include "at.h"
-#include "c.h"
-
-FILE *fopen_at(int dir, const char *filename, int flags,
-			const char *mode)
-{
-	int fd = openat(dir, filename, flags);
-
-	if (fd < 0)
-		return NULL;
-
-	return fdopen(fd, mode);
-}
-
diff --git a/lib/procutils.c b/lib/procutils.c
index 6f01634..16d1897 100644
--- a/lib/procutils.c
+++ b/lib/procutils.c
@@ -24,7 +24,7 @@
 #include <ctype.h>
 
 #include "procutils.h"
-#include "at.h"
+#include "fileutils.h"
 #include "all-io.h"
 #include "c.h"
 
diff --git a/libmount/src/tab_parse.c b/libmount/src/tab_parse.c
index 9536ebe..cee7008 100644
--- a/libmount/src/tab_parse.c
+++ b/libmount/src/tab_parse.c
@@ -17,7 +17,7 @@
 #include <fcntl.h>
 #include <sys/stat.h>
 
-#include "at.h"
+#include "fileutils.h"
 #include "mangle.h"
 #include "mountP.h"
 #include "pathnames.h"
-- 
1.8.4.5

