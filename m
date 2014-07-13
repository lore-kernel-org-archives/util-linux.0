Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f179.google.com ([74.125.82.179]:60163 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbaGMUZi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Jul 2014 16:25:38 -0400
Received: by mail-we0-f179.google.com with SMTP id u57so1036049wes.24
        for <util-linux@vger.kernel.org>; Sun, 13 Jul 2014 13:25:37 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/14] libfdisk: do not do the same thing twice in single if statement
Date: Sun, 13 Jul 2014 21:24:51 +0100
Message-Id: <1405283093-28182-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
References: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The second argument was very likely meant to be 'be->offset'.
Maintainers review & sign-off will further verify this change being
correct.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libfdisk/src/dos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libfdisk/src/dos.c b/libfdisk/src/dos.c
index 5453eb3..aff9755 100644
--- a/libfdisk/src/dos.c
+++ b/libfdisk/src/dos.c
@@ -1736,7 +1736,7 @@ static int cmp_ebr_offsets(const void *a, const void *b)
 	struct pte *ae = (struct pte *) a,
 		   *be = (struct pte *) b;
 
-	if (ae->offset == 0 && ae->offset == 0)
+	if (ae->offset == 0 && be->offset == 0)
 		return 0;
 	if (ae->offset == 0)
 		return 1;
-- 
2.0.1

