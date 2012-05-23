Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:60248 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756359Ab2EWUgD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 23 May 2012 16:36:03 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 2/3] logger: use memcpy instead of bcopy
Date: Wed, 23 May 2012 16:35:59 -0400
Message-Id: <1337805360-16469-2-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1337805360-16469-1-git-send-email-dreisner@archlinux.org>
References: <1337805360-16469-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

bcopy is marked legacy in POSIX.1-2001 and should not be used.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 misc-utils/logger.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 19b4c47..a187227 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -96,7 +96,7 @@ udpopenlog(const char *servername, uint16_t port) {
 	if ((fd = socket(AF_INET, SOCK_DGRAM , 0)) == -1)
 		err(EXIT_FAILURE, _("socket"));
 
-	bcopy(serverhost->h_addr,&s_addr.sin_addr,serverhost->h_length);
+	memcpy(serverhost->h_addr,&s_addr.sin_addr,serverhost->h_length);
         s_addr.sin_family=AF_INET;
         s_addr.sin_port=htons(port);
 
-- 
1.7.10.2

