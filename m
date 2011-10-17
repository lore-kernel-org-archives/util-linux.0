Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 27/49] login: remove pam_handle_t from main()
Date: Mon, 17 Oct 2011 13:15:06 +0200
Message-Id: <1318850128-23458-28-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index 49c8aab..950af99 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -840,7 +840,6 @@ int main(int argc, char **argv)
 
 	char *pwdbuf = NULL;
 	struct passwd *pwd = NULL, _pwd;
-	pam_handle_t *pamh;
 
 	struct login_context cxt = {
 		.pid = getpid(),		/* PID */
@@ -949,8 +948,7 @@ int main(int argc, char **argv)
 	openlog("login", LOG_ODELAY, LOG_AUTHPRIV);
 
 	init_tty(&cxt);
-
-	pamh = init_loginpam(&cxt);
+	init_loginpam(&cxt);
 
 	/* login -f, then the user has already been authenticated */
 	cxt.noauth = cxt.noauth && getuid() == 0 ? 1 : 0;
@@ -970,7 +968,7 @@ int main(int argc, char **argv)
 		warnx(_("\nSession setup problem, abort."));
 		syslog(LOG_ERR, _("Invalid user name \"%s\" in %s:%d. Abort."),
 		       cxt.username, __FUNCTION__, __LINE__);
-		pam_end(pamh, PAM_SYSTEM_ERR);
+		pam_end(cxt.pamh, PAM_SYSTEM_ERR);
 		exit(EXIT_FAILURE);
 	}
 
@@ -992,7 +990,7 @@ int main(int argc, char **argv)
 	if (retcode < 0) {
 		syslog(LOG_ERR, _("groups initialization failed: %m"));
 		warnx(_("\nSession setup problem, abort."));
-		pam_end(pamh, PAM_SYSTEM_ERR);
+		pam_end(cxt.pamh, PAM_SYSTEM_ERR);
 		exit(EXIT_FAILURE);
 	}
 
@@ -1063,7 +1061,7 @@ int main(int argc, char **argv)
 
 	{
 		int i;
-		char **env = pam_getenvlist(pamh);
+		char **env = pam_getenvlist(cxt.pamh);
 
 		if (env != NULL) {
 			for (i = 0; env[i]; i++) {
@@ -1156,15 +1154,20 @@ int main(int argc, char **argv)
 
 	child_pid = fork();
 	if (child_pid < 0) {
-		/* error in fork() */
-		warn(_("failure forking"));
-		pam_setcred(pamh, PAM_DELETE_CRED);
-		pam_end(pamh, pam_close_session(pamh, 0));
+		/*
+		 * fork() error
+		 */
+		warn(_("fork failed"));
+
+		pam_setcred(cxt.pamh, PAM_DELETE_CRED);
+		pam_end(cxt.pamh, pam_close_session(cxt.pamh, 0));
 		exit(EXIT_FAILURE);
 	}
 
 	if (child_pid) {
-		/* parent - wait for child to finish, then cleanup session */
+		/*
+		 * parent - wait for child to finish, then cleanup session
+		 */
 		close(0);
 		close(1);
 		close(2);
@@ -1175,8 +1178,9 @@ int main(int argc, char **argv)
 		/* wait as long as any child is there */
 		while (wait(NULL) == -1 && errno == EINTR) ;
 		openlog("login", LOG_ODELAY, LOG_AUTHPRIV);
-		pam_setcred(pamh, PAM_DELETE_CRED);
-		pam_end(pamh, pam_close_session(pamh, 0));
+
+		pam_setcred(cxt.pamh, PAM_DELETE_CRED);
+		pam_end(cxt.pamh, pam_close_session(cxt.pamh, 0));
 		exit(EXIT_SUCCESS);
 	}
 
-- 
1.7.6.4
