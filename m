Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 09/49] login: remove obsolete code, clean up macros names
Date: Mon, 17 Oct 2011 13:14:48 +0200
Message-Id: <1318850128-23458-10-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |   50 +++++++++++---------------------------------------
 1 files changed, 11 insertions(+), 39 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index 1bbcddd..4ed1da3 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -67,10 +67,11 @@
 #include "nls.h"
 #include "xalloc.h"
 
-#define PAM_MAX_LOGIN_TRIES	3
 #define is_pam_failure(_rc)	((_rc) != PAM_SUCCESS)
 
-#define SLEEP_EXIT_TIMEOUT 5
+#define LOGIN_MAX_TRIES        3
+#define LOGIN_EXIT_TIMEOUT     5
+#define LOGIN_TIMEOUT          60
 
 #ifdef USE_TTY_GROUP
 #  define TTY_MODE 0620
@@ -80,25 +81,18 @@
 
 #define	TTYGRPNAME	"tty"		/* name of group to own ttys */
 
-#ifndef MAXPATHLEN
-#  define MAXPATHLEN 1024
-#endif
-
 /*
  * This bounds the time given to login.  Not a define so it can
  * be patched on machines where it's too small.
  */
-int timeout = 60;
+int timeout = LOGIN_TIMEOUT;
 
 struct passwd *pwd;
 
 static struct passwd pwdcopy;
 char hostaddress[16];	/* used in checktty.c */
-sa_family_t hostfamily;		/* used in checktty.c */
 char	*hostname;		/* idem */
 static char	*username, *tty_name, *tty_number;
-static char	thishost[100];
-static int	failures = 1;
 static pid_t	pid;
 
 static void timedout (int);
@@ -316,7 +310,7 @@ main(int argc, char **argv)
     int fflag, hflag, pflag, cnt;
     int quietlog, passwd_req;
     char *domain, *ttyn;
-    char tbuf[MAXPATHLEN + 2];
+    char tbuf[PATH_MAX + 2];
     char *termenv;
     char *childArgv[10];
     char *buff;
@@ -351,7 +345,6 @@ main(int argc, char **argv)
      *    host to login so that it may be placed in utmp and wtmp
      */
     gethostname(tbuf, sizeof(tbuf));
-    xstrncpy(thishost, tbuf, sizeof(thishost));
     domain = strchr(tbuf, '.');
 
     username = tty_name = hostname = NULL;
@@ -397,7 +390,6 @@ main(int argc, char **argv)
 			    memcpy(hostaddress, &(sa->sin6_addr),
 					sizeof(sa->sin6_addr));
 			}
-			hostfamily = info->ai_family;
 			freeaddrinfo(info);
 		}
 	  }
@@ -546,7 +538,7 @@ main(int argc, char **argv)
 	   pay attention to failure count and get rid of MAX_LOGIN_TRIES? */
 
 	retcode = pam_authenticate(pamh, 0);
-	while((failcount++ < PAM_MAX_LOGIN_TRIES) &&
+	while((failcount++ < LOGIN_MAX_TRIES) &&
 	      ((retcode == PAM_AUTH_ERR) ||
 	       (retcode == PAM_USER_UNKNOWN) ||
 	       (retcode == PAM_CRED_INSUFFICIENT) ||
@@ -672,15 +664,14 @@ main(int argc, char **argv)
 
        A portable solution would require a fork(), but we rely on Linux
        having the BSD setreuid() */
-
     {
-	char tmpstr[MAXPATHLEN];
+	char tmpstr[PATH_MAX];
 	uid_t ruid = getuid();
 	gid_t egid = getegid();
 
 	/* avoid snprintf - old systems do not have it, or worse,
 	   have a libc in which snprintf is the same as sprintf */
-	if (strlen(pwd->pw_dir) + sizeof(_PATH_HUSHLOGIN) + 2 > MAXPATHLEN)
+	if (strlen(pwd->pw_dir) + sizeof(_PATH_HUSHLOGIN) + 2 > PATH_MAX)
 		quietlog = 0;
 	else {
 		sprintf(tmpstr, "%s/%s", pwd->pw_dir, _PATH_HUSHLOGIN);
@@ -838,9 +829,9 @@ Michael Riepe <michael@stud.uni-hannover.de>
 
     /* mailx will give a funny error msg if you forget this one */
     {
-      char tmp[MAXPATHLEN];
+      char tmp[PATH_MAX];
       /* avoid snprintf */
-      if (sizeof(_PATH_MAILDIR) + strlen(pwd->pw_name) + 1 < MAXPATHLEN) {
+      if (sizeof(_PATH_MAILDIR) + strlen(pwd->pw_name) + 1 < PATH_MAX) {
 	      sprintf(tmp, "%s/%s", _PATH_MAILDIR, pwd->pw_name);
 	      setenv("MAIL",tmp,0);
       }
@@ -1145,28 +1136,9 @@ dolastlog(int quiet) {
     }
 }
 
-void
-badlogin(const char *name) {
-    if (failures == 1) {
-	if (hostname)
-	  syslog(LOG_NOTICE, _("LOGIN FAILURE FROM %s, %s"),
-		 hostname, name);
-	else
-	  syslog(LOG_NOTICE, _("LOGIN FAILURE ON %s, %s"),
-		 tty_name, name);
-    } else {
-	if (hostname)
-	  syslog(LOG_NOTICE, _("%d LOGIN FAILURES FROM %s, %s"),
-		 failures, hostname, name);
-	else
-	  syslog(LOG_NOTICE, _("%d LOGIN FAILURES ON %s, %s"),
-		 failures, tty_name, name);
-    }
-}
-
 /* Should not be called from PAM code... */
 void
 sleepexit(int eval) {
-    sleep(SLEEP_EXIT_TIMEOUT);
+    sleep(LOGIN_EXIT_TIMEOUT);
     exit(eval);
 }
-- 
1.7.6.4
