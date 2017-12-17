Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35742 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbdLQGpy (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 17 Dec 2017 01:45:54 -0500
Received: by mail-wm0-f65.google.com with SMTP id f9so24214660wmh.0
        for <util-linux@vger.kernel.org>; Sat, 16 Dec 2017 22:45:54 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] libblkid: fix overflow in implicit constant conversion
Date: Sun, 17 Dec 2017 06:45:50 +0000
Message-Id: <20171217064550.7762-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libblkid/src/superblocks/bcache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libblkid/src/superblocks/bcache.c b/libblkid/src/superblocks/bcache.c
index 82c1a8008..f9273b97a 100644
--- a/libblkid/src/superblocks/bcache.c
+++ b/libblkid/src/superblocks/bcache.c
@@ -10,6 +10,7 @@
 
 #include <stddef.h>
 #include <stdio.h>
+#include <stdint.h>
 
 #include "superblocks.h"
 
@@ -19,7 +20,7 @@
 #define node(i, j)         ((i)->d + (j))
 #define end(i)             node(i, le16_to_cpu((i)->keys))
 
-static const char bcache_magic[] = {
+static const uint8_t bcache_magic[] = {
 	0xc6, 0x85, 0x73, 0xf6, 0x4e, 0x1a, 0x45, 0xca,
 	0x82, 0x65, 0xf5, 0x7f, 0x48, 0xba, 0x6d, 0x81
 };
-- 
2.15.1

