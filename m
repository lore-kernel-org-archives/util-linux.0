Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f172.google.com ([209.85.215.172]:57159 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGT4Z (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:56:25 -0400
Received: by mail-ea0-f172.google.com with SMTP id q10so2491995eaj.17
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:56:23 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 29/34] agetty: fix memory leak [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:44 +0100
Message-Id: <1373226889-3451-30-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/agetty.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 054a1dd..5a75433 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -463,9 +463,11 @@ static char *replace_u(char *str, char *username)
 		}
 		sz = strlen(str);
 
-		if (p == str && sz == 2)
+		if (p == str && sz == 2) {
 			/* 'str' contains only '\u' */
+			free(old);
 			return username;
+		}
 
 		tp = entry = malloc(sz + usz);
 		if (!tp)
-- 
1.8.3.2

