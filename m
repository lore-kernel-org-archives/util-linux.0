Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f180.google.com ([74.125.82.180]:55850 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701Ab3DMTzs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:55:48 -0400
Received: by mail-we0-f180.google.com with SMTP id r5so2759638wey.11
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:55:47 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 14/33] libblkid: check writing to a file was successful
Date: Sat, 13 Apr 2013 20:54:42 +0100
Message-Id: <1365882901-11429-15-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libblkid/src/evaluate.c | 4 +++-
 libblkid/src/save.c     | 7 ++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/libblkid/src/evaluate.c b/libblkid/src/evaluate.c
index 8853009..8ef9277 100644
--- a/libblkid/src/evaluate.c
+++ b/libblkid/src/evaluate.c
@@ -24,6 +24,7 @@
 
 #include "pathnames.h"
 #include "canonicalize.h"
+#include "closestream.h"
 
 #include "blkidP.h"
 
@@ -123,7 +124,8 @@ int blkid_send_uevent(const char *devname, const char *action)
 		rc = 0;
 		if (fputs(action, f) >= 0)
 			rc = 0;
-		fclose(f);
+		if (close_stream(f) != 0)
+			DBG(EVALUATE, blkid_debug("write failed: %s", uevent));
 	}
 	DBG(EVALUATE, blkid_debug("%s: send uevent %s",
 			uevent, rc == 0 ? "SUCCES" : "FAILED"));
diff --git a/libblkid/src/save.c b/libblkid/src/save.c
index 86eda6c..424017a 100644
--- a/libblkid/src/save.c
+++ b/libblkid/src/save.c
@@ -21,6 +21,9 @@
 #ifdef HAVE_ERRNO_H
 #include <errno.h>
 #endif
+
+#include "closestream.h"
+
 #include "blkidP.h"
 
 static int save_dev(blkid_dev dev, FILE *file)
@@ -148,7 +151,9 @@ int blkid_flush_cache(blkid_cache cache)
 		ret = 1;
 	}
 
-	fclose(file);
+	if (close_stream(file) != 0)
+		DBG(SAVE, blkid_debug("write failed: %s", filename));
+
 	if (opened != filename) {
 		if (ret < 0) {
 			unlink(opened);
-- 
1.8.2.1

