Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:60304 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759581Ab2FAMv1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Jun 2012 08:51:27 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id C306496101
	for <util-linux@vger.kernel.org>; Fri,  1 Jun 2012 14:51:26 +0200 (CEST)
From: Ludwig Nussel <ludwig.nussel@suse.de>
To: util-linux@vger.kernel.org
Cc: Ludwig Nussel <ludwig.nussel@suse.de>
Subject: [PATCH 4/7] introduce xsetenv globally
Date: Fri,  1 Jun 2012 14:51:18 +0200
Message-Id: <1338555081-2061-4-git-send-email-ludwig.nussel@suse.de>
In-Reply-To: <1338555081-2061-1-git-send-email-ludwig.nussel@suse.de>
References: <1338555081-2061-1-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Ludwig Nussel <ludwig.nussel@suse.de>
---
 include/env.h    |    7 +++++++
 login-utils/su.c |   36 +++++++++++-------------------------
 2 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/include/env.h b/include/env.h
index bcd0f7e..9c6a3fd 100644
--- a/include/env.h
+++ b/include/env.h
@@ -4,5 +4,12 @@
 extern void sanitize_env (void);
 extern char *safe_getenv(const char *arg);
 
+static inline void
+xsetenv (char const *name, char const *val, int overwrite)
+{
+  if (setenv (name, val, overwrite) != 0)
+    err (EXIT_FAILURE,  _("failed to set the %s environment variable"), name);
+}
+
 #endif /* UTIL_LINUX_ENV_H */
 
diff --git a/login-utils/su.c b/login-utils/su.c
index 22b9ccc..cdaf31e 100644
--- a/login-utils/su.c
+++ b/login-utils/su.c
@@ -62,6 +62,7 @@ enum
 #include "xalloc.h"
 #include "nls.h"
 #include "pathnames.h"
+#include "env.h"
 
 /* name of the pam configuration files. separate configs for su and su -  */
 #define PAM_SERVICE_NAME "su"
@@ -111,21 +112,6 @@ static struct option const longopts[] =
   {NULL, 0, NULL, 0}
 };
 
-/* Add NAME=VAL to the environment, checking for out of memory errors.  */
-
-static void
-xsetenv (char const *name, char const *val)
-{
-  size_t namelen = strlen (name);
-  size_t vallen = strlen (val);
-  char *string = xmalloc (namelen + 1 + vallen + 1);
-  strcpy (string, name);
-  string[namelen] = '=';
-  strcpy (string + namelen + 1, val);
-  if (putenv (string) != 0)
-    error (EXIT_FAILURE, 0, _("out of memory"));
-}
-
 /* Log the fact that someone has run su to the user given by PW;
    if SUCCESSFUL is true, they gave the correct password, etc.  */
 
@@ -506,11 +492,11 @@ modify_environment (const struct passwd *pw, const char *shell)
       environ = xmalloc ((6 + !!term) * sizeof (char *));
       environ[0] = NULL;
       if (term)
-	xsetenv ("TERM", term);
-      xsetenv ("HOME", pw->pw_dir);
-      xsetenv ("SHELL", shell);
-      xsetenv ("USER", pw->pw_name);
-      xsetenv ("LOGNAME", pw->pw_name);
+	xsetenv ("TERM", term, 1);
+      xsetenv ("HOME", pw->pw_dir, 1);
+      xsetenv ("SHELL", shell, 1);
+      xsetenv ("USER", pw->pw_name, 1);
+      xsetenv ("LOGNAME", pw->pw_name, 1);
       set_path(pw);
     }
   else
@@ -519,8 +505,8 @@ modify_environment (const struct passwd *pw, const char *shell)
 	 USER and LOGNAME.  */
       if (change_environment)
         {
-          xsetenv ("HOME", pw->pw_dir);
-          xsetenv ("SHELL", shell);
+          xsetenv ("HOME", pw->pw_dir, 1);
+          xsetenv ("SHELL", shell, 1);
 	  if (getlogindefs_bool ("ALWAYS_SET_PATH", 0))
 	    set_path(pw);
 	  else
@@ -535,14 +521,14 @@ modify_environment (const struct passwd *pw, const char *shell)
 
 	      if (new)
 		{
-		  xsetenv ("PATH", new);
+		  xsetenv ("PATH", new, 1);
 		  free (new);
 		}
 	    }
           if (pw->pw_uid)
             {
-              xsetenv ("USER", pw->pw_name);
-              xsetenv ("LOGNAME", pw->pw_name);
+              xsetenv ("USER", pw->pw_name, 1);
+              xsetenv ("LOGNAME", pw->pw_name, 1);
             }
         }
     }
-- 
1.7.7

