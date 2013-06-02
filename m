Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f51.google.com ([74.125.82.51]:55675 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970Ab3FBRwJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Jun 2013 13:52:09 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so2514855wgh.6
        for <util-linux@vger.kernel.org>; Sun, 02 Jun 2013 10:52:07 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/19] rev: simplify new line detection and impossible test
Date: Sun,  2 Jun 2013 18:51:17 +0100
Message-Id: <1370195485-27907-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
References: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The new line detection is earlier using only '\n' so there should not be
need to search for '\r' later.

The detection whether allocated address is pointing to null seems to be
unnecessary.  Assuming xmalloc() returned valid address space the address
should never be 0.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/rev.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/text-utils/rev.c b/text-utils/rev.c
index 0456c2b..1665772 100644
--- a/text-utils/rev.c
+++ b/text-utils/rev.c
@@ -154,11 +154,10 @@ int main(int argc, char *argv[])
 				len = wcslen(buf);
 			}
 
-			t = buf + len - 1 - (*(buf+len-1)=='\r' || *(buf+len-1)=='\n');
-			for ( ; t >= buf; --t) {
-				if (*t != 0)
-					putwchar(*t);
-			}
+			if (*(t = buf + len - 1) == '\n')
+				--t;
+			for ( ; buf <= t; --t)
+				putwchar(*t);
 			if (!feof(fp))
 				putwchar('\n');
 		}
-- 
1.8.3

