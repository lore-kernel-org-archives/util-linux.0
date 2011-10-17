Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 14/49] login: add username to login_context struct
Date: Mon, 17 Oct 2011 13:14:53 +0200
Message-Id: <1318850128-23458-15-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |   59 +++++++++++++++++++++++++--------------------------
 1 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index 9299e5c..a794d18 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -91,6 +91,8 @@ struct login_context {
 	const char	*tty_name;	/* tty_path without /dev prefix */
 	const char	*tty_number;	/* end of the tty_path */
 
+	char		*username;	/* from command line or PAM */
+
 #ifdef LOGIN_CHOWN_VCS
 	char		vcsn[VCS_PATH_MAX];	/* virtual console name */
 	char		vcsan[VCS_PATH_MAX];
@@ -111,7 +113,6 @@ int timeout = LOGIN_TIMEOUT;
 struct passwd *pwd;
 
 static struct passwd pwdcopy;
-static char *username;
 
 static void timedout(int);
 static void sigint(int);
@@ -251,14 +252,15 @@ static int is_consoletty(int fd)
  * The most common login failure is to give password instead of username.
  */
 static void
-logbtmp(struct login_context *cxt, const char *username)
+logbtmp(struct login_context *cxt)
 {
 	struct utmp ut;
 	struct timeval tv;
 
 	memset(&ut, 0, sizeof(ut));
 
-	strncpy(ut.ut_user, username ? username : "(unknown)",
+	strncpy(ut.ut_user,
+		cxt->username ? cxt->username : "(unknown)",
 		sizeof(ut.ut_user));
 
 	if (cxt->tty_number)
@@ -419,7 +421,6 @@ int main(int argc, char **argv)
 	gethostname(tbuf, sizeof(tbuf));
 	domain = strchr(tbuf, '.');
 
-	username = NULL;
 	fflag = hflag = pflag = 0;
 	passwd_req = 1;
 
@@ -485,7 +486,7 @@ int main(int argc, char **argv)
 
 	if (*argv) {
 		char *p = *argv;
-		username = strdup(p);
+		cxt.username = strdup(p);
 
 		/* wipe name - some people mistype their password here */
 		/* (of course we are too late, but perhaps this helps a little ..) */
@@ -508,7 +509,7 @@ int main(int argc, char **argv)
 	 * Therefore, we are safe not setting it to anything
 	 */
 
-	retcode = pam_start(hflag ? "remote" : "login", username, &conv, &pamh);
+	retcode = pam_start(hflag ? "remote" : "login", cxt.username, &conv, &pamh);
 	if (retcode != PAM_SUCCESS) {
 		warnx(_("PAM failure, aborting: %s"),
 		      pam_strerror(pamh, retcode));
@@ -538,11 +539,9 @@ int main(int argc, char **argv)
 	if (is_pam_failure(retcode))
 		loginpam_err(pamh, retcode);
 
-	if (username) {
-		/* we need't the original username. We have to follow PAM. */
-		free(username);
-		username = NULL;
-	}
+	/* we need't the original username. We have to follow PAM. */
+	free(cxt.username);
+	cxt.username = NULL;
 
 	/* if fflag == 1, then the user has already been authenticated */
 	if (fflag && (getuid() == 0))
@@ -554,7 +553,7 @@ int main(int argc, char **argv)
 		int failcount = 0;
 
 		/* if we didn't get a user on the command line, set it to NULL */
-		loginpam_get_username(pamh, &username);
+		loginpam_get_username(pamh, &cxt.username);
 
 		/* there may be better ways to deal with some of these
 		   conditions, but at least this way I don't think we'll
@@ -568,14 +567,14 @@ int main(int argc, char **argv)
 			(retcode == PAM_USER_UNKNOWN) ||
 			(retcode == PAM_CRED_INSUFFICIENT) ||
 			(retcode == PAM_AUTHINFO_UNAVAIL))) {
-			loginpam_get_username(pamh, &username);
+			loginpam_get_username(pamh, &cxt.username);
 
 			syslog(LOG_NOTICE,
 			       _("FAILED LOGIN %d FROM %s FOR %s, %s"),
-			       failcount, cxt.hostname, username, pam_strerror(pamh,
+			       failcount, cxt.hostname, cxt.username, pam_strerror(pamh,
 									   retcode));
-			logbtmp(&cxt, username);
-			logaudit(cxt.tty_name, username, cxt.hostname, NULL, 0);
+			logbtmp(&cxt);
+			logaudit(cxt.tty_name, cxt.username, cxt.hostname, NULL, 0);
 
 			fprintf(stderr, _("Login incorrect\n\n"));
 			pam_set_item(pamh, PAM_USER, NULL);
@@ -583,22 +582,22 @@ int main(int argc, char **argv)
 		}
 
 		if (is_pam_failure(retcode)) {
-			loginpam_get_username(pamh, &username);
+			loginpam_get_username(pamh, &cxt.username);
 
 			if (retcode == PAM_MAXTRIES)
 				syslog(LOG_NOTICE,
 				       _
 				       ("TOO MANY LOGIN TRIES (%d) FROM %s FOR "
 					"%s, %s"), failcount, cxt.hostname,
-				       username, pam_strerror(pamh, retcode));
+				       cxt.username, pam_strerror(pamh, retcode));
 			else
 				syslog(LOG_NOTICE,
 				       _
 				       ("FAILED LOGIN SESSION FROM %s FOR %s, %s"),
-				       cxt.hostname, username, pam_strerror(pamh,
+				       cxt.hostname, cxt.username, pam_strerror(pamh,
 									retcode));
-			logbtmp(&cxt, username);
-			logaudit(cxt.tty_name, username, cxt.hostname, NULL, 0);
+			logbtmp(&cxt);
+			logaudit(cxt.tty_name, cxt.username, cxt.hostname, NULL, 0);
 
 			fprintf(stderr, _("\nLogin incorrect\n"));
 			pam_end(pamh, retcode);
@@ -623,21 +622,21 @@ int main(int argc, char **argv)
 	 * Grab the user information out of the password file for future usage
 	 * First get the username that we are actually using, though.
 	 */
-	retcode = loginpam_get_username(pamh, &username);
+	retcode = loginpam_get_username(pamh, &cxt.username);
 	if (is_pam_failure(retcode))
 		loginpam_err(pamh, retcode);
 
-	if (!username || !*username) {
+	if (!cxt.username || !*cxt.username) {
 		warnx(_("\nSession setup problem, abort."));
 		syslog(LOG_ERR, _("NULL user name in %s:%d. Abort."),
 		       __FUNCTION__, __LINE__);
 		pam_end(pamh, PAM_SYSTEM_ERR);
 		exit(EXIT_FAILURE);
 	}
-	if (!(pwd = getpwnam(username))) {
+	if (!(pwd = getpwnam(cxt.username))) {
 		warnx(_("\nSession setup problem, abort."));
 		syslog(LOG_ERR, _("Invalid user name \"%s\" in %s:%d. Abort."),
-		       username, __FUNCTION__, __LINE__);
+		       cxt.username, __FUNCTION__, __LINE__);
 		pam_end(pamh, PAM_SYSTEM_ERR);
 		exit(EXIT_FAILURE);
 	}
@@ -660,14 +659,14 @@ int main(int argc, char **argv)
 		pam_end(pamh, PAM_SYSTEM_ERR);
 		exit(EXIT_FAILURE);
 	}
-	username = pwd->pw_name;
+	cxt.username = pwd->pw_name;
 
 	/*
 	 * Initialize the supplementary group list.
 	 * This should be done before pam_setcred because
 	 * the PAM modules might add groups during pam_setcred.
 	 */
-	if (initgroups(username, pwd->pw_gid) < 0) {
+	if (initgroups(cxt.username, pwd->pw_gid) < 0) {
 		syslog(LOG_ERR, "initgroups: %m");
 		warnx(_("\nSession setup problem, abort."));
 		pam_end(pamh, PAM_SYSTEM_ERR);
@@ -762,7 +761,7 @@ int main(int argc, char **argv)
 		if (ut.ut_id[0] == 0)
 			strncpy(ut.ut_id, cxt.tty_number, sizeof(ut.ut_id));
 
-		strncpy(ut.ut_user, username, sizeof(ut.ut_user));
+		strncpy(ut.ut_user, cxt.username, sizeof(ut.ut_user));
 		xstrncpy(ut.ut_line, cxt.tty_name, sizeof(ut.ut_line));
 #ifdef _HAVE_UT_TV		/* in <utmpbits.h> included by <utmp.h> */
 		gettimeofday(&tv, NULL);
@@ -812,7 +811,7 @@ int main(int argc, char **argv)
 #endif
 	}
 
-	logaudit(cxt.tty_name, username, cxt.hostname, pwd, 1);
+	logaudit(cxt.tty_name, cxt.username, cxt.hostname, pwd, 1);
 	dolastlog(&cxt, quietlog);
 
 	if (fchown(0, pwd->pw_uid,
@@ -894,7 +893,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	setproctitle("login", username);
+	setproctitle("login", cxt.username);
 
 	if (!strncmp(cxt.tty_name, "ttyS", 4))
 		syslog(LOG_INFO, _("DIALUP AT %s BY %s"), cxt.tty_name,
-- 
1.7.6.4
