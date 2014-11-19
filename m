Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:39885 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbaKSLd3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 19 Nov 2014 06:33:29 -0500
Received: from ipb5.telenor.se (ipb5.telenor.se [195.54.127.168])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 980D0D95F
	for <util-linux@vger.kernel.org>; Wed, 19 Nov 2014 12:03:48 +0100 (CET)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] lib/colors: fix double free on error path
Date: Wed, 19 Nov 2014 12:03:35 +0100
Message-Id: <1416395016-17902-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The error path was a bit unclear on the semantics. The seq argument
would get freed but not the name argument. Then the caller frees
them both when the function returns an error.
This fixes the problem my making the function not touch the arguments
unless we're going to return success. Also improve the description
for this function to make it more obvious what the callers should expect.

Addresses: CID#77487 (on scan.coverity.com for JIghtuse/util-linux)
Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 lib/colors.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/colors.c b/lib/colors.c
index fb7d4b2..ab62c56 100644
--- a/lib/colors.c
+++ b/lib/colors.c
@@ -438,8 +438,9 @@ static int cn_sequence(const char *str, char **seq)
 
 
 /*
- * Adds one color sequence to array with color scheme,
- * @seq and @name have to be allocated strings
+ * Adds one color sequence to array with color scheme.
+ * When returning success (0) this function takes ownership of
+ * @seq and @name, which have to be allocated strings.
  */
 static int colors_add_scheme(struct ul_color_ctl *cc,
 			     char *name,
@@ -455,7 +456,6 @@ static int colors_add_scheme(struct ul_color_ctl *cc,
 	DBG(SCHEME, ul_debug("add '%s'", name));
 
 	rc = cn_sequence(seq0, &seq);
-	free(seq0);
 	if (rc)
 		return rc;
 
@@ -485,6 +485,8 @@ static int colors_add_scheme(struct ul_color_ctl *cc,
 		cc->schemes_sz = cc->nschemes + 10;
 	}
 
+	free(seq0);
+
 	/* add a new item */
 	cs = &cc->schemes[cc->nschemes++];
 	cs->name = name;
-- 
2.1.3

