Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:65347 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080Ab2DEUky (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 5 Apr 2012 16:40:54 -0400
Received: by eekc41 with SMTP id c41so559672eek.19
        for <util-linux@vger.kernel.org>; Thu, 05 Apr 2012 13:40:53 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/3] eject: inform why open failed
Date: Thu,  5 Apr 2012 22:40:47 +0200
Message-Id: <1333658449-20112-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mostly to cover common case when user does not have permission to use
eject.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/eject.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 2d8b0cb..790ab3a 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -661,7 +661,7 @@ static int open_device(const char *name)
 	if (fd < 0)
 		fd = open(name, O_RDONLY|O_NONBLOCK);
 	if (fd == -1)
-		errx(EXIT_FAILURE, _("%s: open failed"), name);
+		err(EXIT_FAILURE, _("%s: open failed"), name);
 	return fd;
 }
 
-- 
1.7.9.6

