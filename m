Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:38427 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbaIGMn4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Sep 2014 08:43:56 -0400
Received: by mail-we0-f173.google.com with SMTP id u56so330324wes.32
        for <util-linux@vger.kernel.org>; Sun, 07 Sep 2014 05:43:55 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 17/17] setarch: remove unreachable code
Date: Sun,  7 Sep 2014 13:43:05 +0100
Message-Id: <1410093785-17537-18-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Architectures are protected using '#if defined' clauses, making the code
in this removal to be impossible to reach.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/setarch.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index ed2a6a6..43594ad 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -233,15 +233,6 @@ static int set_arch(const char *pers, unsigned long options, int list)
 	pers_value = transitions[i].perval | options;
 	if (personality(pers_value) == -EINVAL)
 		return 1;
-	uname(&un);
-	if (transitions[i].result_arch && strcmp(un.machine, transitions[i].result_arch)) {
-		if (strcmp(transitions[i].result_arch, "i386")
-		    || (strcmp(un.machine, "i486")
-			&& strcmp(un.machine, "i586")
-			&& strcmp(un.machine, "i686")
-			&& strcmp(un.machine, "athlon")))
-			errx(EXIT_FAILURE, _("%s: Unrecognized architecture"), pers);
-	}
 	return 0;
 }
 
-- 
2.1.0

