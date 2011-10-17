Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 20/49] login: use setgroups(0, NULL) for root
Date: Mon, 17 Oct 2011 13:14:59 +0200
Message-Id: <1318850128-23458-21-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index 3a74abe..1adf330 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -709,7 +709,6 @@ int main(int argc, char **argv)
 	 * and if specified on the command line it is set.
 	 * Therefore, we are safe not setting it to anything
 	 */
-
 	retcode = pam_start(hflag ? "remote" : "login", cxt.username, &conv, &pamh);
 	if (retcode != PAM_SUCCESS) {
 		warnx(_("PAM failure, aborting: %s"),
@@ -834,6 +833,7 @@ int main(int argc, char **argv)
 		pam_end(pamh, PAM_SYSTEM_ERR);
 		exit(EXIT_FAILURE);
 	}
+
 	if (!(cxt.pwd = get_passwd_entry(cxt.username, &pwdbuf, &_pwd))) {
 		warnx(_("\nSession setup problem, abort."));
 		syslog(LOG_ERR, _("Invalid user name \"%s\" in %s:%d. Abort."),
@@ -846,12 +846,19 @@ int main(int argc, char **argv)
 	cxt.username = pwd->pw_name;
 
 	/*
-	 * Initialize the supplementary group list.
-	 * This should be done before pam_setcred because
-	 * the PAM modules might add groups during pam_setcred.
+	 * Initialize the supplementary group list. This should be done before
+	 * pam_setcred because the PAM modules might add groups during
+	 * pam_setcred.
+	 *
+         * For root we don't call initgroups, instead we call setgroups with
+	 * group 0. This avoids the need to step through the whole group file,
+	 * which can cause problems if NIS, NIS+, LDAP or something similar
+	 * is used and the machine has network problems.
 	 */
-	if (initgroups(cxt.username, pwd->pw_gid) < 0) {
-		syslog(LOG_ERR, "initgroups: %m");
+	retcode = pwd->pw_uid ? initgroups(cxt.username, pwd->pw_gid) :	/* user */
+			        setgroups(0, NULL);			/* root */
+	if (retcode < 0) {
+		syslog(LOG_ERR, _("groups initialization failed: %m"));
 		warnx(_("\nSession setup problem, abort."));
 		pam_end(pamh, PAM_SYSTEM_ERR);
 		exit(EXIT_FAILURE);
-- 
1.7.6.4
