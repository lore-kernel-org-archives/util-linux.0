Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ie0-f172.google.com ([209.85.223.172]:47300 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab3AMJM6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Jan 2013 04:12:58 -0500
Received: by mail-ie0-f172.google.com with SMTP id c13so3887128ieb.17
        for <util-linux@vger.kernel.org>; Sun, 13 Jan 2013 01:12:57 -0800 (PST)
From: Cody Maloney <cmaloney@theoreticalchaos.com>
To: util-linux@vger.kernel.org
Cc: mitr@redhat.com, Cody Maloney <cmaloney@theoreticalchaos.com>
Subject: [PATCH v2 2/4] chsh-chfn: Move pam auth to its own function, factoring out common code
Date: Sun, 13 Jan 2013 02:12:23 -0700
Message-Id: <1358068345-773-4-git-send-email-cmaloney@theoreticalchaos.com>
In-Reply-To: <1358068345-773-1-git-send-email-cmaloney@theoreticalchaos.com>
References: <1358068345-773-1-git-send-email-cmaloney@theoreticalchaos.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This makes it easier to add support for libuser, which needs the same PAM
authentication. Also removes duplicate code between chsh and chfn.

Signed-off-by: Cody Maloney <cmaloney@theoreticalchaos.com>
---
 login-utils/Makemodule.am |  2 ++
 login-utils/auth.c        | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 login-utils/auth.h        | 13 +++++++++++++
 login-utils/chfn.c        | 33 +++------------------------------
 login-utils/chsh.c        | 33 +++------------------------------
 5 files changed, 68 insertions(+), 60 deletions(-)
 create mode 100644 login-utils/auth.c
 create mode 100644 login-utils/auth.h

diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index 479b87b..ee85329 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -62,6 +62,8 @@ dist_man_MANS += \
 chfn_chsh_sources = \
 	login-utils/islocal.c \
 	login-utils/islocal.h \
+	login-utils/auth.c \
+	login-utils/auth.h \
 	login-utils/setpwnam.c \
 	login-utils/setpwnam.h
 chfn_chsh_cflags = $(SUID_CFLAGS) $(AM_CFLAGS)
diff --git a/login-utils/auth.c b/login-utils/auth.c
new file mode 100644
index 0000000..373bd22
--- /dev/null
+++ b/login-utils/auth.c
@@ -0,0 +1,47 @@
+/*
+ *   auth.c -- PAM authorization code, common between chsh and chfn
+ *   (c) 2012 by Cody Maloney <cmaloney@theoreticalchaos.com>
+ *
+ *   this program is free software.  you can redistribute it and
+ *   modify it under the terms of the gnu general public license.
+ *   there is no warranty.
+ *
+ */
+
+#include "auth.h"
+
+#include "pamfail.h"
+
+int auth_pam(const char *service_name, uid_t uid, const char *username) {
+#ifdef REQUIRE_PASSWORD
+	if (uid != 0) {
+		pam_handle_t *pamh = NULL;
+		struct pam_conv conv = { misc_conv, NULL };
+		int retcode;
+
+		retcode = pam_start(service_name, username, &conv, &pamh);
+		if (pam_fail_check(pamh, retcode))
+			return FALSE;
+
+		retcode = pam_authenticate(pamh, 0);
+		if (pam_fail_check(pamh, retcode))
+			return FALSE;
+
+		retcode = pam_acct_mgmt(pamh, 0);
+		if (retcode == PAM_NEW_AUTHTOK_REQD)
+			retcode =
+			    pam_chauthtok(pamh, PAM_CHANGE_EXPIRED_AUTHTOK);
+		if (pam_fail_check(pamh, retcode))
+			return FALSE;
+
+		retcode = pam_setcred(pamh, 0);
+		if (pam_fail_check(pamh, retcode))
+			return FALSE;
+
+		pam_end(pamh, 0);
+		/* no need to establish a session; this isn't a
+		 * session-oriented activity...  */
+	}
+	return TRUE;
+#endif	/* REQUIRE_PASSWORD */
+}
diff --git a/login-utils/auth.h b/login-utils/auth.h
new file mode 100644
index 0000000..bf7c369
--- /dev/null
+++ b/login-utils/auth.h
@@ -0,0 +1,13 @@
+/*
+ *   auth.h -- PAM authorization code, common between chsh and chfn
+ *   (c) 2012 by Cody Maloney <cmaloney@theoreticalchaos.com>
+ *
+ *   this program is free software.  you can redistribute it and
+ *   modify it under the terms of the gnu general public license.
+ *   there is no warranty.
+ *
+ */
+
+#include <sys/types.h>
+
+extern int auth_pam(const char *service_name, uid_t uid, const char *username);
diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index 76c0b03..e189558 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -31,12 +31,12 @@
 #include <sys/types.h>
 #include <unistd.h>
 
+#include "auth.h"
 #include "c.h"
 #include "env.h"
 #include "closestream.h"
 #include "islocal.h"
 #include "nls.h"
-#include "pamfail.h"
 #include "setpwnam.h"
 #include "strutils.h"
 #include "xalloc.h"
@@ -157,36 +157,9 @@ int main(int argc, char **argv)
 
 	printf(_("Changing finger information for %s.\n"), oldf.username);
 
-#ifdef REQUIRE_PASSWORD
-	if (uid != 0) {
-		pam_handle_t *pamh = NULL;
-		struct pam_conv conv = { misc_conv, NULL };
-		int retcode;
-
-		retcode = pam_start("chfn", oldf.username, &conv, &pamh);
-		if (pam_fail_check(pamh, retcode))
-			return EXIT_FAILURE;
-
-		retcode = pam_authenticate(pamh, 0);
-		if (pam_fail_check(pamh, retcode))
-			return EXIT_FAILURE;
-
-		retcode = pam_acct_mgmt(pamh, 0);
-		if (retcode == PAM_NEW_AUTHTOK_REQD)
-			retcode =
-			    pam_chauthtok(pamh, PAM_CHANGE_EXPIRED_AUTHTOK);
-		if (pam_fail_check(pamh, retcode))
-			return EXIT_FAILURE;
-
-		retcode = pam_setcred(pamh, 0);
-		if (pam_fail_check(pamh, retcode))
-			return EXIT_FAILURE;
-
-		pam_end(pamh, 0);
-		/* no need to establish a session; this isn't a
-		 * session-oriented activity...  */
+	if(!auth_pam("chfn", uid, oldf.username)) {
+		return EXIT_FAILURE;
 	}
-#endif	/* REQUIRE_PASSWORD */
 
 	if (interactive)
 		ask_info(&oldf, &newf);
diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index 6e9325d..4113df5 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -32,12 +32,12 @@
 #include <sys/types.h>
 #include <unistd.h>
 
+#include "auth.h"
 #include "c.h"
 #include "env.h"
 #include "closestream.h"
 #include "islocal.h"
 #include "nls.h"
-#include "pamfail.h"
 #include "pathnames.h"
 #include "setpwnam.h"
 #include "xalloc.h"
@@ -147,36 +147,9 @@ int main(int argc, char **argv)
 
 	printf(_("Changing shell for %s.\n"), pw->pw_name);
 
-#ifdef REQUIRE_PASSWORD
-	if (uid != 0) {
-		pam_handle_t *pamh = NULL;
-		struct pam_conv conv = { misc_conv, NULL };
-		int retcode;
-
-		retcode = pam_start("chsh", pw->pw_name, &conv, &pamh);
-		if (pam_fail_check(pamh, retcode))
-			return EXIT_FAILURE;
-
-		retcode = pam_authenticate(pamh, 0);
-		if (pam_fail_check(pamh, retcode))
-			return EXIT_FAILURE;
-
-		retcode = pam_acct_mgmt(pamh, 0);
-		if (retcode == PAM_NEW_AUTHTOK_REQD)
-			retcode =
-			    pam_chauthtok(pamh, PAM_CHANGE_EXPIRED_AUTHTOK);
-		if (pam_fail_check(pamh, retcode))
-			return EXIT_FAILURE;
-
-		retcode = pam_setcred(pamh, 0);
-		if (pam_fail_check(pamh, retcode))
-			return EXIT_FAILURE;
-
-		pam_end(pamh, 0);
-		/* no need to establish a session; this isn't a
-		 * session-oriented activity...  */
+	if(!auth_pam("chsh", uid, pw->pw_name)) {
+		return EXIT_FAILURE;
 	}
-#endif	/* REQUIRE_PASSWORD */
 
 	if (!shell) {
 		shell = prompt(_("New shell"), oldshell);
-- 
1.8.1

