Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:34212 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932461AbbCPXz4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 16 Mar 2015 19:55:56 -0400
Received: by wggv3 with SMTP id v3so52525532wgg.1
        for <util-linux@vger.kernel.org>; Mon, 16 Mar 2015 16:55:55 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] libblkid: fix compiler warnings
Date: Mon, 16 Mar 2015 23:55:47 +0000
Message-Id: <1426550147-24964-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

warning: extra ';' outside of a function [-Wextra-semi]

warning: embedding a directive within macro arguments has undefined
behavior [-Wembedded-directive]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libblkid/src/superblocks/bcache.c | 2 +-
 libblkid/src/superblocks/minix.c  | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/libblkid/src/superblocks/bcache.c b/libblkid/src/superblocks/bcache.c
index 4fb16bd..ba9cf32 100644
--- a/libblkid/src/superblocks/bcache.c
+++ b/libblkid/src/superblocks/bcache.c
@@ -117,7 +117,7 @@ static int probe_bcache (blkid_probe pr, const struct blkid_idmag *mag)
 		return BLKID_PROBE_NONE;
 
 	return BLKID_PROBE_OK;
-};
+}
 
 const struct blkid_idinfo bcache_idinfo =
 {
diff --git a/libblkid/src/superblocks/minix.c b/libblkid/src/superblocks/minix.c
index 9ea49fe..d6d45bd 100644
--- a/libblkid/src/superblocks/minix.c
+++ b/libblkid/src/superblocks/minix.c
@@ -21,6 +21,7 @@ static int get_minix_version(const unsigned char *data, int *other_endian)
 	struct minix_super_block *sb = (struct minix_super_block *) data;
 	struct minix3_super_block *sb3 = (struct minix3_super_block *) data;
 	int version = 0;
+	char *endian;
 
 	*other_endian = 0;
 
@@ -60,13 +61,13 @@ static int get_minix_version(const unsigned char *data, int *other_endian)
 	if (!version)
 		return -1;
 
-	DBG(LOWPROBE, ul_debug("minix version %d detected [%s]", version,
 #if defined(WORDS_BIGENDIAN)
-	*other_endian ? "LE" : "BE"
+	endian = *other_endian ? "LE" : "BE";
 #else
-	*other_endian ? "BE" : "LE"
+	endian = *other_endian ? "BE" : "LE";
 #endif
-	));
+	DBG(LOWPROBE, ul_debug("minix version %d detected [%s]", version,
+			       endian));
 	return version;
 }
 
-- 
2.3.3

