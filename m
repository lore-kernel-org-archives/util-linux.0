Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:63439 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558AbaLVLrb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Dec 2014 06:47:31 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so7671385wiw.10
        for <util-linux@vger.kernel.org>; Mon, 22 Dec 2014 03:47:30 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 04/14] chsh: set few variables read-only and rename one of them
Date: Mon, 22 Dec 2014 11:47:07 +0000
Message-Id: <1419248837-4619-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
References: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This change also improves couple variable initializations.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chsh.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index 9ed4d06..a316415 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -83,7 +83,7 @@ static void __attribute__((__noreturn__)) usage (FILE *fp)
  *	return true.  if not, return false.
  *	if the given shell is NULL, /etc/shells is outputted to stdout.
  */
-static int get_shell_list(char *shell_name)
+static int get_shell_list(const char *shell_name)
 {
 	FILE *fp;
 	int found;
@@ -206,7 +206,7 @@ static char *prompt(char *question, char *def_val)
  *	an error and return (-1).
  *	if the shell is a bad idea, print a warning.
  */
-static int check_shell(char *shell)
+static int check_shell(const char *shell)
 {
 	if (!shell)
 		return -1;
@@ -251,9 +251,9 @@ static int check_shell(char *shell)
 
 int main(int argc, char **argv)
 {
-	char *shell, *oldshell;
-	uid_t uid;
-	struct sinfo info;
+	char *oldshell;
+	const uid_t uid = getuid();
+	struct sinfo info = { 0 };
 	struct passwd *pw;
 
 	sanitize_env();
@@ -262,11 +262,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	uid = getuid();
-	memset(&info, 0, sizeof(info));
-
 	parse_argv(argc, argv, &info);
-	pw = NULL;
 	if (!info.username) {
 		pw = getpwuid(uid);
 		if (!pw)
@@ -327,33 +323,31 @@ int main(int argc, char **argv)
 				    "shell change denied"), _PATH_SHELLS);
 	}
 
-	shell = info.shell;
-
 	printf(_("Changing shell for %s.\n"), pw->pw_name);
 
 #if !defined(HAVE_LIBUSER) && defined(CHFN_CHSH_PASSWORD)
-	if(!auth_pam("chsh", uid, pw->pw_name)) {
+	if (!auth_pam("chsh", uid, pw->pw_name)) {
 		return EXIT_FAILURE;
 	}
 #endif
-	if (!shell) {
-		shell = prompt(_("New shell"), oldshell);
-		if (!shell)
+	if (!info.shell) {
+		info.shell = prompt(_("New shell"), oldshell);
+		if (!info.shell)
 			return EXIT_SUCCESS;
 	}
 
-	if (check_shell(shell) < 0)
+	if (check_shell(info.shell) < 0)
 		return EXIT_FAILURE;
 
-	if (strcmp(oldshell, shell) == 0)
+	if (strcmp(oldshell, info.shell) == 0)
 		errx(EXIT_SUCCESS, _("Shell not changed."));
 
 #ifdef HAVE_LIBUSER
 	if (set_value_libuser("chsh", pw->pw_name, uid,
-	    LU_LOGINSHELL, shell) < 0)
+	    LU_LOGINSHELL, info.shell) < 0)
 		errx(EXIT_FAILURE, _("Shell *NOT* changed.  Try again later."));
 #else
-	pw->pw_shell = shell;
+	pw->pw_shell = info.shell;
 	if (setpwnam(pw) < 0)
 		err(EXIT_FAILURE, _("setpwnam failed\n"
 			"Shell *NOT* changed.  Try again later."));
-- 
2.2.1

