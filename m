Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33476 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbcHNJpk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Aug 2016 05:45:40 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so5822808wme.0
        for <util-linux@vger.kernel.org>; Sun, 14 Aug 2016 02:45:39 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/3] misc: always check setenv(3) return value
Date: Sun, 14 Aug 2016 08:24:04 +0100
Message-Id: <20160814072406.2991-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

At least glibc setenv(3) can fail when system runs out of memory.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/env.h           |  2 +-
 lib/pager.c             |  3 ++-
 login-utils/login.c     | 19 +++++++++++--------
 login-utils/su-common.c |  2 +-
 login-utils/sulogin.c   | 21 +++++++++++----------
 sys-utils/hwclock.c     |  5 +++--
 sys-utils/rtcwake.c     |  3 ++-
 term-utils/agetty.c     |  4 +++-
 8 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/include/env.h b/include/env.h
index a53d310..ff5fc79 100644
--- a/include/env.h
+++ b/include/env.h
@@ -9,7 +9,7 @@ extern char *safe_getenv(const char *arg);
 static inline void xsetenv(char const *name, char const *val, int overwrite)
 {
 	if (setenv(name, val, overwrite) != 0)
-		err(EXIT_FAILURE, "failed to set the %s environment variable", name);
+		err(EXIT_FAILURE, _("failed to set the %s environment variable"), name);
 }
 
 #endif /* UTIL_LINUX_ENV_H */
diff --git a/lib/pager.c b/lib/pager.c
index 330659e..e8cf109 100644
--- a/lib/pager.c
+++ b/lib/pager.c
@@ -138,7 +138,8 @@ static void pager_preexec(void)
 	FD_SET(STDIN_FILENO, &in);
 	select(1, &in, NULL, &in, NULL);
 
-	setenv("LESS", "FRSX", 0);
+	if (setenv("LESS", "FRSX", 0) != 0)
+		warn(_("failed to set the %s environment variable"), "LESS");
 }
 
 static void wait_for_pager(void)
diff --git a/login-utils/login.c b/login-utils/login.c
index 7501f6d..1de24a8 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -69,6 +69,7 @@
 #include "pathnames.h"
 #include "strutils.h"
 #include "nls.h"
+#include "env.h"
 #include "xalloc.h"
 #include "all-io.h"
 #include "fileutils.h"
@@ -1040,27 +1041,29 @@ static void init_environ(struct login_context *cxt)
 		memset(environ, 0, sizeof(char *));
 	}
 
-	setenv("HOME", pwd->pw_dir, 0);	/* legal to override */
-	setenv("USER", pwd->pw_name, 1);
-	setenv("SHELL", pwd->pw_shell, 1);
-	setenv("TERM", termenv ? termenv : "dumb", 1);
+	xsetenv("HOME", pwd->pw_dir, 0);	/* legal to override */
+	xsetenv("USER", pwd->pw_name, 1);
+	xsetenv("SHELL", pwd->pw_shell, 1);
+	xsetenv("TERM", termenv ? termenv : "dumb", 1);
 	free(termenv);
 
 	if (pwd->pw_uid)
-		logindefs_setenv("PATH", "ENV_PATH", _PATH_DEFPATH);
+		if (logindefs_setenv("PATH", "ENV_PATH", _PATH_DEFPATH) != 0)
+			err(EXIT_FAILURE, _("failed to set the %s environment variable"), "PATH");
 
 	else if (logindefs_setenv("PATH", "ENV_ROOTPATH", NULL) != 0)
-		logindefs_setenv("PATH", "ENV_SUPATH", _PATH_DEFPATH_ROOT);
+		if (logindefs_setenv("PATH", "ENV_SUPATH", _PATH_DEFPATH_ROOT) != 0)
+			err(EXIT_FAILURE, _("failed to set the %s environment variable"), "PATH");
 
 	/* mailx will give a funny error msg if you forget this one */
 	len = snprintf(tmp, sizeof(tmp), "%s/%s", _PATH_MAILDIR, pwd->pw_name);
 	if (len > 0 && (size_t) len < sizeof(tmp))
-		setenv("MAIL", tmp, 0);
+		xsetenv("MAIL", tmp, 0);
 
 	/* LOGNAME is not documented in login(1) but HP-UX 6.5 does it. We'll
 	 * not allow modifying it.
 	 */
-	setenv("LOGNAME", pwd->pw_name, 1);
+	xsetenv("LOGNAME", pwd->pw_name, 1);
 
 	env = pam_getenvlist(cxt->pamh);
 	for (i = 0; env && env[i]; i++)
diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index 1776b6b..ff20a2f 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -520,7 +520,7 @@ set_path(const struct passwd* pw)
     r = logindefs_setenv("PATH", "ENV_SUPATH", _PATH_DEFPATH_ROOT);
 
   if (r != 0)
