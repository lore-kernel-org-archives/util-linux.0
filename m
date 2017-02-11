Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34282 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdBKSET (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 11 Feb 2017 13:04:19 -0500
Received: by mail-wm0-f65.google.com with SMTP id c85so11626953wmi.1
        for <util-linux@vger.kernel.org>; Sat, 11 Feb 2017 10:04:18 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] lib/randutils: glibc 2.25 has getrandom(2) declaration
Date: Sat, 11 Feb 2017 18:04:14 +0000
Message-Id: <20170211180414.4181-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use correct header file to include the function.

Reference: http://git.kernel.org/cgit/docs/man-pages/man-pages.git/commit/?id=2cbb6fb4e926e56dc3985b19ac02389321a0af5d
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/randutils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/randutils.c b/lib/randutils.c
index daf046005..a835ff345 100644
--- a/lib/randutils.c
+++ b/lib/randutils.c
@@ -26,7 +26,7 @@
 #endif
 
 #ifdef HAVE_GETRANDOM
-# include <linux/random.h>
+# include <sys/random.h>
 #elif defined (__linux__)
 # include <sys/syscall.h>
 # if !defined(SYS_getrandom) && defined(__NR_getrandom)
-- 
2.11.1

