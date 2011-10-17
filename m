Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 31/49] login: log good logins refactoring
Date: Mon, 17 Oct 2011 13:15:10 +0200
Message-Id: <1318850128-23458-32-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |   50 ++++++++++++++++++++++++++------------------------
 1 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index d87a632..52598f4 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -509,6 +509,30 @@ static void log_utmp(struct login_context *cxt)
 	updwtmp(_PATH_WTMP, &ut);
 }
 
+static void log_syslog(struct login_context *cxt)
+{
+	struct passwd *pwd = cxt->pwd;
+
+	if (!strncmp(cxt->tty_name, "ttyS", 4))
+		syslog(LOG_INFO, _("DIALUP AT %s BY %s"),
+		       cxt->tty_name, pwd->pw_name);
+
+	if (!pwd->pw_uid) {
+		if (cxt->hostname)
+			syslog(LOG_NOTICE, _("ROOT LOGIN ON %s FROM %s"),
+			       cxt->tty_name, cxt->hostname);
+		else
+			syslog(LOG_NOTICE, _("ROOT LOGIN ON %s"), cxt->tty_name);
+	} else {
+		if (cxt->hostname)
+			syslog(LOG_INFO, _("LOGIN ON %s BY %s FROM %s"),
+			       cxt->tty_name, pwd->pw_name, cxt->hostname);
+		else
+			syslog(LOG_INFO, _("LOGIN ON %s BY %s"), cxt->tty_name,
+			       pwd->pw_name);
+	}
+}
+
 static struct passwd *get_passwd_entry(const char *username,
 					 char **pwdbuf,
 					 struct passwd *pwd)
@@ -1140,7 +1164,6 @@ int main(int argc, char **argv)
 
 	chown_tty(&cxt);
 
-
 	if (setgid(pwd->pw_gid) < 0 && pwd->pw_gid) {
 		syslog(LOG_ALERT, _("setgid() failed"));
 		exit(EXIT_FAILURE);
@@ -1149,32 +1172,11 @@ int main(int argc, char **argv)
 	if (*pwd->pw_shell == '\0')
 		pwd->pw_shell = _PATH_BSHELL;
 
-	init_environ(&cxt);
-
+	init_environ(&cxt);		/* init $HOME, $TERM ... */
 
 	setproctitle("login", cxt.username);
 
-	if (!strncmp(cxt.tty_name, "ttyS", 4))
-		syslog(LOG_INFO, _("DIALUP AT %s BY %s"), cxt.tty_name,
-		       pwd->pw_name);
-
-	/* allow tracking of good logins.
-	   -steve philp (sphilp@mail.alliance.net) */
-
-	if (pwd->pw_uid == 0) {
-		if (cxt.hostname)
-			syslog(LOG_NOTICE, _("ROOT LOGIN ON %s FROM %s"),
-			       cxt.tty_name, cxt.hostname);
-		else
-			syslog(LOG_NOTICE, _("ROOT LOGIN ON %s"), cxt.tty_name);
-	} else {
-		if (cxt.hostname)
-			syslog(LOG_INFO, _("LOGIN ON %s BY %s FROM %s"),
-			       cxt.tty_name, pwd->pw_name, cxt.hostname);
-		else
-			syslog(LOG_INFO, _("LOGIN ON %s BY %s"), cxt.tty_name,
-			       pwd->pw_name);
-	}
+	log_syslog(&cxt);
 
 	if (!cxt.quiet) {
 		motd();
-- 
1.7.6.4
