Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f181.google.com ([209.85.215.181]:64873 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab3GGT4l (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:56:41 -0400
Received: by mail-ea0-f181.google.com with SMTP id a15so2524503eae.40
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:56:40 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 33/34] column: dereference of null pointer [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:48 +0100
Message-Id: <1373226889-3451-34-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/column.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/text-utils/column.c b/text-utils/column.c
index 25a2286..3909887 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -392,7 +392,7 @@ static int input(FILE *fp, int *maxlength, wchar_t ***list, int *entries)
 			continue;
 		}
 		lineno++;
-		if (!feof(fp))
+		if (!feof(fp) && p)
 			*p = '\0';
 		len = wcs_width(buf);	/* len = p - buf; */
 		if (*maxlength < len)
-- 
1.8.3.2

