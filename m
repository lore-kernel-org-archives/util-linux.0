Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f54.google.com ([74.125.82.54]:50377 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab3JGWEu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 7 Oct 2013 18:04:50 -0400
Received: by mail-wg0-f54.google.com with SMTP id m15so8099515wgh.9
        for <util-linux@vger.kernel.org>; Mon, 07 Oct 2013 15:04:48 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/2] libblkid: fix compiler warning [smatch]
Date: Mon,  7 Oct 2013 23:04:22 +0100
Message-Id: <1381183463-1297-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

warning: overflow in implicit constant conversion

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libblkid/src/superblocks/bcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libblkid/src/superblocks/bcache.c b/libblkid/src/superblocks/bcache.c
index 303f7ee..f5a8ce6 100644
--- a/libblkid/src/superblocks/bcache.c
+++ b/libblkid/src/superblocks/bcache.c
@@ -20,7 +20,7 @@
 #define node(i, j)         ((i)->d + (j))
 #define end(i)             node(i, (i)->keys)
 
-static const char bcache_magic[] = {
+static const unsigned char bcache_magic[] = {
 	0xc6, 0x85, 0x73, 0xf6, 0x4e, 0x1a, 0x45, 0xca,
 	0x82, 0x65, 0xf5, 0x7f, 0x48, 0xba, 0x6d, 0x81
 };
-- 
1.8.4

