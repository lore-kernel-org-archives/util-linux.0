Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:64035 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbaLNRp2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Dec 2014 12:45:28 -0500
Received: by mail-wg0-f50.google.com with SMTP id a1so12811179wgh.23
        for <util-linux@vger.kernel.org>; Sun, 14 Dec 2014 09:45:27 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 12/16] chfn: simplify parse_passwd() by using strsep()
Date: Sun, 14 Dec 2014 17:44:08 +0000
Message-Id: <1418579052-29386-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chfn.c | 51 +++++++++++++++------------------------------------
 1 file changed, 15 insertions(+), 36 deletions(-)

diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index 9833591..7ba1a51 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -191,42 +191,21 @@ static int parse_argv(int argc, char *argv[], struct finfo *pinfo)
 static void parse_passwd(struct passwd *pw, struct finfo *pinfo)
 {
 	char *gecos;
-	char *cp;
-
-	if (pw) {
-		pinfo->pw = pw;
-		pinfo->username = pw->pw_name;
-		/* use pw_gecos - we take a copy since PAM destroys the original */
-		gecos = xstrdup(pw->pw_gecos);
-		cp = (gecos ? gecos : "");
-		pinfo->full_name = cp;
-		cp = strchr(cp, ',');
-		if (cp) {
-			*cp = 0, cp++;
-		} else
-			return;
-		pinfo->office = cp;
-		cp = strchr(cp, ',');
-		if (cp) {
-			*cp = 0, cp++;
-		} else
-			return;
-		pinfo->office_phone = cp;
-		cp = strchr(cp, ',');
-		if (cp) {
-			*cp = 0, cp++;
-		} else
-			return;
-		pinfo->home_phone = cp;
-		/*  extra fields contain site-specific information, and can
-		 *  not be changed by this version of chfn.  */
-		cp = strchr(cp, ',');
-		if (cp) {
-			*cp = 0, cp++;
-		} else
-			return;
-		pinfo->other = cp;
-	}
+
+	if (!pw)
+		return;
+	pinfo->pw = pw;
+	pinfo->username = pw->pw_name;
+	/* use pw_gecos - we take a copy since PAM destroys the original */
+	gecos = xstrdup(pw->pw_gecos);
+	/* extract known fields */
+	pinfo->full_name = strsep(&gecos, ",");
+	pinfo->office = strsep(&gecos, ",");
+	pinfo->office_phone = strsep(&gecos, ",");
+	pinfo->home_phone = strsep(&gecos, ",");
+	/*  extra fields contain site-specific information, and can
+	 *  not be changed by this version of chfn.  */
+	pinfo->other = strsep(&gecos, ",");
 }
 
 /*
-- 
2.1.3

