Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 23/49] login: PAM initialization refactoring
Date: Mon, 17 Oct 2011 13:15:02 +0200
Message-Id: <1318850128-23458-24-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |  106 +++++++++++++++++++++++++++++----------------------
 1 files changed, 60 insertions(+), 46 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index fa28c1b..1e69afd 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -95,6 +95,9 @@ struct login_context {
 
 	struct passwd	*pwd;		/* user info */
 
+	pam_handle_t	*pamh;		/* PAM handler */
+	struct pam_conv	conv;		/* PAM conversation */
+
 #ifdef LOGIN_CHOWN_VCS
 	char		vcsn[VCS_PATH_MAX];	/* virtual console name */
 	char		vcsan[VCS_PATH_MAX];
@@ -105,6 +108,8 @@ struct login_context {
 
 	pid_t		pid;
 	int		quiet;		/* 1 is hush file exists */
+
+	unsigned int	remote:1;	/* login -h */
 };
 
 /*
@@ -538,7 +543,7 @@ static struct passwd *get_passwd_entry(const char *username,
 }
 
 /* encapsulate stupid "void **" pam_get_item() API */
-static int loginpam_get_username(pam_handle_t * pamh, char **name)
+static int loginpam_get_username(pam_handle_t *pamh, char **name)
 {
 	const void *item = (void *)*name;
 	int rc;
@@ -547,7 +552,7 @@ static int loginpam_get_username(pam_handle_t * pamh, char **name)
 	return rc;
 }
 
-static int loginpam_err(pam_handle_t * pamh, int retcode)
+static int loginpam_err(pam_handle_t *pamh, int retcode)
 {
 	const char *msg = pam_strerror(pamh, retcode);
 
@@ -560,6 +565,52 @@ static int loginpam_err(pam_handle_t * pamh, int retcode)
 
 }
 
+static pam_handle_t *init_loginpam(struct login_context *cxt)
+{
+	pam_handle_t *pamh = NULL;
+	int rc;
+
+	/*
+	 * username is initialized to NULL and if specified on the command line
+	 * it is set.  Therefore, we are safe not setting it to anything
+	 */
+	rc = pam_start(cxt->remote ? "remote" : "login",
+		       cxt->username, &cxt->conv, &pamh);
+	if (rc != PAM_SUCCESS) {
+		warnx(_("PAM failure, aborting: %s"), pam_strerror(pamh, rc));
+		syslog(LOG_ERR, _("Couldn't initialize PAM: %s"),
+		       pam_strerror(pamh, rc));
+		exit(EXIT_FAILURE);
+	}
+
+	/* hostname & tty are either set to NULL or their correct values,
+	 * depending on how much we know
+	 */
+	rc = pam_set_item(pamh, PAM_RHOST, cxt->hostname);
+	if (is_pam_failure(rc))
+		loginpam_err(pamh, rc);
+
+	rc = pam_set_item(pamh, PAM_TTY, cxt->tty_name);
+	if (is_pam_failure(rc))
+		loginpam_err(pamh, rc);
+
+	/*
+	 * Andrew.Taylor@cal.montage.ca: Provide a user prompt to PAM so that
+	 * the "login: " prompt gets localized. Unfortunately, PAM doesn't have
+	 * an interface to specify the "Password: " string (yet).
+	 */
+	rc = pam_set_item(pamh, PAM_USER_PROMPT, _("login: "));
+	if (is_pam_failure(rc))
+		loginpam_err(pamh, rc);
+
+	/* we need't the original username. We have to follow PAM. */
+	free(cxt->username);
+	cxt->username = NULL;
+	cxt->pamh = pamh;
+
+	return pamh;
+}
+
 /*
  * We need to check effective UID/GID. For example $HOME could be on root
  * squashed NFS or on NFS with UID mapping and access(2) uses real UID/GID.
@@ -667,7 +718,7 @@ int main(int argc, char **argv)
 	extern char *optarg, **environ;
 	register int ch;
 	register char *p;
-	int fflag, hflag, pflag, cnt;
+	int fflag, pflag, cnt;
 	int passwd_req;
 	char *domain;
 	char tbuf[PATH_MAX + 2];
@@ -676,15 +727,15 @@ int main(int argc, char **argv)
 	char *buff;
 	int childArgc = 0;
 	int retcode;
-	pam_handle_t *pamh = NULL;
-	struct pam_conv conv = { misc_conv, NULL };
 	struct sigaction sa, oldsa_hup, oldsa_term;
 
 	char *pwdbuf = NULL;
 	struct passwd *pwd = NULL, _pwd;
+	pam_handle_t *pamh;
 
 	struct login_context cxt = {
-		.pid = getpid()
+		.pid = getpid(),		/* PID */
+		.conv = { misc_conv, NULL }	/* PAM conversation function */
 	};
 
 	signal(SIGALRM, timedout);
@@ -709,7 +760,7 @@ int main(int argc, char **argv)
 	gethostname(tbuf, sizeof(tbuf));
 	domain = strchr(tbuf, '.');
 
-	fflag = hflag = pflag = 0;
+	fflag = pflag = 0;
 	passwd_req = 1;
 
 	while ((ch = getopt(argc, argv, "fh:p")) != -1)
@@ -724,7 +775,7 @@ int main(int argc, char **argv)
 					_("login: -h for super-user only.\n"));
 				exit(EXIT_FAILURE);
 			}
-			hflag = 1;
+			cxt.remote = 1;
 			if (domain && (p = strchr(optarg, '.')) &&
 			    strcasecmp(p, domain) == 0)
 				*p = 0;
@@ -791,44 +842,7 @@ int main(int argc, char **argv)
 
 	init_tty(&cxt);
 
-	/*
-	 * username is initialized to NULL
-	 * and if specified on the command line it is set.
-	 * Therefore, we are safe not setting it to anything
-	 */
-	retcode = pam_start(hflag ? "remote" : "login", cxt.username, &conv, &pamh);
-	if (retcode != PAM_SUCCESS) {
-		warnx(_("PAM failure, aborting: %s"),
-		      pam_strerror(pamh, retcode));
-		syslog(LOG_ERR, _("Couldn't initialize PAM: %s"),
-		       pam_strerror(pamh, retcode));
-		exit(EXIT_FAILURE);
-	}
-
-	/* hostname & tty are either set to NULL or their correct values,
-	 * depending on how much we know
-	 */
-	retcode = pam_set_item(pamh, PAM_RHOST, cxt.hostname);
-	if (is_pam_failure(retcode))
-		loginpam_err(pamh, retcode);
-
-	retcode = pam_set_item(pamh, PAM_TTY, cxt.tty_name);
-	if (is_pam_failure(retcode))
-		loginpam_err(pamh, retcode);
-
-	/*
-	 * Andrew.Taylor@cal.montage.ca: Provide a user prompt to PAM
-	 * so that the "login: " prompt gets localized. Unfortunately,
-	 * PAM doesn't have an interface to specify the "Password: " string
-	 * (yet).
-	 */
-	retcode = pam_set_item(pamh, PAM_USER_PROMPT, _("login: "));
-	if (is_pam_failure(retcode))
-		loginpam_err(pamh, retcode);
-
-	/* we need't the original username. We have to follow PAM. */
-	free(cxt.username);
-	cxt.username = NULL;
+	pamh = init_loginpam(&cxt);
 
 	/* if fflag == 1, then the user has already been authenticated */
 	if (fflag && (getuid() == 0))
-- 
1.7.6.4
