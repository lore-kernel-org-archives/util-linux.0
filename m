Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:46830 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760521Ab3DBTnI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Apr 2013 15:43:08 -0400
Received: by mail-wi0-f178.google.com with SMTP id ez12so815275wid.11
        for <util-linux@vger.kernel.org>; Tue, 02 Apr 2013 12:43:07 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/13] newgrp: use xstrdup to check allocation succeeded
Date: Tue,  2 Apr 2013 20:42:46 +0100
Message-Id: <1364931777-2645-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
References: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/newgrp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/login-utils/newgrp.c b/login-utils/newgrp.c
index 6269547..55dad1b 100644
--- a/login-utils/newgrp.c
+++ b/login-utils/newgrp.c
@@ -32,6 +32,7 @@
 #include "closestream.h"
 #include "nls.h"
 #include "pathnames.h"
+#include "xalloc.h"
 
 /* try to read password from gshadow */
 static char *get_gshadow_pwd(char *groupname)
@@ -67,7 +68,7 @@ static char *get_gshadow_pwd(char *groupname)
 		}
 	}
 	fclose(f);
-	return pwd ? strdup(pwd) : NULL;
+	return pwd ? xstrdup(pwd) : NULL;
 }
 
 static int allow_setgid(struct passwd *pe, struct group *ge)
-- 
1.8.2

