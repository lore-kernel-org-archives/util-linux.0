Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 15/49] login: use login_context struct in audit stuff
Date: Mon, 17 Oct 2011 13:14:54 +0200
Message-Id: <1318850128-23458-16-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |   36 ++++++++++++++++++++----------------
 1 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index a794d18..e29fb43 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -251,8 +251,7 @@ static int is_consoletty(int fd)
  * Must be called only with username the name of an actual user.
  * The most common login failure is to give password instead of username.
  */
-static void
-logbtmp(struct login_context *cxt)
+static void logbtmp(struct login_context *cxt)
 {
 	struct utmp ut;
 	struct timeval tv;
@@ -282,6 +281,7 @@ logbtmp(struct login_context *cxt)
 
 	ut.ut_type = LOGIN_PROCESS;	/* XXX doesn't matter */
 	ut.ut_pid = cxt->pid;
+
 	if (cxt->hostname) {
 		xstrncpy(ut.ut_host, cxt->hostname, sizeof(ut.ut_host));
 		if (cxt->hostaddress && *cxt->hostaddress)
@@ -315,27 +315,31 @@ static void sig_handler(int signal)
 }
 
 #ifdef HAVE_LIBAUDIT
-static void
-logaudit(const char *tty, const char *username, const char *hostname,
-	 struct passwd *pwd, int status)
+static void log_audit(struct login_context *cxt, struct passwd *pwd, int status)
 {
 	int audit_fd;
 
 	audit_fd = audit_open();
 	if (audit_fd == -1)
 		return;
-	if (!pwd && username)
-		pwd = getpwnam(username);
-
-	audit_log_acct_message(audit_fd, AUDIT_USER_LOGIN,
-			       NULL, "login", username ? username : "(unknown)",
-			       pwd ? pwd->pw_uid : (unsigned int)-1, hostname,
-			       NULL, tty, status);
+	if (!pwd && cxt->username)
+		pwd = getpwnam(cxt->username);
+
+	audit_log_acct_message(audit_fd,
+			       AUDIT_USER_LOGIN,
+			       NULL,
+			       "login",
+			       cxt->username ? cxt->username : "(unknown)",
+			       pwd ? pwd->pw_uid : (unsigned int) -1,
+			       cxt->hostname,
+			       NULL,
+			       cxt->tty_name,
+			       status);
 
 	close(audit_fd);
 }
 #else				/* ! HAVE_LIBAUDIT */
-#define logaudit(tty, username, hostname, pwd, status)
+#define log_audit(cxt, pwd, status)
 #endif				/* HAVE_LIBAUDIT */
 
 /* encapsulate stupid "void **" pam_get_item() API */
@@ -574,7 +578,7 @@ int main(int argc, char **argv)
 			       failcount, cxt.hostname, cxt.username, pam_strerror(pamh,
 									   retcode));
 			logbtmp(&cxt);
-			logaudit(cxt.tty_name, cxt.username, cxt.hostname, NULL, 0);
+			log_audit(&cxt, NULL, 0);
 
 			fprintf(stderr, _("Login incorrect\n\n"));
 			pam_set_item(pamh, PAM_USER, NULL);
@@ -597,7 +601,7 @@ int main(int argc, char **argv)
 				       cxt.hostname, cxt.username, pam_strerror(pamh,
 									retcode));
 			logbtmp(&cxt);
-			logaudit(cxt.tty_name, cxt.username, cxt.hostname, NULL, 0);
+			log_audit(&cxt, NULL, 0);
 
 			fprintf(stderr, _("\nLogin incorrect\n"));
 			pam_end(pamh, retcode);
@@ -811,7 +815,7 @@ int main(int argc, char **argv)
 #endif
 	}
 
-	logaudit(cxt.tty_name, cxt.username, cxt.hostname, pwd, 1);
+	log_audit(&cxt, pwd, 1);
 	dolastlog(&cxt, quietlog);
 
 	if (fchown(0, pwd->pw_uid,
-- 
1.7.6.4
