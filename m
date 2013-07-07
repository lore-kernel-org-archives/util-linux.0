Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f49.google.com ([74.125.83.49]:42883 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab3GGT4j (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:56:39 -0400
Received: by mail-ee0-f49.google.com with SMTP id b57so2371172eek.36
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:56:37 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 32/34] ul: use string printing function
Date: Sun,  7 Jul 2013 20:54:47 +0100
Message-Id: <1373226889-3451-33-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use of for loop and printing a string character by character is slower
than to print whole string with single function.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/ul.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/text-utils/ul.c b/text-utils/ul.c
index add419b..a69ac8a 100644
--- a/text-utils/ul.c
+++ b/text-utils/ul.c
@@ -448,8 +448,7 @@ static void overstrike(void)
 	putwchar('\r');
 	for (*cp = ' '; *cp == ' '; cp--)
 		*cp = 0;
-	for (cp = lbuf; *cp; cp++)
-		putwchar(*cp);
+	fputws(lbuf, stdout);
 	if (hadbold) {
 		putwchar('\r');
 		for (cp = lbuf; *cp; cp++)
@@ -482,8 +481,7 @@ static void iattr(void)
 		}
 	for (*cp = ' '; *cp == ' '; cp--)
 		*cp = 0;
-	for (cp = lbuf; *cp; cp++)
-		putwchar(*cp);
+	fputws(lbuf, stdout);
 	putwchar('\n');
 }
 
-- 
1.8.3.2

