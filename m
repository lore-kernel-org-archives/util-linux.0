Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45430 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920Ab3BGGWt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 7 Feb 2013 01:22:49 -0500
Received: by mail-ie0-f174.google.com with SMTP id k10so3053302iea.33
        for <util-linux@vger.kernel.org>; Wed, 06 Feb 2013 22:22:49 -0800 (PST)
From: Cody Maloney <cmaloney@theoreticalchaos.com>
To: util-linux@vger.kernel.org
Cc: mitr@redhat.com, Cody Maloney <cmaloney@theoreticalchaos.com>
Subject: [PATCH v3 4/4] chfn: Add libuser support
Date: Wed,  6 Feb 2013 23:22:21 -0700
Message-Id: <1360218141-4463-5-git-send-email-cmaloney@theoreticalchaos.com>
In-Reply-To: <1360218141-4463-1-git-send-email-cmaloney@theoreticalchaos.com>
References: <1360218141-4463-1-git-send-email-cmaloney@theoreticalchaos.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Cody Maloney <cmaloney@theoreticalchaos.com>
---
 login-utils/chfn.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index 7c9af84..7ea3f3e 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -1,6 +1,7 @@
 /*
  *   chfn.c -- change your finger information
  *   (c) 1994 by salvatore valente <svalente@athena.mit.edu>
+ *   (c) 2012 by Cody Maloney <cmaloney@theoreticalchaos.com>
  *
  *   this program is free software.  you can redistribute it and
  *   modify it under the terms of the gnu general public license.
@@ -31,7 +32,6 @@
 #include <sys/types.h>
 #include <unistd.h>
 
-#include "auth.h"
 #include "c.h"
 #include "env.h"
 #include "closestream.h"
@@ -47,6 +47,13 @@
 # include "selinux_utils.h"
 #endif
 
+#ifdef HAVE_LIBUSER
+# include <libuser/user.h>
+# include "libuser.h"
+#else
+# include "auth.h"
+#endif
+
 static char buf[1024];
 
 struct finfo {
@@ -149,17 +156,24 @@ int main(int argc, char **argv)
 	}
 #endif
 
-	/* Reality check */
-	if (uid != 0 && uid != oldf.pw->pw_uid) {
+#ifdef HAVE_LIBUSER
+	/* If we're setuid and not really root, disallow the password change. */
+	if (geteuid() != getuid() && uid != pw->pw_uid) {
+#else
+	if (uid != 0 && uid != pw->pw_uid) {
+#endif
 		errno = EACCES;
-		err(EXIT_FAILURE, NULL);
+		err(EXIT_FAILURE, _("running UID doesn't match UID of user we're "
+		      "altering, change denied")););
 	}
 
 	printf(_("Changing finger information for %s.\n"), oldf.username);
 
+#ifndef HAVE_LIBUSER
 	if(!auth_pam("chfn", uid, oldf.username)) {
 		return EXIT_FAILURE;
 	}
+#endif
 
 	if (interactive)
 		ask_info(&oldf, &newf);
@@ -445,9 +459,14 @@ static int save_new_data(struct finfo *pinfo)
 		gecos[len] = 0;
 	}
 
+#ifdef HAVE_LIBUSER
+	if(set_value_libuser("chfn", pinfo->pw->pw_name, pinfo->pw->pw_uid,
+			LU_GECOS, gecos)) {
+#else /* HAVE_LIBUSER */
 	/* write the new struct passwd to the passwd file. */
 	pinfo->pw->pw_gecos = gecos;
 	if (setpwnam(pinfo->pw) < 0) {
+#endif
 		warn("setpwnam");
 		printf(_
 		       ("Finger information *NOT* changed.  Try again later.\n"));
-- 
1.8.1

