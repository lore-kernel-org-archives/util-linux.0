Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:48835 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755382AbdJPVhi (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 16 Oct 2017 17:37:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id i124so65099wmf.3
        for <util-linux@vger.kernel.org>; Mon, 16 Oct 2017 14:37:37 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] libuuid: use explicit_bzero() in uuid_clear() when possible
Date: Mon, 16 Oct 2017 22:37:34 +0100
Message-Id: <20171016213734.23237-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This ensures value is blanked.  It is possible compiler optimization removed
earlier uuid_clear() calls as unnecessary if value was not used after clear.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libuuid/src/clear.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libuuid/src/clear.c b/libuuid/src/clear.c
index 2d91fee93..5b1392464 100644
--- a/libuuid/src/clear.c
+++ b/libuuid/src/clear.c
@@ -38,6 +38,10 @@
 
 void uuid_clear(uuid_t uu)
 {
+#ifdef HAVE_EXPLICIT_BZERO
+	explicit_bzero(uu, 16);
+#else
 	memset(uu, 0, 16);
+#endif
 }
 
-- 
2.14.2

