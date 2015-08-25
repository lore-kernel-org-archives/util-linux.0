Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:56616
	"EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755533AbbHYQ1v (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 25 Aug 2015 12:27:51 -0400
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH 1/2] lib/strutil: fix parse_switch resource leak [coverity scan]
Date: Tue, 25 Aug 2015 18:27:40 +0200
Message-Id: <1440520061-23922-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 lib/strutils.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/strutils.c b/lib/strutils.c
index b033f75..30dc090 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -198,10 +198,13 @@ int parse_switch(const char *arg, const char *errmesg, ...)
 		if (!b)
 			break;
 
-		if (strcmp(arg, a) == 0)
+		if (strcmp(arg, a) == 0) {
+			va_end(ap);
 			return 1;
-		else if (strcmp(arg, b) == 0)
+		} else if (strcmp(arg, b) == 0) {
+			va_end(ap);
 			return 0;
+		}
 	} while (1);
 	va_end(ap);
 
-- 
2.1.4

