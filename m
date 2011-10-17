Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 26/49] login: PAM session initialization refactoring
Date: Mon, 17 Oct 2011 13:15:05 +0200
Message-Id: <1318850128-23458-27-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |   29 ++++++++++++++++++++---------
 1 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index 0c53d5f..49c8aab 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -705,6 +705,22 @@ static void loginpam_acct(struct login_context *cxt)
 	}
 }
 
+static void loginpam_session(struct login_context *cxt)
+{
+	int rc;
+	pam_handle_t *pamh = cxt->pamh;
+
+	rc = pam_open_session(pamh, 0);
+	if (is_pam_failure(rc))
+		loginpam_err(pamh, rc);
+
+	rc = pam_setcred(pamh, PAM_ESTABLISH_CRED);
+	if (is_pam_failure(rc)) {
+		pam_close_session(pamh, 0);
+		loginpam_err(pamh, rc);
+	}
+}
+
 /*
  * We need to check effective UID/GID. For example $HOME could be on root
  * squashed NFS or on NFS with UID mapping and access(2) uses real UID/GID.
@@ -980,15 +996,10 @@ int main(int argc, char **argv)
 		exit(EXIT_FAILURE);
 	}
 
-	retcode = pam_open_session(pamh, 0);
-	if (is_pam_failure(retcode))
-		loginpam_err(pamh, retcode);
-
-	retcode = pam_setcred(pamh, PAM_ESTABLISH_CRED);
-	if (is_pam_failure(retcode)) {
-		pam_close_session(pamh, 0);
-		loginpam_err(pamh, retcode);
-	}
+	/*
+	 * Open PAM session (after successful authentication and account check)
+	 */
+	loginpam_session(&cxt);
 
 	/* committed to login -- turn off timeout */
 	alarm((unsigned int)0);
-- 
1.7.6.4
