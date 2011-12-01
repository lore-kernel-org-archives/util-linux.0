Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60176 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555Ab1LAWK3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 1 Dec 2011 17:10:29 -0500
Received: by eaak14 with SMTP id k14so2703091eaa.19
        for <util-linux@vger.kernel.org>; Thu, 01 Dec 2011 14:10:28 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/2] build-sys: check HAVE_ definitions with #ifdef [smatch scan]
Date: Thu,  1 Dec 2011 23:10:21 +0100
Message-Id: <1322777421-11541-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1322777421-11541-1-git-send-email-kerolasa@iki.fi>
References: <1322777421-11541-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fix to `warning: undefined preprocessor identifier' messages.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/blkdev.h       |    2 +-
 include/md5.h          |    2 +-
 lib/env.c              |    2 +-
 lib/ismounted.c        |    2 +-
 libblkid/src/cache.c   |    2 +-
 libblkid/src/devname.c |    8 ++++----
 libblkid/src/devno.c   |   10 +++++-----
 libblkid/src/llseek.c  |    6 +++---
 libblkid/src/read.c    |    4 ++--
 libblkid/src/resolve.c |    2 +-
 libblkid/src/version.c |    2 +-
 misc-utils/cal.c       |    2 +-
 term-utils/script.c    |   10 +++++++---
 13 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/include/blkdev.h b/include/blkdev.h
index 3ce8111..1e7409d 100644
--- a/include/blkdev.h
+++ b/include/blkdev.h
@@ -9,7 +9,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 
-#if HAVE_SYS_MKDEV_H
+#ifdef HAVE_SYS_MKDEV_H
 # include <sys/mkdev.h>		/* major and minor on Solaris */
 #endif
 
diff --git a/include/md5.h b/include/md5.h
index 1222cf0..d997e37 100644
--- a/include/md5.h
+++ b/include/md5.h
@@ -1,7 +1,7 @@
 #ifndef MD5_H
 #define MD5_H
 
-#if HAVE_STDINT_H
+#ifdef HAVE_STDINT_H
 #include <stdint.h>
 #else
 typedef unsigned int uint32_t;
diff --git a/lib/env.c b/lib/env.c
index 770cadf..e6d119f 100644
--- a/lib/env.c
+++ b/lib/env.c
@@ -89,7 +89,7 @@ char *safe_getenv(const char *arg)
 
 	if (ruid != 0 || (ruid != geteuid()) || (getgid() != getegid()))
 		return NULL;
-#if HAVE_PRCTL
+#ifdef HAVE_PRCTL
 	if (prctl(PR_GET_DUMPABLE, 0, 0, 0, 0) == 0)
 		return NULL;
 #else
diff --git a/lib/ismounted.c b/lib/ismounted.c
index f19d67b..273a7d9 100644
--- a/lib/ismounted.c
+++ b/lib/ismounted.c
@@ -11,7 +11,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <fcntl.h>
-#if HAVE_MNTENT_H
+#ifdef HAVE_MNTENT_H
 #include <mntent.h>
 #endif
 #include <string.h>
diff --git a/libblkid/src/cache.c b/libblkid/src/cache.c
index 6ef22a1..c100cfa 100644
--- a/libblkid/src/cache.c
+++ b/libblkid/src/cache.c
@@ -10,7 +10,7 @@
  * %End-Header%
  */
 
-#if HAVE_UNISTD_H
+#ifdef HAVE_UNISTD_H
 #include <unistd.h>
 #endif
 #ifdef HAVE_ERRNO_H
diff --git a/libblkid/src/devname.c b/libblkid/src/devname.c
index 42a8c19..12cd93a 100644
--- a/libblkid/src/devname.c
+++ b/libblkid/src/devname.c
@@ -16,20 +16,20 @@
 #include <stdio.h>
 #include <string.h>
 #include <limits.h>
-#if HAVE_UNISTD_H
+#ifdef HAVE_UNISTD_H
 #include <unistd.h>
 #endif
 #include <stdlib.h>
 #include <ctype.h>
 #include <fcntl.h>
-#if HAVE_SYS_TYPES_H
+#ifdef HAVE_SYS_TYPES_H
 #include <sys/types.h>
 #endif
 #include <dirent.h>
-#if HAVE_SYS_STAT_H
+#ifdef HAVE_SYS_STAT_H
 #include <sys/stat.h>
 #endif
-#if HAVE_ERRNO_H
+#ifdef HAVE_ERRNO_H
 #include <errno.h>
 #endif
 #include <time.h>
diff --git a/libblkid/src/devno.c b/libblkid/src/devno.c
index 92ed7c0..b2a8be5 100644
--- a/libblkid/src/devno.c
+++ b/libblkid/src/devno.c
@@ -12,21 +12,21 @@
 
 #include <stdio.h>
 #include <string.h>
-#if HAVE_UNISTD_H
+#ifdef HAVE_UNISTD_H
 #include <unistd.h>
 #endif
 #include <stdlib.h>
-#if HAVE_SYS_TYPES_H
+#ifdef HAVE_SYS_TYPES_H
 #include <sys/types.h>
 #endif
-#if HAVE_SYS_STAT_H
+#ifdef HAVE_SYS_STAT_H
 #include <sys/stat.h>
 #endif
 #include <dirent.h>
-#if HAVE_ERRNO_H
+#ifdef HAVE_ERRNO_H
 #include <errno.h>
 #endif
-#if HAVE_SYS_MKDEV_H
+#ifdef HAVE_SYS_MKDEV_H
 #include <sys/mkdev.h>
 #endif
 #include <fcntl.h>
diff --git a/libblkid/src/llseek.c b/libblkid/src/llseek.c
index 5bd0e51..7fb44c4 100644
--- a/libblkid/src/llseek.c
+++ b/libblkid/src/llseek.c
@@ -12,14 +12,14 @@
 #define _LARGEFILE_SOURCE
 #define _LARGEFILE64_SOURCE
 
-#if HAVE_SYS_TYPES_H
+#ifdef HAVE_SYS_TYPES_H
 #include <sys/types.h>
 #endif
 
-#if HAVE_ERRNO_H
+#ifdef HAVE_ERRNO_H
 #include <errno.h>
 #endif
-#if HAVE_UNISTD_H
+#ifdef HAVE_UNISTD_H
 #include <unistd.h>
 #endif
 #ifdef __MSDOS__
diff --git a/libblkid/src/read.c b/libblkid/src/read.c
index c404bb0..b9fda3a 100644
--- a/libblkid/src/read.c
+++ b/libblkid/src/read.c
@@ -19,13 +19,13 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <unistd.h>
-#if HAVE_ERRNO_H
+#ifdef HAVE_ERRNO_H
 #include <errno.h>
 #endif
 
 #include "blkidP.h"
 
-#if HAVE_STDLIB_H
+#ifdef HAVE_STDLIB_H
 # ifndef _XOPEN_SOURCE
 #  define _XOPEN_SOURCE 600	/* for inclusion of strtoull */
 # endif
diff --git a/libblkid/src/resolve.c b/libblkid/src/resolve.c
index bf13b86..bf5041d 100644
--- a/libblkid/src/resolve.c
+++ b/libblkid/src/resolve.c
@@ -11,7 +11,7 @@
  */
 
 #include <stdio.h>
-#if HAVE_UNISTD_H
+#ifdef HAVE_UNISTD_H
 #include <unistd.h>
 #endif
 #include <stdlib.h>
diff --git a/libblkid/src/version.c b/libblkid/src/version.c
index 4c7fa06..63f02f6 100644
--- a/libblkid/src/version.c
+++ b/libblkid/src/version.c
@@ -9,7 +9,7 @@
  * %End-Header%
  */
 
-#if HAVE_UNISTD_H
+#ifdef HAVE_UNISTD_H
 #include <unistd.h>
 #endif
 #include <string.h>
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 1c810ca..c9efdf0 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -297,7 +297,7 @@ main(int argc, char **argv) {
  * the locale database, which can be overridden with the
  * -s (Sunday) or -m (Monday) options.
  */
-#if HAVE_DECL__NL_TIME_WEEK_1STDAY
+#ifdef HAVE_DECL__NL_TIME_WEEK_1STDAY
 	/*
 	 * You need to use 2 locale variables to get the first day of the week.
 	 * This is needed to support first_weekday=2 and first_workday=1 for
diff --git a/term-utils/script.c b/term-utils/script.c
index 3891bf9..9e08ff6 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -62,8 +62,10 @@
 #include "nls.h"
 #include "c.h"
 
-#if HAVE_LIBUTIL && HAVE_PTY_H
-#include <pty.h>
+#ifdef HAVE_LIBUTIL
+# ifdef HAVE_PTY_H
+#  include <pty.h>
+# endif
 #endif
 
 #ifdef HAVE_LIBUTEMPTER
@@ -499,13 +501,15 @@ done(void) {
 
 void
 getmaster(void) {
-#if HAVE_LIBUTIL && HAVE_PTY_H
+#ifdef HAVE_LIBUTIL
+# ifdef HAVE_PTY_H
 	tcgetattr(STDIN_FILENO, &tt);
 	ioctl(STDIN_FILENO, TIOCGWINSZ, (char *)&win);
 	if (openpty(&master, &slave, NULL, &tt, &win) < 0) {
 		warn(_("openpty failed"));
 		fail();
 	}
+# endif
 #else
 	char *pty, *bank, *cp;
 	struct stat stb;
-- 
1.7.7.4

