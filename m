Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:47586 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab3DMT4h (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:56:37 -0400
Received: by mail-wg0-f52.google.com with SMTP id n12so3651997wgh.7
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:56:36 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 32/33] swapon: check writing to a file descriptor was successful
Date: Sat, 13 Apr 2013 20:55:00 +0100
Message-Id: <1365882901-11429-33-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/swapon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index d5b7e37..f1e2433 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -323,7 +323,10 @@ static int swap_rewrite_signature(const char *devname, unsigned int pagesize)
 
 	rc  = 0;
 err:
-	close(fd);
+	if (close_fd(fd) != 0) {
+		warn(_("write failed: %s"), devname);
+		rc = -1;
+	}
 	return rc;
 }
 
-- 
1.8.2.1

