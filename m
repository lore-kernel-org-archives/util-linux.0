Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:61235 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349Ab2JNUVg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:21:36 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2680285wey.19
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:21:36 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 14/19] include/usleep: remove remaining references to usleep
Date: Sun, 14 Oct 2012 21:21:05 +0100
Message-Id: <1350246070-10544-15-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

POSIX.1-2001 declares usleep is obsolete.

Reference: http://pubs.opengroup.org/onlinepubs/009695399/functions/usleep.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac             |  1 -
 include/Makemodule.am    |  1 -
 include/usleep.h         | 18 ------------------
 mount-deprecated/fstab.c |  1 -
 4 files changed, 21 deletions(-)
 delete mode 100644 include/usleep.h

diff --git a/configure.ac b/configure.ac
index 9d2f589..d94f271 100644
--- a/configure.ac
+++ b/configure.ac
@@ -326,7 +326,6 @@ AC_CHECK_FUNCS([ \
 	strtoull \
 	sysconf \
 	updwtmp \
-	usleep \
 	warn \
 	warnx \
 ])
diff --git a/include/Makemodule.am b/include/Makemodule.am
index 9f9b78e..bef118f 100644
--- a/include/Makemodule.am
+++ b/include/Makemodule.am
@@ -38,7 +38,6 @@ dist_noinst_HEADERS += \
 	include/sysfs.h \
 	include/tt.h \
 	include/ttyutils.h \
-	include/usleep.h \
 	include/wholedisk.h \
 	include/widechar.h \
 	include/xalloc.h \
diff --git a/include/usleep.h b/include/usleep.h
deleted file mode 100644
index f64477c..0000000
--- a/include/usleep.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#ifndef UTIL_LINUX_USLEEP_H
-#define UTIL_LINUX_USLEEP_H
-
-#ifndef HAVE_USLEEP
-/*
- * This function is marked obsolete in POSIX.1-2001 and removed in
- * POSIX.1-2008. It is replaced with nanosleep().
- */
-# define usleep(x) \
-	do { \
-		struct timespec xsleep; \
-		xsleep.tv_sec = x / 1000 / 1000; \
-		xsleep.tv_nsec = (x - xsleep.tv_sec * 1000 * 1000) * 1000; \
-		nanosleep(&xsleep, NULL); \
-	} while (0)
-#endif
-
-#endif /* UTIL_LINUX_USLEEP_H */
diff --git a/mount-deprecated/fstab.c b/mount-deprecated/fstab.c
index 47159a3..18ae909 100644
--- a/mount-deprecated/fstab.c
+++ b/mount-deprecated/fstab.c
@@ -19,7 +19,6 @@
 #include "fsprobe.h"
 #include "pathnames.h"
 #include "nls.h"
-#include "usleep.h"
 #include "strutils.h"
 
 #define streq(s, t)	(strcmp ((s), (t)) == 0)
-- 
1.7.12.2

