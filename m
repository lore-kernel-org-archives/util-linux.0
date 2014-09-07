Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f172.google.com ([74.125.82.172]:60430 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbaIGMnW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Sep 2014 08:43:22 -0400
Received: by mail-we0-f172.google.com with SMTP id w62so1251992wes.31
        for <util-linux@vger.kernel.org>; Sun, 07 Sep 2014 05:43:21 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/17] newgrp: use xgetpass() and memset_s() to group password validation
Date: Sun,  7 Sep 2014 13:42:53 +0100
Message-Id: <1410093785-17537-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/newgrp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/login-utils/newgrp.c b/login-utils/newgrp.c
index 55dad1b..84e20b0 100644
--- a/login-utils/newgrp.c
+++ b/login-utils/newgrp.c
@@ -99,9 +99,10 @@ static int allow_setgid(struct passwd *pe, struct group *ge)
 	if (!(pwd = get_gshadow_pwd(ge->gr_name)))
 		pwd = ge->gr_passwd;
 
-	if (pwd && *pwd && (xpwd = getpass(_("Password: ")))) {
+	if (pwd && *pwd && (xpwd = xgetpass(_("Password: ")))) {
 		char *cbuf = crypt(xpwd, pwd);
 
+		memset_s(xpwd, strlen(xpwd), 0);
 		if (!cbuf)
 			warn(_("crypt() failed"));
 		else if (strcmp(pwd, cbuf) == 0)
-- 
2.1.0

