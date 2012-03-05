Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41695 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757512Ab2CETje (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Mar 2012 14:39:34 -0500
Received: by mail-ee0-f46.google.com with SMTP id c41so1625459eek.19
        for <util-linux@vger.kernel.org>; Mon, 05 Mar 2012 11:39:33 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/17] vipw: use xmkstemp() and lckpwdf()
Date: Mon,  5 Mar 2012 20:38:49 +0100
Message-Id: <1330976334-10751-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
References: <20120305123847.GD486@x2.net.home>
 <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Get rid private locking schema and use libc instead.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/Makefile.am |    3 +-
 login-utils/setpwnam.h  |   39 ++++--------------
 login-utils/vipw.8      |    1 +
 login-utils/vipw.c      |  100 ++++++++++++++++++-----------------------------
 4 files changed, 49 insertions(+), 94 deletions(-)

diff --git a/login-utils/Makefile.am b/login-utils/Makefile.am
index 7bd2ddb..7b3b739 100644
--- a/login-utils/Makefile.am
+++ b/login-utils/Makefile.am
@@ -51,7 +51,8 @@ login_SOURCES = \
 	$(top_srcdir)/lib/setproctitle.c
 vipw_SOURCES = \
 	vipw.c \
-	setpwnam.h
+	setpwnam.h \
+	$(top_srcdir)/lib/fileutils.c
 
 chfn_LDADD = $(login_ldadd_common)
 chsh_LDADD = $(login_ldadd_common)
diff --git a/login-utils/setpwnam.h b/login-utils/setpwnam.h
index e7f44a9..6a4dbb7 100644
--- a/login-utils/setpwnam.h
+++ b/login-utils/setpwnam.h
@@ -15,38 +15,15 @@
 #include "pathnames.h"
 
 #ifndef DEBUG
-#define PASSWD_FILE    _PATH_PASSWD
-#define PTMP_FILE      _PATH_PTMP
-#define PTMPTMP_FILE   _PATH_PTMPTMP
-
-#define GROUP_FILE     _PATH_GROUP
-#define GTMP_FILE      _PATH_GTMP
-#define GTMPTMP_FILE   _PATH_GTMPTMP
-
-#define SHADOW_FILE	_PATH_SHADOW_PASSWD
-#define SPTMP_FILE	_PATH_SHADOW_PTMP
-#define SPTMPTMP_FILE	_PATH_SHADOW_PTMPTMP
-
-#define SGROUP_FILE	_PATH_SHADOW_GROUP
-#define SGTMP_FILE	_PATH_SHADOW_GTMP
-#define SGTMPTMP_FILE	_PATH_SHADOW_GTMPTMP
-
+# define PASSWD_FILE	_PATH_PASSWD
+# define GROUP_FILE	_PATH_GROUP
+# define SHADOW_FILE	_PATH_SHADOW_PASSWD
+# define SGROUP_FILE	_PATH_SHADOW_GROUP
 #else
-#define PASSWD_FILE    "/tmp/passwd"
-#define PTMP_FILE      "/tmp/ptmp"
-#define PTMPTMP_FILE   "/tmp/ptmptmp"
-
-#define GROUP_FILE     "/tmp/group"
-#define GTMP_FILE      "/tmp/gtmp"
-#define GTMPTMP_FILE   "/tmp/gtmptmp"
-
-#define SHADOW_FILE	"/tmp/shadow"
-#define SPTMP_FILE	"/tmp/sptmp"
-#define SPTMPTMP_FILE	"/tmp/sptmptmp"
-
-#define SGROUP_FILE	"/tmp/gshadow"
-#define SGTMP_FILE	"/tmp/sgtmp"
-#define SGTMPTMP_FILE	"/tmp/sgtmptmp"
+# define PASSWD_FILE	"/tmp/passwd"
+# define GROUP_FILE	"/tmp/group"
+# define SHADOW_FILE	"/tmp/shadow"
+# define SGROUP_FILE	"/tmp/gshadow"
 #endif
 
 extern int setpwnam (struct passwd *pwd);
