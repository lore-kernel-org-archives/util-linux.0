Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33497 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbeHDVSu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 4 Aug 2018 17:18:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so8530256wrp.0
        for <util-linux@vger.kernel.org>; Sat, 04 Aug 2018 12:17:10 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] libuuid: use kernel crypto api
Date: Sat,  4 Aug 2018 20:17:06 +0100
Message-Id: <20180804191706.10641-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Try to speed up md5 checksums by using hardware accelerators when they are
present with use of kernel crypto api.

Reference: http://www.chronox.de/libkcapi/html/ch01s02.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libuuid/src/gen_uuid.c | 51 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index a374e75c9..a1867460e 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -80,6 +80,8 @@
 #if defined(__linux__) && defined(HAVE_SYS_SYSCALL_H)
 #include <sys/syscall.h>
 #endif
+#include <linux/if_alg.h>
+#include <sys/uio.h>
 
 #include "all-io.h"
 #include "uuidP.h"
@@ -564,17 +566,50 @@ void uuid_generate(uuid_t out)
  */
 void uuid_generate_md5(uuid_t out, const uuid_t ns, const char *name, size_t len)
 {
-	UL_MD5_CTX ctx;
-	char hash[UL_MD5LENGTH];
+	int tfmfd;
+	struct sockaddr_alg sa = {
+		.salg_family = AF_ALG,
+		.salg_type = "hash",
+		.salg_name = "md5"
+	};
+
+	tfmfd = socket(AF_ALG, SOCK_SEQPACKET, 0);
+ old_md5:
+	if (tfmfd != -1) {
+		int opfd = -1, fail = 0;
+		struct iovec const iov[2] = {
+			{.iov_base = (void *)ns, .iov_len = sizeof(uuid_t)},
+			{.iov_base = (void *)name, .iov_len = len}
+		};
+
+		if (bind(tfmfd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
+			fail = 1;
+		if (!fail && (opfd = accept(tfmfd, NULL, 0)) < 0)
+			fail = 1;
+		if (!fail && writev(opfd, iov, 2) < 0)
+			fail = 1;
+		if (!fail && read(opfd, out, sizeof(uuid_t)) == -1)
+			fail = 1;
+		if (opfd != -1)
+			close(opfd);
+		close(tfmfd);
+		if (fail) {
+			tfmfd = -1;
+			goto old_md5;
+		}
+	} else {
+		UL_MD5_CTX ctx;
+		char hash[UL_MD5LENGTH];
 
-	ul_MD5Init(&ctx);
-	/* hash concatenation of well-known UUID with name */
-	ul_MD5Update(&ctx, ns, sizeof(uuid_t));
-	ul_MD5Update(&ctx, (const unsigned char *)name, len);
+		ul_MD5Init(&ctx);
+		/* hash concatenation of well-known UUID with name */
+		ul_MD5Update(&ctx, ns, sizeof(uuid_t));
+		ul_MD5Update(&ctx, (const unsigned char *)name, len);
 
-	ul_MD5Final((unsigned char *)hash, &ctx);
+		ul_MD5Final((unsigned char *)hash, &ctx);
 
-	memcpy(out, hash, sizeof(uuid_t));
+		memcpy(out, hash, sizeof(uuid_t));
+	}
 
 	out[6] &= ~(UUID_TYPE_MASK << UUID_TYPE_SHIFT);
 	out[6] |= (UUID_TYPE_DCE_MD5 << UUID_TYPE_SHIFT);
-- 
2.18.0

