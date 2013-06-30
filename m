Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f51.google.com ([74.125.82.51]:44912 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab3F3IoW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 30 Jun 2013 04:44:22 -0400
Received: by mail-wg0-f51.google.com with SMTP id e11so2833333wgh.6
        for <util-linux@vger.kernel.org>; Sun, 30 Jun 2013 01:44:21 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] ul: enhance command performance
Date: Sun, 30 Jun 2013 09:44:00 +0100
Message-Id: <1372581840-18966-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Avoid reseting, time after time, the memory which was not used.  Effect
of the change is below in before and after timings.

$ time ./ul </etc/services >/dev/null
real    0m0.320s
user    0m0.307s
sys     0m0.010s

$ time ./ul </etc/services >/dev/null
real    0m0.068s
user    0m0.050s
sys     0m0.017s

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/ul.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/text-utils/ul.c b/text-utils/ul.c
index 5710a55..572f1b8 100644
--- a/text-utils/ul.c
+++ b/text-utils/ul.c
@@ -491,11 +491,11 @@ static void initbuf(void)
 	if (obuf == NULL) {
 		/* First time. */
 		obuflen = BUFSIZ;
-		obuf = xmalloc(sizeof(struct CHAR) * obuflen);
+		obuf = xcalloc(obuflen, sizeof(struct CHAR));
 	}
 
 	/* assumes NORMAL == 0 */
-	memset(obuf, 0, sizeof(struct CHAR) * obuflen);
+	memset(obuf, 0, sizeof(struct CHAR) * col);
 	setcol(0);
 	maxcol = 0;
 	mode &= ALTSET;
-- 
1.8.3.1