diff --git a/login-utils/vipw.8 b/login-utils/vipw.8
index 66c99d1..62dcc85 100644
--- a/login-utils/vipw.8
+++ b/login-utils/vipw.8
@@ -72,6 +72,7 @@ will be invoked instead of the default editor
 .El
 .SH SEE ALSO
 .BR passwd (1),
+.BR flock (2),
 .BR vi (1),
 .BR passwd (5)
 .SH HISTORY
diff --git a/login-utils/vipw.c b/login-utils/vipw.c
index 992a3a3..765d111 100644
--- a/login-utils/vipw.c
+++ b/login-utils/vipw.c
@@ -57,6 +57,7 @@
 #include <fcntl.h>
 #include <paths.h>
 #include <pwd.h>
+#include <shadow.h>
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -71,6 +72,7 @@
 #include <unistd.h>
 
 #include "c.h"
+#include "fileutils.h"
 #include "nls.h"
 #include "setpwnam.h"
 #include "strutils.h"
@@ -88,8 +90,7 @@ enum {
 };
 int program;
 char orig_file[FILENAMELEN];	/* original file /etc/passwd or /etc/group */
-char tmp_file[FILENAMELEN];	/* tmp file */
-char tmptmp_file[FILENAMELEN];	/* very tmp file */
+char *tmp_file;			/* tmp file */
 
 void pw_error __P((char *, int, int));
 
@@ -137,55 +138,22 @@ static void pw_init(void)
 	(void)umask(0);
 }
 
-static int pw_lock(void)
+static FILE * pw_tmpfile(int lockfd)
 {
-	int lockfd, fd, ret;
-
-	/*
-	 * If the password file doesn't exist, the system is hosed.  Might as
-	 * well try to build one.  Set the close-on-exec bit so that users
-	 * can't get at the encrypted passwords while editing.  Open should
-	 * allow flock'ing the file; see 4.4BSD.  XXX
-	 */
-#if 0
-	/* flock()ing is superfluous here, with the ptmp/ptmptmp system. */
-	if (flock(lockfd, LOCK_EX | LOCK_NB)) {
-		if (program == VIPW)
-			err(EXIT_FAILURE, _("cannot lock password file"));
-		else
-			err(EXIT_FAILURE, _("cannot lock group file"));
-	}
-#endif
-
-	if ((fd = open(tmptmp_file, O_WRONLY | O_CREAT, 0600)) == -1)
-		err(EXIT_FAILURE, _("%s: open failed"), tmptmp_file);
-
-	ret = link(tmptmp_file, tmp_file);
-	(void)unlink(tmptmp_file);
-	if (ret == -1) {
-		if (errno == EEXIST)
-			errx(EXIT_FAILURE,
-			     _("the %s file is busy (%s present)"),
-			     program == VIPW ? "password" : "group", tmp_file);
-		else
-			err(EXIT_FAILURE, _("can't link %s"), tmp_file);
-	}
-
-	lockfd = open(orig_file, O_RDONLY, 0);
+	FILE *fd;
+	char *tmpname = NULL;
 
-	if (lockfd < 0) {
-		warn("%s", orig_file);
-		unlink(tmp_file);
-		exit(EXIT_FAILURE);
+	if ((fd = xmkstemp(&tmpname)) == NULL) {
+		ulckpwdf();
+		err(EXIT_FAILURE, _("can't open temporary file"));
 	}
 
-	copyfile(lockfd, fd);
-	(void)close(lockfd);
-	(void)close(fd);
-	return 1;
+	copyfile(lockfd, fileno(fd));
+	tmp_file = tmpname;
+	return fd;
 }
 
-static void pw_unlock(void)
+static void pw_write(void)
 {
 	char tmp[FILENAMELEN + 4];
 
@@ -215,10 +183,11 @@ static void pw_unlock(void)
 	if (rename(tmp_file, orig_file) == -1) {
 		int errsv = errno;
 		errx(EXIT_FAILURE,
-		     ("can't unlock %s: %s (your changes are still in %s)"),
+		     ("cannot write %s: %s (your changes are still in %s)"),
 		     orig_file, strerror(errsv), tmp_file);
 	}
 	unlink(tmp_file);
+	free(tmp_file);
 }
 
 static void pw_edit(int notsetuid)
@@ -275,33 +244,49 @@ void pw_error(char *name, int err, int eval)
 	}
 	warnx(_("%s unchanged"), orig_file);
 	unlink(tmp_file);
