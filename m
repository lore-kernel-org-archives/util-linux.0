Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f170.google.com ([74.125.82.170]:42424 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756331AbaGVWBK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jul 2014 18:01:10 -0400
Received: by mail-we0-f170.google.com with SMTP id w62so288476wes.15
        for <util-linux@vger.kernel.org>; Tue, 22 Jul 2014 15:01:09 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/10] logger: ensure program writes everything to syslog file descriptor
Date: Tue, 22 Jul 2014 23:00:50 +0100
Message-Id: <1406066459-4816-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
References: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It is fair assumption messages an user is asking to be wrote will be
attempted to be wrote as hard as possible.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index a862e55..6604d1a 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -51,6 +51,7 @@
 #include <netdb.h>
 #include <getopt.h>
 
+#include "all-io.h"
 #include "c.h"
 #include "closestream.h"
 #include "nls.h"
@@ -281,8 +282,8 @@ static void mysyslog(int fd, int logflags, int pri, char *tag, char *msg)
                snprintf(buf, sizeof(buf), "<%d>%.15s %.200s%s: %.400s",
 			pri, tp, cp, pid, msg);
 
-               if (write(fd, buf, strlen(buf)+1) < 0)
-                       return; /* error */
+	       if (write_all(fd, buf, strlen(buf)+1) < 0)
+		       warn(_("write failed"));
        }
 }
 
-- 
2.0.2

