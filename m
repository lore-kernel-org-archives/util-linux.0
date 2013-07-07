Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f176.google.com ([209.85.215.176]:40695 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGTzs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:55:48 -0400
Received: by mail-ea0-f176.google.com with SMTP id z15so2496171ead.35
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:55:47 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 17/34] utmpdump: assigned values are never read [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:32 +0100
Message-Id: <1373226889-3451-18-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/utmpdump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index 3febeaf..8b6f17d 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -252,7 +252,7 @@ static void undump(FILE *in, FILE *out)
 	char s_addr[16], s_time[29], *linestart, *line;
 	int count = 0;
 
-	line = linestart = xmalloc(1024 * sizeof(*linestart));
+	linestart = xmalloc(1024 * sizeof(*linestart));
 	s_addr[15] = 0;
 	s_time[28] = 0;
 
@@ -266,7 +266,7 @@ static void undump(FILE *in, FILE *out)
 		line += gettok(line, ut.ut_line, sizeof(ut.ut_line), 1);
 		line += gettok(line, ut.ut_host, sizeof(ut.ut_host), 1);
 		line += gettok(line, s_addr, sizeof(s_addr) - 1, 1);
-		line += gettok(line, s_time, sizeof(s_time) - 1, 0);
+		gettok(line, s_time, sizeof(s_time) - 1, 0);
 
 		ut.ut_addr = inet_addr(s_addr);
 		ut.ut_time = strtotime(s_time);
-- 
1.8.3.2

