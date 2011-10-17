Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 06/49] login: remove PAM_FAIL_CHECK and PAM_END macros
Date: Mon, 17 Oct 2011 13:14:45 +0200
Message-Id: <1318850128-23458-7-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

 * use function rather than horrible macros
 * rename get_pam_username -> loginpam_get_username

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |   80 +++++++++++++++++++++++++++++---------------------
 1 files changed, 46 insertions(+), 34 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index a7d6b02..8ef12af 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -49,10 +49,11 @@
 #include <sys/sysmacros.h>
 #include <linux/major.h>
 #include <netdb.h>
+#include <security/pam_appl.h>
+#include <security/pam_misc.h>
 #ifdef HAVE_LIBAUDIT
 # include <libaudit.h>
 #endif
-
 #ifdef HAVE_CRYPT_H
 #include <crypt.h>
 #endif
@@ -64,19 +65,8 @@
 #include "xalloc.h"
 #include "c.h"
 
-#include <security/pam_appl.h>
-#include <security/pam_misc.h>
 #define PAM_MAX_LOGIN_TRIES	3
-#define PAM_FAIL_CHECK if (retcode != PAM_SUCCESS) { \
-       fprintf(stderr,"\n%s\n",pam_strerror(pamh, retcode)); \
-       syslog(LOG_ERR,"%s",pam_strerror(pamh, retcode)); \
-       pam_end(pamh, retcode); exit(EXIT_FAILURE); \
-   }
-#define PAM_END { \
-	pam_setcred(pamh, PAM_DELETE_CRED); \
-	retcode = pam_close_session(pamh,0); \
-	pam_end(pamh,retcode); \
-}
+#define is_pam_failure(_rc)	((_rc) != PAM_SUCCESS)
 
 #include <lastlog.h>
 
