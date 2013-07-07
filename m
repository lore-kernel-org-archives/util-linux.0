Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f174.google.com ([209.85.215.174]:62913 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096Ab3GGTzR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:55:17 -0400
Received: by mail-ea0-f174.google.com with SMTP id o10so2461413eaj.19
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:55:16 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/34] scriptreplay: use unlocked io
Date: Sun,  7 Jul 2013 20:54:22 +0100
Message-Id: <1373226889-3451-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/scriptreplay.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/term-utils/scriptreplay.c b/term-utils/scriptreplay.c
index 46468be..a366c35 100644
--- a/term-utils/scriptreplay.c
+++ b/term-utils/scriptreplay.c
@@ -31,6 +31,7 @@
 #include "closestream.h"
 #include "nls.h"
 #include "c.h"
+#include "unlocked-io.h"
 
 #define SCRIPT_MIN_DELAY 0.0001		/* from original sripreplay.pl */
 
@@ -229,6 +230,6 @@ main(int argc, char *argv[])
 
 	fclose(sfile);
 	fclose(tfile);
-	printf("\n");
+	fputs("\n", stdout);
 	exit(EXIT_SUCCESS);
 }
-- 
1.8.3.2

