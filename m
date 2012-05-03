Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53101 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758221Ab2ECTCO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 May 2012 15:02:14 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 59D7F9664A
	for <util-linux@vger.kernel.org>; Thu,  3 May 2012 21:02:13 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 15/15] libuuid: avoid double open and leaking descriptor
Date: Thu,  3 May 2012 21:02:01 +0200
Message-Id: <1336071721-32492-16-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
References: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

We are opening /dev/urandom twice in uuid_generate(): first to check if
the file is available and then later __uuid_generate_random() again to
actually get the random data. Moreover, descriptor from the first open
is leaking.

Fix by passign the descriptor down the stack and reusing it there.

References: http://marc.info/?l=util-linux-ng&m=133406051131131&w=2

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisk/fdiskdoslabel.c  |    2 +-
 include/randutils.h    |    2 +-
 lib/randutils.c        |    8 +++++---
 libuuid/src/gen_uuid.c |   17 ++++++++++-------
 libuuid/src/uuidd.h    |    2 +-
 misc-utils/uuidd.c     |    4 ++--
 6 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/fdisk/fdiskdoslabel.c b/fdisk/fdiskdoslabel.c
index 6a9a044..c6e4198 100644
--- a/fdisk/fdiskdoslabel.c
+++ b/fdisk/fdiskdoslabel.c
@@ -182,7 +182,7 @@ void create_doslabel(void)
 	unsigned int id;
 
 	/* random disk signature */
-	random_get_bytes(&id, sizeof(id));
+	random_get_bytes(&id, sizeof(id), -1);
 
 	fprintf(stderr, _("Building a new DOS disklabel with disk identifier 0x%08x.\n"), id);
 
diff --git a/include/randutils.h b/include/randutils.h
index dec5e35..d5d00f4 100644
--- a/include/randutils.h
+++ b/include/randutils.h
@@ -7,6 +7,6 @@
 #endif
 
 extern int random_get_fd(void);
-extern void random_get_bytes(void *buf, size_t nbytes);
+extern void random_get_bytes(void *buf, size_t nbytes, int fd);
 
 #endif
diff --git a/lib/randutils.c b/lib/randutils.c
index b90c886..0513798 100644
--- a/lib/randutils.c
+++ b/lib/randutils.c
@@ -58,13 +58,15 @@ int random_get_fd(void)
  * Use /dev/urandom if possible, and if not,
  * use glibc pseudo-random functions.
  */
-void random_get_bytes(void *buf, size_t nbytes)
+void random_get_bytes(void *buf, size_t nbytes, int fd)
 {
 	size_t i, n = nbytes;
-	int fd = random_get_fd();
 	int lose_counter = 0;
 	unsigned char *cp = (unsigned char *) buf;
 
+	if (fd < 0)
+		fd = random_get_fd();
+
 	if (fd >= 0) {
 		while (n > 0) {
 			ssize_t x = read(fd, cp, n);
@@ -111,7 +113,7 @@ int main(int argc, char *argv[])
 
 	/* generate and print 10 random numbers */
 	for (i = 0; i < 10; i++) {
-		random_get_bytes(&v, sizeof(v));
+		random_get_bytes(&v, sizeof(v), -1);
 		printf("%d\n", v);
 	}
 
diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 8ff4129..76f1bbd 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -277,7 +277,7 @@ static int get_clock(uint32_t *clock_high, uint32_t *clock_low,
 	}
 
 	if ((last.tv_sec == 0) && (last.tv_usec == 0)) {
-		random_get_bytes(&clock_seq, sizeof(clock_seq));
+		random_get_bytes(&clock_seq, sizeof(clock_seq), -1);
 		clock_seq &= 0x3FFF;
 		gettimeofday(&last, 0);
 		last.tv_sec--;
@@ -434,7 +434,7 @@ int __uuid_generate_time(uuid_t out, int *num)
 
 	if (!has_init) {
 		if (get_node_id(node_id) <= 0) {
-			random_get_bytes(node_id, 6);
+			random_get_bytes(node_id, 6, -1);
 			/*
 			 * Set multicast bit, to prevent conflicts
 			 * with IEEE 802 addresses obtained from
@@ -520,7 +520,7 @@ int uuid_generate_time_safe(uuid_t out)
 }
 
 
-void __uuid_generate_random(uuid_t out, int *num)
+void __uuid_generate_random(uuid_t out, int *num, int fd)
 {
 	uuid_t	buf;
 	struct uuid uu;
@@ -532,7 +532,7 @@ void __uuid_generate_random(uuid_t out, int *num)
 		n = *num;
 
 	for (i = 0; i < n; i++) {
-		random_get_bytes(buf, sizeof(buf));
+		random_get_bytes(buf, sizeof(buf), fd);
 		uuid_unpack(buf, &uu);
 
 		uu.clock_seq = (uu.clock_seq & 0x3FFF) | 0x8000;
@@ -548,7 +548,7 @@ void uuid_generate_random(uuid_t out)
 	int	num = 1;
 	/* No real reason to use the daemon for random uuid's -- yet */
 
-	__uuid_generate_random(out, &num);
+	__uuid_generate_random(out, &num, -1);
 }
 
 
@@ -560,8 +560,11 @@ void uuid_generate_random(uuid_t out)
  */
 void uuid_generate(uuid_t out)
 {
-	if (random_get_fd() >= 0)
-		uuid_generate_random(out);
+	int	fd;
+	int	num = 1;
+
+	if ((fd = random_get_fd()) >= 0)
+		__uuid_generate_random(out, &num, fd);
 	else
 		uuid_generate_time(out);
 }
diff --git a/libuuid/src/uuidd.h b/libuuid/src/uuidd.h
index 27b79c2..2e19522 100644
--- a/libuuid/src/uuidd.h
+++ b/libuuid/src/uuidd.h
@@ -49,6 +49,6 @@
 #define UUIDD_MAX_OP			UUIDD_OP_BULK_RANDOM_UUID
 
 extern int __uuid_generate_time(uuid_t out, int *num);
-extern void __uuid_generate_random(uuid_t out, int *num);
+extern void __uuid_generate_random(uuid_t out, int *num, int fd);
 
 #endif /* _UUID_UUID_H */
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index d20526e..d3ed3eb 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -442,7 +442,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			break;
 		case UUIDD_OP_RANDOM_UUID:
 			num = 1;
-			__uuid_generate_random(uu, &num);
+			__uuid_generate_random(uu, &num, -1);
 			if (uuidd_cxt->debug) {
 				uuid_unparse(uu, str);
 				fprintf(stderr, _("Generated random UUID: %s\n"), str);
@@ -473,7 +473,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			if (num * UUID_LEN > (int) (sizeof(reply_buf) - sizeof(num)))
 				num = (sizeof(reply_buf) - sizeof(num)) / UUID_LEN;
 			__uuid_generate_random((unsigned char *) reply_buf +
-					      sizeof(num), &num);
+					      sizeof(num), &num, -1);
 			if (uuidd_cxt->debug) {
 				fprintf(stderr, P_("Generated %d UUID:\n",
 						   "Generated %d UUIDs:\n", num), num);
-- 
1.7.7

