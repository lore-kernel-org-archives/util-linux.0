Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f182.google.com ([209.85.215.182]:53432 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGT4W (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:56:22 -0400
Received: by mail-ea0-f182.google.com with SMTP id d10so2520745eaj.13
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:56:21 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 28/34] sulogin: fix memory leak [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:43 +0100
Message-Id: <1373226889-3451-29-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

And make code a little bit more robust.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/sulogin-consoles.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/login-utils/sulogin-consoles.c b/login-utils/sulogin-consoles.c
index d0f0eab..a131e79 100644
--- a/login-utils/sulogin-consoles.c
+++ b/login-utils/sulogin-consoles.c
@@ -719,7 +719,7 @@ console:
 
 fallback:
 	if (fallback >= 0) {
-		const char *name;
+		const char *name, *n;
 		struct console *console;
 
 		if (device && *device != '\0')
@@ -729,7 +729,11 @@ fallback:
 		if (!name)
 			name = "/dev/tty";
 
-		rc = append_console(consoles, strdup(name));
+		n = strdup(name);
+		if (!n)
+			return -ENOMEM;
+		rc = append_console(consoles, n);
+		free(n);
 		if (rc < 0)
 			return rc;
 		if (list_empty(consoles))
-- 
1.8.3.2

