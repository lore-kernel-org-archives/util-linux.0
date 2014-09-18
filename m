Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-b32.telenor.se ([213.150.131.21]:38986 "EHLO
	smtprelay-b32.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbaISAFO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 18 Sep 2014 20:05:14 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b32.telenor.se (Postfix) with ESMTP id 7C2AEF1B6C
	for <util-linux@vger.kernel.org>; Fri, 19 Sep 2014 01:36:48 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH 5/5] logger: gettimeofday needs <sys/time.h>
Date: Fri, 19 Sep 2014 01:36:37 +0200
Message-Id: <1411083397-8056-5-git-send-email-andreas@fatal.se>
In-Reply-To: <1411083397-8056-1-git-send-email-andreas@fatal.se>
References: <1411083397-8056-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Either works on linux, but kfreebsd build fails
if we don't use the <sys/time.h> include.

According to man gettimeofday the correct include is <sys/time.h>

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 misc-utils/logger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 99a5569..2994dc0 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -40,7 +40,7 @@
 #include <limits.h>
 #include <unistd.h>
 #include <stdlib.h>
-#include <time.h>
+#include <sys/time.h>
 #include <stdio.h>
 #include <ctype.h>
 #include <string.h>
-- 
2.1.0.rc1

