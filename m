Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.133]:59437 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbcH3TAh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 30 Aug 2016 15:00:37 -0400
Received: from localhost ([91.7.171.187]) by mrelayeu.kundenserver.de
 (mreue005) with ESMTPSA (Nemesis) id 0MF8TX-1buVSs3hNL-00GKwy for
 <util-linux@vger.kernel.org>; Tue, 30 Aug 2016 21:00:33 +0200
Date: Tue, 30 Aug 2016 21:00:38 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] Set errno in is_loopdev on error
Message-ID: <20160830190038.GA32582@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The function is_loopdev does not set errno if the supplied string does
not reference a valid loop device. Fix this to avoid an error message
like this one:

losetup: /: failed to use device: Success

I prefer this one:

losetup: /: failed to use device: No such device

Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
---
 lib/loopdev.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/loopdev.c b/lib/loopdev.c
index b3941dd..a57e7a7 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -633,12 +633,13 @@ int is_loopdev(const char *device)
 {
 	struct stat st;
 
-	if (!device)
-		return 0;
-
-	return (stat(device, &st) == 0 &&
+	if (device && stat(device, &st) == 0 &&
 		S_ISBLK(st.st_mode) &&
-		major(st.st_rdev) == LOOPDEV_MAJOR);
+		major(st.st_rdev) == LOOPDEV_MAJOR)
+		return 1;
+
+	errno = ENODEV;
+	return 0;
 }
 
 /*
-- 
2.9.3

