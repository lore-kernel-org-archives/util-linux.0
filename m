Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36226 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbcGQNAo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Jul 2016 09:00:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id x83so8718025wma.3
        for <util-linux@vger.kernel.org>; Sun, 17 Jul 2016 06:00:43 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 12/13] agetty: move unreachable code to pre-processor #else segment [oclint]
Date: Sun, 17 Jul 2016 14:00:14 +0100
Message-Id: <20160717130015.31760-13-kerolasa@iki.fi>
In-Reply-To: <20160717130015.31760-1-kerolasa@iki.fi>
References: <20160717130015.31760-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/agetty.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index d5d9a91..1089c77 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1424,7 +1424,7 @@ static char *xgetdomainname(void)
 {
 #ifdef HAVE_GETDOMAINNAME
 	char *name;
-	size_t sz = get_hostname_max() + 1;
+	const size_t sz = get_hostname_max() + 1;
 
 	name = malloc(sizeof(char) * sz);
 	if (!name)
@@ -1436,8 +1436,9 @@ static char *xgetdomainname(void)
 	}
 	name[sz - 1] = '\0';
 	return name;
-#endif
+#else
 	return NULL;
+#endif
 }
 
 static char *read_os_release(struct options *op, const char *varname)
-- 
2.9.0

