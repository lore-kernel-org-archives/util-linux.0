Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:40249 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760521Ab3DBTnT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Apr 2013 15:43:19 -0400
Received: by mail-wg0-f42.google.com with SMTP id k13so3512308wgh.5
        for <util-linux@vger.kernel.org>; Tue, 02 Apr 2013 12:43:18 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/13] losetup: allow -j option argument to be relative path
Date: Tue,  2 Apr 2013 20:42:50 +0100
Message-Id: <1364931777-2645-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
References: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/losetup.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index 45e46c8..8f3614e 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -23,6 +23,7 @@
 #include "closestream.h"
 #include "optutils.h"
 #include "xalloc.h"
+#include "canonicalize.h"
 
 enum {
 	A_CREATE = 1,		/* setup a new device */
@@ -167,9 +168,15 @@ static int show_all_loops(struct loopdev_cxt *lc, const char *file,
 		st = NULL;
 
 	while (loopcxt_next(lc) == 0) {
-
-		if (file && !loopcxt_is_used(lc, st, file, offset, flags))
-			continue;
+		if (file && !loopcxt_is_used(lc, st, file, offset, flags)) {
+			char *canonized;
+			int ret;
+			canonized = canonicalize_path(file);
+			ret = loopcxt_is_used(lc, st, canonized, offset, flags);
+			free(canonized);
+			if (!ret)
+				continue;
+		}
 		printf_loopdev(lc);
 	}
 	loopcxt_deinit_iterator(lc);
-- 
1.8.2

