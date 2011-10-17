Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 16/49] login: lastlog code refactoring
Date: Mon, 17 Oct 2011 13:14:55 +0200
Message-Id: <1318850128-23458-17-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |  103 ++++++++++++++++++++++++++------------------------
 1 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index e29fb43..91f5b81 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -67,6 +67,7 @@
 #include "strutils.h"
 #include "nls.h"
 #include "xalloc.h"
+#include "writeall.h"
 
 #define is_pam_failure(_rc)	((_rc) != PAM_SUCCESS)
 
@@ -102,6 +103,7 @@ struct login_context {
 	char		hostaddress[16];
 
 	pid_t		pid;
+	int		quiet;		/* 1 is hush file exists */
 };
 
 /*
@@ -117,7 +119,6 @@ static struct passwd pwdcopy;
 static void timedout(int);
 static void sigint(int);
 static void motd(void);
-static void dolastlog(struct login_context *cxt, int quiet);
 
 /*
  * Nice and simple code provided by Linus Torvalds 16-Feb-93
@@ -342,6 +343,53 @@ static void log_audit(struct login_context *cxt, struct passwd *pwd, int status)
 #define log_audit(cxt, pwd, status)
 #endif				/* HAVE_LIBAUDIT */
 
+static void log_lastlog(struct login_context *cxt)
+{
+	struct lastlog ll;
+	time_t t;
+	int fd;
+
+	fd = open(_PATH_LASTLOG, O_RDWR, 0);
+	if (fd < 0)
+		return;
+
+	lseek(fd, (off_t) pwd->pw_uid * sizeof(ll), SEEK_SET);
+
+	/*
+	 * Print last log message
+	 */
+	if (!cxt->quiet) {
+		if (read(fd, (char *)&ll, sizeof(ll)) == sizeof(ll) &&
+							ll.ll_time != 0) {
+			time_t ll_time = (time_t) ll.ll_time;
+
+			printf(_("Last login: %.*s "), 24 - 5, ctime(&ll_time));
+			if (*ll.ll_host != '\0')
+				printf(_("from %.*s\n"),
+				       (int)sizeof(ll.ll_host), ll.ll_host);
+			else
+				printf(_("on %.*s\n"),
+				       (int)sizeof(ll.ll_line), ll.ll_line);
+		}
+		lseek(fd, (off_t) pwd->pw_uid * sizeof(ll), SEEK_SET);
+	}
+
+	memset((char *)&ll, 0, sizeof(ll));
+
+	time(&t);
+	ll.ll_time = t;		/* ll_time is always 32bit */
+
+	if (cxt->tty_name)
+		xstrncpy(ll.ll_line, cxt->tty_name, sizeof(ll.ll_line));
+	if (cxt->hostname)
+		xstrncpy(ll.ll_host, cxt->hostname, sizeof(ll.ll_host));
+
+	if (write_all(fd, (char *)&ll, sizeof(ll)))
+		warn(_("write lastlog failed"));
+
+	close(fd);
+}
+
 /* encapsulate stupid "void **" pam_get_item() API */
 static int loginpam_get_username(pam_handle_t * pamh, char **name)
 {
@@ -387,7 +435,7 @@ int main(int argc, char **argv)
 	register int ch;
 	register char *p;
 	int fflag, hflag, pflag, cnt;
-	int quietlog, passwd_req;
+	int passwd_req;
 	char *domain;
 	char tbuf[PATH_MAX + 2];
 	char *termenv;
@@ -712,12 +760,12 @@ int main(int argc, char **argv)
 		   have a libc in which snprintf is the same as sprintf */
 		if (strlen(pwd->pw_dir) + sizeof(_PATH_HUSHLOGIN) + 2 >
 		    PATH_MAX)
-			quietlog = 0;
+			cxt.quiet = 0;
 		else {
 			sprintf(tmpstr, "%s/%s", pwd->pw_dir, _PATH_HUSHLOGIN);
 			setregid(-1, pwd->pw_gid);
 			setreuid(0, pwd->pw_uid);
-			quietlog = (effective_access(tmpstr, O_RDONLY) == 0);
+			cxt.quiet = (effective_access(tmpstr, O_RDONLY) == 0);
 			setuid(0);	/* setreuid doesn't do it alone! */
 			setreuid(ruid, 0);
 			setregid(-1, egid);
@@ -816,7 +864,7 @@ int main(int argc, char **argv)
 	}
 
 	log_audit(&cxt, pwd, 1);
-	dolastlog(&cxt, quietlog);
+	log_lastlog(&cxt);
 
 	if (fchown(0, pwd->pw_uid,
 		   (gr = getgrnam(TTYGRPNAME)) ? gr->gr_gid : pwd->pw_gid))
@@ -921,7 +969,7 @@ int main(int argc, char **argv)
 			       pwd->pw_name);
 	}
 
-	if (!quietlog) {
+	if (!cxt.quiet) {
 		motd();
 
 #ifdef LOGIN_STAT_MAIL
@@ -1136,49 +1184,6 @@ void sigint(int sig __attribute__ ((__unused__)))
 	longjmp(motdinterrupt, 1);
 }
 
-void dolastlog(struct login_context *cxt, int quiet)
-{
-	struct lastlog ll;
-	int fd;
-
-	if ((fd = open(_PATH_LASTLOG, O_RDWR, 0)) >= 0) {
-		lseek(fd, (off_t) pwd->pw_uid * sizeof(ll), SEEK_SET);
-		if (!quiet) {
-			if (read(fd, (char *)&ll, sizeof(ll)) == sizeof(ll) &&
-			    ll.ll_time != 0) {
-				time_t ll_time = (time_t) ll.ll_time;
-
-				printf(_("Last login: %.*s "),
-				       24 - 5, ctime(&ll_time));
-
-				if (*ll.ll_host != '\0')
-					printf(_("from %.*s\n"),
-					       (int)sizeof(ll.ll_host),
-					       ll.ll_host);
-				else
-					printf(_("on %.*s\n"),
-					       (int)sizeof(ll.ll_line),
-					       ll.ll_line);
-			}
-			lseek(fd, (off_t) pwd->pw_uid * sizeof(ll), SEEK_SET);
-		}
-		memset((char *)&ll, 0, sizeof(ll));
-
-		{
-			time_t t;
-			time(&t);
-			ll.ll_time = t;	/* ll_time is always 32bit */
-		}
-
-		xstrncpy(ll.ll_line, cxt->tty_name, sizeof(ll.ll_line));
-		if (cxt->hostname)
-			xstrncpy(ll.ll_host, cxt->hostname, sizeof(ll.ll_host));
-
-		if (write(fd, (char *)&ll, sizeof(ll)) < 0)
-			warn(_("write lastlog failed"));
-		close(fd);
-	}
-}
 
 /* Should not be called from PAM code... */
 void sleepexit(int eval)
-- 
1.7.6.4
