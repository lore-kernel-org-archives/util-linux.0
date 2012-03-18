Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qa0-f46.google.com ([209.85.216.46]:43383 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806Ab2CRDgk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Mar 2012 23:36:40 -0400
Received: by mail-qa0-f46.google.com with SMTP id b19so306297qae.19
        for <util-linux@vger.kernel.org>; Sat, 17 Mar 2012 20:36:40 -0700 (PDT)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 3/5] include/ttyutils.h: add include guards
Date: Sat, 17 Mar 2012 23:36:31 -0400
Message-Id: <1332041793-7919-3-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1332041793-7919-1-git-send-email-dreisner@archlinux.org>
References: <1332041793-7919-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 include/ttyutils.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/ttyutils.h b/include/ttyutils.h
index 949b72a..f638aa0 100644
--- a/include/ttyutils.h
+++ b/include/ttyutils.h
@@ -1,3 +1,5 @@
+#ifndef UTIL_LINUX_TTYUTILS_H
+#define UTIL_LINUX_TTYUTILS_H
 
 #include <termios.h>
 
@@ -71,3 +73,5 @@ static inline void reset_virtual_console(struct termios *tp, int flags)
 	tp->c_cc[VLNEXT]   = CLNEXT;
 	tp->c_cc[VEOL2]    = _POSIX_VDISABLE;
 }
+
+#endif /* UTIL_LINUX_TTYUTILS_H */
-- 
1.7.9.4

