Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcagg.dreamhost.com ([208.97.132.66]:45406 "EHLO
	homiemail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755318Ab2DEVwQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 5 Apr 2012 17:52:16 -0400
Subject: [PATCH 3/3] libuuid: use randutils
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Apr 2012 23:52:10 +0200
Message-ID: <1333662730.2696.6.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 libuuid/src/Makefile.am |    3 +-
 libuuid/src/gen_uuid.c  |   99 ++--------------------------------------------
 2 files changed, 7 insertions(+), 95 deletions(-)

diff --git a/libuuid/src/Makefile.am b/libuuid/src/Makefile.am
index 66ab2d4..8e87210 100644
--- a/libuuid/src/Makefile.am
+++ b/libuuid/src/Makefile.am
@@ -25,7 +25,8 @@ libuuid_la_SOURCES = \
 	uuidd.h \
 	uuidP.h \
 	uuid_time.c \
-	$(uuidinc_HEADERS)
+	$(uuidinc_HEADERS) \
+	$(top_srcdir)/lib/randutils.c
 
 libuuid_la_DEPENDENCIES = uuid.sym
 
diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 492bb75..9bcd62c 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -93,11 +93,7 @@
 
 #include "uuidP.h"
 #include "uuidd.h"
-
-#ifdef HAVE_SRANDOM
-#define srand(x)	srandom(x)
-#define rand()		random()
-#endif
+#include "randutils.h"
 
 #ifdef HAVE_TLS
 #define THREAD_LOCAL static __thread
@@ -105,11 +101,6 @@
 #define THREAD_LOCAL static
 #endif
 
-#if defined(__linux__) && defined(__NR_gettid) && defined(HAVE_JRAND48)
-#define DO_JRAND_MIX
-THREAD_LOCAL unsigned short jrand_seed[3];
-#endif
-
 #ifdef _WIN32
 static void gettimeofday (struct timeval *tv, void *dummy)
 {
@@ -134,86 +125,6 @@ static int getuid (void)
 }
 #endif
 
-static int get_random_fd(void)
-{
-	struct timeval	tv;
-	static int	fd = -2;
-	int		i;
-
-	if (fd == -2) {
-		gettimeofday(&tv, 0);
-#ifndef _WIN32
-		fd = open("/dev/urandom", O_RDONLY);
-		if (fd == -1)
-			fd = open("/dev/random", O_RDONLY | O_NONBLOCK);
-		if (fd >= 0) {
-			i = fcntl(fd, F_GETFD);
-			if (i >= 0)
-				fcntl(fd, F_SETFD, i | FD_CLOEXEC);
-		}
-#endif
-		srand((getpid() << 16) ^ getuid() ^ tv.tv_sec ^ tv.tv_usec);
-#ifdef DO_JRAND_MIX
-		jrand_seed[0] = getpid() ^ (tv.tv_sec & 0xFFFF);
-		jrand_seed[1] = getppid() ^ (tv.tv_usec & 0xFFFF);
-		jrand_seed[2] = (tv.tv_sec ^ tv.tv_usec) >> 16;
-#endif
-	}
-	/* Crank the random number generator a few times */
-	gettimeofday(&tv, 0);
-	for (i = (tv.tv_sec ^ tv.tv_usec) & 0x1F; i > 0; i--)
-		rand();
-	return fd;
-}
-
-
-/*
- * Generate a series of random bytes.  Use /dev/urandom if possible,
- * and if not, use srandom/random.
- */
-static void get_random_bytes(void *buf, int nbytes)
-{
-	int i, n = nbytes, fd = get_random_fd();
-	int lose_counter = 0;
-	unsigned char *cp = (unsigned char *) buf;
-
-	if (fd >= 0) {
-		while (n > 0) {
-			i = read(fd, cp, n);
-			if (i <= 0) {
-				if (lose_counter++ > 16)
-					break;
-				continue;
-			}
-			n -= i;
-			cp += i;
-			lose_counter = 0;
-		}
-	}
-
-	/*
-	 * We do this all the time, but this is the only source of
-	 * randomness if /dev/random/urandom is out to lunch.
-	 */
-	for (cp = buf, i = 0; i < nbytes; i++)
-		*cp++ ^= (rand() >> 7) & 0xFF;
-
-#ifdef DO_JRAND_MIX
-	{
-		unsigned short tmp_seed[3];
-
-		memcpy(tmp_seed, jrand_seed, sizeof(tmp_seed));
-		jrand_seed[2] = jrand_seed[2] ^ syscall(__NR_gettid);
-		for (cp = buf, i = 0; i < nbytes; i++)
-			*cp++ ^= (jrand48(tmp_seed) >> 7) & 0xFF;
-		memcpy(jrand_seed, tmp_seed,
-		       sizeof(jrand_seed)-sizeof(unsigned short));
-	}
-#endif
-
-	return;
-}
-
 /*
  * Get the ethernet hardware address, if we can find it...
  *
@@ -370,7 +281,7 @@ static int get_clock(uint32_t *clock_high, uint32_t *clock_low,
 	}
 
 	if ((last.tv_sec == 0) && (last.tv_usec == 0)) {
-		get_random_bytes(&clock_seq, sizeof(clock_seq));
+		random_get_bytes(&clock_seq, sizeof(clock_seq));
 		clock_seq &= 0x3FFF;
 		gettimeofday(&last, 0);
 		last.tv_sec--;
@@ -577,7 +488,7 @@ int __uuid_generate_time(uuid_t out, int *num)
 
 	if (!has_init) {
 		if (get_node_id(node_id) <= 0) {
-			get_random_bytes(node_id, 6);
+			random_get_bytes(node_id, 6);
 			/*
 			 * Set multicast bit, to prevent conflicts
 			 * with IEEE 802 addresses obtained from
@@ -675,7 +586,7 @@ void __uuid_generate_random(uuid_t out, int *num)
 		n = *num;
 
 	for (i = 0; i < n; i++) {
-		get_random_bytes(buf, sizeof(buf));
+		random_get_bytes(buf, sizeof(buf));
 		uuid_unpack(buf, &uu);
 
 		uu.clock_seq = (uu.clock_seq & 0x3FFF) | 0x8000;
@@ -703,7 +614,7 @@ void uuid_generate_random(uuid_t out)
  */
 void uuid_generate(uuid_t out)
 {
-	if (get_random_fd() >= 0)
+	if (random_get_fd() >= 0)
 		uuid_generate_random(out);
 	else
 		uuid_generate_time(out);
-- 
1.7.4.1




