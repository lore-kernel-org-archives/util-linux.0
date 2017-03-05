Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33842 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbdCEUwm (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Mar 2017 15:52:42 -0500
Received: by mail-wr0-f193.google.com with SMTP id u48so19504365wrc.1
        for <util-linux@vger.kernel.org>; Sun, 05 Mar 2017 12:52:40 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 03/13] libblkid: avoid overflow when initializing array
Date: Sun,  5 Mar 2017 20:52:22 +0000
Message-Id: <20170305205232.24030-4-kerolasa@iki.fi>
In-Reply-To: <20170305205232.24030-1-kerolasa@iki.fi>
References: <20170305205232.24030-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

libblkid/src/superblocks/drbdmanage.c:38:42: warning: too long
initializer-string for array of char(no space for nul char)

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libblkid/src/superblocks/drbdmanage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libblkid/src/superblocks/drbdmanage.c b/libblkid/src/superblocks/drbdmanage.c
index 48bf1dabf..b45f89bc8 100644
--- a/libblkid/src/superblocks/drbdmanage.c
+++ b/libblkid/src/superblocks/drbdmanage.c
@@ -35,7 +35,7 @@ struct drbdmanage_pers {
 } __attribute__ ((packed));
 
 
-static const char persistence_magic[4] = "\x1a\xdb\x98\xa2";
+static const char persistence_magic[4] = { '\x1a', '\xdb', '\x98', '\xa2' };
 
 
 static int probe_drbdmanage(blkid_probe pr,
-- 
2.12.0

