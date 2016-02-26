Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:60483 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752219AbcBZDDg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 25 Feb 2016 22:03:36 -0500
Received: from tenfore.ga-group.nl ([95.114.239.233]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0LiHc7-1aCETt3yeh-00nOa8 for
 <util-linux@vger.kernel.org>; Fri, 26 Feb 2016 04:03:35 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 06/14] newgrp: rename memset_s()
Date: Fri, 26 Feb 2016 04:03:29 +0100
Message-Id: <1456455812-19453-7-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

It's already defined in OSX standard c library.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 login-utils/newgrp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/login-utils/newgrp.c b/login-utils/newgrp.c
index 141b41b..56639d1 100644
--- a/login-utils/newgrp.c
+++ b/login-utils/newgrp.c
@@ -62,7 +62,7 @@ static char *xgetpass(FILE *input, const char *prompt)
 
 /* Ensure memory is set to value c without compiler optimization getting
  * into way that could happen with memset(3). */
-static int memset_s(void *v, size_t sz, const int c)
+static int xmemset_s(void *v, size_t sz, const int c)
 {
 	volatile unsigned char *p = v;
 
@@ -148,7 +148,7 @@ static int allow_setgid(const struct passwd *pe, const struct group *ge)
 	if (pwd && *pwd && (xpwd = xgetpass(stdin, _("Password: ")))) {
 		char *cbuf = crypt(xpwd, pwd);
 
-		memset_s(xpwd, strlen(xpwd), 0);
+		xmemset_s(xpwd, strlen(xpwd), 0);
 		free(xpwd);
 		if (!cbuf)
 			warn(_("crypt failed"));
-- 
1.8.4.5

