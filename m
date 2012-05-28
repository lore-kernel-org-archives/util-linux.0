Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:58810 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab2E1SDH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 28 May 2012 14:03:07 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] logger: use memcpy instead of bcopy
Date: Mon, 28 May 2012 14:02:59 -0400
Message-Id: <1338228179-14512-1-git-send-email-dreisner@archlinux.org>
In-Reply-To: <20120527232300.GA15566@gaara.hadrons.org>
References: <20120527232300.GA15566@gaara.hadrons.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

bcopy is marked legacy in POSIX.1-2001 and should not be used.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 misc-utils/logger.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 19b4c47..0a935f6 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -96,7 +96,7 @@ udpopenlog(const char *servername, uint16_t port) {
 	if ((fd = socket(AF_INET, SOCK_DGRAM , 0)) == -1)
 		err(EXIT_FAILURE, _("socket"));
 
-	bcopy(serverhost->h_addr,&s_addr.sin_addr,serverhost->h_length);
+	memcpy(&s_addr.sin_addr, serverhost->h_addr, serverhost->h_length);
         s_addr.sin_family=AF_INET;
         s_addr.sin_port=htons(port);
 
-- 
1.7.10.2

