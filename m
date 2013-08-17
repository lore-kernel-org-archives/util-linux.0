Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f49.google.com ([74.125.82.49]:55130 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab3HQSQ0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Aug 2013 14:16:26 -0400
Received: by mail-wg0-f49.google.com with SMTP id y10so2447612wgg.16
        for <util-linux@vger.kernel.org>; Sat, 17 Aug 2013 11:16:25 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/16] last: use carefulput() for printable character output
Date: Sat, 17 Aug 2013 19:15:12 +0100
Message-Id: <1376763321-22782-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
References: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 0f475f2..f08632b 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -45,6 +45,7 @@
 #include "pathnames.h"
 #include "xalloc.h"
 #include "closestream.h"
+#include "carefulputc.h"
 
 #ifndef SHUTDOWN_TIME
 # define SHUTDOWN_TIME 254
@@ -396,12 +397,8 @@ static int list(struct utmp *p, time_t t, int what)
 	/*
 	 *	Print out "final" string safely.
 	 */
-	for (s = final; *s; s++) {
-		if (*s == '\n' || (*s >= 32 && (unsigned char)*s <= 126))
-			putchar(*s);
-		else
-			putchar('*');
-	}
+	for (s = final; *s; s++)
+		carefulputc(*s, stdout, '*');
 
 	if (len < 0 || (size_t)len >= sizeof(final))
 		putchar('\n');
-- 
1.8.3.4

