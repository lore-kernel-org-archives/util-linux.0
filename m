Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f44.google.com ([74.125.83.44]:57610 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGTzo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:55:44 -0400
Received: by mail-ee0-f44.google.com with SMTP id c13so2423904eek.3
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:55:42 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 16/34] more: assigned value is never read [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:31 +0100
Message-Id: <1373226889-3451-17-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index bdc5bf9..62de6ad 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1581,7 +1581,7 @@ void search(char buf[], FILE *file, register int n)
 	long startline = Ftell(file);
 	register long line1 = startline;
 	register long line2 = startline;
-	register long line3 = startline;
+	register long line3;
 	register int lncount;
 	int saveln, rc;
 	regex_t re;
-- 
1.8.3.2

