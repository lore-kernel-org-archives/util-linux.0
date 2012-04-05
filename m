Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdccah.dreamhost.com ([208.97.132.207]:37507 "EHLO
	homiemail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755409Ab2DEVwI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 5 Apr 2012 17:52:08 -0400
Subject: [PATCH 1/3] lib: random utilities
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Apr 2012 23:52:04 +0200
Message-ID: <1333662724.2696.4.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Add a random number(s) generator specific file. The intial functions are based
on what libuuid provide. I did some modifications like avoid WIN32 checks - this
is util-LINUX.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 include/randutils.h |   19 +++++++++
 lib/Makefile.am     |    2 +
 lib/randutils.c     |  104 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+), 0 deletions(-)
 create mode 100644 include/randutils.h
 create mode 100644 lib/randutils.c

diff --git a/include/randutils.h b/include/randutils.h
new file mode 100644
index 0000000..8c1a447
--- /dev/null
+++ b/include/randutils.h
@@ -0,0 +1,19 @@
+#ifndef UTIL_LINUX_RANDUTILS
+#define UTIL_LINUX_RANDUTILS
+
+#include <sys/syscall.h>
+
+#ifdef HAVE_SRANDOM
+#define srand(x)	srandom(x)
+#define rand()		random()
+#endif
+
+#if defined(__linux__) && defined(__NR_gettid) && defined(HAVE_JRAND48)
+#define DO_JRAND_MIX
+static unsigned short jrand_seed[3];
+#endif
+
+int random_get_fd(void);
+void random_get_bytes(void *buf, int nbytes);
+
+#endif
diff --git a/lib/Makefile.am b/lib/Makefile.am
index c34481d..fc967fc 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -10,6 +10,7 @@ noinst_PROGRAMS = \
 	test_ismounted \
 	test_mangle \
 	test_procutils \
+	test_randutils \
 	test_strutils \
 	test_tt \
 	test_wholedisk
@@ -30,6 +31,7 @@ test_at_SOURCES = at.c
 test_at_CFLAGS = -DTEST_PROGRAM_AT
 
 test_strutils_SOURCES = strutils.c
+test_randutils_SOURCES = randutils.c
 test_procutils_SOURCES = procutils.c
 
 if LINUX
diff --git a/lib/randutils.c b/lib/randutils.c
new file mode 100644
index 0000000..7bc78a3
--- /dev/null
+++ b/lib/randutils.c
@@ -0,0 +1,104 @@
+/*
+ * General purpose random utilities
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/time.h>
+
+#include "randutils.h"
+
+int random_get_fd(void)
+{
+	int i, fd;
+       	struct timeval	tv;
+
+	gettimeofday(&tv, 0);
+	fd = open("/dev/urandom", O_RDONLY);
+	if (fd == -1)
+		fd = open("/dev/random", O_RDONLY | O_NONBLOCK);
+	if (fd >= 0) {
+		i = fcntl(fd, F_GETFD);
+		if (i >= 0)
+			fcntl(fd, F_SETFD, i | FD_CLOEXEC);
+	}
+	srand((getpid() << 16) ^ getuid() ^ tv.tv_sec ^ tv.tv_usec);
+
+#ifdef DO_JRAND_MIX
+	jrand_seed[0] = getpid() ^ (tv.tv_sec & 0xFFFF);
+	jrand_seed[1] = getppid() ^ (tv.tv_usec & 0xFFFF);
+	jrand_seed[2] = (tv.tv_sec ^ tv.tv_usec) >> 16;
+#endif
+	/* Crank the random number generator a few times */
+	gettimeofday(&tv, 0);
+	for (i = (tv.tv_sec ^ tv.tv_usec) & 0x1F; i > 0; i--)
+		rand();
+	return fd;
+}
+
+
+/*
+ * Generate a stream of random nbytes into buf.
+ * Use /dev/urandom if possible, and if not,
+ * use glibc pseudo-random functions.
+ */
+void random_get_bytes(void *buf, int nbytes)
+{
+	int i, n = nbytes, fd = random_get_fd();
+	int lose_counter = 0;
+	unsigned char *cp = (unsigned char *) buf;
+
+	if (fd >= 0) {
+		while (n > 0) {
+			i = read(fd, cp, n);
+			if (i <= 0) {
+				if (lose_counter++ > 16)
+					break;
+				continue;
+			}
+			n -= i;
+			cp += i;
+			lose_counter = 0;
+		}
+	}
+
+	/*
+	 * We do this all the time, but this is the only source of
+	 * randomness if /dev/random/urandom is out to lunch.
+	 */
+	for (cp = buf, i = 0; i < nbytes; i++)
+		*cp++ ^= (rand() >> 7) & 0xFF;
+
+#ifdef DO_JRAND_MIX
+	{
+		unsigned short tmp_seed[3];
+
+		memcpy(tmp_seed, jrand_seed, sizeof(tmp_seed));
+		jrand_seed[2] = jrand_seed[2] ^ syscall(__NR_gettid);
+		for (cp = buf, i = 0; i < nbytes; i++)
+			*cp++ ^= (jrand48(tmp_seed) >> 7) & 0xFF;
+		memcpy(jrand_seed, tmp_seed,
+		       sizeof(jrand_seed)-sizeof(unsigned short));
+	}
+#endif
+
+	return;
+}
+
+#ifdef TEST_PROGRAM
+int main(int argc, char *argv[])
+{
+	unsigned int v, i;
+
+	/* generate and print 10 random numbers */
+	for (i = 0; i < 10; i++) {
+		random_get_bytes(&v, sizeof(v));
+		printf("%d\n", v);
+	}
+
+	return EXIT_SUCCESS;
+}
+#endif /* TEST_PROGRAM */
-- 
1.7.4.1




