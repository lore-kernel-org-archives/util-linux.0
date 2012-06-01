Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:60306 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759632Ab2FAMv1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Jun 2012 08:51:27 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id B98559604E
	for <util-linux@vger.kernel.org>; Fri,  1 Jun 2012 14:51:26 +0200 (CEST)
From: Ludwig Nussel <ludwig.nussel@suse.de>
To: util-linux@vger.kernel.org
Cc: Ludwig Nussel <ludwig.nussel@suse.de>
Subject: [PATCH 3/7] use ENV_PATH resp ENV_SUPATH to be consistent with login
Date: Fri,  1 Jun 2012 14:51:17 +0200
Message-Id: <1338555081-2061-3-git-send-email-ludwig.nussel@suse.de>
In-Reply-To: <1338555081-2061-1-git-send-email-ludwig.nussel@suse.de>
References: <1338555081-2061-1-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Ludwig Nussel <ludwig.nussel@suse.de>
---
 login-utils/su.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/login-utils/su.c b/login-utils/su.c
index b1fca5f..22b9ccc 100644
--- a/login-utils/su.c
+++ b/login-utils/su.c
@@ -476,6 +476,20 @@ clearsbin (const char *const path)
   return ret;
 }
 
+static void
+set_path(const struct passwd* pw)
+{
+  int r;
+  if (pw->pw_uid)
+    r = logindefs_setenv("PATH", "ENV_PATH", _PATH_DEFPATH);
+
+  else if ((r = logindefs_setenv("PATH", "ENV_ROOTPATH", NULL)) != 0)
+    r = logindefs_setenv("PATH", "ENV_SUPATH", _PATH_DEFPATH_ROOT);
+
+  if (r != 0)
+    err (EXIT_FAILURE,  _("failed to set PATH"));
+}
+
 /* Update `environ' for the new shell based on PW, with SHELL being
    the value for the SHELL environment variable.  */
 
@@ -497,9 +511,7 @@ modify_environment (const struct passwd *pw, const char *shell)
       xsetenv ("SHELL", shell);
       xsetenv ("USER", pw->pw_name);
       xsetenv ("LOGNAME", pw->pw_name);
-      xsetenv ("PATH", (pw->pw_uid
-			? getlogindefs_str ("PATH", _PATH_DEFPATH)
-			: getlogindefs_str ("SUPATH", _PATH_DEFPATH_ROOT)));
+      set_path(pw);
     }
   else
     {
@@ -510,11 +522,7 @@ modify_environment (const struct passwd *pw, const char *shell)
           xsetenv ("HOME", pw->pw_dir);
           xsetenv ("SHELL", shell);
 	  if (getlogindefs_bool ("ALWAYS_SET_PATH", 0))
-	    xsetenv ("PATH", (pw->pw_uid
-			      ? getlogindefs_str ("PATH",
-					    _PATH_DEFPATH)
-			      : getlogindefs_str ("SUPATH",
-					    _PATH_DEFPATH_ROOT)));
+	    set_path(pw);
 	  else
 	    {
 	      char const *path = getenv ("PATH");
-- 
1.7.7

