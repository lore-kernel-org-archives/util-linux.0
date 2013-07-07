Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f47.google.com ([74.125.83.47]:39802 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGTz3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:55:29 -0400
Received: by mail-ee0-f47.google.com with SMTP id e49so2360959eek.6
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:55:28 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/34] lib/loopdev: assigned value is never read [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:26 +0100
Message-Id: <1373226889-3451-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/loopdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/loopdev.c b/lib/loopdev.c
index 3b65b5d..001a9ad 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -1234,7 +1234,6 @@ int loopcxt_setup_device(struct loopdev_cxt *lc)
 		goto err;
 
 	close(file_fd);
-	file_fd = -1;
 
 	memset(&lc->info, 0, sizeof(lc->info));
 	lc->has_info = 0;
-- 
1.8.3.2

