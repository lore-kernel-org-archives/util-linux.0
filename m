Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35810 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbaIGMnU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Sep 2014 08:43:20 -0400
Received: by mail-wi0-f180.google.com with SMTP id ex7so1383086wid.1
        for <util-linux@vger.kernel.org>; Sun, 07 Sep 2014 05:43:19 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/17] lib: add function to remove string from memory
Date: Sun,  7 Sep 2014 13:42:52 +0100
Message-Id: <1410093785-17537-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The memcpy(3) can be get optimized out by compiler.

Reference: https://www.securecoding.cert.org/confluence/display/seccode/MSC06-C.+Beware+of+compiler+optimizations
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/xgetpass.h |  1 +
 lib/xgetpass.c     | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/xgetpass.h b/include/xgetpass.h
index 622ba8c..0f77419 100644
--- a/include/xgetpass.h
+++ b/include/xgetpass.h
@@ -2,5 +2,6 @@
 #define UTIL_LINUX_XGETPASS_H
 
 extern char *xgetpass(FILE *input, const char *prompt);
+extern int memset_s(void *v, size_t sz, int c);
 
 #endif /* UTIL_LINUX_XGETPASS_H */
diff --git a/lib/xgetpass.c b/lib/xgetpass.c
index 9c7d431..0948ff1 100644
--- a/lib/xgetpass.c
+++ b/lib/xgetpass.c
@@ -6,11 +6,14 @@
  */
 
 #include <err.h>
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <termios.h>
 #include <unistd.h>
 
+#include "xgetpass.h"
+
 char *xgetpass(FILE *input, const char *prompt)
 {
 	char *pass = NULL;
@@ -40,3 +43,18 @@ char *xgetpass(FILE *input, const char *prompt)
 			err(EXIT_FAILURE, "could not set terminal attributes");
 	return pass;
 }
+
+/* Ensure memory is set to value c without compiler optimization getting
+ * into way, that could happen with memset(3).  This function can be used
+ * for example getting rid of in memory password strings read with
+ * xgetpass().  */
+ int memset_s(void *v, size_t sz, int c)
+{
+	volatile unsigned char *p = v;
+
+	if (v == NULL)
+		return EINVAL;
+	while (sz--)
+		*p++ = c;
+	return 0;
+}
-- 
2.1.0

