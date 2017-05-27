Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34248 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdE0SYP (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 27 May 2017 14:24:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id d127so8996127wmf.1
        for <util-linux@vger.kernel.org>; Sat, 27 May 2017 11:24:14 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/4] last: fix format overflow
Date: Sat, 27 May 2017 19:24:06 +0100
Message-Id: <20170527182409.13985-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

login-utils/last.c:624:23: warning: '%s' directive writing up to 31 bytes
into a region of size 27 [-Wformat-overflow=]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 679ea6c12..153130ac0 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -598,7 +598,7 @@ static void __attribute__((__noreturn__)) usage(const struct last_control *ctl,
 static int is_phantom(const struct last_control *ctl, struct utmpx *ut)
 {
 	struct passwd *pw;
-	char path[32];
+	char path[sizeof("/dev/") + sizeof(ut->ut_line) + 1];
 	int ret = 0;
 
 	if (ut->ut_tv.tv_sec < ctl->boot_time.tv_sec)
-- 
2.13.0

