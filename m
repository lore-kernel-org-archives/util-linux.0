Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 28/49] login: fork & session initialization refactoring
Date: Mon, 17 Oct 2011 13:15:07 +0200
Message-Id: <1318850128-23458-29-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |  200 +++++++++++++++++++++++++++------------------------
 1 files changed, 106 insertions(+), 94 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index 950af99..1011206 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -117,7 +117,9 @@ struct login_context {
  * This bounds the time given to login.  Not a define so it can
  * be patched on machines where it's too small.
  */
-int timeout = LOGIN_TIMEOUT;
+static int timeout = LOGIN_TIMEOUT;
+static int child_pid = 0;
+static volatile int got_sig = 0;
 
 static void timedout(int);
 static void sigint(int);
@@ -334,9 +336,6 @@ static void log_btmp(struct login_context *cxt)
 	updwtmp(_PATH_BTMP, &ut);
 }
 
-static int child_pid = 0;
-static volatile int got_sig = 0;
-
 /*
  * This handler allows to inform a shell about signals to login. If you have
  * (root) permissions you can kill all login childrent by one signal to login
@@ -822,6 +821,106 @@ static int get_hushlogin_status(struct passwd *pwd)
 	return 0;
 }
 
+/*
+ * Detach the controlling terminal, fork, restore syslog stuff and create a new
+ * session.
+ */
+static void fork_session(struct login_context *cxt)
+{
+	struct sigaction sa, oldsa_hup, oldsa_term;
+
+	signal(SIGALRM, SIG_DFL);
+	signal(SIGQUIT, SIG_DFL);
+	signal(SIGTSTP, SIG_IGN);
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = SIG_IGN;
+	sigaction(SIGINT, &sa, NULL);
+
+	sigaction(SIGHUP, &sa, &oldsa_hup);	/* ignore when TIOCNOTTY */
+
+	/*
+	 * detach the controlling tty
+	 * -- we needn't the tty in parent who waits for child only.
+	 *    The child calls setsid() that detach from the tty as well.
+	 */
+	ioctl(0, TIOCNOTTY, NULL);
+
+	/*
+	 * We have care about SIGTERM, because leave PAM session without
+	 * pam_close_session() is pretty bad thing.
+	 */
+	sa.sa_handler = sig_handler;
+	sigaction(SIGHUP, &sa, NULL);
+	sigaction(SIGTERM, &sa, &oldsa_term);
+
+	closelog();
+
+	/*
+	 * We must fork before setuid() because we need to call
+	 * pam_close_session() as root.
+	 */
+	child_pid = fork();
+	if (child_pid < 0) {
+		/*
+		 * fork() error
+		 */
+		warn(_("fork failed"));
+
+		pam_setcred(cxt->pamh, PAM_DELETE_CRED);
+		pam_end(cxt->pamh, pam_close_session(cxt->pamh, 0));
+		exit(EXIT_FAILURE);
+	}
+
+	if (child_pid) {
+		/*
+		 * parent - wait for child to finish, then cleanup session
+		 */
+		close(0);
+		close(1);
+		close(2);
+		sa.sa_handler = SIG_IGN;
+		sigaction(SIGQUIT, &sa, NULL);
+		sigaction(SIGINT, &sa, NULL);
+
+		/* wait as long as any child is there */
+		while (wait(NULL) == -1 && errno == EINTR) ;
+		openlog("login", LOG_ODELAY, LOG_AUTHPRIV);
+
+		pam_setcred(cxt->pamh, PAM_DELETE_CRED);
+		pam_end(cxt->pamh, pam_close_session(cxt->pamh, 0));
+		exit(EXIT_SUCCESS);
+	}
+
+	/*
+	 * child
+	 */
+	sigaction(SIGHUP, &oldsa_hup, NULL);		/* restore old state */
+	sigaction(SIGTERM, &oldsa_term, NULL);
+	if (got_sig)
+		exit(EXIT_FAILURE);
+
+	/*
+	 * Problem: if the user's shell is a shell like ash that doesnt do
+	 * setsid() or setpgrp(), then a ctrl-\, sending SIGQUIT to every
+	 * process in the pgrp, will kill us.
+	 */
+
+	/* start new session */
+	setsid();
+
+	/* make sure we have a controlling tty */
+	open_tty(cxt->tty_path);
+	openlog("login", LOG_ODELAY, LOG_AUTHPRIV);	/* reopen */
+
+	/*
+	 * TIOCSCTTY: steal tty from other process group.
+	 */
+	if (ioctl(0, TIOCSCTTY, 1))
+		syslog(LOG_ERR, _("TIOCSCTTY failed: %m"));
+	signal(SIGINT, SIG_DFL);
+}
+
 int main(int argc, char **argv)
 {
 	extern int optind;
@@ -836,7 +935,6 @@ int main(int argc, char **argv)
 	char *buff;
 	int childArgc = 0;
 	int retcode;
-	struct sigaction sa, oldsa_hup, oldsa_term;
 
 	char *pwdbuf = NULL;
 	struct passwd *pwd = NULL, _pwd;
@@ -1120,97 +1218,11 @@ int main(int argc, char **argv)
 #endif
 	}
 
