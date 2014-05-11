Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:37062 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934100AbaEKT1D (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 15:27:03 -0400
Received: by mail-wg0-f46.google.com with SMTP id n12so6052180wgh.5
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 12:27:01 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/12] logger: fail when io vector number exceeds maximum
Date: Sun, 11 May 2014 20:26:41 +0100
Message-Id: <1399836409-7769-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
References: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier version silently failed without logging anything.

$ logger --journald=/etc/services ; echo $?
1

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index f3bdc90..fccba38 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -37,6 +37,7 @@
  */
 
 #include <errno.h>
+#include <limits.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <time.h>
@@ -231,6 +232,8 @@ static int journald_entry(FILE *fp)
 		}
 		if (lines == vectors) {
 			vectors *= 2;
+			if (IOV_MAX < vectors)
+				errx(EXIT_FAILURE, _("maximum input lines (%d) exceeded"), IOV_MAX);
 			iovec = xrealloc(iovec, vectors * sizeof(struct iovec));
 		}
 		iovec[lines].iov_base = buf;
@@ -415,7 +418,9 @@ int main(int argc, char **argv)
 		int ret = journald_entry(jfd);
 		if (stdin != jfd)
 			fclose(jfd);
-		return ret ? EXIT_FAILURE : EXIT_SUCCESS;
+		if (ret)
+			errx(EXIT_FAILURE, "journald entry could not be wrote");
+		return EXIT_SUCCESS;
 	}
 #endif
 	if (server)
-- 
1.9.2

