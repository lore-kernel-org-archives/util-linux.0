Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:63513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750738AbcLAIwQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Dec 2016 03:52:16 -0500
Received: from tenfore.ga-group.nl ([217.186.11.144]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MOTRh-1c6bvs0zH3-005m5F for <util-linux@vger.kernel.org>; Thu, 01 Dec 2016
 09:52:13 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 01/11] last: include libgen.h for basename(3p)
Date: Thu,  1 Dec 2016 09:52:04 +0100
Message-Id: <1480582332-17407-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
References: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 login-utils/last.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 6d0e892..90eee68 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -40,6 +40,7 @@
 #include <netinet/in.h>
 #include <netdb.h>
 #include <arpa/inet.h>
+#include <libgen.h>
 
 #include "c.h"
 #include "nls.h"
@@ -877,7 +878,11 @@ static void process_wtmp_file(const struct last_control *ctl,
 		}
 	}
 
-	printf(_("\n%s begins %s"), basename(filename), ctime(&begintime));
+	{
+		char* tmp = xstrdup(filename);
+		printf(_("\n%s begins %s"), basename(tmp), ctime(&begintime));
+		free(tmp);
+	}
 	fclose(fp);
 
 	for (p = ulist; p; p = next) {
-- 
1.8.5.6

