Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f182.google.com ([209.85.212.182]:61914 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbaLNRp0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Dec 2014 12:45:26 -0500
Received: by mail-wi0-f182.google.com with SMTP id h11so6889440wiw.15
        for <util-linux@vger.kernel.org>; Sun, 14 Dec 2014 09:45:24 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 10/16] chfn: use xasprintf() rather than bunch of strlen() and malloc() calls
Date: Sun, 14 Dec 2014 17:44:06 +0000
Message-Id: <1418579052-29386-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chfn.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index ca6f456..4746927 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -324,12 +324,8 @@ static int save_new_data(struct finfo *pinfo)
 		pinfo->other = "";
 
 	/* create the new gecos string */
-	len = (strlen(pinfo->full_name) + strlen(pinfo->office) +
-	       strlen(pinfo->office_phone) + strlen(pinfo->home_phone) +
-	       strlen(pinfo->other) + 4);
-	gecos = (char *)xmalloc(len + 1);
-	sprintf(gecos, "%s,%s,%s,%s,%s", pinfo->full_name, pinfo->office,
-		pinfo->office_phone, pinfo->home_phone, pinfo->other);
+	len = xasprintf(&gecos, "%s,%s,%s,%s,%s", pinfo->full_name, pinfo->office,
+		  pinfo->office_phone, pinfo->home_phone, pinfo->other);
 
 	/* remove trailing empty fields (but not subfields of pinfo->other) */
 	if (!pinfo->other[0]) {
@@ -351,6 +347,7 @@ static int save_new_data(struct finfo *pinfo)
 		       ("Finger information *NOT* changed.  Try again later.\n"));
 		return -1;
 	}
+	free(gecos);
 	printf(_("Finger information changed.\n"));
 	return 0;
 }
-- 
2.1.3

