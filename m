Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33744 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751698AbdFHTwe (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 8 Jun 2017 15:52:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id x3so8901601wme.0
        for <util-linux@vger.kernel.org>; Thu, 08 Jun 2017 12:52:34 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 11/11] lib: remove _RLD_ from forbid environment variable list
Date: Thu,  8 Jun 2017 20:52:15 +0100
Message-Id: <20170608195215.1702-12-kerolasa@iki.fi>
In-Reply-To: <20170608195215.1702-1-kerolasa@iki.fi>
References: <20170608195215.1702-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The RLD environment variables are related to runtime linker vulnerability in
TELNET on systems running Silicon Graphics IRIX.  It is extremely unlikely
current util-linux would be compiled on such system.

Reference: http://www.cert.org/historical/advisories/CA-1995-14.cfm
Reference: http://signatures.juniper.net/documentation/signatures/TELNET%3AEXPLOIT%3ASGI-RLD.html
Refefence: http://www.polarhome.com/service/man/?qf=rld&tf=2&of=IRIX&sf=1
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/env.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/env.c b/lib/env.c
index c79e0e0de..b2e3d975a 100644
--- a/lib/env.c
+++ b/lib/env.c
@@ -26,7 +26,6 @@ extern char **environ;
 #endif
 
 static char * const forbid[] = {
-        "_RLD_=",
         "BASH_ENV=",    /* GNU creeping featurism strikes again... */
         "ENV=",
         "HOME=",
-- 
2.13.1

