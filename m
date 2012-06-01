Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:60305 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759630Ab2FAMv1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Jun 2012 08:51:27 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id A08BE95D4D
	for <util-linux@vger.kernel.org>; Fri,  1 Jun 2012 14:51:26 +0200 (CEST)
From: Ludwig Nussel <ludwig.nussel@suse.de>
To: util-linux@vger.kernel.org
Cc: Ludwig Nussel <ludwig.nussel@suse.de>
Subject: [PATCH 2/7] use EXIT_FAILURE consistently
Date: Fri,  1 Jun 2012 14:51:16 +0200
Message-Id: <1338555081-2061-2-git-send-email-ludwig.nussel@suse.de>
In-Reply-To: <1338555081-2061-1-git-send-email-ludwig.nussel@suse.de>
References: <1338555081-2061-1-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Ludwig Nussel <ludwig.nussel@suse.de>
---
 login-utils/su.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/login-utils/su.c b/login-utils/su.c
index 77722c4..b1fca5f 100644
--- a/login-utils/su.c
+++ b/login-utils/su.c
@@ -37,11 +37,8 @@
 
    Based on an implemenation by David MacKenzie <djm@gnu.ai.mit.edu>.  */
 
-/* Exit statuses for programs like 'env' that exec other programs.
-   EXIT_FAILURE might not be 1, so use EXIT_FAIL in such programs.  */
 enum
 {
-  EXIT_FAIL = 1,
   EXIT_CANNOT_INVOKE = 126,
   EXIT_ENOENT = 127
 };
@@ -555,7 +552,7 @@ init_groups (const struct passwd *pw)
   if (initgroups (pw->pw_name, pw->pw_gid) == -1)
     {
       cleanup_pam (PAM_ABORT);
-      error (EXIT_FAIL, errno, _("cannot set groups"));
+      error (EXIT_FAILURE, errno, _("cannot set groups"));
     }
   endgrent ();
 
@@ -570,9 +567,9 @@ static void
 change_identity (const struct passwd *pw)
 {
   if (setgid (pw->pw_gid))
-    error (EXIT_FAIL, errno, _("cannot set group id"));
+    error (EXIT_FAILURE, errno, _("cannot set group id"));
   if (setuid (pw->pw_uid))
-    error (EXIT_FAIL, errno, _("cannot set user id"));
+    error (EXIT_FAILURE, errno, _("cannot set user id"));
 }
 
 /* Run SHELL, or DEFAULT_SHELL if SHELL is empty.
@@ -734,7 +731,7 @@ main (int argc, char **argv)
 	  exit(EXIT_SUCCESS);
 
 	default:
-	  usage (EXIT_FAIL);
+	  usage (EXIT_FAILURE);
 	}
     }
 
@@ -751,7 +748,7 @@ main (int argc, char **argv)
   pw = getpwnam (new_user);
   if (! (pw && pw->pw_name && pw->pw_name[0] && pw->pw_dir && pw->pw_dir[0]
 	 && pw->pw_passwd))
-    error (EXIT_FAIL, 0, _("user %s does not exist"), new_user);
+    error (EXIT_FAILURE, 0, _("user %s does not exist"), new_user);
 
   /* Make a copy of the password information and point pw at the local
      copy instead.  Otherwise, some systems (e.g. Linux) would clobber
@@ -773,7 +770,7 @@ main (int argc, char **argv)
     {
       log_su (pw, false);
       sleep (getlogindefs_num ("FAIL_DELAY", 1));
-      error (EXIT_FAIL, 0, _("incorrect password"));
+      error (EXIT_FAILURE, 0, _("incorrect password"));
     }
   else
     {
-- 
1.7.7

