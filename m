Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f53.google.com ([74.125.82.53]:64578 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106Ab3AIThF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Jan 2013 14:37:05 -0500
Received: by mail-wg0-f53.google.com with SMTP id fn15so1244936wgb.32
        for <util-linux@vger.kernel.org>; Wed, 09 Jan 2013 11:37:04 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/4] lib: add function to seed random()
Date: Wed,  9 Jan 2013 19:36:53 +0000
Message-Id: <1357760216-4068-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/randutils.h |  1 +
 lib/randutils.c     | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/randutils.h b/include/randutils.h
index dec5e35..9d4d41c 100644
--- a/include/randutils.h
+++ b/include/randutils.h
@@ -8,5 +8,6 @@
 
 extern int random_get_fd(void);
 extern void random_get_bytes(void *buf, size_t nbytes);
+extern void seed_random(void);
 
 #endif
diff --git a/lib/randutils.c b/lib/randutils.c
index 85cb1a9..44d996e 100644
--- a/lib/randutils.c
+++ b/lib/randutils.c
@@ -104,6 +104,24 @@ void random_get_bytes(void *buf, size_t nbytes)
 	return;
 }
 
+/* Seed random(3). */
+void seed_random(void)
+{
+	struct timeval tv;
+	unsigned int seed;
+	FILE *fd;
+
+	if ((fd = fopen("/dev/urandom", "r"))) {
+		fread(&seed, sizeof seed, 1, fd);
+		fclose(fd);
+	} else {
+		gettimeofday(&tv, NULL);
+		/* NOTE: intentional use of uninitialized variable */
+		seed ^= (getpid() << 16) ^ tv.tv_sec ^ tv.tv_usec;
+	}
+	srandom(seed);
+}
+
 #ifdef TEST_PROGRAM
 int main(int argc __attribute__ ((__unused__)),
          char *argv[] __attribute__ ((__unused__)))
-- 
1.8.1

