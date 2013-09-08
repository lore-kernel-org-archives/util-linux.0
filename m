Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f182.google.com ([209.85.212.182]:63489 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557Ab3IHQJY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Sep 2013 12:09:24 -0400
Received: by mail-wi0-f182.google.com with SMTP id ez12so2517073wid.15
        for <util-linux@vger.kernel.org>; Sun, 08 Sep 2013 09:09:23 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/4] lib/fileutils: advice there is no point caching temporary files
Date: Sun,  8 Sep 2013 17:09:08 +0100
Message-Id: <1378656549-3729-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1378656549-3729-1-git-send-email-kerolasa@iki.fi>
References: <1378656549-3729-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/fileutils.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/fileutils.c b/lib/fileutils.c
index 92b474c..23cf80c 100644
--- a/lib/fileutils.c
+++ b/lib/fileutils.c
@@ -8,6 +8,7 @@
 #include <unistd.h>
 #include <sys/time.h>
 #include <sys/resource.h>
+#include <fcntl.h>
 
 #include "c.h"
 #include "fileutils.h"
@@ -43,6 +44,9 @@ int xmkstemp(char **tmpname, char *dir)
 		free(localtmp);
 		localtmp = NULL;
 	}
+#ifdef POSIX_FADV_NOREUSE
+	posix_fadvise(fd, 0, lseek(fd, 0, 0), POSIX_FADV_NOREUSE);
+#endif
 	*tmpname = localtmp;
 	return fd;
 }
-- 
1.8.4

