Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 25/49] login: PAM account checks refactoring
Date: Mon, 17 Oct 2011 13:15:04 +0200
Message-Id: <1318850128-23458-26-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |   61 +++++++++++++++++++++++++++++---------------------
 1 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index 03335c4..0c53d5f 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -675,6 +675,36 @@ static void loginpam_auth(struct login_context *cxt)
 	}
 }
 
+static void loginpam_acct(struct login_context *cxt)
+{
+	int rc;
+	pam_handle_t *pamh = cxt->pamh;
+
+	rc = pam_acct_mgmt(pamh, 0);
+
+	if (rc == PAM_NEW_AUTHTOK_REQD)
+		rc = pam_chauthtok(pamh, PAM_CHANGE_EXPIRED_AUTHTOK);
+
+	if (is_pam_failure(rc))
+		loginpam_err(pamh, rc);
+
+	/*
+	 * Grab the user information out of the password file for future usage
+	 * First get the username that we are actually using, though.
+	 */
+	rc = loginpam_get_username(pamh, &cxt->username);
+	if (is_pam_failure(rc))
+		loginpam_err(pamh, rc);
+
+	if (!cxt->username || !*cxt->username) {
+		warnx(_("\nSession setup problem, abort."));
+		syslog(LOG_ERR, _("NULL user name in %s:%d. Abort."),
+		       __FUNCTION__, __LINE__);
+		pam_end(pamh, PAM_SYSTEM_ERR);
+		exit(EXIT_FAILURE);
+	}
+}
+
 /*
  * We need to check effective UID/GID. For example $HOME could be on root
  * squashed NFS or on NFS with UID mapping and access(2) uses real UID/GID.
@@ -913,33 +943,12 @@ int main(int argc, char **argv)
 		loginpam_auth(&cxt);
 
 	/*
-	 * Authentication may be skipped (for example, during krlogin, rlogin, etc...),
-	 * but it doesn't mean that we can skip other account checks. The account
-	 * could be disabled or password expired (althought kerberos ticket is valid).
-	 * -- kzak@redhat.com (22-Feb-2006)
-	 */
-	retcode = pam_acct_mgmt(pamh, 0);
-
-	if (retcode == PAM_NEW_AUTHTOK_REQD)
-		retcode = pam_chauthtok(pamh, PAM_CHANGE_EXPIRED_AUTHTOK);
-	if (is_pam_failure(retcode))
-		loginpam_err(pamh, retcode);
-
-	/*
-	 * Grab the user information out of the password file for future usage
-	 * First get the username that we are actually using, though.
+	 * Authentication may be skipped (for example, during krlogin, rlogin,
+	 * etc...), but it doesn't mean that we can skip other account checks.
+	 * The account could be disabled or password expired (althought
+	 * kerberos ticket is valid).         -- kzak@redhat.com (22-Feb-2006)
 	 */
-	retcode = loginpam_get_username(pamh, &cxt.username);
-	if (is_pam_failure(retcode))
-		loginpam_err(pamh, retcode);
-
-	if (!cxt.username || !*cxt.username) {
-		warnx(_("\nSession setup problem, abort."));
-		syslog(LOG_ERR, _("NULL user name in %s:%d. Abort."),
-		       __FUNCTION__, __LINE__);
-		pam_end(pamh, PAM_SYSTEM_ERR);
-		exit(EXIT_FAILURE);
-	}
+	loginpam_acct(&cxt);
 
 	if (!(cxt.pwd = get_passwd_entry(cxt.username, &pwdbuf, &_pwd))) {
 		warnx(_("\nSession setup problem, abort."));
-- 
1.7.6.4
