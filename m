Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:56144 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbaI1Twm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:52:42 -0400
Received: by mail-wi0-f177.google.com with SMTP id q5so2057798wiv.10
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:52:41 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 13/23] libblkid: fix implicit constant conversion warning
Date: Sun, 28 Sep 2014 20:51:46 +0100
Message-Id: <1411933916-30576-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

warning: overflow in implicit constant conversion [-Woverflow]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libblkid/src/superblocks/bcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libblkid/src/superblocks/bcache.c b/libblkid/src/superblocks/bcache.c
index b3e397b..010866c 100644
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
2.1.1

