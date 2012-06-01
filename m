Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:60303 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759591Ab2FAMv1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Jun 2012 08:51:27 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id D620796140
	for <util-linux@vger.kernel.org>; Fri,  1 Jun 2012 14:51:26 +0200 (CEST)
From: Ludwig Nussel <ludwig.nussel@suse.de>
To: util-linux@vger.kernel.org
Cc: Ludwig Nussel <ludwig.nussel@suse.de>
Subject: [PATCH 5/7] replace PAM_BAIL_P macro with better solution
Date: Fri,  1 Jun 2012 14:51:19 +0200
Message-Id: <1338555081-2061-5-git-send-email-ludwig.nussel@suse.de>
In-Reply-To: <1338555081-2061-1-git-send-email-ludwig.nussel@suse.de>
References: <1338555081-2061-1-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Ludwig Nussel <ludwig.nussel@suse.de>
---
 login-utils/su.c |   56 +++++++++++++++++++++++++++---------------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/login-utils/su.c b/login-utils/su.c
index cdaf31e..cabf116 100644
--- a/login-utils/su.c
+++ b/login-utils/su.c
@@ -68,6 +68,8 @@ enum
 #define PAM_SERVICE_NAME "su"
 #define PAM_SERVICE_NAME_L "su-l"
 
+#define is_pam_failure(_rc)	((_rc) != PAM_SUCCESS)
+
 #include "logindefs.h"
 
 /* The shell to run if none is given in the user's passwd entry.  */
@@ -148,13 +150,6 @@ static struct pam_conv conv =
   NULL
 };
 
-# define PAM_BAIL_P(a) \
-  if (retval) \
-    { \
-      pam_end (pamh, retval); \
-      a; \
-    }
-
 static void
 cleanup_pam (int retcode)
 {
@@ -199,7 +194,7 @@ create_watching_parent (void)
   int retval;
 
   retval = pam_open_session (pamh, 0);
-  if (retval != PAM_SUCCESS)
+  if (is_pam_failure(retval))
     {
       cleanup_pam (retval);
       error (EXIT_FAILURE, 0, _("cannot not open session: %s"),
@@ -305,8 +300,8 @@ create_watching_parent (void)
   exit (status);
 }
 
-static bool
-correct_password (const struct passwd *pw)
+static void
+authenticate (const struct passwd *pw)
 {
   const struct passwd *lpw;
   const char *cp;
@@ -314,7 +309,8 @@ correct_password (const struct passwd *pw)
 
   retval = pam_start (simulate_login ? PAM_SERVICE_NAME_L : PAM_SERVICE_NAME,
 		      pw->pw_name, &conv, &pamh);
-  PAM_BAIL_P (return false);
+  if (is_pam_failure(retval))
+    goto done;
 
   if (isatty (0) && (cp = ttyname (0)) != NULL)
     {
@@ -325,7 +321,8 @@ correct_password (const struct passwd *pw)
       else
 	tty = cp;
       retval = pam_set_item (pamh, PAM_TTY, tty);
-      PAM_BAIL_P (return false);
+      if (is_pam_failure(retval))
+	goto done;
     }
 # if 0 /* Manpage discourages use of getlogin.  */
   cp = getlogin ();
@@ -335,20 +332,32 @@ correct_password (const struct passwd *pw)
   if (lpw && lpw->pw_name)
     {
       retval = pam_set_item (pamh, PAM_RUSER, (const void *) lpw->pw_name);
-      PAM_BAIL_P (return false);
+      if (is_pam_failure(retval))
+	goto done;
     }
+
   retval = pam_authenticate (pamh, 0);
-  PAM_BAIL_P (return false);
+  if (is_pam_failure(retval))
+    goto done;
+
   retval = pam_acct_mgmt (pamh, 0);
   if (retval == PAM_NEW_AUTHTOK_REQD)
     {
       /* Password has expired.  Offer option to change it.  */
       retval = pam_chauthtok (pamh, PAM_CHANGE_EXPIRED_AUTHTOK);
-      PAM_BAIL_P (return false);
     }
-  PAM_BAIL_P (return false);
-  /* Must be authenticated if this point was reached.  */
-  return true;
+
+done:
+
+  log_su (pw, !is_pam_failure(retval));
+
+  if (is_pam_failure(retval))
+    {
+      const char *msg = pam_strerror(pamh, retval);
+      pam_end(pamh, retval);
+      sleep (getlogindefs_num ("FAIL_DELAY", 1));
+      error (EXIT_FAILURE, 0, "%s", msg?msg:_("incorrect password"));
+    }
 }
 
 /* Add or clear /sbin and /usr/sbin for the su command
@@ -760,16 +769,7 @@ main (int argc, char **argv)
 			  : DEFAULT_SHELL);
   endpwent ();
 
-  if (!correct_password (pw))
-    {
-      log_su (pw, false);
-      sleep (getlogindefs_num ("FAIL_DELAY", 1));
-      error (EXIT_FAILURE, 0, _("incorrect password"));
-    }
-  else
-    {
-      log_su (pw, true);
-    }
+  authenticate (pw);
 
   if (request_same_session || !command || !pw->pw_uid)
     same_session = 1;
-- 
1.7.7

