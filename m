Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f172.google.com ([209.85.215.172]:63131 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab3GGT4b (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:56:31 -0400
Received: by mail-ea0-f172.google.com with SMTP id q10so2492053eaj.17
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:56:29 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 31/34] ul: use correct types
Date: Sun,  7 Jul 2013 20:54:46 +0100
Message-Id: <1373226889-3451-32-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/ul.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/text-utils/ul.c b/text-utils/ul.c
index c2c19f6..add419b 100644
--- a/text-utils/ul.c
+++ b/text-utils/ul.c
@@ -464,11 +464,11 @@ static void iattr(void)
 {
 	register int i;
 #ifdef __GNUC__
-	register char *lbuf = __builtin_alloca((maxcol+1)*sizeof(char));
+	register wchar_t *lbuf = __builtin_alloca((maxcol+1)*sizeof(wchar_t));
 #else
-	char lbuf[BUFSIZ];
+	wchar_t lbuf[BUFSIZ];
 #endif
-	register char *cp = lbuf;
+	register wchar_t *cp = lbuf;
 
 	for (i = 0; i < maxcol; i++)
 		switch (obuf[i].c_mode) {
-- 
1.8.3.2

