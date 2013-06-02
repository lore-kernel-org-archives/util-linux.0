Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:50907 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839Ab3FBRve (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Jun 2013 13:51:34 -0400
Received: by mail-wg0-f52.google.com with SMTP id z11so2519932wgg.31
        for <util-linux@vger.kernel.org>; Sun, 02 Jun 2013 10:51:33 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/19] lib: remove unused code
Date: Sun,  2 Jun 2013 18:51:07 +0100
Message-Id: <1370195485-27907-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
References: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/pager.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/lib/pager.c b/lib/pager.c
index 5cf8c03..c6e74e8 100644
--- a/lib/pager.c
+++ b/lib/pager.c
@@ -40,16 +40,6 @@ static inline void close_pair(int fd[2])
 	close(fd[1]);
 }
 
-static inline void dup_devnull(int to)
-{
-	int fd = open(NULL_DEVICE, O_RDWR);
-
-	if (fd < 0)
-		err(EXIT_FAILURE, _("cannot open %s"), NULL_DEVICE);
-	dup2(fd, to);
-	close(fd);
-}
-
 static int start_command(struct child_process *cmd)
 {
 	int need_in;
-- 
1.8.3

