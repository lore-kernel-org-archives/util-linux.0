Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f169.google.com ([74.125.82.169]:38745 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282Ab2L1V3D (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 28 Dec 2012 16:29:03 -0500
Received: by mail-we0-f169.google.com with SMTP id t49so5313321wey.28
        for <util-linux@vger.kernel.org>; Fri, 28 Dec 2012 13:29:01 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/4] script: search shell from path, when necessary
Date: Fri, 28 Dec 2012 21:23:40 +0000
Message-Id: <1356729823-729-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Addresses: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=518532
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 94a20da..983930f 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -445,11 +445,17 @@ doshell(void) {
 	 */
 	signal(SIGTERM, SIG_DFL);
 
-	if (cflg)
-		execl(shell, shname, "-c", cflg, NULL);
-	else
-		execl(shell, shname, "-i", NULL);
-
+	if (access(shell, X_OK) == 0) {
+		if (cflg)
+			execl(shell, shname, "-c", cflg, NULL);
+		else
+			execl(shell, shname, "-i", NULL);
+	} else {
+		if (cflg)
+			execlp(shname, "-c", cflg, NULL);
+		else
+			execlp(shname, "-i", NULL);
+	}
 	warn(_("failed to execute %s"), shell);
 	fail();
 }
-- 
1.8.0.3

