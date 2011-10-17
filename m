Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 18/49] login: use getpwnam_r() rather than manually copy passwd struct
Date: Mon, 17 Oct 2011 13:14:57 +0200
Message-Id: <1318850128-23458-19-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |   80 ++++++++++++++++++++++++++++++++------------------
 1 files changed, 51 insertions(+), 29 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index c4f3d9c..8b724ec 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -94,6 +94,8 @@ struct login_context {
 
 	char		*username;	/* from command line or PAM */
 
+	struct passwd	*pwd;		/* user info */
+
 #ifdef LOGIN_CHOWN_VCS
 	char		vcsn[VCS_PATH_MAX];	/* virtual console name */
 	char		vcsan[VCS_PATH_MAX];
@@ -112,10 +114,6 @@ struct login_context {
  */
 int timeout = LOGIN_TIMEOUT;
 
-struct passwd *pwd;
-
-static struct passwd pwdcopy;
-
 static void timedout(int);
 static void sigint(int);
 static void motd(void);
@@ -315,9 +313,10 @@ static void sig_handler(int signal)
 }
 
 #ifdef HAVE_LIBAUDIT
-static void log_audit(struct login_context *cxt, struct passwd *pwd, int status)
+static void log_audit(struct login_context *cxt, int status)
 {
 	int audit_fd;
+	struct passwd *pwd = cxt->pwd;
 
 	audit_fd = audit_open();
 	if (audit_fd == -1)
@@ -348,11 +347,14 @@ static void log_lastlog(struct login_context *cxt)
 	time_t t;
 	int fd;
 
+	if (!cxt->pwd)
+		return;
+
 	fd = open(_PATH_LASTLOG, O_RDWR, 0);
 	if (fd < 0)
 		return;
 
-	lseek(fd, (off_t) pwd->pw_uid * sizeof(ll), SEEK_SET);
+	lseek(fd, (off_t) cxt->pwd->pw_uid * sizeof(ll), SEEK_SET);
 
 	/*
 	 * Print last log message
@@ -370,7 +372,7 @@ static void log_lastlog(struct login_context *cxt)
 				printf(_("on %.*s\n"),
 				       (int)sizeof(ll.ll_line), ll.ll_line);
 		}
-		lseek(fd, (off_t) pwd->pw_uid * sizeof(ll), SEEK_SET);
+		lseek(fd, (off_t) cxt->pwd->pw_uid * sizeof(ll), SEEK_SET);
 	}
 
 	memset((char *)&ll, 0, sizeof(ll));
@@ -464,6 +466,40 @@ static void log_utmp(struct login_context *cxt)
 	updwtmp(_PATH_WTMP, &ut);
 }
 
+static struct passwd *get_passwd_entry(const char *username,
+					 char **pwdbuf,
+					 struct passwd *pwd)
+{
+	struct passwd *res = NULL;
+	size_t sz;
+	char *tmp;
+	int x;
+
+	if (!pwdbuf || !username)
+		return NULL;
+
+#ifdef _SC_GETPW_R_SIZE_MAX
+	sz = sysconf(_SC_GETPW_R_SIZE_MAX);
+	if (sz <= 0)
+#endif
+		sz = 16384;
+
+	tmp = realloc(*pwdbuf, sz);
+	if (!tmp) {
+		free(*pwdbuf);
+		*pwdbuf = NULL;
+		return NULL;
+	}
+	*pwdbuf = tmp;
+
+	x = getpwnam_r(username, pwd, *pwdbuf, sz, &res);
+	if (!res) {
+		errno = x;
+		return NULL;
+	}
+	return res;
+}
+
 /* encapsulate stupid "void **" pam_get_item() API */
 static int loginpam_get_username(pam_handle_t * pamh, char **name)
 {
@@ -521,6 +557,9 @@ int main(int argc, char **argv)
 	struct pam_conv conv = { misc_conv, NULL };
 	struct sigaction sa, oldsa_hup, oldsa_term;
 
+	char *pwdbuf = NULL;
+	struct passwd *pwd = NULL, _pwd;
+
 	struct login_context cxt = {
 		.pid = getpid()
 	};
@@ -700,7 +739,7 @@ int main(int argc, char **argv)
 			       failcount, cxt.hostname, cxt.username, pam_strerror(pamh,
 									   retcode));
 			logbtmp(&cxt);
-			log_audit(&cxt, NULL, 0);
+			log_audit(&cxt, 0);
 
 			fprintf(stderr, _("Login incorrect\n\n"));
 			pam_set_item(pamh, PAM_USER, NULL);
@@ -723,7 +762,7 @@ int main(int argc, char **argv)
 				       cxt.hostname, cxt.username, pam_strerror(pamh,
 									retcode));
 			logbtmp(&cxt);
-			log_audit(&cxt, NULL, 0);
+			log_audit(&cxt, 0);
 
 			fprintf(stderr, _("\nLogin incorrect\n"));
 			pam_end(pamh, retcode);
@@ -759,7 +798,7 @@ int main(int argc, char **argv)
 		pam_end(pamh, PAM_SYSTEM_ERR);
 		exit(EXIT_FAILURE);
 	}
-	if (!(pwd = getpwnam(cxt.username))) {
+	if (!(cxt.pwd = get_passwd_entry(cxt.username, &pwdbuf, &_pwd))) {
 		warnx(_("\nSession setup problem, abort."));
 		syslog(LOG_ERR, _("Invalid user name \"%s\" in %s:%d. Abort."),
 		       cxt.username, __FUNCTION__, __LINE__);
@@ -767,24 +806,7 @@ int main(int argc, char **argv)
 		exit(EXIT_FAILURE);
 	}
 
-	/*
-	 * Create a copy of the pwd struct - otherwise it may get
-	 * clobbered by PAM
-	 */
-	memcpy(&pwdcopy, pwd, sizeof(*pwd));
-	pwd = &pwdcopy;
-	pwd->pw_name = strdup(pwd->pw_name);
-	pwd->pw_passwd = strdup(pwd->pw_passwd);
-	pwd->pw_gecos = strdup(pwd->pw_gecos);
-	pwd->pw_dir = strdup(pwd->pw_dir);
-	pwd->pw_shell = strdup(pwd->pw_shell);
-	if (!pwd->pw_name || !pwd->pw_passwd || !pwd->pw_gecos ||
-	    !pwd->pw_dir || !pwd->pw_shell) {
-		warnx(_("out of memory"));
-		syslog(LOG_ERR, "Out of memory");
-		pam_end(pamh, PAM_SYSTEM_ERR);
-		exit(EXIT_FAILURE);
-	}
+	pwd = cxt.pwd;
 	cxt.username = pwd->pw_name;
 
 	/*
@@ -847,7 +869,7 @@ int main(int argc, char **argv)
 	}
 
 	log_utmp(&cxt);
-	log_audit(&cxt, pwd, 1);
+	log_audit(&cxt, 1);
 	log_lastlog(&cxt);
 
 	if (fchown(0, pwd->pw_uid,
-- 
1.7.6.4
