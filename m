Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 39/49] login: rewrite motd(), use MOTD_FILE from login.defs
Date: Mon, 17 Oct 2011 13:15:18 +0200
Message-Id: <1318850128-23458-40-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Note that Suse login(1) does not use any default for MOTD_FILE, so
MOTD_FILE item in login.defs is required otherwise nothing is printed.

We use (for backward compatibility) /etc/motd as default.

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/Makefile.am |    3 +-
 login-utils/login.1     |   20 +++++++++++++++++
 login-utils/login.c     |   53 +++++++++++++++++++++++++++-------------------
 3 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/login-utils/Makefile.am b/login-utils/Makefile.am
index 84036fc..ada4555 100644
--- a/login-utils/Makefile.am
+++ b/login-utils/Makefile.am
@@ -25,7 +25,8 @@ chfn_SOURCES = chfn.c $(chfn_chsh_common)
 chsh_SOURCES = chsh.c $(chfn_chsh_common)
 chfn_chsh_common = islocal.c setpwnam.c islocal.h setpwnam.h \
 	$(top_srcdir)/lib/env.c
-login_SOURCES = login.c $(top_srcdir)/lib/setproctitle.c
+login_SOURCES = login.c logindefs.c logindefs.h \
+		$(top_srcdir)/lib/setproctitle.c
 vipw_SOURCES = vipw.c setpwnam.h
 
 chfn_LDADD = $(login_ldadd_common)
diff --git a/login-utils/login.1 b/login-utils/login.1
index 50575cc..8aba16f 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -114,6 +114,26 @@ and
 .I /etc/pam.d/remote
 ).
 
+
+.SH CONFIG FILE ITEMS
+.B login
+reads the
+.IR /etc/login.defs (5)
+configuration file. Note that the configuration file could be distributed with
+another package (e.g. shadow-utils). The following configuration items are
+relevant for
+.BR login (1):
+.PP
+\fBMOTD_FILE\fR (string)
+.RS 4
+If defined, ":" delimited list of "message of the day" files to be displayed
+upon login. The default value is "/etc/motd". If the \fBMOTD_FILE\fR item is
+empty or "quiet" login is enabled then the message of the day is not displayed.
+Note that the same functionality is also provided by
+.BR pam_motd (8)
+PAM module.
+.RE
+
 .SH FILES
 .nf
 .I /var/run/utmp
diff --git a/login-utils/login.c b/login-utils/login.c
index 5f5313f..8431af8 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -43,7 +43,6 @@
 #include <grp.h>
 #include <pwd.h>
 #include <utmp.h>
-#include <setjmp.h>
 #include <stdlib.h>
 #include <sys/syslog.h>
 #include <sys/sysmacros.h>
@@ -52,6 +51,7 @@
 #include <lastlog.h>
 #include <security/pam_appl.h>
 #include <security/pam_misc.h>
+#include <sys/sendfile.h>
 
 #ifdef HAVE_LIBAUDIT
 # include <libaudit.h>
@@ -68,6 +68,8 @@
 #include "xalloc.h"
 #include "writeall.h"
 
+#include "logindefs.h"
+
 #define is_pam_failure(_rc)	((_rc) != PAM_SUCCESS)
 
 #define LOGIN_MAX_TRIES        3
@@ -122,8 +124,6 @@ static int timeout = LOGIN_TIMEOUT;
 static int child_pid = 0;
 static volatile int got_sig = 0;
 
-jmp_buf motdinterrupt;
-
 /*
  * Robert Ambrose writes:
  * A couple of my users have a problem with login processes hanging around
@@ -173,12 +173,6 @@ static void sig_handler(int signal)
 		kill(-child_pid, SIGHUP);	/* because the shell often ignores SIGTERM */
 }
 
-static void sigint(int sig __attribute__ ((__unused__)))
-{
-	longjmp(motdinterrupt, 1);
-}
-
-
 /* Should not be called from PAM code... */
 static void sleepexit(int eval)
 {
@@ -186,23 +180,38 @@ static void sleepexit(int eval)
 	exit(eval);
 }
 
+/*
+ * Output the /etc/motd file
+ *
+ * motd() determines the name of a login announcement file and outputs it to
+ * the user's terminal at login time.  The MOTD_FILE configuration option is a
+ * colon-delimited list of filenames. The empty MOTD_FILE option disables motd
+ * printing at all.
+ */
 static void motd(void)
 {
-	int fd, nchars;
-	void (*oldint) (int);
-	char tbuf[8192];
+	char *motdlist, *motdfile, *cp;
+	const char *mb;
 
-	if ((fd = open(_PATH_MOTDFILE, O_RDONLY, 0)) < 0)
+	mb = getlogindefs_str("MOTD_FILE", _PATH_MOTDFILE);
+	if (!mb || !*mb)
 		return;
-	oldint = signal(SIGINT, sigint);
-	if (setjmp(motdinterrupt) == 0)
-		while ((nchars = read(fd, tbuf, sizeof(tbuf))) > 0) {
-			if (write(fileno(stdout), tbuf, nchars)) {
-				;	/* glibc warn_unused_result */
-			}
-		}
-	signal(SIGINT, oldint);
-	close(fd);
+
+	motdlist = xstrdup(mb);
+
+	for (cp = motdlist; (motdfile = strtok(cp, ":")); cp = NULL) {
+		struct stat st;
+		int fd;
+
+		if (stat(motdfile, &st) || !st.st_size)
+			continue;
+		fd = open(motdfile, O_RDONLY, 0);
+		if (fd < 0)
+			continue;
+
+		sendfile(fileno(stdout), fd, NULL, st.st_size);
+		close(fd);
+	}
 }
 
 /*
-- 
1.7.6.4
