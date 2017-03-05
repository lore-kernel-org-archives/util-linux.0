Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36249 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbdCEUwn (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Mar 2017 15:52:43 -0500
Received: by mail-wm0-f65.google.com with SMTP id v190so10888238wme.3
        for <util-linux@vger.kernel.org>; Sun, 05 Mar 2017 12:52:42 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 04/13] libblkid: ensure uninitialized variable is not used [clang]
Date: Sun,  5 Mar 2017 20:52:23 +0000
Message-Id: <20170305205232.24030-5-kerolasa@iki.fi>
In-Reply-To: <20170305205232.24030-1-kerolasa@iki.fi>
References: <20170305205232.24030-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Following condition can be true if minix file system is corrupt, and versio
number is found to be greater than 3.  It is fair to say described scenario
is unlikely.

libblkid/src/superblocks/minix.c:107:13: warning: variable 'zone_size' is
used uninitialized whenever
      'if' condition is false [-Wsometimes-uninitialized]
        } else if (version == 3) {
                   ^~~~~~~~~~~~
libblkid/src/superblocks/minix.c:121:6: note: uninitialized use occurs here
        if (zone_size != 0 || ninodes == 0 || ninodes == UINT32_MAX)
            ^~~~~~~~~

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libblkid/src/superblocks/minix.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/libblkid/src/superblocks/minix.c b/libblkid/src/superblocks/minix.c
index b8881e574..c47378d73 100644
--- a/libblkid/src/superblocks/minix.c
+++ b/libblkid/src/superblocks/minix.c
@@ -87,10 +87,9 @@ static int probe_minix(blkid_probe pr,
 	if (!data)
 		return errno ? -errno : 1;
 	version = get_minix_version(data, &swabme);
-	if (version < 1)
-		return 1;
-
-	if (version <= 2) {
+	switch (version) {
+	case 1:
+	case 2: {
 		struct minix_super_block *sb = (struct minix_super_block *) data;
 
 		uint16_t state = minix_swab16(swabme, sb->s_state);
@@ -104,7 +103,9 @@ static int probe_minix(blkid_probe pr,
 		zmaps   = minix_swab16(swabme, sb->s_zmap_blocks);
 		firstz  = minix_swab16(swabme, sb->s_firstdatazone);
 		zone_size = sb->s_log_zone_size;
-	} else if (version == 3) {
+		break;
+	}
+	case 3: {
 		struct minix3_super_block *sb = (struct minix3_super_block *) data;
 
 		zones = minix_swab32(swabme, sb->s_zones);
@@ -113,6 +114,10 @@ static int probe_minix(blkid_probe pr,
 		zmaps   = minix_swab16(swabme, sb->s_zmap_blocks);
 		firstz  = minix_swab16(swabme, sb->s_firstdatazone);
 		zone_size = sb->s_log_zone_size;
+		break;
+	}
+	default:
+		return 1;
 	}
 
 	/* sanity checks to be sure that the FS is really minix.
-- 
2.12.0