+	ulckpwdf();
 	exit(eval);
 }
 
 static void edit_file(int is_shadow)
 {
 	struct stat begin, end;
+	int passwd_file, ch_ret;
+	FILE *tmp_fd;
 
 	pw_init();
-	pw_lock();
 
-	if (stat(tmp_file, &begin))
+	/* acquire exclusive lock */
+	if (lckpwdf() < 0)
+		err(EXIT_FAILURE, _("cannot get lock"));
+
+	passwd_file = open(orig_file, O_RDONLY, 0);
+	if (passwd_file < 0)
+		err(EXIT_FAILURE, "%s: %s", _("cannot open file"), orig_file);
+	tmp_fd = pw_tmpfile(passwd_file);
+
+	if (fstat(fileno(tmp_fd), &begin))
 		pw_error(tmp_file, 1, 1);
 
 	pw_edit(0);
 
-	if (stat(tmp_file, &end))
+	if (fstat(fileno(tmp_fd), &end))
 		pw_error(tmp_file, 1, 1);
 	if (begin.st_mtime == end.st_mtime) {
 		warnx(_("no changes made"));
 		pw_error((char *)NULL, 0, 0);
 	}
-	/* see pw_lock() where we create the file with mode 600 */
+	/* pw_tmpfile() will create the file with mode 600 */
 	if (!is_shadow)
-		chmod(tmp_file, 0644);
+		ch_ret = fchmod(fileno(tmp_fd), 0644);
 	else
-		chmod(tmp_file, 0400);
-	pw_unlock();
+		ch_ret = fchmod(fileno(tmp_fd), 0400);
+	if (ch_ret < 0)
+		err(EXIT_FAILURE, "%s: %s", _("cannot chmod file"), orig_file);
+	fclose(tmp_fd);
+	pw_write();
+	close(passwd_file);
+	ulckpwdf();
 }
 
 int main(int argc, char *argv[])
@@ -310,17 +295,12 @@ int main(int argc, char *argv[])
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 
-	memset(tmp_file, '\0', FILENAMELEN);
 	if (!strcmp(program_invocation_short_name, "vigr")) {
 		program = VIGR;
 		xstrncpy(orig_file, GROUP_FILE, sizeof(orig_file));
-		xstrncpy(tmp_file, GTMP_FILE, sizeof(tmp_file));
-		xstrncpy(tmptmp_file, GTMPTMP_FILE, sizeof(tmptmp_file));
 	} else {
 		program = VIPW;
 		xstrncpy(orig_file, PASSWD_FILE, sizeof(orig_file));
-		xstrncpy(tmp_file, PTMP_FILE, sizeof(tmp_file));
-		xstrncpy(tmptmp_file, PTMPTMP_FILE, sizeof(tmptmp_file));
 	}
 
 	if ((argc > 1) &&
@@ -333,12 +313,8 @@ int main(int argc, char *argv[])
 
 	if (program == VIGR) {
 		strncpy(orig_file, SGROUP_FILE, FILENAMELEN - 1);
-		strncpy(tmp_file, SGTMP_FILE, FILENAMELEN - 1);
-		strncpy(tmptmp_file, SGTMPTMP_FILE, FILENAMELEN - 1);
 	} else {
 		strncpy(orig_file, SHADOW_FILE, FILENAMELEN - 1);
-		strncpy(tmp_file, SPTMP_FILE, FILENAMELEN - 1);
-		strncpy(tmptmp_file, SPTMPTMP_FILE, FILENAMELEN - 1);
 	}
 
 	if (access(orig_file, F_OK) == 0) {
-- 
1.7.9.2

