Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ia0-f178.google.com ([209.85.210.178]:53984 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab3AMJM7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Jan 2013 04:12:59 -0500
Received: by mail-ia0-f178.google.com with SMTP id k25so2760301iah.37
        for <util-linux@vger.kernel.org>; Sun, 13 Jan 2013 01:12:59 -0800 (PST)
From: Cody Maloney <cmaloney@theoreticalchaos.com>
To: util-linux@vger.kernel.org
Cc: mitr@redhat.com, Cody Maloney <cmaloney@theoreticalchaos.com>
Subject: [PATCH v2 3/4] chsh: Add libuser support
Date: Sun, 13 Jan 2013 02:12:24 -0700
Message-Id: <1358068345-773-5-git-send-email-cmaloney@theoreticalchaos.com>
In-Reply-To: <1358068345-773-1-git-send-email-cmaloney@theoreticalchaos.com>
References: <1358068345-773-1-git-send-email-cmaloney@theoreticalchaos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is based directly on lchsh which is a part of libuser. libuser.{c,h}
exist because exactly the same code is needed for both chsh and chfn.

Signed-off-by: Cody Maloney <cmaloney@theoreticalchaos.com>
---
 login-utils/Makemodule.am |  3 ++
 login-utils/chsh.c        | 24 ++++++++++++--
 login-utils/libuser.c     | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 login-utils/libuser.h     | 14 ++++++++
 4 files changed, 123 insertions(+), 2 deletions(-)
 create mode 100644 login-utils/libuser.c
 create mode 100644 login-utils/libuser.h

diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index ee85329..0c57118 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -73,6 +73,9 @@ chfn_chsh_ldadd = libcommon.la -lpam -lpam_misc
 if HAVE_USER
 chfn_chsh_ldflags += $(LIBUSER_LIBS)
 chfn_chsh_cflags += $(LIBUSER_CFLAGS)
+chfn_chsh_sources+= \
+	login-utils/libuser.c \
+	login-utils/libuser.h
 endif
 
 if HAVE_SELINUX
diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index 4113df5..fa2fa84 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -1,6 +1,7 @@
 /*
  *   chsh.c -- change your login shell
  *   (c) 1994 by salvatore valente <svalente@athena.mit.edu>
+ *   (c) 2012 by Cody Maloney <cmaloney@theoreticalchaos.com>
  *
  *   this program is free software.  you can redistribute it and
  *   modify it under the terms of the gnu general public license.
@@ -17,7 +18,7 @@
  *   suggestion from Zefram.  Disallowing users with shells not in /etc/shells
  *   from changing their shell.
  *
- *   1999-02-22 Arkadiusz Mi¶kiewicz <misiek@pld.ORG.PL>
+ *   1999-02-22 Arkadiusz MiÂ¶kiewicz <misiek@pld.ORG.PL>
  *   - added Native Language Support
  */
 
@@ -32,7 +33,6 @@
 #include <sys/types.h>
 #include <unistd.h>
 
-#include "auth.h"
 #include "c.h"
 #include "env.h"
 #include "closestream.h"
@@ -48,6 +48,14 @@
 # include "selinux_utils.h"
 #endif
 
+
+#ifdef HAVE_LIBUSER
+# include <libuser/user.h>
+# include "libuser.h"
+#else
+# include "auth.h"
+#endif
+
 struct sinfo {
 	char *username;
 	char *shell;
@@ -131,7 +139,12 @@ int main(int argc, char **argv)
 		oldshell = _PATH_BSHELL;	/* default */
 
 	/* reality check */
+#ifdef HAVE_LIBUSER
+	/* If we're setuid and not really root, disallow the password change. */
+	if (geteuid() != getuid() && uid != pw->pw_uid) {
+#else
 	if (uid != 0 && uid != pw->pw_uid) {
+#endif
 		errno = EACCES;
 		err(EXIT_FAILURE,
 		    _("running UID doesn't match UID of user we're "
@@ -147,9 +160,11 @@ int main(int argc, char **argv)
 
 	printf(_("Changing shell for %s.\n"), pw->pw_name);
 
+#ifndef HAVE_LIBUSER
 	if(!auth_pam("chsh", uid, pw->pw_name)) {
 		return EXIT_FAILURE;
 	}
+#endif
 
 	if (!shell) {
 		shell = prompt(_("New shell"), oldshell);
@@ -162,10 +177,15 @@ int main(int argc, char **argv)
 
 	if (strcmp(oldshell, shell) == 0)
 		errx(EXIT_SUCCESS, _("Shell not changed."));
+
+#ifdef HAVE_LIBUSER
+	set_value_libuser("chsh", pw->pw_name, uid, LU_LOGINSHELL, shell);
+#else
 	pw->pw_shell = shell;
 	if (setpwnam(pw) < 0)
 		err(EXIT_FAILURE, _("setpwnam failed\n"
 			"Shell *NOT* changed.  Try again later."));
+#endif
 
 	printf(_("Shell changed.\n"));
 	return EXIT_SUCCESS;
diff --git a/login-utils/libuser.c b/login-utils/libuser.c
new file mode 100644
index 0000000..9a3e3b1
--- /dev/null
+++ b/login-utils/libuser.c
@@ -0,0 +1,84 @@
+/*
+ *   libuser.c -- Utilize libuser to set a user attribute
+ *   (c) 2012 by Cody Maloney <cmaloney@theoreticalchaos.com>
+ *
+ *   this program is free software.  you can redistribute it and
+ *   modify it under the terms of the gnu general public license.
+ *   there is no warranty.
+ *
+ */
+
+#include "libuser.h"
+
+#include <grp.h>
+#include <libuser/user.h>
+#include <unistd.h>
+
+#include "auth.h"
+#include "c.h"
+#include "nls.h"
+
+static int auth_lu(const char *service_name, struct lu_context *ctx, uid_t uid,
+			const char *username);
+
+static int auth_lu(const char *service_name, struct lu_context *ctx, uid_t uid,
+			const char *username) {
+	if(!lu_uses_elevated_privileges(ctx)) {
+		/* Drop privileges */
+		if (setegid(getgid()) == -1) {
+			errx(EXIT_FAILURE, _("Couldn't drop group privileges"));
+			return FALSE;
+		}
+		if (seteuid(getuid()) == -1) {
+			errx(EXIT_FAILURE, _("Couldn't drop group privileges"));
+			return FALSE;
+		}
+		if (initgroups(username, 0)) {
+			errx(EXIT_FAILURE, _("Couldn't drop group privileges"));
+			return FALSE;
+		}
+		return TRUE;
+	}
+
+	return auth_pam(service_name, uid, username);
+}
+
+int set_value_libuser(const char *service_name, const char *username, uid_t uid,
+			const char *attr, const char *val) {
+	struct lu_context *ctx;
+	struct lu_error *error = NULL;
+	struct lu_ent *ent;
+
+	ctx = lu_start(username, lu_user, NULL, NULL, lu_prompt_console_quiet,
+			NULL, &error);
+	if (ctx == NULL) {
+		err(EXIT_FAILURE, _("Error initializing %s: %s.\n"), PACKAGE,
+			lu_strerror(error));
+		return FALSE;
+	}
+
+	if(!auth_lu(service_name, ctx, uid, username)) {
+		errno = EACCES;
+		err(EXIT_FAILURE, _("Permisison denied for changing user attribute"));
+		return FALSE;
+	}
+
+	/* Look up the user's record. */
+	ent = lu_ent_new();
+	if (lu_user_lookup_name(ctx, username, ent, &error) == FALSE) {
+		lu_end(ctx);
+		err(EXIT_FAILURE, _("user \"%s\" does not exist."), username);
+		return FALSE;
+	}
+
+	lu_ent_set_string(ent, attr, val);
+	if (!lu_user_modify(ctx, ent, &error)) {
+		lu_ent_free(ent);
+		lu_end(ctx);
+		err(EXIT_FAILURE, _("Shell not changed: %s\n"), lu_strerror(error));
+		return FALSE;
+	}
+	lu_ent_free(ent);
+	lu_end(ctx);
+	return TRUE;
+}
diff --git a/login-utils/libuser.h b/login-utils/libuser.h
new file mode 100644
index 0000000..7454b99
--- /dev/null
+++ b/login-utils/libuser.h
@@ -0,0 +1,14 @@
+/*
+ *   libuser.h -- Utilize libuser to set a user attribute
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
+extern int set_value_libuser(const char *service_name, const char *username,
+			uid_t uid, const char *attr, const char *val);
-- 
1.8.1

