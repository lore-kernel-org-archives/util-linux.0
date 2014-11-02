Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:56716 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbaKBU1B (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Nov 2014 15:27:01 -0500
Received: by mail-wi0-f170.google.com with SMTP id q5so4680748wiv.3
        for <util-linux@vger.kernel.org>; Sun, 02 Nov 2014 12:26:59 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/8] mkswap: remove unnecessary size check
Date: Sun,  2 Nov 2014 20:26:26 +0000
Message-Id: <1414959991-8369-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1414959991-8369-1-git-send-email-kerolasa@iki.fi>
References: <1414959991-8369-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkswap.c  | 6 ------
 include/swapheader.h | 2 --
 2 files changed, 8 deletions(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index a1b864d..b2713ab 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -115,12 +115,6 @@ write_uuid_and_label(unsigned char *uuid, char *volume_name)
 {
 	struct swap_header_v1_2 *h;
 
-	/* Sanity check */
-	if (sizeof(struct swap_header_v1_2) != SWAP_HEADER_SIZE) {
-		warnx(_("Bad swap header size, no label written."));
-		return;
-	}
-
 	h = (struct swap_header_v1_2 *) signature_page;
 	if (uuid)
 		memcpy(h->uuid, uuid, sizeof(h->uuid));
diff --git a/include/swapheader.h b/include/swapheader.h
index 1d91e41..3fce0d0 100644
--- a/include/swapheader.h
+++ b/include/swapheader.h
@@ -20,6 +20,4 @@ struct swap_header_v1_2 {
 	uint32_t      badpages[1];
 };
 
-#define SWAP_HEADER_SIZE (sizeof(struct swap_header_v1_2))
-
 #endif /* _SWAPHEADER_H */
-- 
2.1.3

