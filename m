Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 13/49] login: add pid to login_context struct
Date: Mon, 17 Oct 2011 13:14:52 +0200
Message-Id: <1318850128-23458-14-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index c4ef30a..9299e5c 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -98,6 +98,8 @@ struct login_context {
 
 	char		*hostname;
 	char		hostaddress[16];
+
+	pid_t		pid;
 };
 
 /*
@@ -110,7 +112,6 @@ struct passwd *pwd;
 
 static struct passwd pwdcopy;
 static char *username;
-static pid_t pid;
 
 static void timedout(int);
 static void sigint(int);
@@ -278,7 +279,7 @@ logbtmp(struct login_context *cxt, const char *username)
 #endif
 
 	ut.ut_type = LOGIN_PROCESS;	/* XXX doesn't matter */
-	ut.ut_pid = pid;
+	ut.ut_pid = cxt->pid;
 	if (cxt->hostname) {
 		xstrncpy(ut.ut_host, cxt->hostname, sizeof(ut.ut_host));
 		if (cxt->hostaddress && *cxt->hostaddress)
@@ -391,10 +392,10 @@ int main(int argc, char **argv)
 	pam_handle_t *pamh = NULL;
 	struct pam_conv conv = { misc_conv, NULL };
 	struct sigaction sa, oldsa_hup, oldsa_term;
-	struct login_context cxt;
 
-	memset(&cxt, 0, sizeof(cxt));
-	pid = getpid();
+	struct login_context cxt = {
+		.pid = getpid()
+	};
 
 	signal(SIGALRM, timedout);
 	siginterrupt(SIGALRM, 1);	/* we have to interrupt syscalls like ioclt() */
@@ -737,7 +738,7 @@ int main(int argc, char **argv)
 		   Michael Riepe <michael@stud.uni-hannover.de>
 		 */
 		while ((utp = getutent()))
-			if (utp->ut_pid == pid
+			if (utp->ut_pid == cxt.pid
 			    && utp->ut_type >= INIT_PROCESS
 			    && utp->ut_type <= DEAD_PROCESS)
 				break;
@@ -776,7 +777,7 @@ int main(int argc, char **argv)
 		}
 #endif
 		ut.ut_type = USER_PROCESS;
-		ut.ut_pid = pid;
+		ut.ut_pid = cxt.pid;
 		if (cxt.hostname) {
 			xstrncpy(ut.ut_host, cxt.hostname, sizeof(ut.ut_host));
 			if (cxt.hostaddress[0])
-- 
1.7.6.4
