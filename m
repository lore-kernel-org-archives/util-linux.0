Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44503 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933051Ab1IOOSF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 Sep 2011 10:18:05 -0400
Received: by wyh22 with SMTP id 22so2710487wyh.19
        for <util-linux@vger.kernel.org>; Thu, 15 Sep 2011 07:18:03 -0700 (PDT)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 1/2] lib: [loopdev.c] fix use of logical '&&' with constant operand
Date: Thu, 15 Sep 2011 16:17:45 +0200
Message-Id: <1316096266-14692-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Found by clang.

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 lib/loopdev.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/loopdev.c b/lib/loopdev.c
index 81b7d2d..7c095ee 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -116,7 +116,7 @@ int loopcxt_init(struct loopdev_cxt *lc, int flags)
 	lc->flags = flags;
 	loopcxt_set_device(lc, NULL);
 
-	if (!(lc->flags && LOOPDEV_FL_NOSYSFS) &&
+	if (!(lc->flags & LOOPDEV_FL_NOSYSFS) &&
 	    get_linux_version() >= KERNEL_VERSION(2,6,37))
 		/*
 		 * Use only sysfs for basic information about loop devices
@@ -244,7 +244,7 @@ int loopcxt_init_iterator(struct loopdev_cxt *lc, int flags)
 		/*
 		 * Check for /dev/loop/<N> subdirectory
 		 */
-		if (!(lc->flags && LOOPDEV_FL_DEVSUBDIR) &&
+		if (!(lc->flags & LOOPDEV_FL_DEVSUBDIR) &&
 		    stat(_PATH_DEV_LOOP, &st) == 0 && S_ISDIR(st.st_mode))
 			lc->flags |= LOOPDEV_FL_DEVSUBDIR;
 
-- 
1.7.3.4

