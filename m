Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f54.google.com ([74.125.83.54]:36588 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab3GGT4o (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:56:44 -0400
Received: by mail-ee0-f54.google.com with SMTP id t10so2404031eei.41
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:56:43 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 34/34] more: use variable lenght printf field width to print blanks
Date: Sun,  7 Jul 2013 20:54:49 +0100
Message-Id: <1373226889-3451-35-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This makes program to run a little faster.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 62de6ad..1137ea7 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1059,8 +1059,7 @@ void erasep(register int col)
 		if (!dumb && eraseln)
 			my_putstring(eraseln);
 		else
-			for (col = promptlen - col; col > 0; col--)
-				putchar(' ');
+			printf("%*s", promptlen - col, "");
 	}
 	promptlen = 0;
 }
-- 
1.8.3.2

