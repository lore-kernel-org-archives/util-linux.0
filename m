Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35659 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbdGaTzU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 31 Jul 2017 15:55:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id r77so93605wmd.2
        for <util-linux@vger.kernel.org>; Mon, 31 Jul 2017 12:55:19 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/9] vipw: use explicit_bzero() to clear buffer after copy
Date: Mon, 31 Jul 2017 20:55:02 +0100
Message-Id: <20170731195508.11661-4-kerolasa@iki.fi>
In-Reply-To: <20170731195508.11661-1-kerolasa@iki.fi>
References: <20170731195508.11661-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This should make leaking end of /etc/shadow file more unlikely.

Notice that there is now way to tell to editors they should ensure none it
does not leak any buffers, drop cores, and so on, when editing sensitive
data.  In short this change is addressing the issue only partially.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/vipw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/login-utils/vipw.c b/login-utils/vipw.c
index 5999d8d15..b7650de8b 100644
--- a/login-utils/vipw.c
+++ b/login-utils/vipw.c
@@ -100,6 +100,9 @@ static void copyfile(int from, int to)
 
 	if (nr < 0)
 		pw_error(orig_file, 1, 1);
+#ifdef HAVE_EXPLICIT_BZERO
+	explicit_bzero(buf, sizeof(buf));
+#endif
 }
 
 static void pw_init(void)
-- 
2.13.3

