Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:51715 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbaD0UGN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Apr 2014 16:06:13 -0400
Received: by mail-we0-f173.google.com with SMTP id w61so5496905wes.18
        for <util-linux@vger.kernel.org>; Sun, 27 Apr 2014 13:06:12 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/12] swapon: swaps with legacy version label are not supported
Date: Sun, 27 Apr 2014 21:05:34 +0100
Message-Id: <1398629138-31718-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/swapon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 6c422ce..c2d4795 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -344,8 +344,7 @@ err:
 
 static int swap_detect_signature(const char *buf, int *sig)
 {
-	if (memcmp(buf, "SWAP-SPACE", 10) == 0 ||
-            memcmp(buf, "SWAPSPACE2", 10) == 0)
+	if (memcmp(buf, SWAP_SIGNATURE, 10) == 0)
 		*sig = SIG_SWAPSPACE;
 
 	else if (memcmp(buf, "S1SUSPEND", 9) == 0 ||
-- 
1.9.2

