Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f42.google.com ([209.85.160.42]:61150 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab3ACDWV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 2 Jan 2013 22:22:21 -0500
Received: by mail-pb0-f42.google.com with SMTP id rp2so8273326pbb.29
        for <util-linux@vger.kernel.org>; Wed, 02 Jan 2013 19:22:20 -0800 (PST)
From: Cody Maloney <cmaloney@theoreticalchaos.com>
To: util-linux@vger.kernel.org
Cc: mitr@redhat.com, Cody Maloney <cmaloney@theoreticalchaos.com>
Subject: [PATCH 3/3] chsh: Add libuser support
Date: Wed,  2 Jan 2013 20:22:01 -0700
Message-Id: <1357183321-24637-4-git-send-email-cmaloney@theoreticalchaos.com>
In-Reply-To: <1357183321-24637-1-git-send-email-cmaloney@theoreticalchaos.com>
References: <1357183321-24637-1-git-send-email-cmaloney@theoreticalchaos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is based directly on lchsh which is a part of libuser.
---
 login-utils/chsh.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 2 deletions(-)

diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index b5c3e2e..6db6b44 100644
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
 
@@ -48,11 +49,20 @@
 # include "selinux_utils.h"
 #endif
 
+
+#ifdef HAVE_LIBUSER
+# include <libuser/user.h>
+#endif
+
 struct sinfo {
 	char *username;
 	char *shell;
 };
 
+#ifdef HAVE_LIBUSER
+static int auth_lu(struct lu_context *ctx, uid_t uid, struct passwd *pw);
+#endif
+
 static int auth_pam(uid_t uid, struct passwd *pw);
 static void parse_argv(int argc, char **argv, struct sinfo *pinfo);
 static char *prompt(char *question, char *def_val);
@@ -80,6 +90,13 @@ int main(int argc, char **argv)
 	struct sinfo info;
 	struct passwd *pw;
 
+#ifdef HAVE_LIBUSER
+	struct lu_context *ctx;
+	struct lu_error *error = NULL;
+	struct lu_ent *ent;
+	GValue val;
+#endif
+
 	sanitize_env();
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -132,7 +149,12 @@ int main(int argc, char **argv)
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
@@ -148,9 +170,11 @@ int main(int argc, char **argv)
 
 	printf(_("Changing shell for %s.\n"), pw->pw_name);
 
+#ifndef HAVE_LIBUSER
 	if(!auth_pam(uid, pw)) {
 		return EXIT_FAILURE;
 	}
+#endif
 
 	if (!shell) {
 		shell = prompt(_("New shell"), oldshell);
@@ -163,15 +187,72 @@ int main(int argc, char **argv)
 
 	if (strcmp(oldshell, shell) == 0)
 		errx(EXIT_SUCCESS, _("Shell not changed."));
+
+#ifdef HAVE_LIBUSER
+	ctx = lu_start(pw->pw_name, lu_user, NULL, NULL, NULL, NULL, &error);
+	if (ctx == NULL) {
+		errx(EXIT_FAILURE, _("Error initializing %s: %s.\n"), PACKAGE,
+			lu_strerror(error));
+	}
+
+	if(!auth_lu(ctx, uid, pw)) {
+		errno = EACCES;
+		errx(EXIT_FAILURE, _("Permisison denied for changing shell"));
+	}
+
+	/* Look up the user's record. */
+	ent = lu_ent_new();
+	if (lu_user_lookup_name(ctx, pw->pw_name, ent, &error) == FALSE) {
+		lu_end(ctx);
+		errx(EXIT_FAILURE, _("user \"%s\" does not exist."), pw->pw_name);
+	}
+
+	memset(&val, 0, sizeof(val));
+	g_value_init(&val, G_TYPE_STRING);
+	g_value_set_string(&val, shell);
+
+	lu_ent_clear(ent, LU_LOGINSHELL);
+	lu_ent_add(ent, LU_LOGINSHELL, &val);
+	if (!lu_user_modify(ctx, ent, &error)) {
+		g_value_unset(&val);
+		lu_ent_free(ent);
+		lu_end(ctx);
+		err(EXIT_FAILURE, _("Shell not changed: %s\n"), lu_strerror(error));
+	}
+	g_value_unset(&val);
+	lu_ent_free(ent);
+	lu_end(ctx);
+
+#else /* HAVE_LIBUSER */
 	pw->pw_shell = shell;
 	if (setpwnam(pw) < 0)
-		err(EXIT_FAILURE, _("setpwnam failed\n"
+		errx(EXIT_FAILURE, _("setpwnam failed\n"
 			"Shell *NOT* changed.  Try again later."));
+#endif /* HAVE_LIBUSER */
 
 	printf(_("Shell changed.\n"));
 	return EXIT_SUCCESS;
 }
 
+#ifdef HAVE_LIBUSER
+static int auth_lu(struct lu_context *ctx, uid_t uid, struct passwd *pw) {
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
+		return TRUE;
+	}
+
+	return auth_pam(uid, pw);
+}
+#endif
+
 int auth_pam(uid_t uid, struct passwd *pw) {
 #ifdef REQUIRE_PASSWORD
 	if (uid != 0) {
-- 
1.8.1

