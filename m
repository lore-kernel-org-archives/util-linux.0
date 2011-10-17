Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 46/49] login: use LOG_UNKFAIL_ENAB from login.defs, improve logging
Date: Mon, 17 Oct 2011 13:15:25 +0200
Message-Id: <1318850128-23458-47-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.1 |    9 ++++++++-
 login-utils/login.c |   29 +++++++++++++++++++++++------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/login-utils/login.1 b/login-utils/login.1
index ca7c4b3..948177c 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -182,7 +182,14 @@ Indicate if login is allowed if we can\'t cd to the home directory. If set to
 \fIyes\fR, the user will login in the root (/) directory if it is not possible
 to cd to her home directory. The default value is 'yes'.
 .RE
-
+.PP
+\fBLOG_UNKFAIL_ENAB\fR (boolean)
+.RS 4
+Enable display of unknown usernames when login failures are recorded\&.
+.sp
+Note that logging unknown usernames may be a security issue if an user enter
+her password instead of her login name.
+.RE
 .SH FILES
 .nf
 .I /var/run/utmp
diff --git a/login-utils/login.c b/login-utils/login.c
index 0c8cc26..74f5736 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -711,12 +711,16 @@ static pam_handle_t *init_loginpam(struct login_context *cxt)
 
 static void loginpam_auth(struct login_context *cxt)
 {
-	int rc, failcount = 0;
+	int rc, failcount = 0, show_unknown;
+	const char *hostname = cxt->hostname ? cxt->hostname :
+			       cxt->tty_name ? cxt->tty_name : "<unknown>";
 	pam_handle_t *pamh = cxt->pamh;
 
 	/* if we didn't get a user on the command line, set it to NULL */
 	loginpam_get_username(pamh, &cxt->username);
 
+	show_unknown = getlogindefs_bool("LOG_UNKFAIL_ENAB", 0);
+
 	/*
 	 * There may be better ways to deal with some of these conditions, but
 	 * at least this way I don't think we'll be giving away information...
@@ -732,11 +736,19 @@ static void loginpam_auth(struct login_context *cxt)
 		(rc == PAM_CRED_INSUFFICIENT) ||
 		(rc == PAM_AUTHINFO_UNAVAIL))) {
 
-		loginpam_get_username(pamh, &cxt->username);
+		if (rc == PAM_USER_UNKNOWN && !show_unknown)
+			/*
+			 * logging unknown usernames may be a security issue if
+			 * an user enter her password instead of her login name
+			 */
+			cxt->username = NULL;
+		else
+			loginpam_get_username(pamh, &cxt->username);
 
 		syslog(LOG_NOTICE,
 		       _("FAILED LOGIN %d FROM %s FOR %s, %s"),
-		       failcount, cxt->hostname, cxt->username,
+		       failcount, hostname,
+		       cxt->username ? cxt->username : "(unknown)",
 		       pam_strerror(pamh, rc));
 
 		log_btmp(cxt);
@@ -750,17 +762,22 @@ static void loginpam_auth(struct login_context *cxt)
 
 	if (is_pam_failure(rc)) {
 
-		loginpam_get_username(pamh, &cxt->username);
+		if (rc == PAM_USER_UNKNOWN && !show_unknown)
+			cxt->username = NULL;
+		else
+			loginpam_get_username(pamh, &cxt->username);
 
 		if (rc == PAM_MAXTRIES)
 			syslog(LOG_NOTICE,
 			       _("TOO MANY LOGIN TRIES (%d) FROM %s FOR %s, %s"),
-			       failcount, cxt->hostname, cxt->username,
+			       failcount, hostname,
+			       cxt->username ? cxt->username : "(unknown)",
 			       pam_strerror(pamh, rc));
 		else
 			syslog(LOG_NOTICE,
 			       _("FAILED LOGIN SESSION FROM %s FOR %s, %s"),
-			       cxt->hostname, cxt->username,
+			       hostname,
+			       cxt->username ? cxt->username : "(unknown)",
 			       pam_strerror(pamh, rc));
 
 		log_btmp(cxt);
-- 
1.7.6.4
