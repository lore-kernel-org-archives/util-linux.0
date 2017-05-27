Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36582 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754992AbdE0JEF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 27 May 2017 05:04:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id k15so7480696wmh.3
        for <util-linux@vger.kernel.org>; Sat, 27 May 2017 02:04:05 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] libfdisk: fix variable shadowing
Date: Sat, 27 May 2017 10:03:55 +0100
Message-Id: <20170527090355.28183-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

libfdisk/src/context.c: In function 'fdisk_assign_device':
libfdisk/src/context.c:549:7: warning: declaration of 'rc' shadows a previous local [-Wshadow]
libfdisk/src/context.c:542:10: note: shadowed declaration is here

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libfdisk/src/context.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/libfdisk/src/context.c b/libfdisk/src/context.c
index 52fd57987..5cf27a948 100644
--- a/libfdisk/src/context.c
+++ b/libfdisk/src/context.c
@@ -539,7 +539,7 @@ static void reset_context(struct fdisk_context *cxt)
 int fdisk_assign_device(struct fdisk_context *cxt,
 			const char *fname, int readonly)
 {
-	int fd, rc = 0;
+	int fd;
 
 	DBG(CXT, ul_debugobj(cxt, "assigning device %s", fname));
 	assert(cxt);
@@ -600,11 +600,13 @@ int fdisk_assign_device(struct fdisk_context *cxt,
 			      fname, readonly ? "READ-ONLY" : "READ-WRITE"));
 	return 0;
 fail:
-	rc = -errno;
-	if (fd >= 0)
-		close(fd);
-	DBG(CXT, ul_debugobj(cxt, "failed to assign device"));
-	return rc;
+	{
+		int rc = -errno;
+		if (fd >= 0)
+			close(fd);
+			DBG(CXT, ul_debugobj(cxt, "failed to assign device"));
+		return rc;
+	}
 }
 
 /**
-- 
2.13.0

