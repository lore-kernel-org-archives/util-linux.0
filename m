Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f180.google.com ([74.125.82.180]:33523 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbaD0UGD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Apr 2014 16:06:03 -0400
Received: by mail-we0-f180.google.com with SMTP id t61so734405wes.25
        for <util-linux@vger.kernel.org>; Sun, 27 Apr 2014 13:06:02 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/12] include/c.h: add macro to print definitions as string
Date: Sun, 27 Apr 2014 21:05:30 +0100
Message-Id: <1398629138-31718-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/c.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/c.h b/include/c.h
index a192fb1..6b8793a 100644
--- a/include/c.h
+++ b/include/c.h
@@ -307,4 +307,13 @@ static inline int xusleep(useconds_t usec)
 # define SEEK_HOLE	4
 #endif
 
+
+/*
+ * Macros to convert #define'itions to strings, for example
+ * #define XYXXY 42
+ * printf ("%s=%s\n", stringify(XYXXY), stringify_value(XYXXY));
+ */
+#define stringify_value(s) stringify(s)
+#define stringify(s) #s
+
 #endif /* UTIL_LINUX_C_H */
-- 
1.9.2

