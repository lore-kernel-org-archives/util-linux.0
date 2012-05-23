Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:60247 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755290Ab2EWUgD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 23 May 2012 16:36:03 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 1/3] logger: avoid explicit fclose(stdout)
Date: Wed, 23 May 2012 16:35:58 -0400
Message-Id: <1337805360-16469-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is done for us via an atexit hook since c05a80ca6385b8. Avoids a
useless 'Write error' on exit whenever invoking the tool.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 misc-utils/logger.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 067272a..19b4c47 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -248,8 +248,6 @@ main(int argc, char **argv) {
 	else
 		LogSock = myopenlog(usock);
 
-	(void) fclose(stdout);
-
 	/* log input line if appropriate */
 	if (argc > 0) {
 		register char *p, *endp;
-- 
1.7.10.2

