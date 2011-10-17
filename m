Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 19/49] login: tty chown.chmod refactoring
Date: Mon, 17 Oct 2011 13:14:58 +0200
Message-Id: <1318850128-23458-20-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |   58 +++++++++++++++++++++++++++++++++-----------------
 1 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index 8b724ec..3a74abe 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -158,6 +158,43 @@ static void open_tty(const char *tty)
 		close(fd);
 }
 
+#define chown_err(_what, _uid, _gid) \
+		syslog(LOG_ERR, _("chown (%s, %lu, %lu) failed: %m"), \
+			(_what), (unsigned long) (_uid), (unsigned long) (_gid))
+
+#define chmod_err(_what, _mode) \
+		syslog(LOG_ERR, _("chmod (%s, %u) failed: %m"), (_what), (_mode))
+
+static void chown_tty(struct login_context *cxt)
+{
+	struct group *gr;
+	uid_t uid = cxt->pwd->pw_uid;
+	gid_t gid = cxt->pwd->pw_gid;
+
+	gr = getgrnam(TTYGRPNAME);
+	if (gr)
+		gid = gr->gr_gid;
+
+	if (fchown(0, uid, gid))				/* tty */
+		chown_err(cxt->tty_name, uid, gid);
+	if (fchmod(0, TTY_MODE))
+		chmod_err(cxt->tty_name, TTY_MODE);
+
+#ifdef LOGIN_CHOWN_VCS
+	if (is_consoletty(0)) {
+		if (chown(cxt->vcs, uid, gid))			/* vcs */
+			chown_err(cxt->vcs, uid, gid);
+		if (chmod(cxt->vcs, TTY_MODE))
+			chmod_err(cxt->vcs, TTY_MODE);
+
+		if (chown(cxt->vcsa, uid, gid))			/* vcsa */
+			chown_err(cxt->vcsa, uid, gid);
+		if (chmod(cxt->vcsa, TTY_MODE))
+			chmod_err(cxt->vcsa, TTY_MODE);
+	}
+#endif
+}
+
 /*
  * Reads the currect terminal path and initialize cxt->tty_* variables.
  */
@@ -541,7 +578,6 @@ int main(int argc, char **argv)
 {
 	extern int optind;
 	extern char *optarg, **environ;
-	struct group *gr;
 	register int ch;
 	register char *p;
 	int fflag, hflag, pflag, cnt;
@@ -872,26 +908,8 @@ int main(int argc, char **argv)
 	log_audit(&cxt, 1);
 	log_lastlog(&cxt);
 
-	if (fchown(0, pwd->pw_uid,
-		   (gr = getgrnam(TTYGRPNAME)) ? gr->gr_gid : pwd->pw_gid))
-		warn(_("change terminal owner failed"));
-
-	fchmod(0, TTY_MODE);
-
-#ifdef LOGIN_CHOWN_VCS
-	/* if tty is one of the VC's then change owner and mode of the
-	   special /dev/vcs devices as well */
-	if (is_consoletty(0)) {
-
-		if (chown(vcsn, pwd->pw_uid, (gr ? gr->gr_gid : pwd->pw_gid)))
-			warn(_("change terminal owner failed"));
-		if (chown(vcsan, pwd->pw_uid, (gr ? gr->gr_gid : pwd->pw_gid)))
-			warn(_("change terminal owner failed"));
+	chown_tty(&cxt);
 
-		chmod(vcsn, TTY_MODE);
-		chmod(vcsan, TTY_MODE);
-	}
-#endif
 
 	if (setgid(pwd->pw_gid) < 0 && pwd->pw_gid) {
 		syslog(LOG_ALERT, _("setgid() failed"));
-- 
1.7.6.4
