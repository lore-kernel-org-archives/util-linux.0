Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33902 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757665AbcGZSGI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 26 Jul 2016 14:06:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so2879543wma.1
        for <util-linux@vger.kernel.org>; Tue, 26 Jul 2016 11:06:07 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/2] chfn: stop adding trailing commas to gecos
Date: Tue, 26 Jul 2016 19:06:02 +0100
Message-Id: <20160726180602.4914-2-kerolasa@iki.fi>
In-Reply-To: <20160726180602.4914-1-kerolasa@iki.fi>
References: <20160726180602.4914-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The other field should not appear automatically, it causes not-automatically
trimmed trailing commas to appear in gecos.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chfn.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index 2d58fc3..c56f510 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -346,7 +346,7 @@ static void add_missing(struct chfn_control *ctl)
 	ctl->newf.office = find_field(ctl->newf.office, ctl->oldf.office);
 	ctl->newf.office_phone = find_field(ctl->newf.office_phone, ctl->oldf.office_phone);
 	ctl->newf.home_phone = find_field(ctl->newf.home_phone, ctl->oldf.home_phone);
-	ctl->newf.other = find_field(ctl->newf.other, ctl->oldf.other);
+	ctl->newf.other = ctl->oldf.other ? ctl->oldf.other : NULL;
 	printf("\n");
 }
 
@@ -361,12 +361,13 @@ static int save_new_data(struct chfn_control *ctl)
 	int len;
 
 	/* create the new gecos string */
-	len = xasprintf(&gecos, "%s,%s,%s,%s,%s",
+	len = xasprintf(&gecos, "%s,%s,%s,%s%s%s",
 			ctl->newf.full_name,
 			ctl->newf.office,
 			ctl->newf.office_phone,
 			ctl->newf.home_phone,
-			ctl->newf.other);
+			ctl->newf.other ? "," : "",
+			ctl->newf.other ? ctl->newf.other : "");
 
 	/* remove trailing empty fields (but not subfields of ctl->newf.other) */
 	if (!ctl->newf.other || ctl->trim) {
-- 
2.9.0

