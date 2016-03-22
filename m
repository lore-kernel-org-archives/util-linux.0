Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:34166 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753349AbcCVJjH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 22 Mar 2016 05:39:07 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id AD130AB5D
	for <util-linux@vger.kernel.org>; Tue, 22 Mar 2016 09:39:04 +0000 (UTC)
From: Werner Fink <werner@suse.de>
To: util-linux@vger.kernel.org
Cc: Werner Fink <werner@suse.de>
Subject: [PATCH] Always make echo work after performing getpasswd even if root account is locked
Date: Tue, 22 Mar 2016 10:38:59 +0100
Message-Id: <1458639539-3457-1-git-send-email-werner@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If the root account is locked and no password was provided then the terminal
line is not set back to do echo of the input. This correct a small overlook
in commit 7ff1162e67164cb4ece19dd809c26272461aa254

Signed-off-by: Werner Fink <werner@suse.de>
---
 login-utils/sulogin.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git login-utils/sulogin.c login-utils/sulogin.c
index b2c778a..7311ec1 100644
--- login-utils/sulogin.c
+++ login-utils/sulogin.c
@@ -739,8 +739,7 @@ quit:
 	alarm(0);
 	if (tc)
 		tcsetattr(fd, TCSAFLUSH, &con->tio);
-	if (ret && *ret != '\0')
-		tcfinal(con);
+	tcfinal(con);
 	printf("\r\n");
 out:
 	return ret;
-- 
2.6.2

