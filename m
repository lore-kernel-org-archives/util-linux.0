Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-da0-f45.google.com ([209.85.210.45]:34242 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab3ACDWU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 2 Jan 2013 22:22:20 -0500
Received: by mail-da0-f45.google.com with SMTP id w4so6771697dam.32
        for <util-linux@vger.kernel.org>; Wed, 02 Jan 2013 19:22:19 -0800 (PST)
From: Cody Maloney <cmaloney@theoreticalchaos.com>
To: util-linux@vger.kernel.org
Cc: mitr@redhat.com, Cody Maloney <cmaloney@theoreticalchaos.com>
Subject: [PATCH 2/3] chsh: Move pam auth to its own function.
Date: Wed,  2 Jan 2013 20:22:00 -0700
Message-Id: <1357183321-24637-3-git-send-email-cmaloney@theoreticalchaos.com>
In-Reply-To: <1357183321-24637-1-git-send-email-cmaloney@theoreticalchaos.com>
References: <1357183321-24637-1-git-send-email-cmaloney@theoreticalchaos.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This makes it easier to add support for libuser, which needs the same PAM
authentication.
---
 login-utils/chsh.c | 54 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index 6e9325d..b5c3e2e 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -53,6 +53,7 @@ struct sinfo {
 	char *shell;
 };
 
+static int auth_pam(uid_t uid, struct passwd *pw);
 static void parse_argv(int argc, char **argv, struct sinfo *pinfo);
 static char *prompt(char *question, char *def_val);
 static int check_shell(char *shell);
@@ -147,6 +148,31 @@ int main(int argc, char **argv)
 
 	printf(_("Changing shell for %s.\n"), pw->pw_name);
 
+	if(!auth_pam(uid, pw)) {
+		return EXIT_FAILURE;
+	}
+
+	if (!shell) {
+		shell = prompt(_("New shell"), oldshell);
+		if (!shell)
+			return EXIT_SUCCESS;
+	}
+
+	if (check_shell(shell) < 0)
+		return EXIT_FAILURE;
+
+	if (strcmp(oldshell, shell) == 0)
+		errx(EXIT_SUCCESS, _("Shell not changed."));
+	pw->pw_shell = shell;
+	if (setpwnam(pw) < 0)
+		err(EXIT_FAILURE, _("setpwnam failed\n"
+			"Shell *NOT* changed.  Try again later."));
+
+	printf(_("Shell changed.\n"));
+	return EXIT_SUCCESS;
+}
+
+int auth_pam(uid_t uid, struct passwd *pw) {
 #ifdef REQUIRE_PASSWORD
 	if (uid != 0) {
 		pam_handle_t *pamh = NULL;
@@ -155,47 +181,29 @@ int main(int argc, char **argv)
 
 		retcode = pam_start("chsh", pw->pw_name, &conv, &pamh);
 		if (pam_fail_check(pamh, retcode))
-			return EXIT_FAILURE;
+			return FALSE;
 
 		retcode = pam_authenticate(pamh, 0);
 		if (pam_fail_check(pamh, retcode))
-			return EXIT_FAILURE;
+			return FALSE;
 
 		retcode = pam_acct_mgmt(pamh, 0);
 		if (retcode == PAM_NEW_AUTHTOK_REQD)
 			retcode =
 			    pam_chauthtok(pamh, PAM_CHANGE_EXPIRED_AUTHTOK);
 		if (pam_fail_check(pamh, retcode))
-			return EXIT_FAILURE;
+			return FALSE;
 
 		retcode = pam_setcred(pamh, 0);
 		if (pam_fail_check(pamh, retcode))
-			return EXIT_FAILURE;
+			return FALSE;
 
 		pam_end(pamh, 0);
 		/* no need to establish a session; this isn't a
 		 * session-oriented activity...  */
 	}
+	return TRUE;
 #endif	/* REQUIRE_PASSWORD */
-
-	if (!shell) {
-		shell = prompt(_("New shell"), oldshell);
-		if (!shell)
-			return EXIT_SUCCESS;
-	}
-
-	if (check_shell(shell) < 0)
-		return EXIT_FAILURE;
-
-	if (strcmp(oldshell, shell) == 0)
-		errx(EXIT_SUCCESS, _("Shell not changed."));
-	pw->pw_shell = shell;
-	if (setpwnam(pw) < 0)
-		err(EXIT_FAILURE, _("setpwnam failed\n"
-			"Shell *NOT* changed.  Try again later."));
-
-	printf(_("Shell changed.\n"));
-	return EXIT_SUCCESS;
 }
 
 /*
-- 
1.8.1

