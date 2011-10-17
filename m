Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 24/49] login: PAM auth refactoring
Date: Mon, 17 Oct 2011 13:15:03 +0200
Message-Id: <1318850128-23458-25-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |  140 ++++++++++++++++++++++++++------------------------
 1 files changed, 73 insertions(+), 67 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index 1e69afd..03335c4 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -109,7 +109,8 @@ struct login_context {
 	pid_t		pid;
 	int		quiet;		/* 1 is hush file exists */
 
-	unsigned int	remote:1;	/* login -h */
+	unsigned int	remote:1,	/* login -h */
+			noauth:1;	/* login -f */
 };
 
 /*
@@ -292,7 +293,7 @@ static int is_consoletty(int fd)
  * Must be called only with username the name of an actual user.
  * The most common login failure is to give password instead of username.
  */
-static void logbtmp(struct login_context *cxt)
+static void log_btmp(struct login_context *cxt)
 {
 	struct utmp ut;
 	struct timeval tv;
@@ -611,6 +612,69 @@ static pam_handle_t *init_loginpam(struct login_context *cxt)
 	return pamh;
 }
 
+static void loginpam_auth(struct login_context *cxt)
+{
+	int rc, failcount = 0;
+	pam_handle_t *pamh = cxt->pamh;
+
+	/* if we didn't get a user on the command line, set it to NULL */
+	loginpam_get_username(pamh, &cxt->username);
+
+	/*
+	 * There may be better ways to deal with some of these conditions, but
+	 * at least this way I don't think we'll be giving away information...
+	 *
+	 * Perhaps someday we can trust that all PAM modules will pay attention
+	 * to failure count and get rid of MAX_LOGIN_TRIES?
+	 */
+	rc = pam_authenticate(pamh, 0);
+
+	while ((failcount++ < LOGIN_MAX_TRIES) &&
+	       ((rc == PAM_AUTH_ERR) ||
+		(rc == PAM_USER_UNKNOWN) ||
+		(rc == PAM_CRED_INSUFFICIENT) ||
+		(rc == PAM_AUTHINFO_UNAVAIL))) {
+
+		loginpam_get_username(pamh, &cxt->username);
+
+		syslog(LOG_NOTICE,
+		       _("FAILED LOGIN %d FROM %s FOR %s, %s"),
+		       failcount, cxt->hostname, cxt->username,
+		       pam_strerror(pamh, rc));
+
+		log_btmp(cxt);
+		log_audit(cxt, 0);
+
+		fprintf(stderr, _("Login incorrect\n\n"));
+
+		pam_set_item(pamh, PAM_USER, NULL);
+		rc = pam_authenticate(pamh, 0);
+	}
+
+	if (is_pam_failure(rc)) {
+
+		loginpam_get_username(pamh, &cxt->username);
+
+		if (rc == PAM_MAXTRIES)
+			syslog(LOG_NOTICE,
+			       _("TOO MANY LOGIN TRIES (%d) FROM %s FOR %s, %s"),
+			       failcount, cxt->hostname, cxt->username,
+			       pam_strerror(pamh, rc));
+		else
+			syslog(LOG_NOTICE,
+			       _("FAILED LOGIN SESSION FROM %s FOR %s, %s"),
+			       cxt->hostname, cxt->username,
+			       pam_strerror(pamh, rc));
+
+		log_btmp(cxt);
+		log_audit(cxt, 0);
+
+		fprintf(stderr, _("\nLogin incorrect\n"));
+		pam_end(pamh, rc);
+		exit(EXIT_SUCCESS);
+	}
+}
+
 /*
  * We need to check effective UID/GID. For example $HOME could be on root
  * squashed NFS or on NFS with UID mapping and access(2) uses real UID/GID.
@@ -718,8 +782,7 @@ int main(int argc, char **argv)
 	extern char *optarg, **environ;
 	register int ch;
 	register char *p;
-	int fflag, pflag, cnt;
-	int passwd_req;
+	int pflag, cnt;
 	char *domain;
 	char tbuf[PATH_MAX + 2];
 	char *termenv;
@@ -760,13 +823,12 @@ int main(int argc, char **argv)
 	gethostname(tbuf, sizeof(tbuf));
 	domain = strchr(tbuf, '.');
 
-	fflag = pflag = 0;
-	passwd_req = 1;
+	pflag = 0;
 
 	while ((ch = getopt(argc, argv, "fh:p")) != -1)
 		switch (ch) {
 		case 'f':
-			fflag = 1;
+			cxt.noauth = 1;
 			break;
 
 		case 'h':
@@ -844,67 +906,11 @@ int main(int argc, char **argv)
 
 	pamh = init_loginpam(&cxt);
 
-	/* if fflag == 1, then the user has already been authenticated */
-	if (fflag && (getuid() == 0))
-		passwd_req = 0;
-	else
-		passwd_req = 1;
-
-	if (passwd_req == 1) {
-		int failcount = 0;
-
-		/* if we didn't get a user on the command line, set it to NULL */
-		loginpam_get_username(pamh, &cxt.username);
+	/* login -f, then the user has already been authenticated */
+	cxt.noauth = cxt.noauth && getuid() == 0 ? 1 : 0;
 
-		/* there may be better ways to deal with some of these
-		   conditions, but at least this way I don't think we'll
-		   be giving away information... */
-		/* Perhaps someday we can trust that all PAM modules will
-		   pay attention to failure count and get rid of MAX_LOGIN_TRIES? */
-
-		retcode = pam_authenticate(pamh, 0);
-		while ((failcount++ < LOGIN_MAX_TRIES) &&
-		       ((retcode == PAM_AUTH_ERR) ||
-			(retcode == PAM_USER_UNKNOWN) ||
-			(retcode == PAM_CRED_INSUFFICIENT) ||
-			(retcode == PAM_AUTHINFO_UNAVAIL))) {
-			loginpam_get_username(pamh, &cxt.username);
-
-			syslog(LOG_NOTICE,
-			       _("FAILED LOGIN %d FROM %s FOR %s, %s"),
-			       failcount, cxt.hostname, cxt.username, pam_strerror(pamh,
-									   retcode));
-			logbtmp(&cxt);
-			log_audit(&cxt, 0);
-
-			fprintf(stderr, _("Login incorrect\n\n"));
-			pam_set_item(pamh, PAM_USER, NULL);
-			retcode = pam_authenticate(pamh, 0);
-		}
-
-		if (is_pam_failure(retcode)) {
-			loginpam_get_username(pamh, &cxt.username);
-
-			if (retcode == PAM_MAXTRIES)
-				syslog(LOG_NOTICE,
-				       _
-				       ("TOO MANY LOGIN TRIES (%d) FROM %s FOR "
-					"%s, %s"), failcount, cxt.hostname,
-				       cxt.username, pam_strerror(pamh, retcode));
-			else
-				syslog(LOG_NOTICE,
-				       _
-				       ("FAILED LOGIN SESSION FROM %s FOR %s, %s"),
-				       cxt.hostname, cxt.username, pam_strerror(pamh,
-									retcode));
-			logbtmp(&cxt);
-			log_audit(&cxt, 0);
-
-			fprintf(stderr, _("\nLogin incorrect\n"));
-			pam_end(pamh, retcode);
-			exit(EXIT_SUCCESS);
-		}
-	}
+	if (!cxt.noauth)
+		loginpam_auth(&cxt);
 
 	/*
 	 * Authentication may be skipped (for example, during krlogin, rlogin, etc...),
-- 
1.7.6.4