-    err (EXIT_FAILURE,  _("failed to set PATH"));
+    err (EXIT_FAILURE,  _("failed to set the %s environment variable"), "PATH");
 }
 
 /* Update `environ' for the new shell based on PW, with SHELL being
diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index fdbda7c..1c4313a 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -56,6 +56,7 @@
 
 #include "c.h"
 #include "closestream.h"
+#include "env.h"
 #include "nls.h"
 #include "pathnames.h"
 #ifdef USE_PLYMOUTH_SUPPORT
@@ -219,18 +220,18 @@ static void tcfinal(struct console *con)
 	int fd;
 
 	if ((con->flags & CON_SERIAL) == 0) {
-		setenv("TERM", "linux", 1);
+		xsetenv("TERM", "linux", 1);
 		return;
 	}
 	if (con->flags & CON_NOTTY) {
-		setenv("TERM", "dumb", 1);
+		xsetenv("TERM", "dumb", 1);
 		return;
 	}
 
 #if defined (__s390__) || defined (__s390x__)
-	setenv("TERM", "dumb", 1);
+	xsetenv("TERM", "dumb", 1);
 #else
-	setenv("TERM", "vt102", 1);
+	xsetenv("TERM", "vt102", 1);
 #endif
 	tio = &con->tio;
 	fd = con->fd;
@@ -759,16 +760,16 @@ static void sushell(struct passwd *pwd)
 	if (getcwd(home, sizeof(home)) == NULL)
 		strcpy(home, "/");
 
-	setenv("HOME", home, 1);
-	setenv("LOGNAME", "root", 1);
-	setenv("USER", "root", 1);
+	xsetenv("HOME", home, 1);
+	xsetenv("LOGNAME", "root", 1);
+	xsetenv("USER", "root", 1);
 	if (!profile)
-		setenv("SHLVL","0",1);
+		xsetenv("SHLVL","0",1);
 
 	/*
 	 * Try to execute a shell.
 	 */
-	setenv("SHELL", su_shell, 1);
+	xsetenv("SHELL", su_shell, 1);
 	unmask_signal(SIGINT, &saved_sigint);
 	unmask_signal(SIGTSTP, &saved_sigtstp);
 	unmask_signal(SIGQUIT, &saved_sigquit);
@@ -793,7 +794,7 @@ static void sushell(struct passwd *pwd)
 	execl(su_shell, shell, NULL);
 	warn(_("failed to execute %s"), su_shell);
 
-	setenv("SHELL", "/bin/sh", 1);
+	xsetenv("SHELL", "/bin/sh", 1);
 	execl("/bin/sh", profile ? "-sh" : "sh", NULL);
 	warn(_("failed to execute %s"), "/bin/sh");
 }
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index e98c2c0..21caeb2 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -81,6 +81,7 @@
 #include "strutils.h"
 #include "hwclock.h"
 #include "timeutils.h"
+#include "env.h"
 
 #ifdef HAVE_LIBAUDIT
 #include <libaudit.h>
@@ -399,7 +400,7 @@ mktime_tz(struct tm tm, const bool universal,
 	zone = getenv("TZ");	/* remember original time zone */
 	if (universal) {
 		/* Set timezone to UTC */
-		setenv("TZ", "", TRUE);
+		xsetenv("TZ", "", TRUE);
 		/*
 		 * Note: tzset() gets called implicitly by the time code,
 		 * but only the first time. When changing the environment
@@ -434,7 +435,7 @@ mktime_tz(struct tm tm, const bool universal,
 	}
 	/* now put back the original zone. */
 	if (zone)
-		setenv("TZ", zone, TRUE);
+		xsetenv("TZ", zone, TRUE);
 	else
 		unsetenv("TZ");
 	tzset();
diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index 536c5bf..f4e630a 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -34,6 +34,7 @@
 
 #include "c.h"
 #include "closestream.h"
+#include "env.h"
 #include "nls.h"
 #include "optutils.h"
 #include "pathnames.h"
@@ -157,7 +158,7 @@ static int get_basetimes(struct rtcwake_control *ctl, int fd)
 	 * with the system clock (which always uses UTC).
 	 */
 	if (ctl->clock_mode == CM_UTC)
-		setenv("TZ", "UTC", 1);
+		xsetenv("TZ", "UTC", 1);
 	tzset();
 	/* Read rtc and system clocks "at the same time", or as
 	 * precisely (+/- a second) as we can read them.
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index d5dc018..d6cec8f 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -45,6 +45,7 @@
 #include "widechar.h"
 #include "ttyutils.h"
 #include "color-names.h"
+#include "env.h"
 
 #ifdef USE_PLYMOUTH_SUPPORT
 # include "plymouth-ctrl.h"
@@ -1155,7 +1156,8 @@ static void open_tty(char *tty, struct termios *tp, struct options *op)
 			op->term = DEFAULT_STERM;
 	}
 
-	setenv("TERM", op->term, 1);
+	if (setenv("TERM", op->term, 1) != 0)
+		log_err(_("failed to set the %s environment variable"), "TERM");
 }
 
 /* Initialize termios settings. */
-- 
2.9.3

