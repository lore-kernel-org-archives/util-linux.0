Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:60308 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759637Ab2FAMv2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Jun 2012 08:51:28 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E9AA9965C0
	for <util-linux@vger.kernel.org>; Fri,  1 Jun 2012 14:51:26 +0200 (CEST)
From: Ludwig Nussel <ludwig.nussel@suse.de>
To: util-linux@vger.kernel.org
Cc: Ludwig Nussel <ludwig.nussel@suse.de>
Subject: [PATCH 7/7] use BSD err function instead of gnu's error()
Date: Fri,  1 Jun 2012 14:51:21 +0200
Message-Id: <1338555081-2061-7-git-send-email-ludwig.nussel@suse.de>
In-Reply-To: <1338555081-2061-1-git-send-email-ludwig.nussel@suse.de>
References: <1338555081-2061-1-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Ludwig Nussel <ludwig.nussel@suse.de>
---
 login-utils/su.c |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/login-utils/su.c b/login-utils/su.c
index 9585d07..944d655 100644
--- a/login-utils/su.c
+++ b/login-utils/su.c
@@ -55,7 +55,7 @@ enum
 #include <sys/wait.h>
 #include <syslog.h>
 
-#include "error.h"
+#include "err.h"
 
 #include <stdbool.h>
 #include "c.h"
@@ -180,7 +180,7 @@ export_pamenv (void)
   while (env && *env)
     {
       if (putenv (*env) != 0)
-	error (EXIT_FAILURE, 0, _("out of memory"));
+	err (EXIT_FAILURE, NULL);
       env++;
     }
 }
@@ -197,7 +197,7 @@ create_watching_parent (void)
   if (is_pam_failure(retval))
     {
       cleanup_pam (retval);
-      error (EXIT_FAILURE, 0, _("cannot not open session: %s"),
+      errx (EXIT_FAILURE, _("cannot not open session: %s"),
 	     pam_strerror (pamh, retval));
     }
   else
@@ -207,7 +207,7 @@ create_watching_parent (void)
   if (child == (pid_t) -1)
     {
       cleanup_pam (PAM_ABORT);
-      error (EXIT_FAILURE, errno, _("cannot create child process"));
+      err (EXIT_FAILURE, _("cannot create child process"));
     }
 
   /* the child proceeds to run the shell */
@@ -219,12 +219,12 @@ create_watching_parent (void)
   /* su without pam support does not have a helper that keeps
      sitting on any directory so let's go to /.  */
   if (chdir ("/") != 0)
-    error (0, errno, _("warning: cannot change directory to %s"), "/");
+    warn (_("cannot change directory to %s"), "/");
 
   sigfillset (&ourset);
   if (sigprocmask (SIG_BLOCK, &ourset, NULL))
     {
-      error (0, errno, _("cannot block signals"));
+      warn (_("cannot block signals"));
       caught_signal = true;
     }
   if (!caught_signal)
@@ -238,7 +238,7 @@ create_watching_parent (void)
       {
         if (sigaddset(&ourset, SIGINT) || sigaddset(&ourset, SIGQUIT))
           {
-            error (0, errno, _("cannot set signal handler"));
+            warn (_("cannot set signal handler"));
             caught_signal = true;
           }
       }
@@ -246,13 +246,13 @@ create_watching_parent (void)
                     || sigaddset(&ourset, SIGALRM)
                     || sigaction(SIGTERM, &action, NULL)
                     || sigprocmask(SIG_UNBLOCK, &ourset, NULL))) {
-	  error (0, errno, _("cannot set signal handler"));
+	  warn (_("cannot set signal handler"));
 	  caught_signal = true;
 	}
     if (!caught_signal && !same_session && (sigaction(SIGINT, &action, NULL)
                                      || sigaction(SIGQUIT, &action, NULL)))
       {
-        error (0, errno, _("cannot set signal handler"));
+        warn (_("cannot set signal handler"));
         caught_signal = true;
       }
     }
@@ -353,7 +353,7 @@ done:
       const char *msg = pam_strerror(pamh, retval);
       pam_end(pamh, retval);
       sleep (getlogindefs_num ("FAIL_DELAY", 1));
-      error (EXIT_FAILURE, 0, "%s", msg?msg:_("incorrect password"));
+      errx (EXIT_FAILURE, "%s", msg?msg:_("incorrect password"));
     }
 }
 
@@ -552,13 +552,13 @@ init_groups (const struct passwd *pw)
   if (initgroups (pw->pw_name, pw->pw_gid) == -1)
     {
       cleanup_pam (PAM_ABORT);
-      error (EXIT_FAILURE, errno, _("cannot set groups"));
+      err (EXIT_FAILURE, _("cannot set groups"));
     }
   endgrent ();
 
   retval = pam_setcred (pamh, PAM_ESTABLISH_CRED);
-  if (retval != PAM_SUCCESS)
-    error (EXIT_FAILURE, 0, "%s", pam_strerror (pamh, retval));
+  if (is_pam_failure(retval))
+    errx (EXIT_FAILURE, "%s", pam_strerror (pamh, retval));
   else
     _pam_cred_established = 1;
 }
@@ -567,9 +567,9 @@ static void
 change_identity (const struct passwd *pw)
 {
   if (setgid (pw->pw_gid))
-    error (EXIT_FAILURE, errno, _("cannot set group id"));
+    err (EXIT_FAILURE,  _("cannot set group id"));
   if (setuid (pw->pw_uid))
-    error (EXIT_FAILURE, errno, _("cannot set user id"));
+    err (EXIT_FAILURE,  _("cannot set user id"));
 }
 
 /* Run SHELL, or DEFAULT_SHELL if SHELL is empty.
@@ -611,7 +611,7 @@ run_shell (char const *shell, char const *command, char **additional_args,
 
   {
     int exit_status = (errno == ENOENT ? EXIT_ENOENT : EXIT_CANNOT_INVOKE);
-    error (0, errno, "%s", shell);
+    warn ("%s", shell);
     exit (exit_status);
   }
 }
@@ -748,7 +748,7 @@ main (int argc, char **argv)
   pw = getpwnam (new_user);
   if (! (pw && pw->pw_name && pw->pw_name[0] && pw->pw_dir && pw->pw_dir[0]
 	 && pw->pw_passwd))
-    error (EXIT_FAILURE, 0, _("user %s does not exist"), new_user);
+    errx (EXIT_FAILURE, _("user %s does not exist"), new_user);
 
   /* Make a copy of the password information and point pw at the local
      copy instead.  Otherwise, some systems (e.g. Linux) would clobber
@@ -779,7 +779,7 @@ main (int argc, char **argv)
 	 probably a uucp account or has restricted access.  Don't
 	 compromise the account by allowing access with a standard
 	 shell.  */
-      error (0, 0, _("using restricted shell %s"), pw->pw_shell);
+      warnx (_("using restricted shell %s"), pw->pw_shell);
       shell = NULL;
     }
   shell = xstrdup (shell ? shell : pw->pw_shell);
@@ -799,7 +799,7 @@ main (int argc, char **argv)
   modify_environment (pw, shell);
 
   if (simulate_login && chdir (pw->pw_dir) != 0)
-    error (0, errno, _("warning: cannot change directory to %s"), pw->pw_dir);
+    warn (_("warning: cannot change directory to %s"), pw->pw_dir);
 
   run_shell (shell, command, argv + optind, max (0, argc - optind));
 }
-- 
1.7.7

