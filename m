Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 42/49] login: use TTYPERM from login.defs
Date: Mon, 17 Oct 2011 13:15:21 +0200
Message-Id: <1318850128-23458-43-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.1 |    6 ++++++
 login-utils/login.c |   18 +++++++++++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/login-utils/login.1 b/login-utils/login.1
index 8cb2450..1d3ae1a 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -144,6 +144,12 @@ Max time in seconds for login. The default value is 60.
 Delay in seconds before being allowed another attempt after a login failure.
 The default value is 5.
 .RE
+.PP
+\fBTTYPERM\fR (string)
+.RS 4
+The terminal permissions. The default value is 0600.
+.RE
+
 .SH FILES
 .nf
 .I /var/run/utmp
diff --git a/login-utils/login.c b/login-utils/login.c
index a70ce56..857240d 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -92,6 +92,7 @@ struct login_context {
 	const char	*tty_path;	/* ttyname() return value */
 	const char	*tty_name;	/* tty_path without /dev prefix */
 	const char	*tty_number;	/* end of the tty_path */
+	mode_t		tty_mode;	/* chmod() mode */
 
 	char		*username;	/* from command line or PAM */
 
@@ -273,20 +274,20 @@ static void chown_tty(struct login_context *cxt)
 
 	if (fchown(0, uid, gid))				/* tty */
 		chown_err(cxt->tty_name, uid, gid);
-	if (fchmod(0, TTY_MODE))
-		chmod_err(cxt->tty_name, TTY_MODE);
+	if (fchmod(0, cxt->tty_mode))
+		chmod_err(cxt->tty_name, cxt->tty_mode);
 
 #ifdef LOGIN_CHOWN_VCS
 	if (is_consoletty(0)) {
 		if (chown(cxt->vcs, uid, gid))			/* vcs */
 			chown_err(cxt->vcs, uid, gid);
-		if (chmod(cxt->vcs, TTY_MODE))
-			chmod_err(cxt->vcs, TTY_MODE);
+		if (chmod(cxt->vcs, cxt->tty_mode))
+			chmod_err(cxt->vcs, cxt->tty_mode);
 
 		if (chown(cxt->vcsa, uid, gid))			/* vcsa */
 			chown_err(cxt->vcsa, uid, gid);
-		if (chmod(cxt->vcsa, TTY_MODE))
-			chmod_err(cxt->vcsa, TTY_MODE);
+		if (chmod(cxt->vcsa, cxt->tty_mode))
+			chmod_err(cxt->vcsa, cxt->tty_mode);
 	}
 #endif
 }
@@ -300,6 +301,8 @@ static void init_tty(struct login_context *cxt)
 	struct stat st;
 	struct termios tt, ttt;
 
+	cxt->tty_mode = (mode_t) getlogindefs_num("TTYPERM", TTY_MODE);
+
 	cxt->tty_path = ttyname(0);		/* libc calls istty() here */
 
 	/*
@@ -341,7 +344,7 @@ static void init_tty(struct login_context *cxt)
 	ttt = tt;
 	ttt.c_cflag &= ~HUPCL;
 
-	if ((fchown(0, 0, 0) || fchmod(0, TTY_MODE)) && errno != EROFS) {
+	if ((fchown(0, 0, 0) || fchmod(0, cxt->tty_mode)) && errno != EROFS) {
 
 		syslog(LOG_ERR, _("FATAL: %s: change permissions failed: %m"),
 				cxt->tty_path);
@@ -1101,6 +1104,7 @@ int main(int argc, char **argv)
 	struct passwd *pwd = NULL, _pwd;
 
 	struct login_context cxt = {
+		.tty_mode = TTY_MODE,		/* tty chmod() */
 		.pid = getpid(),		/* PID */
 		.conv = { misc_conv, NULL }	/* PAM conversation function */
 	};
-- 
1.7.6.4
