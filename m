Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 12/49] login: add hostname to login_context struct
Date: Mon, 17 Oct 2011 13:14:51 +0200
Message-Id: <1318850128-23458-13-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |   71 ++++++++++++++++++++++++++------------------------
 1 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index e1bf81c..c4ef30a 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -95,6 +95,9 @@ struct login_context {
 	char		vcsn[VCS_PATH_MAX];	/* virtual console name */
 	char		vcsan[VCS_PATH_MAX];
 #endif
+
+	char		*hostname;
+	char		hostaddress[16];
 };
 
 /*
@@ -106,8 +109,6 @@ int timeout = LOGIN_TIMEOUT;
 struct passwd *pwd;
 
 static struct passwd pwdcopy;
-char hostaddress[16];		/* used in checktty.c */
-char *hostname;			/* idem */
 static char *username;
 static pid_t pid;
 
@@ -249,7 +250,7 @@ static int is_consoletty(int fd)
  * The most common login failure is to give password instead of username.
  */
 static void
-logbtmp(const char *line, const char *username, const char *hostname)
+logbtmp(struct login_context *cxt, const char *username)
 {
 	struct utmp ut;
 	struct timeval tv;
@@ -259,8 +260,10 @@ logbtmp(const char *line, const char *username, const char *hostname)
 	strncpy(ut.ut_user, username ? username : "(unknown)",
 		sizeof(ut.ut_user));
 
-	strncpy(ut.ut_id, line + 3, sizeof(ut.ut_id));
-	xstrncpy(ut.ut_line, line, sizeof(ut.ut_line));
+	if (cxt->tty_number)
+		strncpy(ut.ut_id, cxt->tty_number, sizeof(ut.ut_id));
+	if (cxt->tty_name)
+		xstrncpy(ut.ut_line, cxt->tty_name, sizeof(ut.ut_line));
 
 #if defined(_HAVE_UT_TV)	/* in <utmpbits.h> included by <utmp.h> */
 	gettimeofday(&tv, NULL);
@@ -276,10 +279,10 @@ logbtmp(const char *line, const char *username, const char *hostname)
 
 	ut.ut_type = LOGIN_PROCESS;	/* XXX doesn't matter */
 	ut.ut_pid = pid;
-	if (hostname) {
-		xstrncpy(ut.ut_host, hostname, sizeof(ut.ut_host));
-		if (hostaddress[0])
-			memcpy(&ut.ut_addr_v6, hostaddress,
+	if (cxt->hostname) {
+		xstrncpy(ut.ut_host, cxt->hostname, sizeof(ut.ut_host));
+		if (cxt->hostaddress && *cxt->hostaddress)
+			memcpy(&ut.ut_addr_v6, cxt->hostaddress,
 			       sizeof(ut.ut_addr_v6));
 	}
 #if HAVE_UPDWTMP		/* bad luck for ancient systems */
@@ -415,7 +418,7 @@ int main(int argc, char **argv)
 	gethostname(tbuf, sizeof(tbuf));
 	domain = strchr(tbuf, '.');
 
-	username = hostname = NULL;
+	username = NULL;
 	fflag = hflag = pflag = 0;
 	passwd_req = 1;
 
@@ -436,29 +439,29 @@ int main(int argc, char **argv)
 			    strcasecmp(p, domain) == 0)
 				*p = 0;
 
-			hostname = strdup(optarg);	/* strdup: Ambrose C. Li */
+			cxt.hostname = strdup(optarg);
 			{
 				struct addrinfo hints, *info = NULL;
 
 				memset(&hints, 0, sizeof(hints));
 				hints.ai_flags = AI_ADDRCONFIG;
 
-				hostaddress[0] = 0;
+				cxt.hostaddress[0] = 0;
 
-				if (getaddrinfo(hostname, NULL, &hints, &info)
+				if (getaddrinfo(cxt.hostname, NULL, &hints, &info)
 				    == 0 && info) {
 					if (info->ai_family == AF_INET) {
 						struct sockaddr_in *sa =
 						    (struct sockaddr_in *)info->
 						    ai_addr;
-						memcpy(hostaddress,
+						memcpy(cxt.hostaddress,
 						       &(sa->sin_addr),
 						       sizeof(sa->sin_addr));
 					} else if (info->ai_family == AF_INET6) {
 						struct sockaddr_in6 *sa =
 						    (struct sockaddr_in6 *)
 						    info->ai_addr;
-						memcpy(hostaddress,
+						memcpy(cxt.hostaddress,
 						       &(sa->sin6_addr),
 						       sizeof(sa->sin6_addr));
 					}
@@ -516,7 +519,7 @@ int main(int argc, char **argv)
 	/* hostname & tty are either set to NULL or their correct values,
 	 * depending on how much we know
 	 */
-	retcode = pam_set_item(pamh, PAM_RHOST, hostname);
+	retcode = pam_set_item(pamh, PAM_RHOST, cxt.hostname);
 	if (is_pam_failure(retcode))
 		loginpam_err(pamh, retcode);
 
@@ -568,10 +571,10 @@ int main(int argc, char **argv)
 
 			syslog(LOG_NOTICE,
 			       _("FAILED LOGIN %d FROM %s FOR %s, %s"),
-			       failcount, hostname, username, pam_strerror(pamh,
+			       failcount, cxt.hostname, username, pam_strerror(pamh,
 									   retcode));
-			logbtmp(cxt.tty_name, username, hostname);
-			logaudit(cxt.tty_name, username, hostname, NULL, 0);
+			logbtmp(&cxt, username);
+			logaudit(cxt.tty_name, username, cxt.hostname, NULL, 0);
 
 			fprintf(stderr, _("Login incorrect\n\n"));
 			pam_set_item(pamh, PAM_USER, NULL);
@@ -585,16 +588,16 @@ int main(int argc, char **argv)
 				syslog(LOG_NOTICE,
 				       _
 				       ("TOO MANY LOGIN TRIES (%d) FROM %s FOR "
-					"%s, %s"), failcount, hostname,
+					"%s, %s"), failcount, cxt.hostname,
 				       username, pam_strerror(pamh, retcode));
 			else
 				syslog(LOG_NOTICE,
 				       _
 				       ("FAILED LOGIN SESSION FROM %s FOR %s, %s"),
-				       hostname, username, pam_strerror(pamh,
+				       cxt.hostname, username, pam_strerror(pamh,
 									retcode));
-			logbtmp(cxt.tty_name, username, hostname);
-			logaudit(cxt.tty_name, username, hostname, NULL, 0);
+			logbtmp(&cxt, username);
+			logaudit(cxt.tty_name, username, cxt.hostname, NULL, 0);
 
 			fprintf(stderr, _("\nLogin incorrect\n"));
 			pam_end(pamh, retcode);
@@ -774,10 +777,10 @@ int main(int argc, char **argv)
 #endif
 		ut.ut_type = USER_PROCESS;
 		ut.ut_pid = pid;
-		if (hostname) {
-			xstrncpy(ut.ut_host, hostname, sizeof(ut.ut_host));
-			if (hostaddress[0])
-				memcpy(&ut.ut_addr_v6, hostaddress,
+		if (cxt.hostname) {
+			xstrncpy(ut.ut_host, cxt.hostname, sizeof(ut.ut_host));
+			if (cxt.hostaddress[0])
+				memcpy(&ut.ut_addr_v6, cxt.hostaddress,
 				       sizeof(ut.ut_addr_v6));
 		}
 
@@ -808,7 +811,7 @@ int main(int argc, char **argv)
 #endif
 	}
 
-	logaudit(cxt.tty_name, username, hostname, pwd, 1);
+	logaudit(cxt.tty_name, username, cxt.hostname, pwd, 1);
 	dolastlog(&cxt, quietlog);
 
 	if (fchown(0, pwd->pw_uid,
@@ -900,15 +903,15 @@ int main(int argc, char **argv)
 	   -steve philp (sphilp@mail.alliance.net) */
 
 	if (pwd->pw_uid == 0) {
-		if (hostname)
+		if (cxt.hostname)
 			syslog(LOG_NOTICE, _("ROOT LOGIN ON %s FROM %s"),
-			       cxt.tty_name, hostname);
+			       cxt.tty_name, cxt.hostname);
 		else
 			syslog(LOG_NOTICE, _("ROOT LOGIN ON %s"), cxt.tty_name);
 	} else {
-		if (hostname)
+		if (cxt.hostname)
 			syslog(LOG_INFO, _("LOGIN ON %s BY %s FROM %s"),
-			       cxt.tty_name, pwd->pw_name, hostname);
+			       cxt.tty_name, pwd->pw_name, cxt.hostname);
 		else
 			syslog(LOG_INFO, _("LOGIN ON %s BY %s"), cxt.tty_name,
 			       pwd->pw_name);
@@ -1164,8 +1167,8 @@ void dolastlog(struct login_context *cxt, int quiet)
 		}
 
 		xstrncpy(ll.ll_line, cxt->tty_name, sizeof(ll.ll_line));
-		if (hostname)
-			xstrncpy(ll.ll_host, hostname, sizeof(ll.ll_host));
+		if (cxt->hostname)
+			xstrncpy(ll.ll_host, cxt->hostname, sizeof(ll.ll_host));
 
 		if (write(fd, (char *)&ll, sizeof(ll)) < 0)
 			warn(_("write lastlog failed"));
-- 
1.7.6.4
