Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:45567 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527AbaLVLrh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Dec 2014 06:47:37 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so6485823wgh.20
        for <util-linux@vger.kernel.org>; Mon, 22 Dec 2014 03:47:36 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 10/14] newgrp: simplify if else clauses
Date: Mon, 22 Dec 2014 11:47:13 +0000
Message-Id: <1419248837-4619-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
References: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The 'if' clauses that have termination as either of the control flow
results will never need 'else'.  Making the termination to happen true
flow is enough.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/newgrp.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/login-utils/newgrp.c b/login-utils/newgrp.c
index 58c9078..3f5c720 100644
--- a/login-utils/newgrp.c
+++ b/login-utils/newgrp.c
@@ -214,15 +214,12 @@ int main(int argc, char *argv[])
 			if (errno)
 				err(EXIT_FAILURE, _("no such group"));
 			else
-				/* No group */
 				errx(EXIT_FAILURE, _("no such group"));
-		} else {
-			if (allow_setgid(pw_entry, gr_entry)) {
-				if (setgid(gr_entry->gr_gid) < 0)
-					err(EXIT_FAILURE, _("setgid failed"));
-			} else
-				errx(EXIT_FAILURE, _("permission denied"));
 		}
+		if (!allow_setgid(pw_entry, gr_entry))
+			errx(EXIT_FAILURE, _("permission denied"));
+		if (setgid(gr_entry->gr_gid) < 0)
+			err(EXIT_FAILURE, _("setgid failed"));
 	}
 
 	if (setuid(getuid()) < 0)
-- 
2.2.1

