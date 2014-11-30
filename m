Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:39652 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbaK3N6N (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 30 Nov 2014 08:58:13 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so12118462wgh.20
        for <util-linux@vger.kernel.org>; Sun, 30 Nov 2014 05:58:12 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 08/10] include/c: define UL_ASAN_BLACKLIST address_sanitizer function attribute
Date: Sun, 30 Nov 2014 13:57:40 +0000
Message-Id: <1417355862-16935-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The UL_ASAN_BLACKLIST allows AddressSanitizer to be set off for functions
that cannot be checked.

Reference: http://dxr.mozilla.org/mozilla-central/source/mfbt/Attributes.h
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/c.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/c.h b/include/c.h
index 0f6e5b2..223f3a7 100644
--- a/include/c.h
+++ b/include/c.h
@@ -313,4 +313,21 @@ static inline int xusleep(useconds_t usec)
 #define stringify_value(s) stringify(s)
 #define stringify(s) #s
 
+/*
+ * UL_ASAN_BLACKLIST is a macro to tell AddressSanitizer (a compile-time
+ * instrumentation shipped with Clang and GCC) to not instrument the
+ * annotated function.  Furthermore, it will prevent the compiler from
+ * inlining the function because inlining currently breaks the blacklisting
+ * mechanism of AddressSanitizer.
+ */
+#if defined(__has_feature)
+# if __has_feature(address_sanitizer)
+#  define UL_ASAN_BLACKLIST __attribute__((noinline)) __attribute__((no_sanitize_memory)) __attribute__((no_sanitize_address))
+# else
+#  define UL_ASAN_BLACKLIST	/* nothing */
+# endif
+#else
+# define UL_ASAN_BLACKLIST	/* nothing */
+#endif
+
 #endif /* UTIL_LINUX_C_H */
-- 
2.1.3

