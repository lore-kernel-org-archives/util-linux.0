Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33195 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435AbbFSTlO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 19 Jun 2015 15:41:14 -0400
Received: by lbbvz5 with SMTP id vz5so30043598lbb.0
        for <util-linux@vger.kernel.org>; Fri, 19 Jun 2015 12:41:12 -0700 (PDT)
From: Boris Egorov <egorov@linux.com>
To: util-linux@vger.kernel.org
Cc: Boris Egorov <egorov@linux.com>
Subject: [PATCH 2/3] libblkid/whereis: simplify some conditions [cppcheck]
Date: Sat, 20 Jun 2015 01:41:00 +0600
Message-Id: <1434742861-11704-3-git-send-email-egorov@linux.com>
In-Reply-To: <1434742861-11704-1-git-send-email-egorov@linux.com>
References: <1434742861-11704-1-git-send-email-egorov@linux.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[misc-utils/whereis.c:466]: (style) Redundant condition: uflag.
'A && (!A || B)' is equivalent to 'A || B'
[libblkid/src/tag.c:373]: (style) Redundant condition: dev.
'A && (!A || B)' is equivalent to 'A || B'

Signed-off-by: Boris Egorov <egorov@linux.com>
---
 libblkid/src/tag.c   | 2 +-
 misc-utils/whereis.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libblkid/src/tag.c b/libblkid/src/tag.c
index 6af8062..281612a 100644
--- a/libblkid/src/tag.c
+++ b/libblkid/src/tag.c
@@ -370,7 +370,7 @@ try_again:
 	}
 	if (dev && !(dev->bid_flags & BLKID_BID_FL_VERIFIED)) {
 		dev = blkid_verify(cache, dev);
-		if (!dev || (dev && (dev->bid_flags & BLKID_BID_FL_VERIFIED)))
+		if (!dev || dev->bid_flags & BLKID_BID_FL_VERIFIED)
 			goto try_again;
 	}
 
diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index 96a930e..697d666 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -463,7 +463,7 @@ static void lookup(const char *pattern, struct wh_dirlist *ls, int want)
 
 	free(wait);
 
-	if (!uflag || (uflag && count > 1))
+	if (!uflag || count > 1)
 		putchar('\n');
 	return;
 }
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
