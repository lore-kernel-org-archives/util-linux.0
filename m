Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37922 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558AbaLVLrf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Dec 2014 06:47:35 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so7665800wid.5
        for <util-linux@vger.kernel.org>; Mon, 22 Dec 2014 03:47:34 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 08/14] chsh: simplify check_shell()
Date: Mon, 22 Dec 2014 11:47:11 +0000
Message-Id: <1419248837-4619-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
References: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Shell null check is redundant.  The shell can be null only after
ask_new_shell returned such, and that is checked earlier in program
logic.

Secondly the check_shell does not need to return values, in such cases
the program can simply exit.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chsh.c | 49 ++++++++++++++++---------------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index bcd0995..3c51783 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -193,50 +193,34 @@ static char *ask_new_shell(char *question, char *oldshell)
 
 /*
  *  check_shell () -- if the shell is completely invalid, print
- *	an error and return (-1).
- *	if the shell is a bad idea, print a warning.
+ *	an error and exit.
  */
-static int check_shell(const char *shell)
+static void check_shell(const char *shell)
 {
-	if (!shell)
-		return -1;
-
-	if (*shell != '/') {
-		warnx(_("shell must be a full path name"));
-		return -1;
-	}
-	if (access(shell, F_OK) < 0) {
-		warnx(_("\"%s\" does not exist"), shell);
-		return -1;
-	}
-	if (access(shell, X_OK) < 0) {
-		printf(_("\"%s\" is not executable"), shell);
-		return -1;
-	}
-	if (illegal_passwd_chars(shell)) {
-		warnx(_("%s: has illegal characters"), shell);
-		return -1;
-	}
-#ifdef ONLY_LISTED_SHELLS
+	if (*shell != '/')
+		errx(EXIT_FAILURE, _("shell must be a full path name"));
+	if (access(shell, F_OK) < 0)
+		errx(EXIT_FAILURE, _("\"%s\" does not exist"), shell);
+	if (access(shell, X_OK) < 0)
+		errx(EXIT_FAILURE, _("\"%s\" is not executable"), shell);
+	if (illegal_passwd_chars(shell))
+		errx(EXIT_FAILURE, _("%s: has illegal characters"), shell);
 	if (!get_shell_list(shell)) {
+#ifdef ONLY_LISTED_SHELLS
 		if (!getuid())
-			warnx(_
-			      ("Warning: \"%s\" is not listed in %s."),
-			      shell, _PATH_SHELLS);
+			warnx(_("Warning: \"%s\" is not listed in %s."), shell,
+			      _PATH_SHELLS);
 		else
 			errx(EXIT_FAILURE,
 			     _("\"%s\" is not listed in %s.\n"
 			       "Use %s -l to see list."), shell, _PATH_SHELLS,
 			     program_invocation_short_name);
-	}
 #else
-	if (!get_shell_list(shell)) {
 		warnx(_("\"%s\" is not listed in %s.\n"
 			"Use %s -l to see list."), shell, _PATH_SHELLS,
-		      program_invocation_short_name);
-	}
+		       program_invocation_short_name);
 #endif
-	return 0;
+	}
 }
 
 int main(int argc, char **argv)
@@ -329,8 +313,7 @@ int main(int argc, char **argv)
 			return EXIT_SUCCESS;
 	}
 
-	if (check_shell(info.shell) < 0)
-		return EXIT_FAILURE;
+	check_shell(info.shell);
 
 	if (!nullshell && strcmp(oldshell, info.shell) == 0)
 		errx(EXIT_SUCCESS, _("Shell not changed."));
-- 
2.2.1