-	signal(SIGALRM, SIG_DFL);
-	signal(SIGQUIT, SIG_DFL);
-	signal(SIGTSTP, SIG_IGN);
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = SIG_IGN;
-	sigaction(SIGINT, &sa, NULL);
-
-	sigaction(SIGHUP, &sa, &oldsa_hup);	/* ignore when TIOCNOTTY */
-
 	/*
-	 * detach the controlling tty
-	 * -- we needn't the tty in parent who waits for child only.
-	 *    The child calls setsid() that detach from the tty as well.
+	 * Detach the controlling terminal, fork() and create, new session
+	 * and reinilizalize syslog stuff.
 	 */
-	ioctl(0, TIOCNOTTY, NULL);
-
-	/*
-	 * We have care about SIGTERM, because leave PAM session without
-	 * pam_close_session() is pretty bad thing.
-	 */
-	sa.sa_handler = sig_handler;
-	sigaction(SIGHUP, &sa, NULL);
-	sigaction(SIGTERM, &sa, &oldsa_term);
-
-	closelog();
-
-	/*
-	 * We must fork before setuid() because we need to call
-	 * pam_close_session() as root.
-	 */
-
-	child_pid = fork();
-	if (child_pid < 0) {
-		/*
-		 * fork() error
-		 */
-		warn(_("fork failed"));
-
-		pam_setcred(cxt.pamh, PAM_DELETE_CRED);
-		pam_end(cxt.pamh, pam_close_session(cxt.pamh, 0));
-		exit(EXIT_FAILURE);
-	}
-
-	if (child_pid) {
-		/*
-		 * parent - wait for child to finish, then cleanup session
-		 */
-		close(0);
-		close(1);
-		close(2);
-		sa.sa_handler = SIG_IGN;
-		sigaction(SIGQUIT, &sa, NULL);
-		sigaction(SIGINT, &sa, NULL);
-
-		/* wait as long as any child is there */
-		while (wait(NULL) == -1 && errno == EINTR) ;
-		openlog("login", LOG_ODELAY, LOG_AUTHPRIV);
-
-		pam_setcred(cxt.pamh, PAM_DELETE_CRED);
-		pam_end(cxt.pamh, pam_close_session(cxt.pamh, 0));
-		exit(EXIT_SUCCESS);
-	}
-
-	/* child */
-
-	/* restore to old state */
-	sigaction(SIGHUP, &oldsa_hup, NULL);
-	sigaction(SIGTERM, &oldsa_term, NULL);
-	if (got_sig)
-		exit(EXIT_FAILURE);
-
-	/*
-	 * Problem: if the user's shell is a shell like ash that doesnt do
-	 * setsid() or setpgrp(), then a ctrl-\, sending SIGQUIT to every
-	 * process in the pgrp, will kill us.
-	 */
-
-	/* start new session */
-	setsid();
-
-	/* make sure we have a controlling tty */
-	open_tty(cxt.tty_path);
-	openlog("login", LOG_ODELAY, LOG_AUTHPRIV);	/* reopen */
-
-	/*
-	 * TIOCSCTTY: steal tty from other process group.
-	 */
-	if (ioctl(0, TIOCSCTTY, 1))
-		syslog(LOG_ERR, _("TIOCSCTTY failed: %m"));
-	signal(SIGINT, SIG_DFL);
+	fork_session(&cxt);
 
 	/* discard permissions last so can't get killed and drop core */
 	if (setuid(pwd->pw_uid) < 0 && pwd->pw_uid) {
-- 
1.7.6.4
