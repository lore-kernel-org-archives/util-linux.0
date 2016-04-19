Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33465 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbcDSUfx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 19 Apr 2016 16:35:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id y144so8321569wmd.0
        for <util-linux@vger.kernel.org>; Tue, 19 Apr 2016 13:35:52 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/5] setpwnam: fix memory leak
Date: Tue, 19 Apr 2016 21:35:43 +0100
Message-Id: <1461098145-2988-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1461098145-2988-1-git-send-email-kerolasa@iki.fi>
References: <1461098145-2988-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Found with scan-build.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/setpwnam.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/login-utils/setpwnam.c b/login-utils/setpwnam.c
index 9f39d01..0616c79 100644
--- a/login-utils/setpwnam.c
+++ b/login-utils/setpwnam.c
@@ -166,6 +166,7 @@ int setpwnam(struct passwd *pwd, const char *prefix)
 		goto fail;
 	/* finally:  success */
 	ulckpwdf();
+	free(linebuf);
 	return 0;
 
  fail:
-- 
2.8.0

