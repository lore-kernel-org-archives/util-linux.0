Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:32833 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958Ab2JJEWH (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 10 Oct 2012 00:22:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id EB02433C235
	for <util-linux-ng@vger.kernel.org>; Wed, 10 Oct 2012 04:22:05 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux-ng@vger.kernel.org
Subject: [PATCH] md5: fix strict aliasing warnings
Date: Wed, 10 Oct 2012 00:22:38 -0400
Message-Id: <1349842958-6533-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is the same fix as was merged in gcc/binutils where this code
appears to originate from.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 lib/md5.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/md5.c b/lib/md5.c
index 26ec4bb..488d16e 100644
--- a/lib/md5.c
+++ b/lib/md5.c
@@ -138,9 +138,12 @@ void MD5Final(unsigned char digest[MD5LENGTH], struct MD5Context *ctx)
     }
     byteReverse(ctx->in, 14);
 
-    /* Append length in bits and transform */
-    ((uint32_t *) ctx->in)[14] = ctx->bits[0];
-    ((uint32_t *) ctx->in)[15] = ctx->bits[1];
+    /* Append length in bits and transform.
+     * Use memcpy to avoid aliasing problems.  On most systems,
+     * this will be optimized away to the same code.
+     */
+    memcpy(&ctx->in[14 * sizeof(uint32_t)], &ctx->bits[0], 4);
+    memcpy(&ctx->in[15 * sizeof(uint32_t)], &ctx->bits[1], 4);
 
     MD5Transform(ctx->buf, (uint32_t *) ctx->in);
     byteReverse((unsigned char *) ctx->buf, 4);
-- 
1.7.12

