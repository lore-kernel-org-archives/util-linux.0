Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36410 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbcGBJ3A (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 2 Jul 2016 05:29:00 -0400
Received: by mail-wm0-f66.google.com with SMTP id c82so10403989wme.3
        for <util-linux@vger.kernel.org>; Sat, 02 Jul 2016 02:28:59 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] sulogin: remove __nonnull__ function attribute
Date: Sat,  2 Jul 2016 10:28:55 +0100
Message-Id: <20160702092855.12718-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This change fixes compiler option -Werror=nonnull option warning:

login-utils/sulogin-consoles.c: In function 'append_console':
login-utils/sulogin-consoles.c:324:14: warning: nonnull argument 'consoles'
compared to NULL [-Wnonnull-compare]

The NULL check done with list_empty() looks valid, so  it is best to remove
the function attribute that allows compiler to optimize the check away.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/sulogin-consoles.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/sulogin-consoles.c b/login-utils/sulogin-consoles.c
index 1644da5..595b516 100644
--- a/login-utils/sulogin-consoles.c
+++ b/login-utils/sulogin-consoles.c
@@ -311,7 +311,7 @@ out:
  */
 static
 #ifdef __GNUC__
-__attribute__((__nonnull__,__hot__))
+__attribute__((__hot__))
 #endif
 int append_console(struct list_head *consoles, const char *name)
 {
-- 
2.9.0

