Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.171]:55748 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab2E2Hvf convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 29 May 2012 03:51:35 -0400
From: =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <biessmann@corscience.de>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <biessmann@corscience.de>
Subject: [PATCH] text-utils/hexsyntax.c: use c.h
Date: Tue, 29 May 2012 09:51:24 +0200
Message-Id: <1338277884-29779-1-git-send-email-biessmann@corscience.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch hfixes following error for me:
---8<---
hexsyntax.c: In function 'newsyntax':
hexsyntax.c:115: error: 'program_invocation_short_name' undeclared (first use in this function)
hexsyntax.c:115: error: (Each undeclared identifier is reported only once
hexsyntax.c:115: error: for each function it appears in.)
--->8---

Signed-off-by: Andreas Bießmann <biessmann@corscience.de>
---
 text-utils/hexsyntax.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/text-utils/hexsyntax.c b/text-utils/hexsyntax.c
index 5f3b733..21cc55e 100644
--- a/text-utils/hexsyntax.c
+++ b/text-utils/hexsyntax.c
@@ -45,6 +45,7 @@
 #include "hexdump.h"
 #include "nls.h"
 #include "strutils.h"
+#include "c.h"
 
 off_t skip;				/* bytes to skip */
 
-- 
1.7.10

