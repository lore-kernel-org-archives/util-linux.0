Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:54613 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbaLNRpX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Dec 2014 12:45:23 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so6867097wid.17
        for <util-linux@vger.kernel.org>; Sun, 14 Dec 2014 09:45:22 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 08/16] chfn: remove function prototypes
Date: Sun, 14 Dec 2014 17:44:04 +0000
Message-Id: <1418579052-29386-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Requires resuffling functions order they work without issues.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chfn.c | 276 ++++++++++++++++++++++++++---------------------------
 1 file changed, 134 insertions(+), 142 deletions(-)

diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index 25f7e91..35d00f9 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -66,14 +66,6 @@ struct finfo {
 	char *other;
 };
 
-static int parse_argv(int argc, char *argv[], struct finfo *pinfo);
-static void parse_passwd(struct passwd *pw, struct finfo *pinfo);
-static void ask_info(struct finfo *oldfp, struct finfo *newfp);
-static char *prompt(char *question, char *def_val);
-static int check_gecos_string(char *msg, char *gecos);
-static int set_changed_data(struct finfo *oldfp, struct finfo *newfp);
-static int save_new_data(struct finfo *pinfo);
-
 /* we do not accept gecos field sizes longer than MAX_FIELD_SIZE */
 #define MAX_FIELD_SIZE		256
 
