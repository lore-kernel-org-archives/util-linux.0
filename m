Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:38185 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754104Ab2EFTzz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 6 May 2012 15:55:55 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 8017E93583
	for <util-linux@vger.kernel.org>; Sun,  6 May 2012 21:55:54 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] libuuid: avoid double open and leaking fd (reworked)
Date: Sun,  6 May 2012 21:55:53 +0200
Message-Id: <1336334153-32532-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This reverts commit 6126f7a53c57485a9a29ddd772765695f23c92e6
and fixes the double open and leaking descriptor in a different way,
that is by using newly introduced function 'have_random_source()'
to check whether good random source is available while deciding
which uuid type to generate (random/time).

This is better than calling random_get_fd() twice, passing the file
descriptor down the stack and reusing it in next call to
random_get_fd().

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisk/fdiskdoslabel.c  |    2 +-
 include/randutils.h    |    2 +-
 lib/randutils.c        |    8 +++-----
 libuuid/src/gen_uuid.c |   28 ++++++++++++++++++----------
 libuuid/src/uuidd.h    |    2 +-
 misc-utils/uuidd.c     |    4 ++--
 6 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/fdisk/fdiskdoslabel.c b/fdisk/fdiskdoslabel.c
index c6e4198..6a9a044 100644
--- a/fdisk/fdiskdoslabel.c
+++ b/fdisk/fdiskdoslabel.c
@@ -182,7 +182,7 @@ void create_doslabel(void)
 	unsigned int id;
 
 	/* random disk signature */
-	random_get_bytes(&id, sizeof(id), -1);
+	random_get_bytes(&id, sizeof(id));
 
 	fprintf(stderr, _("Building a new DOS disklabel with disk identifier 0x%08x.\n"), id);
 
diff --git a/include/randutils.h b/include/randutils.h
index d5d00f4..dec5e35 100644
--- a/include/randutils.h
+++ b/include/randutils.h
@@ -7,6 +7,6 @@
 #endif
 
 extern int random_get_fd(void);
-extern void random_get_bytes(void *buf, size_t nbytes, int fd);
+extern void random_get_bytes(void *buf, size_t nbytes);
 
 #endif
diff --git a/lib/randutils.c b/lib/randutils.c
index 0513798..b90c886 100644
--- a/lib/randutils.c
+++ b/lib/randutils.c
@@ -58,15 +58,13 @@ int random_get_fd(void)
  * Use /dev/urandom if possible, and if not,
  * use glibc pseudo-random functions.
  */
-void random_get_bytes(void *buf, size_t nbytes, int fd)
+void random_get_bytes(void *buf, size_t nbytes)
 {
 	size_t i, n = nbytes;
+	int fd = random_get_fd();
 	int lose_counter = 0;
 	unsigned char *cp = (unsigned char *) buf;
 
-	if (fd < 0)
-		fd = random_get_fd();
-
 	if (fd >= 0) {
 		while (n > 0) {
 			ssize_t x = read(fd, cp, n);
@@ -113,7 +111,7 @@ int main(int argc, char *argv[])
 
 	/* generate and print 10 random numbers */
 	for (i = 0; i < 10; i++) {
-		random_get_bytes(&v, sizeof(v), -1);
+		random_get_bytes(&v, sizeof(v));
 		printf("%d\n", v);
 	}
 
diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 76f1bbd..93d292a 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -277,7 +277,7 @@ static int get_clock(uint32_t *clock_high, uint32_t *clock_low,
 	}
 
 	if ((last.tv_sec == 0) && (last.tv_usec == 0)) {
-		random_get_bytes(&clock_seq, sizeof(clock_seq), -1);
+		random_get_bytes(&clock_seq, sizeof(clock_seq));
 		clock_seq &= 0x3FFF;
 		gettimeofday(&last, 0);
 		last.tv_sec--;
@@ -434,7 +434,7 @@ int __uuid_generate_time(uuid_t out, int *num)
 
 	if (!has_init) {
 		if (get_node_id(node_id) <= 0) {
-			random_get_bytes(node_id, 6, -1);
+			random_get_bytes(node_id, 6);
 			/*
 			 * Set multicast bit, to prevent conflicts
 			 * with IEEE 802 addresses obtained from
@@ -520,7 +520,7 @@ int uuid_generate_time_safe(uuid_t out)
 }
 
 
-void __uuid_generate_random(uuid_t out, int *num, int fd)
+void __uuid_generate_random(uuid_t out, int *num)
 {
 	uuid_t	buf;
 	struct uuid uu;
@@ -532,7 +532,7 @@ void __uuid_generate_random(uuid_t out, int *num, int fd)
 		n = *num;
 
 	for (i = 0; i < n; i++) {
-		random_get_bytes(buf, sizeof(buf), fd);
+		random_get_bytes(buf, sizeof(buf));
 		uuid_unpack(buf, &uu);
 
 		uu.clock_seq = (uu.clock_seq & 0x3FFF) | 0x8000;
@@ -548,7 +548,18 @@ void uuid_generate_random(uuid_t out)
 	int	num = 1;
 	/* No real reason to use the daemon for random uuid's -- yet */
 
-	__uuid_generate_random(out, &num, -1);
+	__uuid_generate_random(out, &num);
+}
+
+/*
+ * Check whether good random source (/dev/random or /dev/urandom)
+ * is available.
+ */
+static int have_random_source(void)
+{
+	struct stat s;
+
+	return (!stat("/dev/random", &s) || !stat("/dev/urandom", &s));
 }
 
 
@@ -560,11 +571,8 @@ void uuid_generate_random(uuid_t out)
  */
 void uuid_generate(uuid_t out)
 {
-	int	fd;
-	int	num = 1;
-
-	if ((fd = random_get_fd()) >= 0)
-		__uuid_generate_random(out, &num, fd);
+	if (have_random_source())
+		uuid_generate_random(out);
 	else
 		uuid_generate_time(out);
 }
diff --git a/libuuid/src/uuidd.h b/libuuid/src/uuidd.h
index 2e19522..27b79c2 100644
--- a/libuuid/src/uuidd.h
+++ b/libuuid/src/uuidd.h
@@ -49,6 +49,6 @@
 #define UUIDD_MAX_OP			UUIDD_OP_BULK_RANDOM_UUID
 
 extern int __uuid_generate_time(uuid_t out, int *num);
-extern void __uuid_generate_random(uuid_t out, int *num, int fd);
+extern void __uuid_generate_random(uuid_t out, int *num);
 
 #endif /* _UUID_UUID_H */
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 768fed5..eb1ef02 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -442,7 +442,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			break;
 		case UUIDD_OP_RANDOM_UUID:
 			num = 1;
-			__uuid_generate_random(uu, &num, -1);
+			__uuid_generate_random(uu, &num);
 			if (uuidd_cxt->debug) {
 				uuid_unparse(uu, str);
 				fprintf(stderr, _("Generated random UUID: %s\n"), str);
@@ -473,7 +473,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			if (num * UUID_LEN > (int) (sizeof(reply_buf) - sizeof(num)))
 				num = (sizeof(reply_buf) - sizeof(num)) / UUID_LEN;
 			__uuid_generate_random((unsigned char *) reply_buf +
-					      sizeof(num), &num, -1);
+					      sizeof(num), &num);
 			if (uuidd_cxt->debug) {
 				fprintf(stderr, P_("Generated %d UUID:\n",
 						   "Generated %d UUIDs:\n", num), num);
-- 
1.7.7

