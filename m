Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33311 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdE0SYR (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 27 May 2017 14:24:17 -0400
Received: by mail-wm0-f67.google.com with SMTP id b84so9021167wmh.0
        for <util-linux@vger.kernel.org>; Sat, 27 May 2017 11:24:17 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/4] lib/loopdev: fix format overflow
Date: Sat, 27 May 2017 19:24:08 +0100
Message-Id: <20170527182409.13985-3-kerolasa@iki.fi>
In-Reply-To: <20170527182409.13985-1-kerolasa@iki.fi>
References: <20170527182409.13985-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

lib/loopdev.c:546:32: warning: '/loop/backing_file' directive output may be
truncated writing 18 bytes into a region of size between 1 and 256
[-Wformat-truncation=]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/loopdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/loopdev.c b/lib/loopdev.c
index fd4f16692..c1d56f7b4 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -533,7 +533,7 @@ static int loopcxt_next_from_sysfs(struct loopdev_cxt *lc)
 	fd = dirfd(iter->sysblock);
 
 	while ((d = readdir(iter->sysblock))) {
-		char name[256];
+		char name[sizeof(d->d_name) + sizeof("/loop/backing_file") + 1];
 		struct stat st;
 
 		DBG(ITER, ul_debugobj(iter, "check %s", d->d_name));
-- 
2.13.0

