Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38367 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbbJaTVb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 31 Oct 2015 15:21:31 -0400
Received: by wmeg8 with SMTP id g8so33290316wme.1
        for <util-linux@vger.kernel.org>; Sat, 31 Oct 2015 12:21:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 01/12] login: fix stat(2) race
Date: Sat, 31 Oct 2015 19:21:13 +0000
Message-Id: <1446319284-24778-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
References: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/login.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index 0e45de7..b708467 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -256,13 +256,11 @@ static void motd(void)
 		struct stat st;
 		int fd;
 
-		if (stat(motdfile, &st) || !st.st_size)
-			continue;
 		fd = open(motdfile, O_RDONLY, 0);
 		if (fd < 0)
 			continue;
-
-		sendfile(fileno(stdout), fd, NULL, st.st_size);
+		if (!fstat(fd, &st) && st.st_size)
+			sendfile(fileno(stdout), fd, NULL, st.st_size);
 		close(fd);
 	}
 
-- 
2.6.2

