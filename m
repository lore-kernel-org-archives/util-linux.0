Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.186]:64936 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab2FDLBO convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 4 Jun 2012 07:01:14 -0400
From: =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <biessmann@corscience.de>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <biessmann@corscience.de>
Subject: [PATCH v2] text-utils/hexsyntax.c: fix for missing program_invocation_short_name
Date: Mon,  4 Jun 2012 13:01:09 +0200
Message-Id: <1338807669-32204-1-git-send-email-biessmann@corscience.de>
In-Reply-To: <1338277884-29779-1-git-send-email-biessmann@corscience.de>
References: <1338277884-29779-1-git-send-email-biessmann@corscience.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Some libc do not expose program_invocation_short_name. Therefore util-linux
comes with helpers in 'c.h'. Use the 'c.h' in hexsyntax.c where it was missed.

This patch fixes following error for me:
---8<---
hexsyntax.c: In function 'newsyntax':
hexsyntax.c:115: error: 'program_invocation_short_name' undeclared (first use in this function)
hexsyntax.c:115: error: (Each undeclared identifier is reported only once
hexsyntax.c:115: error: for each function it appears in.)
--->8---

Signed-off-by: Andreas Bießmann <biessmann@corscience.de>
---
since v1:
 clearify commit message

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

