Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f170.google.com ([74.125.82.170]:59974 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbaD0UGK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Apr 2014 16:06:10 -0400
Received: by mail-we0-f170.google.com with SMTP id w61so5604100wes.1
        for <util-linux@vger.kernel.org>; Sun, 27 Apr 2014 13:06:10 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/12] include/swapheader.h: ensure type sizes
Date: Sun, 27 Apr 2014 21:05:33 +0100
Message-Id: <1398629138-31718-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use consistently the same type sizes as in libblkid and kernel.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/swapheader.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/swapheader.h b/include/swapheader.h
index 1fdd133..1e1090c 100644
--- a/include/swapheader.h
+++ b/include/swapheader.h
@@ -6,15 +6,17 @@
 #define SWAP_LABEL_LENGTH 16
 #define SWAP_HEADER_SIZE 1540
 
+#include <stdint.h>
+
 struct swap_header_v1_2 {
 	char	      bootbits[1024];    /* Space for disklabel etc. */
-	unsigned int  version;
-	unsigned int  last_page;
-	unsigned int  nr_badpages;
+	uint32_t      version;
+	uint32_t      last_page;
+	uint32_t      nr_badpages;
 	unsigned char uuid[SWAP_UUID_LENGTH];
 	char	      volume_name[SWAP_LABEL_LENGTH];
-	unsigned int  padding[117];
-	unsigned int  badpages[1];
+	uint32_t      padding[117];
+	uint32_t      badpages[1];
 };
 
 #endif /* _SWAPHEADER_H */
-- 
1.9.2

