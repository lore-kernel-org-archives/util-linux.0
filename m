Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34218 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751328AbdBMWGv (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 13 Feb 2017 17:06:51 -0500
Received: by mail-wm0-f65.google.com with SMTP id c85so554484wmi.1
        for <util-linux@vger.kernel.org>; Mon, 13 Feb 2017 14:06:50 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 5/7] lib/idcache: add void to function declaration [smatch scan]
Date: Mon, 13 Feb 2017 22:06:39 +0000
Message-Id: <20170213220641.1395-6-kerolasa@iki.fi>
In-Reply-To: <20170213220641.1395-1-kerolasa@iki.fi>
References: <20170213220641.1395-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

lib/idcache.c:29:29: warning: non-ANSI function declaration of function
'new_idcache'

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/idcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/idcache.c b/lib/idcache.c
index 3c358b8a8..a1a957b93 100644
--- a/lib/idcache.c
+++ b/lib/idcache.c
@@ -26,7 +26,7 @@ struct identry *get_id(struct idcache *ic, unsigned long int id)
 	return NULL;
 }
 
-struct idcache *new_idcache()
+struct idcache *new_idcache(void)
 {
 	return calloc(1, sizeof(struct idcache));
 }
-- 
2.11.1

