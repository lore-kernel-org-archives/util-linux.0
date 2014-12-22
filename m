Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33502 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465AbaLVLrW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Dec 2014 06:47:22 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so7682034wiv.8
        for <util-linux@vger.kernel.org>; Mon, 22 Dec 2014 03:47:21 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 01/14] chsh: remove function prototypes
Date: Mon, 22 Dec 2014 11:47:04 +0000
Message-Id: <1419248837-4619-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
References: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chsh.c | 290 ++++++++++++++++++++++++++---------------------------
 1 file changed, 143 insertions(+), 147 deletions(-)

diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index 76c3d21..1327614 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -61,10 +61,6 @@ struct sinfo {
 	char *shell;
 };
 
-static void parse_argv(int argc, char **argv, struct sinfo *pinfo);
-static char *prompt(char *question, char *def_val);
-static int check_shell(char *shell);
-static int get_shell_list(char *shell);
 
 static void __attribute__((__noreturn__)) usage (FILE *fp)
 {
@@ -80,118 +76,47 @@ static void __attribute__((__noreturn__)) usage (FILE *fp)
 	exit(fp == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-int main(int argc, char **argv)
+/*
+ *  get_shell_list () -- if the given shell appears in /etc/shells,
+ *	return true.  if not, return false.
+ *	if the given shell is NULL, /etc/shells is outputted to stdout.
+ */
+static int get_shell_list(char *shell_name)
 {
-	char *shell, *oldshell;
-	uid_t uid;
-	struct sinfo info;
-	struct passwd *pw;
-
-	sanitize_env();
-	setlocale(LC_ALL, "");
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
-	atexit(close_stdout);
-
-	uid = getuid();
-	memset(&info, 0, sizeof(info));
+	FILE *fp;
+	int found;
+	int len;
+	char buf[PATH_MAX];
 
-	parse_argv(argc, argv, &info);
-	pw = NULL;
-	if (!info.username) {
-		pw = getpwuid(uid);
-		if (!pw)
-			errx(EXIT_FAILURE, _("you (user %d) don't exist."),
-			     uid);
-	} else {
-		pw = getpwnam(info.username);
-		if (!pw)
-			errx(EXIT_FAILURE, _("user \"%s\" does not exist."),
-			     info.username);
+	found = false;
+	fp = fopen(_PATH_SHELLS, "r");
+	if (!fp) {
+		if (!shell_name)
+			warnx(_("No known shells."));
+		return true;
 	}
-
-#ifndef HAVE_LIBUSER
-	if (!(is_local(pw->pw_name)))
-		errx(EXIT_FAILURE, _("can only change local entries"));
-#endif
-
-#ifdef HAVE_LIBSELINUX
-	if (is_selinux_enabled() > 0) {
-		if (uid == 0) {
-			if (checkAccess(pw->pw_name, PASSWD__CHSH) != 0) {
-				security_context_t user_context;
-				if (getprevcon(&user_context) < 0)
-					user_context =
-					    (security_context_t) NULL;
-
-				errx(EXIT_FAILURE,
-				     _("%s is not authorized to change the shell of %s"),
-				     user_context ? : _("Unknown user context"),
-				     pw->pw_name);
+	while (fgets(buf, sizeof(buf), fp) != NULL) {
+		/* ignore comments */
+		if (*buf == '#')
+			continue;
+		len = strlen(buf);
+		/* strip the ending newline */
+		if (buf[len - 1] == '\n')
+			buf[len - 1] = 0;
+		/* ignore lines that are too damn long */
+		else
+			continue;
+		/* check or output the shell */
+		if (shell_name) {
+			if (!strcmp(shell_name, buf)) {
+				found = true;
+				break;
 			}
-		}
-		if (setupDefaultContext(_PATH_PASSWD) != 0)
-			errx(EXIT_FAILURE,
-			     _("can't set default context for %s"), _PATH_PASSWD);
-	}
-#endif
-
-	oldshell = pw->pw_shell;
-	if (oldshell == NULL || *oldshell == '\0')
-		oldshell = _PATH_BSHELL;	/* default */
-
-	/* reality check */
-#ifdef HAVE_LIBUSER
-	/* If we're setuid and not really root, disallow the password change. */
-	if (geteuid() != getuid() && uid != pw->pw_uid) {
-#else
-	if (uid != 0 && uid != pw->pw_uid) {
-#endif
-		errno = EACCES;
-		err(EXIT_FAILURE,
-		    _("running UID doesn't match UID of user we're "
-		      "altering, shell change denied"));
-	}
-	if (uid != 0 && !get_shell_list(oldshell)) {
-		errno = EACCES;
-		err(EXIT_FAILURE, _("your shell is not in %s, "
-				    "shell change denied"), _PATH_SHELLS);
-	}
-
-	shell = info.shell;
-
-	printf(_("Changing shell for %s.\n"), pw->pw_name);
-
-#if !defined(HAVE_LIBUSER) && defined(CHFN_CHSH_PASSWORD)
-	if(!auth_pam("chsh", uid, pw->pw_name)) {
-		return EXIT_FAILURE;
-	}
-#endif
-	if (!shell) {
-		shell = prompt(_("New shell"), oldshell);
-		if (!shell)
-			return EXIT_SUCCESS;
+		} else
+			printf("%s\n", buf);
 	}
-
-	if (check_shell(shell) < 0)
-		return EXIT_FAILURE;
-
-	if (strcmp(oldshell, shell) == 0)
-		errx(EXIT_SUCCESS, _("Shell not changed."));
-
-#ifdef HAVE_LIBUSER
-	if (set_value_libuser("chsh", pw->pw_name, uid,
-	    LU_LOGINSHELL, shell) < 0)
-		errx(EXIT_FAILURE, _("Shell *NOT* changed.  Try again later."));
-#else
-	pw->pw_shell = shell;
-	if (setpwnam(pw) < 0)
-		err(EXIT_FAILURE, _("setpwnam failed\n"
-			"Shell *NOT* changed.  Try again later."));
-#endif
-
-	printf(_("Shell changed.\n"));
-	return EXIT_SUCCESS;
+	fclose(fp);
+	return found;
 }
 
 /*
@@ -331,45 +256,116 @@ static int check_shell(char *shell)
 	return 0;
 }
 
-/*
- *  get_shell_list () -- if the given shell appears in /etc/shells,
- *	return true.  if not, return false.
- *	if the given shell is NULL, /etc/shells is outputted to stdout.
- */
-static int get_shell_list(char *shell_name)
+int main(int argc, char **argv)
 {
-	FILE *fp;
-	int found;
-	int len;
-	char buf[PATH_MAX];
+	char *shell, *oldshell;
+	uid_t uid;
+	struct sinfo info;
+	struct passwd *pw;
 
-	found = false;
-	fp = fopen(_PATH_SHELLS, "r");
-	if (!fp) {
-		if (!shell_name)
-			warnx(_("No known shells."));
-		return true;
+	sanitize_env();
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	uid = getuid();
+	memset(&info, 0, sizeof(info));
+
+	parse_argv(argc, argv, &info);
+	pw = NULL;
+	if (!info.username) {
+		pw = getpwuid(uid);
+		if (!pw)
+			errx(EXIT_FAILURE, _("you (user %d) don't exist."),
+			     uid);
+	} else {
+		pw = getpwnam(info.username);
+		if (!pw)
+			errx(EXIT_FAILURE, _("user \"%s\" does not exist."),
+			     info.username);
 	}
-	while (fgets(buf, sizeof(buf), fp) != NULL) {
-		/* ignore comments */
-		if (*buf == '#')
-			continue;
-		len = strlen(buf);
-		/* strip the ending newline */
-		if (buf[len - 1] == '\n')
-			buf[len - 1] = 0;
-		/* ignore lines that are too damn long */
-		else
-			continue;
-		/* check or output the shell */
-		if (shell_name) {
-			if (!strcmp(shell_name, buf)) {
-				found = true;
-				break;
+
+#ifndef HAVE_LIBUSER
+	if (!(is_local(pw->pw_name)))
+		errx(EXIT_FAILURE, _("can only change local entries"));
+#endif
+
+#ifdef HAVE_LIBSELINUX
+	if (is_selinux_enabled() > 0) {
+		if (uid == 0) {
+			if (checkAccess(pw->pw_name, PASSWD__CHSH) != 0) {
+				security_context_t user_context;
+				if (getprevcon(&user_context) < 0)
+					user_context =
+					    (security_context_t) NULL;
+
+				errx(EXIT_FAILURE,
+				     _("%s is not authorized to change the shell of %s"),
+				     user_context ? : _("Unknown user context"),
+				     pw->pw_name);
 			}
-		} else
-			printf("%s\n", buf);
+		}
+		if (setupDefaultContext(_PATH_PASSWD) != 0)
+			errx(EXIT_FAILURE,
+			     _("can't set default context for %s"), _PATH_PASSWD);
 	}
-	fclose(fp);
-	return found;
+#endif
+
+	oldshell = pw->pw_shell;
+	if (oldshell == NULL || *oldshell == '\0')
+		oldshell = _PATH_BSHELL;	/* default */
+
+	/* reality check */
+#ifdef HAVE_LIBUSER
+	/* If we're setuid and not really root, disallow the password change. */
+	if (geteuid() != getuid() && uid != pw->pw_uid) {
+#else
+	if (uid != 0 && uid != pw->pw_uid) {
+#endif
+		errno = EACCES;
+		err(EXIT_FAILURE,
+		    _("running UID doesn't match UID of user we're "
+		      "altering, shell change denied"));
+	}
+	if (uid != 0 && !get_shell_list(oldshell)) {
+		errno = EACCES;
+		err(EXIT_FAILURE, _("your shell is not in %s, "
+				    "shell change denied"), _PATH_SHELLS);
+	}
+
+	shell = info.shell;
+
+	printf(_("Changing shell for %s.\n"), pw->pw_name);
+
+#if !defined(HAVE_LIBUSER) && defined(CHFN_CHSH_PASSWORD)
+	if(!auth_pam("chsh", uid, pw->pw_name)) {
+		return EXIT_FAILURE;
+	}
+#endif
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
+
+#ifdef HAVE_LIBUSER
+	if (set_value_libuser("chsh", pw->pw_name, uid,
+	    LU_LOGINSHELL, shell) < 0)
+		errx(EXIT_FAILURE, _("Shell *NOT* changed.  Try again later."));
+#else
+	pw->pw_shell = shell;
+	if (setpwnam(pw) < 0)
+		err(EXIT_FAILURE, _("setpwnam failed\n"
+			"Shell *NOT* changed.  Try again later."));
+#endif
+
+	printf(_("Shell changed.\n"));
+	return EXIT_SUCCESS;
 }
-- 
2.2.1