@@ -93,99 +85,43 @@ static void __attribute__((__noreturn__)) usage(FILE *fp)
 	exit(fp == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-int main(int argc, char **argv)
+/*
+ *  check_gecos_string () --
+ *	check that the given gecos string is legal.  if it's not legal,
+ *	output "msg" followed by a description of the problem, and return (-1).
+ */
+static int check_gecos_string(char *msg, char *gecos)
 {
-	uid_t uid;
-	struct finfo oldf, newf;
-	int interactive;
-
-	sanitize_env();
-	setlocale(LC_ALL, "");	/* both for messages and for iscntrl() below */
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
-	atexit(close_stdout);
-
-	/*
-	 *  "oldf" contains the users original finger information.
-	 *  "newf" contains the changed finger information, and contains NULL
-	 *         in fields that haven't been changed.
-	 *  in the end, "newf" is folded into "oldf".
-	 *
-	 *  the reason the new finger information is not put _immediately_
-	 *  into "oldf" is that on the command line, new finger information
-	 *  can be specified before we know what user the information is
-	 *  being specified for.
-	 */
-	uid = getuid();
-	memset(&oldf, 0, sizeof(oldf));
-	memset(&newf, 0, sizeof(newf));
+	unsigned int i, c;
 
-	interactive = parse_argv(argc, argv, &newf);
-	if (!newf.username) {
-		parse_passwd(getpwuid(uid), &oldf);
-		if (!oldf.username)
-			errx(EXIT_FAILURE, _("you (user %d) don't exist."),
-			     uid);
-	} else {
-		parse_passwd(getpwnam(newf.username), &oldf);
-		if (!oldf.username)
-			errx(EXIT_FAILURE, _("user \"%s\" does not exist."),
-			     newf.username);
+	if (strlen(gecos) > MAX_FIELD_SIZE) {
+		if (msg)
+			warnx(_("field %s is too long"), msg);
+		else
+			warnx(_("field is too long"));
+		return -1;
 	}
 
-#ifndef HAVE_LIBUSER
-	if (!(is_local(oldf.username)))
-		errx(EXIT_FAILURE, _("can only change local entries"));
-#endif
-
-#ifdef HAVE_LIBSELINUX
-	if (is_selinux_enabled() > 0) {
-		if (uid == 0) {
-			if (checkAccess(oldf.username, PASSWD__CHFN) != 0) {
-				security_context_t user_context;
-				if (getprevcon(&user_context) < 0)
-					user_context = NULL;
-				errx(EXIT_FAILURE,
-				     _("%s is not authorized to change "
-				       "the finger info of %s"),
-				     user_context ? : _("Unknown user context"),
-				     oldf.username);
-			}
+	for (i = 0; i < strlen(gecos); i++) {
+		c = gecos[i];
+		if (c == ',' || c == ':' || c == '=' || c == '"' || c == '\n') {
+			if (msg)
+				warnx(_("%s: '%c' is not allowed"), msg, c);
+			else
+				warnx(_("'%c' is not allowed"), c);
+			return -1;
+		}
+		if (iscntrl(c)) {
+			if (msg)
+				warnx(_
+				      ("%s: control characters are not allowed"),
+				      msg);
+			else
+				warnx(_("control characters are not allowed"));
+			return -1;
 		}
-		if (setupDefaultContext(_PATH_PASSWD))
-			errx(EXIT_FAILURE,
-			     _("can't set default context for %s"), _PATH_PASSWD);
-	}
-#endif
-
-#ifdef HAVE_LIBUSER
-	/* If we're setuid and not really root, disallow the password change. */
-	if (geteuid() != getuid() && uid != oldf.pw->pw_uid) {
-#else
-	if (uid != 0 && uid != oldf.pw->pw_uid) {
-#endif
-		errno = EACCES;
-		err(EXIT_FAILURE, _("running UID doesn't match UID of user we're "
-		      "altering, change denied"));
-	}
-
-	printf(_("Changing finger information for %s.\n"), oldf.username);
-
-#if !defined(HAVE_LIBUSER) && defined(CHFN_CHSH_PASSWORD)
-	if(!auth_pam("chfn", uid, oldf.username)) {
-		return EXIT_FAILURE;
-	}
-#endif
-
-	if (interactive)
-		ask_info(&oldf, &newf);
-
-	if (!set_changed_data(&oldf, &newf)) {
-		printf(_("Finger information not changed.\n"));
-		return EXIT_SUCCESS;
 	}
-
-	return save_new_data(&oldf) == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
+	return 0;
 }
 
 /*
@@ -307,19 +243,6 @@ static void parse_passwd(struct passwd *pw, struct finfo *pinfo)
 }
 
 /*
- *  ask_info () --
- *	prompt the user for the finger information and store it.
- */
-static void ask_info(struct finfo *oldfp, struct finfo *newfp)
-{
-	newfp->full_name = prompt(_("Name"), oldfp->full_name);
-	newfp->office = prompt(_("Office"), oldfp->office);
-	newfp->office_phone = prompt(_("Office Phone"), oldfp->office_phone);
-	newfp->home_phone = prompt(_("Home Phone"), oldfp->home_phone);
-	printf("\n");
-}
-
-/*
  *  prompt () --
  *	ask the user for a given field and check that the string is legal.
  */
@@ -357,42 +280,16 @@ static char *prompt(char *question, char *def_val)
 }
 
 /*
- *  check_gecos_string () --
- *	check that the given gecos string is legal.  if it's not legal,
- *	output "msg" followed by a description of the problem, and return (-1).
+ *  ask_info () --
+ *	prompt the user for the finger information and store it.
  */
-static int check_gecos_string(char *msg, char *gecos)
+static void ask_info(struct finfo *oldfp, struct finfo *newfp)
 {
-	unsigned int i, c;
-
-	if (strlen(gecos) > MAX_FIELD_SIZE) {
-		if (msg)
-			warnx(_("field %s is too long"), msg);
-		else
-			warnx(_("field is too long"));
-		return -1;
-	}
-
-	for (i = 0; i < strlen(gecos); i++) {
-		c = gecos[i];
-		if (c == ',' || c == ':' || c == '=' || c == '"' || c == '\n') {
-			if (msg)
-				warnx(_("%s: '%c' is not allowed"), msg, c);
-			else
-				warnx(_("'%c' is not allowed"), c);
-			return -1;
-		}
-		if (iscntrl(c)) {
-			if (msg)
-				warnx(_
-				      ("%s: control characters are not allowed"),
-				      msg);
-			else
-				warnx(_("control characters are not allowed"));
-			return -1;
-		}
-	}
-	return 0;
+	newfp->full_name = prompt(_("Name"), oldfp->full_name);
+	newfp->office = prompt(_("Office"), oldfp->office);
+	newfp->office_phone = prompt(_("Office Phone"), oldfp->office_phone);
+	newfp->home_phone = prompt(_("Home Phone"), oldfp->home_phone);
+	printf("\n");
 }
 
 /*
@@ -476,3 +373,98 @@ static int save_new_data(struct finfo *pinfo)
 	printf(_("Finger information changed.\n"));
 	return 0;
 }
+
+int main(int argc, char **argv)
+{
+	uid_t uid;
+	struct finfo oldf, newf;
+	int interactive;
+
+	sanitize_env();
+	setlocale(LC_ALL, "");	/* both for messages and for iscntrl() below */
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	/*
+	 *  "oldf" contains the users original finger information.
+	 *  "newf" contains the changed finger information, and contains NULL
+	 *         in fields that haven't been changed.
+	 *  in the end, "newf" is folded into "oldf".
+	 *
+	 *  the reason the new finger information is not put _immediately_
+	 *  into "oldf" is that on the command line, new finger information
+	 *  can be specified before we know what user the information is
+	 *  being specified for.
+	 */
+	uid = getuid();
+	memset(&oldf, 0, sizeof(oldf));
+	memset(&newf, 0, sizeof(newf));
+
+	interactive = parse_argv(argc, argv, &newf);
+	if (!newf.username) {
+		parse_passwd(getpwuid(uid), &oldf);
+		if (!oldf.username)
+			errx(EXIT_FAILURE, _("you (user %d) don't exist."),
+			     uid);
+	} else {
+		parse_passwd(getpwnam(newf.username), &oldf);
+		if (!oldf.username)
+			errx(EXIT_FAILURE, _("user \"%s\" does not exist."),
+			     newf.username);
+	}
+
+#ifndef HAVE_LIBUSER
+	if (!(is_local(oldf.username)))
+		errx(EXIT_FAILURE, _("can only change local entries"));
+#endif
+
+#ifdef HAVE_LIBSELINUX
+	if (is_selinux_enabled() > 0) {
+		if (uid == 0) {
+			if (checkAccess(oldf.username, PASSWD__CHFN) != 0) {
+				security_context_t user_context;
+				if (getprevcon(&user_context) < 0)
+					user_context = NULL;
+				errx(EXIT_FAILURE,
+				     _("%s is not authorized to change "
+				       "the finger info of %s"),
+				     user_context ? : _("Unknown user context"),
+				     oldf.username);
+			}
+		}
+		if (setupDefaultContext(_PATH_PASSWD))
+			errx(EXIT_FAILURE,
+			     _("can't set default context for %s"), _PATH_PASSWD);
+	}
+#endif
+
+#ifdef HAVE_LIBUSER
+	/* If we're setuid and not really root, disallow the password change. */
+	if (geteuid() != getuid() && uid != oldf.pw->pw_uid) {
+#else
+	if (uid != 0 && uid != oldf.pw->pw_uid) {
+#endif
+		errno = EACCES;
+		err(EXIT_FAILURE, _("running UID doesn't match UID of user we're "
+		      "altering, change denied"));
+	}
+
+	printf(_("Changing finger information for %s.\n"), oldf.username);
+
+#if !defined(HAVE_LIBUSER) && defined(CHFN_CHSH_PASSWORD)
+	if(!auth_pam("chfn", uid, oldf.username)) {
+		return EXIT_FAILURE;
+	}
+#endif
+
+	if (interactive)
+		ask_info(&oldf, &newf);
+
+	if (!set_changed_data(&oldf, &newf)) {
+		printf(_("Finger information not changed.\n"));
+		return EXIT_SUCCESS;
+	}
+
+	return save_new_data(&oldf) == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
+}
-- 
2.1.3

