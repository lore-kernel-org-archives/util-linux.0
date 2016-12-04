Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36484 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbcLDJNe (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 4 Dec 2016 04:13:34 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so9096211wma.3
        for <util-linux@vger.kernel.org>; Sun, 04 Dec 2016 01:13:07 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] lib/randutils: use getrandom(2) when it is available
Date: Sun,  4 Dec 2016 09:12:59 +0000
Message-Id: <20161204091259.12651-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

System call getrandom(2) is relatively new, available since kernel 3.17 but
not supported by glibc 2.24.  That in mind autotools is made to check
availability of this function and keep old code as fallback.  It is
reasonable assume it will take years before the syscall(2) and fallback are
unproblematic to remove.

One might ask why bother using getrandom(2).  Main reason is to avoid
unnecessary system calls to achieve exactly same end result.  That
demonstrated with 'strace -c ./mcookie' showing 36 calls before, and 32
after this change.  Secondly the getrandom(2) function got to kernel with
promise it can be used to avoid file descriptor run down, and since uuidd
uses random_get_bytes() it should fulfill it's promise here.

Reference: http://man7.org/linux/man-pages/man2/getrandom.2.html
Reference: https://lwn.net/Articles/606141/
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac    |  8 ++++++++
 lib/randutils.c | 60 ++++++++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/configure.ac b/configure.ac
index dddc6a9..788cd53 100644
--- a/configure.ac
+++ b/configure.ac
@@ -427,6 +427,14 @@ AC_CHECK_FUNCS([reboot], [have_reboot=yes],[have_reboot=no])
 
 AM_CONDITIONAL([HAVE_OPENAT], [test "x$have_openat" = xyes])
 
+AC_CHECK_FUNCS([getrandom], [], [
+	AS_IF([UL_CHECK_SYSCALL([getrandom])
+	  test "$ul_cv_syscall_getrandom" = SYS_getrandom],
+		[AC_DEFINE([SYSTEM_GETRANDOM], [1],
+			[Define if getrandom syscall is missing from libc])
+	])
+])
+
 dnl lib/mononotic.c may require -lrt
 AC_CHECK_FUNCS([clock_gettime], [],
 	[AC_CHECK_LIB([rt], [clock_gettime], [REALTIME_LIBS="-lrt"])]
diff --git a/lib/randutils.c b/lib/randutils.c
index b93b9ba..6eac134 100644
--- a/lib/randutils.c
+++ b/lib/randutils.c
@@ -35,20 +35,11 @@ int rand_get_number(int low_n, int high_n)
 	return rand() % (high_n - low_n + 1) + low_n;
 }
 
-int random_get_fd(void)
+static void crank_random(void)
 {
-	int i, fd;
+	int i;
 	struct timeval tv;
 
-	fd = open("/dev/urandom", O_RDONLY | O_CLOEXEC);
-	if (fd == -1)
-		fd = open("/dev/random", O_RDONLY | O_NONBLOCK | O_CLOEXEC);
-	if (fd >= 0) {
-		i = fcntl(fd, F_GETFD);
-		if (i >= 0)
-			fcntl(fd, F_SETFD, i | FD_CLOEXEC);
-	}
-
 	gettimeofday(&tv, 0);
 	srand((getpid() << 16) ^ getuid() ^ tv.tv_sec ^ tv.tv_usec);
 
@@ -61,10 +52,34 @@ int random_get_fd(void)
 	gettimeofday(&tv, 0);
 	for (i = (tv.tv_sec ^ tv.tv_usec) & 0x1F; i > 0; i--)
 		rand();
+}
+
+int random_get_fd(void)
+{
+	int i, fd;
+
+	fd = open("/dev/urandom", O_RDONLY | O_CLOEXEC);
+	if (fd == -1)
+		fd = open("/dev/random", O_RDONLY | O_NONBLOCK | O_CLOEXEC);
+	if (fd >= 0) {
+		i = fcntl(fd, F_GETFD);
+		if (i >= 0)
+			fcntl(fd, F_SETFD, i | FD_CLOEXEC);
+	}
+	crank_random();
 	return fd;
 }
 
 
+#ifdef SYSTEM_GETRANDOM
+static int getrandom(void *buf, size_t buflen, unsigned int flags)
+{
+	return (syscall(SYS_getrandom, buf, buflen, flags));
+}
+#elif defined(HAVE_GETRANDOM)
+# include <linux/random.h>
+#endif
+
 /*
  * Generate a stream of random nbytes into buf.
  * Use /dev/urandom if possible, and if not,
@@ -72,10 +87,19 @@ int random_get_fd(void)
  */
 void random_get_bytes(void *buf, size_t nbytes)
 {
-	size_t i, n = nbytes;
+	size_t i;
+	unsigned char *cp = (unsigned char *)buf;
+
+#if defined(SYSTEM_GETRANDOM) || defined(HAVE_GETRANDOM)
+	while (getrandom(buf, nbytes, 0) < 0) {
+		if (errno == EINTR)
+			continue;
+		break;
+	}
+#else
+	size_t n = nbytes;
 	int fd = random_get_fd();
 	int lose_counter = 0;
-	unsigned char *cp = (unsigned char *) buf;
 
 	if (fd >= 0) {
 		while (n > 0) {
@@ -92,11 +116,12 @@ void random_get_bytes(void *buf, size_t nbytes)
 
 		close(fd);
 	}
-
+#endif
 	/*
 	 * We do this all the time, but this is the only source of
 	 * randomness if /dev/random/urandom is out to lunch.
 	 */
+	crank_random();
 	for (cp = buf, i = 0; i < nbytes; i++)
 		*cp++ ^= (rand() >> 7) & 0xFF;
 
@@ -122,6 +147,11 @@ void random_get_bytes(void *buf, size_t nbytes)
  */
 const char *random_tell_source(void)
 {
+#if defined(SYSTEM_GETRANDOM)
+	return _("syscall(SYS_getrandom) function");
+#elif defined(HAVE_GETRANDOM)
+	return _("libc getrandom() function");
+#else
 	size_t i;
 	static const char *random_sources[] = {
 		"/dev/urandom",
@@ -132,7 +162,7 @@ const char *random_tell_source(void)
 		if (!access(random_sources[i], R_OK))
 			return random_sources[i];
 	}
-
+#endif
 	return _("libc pseudo-random functions");
 }
 
-- 
2.10.2

