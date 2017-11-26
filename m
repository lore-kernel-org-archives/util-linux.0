Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:44829 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751603AbdKZRr5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 26 Nov 2017 12:47:57 -0500
Received: by mail-wm0-f65.google.com with SMTP id r68so30208392wmr.3
        for <util-linux@vger.kernel.org>; Sun, 26 Nov 2017 09:47:56 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/3] logindefs: remove unused function
Date: Sun, 26 Nov 2017 17:47:50 +0000
Message-Id: <20171126174751.10500-2-kerolasa@iki.fi>
In-Reply-To: <20171126174751.10500-1-kerolasa@iki.fi>
References: <20171126174751.10500-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/logindefs.c | 18 ------------------
 login-utils/logindefs.h |  1 -
 2 files changed, 19 deletions(-)

diff --git a/login-utils/logindefs.c b/login-utils/logindefs.c
index ebf1a9f3a..18a699d6b 100644
--- a/login-utils/logindefs.c
+++ b/login-utils/logindefs.c
@@ -51,24 +51,6 @@ static struct item *list = NULL;
 static void (*logindefs_loader)(void *) = NULL;
 static void *logindefs_loader_data = NULL;
 
-void free_getlogindefs_data(void)
-{
-	struct item *ptr;
-
-	ptr = list;
-	while (ptr) {
-		struct item *tmp = ptr->next;
-
-		free(ptr->path);
-		free(ptr->name);
-		free(ptr->value);
-		free(ptr);
-		ptr = tmp;
-	}
-
-	list = NULL;
-}
-
 static void store(const char *name, const char *value, const char *path)
 {
 	struct item *new = xmalloc(sizeof(struct item));
diff --git a/login-utils/logindefs.h b/login-utils/logindefs.h
index 064737c6c..0079cd23c 100644
--- a/login-utils/logindefs.h
+++ b/login-utils/logindefs.h
@@ -6,7 +6,6 @@ extern void logindefs_set_loader(void (*loader)(void *data), void *data);
 extern int getlogindefs_bool(const char *name, int dflt);
 extern unsigned long getlogindefs_num(const char *name, long dflt);
 extern const char *getlogindefs_str(const char *name, const char *dflt);
-extern void free_getlogindefs_data(void);
 extern int logindefs_setenv(const char *name, const char *conf, const char *dflt);
 extern int effective_access(const char *path, int mode);
 extern int get_hushlogin_status(struct passwd *pwd, int force_check);
-- 
2.15.0