@@ -285,8 +275,7 @@ logaudit(const char *tty, const char *username, const char *hostname,
 #endif /* HAVE_LIBAUDIT */
 
 /* encapsulate stupid "void **" pam_get_item() API */
-int
-get_pam_username(pam_handle_t *pamh, char **name)
+static int loginpam_get_username(pam_handle_t *pamh, char **name)
 {
 	const void *item = (void *) *name;
 	int rc;
@@ -295,6 +284,19 @@ get_pam_username(pam_handle_t *pamh, char **name)
 	return rc;
 }
 
+static int loginpam_err(pam_handle_t *pamh, int retcode)
+{
+	const char *msg = pam_strerror(pamh, retcode);
+
+	if (msg) {
+		fprintf(stderr, "\n%s\n", msg);
+		syslog(LOG_ERR, "%s", msg);
+	}
+	pam_end(pamh, retcode);
+	exit(EXIT_FAILURE);
+
+}
+
 /*
  * We need to check effective UID/GID. For example $HOME could be on root
  * squashed NFS or on NFS with UID mapping and access(2) uses real UID/GID.
@@ -504,12 +506,17 @@ main(int argc, char **argv)
 	       pam_strerror(pamh, retcode));
 	exit(EXIT_FAILURE);
     }
+
     /* hostname & tty are either set to NULL or their correct values,
-       depending on how much we know */
+     * depending on how much we know
+     */
     retcode = pam_set_item(pamh, PAM_RHOST, hostname);
-    PAM_FAIL_CHECK;
+    if (is_pam_failure(retcode))
+	loginpam_err(pamh, retcode);
+
     retcode = pam_set_item(pamh, PAM_TTY, tty_name);
-    PAM_FAIL_CHECK;
+    if (is_pam_failure(retcode))
+	loginpam_err(pamh, retcode);
 
     /*
      * Andrew.Taylor@cal.montage.ca: Provide a user prompt to PAM
@@ -518,7 +525,8 @@ main(int argc, char **argv)
      * (yet).
      */
     retcode = pam_set_item(pamh, PAM_USER_PROMPT, _("login: "));
-    PAM_FAIL_CHECK;
+    if (is_pam_failure(retcode))
+	loginpam_err(pamh, retcode);
 
     if (username) {
 	/* we need't the original username. We have to follow PAM. */
@@ -536,7 +544,7 @@ main(int argc, char **argv)
 	int failcount=0;
 
 	/* if we didn't get a user on the command line, set it to NULL */
-	get_pam_username(pamh, &username);
+	loginpam_get_username(pamh, &username);
 
 	/* there may be better ways to deal with some of these
 	   conditions, but at least this way I don't think we'll
@@ -550,7 +558,7 @@ main(int argc, char **argv)
 	       (retcode == PAM_USER_UNKNOWN) ||
 	       (retcode == PAM_CRED_INSUFFICIENT) ||
 	       (retcode == PAM_AUTHINFO_UNAVAIL))) {
-	    get_pam_username(pamh, &username);
+	    loginpam_get_username(pamh, &username);
 
 	    syslog(LOG_NOTICE,_("FAILED LOGIN %d FROM %s FOR %s, %s"),
 		   failcount, hostname, username, pam_strerror(pamh, retcode));
@@ -562,8 +570,8 @@ main(int argc, char **argv)
 	    retcode = pam_authenticate(pamh, 0);
 	}
 
-	if (retcode != PAM_SUCCESS) {
-	    get_pam_username(pamh, &username);
+	if (is_pam_failure(retcode)) {
+	    loginpam_get_username(pamh, &username);
 
 	    if (retcode == PAM_MAXTRIES)
 		syslog(LOG_NOTICE,_("TOO MANY LOGIN TRIES (%d) FROM %s FOR "
@@ -589,18 +597,18 @@ main(int argc, char **argv)
      */
     retcode = pam_acct_mgmt(pamh, 0);
 
-    if(retcode == PAM_NEW_AUTHTOK_REQD) {
+    if (retcode == PAM_NEW_AUTHTOK_REQD)
         retcode = pam_chauthtok(pamh, PAM_CHANGE_EXPIRED_AUTHTOK);
-    }
-
-    PAM_FAIL_CHECK;
+    if (is_pam_failure(retcode))
+	loginpam_err(pamh, retcode);
 
     /*
      * Grab the user information out of the password file for future usage
      * First get the username that we are actually using, though.
      */
-    retcode = get_pam_username(pamh, &username);
-    PAM_FAIL_CHECK;
+    retcode = loginpam_get_username(pamh, &username);
+    if (is_pam_failure(retcode))
+	loginpam_err(pamh, retcode);
 
     if (!username || !*username) {
 	    warnx(_("\nSession setup problem, abort."));
@@ -650,12 +658,14 @@ main(int argc, char **argv)
     }
 
     retcode = pam_open_session(pamh, 0);
-    PAM_FAIL_CHECK;
+    if (is_pam_failure(retcode))
+	loginpam_err(pamh, retcode);
 
     retcode = pam_setcred(pamh, PAM_ESTABLISH_CRED);
-    if (retcode != PAM_SUCCESS)
+    if (is_pam_failure(retcode)) {
 	    pam_close_session(pamh, 0);
-    PAM_FAIL_CHECK;
+	    loginpam_err(pamh, retcode);
+    }
 
     /* committed to login -- turn off timeout */
     alarm((unsigned int)0);
@@ -944,7 +954,8 @@ Michael Riepe <michael@stud.uni-hannover.de>
     if (child_pid < 0) {
        /* error in fork() */
        warn(_("failure forking"));
-       PAM_END;
+       pam_setcred(pamh, PAM_DELETE_CRED);
+       pam_end(pamh, pam_close_session(pamh, 0));
        exit(EXIT_FAILURE);
     }
 
@@ -961,7 +972,8 @@ Michael Riepe <michael@stud.uni-hannover.de>
        while(wait(NULL) == -1 && errno == EINTR)
 	       ;
        openlog("login", LOG_ODELAY, LOG_AUTHPRIV);
-       PAM_END;
+       pam_setcred(pamh, PAM_DELETE_CRED);
+       pam_end(pamh, pam_close_session(pamh, 0));
        exit(EXIT_SUCCESS);
     }
 
-- 
1.7.6.4
