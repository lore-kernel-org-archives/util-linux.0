Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:52544 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757056AbcLAIwS (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Dec 2016 03:52:18 -0500
Received: from tenfore.ga-group.nl ([217.186.11.144]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M82zV-1cyIxV12qv-00vgHR for <util-linux@vger.kernel.org>; Thu, 01 Dec 2016
 09:52:16 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 08/11] login-utils: switch to utmpx.h
Date: Thu,  1 Dec 2016 09:52:11 +0100
Message-Id: <1480582332-17407-9-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
References: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Now the build will fail on many non-Linux systems because
utmpx.h is available everywhere but we still use non-POSIX
features. We'll fix this next commit.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac            | 22 +++++++++++-----------
 login-utils/last.c      | 32 +++++++++++++++++---------------
 login-utils/login.c     | 30 +++++++++++++++---------------
 login-utils/lslogins.c  | 26 +++++++++++++-------------
 login-utils/su-common.c |  6 +++---
 login-utils/utmpdump.c  | 10 +++++-----
 term-utils/agetty.c     | 26 +++++++++++++-------------
 term-utils/wall.c       |  8 ++++----
 term-utils/write.c      | 22 +++++++++++-----------
 9 files changed, 92 insertions(+), 90 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5917126..bfcd218 100644
--- a/configure.ac
+++ b/configure.ac
@@ -257,7 +257,7 @@ AC_CHECK_HEADERS([ \
 	sys/un.h \
 	unistd.h \
 	shadow.h \
-	utmp.h \
+	utmpx.h \
 ])
 
 AC_CHECK_HEADERS([linux/gsmmux.h ], [], [],
@@ -295,7 +295,7 @@ have_security_pam_misc_h=$ac_cv_header_security_pam_misc_h
 have_security_openpam_h=$ac_cv_header_security_openpam_h
 have_shadow_h=$ac_cv_header_shadow_h
 have_sys_signalfd_h=$ac_cv_header_sys_signalfd_h
-have_utmp_h=$ac_cv_header_utmp_h
+have_utmpx_h=$ac_cv_header_utmpx_h
 
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
 #include <time.h>
@@ -1243,7 +1243,7 @@ AC_ARG_ENABLE([agetty],
   [], [UL_DEFAULT_ENABLE([agetty], [check])]
 )
 UL_BUILD_INIT([agetty])
-UL_REQUIRES_HAVE([agetty], [utmp_h], [utmp.h header])
+UL_REQUIRES_HAVE([agetty], [utmpx_h], [utmpx.h header])
 AM_CONDITIONAL([BUILD_AGETTY], [test "x$build_agetty" = xyes])
 AS_IF([test "x$have_futimens" = xyes -a "x$have_inotify_init1" = xyes ], [
   AC_DEFINE([AGETTY_RELOAD], [1], [Enable agetty --reload feature])
@@ -1364,7 +1364,7 @@ AC_ARG_ENABLE([lslogins],
 UL_BUILD_INIT([lslogins])
 UL_REQUIRES_BUILD([lslogins], [libsmartcols])
 UL_REQUIRES_HAVE([lslogins], [shadow_h], [shadow.h header])
-UL_REQUIRES_HAVE([lslogins], [utmp_h], [utmp.h header])
+UL_REQUIRES_HAVE([lslogins], [utmpx_h], [utmpx.h header])
 AM_CONDITIONAL([BUILD_LSLOGINS], [test "x$build_lslogins" = xyes])
 
 
@@ -1614,7 +1614,7 @@ AC_ARG_ENABLE([last],
   [], [UL_DEFAULT_ENABLE([last], [check])]
 )
 UL_BUILD_INIT([last])
-UL_REQUIRES_HAVE([last], [utmp_h], [utmp.h header])
+UL_REQUIRES_HAVE([last], [utmpx_h], [utmpx.h header])
 AM_CONDITIONAL([BUILD_LAST], [test "x$build_last" = xyes])
 
 
@@ -1623,7 +1623,7 @@ AC_ARG_ENABLE([utmpdump],
   [], [UL_DEFAULT_ENABLE([utmpdump], [check])]
 )
 UL_BUILD_INIT([utmpdump])
-UL_REQUIRES_HAVE([utmpdump], [utmp_h], [utmp.h header])
+UL_REQUIRES_HAVE([utmpdump], [utmpx_h], [utmpx.h header])
 AM_CONDITIONAL([BUILD_UTMPDUMP], [test "x$build_utmpdump" = xyes])
 
 
@@ -1742,7 +1742,7 @@ AC_ARG_ENABLE([login],
 UL_BUILD_INIT([login])
 UL_REQUIRES_HAVE([login], [security_pam_appl_h], [PAM header file])
 UL_REQUIRES_HAVE([login], [security_pam_misc_h, security_openpam_h], [PAM conversation functions])
-UL_REQUIRES_HAVE([login], [utmp_h], [utmp.h header])
+UL_REQUIRES_HAVE([login], [utmpx_h], [utmpx.h header])
 AM_CONDITIONAL([BUILD_LOGIN], [test "x$build_login" = xyes])
 
 AC_ARG_ENABLE([login-chown-vcs],
@@ -1787,7 +1787,7 @@ AC_ARG_ENABLE([su],
 )
 UL_BUILD_INIT([su])
 UL_REQUIRES_HAVE([su], [security_pam_appl_h], [PAM header file])
-UL_REQUIRES_HAVE([su], [utmp_h], [utmp.h header])
+UL_REQUIRES_HAVE([su], [utmpx_h], [utmpx.h header])
 AM_CONDITIONAL([BUILD_SU], [test "x$build_su" = xyes])
 
 
@@ -1797,7 +1797,7 @@ AC_ARG_ENABLE([runuser],
 )
 UL_BUILD_INIT([runuser])
 UL_REQUIRES_HAVE([runuser], [security_pam_appl_h], [PAM header file])
-UL_REQUIRES_HAVE([runuser], [utmp_h], [utmp.h header])
+UL_REQUIRES_HAVE([runuser], [utmpx_h], [utmpx.h header])
 AM_CONDITIONAL([BUILD_RUNUSER], [test "x$build_runuser" = xyes])
 
 
@@ -1901,7 +1901,7 @@ AC_ARG_ENABLE([wall],
   [], [UL_DEFAULT_ENABLE([wall], [check])]
 )
 UL_BUILD_INIT([wall])
-UL_REQUIRES_HAVE([wall], [utmp_h], [utmp.h header])
+UL_REQUIRES_HAVE([wall], [utmpx_h], [utmpx.h header])
 AM_CONDITIONAL([BUILD_WALL], [test "x$build_wall" = xyes])
 
 
@@ -1910,7 +1910,7 @@ AC_ARG_ENABLE([write],
   [], [UL_DEFAULT_ENABLE([write], [no])]
 )
 UL_BUILD_INIT([write])
-UL_REQUIRES_HAVE([write], [utmp_h], [utmp.h header])
+UL_REQUIRES_HAVE([write], [utmpx_h], [utmpx.h header])
 AM_CONDITIONAL([BUILD_WRITE], [test "x$build_write" = xyes])
 
 
diff --git a/login-utils/last.c b/login-utils/last.c
index da7ed36..75eff5b 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -30,7 +30,7 @@
 #include <time.h>
 #include <stdio.h>
 #include <ctype.h>
-#include <utmp.h>
+#include <utmpx.h>
 #include <pwd.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -94,7 +94,7 @@ struct last_control {
 
 /* Double linked list of struct utmp's */
 struct utmplist {
-	struct utmp ut;
+	struct utmpx ut;
 	struct utmplist *next;
 	struct utmplist *prev;
 };
@@ -173,7 +173,7 @@ static int which_time_format(const char *s)
  *	Read one utmp entry, return in new format.
  *	Automatically reposition file pointer.
  */
-static int uread(FILE *fp, struct utmp *u,  int *quit, const char *filename)
+static int uread(FILE *fp, struct utmpx *u,  int *quit, const char *filename)
 {
 	static int utsize;
 	static char buf[UCHUNKSIZE];
@@ -186,14 +186,14 @@ static int uread(FILE *fp, struct utmp *u,  int *quit, const char *filename)
 		/*
 		 *	Normal read.
 		 */
-		return fread(u, sizeof(struct utmp), 1, fp);
+		return fread(u, sizeof(struct utmpx), 1, fp);
 	}
 
 	if (u == NULL) {
 		/*
 		 *	Initialize and position.
 		 */
-		utsize = sizeof(struct utmp);
+		utsize = sizeof(struct utmpx);
 		fseeko(fp, 0, SEEK_END);
 		fpos = ftello(fp);
 		if (fpos == 0)
@@ -217,7 +217,7 @@ static int uread(FILE *fp, struct utmp *u,  int *quit, const char *filename)
 	 */
 	bpos -= utsize;
 	if (bpos >= 0) {
-		memcpy(u, buf + bpos, sizeof(struct utmp));
+		memcpy(u, buf + bpos, sizeof(struct utmpx));
 		return 1;
 	}
 
@@ -253,7 +253,7 @@ static int uread(FILE *fp, struct utmp *u,  int *quit, const char *filename)
 	memcpy(tmp, buf + UCHUNKSIZE + bpos, -bpos);
 	bpos += UCHUNKSIZE;
 
-	memcpy(u, tmp, sizeof(struct utmp));
+	memcpy(u, tmp, sizeof(struct utmpx));
 
 	return 1;
 }
@@ -376,7 +376,7 @@ static void trim_trailing_spaces(char *s)
 /*
  *	Show one line of information on screen
  */
-static int list(const struct last_control *ctl, struct utmp *p, time_t logout_time, int what)
+static int list(const struct last_control *ctl, struct utmpx *p, time_t logout_time, int what)
 {
 	time_t		secs, utmp_time;
 	char		logintime[LAST_TIMESTAMP_LEN];
@@ -592,7 +592,7 @@ static void __attribute__((__noreturn__)) usage(const struct last_control *ctl,
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-static int is_phantom(const struct last_control *ctl, struct utmp *ut)
+static int is_phantom(const struct last_control *ctl, struct utmpx *ut)
 {
 	struct passwd *pw;
 	char path[32];
@@ -632,7 +632,7 @@ static void process_wtmp_file(const struct last_control *ctl,
 {
 	FILE *fp;		/* File pointer of wtmp file */
 
-	struct utmp ut;		/* Current utmp entry */
+	struct utmpx ut;	/* Current utmp entry */
 	struct utmplist *ulist = NULL;	/* All entries */
 	struct utmplist *p;	/* Pointer into utmplist */
 	struct utmplist *next;	/* Pointer into utmplist */
@@ -837,7 +837,7 @@ static void process_wtmp_file(const struct last_control *ctl,
 			if (ut.ut_line[0] == 0)
 				break;
 			p = xmalloc(sizeof(struct utmplist));
-			memcpy(&p->ut, &ut, sizeof(struct utmp));
+			memcpy(&p->ut, &ut, sizeof(struct utmpx));
 			p->next  = ulist;
 			p->prev  = NULL;
 			if (ulist)
@@ -848,7 +848,9 @@ static void process_wtmp_file(const struct last_control *ctl,
 		case EMPTY:
 		case INIT_PROCESS:
 		case LOGIN_PROCESS:
+#ifdef ACCOUNTING
 		case ACCOUNTING:
+#endif
 			/* ignored ut_types */
 			break;
 
@@ -987,10 +989,10 @@ int main(int argc, char **argv)
 			ctl.until = (time_t) (p / 1000000);
 			break;
 		case 'w':
-			if (ctl.name_len < sizeof(((struct utmp *) 0)->ut_user))
-				ctl.name_len = sizeof(((struct utmp *) 0)->ut_user);
-			if (ctl.domain_len < sizeof(((struct utmp *) 0)->ut_host))
-				ctl.domain_len = sizeof(((struct utmp *) 0)->ut_host);
+			if (ctl.name_len < sizeof(((struct utmpx *) 0)->ut_user))
+				ctl.name_len = sizeof(((struct utmpx *) 0)->ut_user);
+			if (ctl.domain_len < sizeof(((struct utmpx *) 0)->ut_host))
+				ctl.domain_len = sizeof(((struct utmpx *) 0)->ut_host);
 			break;
 		case '0': case '1': case '2': case '3': case '4':
 		case '5': case '6': case '7': case '8': case '9':
diff --git a/login-utils/login.c b/login-utils/login.c
index 3430448..37553ef 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -45,7 +45,7 @@
 #include <errno.h>
 #include <grp.h>
 #include <pwd.h>
-#include <utmp.h>
+#include <utmpx.h>
 #ifdef HAVE_LASTLOG_H
 # include <lastlog.h>
 #endif
@@ -428,7 +428,7 @@ static void init_tty(struct login_context *cxt)
  */
 static void log_btmp(struct login_context *cxt)
 {
-	struct utmp ut;
+	struct utmpx ut;
 	struct timeval tv;
 
 	memset(&ut, 0, sizeof(ut));
@@ -456,7 +456,7 @@ static void log_btmp(struct login_context *cxt)
 			       sizeof(ut.ut_addr_v6));
 	}
 
-	updwtmp(_PATH_BTMP, &ut);
+	updwtmpx(_PATH_BTMP, &ut);
 }
 
 
@@ -555,12 +555,12 @@ done:
  */
 static void log_utmp(struct login_context *cxt)
 {
-	struct utmp ut;
-	struct utmp *utp;
+	struct utmpx ut;
+	struct utmpx *utp;
 	struct timeval tv;
 
-	utmpname(_PATH_UTMP);
-	setutent();
+	utmpxname(_PATH_UTMP);
+	setutxent();
 
 	/* Find pid in utmp.
 	 *
@@ -570,7 +570,7 @@ static void log_utmp(struct login_context *cxt)
 	 * but some number calculated from the previous and current runlevel.)
 	 * -- Michael Riepe <michael@stud.uni-hannover.de>
 	 */
-	while ((utp = getutent()))
+	while ((utp = getutxent()))
 		if (utp->ut_pid == cxt->pid
 		    && utp->ut_type >= INIT_PROCESS
 		    && utp->ut_type <= DEAD_PROCESS)
@@ -579,19 +579,19 @@ static void log_utmp(struct login_context *cxt)
 	/* If we can't find a pre-existing entry by pid, try by line.
 	 * BSD network daemons may rely on this. */
 	if (utp == NULL && cxt->tty_name) {
-		setutent();
+		setutxent();
 		ut.ut_type = LOGIN_PROCESS;
 		strncpy(ut.ut_line, cxt->tty_name, sizeof(ut.ut_line));
-		utp = getutline(&ut);
+		utp = getutxline(&ut);
 	}
 
 	/* If we can't find a pre-existing entry by pid and line, try it by id.
 	 * Very stupid telnetd daemons don't set up utmp at all. (kzak) */
 	if (utp == NULL && cxt->tty_number) {
-	     setutent();
+	     setutxent();
 	     ut.ut_type = DEAD_PROCESS;
 	     strncpy(ut.ut_id, cxt->tty_number, sizeof(ut.ut_id));
-	     utp = getutid(&ut);
+	     utp = getutxid(&ut);
 	}
 
 	if (utp)
@@ -619,10 +619,10 @@ static void log_utmp(struct login_context *cxt)
 			       sizeof(ut.ut_addr_v6));
 	}
 
-	pututline(&ut);
-	endutent();
+	pututxline(&ut);
+	endutxent();
 
-	updwtmp(_PATH_WTMP, &ut);
+	updwtmpx(_PATH_WTMP, &ut);
 }
 
 static void log_syslog(struct login_context *cxt)
diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 4109876..a08db62 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -31,7 +31,7 @@
 #include <shadow.h>
 #include <paths.h>
 #include <time.h>
-#include <utmp.h>
+#include <utmpx.h>
 #include <signal.h>
 #include <err.h>
 #include <limits.h>
@@ -243,10 +243,10 @@ static const struct lslogins_coldesc coldescs[] =
 };
 
 struct lslogins_control {
-	struct utmp *wtmp;
+	struct utmpx *wtmp;
 	size_t wtmp_size;
 
-	struct utmp *btmp;
+	struct utmpx *btmp;
 	size_t btmp_size;
 
 	void *usertree;
@@ -410,7 +410,7 @@ again:
 	return res;
 }
 
-static struct utmp *get_last_wtmp(struct lslogins_control *ctl, const char *username)
+static struct utmpx *get_last_wtmp(struct lslogins_control *ctl, const char *username)
 {
 	size_t n = 0;
 
@@ -445,7 +445,7 @@ static int require_btmp(void)
 	return 0;
 }
 
-static struct utmp *get_last_btmp(struct lslogins_control *ctl, const char *username)
+static struct utmpx *get_last_btmp(struct lslogins_control *ctl, const char *username)
 {
 	size_t n = 0;
 
@@ -462,21 +462,21 @@ static struct utmp *get_last_btmp(struct lslogins_control *ctl, const char *user
 
 }
 
-static int read_utmp(char const *file, size_t *nents, struct utmp **res)
+static int read_utmp(char const *file, size_t *nents, struct utmpx **res)
 {
 	size_t n_read = 0, n_alloc = 0;
-	struct utmp *utmp = NULL, *u;
+	struct utmpx *utmp = NULL, *u;
 
-	if (utmpname(file) < 0)
+	if (utmpxname(file) < 0)
 		return -errno;
 
-	setutent();
+	setutxent();
 	errno = 0;
 
-	while ((u = getutent()) != NULL) {
+	while ((u = getutxent()) != NULL) {
 		if (n_read == n_alloc) {
 			n_alloc += 32;
-			utmp = xrealloc(utmp, n_alloc * sizeof (struct utmp));
+			utmp = xrealloc(utmp, n_alloc * sizeof (struct utmpx));
 		}
 		utmp[n_read++] = *u;
 	}
@@ -485,7 +485,7 @@ static int read_utmp(char const *file, size_t *nents, struct utmp **res)
 		return -errno;
 	}
 
-	endutent();
+	endutxent();
 
 	*nents = n_read;
 	*res = utmp;
@@ -578,7 +578,7 @@ static struct lslogins_user *get_user_info(struct lslogins_control *ctl, const c
 	struct passwd *pwd;
 	struct group *grp;
 	struct spwd *shadow;
-	struct utmp *user_wtmp = NULL, *user_btmp = NULL;
+	struct utmpx *user_wtmp = NULL, *user_btmp = NULL;
 	int n = 0;
 	time_t time;
 	uid_t uid;
diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index c48d951..0928a2b 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -58,7 +58,7 @@ enum
 #include <signal.h>
 #include <sys/wait.h>
 #include <syslog.h>
-#include <utmp.h>
+#include <utmpx.h>
 
 #include "err.h"
 
@@ -182,7 +182,7 @@ log_syslog(struct passwd const *pw, bool successful)
  */
 static void log_btmp(struct passwd const *pw)
 {
-	struct utmp ut;
+	struct utmpx ut;
 	struct timeval tv;
 	const char *tty_name, *tty_num;
 
@@ -204,7 +204,7 @@ static void log_btmp(struct passwd const *pw)
 	ut.ut_type = LOGIN_PROCESS;	/* XXX doesn't matter */
 	ut.ut_pid = getpid();
 
-	updwtmp(_PATH_BTMP, &ut);
+	updwtmpx(_PATH_BTMP, &ut);
 }
 
 
diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index 4a85afa..fd90b5e 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <utmp.h>
+#include <utmpx.h>
 #include <time.h>
 #include <ctype.h>
 #include <getopt.h>
@@ -87,7 +87,7 @@ static void xcleanse(char *s, int len)
 			*s = '?';
 }
 
-static void print_utline(struct utmp *ut, FILE *out)
+static void print_utline(struct utmpx *ut, FILE *out)
 {
 	const char *addr_string;
 	char buffer[INET6_ADDRSTRLEN];
@@ -129,7 +129,7 @@ static void roll_file(const char *filename, off_t *size, FILE *out)
 {
 	FILE *in;
 	struct stat st;
-	struct utmp ut;
+	struct utmpx ut;
 	off_t pos;
 
 	if (!(in = fopen(filename, "r")))
@@ -207,7 +207,7 @@ static int follow_by_inotify(FILE *in, const char *filename, FILE *out)
 
 static FILE *dump(FILE *in, const char *filename, int follow, FILE *out)
 {
-	struct utmp ut;
+	struct utmpx ut;
 
 	if (follow)
 		ignore_result( fseek(in, -10 * sizeof(ut), SEEK_END) );
@@ -265,7 +265,7 @@ static int gettok(char *line, char *dest, int size, int eatspace)
 
 static void undump(FILE *in, FILE *out)
 {
-	struct utmp ut;
+	struct utmpx ut;
 	char s_addr[INET6_ADDRSTRLEN + 1], s_time[29], *linestart, *line;
 	int count = 0;
 
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 0f114a5..46eea01 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -25,7 +25,7 @@
 #include <fcntl.h>
 #include <stdarg.h>
 #include <ctype.h>
-#include <utmp.h>
+#include <utmpx.h>
 #include <getopt.h>
 #include <time.h>
 #include <sys/socket.h>
@@ -884,13 +884,13 @@ static void parse_speeds(struct options *op, char *arg)
 /* Update our utmp entry. */
 static void update_utmp(struct options *op)
 {
-	struct utmp ut;
+	struct utmpx ut;
 	time_t t;
 	pid_t pid = getpid();
 	pid_t sid = getsid(0);
 	char *vcline = op->vcline;
 	char *line   = op->tty;
-	struct utmp *utp;
+	struct utmpx *utp;
 
 	/*
 	 * The utmp file holds miscellaneous information about things started by
@@ -900,8 +900,8 @@ static void update_utmp(struct options *op)
 	 * utmp file can be opened for update, and if we are able to find our
 	 * entry in the utmp file.
 	 */
-	utmpname(_PATH_UTMP);
-	setutent();
+	utmpxname(_PATH_UTMP);
+	setutxent();
 
 	/*
 	 * Find my pid in utmp.
@@ -912,7 +912,7 @@ static void update_utmp(struct options *op)
 	 * FIXME: The present code is taken from login.c, so if this is changed,
 	 * maybe login has to be changed as well (is this true?).
 	 */
-	while ((utp = getutent()))
+	while ((utp = getutxent()))
 		if (utp->ut_pid == pid
 				&& utp->ut_type >= INIT_PROCESS
 				&& utp->ut_type <= DEAD_PROCESS)
@@ -947,10 +947,10 @@ static void update_utmp(struct options *op)
 	ut.ut_pid = pid;
 	ut.ut_session = sid;
 
-	pututline(&ut);
-	endutent();
+	pututxline(&ut);
+	endutxent();
 
-	updwtmp(_PATH_WTMP, &ut);
+	updwtmpx(_PATH_WTMP, &ut);
 }
 
 #endif				/* SYSV_STYLE */
@@ -2448,12 +2448,12 @@ static void output_special_char(unsigned char c, struct options *op,
 	case 'U':
 	{
 		int users = 0;
-		struct utmp *ut;
-		setutent();
-		while ((ut = getutent()))
+		struct utmpx *ut;
+		setutxent();
+		while ((ut = getutxent()))
 			if (ut->ut_type == USER_PROCESS)
 				users++;
-		endutent();
+		endutxent();
 		if (c == 'U')
 			printf(P_("%d user", "%d users", users), users);
 		else
diff --git a/term-utils/wall.c b/term-utils/wall.c
index 4ad94d8..7092cdc 100644
--- a/term-utils/wall.c
+++ b/term-utils/wall.c
@@ -56,7 +56,7 @@
 #include <string.h>
 #include <time.h>
 #include <unistd.h>
-#include <utmp.h>
+#include <utmpx.h>
 #include <getopt.h>
 
 #include "nls.h"
@@ -100,7 +100,7 @@ int main(int argc, char **argv)
 {
 	int ch;
 	struct iovec iov;
-	struct utmp *utmpptr;
+	struct utmpx *utmpptr;
 	char *p;
 	char line[sizeof(utmpptr->ut_line) + 1];
 	int print_banner = TRUE;
@@ -159,7 +159,7 @@ int main(int argc, char **argv)
 
 	iov.iov_base = mbuf;
 	iov.iov_len = mbufsize;
-	while((utmpptr = getutent())) {
+	while((utmpptr = getutxent())) {
 		if (!utmpptr->ut_user[0])
 			continue;
 #ifdef USER_PROCESS
@@ -176,7 +176,7 @@ int main(int argc, char **argv)
 		if ((p = ttymsg(&iov, 1, line, timeout)) != NULL)
 			warnx("%s", p);
 	}
-	endutent();
+	endutxent();
 	free(mbuf);
 	exit(EXIT_SUCCESS);
 }
diff --git a/term-utils/write.c b/term-utils/write.c
index 4f8f21e..2b05e89 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -57,7 +57,7 @@
 #include <sys/stat.h>
 #include <time.h>
 #include <unistd.h>
-#include <utmp.h>
+#include <utmpx.h>
 
 #include "c.h"
 #include "carefulputc.h"
@@ -130,13 +130,13 @@ static int check_tty(const char *tty, int *tty_writeable, time_t *tty_atime, int
  */
 static int check_utmp(const struct write_control *ctl)
 {
-	struct utmp *u;
+	struct utmpx *u;
 	int res = 1;
 
-	utmpname(_PATH_UTMP);
-	setutent();
+	utmpxname(_PATH_UTMP);
+	setutxent();
 
-	while ((u = getutent())) {
+	while ((u = getutxent())) {
 		if (strncmp(ctl->dst_login, u->ut_user, sizeof(u->ut_user)) == 0 &&
 		    strncmp(ctl->dst_tty_name, u->ut_line, sizeof(u->ut_line)) == 0) {
 			res = 0;
@@ -144,7 +144,7 @@ static int check_utmp(const struct write_control *ctl)
 		}
 	}
 
-	endutent();
+	endutxent();
 	return res;
 }
 
@@ -161,15 +161,15 @@ static int check_utmp(const struct write_control *ctl)
  */
 static void search_utmp(struct write_control *ctl)
 {
-	struct utmp *u;
+	struct utmpx *u;
 	time_t best_atime = 0, tty_atime;
 	int num_ttys = 0, valid_ttys = 0, tty_writeable = 0, user_is_me = 0;
 	char path[sizeof(u->ut_line) + 6];
 
-	utmpname(_PATH_UTMP);
-	setutent();
+	utmpxname(_PATH_UTMP);
+	setutxent();
 
-	while ((u = getutent())) {
+	while ((u = getutxent())) {
 		if (strncmp(ctl->dst_login, u->ut_user, sizeof(u->ut_user)) != 0)
 			continue;
 		num_ttys++;
@@ -197,7 +197,7 @@ static void search_utmp(struct write_control *ctl)
 		}
 	}
 
-	endutent();
+	endutxent();
 	if (num_ttys == 0)
 		errx(EXIT_FAILURE, _("%s is not logged in"), ctl->dst_login);
 	if (valid_ttys == 0) {
-- 
1.8.5.6

