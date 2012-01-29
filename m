Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbef.dreamhost.com ([208.97.132.145]:57570 "EHLO
	homiemail-a61.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752110Ab2A2OZ2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 29 Jan 2012 09:25:28 -0500
Subject: [PATCH] whereis: move token assignment into loop syntax
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 29 Jan 2012 15:25:24 +0100
Message-ID: <1327847124.3305.1.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Sun, 29 Jan 2012 15:22:41 +0100

We can save a few lines and use for() naturally instead.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 misc-utils/whereis.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index 925cc93..eee4bf6 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -268,11 +268,7 @@ static void fillpath(void)
 		return;
 	pathcp = xstrdup(path);
 
-	for (tmp = pathcp; ; tmp = NULL) {
-		tok = strtok_r(tmp, ":", &key);
-		if (!tok)
-			break;
-
+	for (tmp = pathcp; tok = strtok_r(tmp, ":", &key); tmp = NULL) {
 		/* make sure we don't repeat the search path */
 		if (inpath(tok))
 			continue;
-- 
1.7.4.1



