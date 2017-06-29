Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:61776 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751545AbdF2CJM (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 28 Jun 2017 22:09:12 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbuIK-1e7PDm0FIC-00jFdv for
 <util-linux@vger.kernel.org>; Thu, 29 Jun 2017 04:09:10 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/3] lib/blkdev: remove support for Linux < 2.6
Date: Thu, 29 Jun 2017 04:09:07 +0200
Message-Id: <1498702148-11755-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498702148-11755-1-git-send-email-sweet_f_a@gmx.de>
References: <1498702148-11755-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Remove a hack for kernels between  2.4.15 and 2.4.17

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 lib/blkdev.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/lib/blkdev.c b/lib/blkdev.c
index 2b62f09..0616142 100644
--- a/lib/blkdev.c
+++ b/lib/blkdev.c
@@ -91,18 +91,9 @@ blkdev_get_size(int fd, unsigned long long *bytes)
 #endif
 
 #ifdef BLKGETSIZE64
-	{
-#ifdef __linux__
-		int ver = get_linux_version();
-
-		/* kernels 2.4.15-2.4.17, had a broken BLKGETSIZE64 */
-		if (ver >= KERNEL_VERSION (2,6,0) ||
-		   (ver >= KERNEL_VERSION (2,4,18) && ver < KERNEL_VERSION (2,5,0)))
+	if (ioctl(fd, BLKGETSIZE64, bytes) >= 0)
+		return 0;
 #endif
-			if (ioctl(fd, BLKGETSIZE64, bytes) >= 0)
-				return 0;
-	}
-#endif /* BLKGETSIZE64 */
 
 #ifdef BLKGETSIZE
 	{
-- 
1.8.5.6

