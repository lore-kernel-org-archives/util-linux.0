Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 11/49] login: add struct login_context, consolidate tty code
Date: Mon, 17 Oct 2011 13:14:50 +0200
Message-Id: <1318850128-23458-12-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

 - move all tty_* variables to struct login_context

 - move all tty initialization code to init_tty()

 - LOG_ERR on failed tty ch{mod,own}
   [based on SUSE pam_login - note that we don't write any this error to stderr]

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |  228 +++++++++++++++++++++++++++------------------------
 1 files changed, 122 insertions(+), 106 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index 9528908..e1bf81c 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -81,6 +81,21 @@
 #endif
 
 #define	TTYGRPNAME	"tty"	/* name of group to own ttys */
+#define VCS_PATH_MAX	64
+
+/*
+ * Login control struct
+ */
+struct login_context {
+	const char	*tty_path;	/* ttyname() return value */
+	const char	*tty_name;	/* tty_path without /dev prefix */
+	const char	*tty_number;	/* end of the tty_path */
+
+#ifdef LOGIN_CHOWN_VCS
+	char		vcsn[VCS_PATH_MAX];	/* virtual console name */
+	char		vcsan[VCS_PATH_MAX];
+#endif
+};
 
 /*
  * This bounds the time given to login.  Not a define so it can
@@ -93,23 +108,26 @@ struct passwd *pwd;
 static struct passwd pwdcopy;
 char hostaddress[16];		/* used in checktty.c */
 char *hostname;			/* idem */
-static char *username, *tty_name, *tty_number;
+static char *username;
 static pid_t pid;
 
 static void timedout(int);
 static void sigint(int);
 static void motd(void);
-static void dolastlog(int quiet);
-
-/* Nice and simple code provided by Linus Torvalds 16-Feb-93 */
-/* Nonblocking stuff by Maciej W. Rozycki, macro@ds2.pg.gda.pl, 1999.
-   He writes: "Login performs open() on a tty in a blocking mode.
-   In some cases it may make login wait in open() for carrier infinitely,
-   for example if the line is a simplistic case of a three-wire serial
-   connection. I believe login should open the line in the non-blocking mode
-   leaving the decision to make a connection to getty (where it actually
-   belongs). */
-static void opentty(const char *tty)
+static void dolastlog(struct login_context *cxt, int quiet);
+
+/*
+ * Nice and simple code provided by Linus Torvalds 16-Feb-93
+ * Nonblocking stuff by Maciej W. Rozycki, macro@ds2.pg.gda.pl, 1999.
+ *
+ * He writes: "Login performs open() on a tty in a blocking mode.
+ * In some cases it may make login wait in open() for carrier infinitely,
+ * for example if the line is a simplistic case of a three-wire serial
+ * connection. I believe login should open the line in the non-blocking mode
+ * leaving the decision to make a connection to getty (where it actually
+ * belongs).
+ */
+static void open_tty(const char *tty)
 {
 	int i, fd, flags;
 
@@ -138,30 +156,81 @@ static void opentty(const char *tty)
 		close(fd);
 }
 
-/* In case login is suid it was possible to use a hardlink as stdin
-   and exploit races for a local root exploit. (Wojciech Purczynski). */
-/* More precisely, the problem is  ttyn := ttyname(0); ...; chown(ttyn);
-   here ttyname() might return "/tmp/x", a hardlink to a pseudotty. */
-/* All of this is a problem only when login is suid, which it isnt. */
-static void check_ttyname(char *ttyn)
+/*
+ * Reads the currect terminal path and initialize cxt->tty_* variables.
+ */
+static void init_tty(struct login_context *cxt)
 {
-	struct stat statbuf;
+	const char *p;
+	struct stat st;
+	struct termios tt, ttt;
+
+	cxt->tty_path = ttyname(0);		/* libc calls istty() here */
 
-	if (ttyn == NULL
-	    || *ttyn == '\0'
-	    || lstat(ttyn, &statbuf)
-	    || !S_ISCHR(statbuf.st_mode)
-	    || (statbuf.st_nlink > 1 && strncmp(ttyn, "/dev/", 5))
-	    || (access(ttyn, R_OK | W_OK) != 0)) {
+	/*
+	 * In case login is suid it was possible to use a hardlink as stdin
+	 * and exploit races for a local root exploit. (Wojciech Purczynski).
+	 *
+	 * More precisely, the problem is  ttyn := ttyname(0); ...; chown(ttyn);
+	 * here ttyname() might return "/tmp/x", a hardlink to a pseudotty.
+	 * All of this is a problem only when login is suid, which it isnt.
+	 */
+	if (!cxt->tty_path || !*cxt->tty_path ||
+	    lstat(cxt->tty_path, &st) != 0 || !S_ISCHR(st.st_mode) ||
+	    (st.st_nlink > 1 && strncmp(cxt->tty_path, "/dev/", 5)) ||
+	    access(cxt->tty_path, R_OK | W_OK) != 0) {
 
 		syslog(LOG_ERR, _("FATAL: bad tty"));
 		sleepexit(EXIT_FAILURE);
 	}
+
+	if (strncmp(cxt->tty_path, "/dev/", 5) == 0)
+		cxt->tty_name = cxt->tty_path + 5;
+	else
+		cxt->tty_name = cxt->tty_path;
+
+	for (p = cxt->tty_name; p && *p; p++) {
+		if (isdigit(*p)) {
+			cxt->tty_number = p;
+			break;
+		}
+	}
+
+#ifdef LOGIN_CHOWN_VCS
+	/* find names of Virtual Console devices, for later mode change */
+	snprintf(cxt->vcsn, sizeof(cxt->vcsn), "/dev/vcs%s", cxt->tty_number);
+	snprintf(cxt->vcsan, sizeof(cxt->vcsan), "/dev/vcsa%s", cxt->tty_number);
+#endif
+
+	tcgetattr(0, &tt);
+	ttt = tt;
+	ttt.c_cflag &= ~HUPCL;
+
+	if ((fchown(0, 0, 0) || fchmod(0, TTY_MODE)) && errno != EROFS) {
+
+		syslog(LOG_ERR, _("FATAL: %s: change permissions failed: %m"),
+				cxt->tty_path);
+		sleepexit(EXIT_FAILURE);
+	}
+
+	/* Kill processes left on this tty */
+	tcsetattr(0, TCSAFLUSH, &ttt);
+
+	signal(SIGHUP, SIG_IGN);	/* so vhangup() wont kill us */
+	vhangup();
+	signal(SIGHUP, SIG_DFL);
+
+	/* open stdin,stdout,stderr to the tty */
+	open_tty(cxt->tty_path);
+
+	/* restore tty modes */
+	tcsetattr(0, TCSAFLUSH, &tt);
 }
 
+
 #ifdef LOGIN_CHOWN_VCS
 /* true if the filedescriptor fd is a console tty, very Linux specific */
-static int consoletty(int fd)
+static int is_consoletty(int fd)
 {
 	struct stat stb;
 
@@ -309,7 +378,7 @@ int main(int argc, char **argv)
 	register char *p;
 	int fflag, hflag, pflag, cnt;
 	int quietlog, passwd_req;
-	char *domain, *ttyn;
+	char *domain;
 	char tbuf[PATH_MAX + 2];
 	char *termenv;
 	char *childArgv[10];
@@ -319,10 +388,9 @@ int main(int argc, char **argv)
 	pam_handle_t *pamh = NULL;
 	struct pam_conv conv = { misc_conv, NULL };
 	struct sigaction sa, oldsa_hup, oldsa_term;
-#ifdef LOGIN_CHOWN_VCS
-	char vcsn[20], vcsan[20];
-#endif
+	struct login_context cxt;
 
+	memset(&cxt, 0, sizeof(cxt));
 	pid = getpid();
 
 	signal(SIGALRM, timedout);
@@ -347,7 +415,7 @@ int main(int argc, char **argv)
 	gethostname(tbuf, sizeof(tbuf));
 	domain = strchr(tbuf, '.');
 
-	username = tty_name = hostname = NULL;
+	username = hostname = NULL;
 	fflag = hflag = pflag = 0;
 	passwd_req = 1;
 
@@ -424,64 +492,12 @@ int main(int argc, char **argv)
 	for (cnt = getdtablesize(); cnt > 2; cnt--)
 		close(cnt);
 
-	/* note that libc checks that the file descriptor is a terminal, so we don't
-	 * have to call isatty() here */
-	ttyn = ttyname(0);
-	check_ttyname(ttyn);
-
-	if (strncmp(ttyn, "/dev/", 5) == 0)
-		tty_name = ttyn + 5;
-	else
-		tty_name = ttyn;
-
-	if (strncmp(ttyn, "/dev/tty", 8) == 0)
-		tty_number = ttyn + 8;
-	else {
-		char *p = ttyn;
-		while (*p && !isdigit(*p))
-			p++;
-		tty_number = p;
-	}
-
-#ifdef LOGIN_CHOWN_VCS
-	/* find names of Virtual Console devices, for later mode change */
-	snprintf(vcsn, sizeof(vcsn), "/dev/vcs%s", tty_number);
-	snprintf(vcsan, sizeof(vcsan), "/dev/vcsa%s", tty_number);
-#endif
-
-	/* set pgid to pid */
-	setpgrp();
-	/* this means that setsid() will fail */
-
-	{
-		struct termios tt, ttt;
-
-		tcgetattr(0, &tt);
-		ttt = tt;
-		ttt.c_cflag &= ~HUPCL;
-
-		/* These can fail, e.g. with ttyn on a read-only filesystem */
-		if (fchown(0, 0, 0)) {
-			;	/* glibc warn_unused_result */
-		}
-
-		fchmod(0, TTY_MODE);
-
-		/* Kill processes left on this tty */
-		tcsetattr(0, TCSAFLUSH, &ttt);
-		signal(SIGHUP, SIG_IGN);	/* so vhangup() wont kill us */
-		vhangup();
-		signal(SIGHUP, SIG_DFL);
-
-		/* open stdin,stdout,stderr to the tty */
-		opentty(ttyn);
-
-		/* restore tty modes */
-		tcsetattr(0, TCSAFLUSH, &tt);
-	}
+	setpgrp();	 /* set pgid to pid this means that setsid() will fail */
 
 	openlog("login", LOG_ODELAY, LOG_AUTHPRIV);
 
+	init_tty(&cxt);
+
 	/*
 	 * username is initialized to NULL
 	 * and if specified on the command line it is set.
@@ -504,7 +520,7 @@ int main(int argc, char **argv)
 	if (is_pam_failure(retcode))
 		loginpam_err(pamh, retcode);
 
-	retcode = pam_set_item(pamh, PAM_TTY, tty_name);
+	retcode = pam_set_item(pamh, PAM_TTY, cxt.tty_name);
 	if (is_pam_failure(retcode))
 		loginpam_err(pamh, retcode);
 
@@ -554,8 +570,8 @@ int main(int argc, char **argv)
 			       _("FAILED LOGIN %d FROM %s FOR %s, %s"),
 			       failcount, hostname, username, pam_strerror(pamh,
 									   retcode));
-			logbtmp(tty_name, username, hostname);
-			logaudit(tty_name, username, hostname, NULL, 0);
+			logbtmp(cxt.tty_name, username, hostname);
+			logaudit(cxt.tty_name, username, hostname, NULL, 0);
 
 			fprintf(stderr, _("Login incorrect\n\n"));
 			pam_set_item(pamh, PAM_USER, NULL);
@@ -577,8 +593,8 @@ int main(int argc, char **argv)
 				       ("FAILED LOGIN SESSION FROM %s FOR %s, %s"),
 				       hostname, username, pam_strerror(pamh,
 									retcode));
-			logbtmp(tty_name, username, hostname);
-			logaudit(tty_name, username, hostname, NULL, 0);
+			logbtmp(cxt.tty_name, username, hostname);
+			logaudit(cxt.tty_name, username, hostname, NULL, 0);
 
 			fprintf(stderr, _("\nLogin incorrect\n"));
 			pam_end(pamh, retcode);
@@ -728,7 +744,7 @@ int main(int argc, char **argv)
 		if (utp == NULL) {
 			setutent();
 			ut.ut_type = LOGIN_PROCESS;
-			strncpy(ut.ut_line, tty_name, sizeof(ut.ut_line));
+			strncpy(ut.ut_line, cxt.tty_name, sizeof(ut.ut_line));
 			utp = getutline(&ut);
 		}
 
@@ -740,10 +756,10 @@ int main(int argc, char **argv)
 		}
 
 		if (ut.ut_id[0] == 0)
-			strncpy(ut.ut_id, tty_number, sizeof(ut.ut_id));
+			strncpy(ut.ut_id, cxt.tty_number, sizeof(ut.ut_id));
 
 		strncpy(ut.ut_user, username, sizeof(ut.ut_user));
-		xstrncpy(ut.ut_line, tty_name, sizeof(ut.ut_line));
+		xstrncpy(ut.ut_line, cxt.tty_name, sizeof(ut.ut_line));
 #ifdef _HAVE_UT_TV		/* in <utmpbits.h> included by <utmp.h> */
 		gettimeofday(&tv, NULL);
 		ut.ut_tv.tv_sec = tv.tv_sec;
@@ -792,8 +808,8 @@ int main(int argc, char **argv)
 #endif
 	}
 
-	logaudit(tty_name, username, hostname, pwd, 1);
-	dolastlog(quietlog);
+	logaudit(cxt.tty_name, username, hostname, pwd, 1);
+	dolastlog(&cxt, quietlog);
 
 	if (fchown(0, pwd->pw_uid,
 		   (gr = getgrnam(TTYGRPNAME)) ? gr->gr_gid : pwd->pw_gid))
@@ -804,7 +820,7 @@ int main(int argc, char **argv)
 #ifdef LOGIN_CHOWN_VCS
 	/* if tty is one of the VC's then change owner and mode of the
 	   special /dev/vcs devices as well */
-	if (consoletty(0)) {
+	if (is_consoletty(0)) {
 
 		if (chown(vcsn, pwd->pw_uid, (gr ? gr->gr_gid : pwd->pw_gid)))
 			warn(_("change terminal owner failed"));
@@ -876,8 +892,8 @@ int main(int argc, char **argv)
 
 	setproctitle("login", username);
 
-	if (!strncmp(tty_name, "ttyS", 4))
-		syslog(LOG_INFO, _("DIALUP AT %s BY %s"), tty_name,
+	if (!strncmp(cxt.tty_name, "ttyS", 4))
+		syslog(LOG_INFO, _("DIALUP AT %s BY %s"), cxt.tty_name,
 		       pwd->pw_name);
 
 	/* allow tracking of good logins.
@@ -886,15 +902,15 @@ int main(int argc, char **argv)
 	if (pwd->pw_uid == 0) {
 		if (hostname)
 			syslog(LOG_NOTICE, _("ROOT LOGIN ON %s FROM %s"),
-			       tty_name, hostname);
+			       cxt.tty_name, hostname);
 		else
-			syslog(LOG_NOTICE, _("ROOT LOGIN ON %s"), tty_name);
+			syslog(LOG_NOTICE, _("ROOT LOGIN ON %s"), cxt.tty_name);
 	} else {
 		if (hostname)
 			syslog(LOG_INFO, _("LOGIN ON %s BY %s FROM %s"),
-			       tty_name, pwd->pw_name, hostname);
+			       cxt.tty_name, pwd->pw_name, hostname);
 		else
-			syslog(LOG_INFO, _("LOGIN ON %s BY %s"), tty_name,
+			syslog(LOG_INFO, _("LOGIN ON %s BY %s"), cxt.tty_name,
 			       pwd->pw_name);
 	}
 
@@ -999,7 +1015,7 @@ int main(int argc, char **argv)
 	setsid();
 
 	/* make sure we have a controlling tty */
-	opentty(ttyn);
+	open_tty(cxt.tty_path);
 	openlog("login", LOG_ODELAY, LOG_AUTHPRIV);	/* reopen */
 
 	/*
@@ -1113,7 +1129,7 @@ void sigint(int sig __attribute__ ((__unused__)))
 	longjmp(motdinterrupt, 1);
 }
 
-void dolastlog(int quiet)
+void dolastlog(struct login_context *cxt, int quiet)
 {
 	struct lastlog ll;
 	int fd;
@@ -1147,7 +1163,7 @@ void dolastlog(int quiet)
 			ll.ll_time = t;	/* ll_time is always 32bit */
 		}
 
-		xstrncpy(ll.ll_line, tty_name, sizeof(ll.ll_line));
+		xstrncpy(ll.ll_line, cxt->tty_name, sizeof(ll.ll_line));
 		if (hostname)
 			xstrncpy(ll.ll_host, hostname, sizeof(ll.ll_host));
 
-- 
1.7.6.4
