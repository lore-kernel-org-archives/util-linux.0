Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f54.google.com ([74.125.82.54]:58369 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbaLNRpw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Dec 2014 12:45:52 -0500
Received: by mail-wg0-f54.google.com with SMTP id l2so12932147wgh.27
        for <util-linux@vger.kernel.org>; Sun, 14 Dec 2014 09:45:51 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 15/16] chfn: move new and old finger structs to chfn control struct
Date: Sun, 14 Dec 2014 17:44:11 +0000
Message-Id: <1418579052-29386-16-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This change is a little bit messy, and requires a comment the struct
finfo should not have 'struct passwd *pw' as it's member.  The earlier
struct design would have been burden to maintain, and confusing to use.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chfn.c | 165 ++++++++++++++++++++++++-----------------------------
 1 file changed, 76 insertions(+), 89 deletions(-)

diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index 0d37a32..2a06fec 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -55,8 +55,6 @@
 #endif
 
 struct finfo {
-	struct passwd *pw;
-	char *username;
 	char *full_name;
 	char *office;
 	char *office_phone;
@@ -65,6 +63,13 @@ struct finfo {
 };
 
 struct chfn_control {
+	struct passwd *pw;
+	char *username;
+	/*  "oldf"  Contains the users original finger information.
+	 *  "newf"  Contains the changed finger information, and contains
+	 *          NULL in fields that haven't been changed.
+	 *  In the end, "newf" is folded into "oldf".  */
+	struct finfo oldf, newf;
 	unsigned int
 		interactive:1;		/* whether to prompt for fields or not */
 };
@@ -121,8 +126,7 @@ static int check_gecos_string(const char *msg, char *gecos)
  *	parse the command line arguments.
  *	returns true if no information beyond the username was given.
  */
-static void parse_argv(struct chfn_control *ctl, int argc, char *argv[],
-		       struct finfo *pinfo)
+static void parse_argv(struct chfn_control *ctl, int argc, char **argv)
 {
 	int index, c, status = 0;
 	const struct option long_options[] = {
@@ -139,19 +143,19 @@ static void parse_argv(struct chfn_control *ctl, int argc, char *argv[],
 				&index)) != -1) {
 		switch (c) {
 		case 'f':
-			pinfo->full_name = optarg;
+			ctl->newf.full_name = optarg;
 			status += check_gecos_string(_("Name"), optarg);
 			break;
 		case 'o':
-			pinfo->office = optarg;
+			ctl->newf.office = optarg;
 			status += check_gecos_string(_("Office"), optarg);
 			break;
 		case 'p':
-			pinfo->office_phone = optarg;
+			ctl->newf.office_phone = optarg;
 			status += check_gecos_string(_("Office Phone"), optarg);
 			break;
 		case 'h':
-			pinfo->home_phone = optarg;
+			ctl->newf.home_phone = optarg;
 			status += check_gecos_string(_("Home Phone"), optarg);
 			break;
 		case 'v':
@@ -170,7 +174,7 @@ static void parse_argv(struct chfn_control *ctl, int argc, char *argv[],
 	if (optind < argc) {
 		if (optind + 1 < argc)
 			usage(stderr);
-		pinfo->username = argv[optind];
+		ctl->username = argv[optind];
 	}
 	return;
 }
@@ -179,24 +183,22 @@ static void parse_argv(struct chfn_control *ctl, int argc, char *argv[],
  *  parse_passwd () --
  *	take a struct password and fill in the fields of the struct finfo.
  */
-static void parse_passwd(struct passwd *pw, struct finfo *pinfo)
+static void parse_passwd(struct chfn_control *ctl)
 {
 	char *gecos;
 
-	if (!pw)
+	if (!ctl->pw)
 		return;
-	pinfo->pw = pw;
-	pinfo->username = pw->pw_name;
 	/* use pw_gecos - we take a copy since PAM destroys the original */
-	gecos = xstrdup(pw->pw_gecos);
+	gecos = xstrdup(ctl->pw->pw_gecos);
 	/* extract known fields */
-	pinfo->full_name = strsep(&gecos, ",");
-	pinfo->office = strsep(&gecos, ",");
-	pinfo->office_phone = strsep(&gecos, ",");
-	pinfo->home_phone = strsep(&gecos, ",");
+	ctl->oldf.full_name = strsep(&gecos, ",");
+	ctl->oldf.office = strsep(&gecos, ",");
+	ctl->oldf.office_phone = strsep(&gecos, ",");
+	ctl->oldf.home_phone = strsep(&gecos, ",");
 	/*  extra fields contain site-specific information, and can
 	 *  not be changed by this version of chfn.  */
-	pinfo->other = strsep(&gecos, ",");
+	ctl->oldf.other = strsep(&gecos, ",");
 }
 
 /*
@@ -234,12 +236,12 @@ static char *prompt(const char *question, char *def_val)
  *  ask_info () --
  *	prompt the user for the finger information and store it.
  */
-static void ask_info(struct finfo *oldfp, struct finfo *newfp)
+static void ask_info(struct chfn_control *ctl)
 {
-	newfp->full_name = prompt(_("Name"), oldfp->full_name);
-	newfp->office = prompt(_("Office"), oldfp->office);
-	newfp->office_phone = prompt(_("Office Phone"), oldfp->office_phone);
-	newfp->home_phone = prompt(_("Home Phone"), oldfp->home_phone);
+	ctl->newf.full_name = prompt(_("Name"), ctl->oldf.full_name);
+	ctl->newf.office = prompt(_("Office"), ctl->oldf.office);
+	ctl->newf.office_phone = prompt(_("Office Phone"), ctl->oldf.office_phone);
+	ctl->newf.home_phone = prompt(_("Home Phone"), ctl->oldf.home_phone);
 	printf("\n");
 }
 
@@ -247,27 +249,26 @@ static void ask_info(struct finfo *oldfp, struct finfo *newfp)
  *  set_changed_data () --
  *	incorporate the new data into the old finger info.
  */
-static int set_changed_data(struct finfo *oldfp, struct finfo *newfp)
+static int set_changed_data(struct chfn_control *ctl)
 {
 	int changed = false;
 
-	if (newfp->full_name) {
-		oldfp->full_name = newfp->full_name;
+	if (ctl->newf.full_name)
 		changed = true;
-	}
-	if (newfp->office) {
-		oldfp->office = newfp->office;
+	else
+		ctl->newf.full_name = ctl->oldf.full_name;
+	if (ctl->newf.office)
 		changed = true;
-	}
-	if (newfp->office_phone) {
-		oldfp->office_phone = newfp->office_phone;
+	else
+		ctl->newf.office = ctl->oldf.office;
+	if (ctl->newf.office_phone)
 		changed = true;
-	}
-	if (newfp->home_phone) {
-		oldfp->home_phone = newfp->home_phone;
+	else
+		ctl->newf.office_phone = ctl->oldf.office_phone;
+	if (ctl->newf.home_phone)
 		changed = true;
-	}
-
+	else
+		ctl->newf.home_phone = ctl->oldf.home_phone;
 	return changed;
 }
 
@@ -276,41 +277,41 @@ static int set_changed_data(struct finfo *oldfp, struct finfo *newfp)
  *	save the given finger info in /etc/passwd.
  *	return zero on success.
  */
-static int save_new_data(struct finfo *pinfo)
+static int save_new_data(struct chfn_control *ctl)
 {
 	char *gecos;
 	int len;
 
 	/* null fields will confuse printf(). */
-	if (!pinfo->full_name)
-		pinfo->full_name = "";
-	if (!pinfo->office)
-		pinfo->office = "";
-	if (!pinfo->office_phone)
-		pinfo->office_phone = "";
-	if (!pinfo->home_phone)
-		pinfo->home_phone = "";
-	if (!pinfo->other)
-		pinfo->other = "";
+	if (!ctl->newf.full_name)
+		ctl->newf.full_name = "";
+	if (!ctl->newf.office)
+		ctl->newf.office = "";
+	if (!ctl->newf.office_phone)
+		ctl->newf.office_phone = "";
+	if (!ctl->newf.home_phone)
+		ctl->newf.home_phone = "";
+	if (!ctl->newf.other)
+		ctl->newf.other = "";
 
 	/* create the new gecos string */
-	len = xasprintf(&gecos, "%s,%s,%s,%s,%s", pinfo->full_name, pinfo->office,
-		  pinfo->office_phone, pinfo->home_phone, pinfo->other);
+	len = xasprintf(&gecos, "%s,%s,%s,%s,%s", ctl->newf.full_name, ctl->newf.office,
+		  ctl->newf.office_phone, ctl->newf.home_phone, ctl->newf.other);
 
-	/* remove trailing empty fields (but not subfields of pinfo->other) */
-	if (!pinfo->other[0]) {
+	/* remove trailing empty fields (but not subfields of ctl->newf.other) */
+	if (!ctl->newf.other[0]) {
 		while (len > 0 && gecos[len - 1] == ',')
 			len--;
 		gecos[len] = 0;
 	}
 
 #ifdef HAVE_LIBUSER
-	if (set_value_libuser("chfn", pinfo->pw->pw_name, pinfo->pw->pw_uid,
+	if (set_value_libuser("chfn", ctl->username, ctl->pw->pw_uid,
 			LU_GECOS, gecos) < 0) {
 #else /* HAVE_LIBUSER */
 	/* write the new struct passwd to the passwd file. */
-	pinfo->pw->pw_gecos = gecos;
-	if (setpwnam(pinfo->pw) < 0) {
+	ctl->pw->pw_gecos = gecos;
+	if (setpwnam(ctl->pw) < 0) {
 		warn("setpwnam failed");
 #endif
 		printf(_
@@ -325,7 +326,6 @@ static int save_new_data(struct finfo *pinfo)
 int main(int argc, char **argv)
 {
 	uid_t uid;
-	struct finfo oldf, newf;
 	struct chfn_control ctl = {
 		.interactive = 1
 	};
@@ -335,44 +335,31 @@ int main(int argc, char **argv)
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 	atexit(close_stdout);
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
 	uid = getuid();
-	memset(&oldf, 0, sizeof(oldf));
-	memset(&newf, 0, sizeof(newf));
 
-	parse_argv(&ctl, argc, argv, &newf);
-	if (!newf.username) {
-		parse_passwd(getpwuid(uid), &oldf);
-		if (!oldf.username)
+	parse_argv(&ctl, argc, argv);
+	if (!ctl.username) {
+		ctl.pw = getpwuid(uid);
+		if (!ctl.pw)
 			errx(EXIT_FAILURE, _("you (user %d) don't exist."),
 			     uid);
+		ctl.username = ctl.pw->pw_name;
 	} else {
-		parse_passwd(getpwnam(newf.username), &oldf);
-		if (!oldf.username)
+		ctl.pw = getpwnam(ctl.username);
+		if (!ctl.pw)
 			errx(EXIT_FAILURE, _("user \"%s\" does not exist."),
-			     newf.username);
+			     ctl.username);
 	}
-
+	parse_passwd(&ctl);
 #ifndef HAVE_LIBUSER
-	if (!(is_local(oldf.username)))
+	if (!(is_local(ctl.username)))
 		errx(EXIT_FAILURE, _("can only change local entries"));
 #endif
 
 #ifdef HAVE_LIBSELINUX
 	if (is_selinux_enabled() > 0) {
 		if (uid == 0) {
-			if (checkAccess(oldf.username, PASSWD__CHFN) != 0) {
+			if (checkAccess(ctl.username, PASSWD__CHFN) != 0) {
 				security_context_t user_context;
 				if (getprevcon(&user_context) < 0)
 					user_context = NULL;
@@ -380,7 +367,7 @@ int main(int argc, char **argv)
 				     _("%s is not authorized to change "
 				       "the finger info of %s"),
 				     user_context ? : _("Unknown user context"),
-				     oldf.username);
+				     ctl.username);
 			}
 		}
 		if (setupDefaultContext(_PATH_PASSWD))
@@ -391,30 +378,30 @@ int main(int argc, char **argv)
 
 #ifdef HAVE_LIBUSER
 	/* If we're setuid and not really root, disallow the password change. */
-	if (geteuid() != getuid() && uid != oldf.pw->pw_uid) {
+	if (geteuid() != getuid() && uid != ctl.pw->pw_uid) {
 #else
-	if (uid != 0 && uid != oldf.pw->pw_uid) {
+	if (uid != 0 && uid != ctl.oldf.pw->pw_uid) {
 #endif
 		errno = EACCES;
 		err(EXIT_FAILURE, _("running UID doesn't match UID of user we're "
 		      "altering, change denied"));
 	}
 
-	printf(_("Changing finger information for %s.\n"), oldf.username);
+	printf(_("Changing finger information for %s.\n"), ctl.username);
 
 #if !defined(HAVE_LIBUSER) && defined(CHFN_CHSH_PASSWORD)
-	if(!auth_pam("chfn", uid, oldf.username)) {
+	if (!auth_pam("chfn", uid, ctl.username)) {
 		return EXIT_FAILURE;
 	}
 #endif
 
 	if (ctl.interactive)
-		ask_info(&oldf, &newf);
+		ask_info(&ctl);
 
-	if (!set_changed_data(&oldf, &newf)) {
+	if (!set_changed_data(&ctl)) {
 		printf(_("Finger information not changed.\n"));
 		return EXIT_SUCCESS;
 	}
 
-	return save_new_data(&oldf) == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
+	return save_new_data(&ctl) == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
 }
-- 
2.1.3

