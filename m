Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:54496 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605Ab2GYTQG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:16:06 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1068839wgb.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:16:05 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 13/19] include: define format to be constant in xasprintf()
Date: Wed, 25 Jul 2012 21:15:34 +0200
Message-Id: <1343243745-1172-17-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add also format function attribute to add robustness.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/xalloc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/xalloc.h b/include/xalloc.h
index 8c22ff7..1704259 100644
--- a/include/xalloc.h
+++ b/include/xalloc.h
@@ -63,7 +63,8 @@ static inline char *xstrdup(const char *str)
         return ret;
 }
 
-static inline int xasprintf(char **strp, char *fmt, ...)
+static inline int __attribute__ ((__format__(printf, 2, 3)))
+    xasprintf(char **strp, const char *fmt, ...)
 {
 	int ret;
 	va_list args;
-- 
1.7.11.3

