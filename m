Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35688 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941746AbcJYUes (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 25 Oct 2016 16:34:48 -0400
Received: by mail-qk0-f196.google.com with SMTP id v138so16487847qka.2
        for <util-linux@vger.kernel.org>; Tue, 25 Oct 2016 13:34:47 -0700 (PDT)
From: Ray Strode <halfline@gmail.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Ray Strode <rstrode@redhat.com>
Subject: [PATCH] login-utils: import environment from user manager on systemd systems
Date: Tue, 25 Oct 2016 16:34:21 -0400
Message-Id: <1477427661-19788-1-git-send-email-halfline@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ray Strode <rstrode@redhat.com>

If the user is using a systemd system, then its useful to grab the
environment from the systemd user manager process.

This allows administrators to initialize the environment of the sessions
via systemd configuration.

Reference: https://github.com/systemd/systemd/pull/3904
Signed-off-by: Ray Strode <rstrode@redhat.com>
---
 login-utils/Makemodule.am |  5 +++
 login-utils/login.c       | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index be07ace..d65bfc1 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -16,70 +16,75 @@ endif
 if BUILD_SULOGIN
 sbin_PROGRAMS += sulogin
 dist_man_MANS += login-utils/sulogin.8
 sulogin_SOURCES = \
 	login-utils/sulogin.c \
 	login-utils/sulogin-consoles.c \
 	login-utils/sulogin-consoles.h
 sulogin_LDADD = $(LDADD) libcommon.la
 
 if HAVE_LIBCRYPT
 sulogin_LDADD += -lcrypt
 endif
 if HAVE_SELINUX
 sulogin_LDADD += -lselinux
 endif
 
 check_PROGRAMS += test_consoles
 test_consoles_SOURCES = login-utils/sulogin-consoles.c
 test_consoles_CFLAGS = $(AM_CFLAGS) -DTEST_PROGRAM
 test_consoles_LDADD = $(LDADD) libcommon.la
 endif # BUILD_SULOGIN
 
 
 if BUILD_LOGIN
 bin_PROGRAMS += login
 dist_man_MANS += login-utils/login.1
 login_SOURCES = \
 	login-utils/login.c \
 	login-utils/logindefs.c \
 	login-utils/logindefs.h
+login_CFLAGS =
 login_LDADD = $(LDADD) libcommon.la -lpam
 if HAVE_LINUXPAM
 login_LDADD += -lpam_misc
 endif
 if HAVE_AUDIT
 login_LDADD += -laudit
 endif
 if HAVE_SELINUX
 login_LDADD += -lselinux
 endif
+if HAVE_SYSTEMD
+login_LDADD += $(SYSTEMD_LIBS)
+login_CFLAGS += $(SYSTEMD_CFLAGS)
+endif
 endif # BUILD_LOGIN
 
 
 if BUILD_NOLOGIN
 sbin_PROGRAMS += nologin
 dist_man_MANS += login-utils/nologin.8
 nologin_SOURCES = login-utils/nologin.c
 endif
 
 
 if BUILD_UTMPDUMP
 usrbin_exec_PROGRAMS += utmpdump
 dist_man_MANS += login-utils/utmpdump.1
 utmpdump_SOURCES = login-utils/utmpdump.c
 utmpdump_LDADD = $(LDADD) libcommon.la
 endif
 
 
 if BUILD_CHFN_CHSH
 usrbin_exec_PROGRAMS += chfn chsh
 dist_man_MANS += \
 	login-utils/chfn.1 \
 	login-utils/chsh.1
 
 chfn_chsh_sources = \
 	login-utils/ch-common.h \
 	login-utils/ch-common.c
 chfn_chsh_cflags = $(SUID_CFLAGS) $(AM_CFLAGS)
 chfn_chsh_ldflags = $(SUID_LDFLAGS) $(AM_LDFLAGS)
 chfn_chsh_ldadd = libcommon.la
diff --git a/login-utils/login.c b/login-utils/login.c
index 2350fc3..9a9a86e 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -37,69 +37,74 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <sys/file.h>
 #include <termios.h>
 #include <string.h>
 #include <sys/ioctl.h>
 #include <sys/wait.h>
 #include <signal.h>
 #include <errno.h>
 #include <grp.h>
 #include <pwd.h>
 #include <utmp.h>
 #include <stdlib.h>
 #include <sys/syslog.h>
 #ifdef HAVE_LINUX_MAJOR_H
 # include <linux/major.h>
 #endif
 #include <netdb.h>
 #include <security/pam_appl.h>
 #ifdef HAVE_SECURITY_PAM_MISC_H
 # include <security/pam_misc.h>
 #elif defined(HAVE_SECURITY_OPENPAM_H)
 # include <security/openpam.h>
 #endif
 #include <sys/sendfile.h>
 
 #ifdef HAVE_LIBAUDIT
 # include <libaudit.h>
 #endif
 
+#ifdef HAVE_LIBSYSTEMD
+# include <systemd/sd-bus.h>
+#endif
+
 #include "c.h"
 #include "setproctitle.h"
 #include "pathnames.h"
 #include "strutils.h"
 #include "nls.h"
 #include "env.h"
 #include "xalloc.h"
 #include "all-io.h"
 #include "fileutils.h"
+#include "strv.h"
 #include "ttyutils.h"
 
 #include "logindefs.h"
 
 #define is_pam_failure(_rc)	((_rc) != PAM_SUCCESS)
 
 #define LOGIN_MAX_TRIES        3
 #define LOGIN_EXIT_TIMEOUT     5
 #define LOGIN_TIMEOUT          60
 
 #ifdef USE_TTY_GROUP
 # define TTY_MODE 0620
 #else
 # define TTY_MODE 0600
 #endif
 
 #define	TTYGRPNAME	"tty"	/* name of group to own ttys */
 #define VCS_PATH_MAX	64
 
 /*
  * Login control struct
  */
 struct login_context {
 	const char	*tty_path;	/* ttyname() return value */
 	const char	*tty_name;	/* tty_path without /dev prefix */
 	const char	*tty_number;	/* end of the tty_path */
 	mode_t		tty_mode;	/* chmod() mode */
 
 	char		*username;	/* from command line or PAM */
 
@@ -994,108 +999,187 @@ static void fork_session(struct login_context *cxt)
 
 	/*
 	 * child
 	 */
 	sigaction(SIGHUP, &oldsa_hup, NULL);		/* restore old state */
 	sigaction(SIGTERM, &oldsa_term, NULL);
 	if (got_sig)
 		exit(EXIT_FAILURE);
 
 	/*
 	 * Problem: if the user's shell is a shell like ash that doesn't do
 	 * setsid() or setpgrp(), then a ctrl-\, sending SIGQUIT to every
 	 * process in the pgrp, will kill us.
 	 */
 
 	/* start new session */
 	setsid();
 
 	/* make sure we have a controlling tty */
 	open_tty(cxt->tty_path);
 	openlog("login", LOG_ODELAY, LOG_AUTHPRIV);	/* reopen */
 
 	/*
 	 * TIOCSCTTY: steal tty from other process group.
 	 */
 	if (ioctl(0, TIOCSCTTY, 1))
 		syslog(LOG_ERR, _("TIOCSCTTY failed: %m"));
 	signal(SIGINT, SIG_DFL);
 }
 
+#ifdef HAVE_LIBSYSTEMD
+/*
+ * Import environment from systemd user manager
+ */
+static void import_systemd_user_environ(struct login_context *cxt)
+{
+	struct passwd *pwd = cxt->pwd;
+	int rc;
+	sd_bus *bus = NULL;
+	sd_bus_error error = SD_BUS_ERROR_NULL;
+	sd_bus_message *reply = NULL;
+	char *env_entry = NULL;
+	uid_t old_euid = geteuid();
+	int euid_changed = 0;
+
+	if (pwd->pw_uid != 0) {
+		assert(old_euid == getuid());
+
+		if (seteuid(pwd->pw_uid) < 0) {
+			syslog(LOG_ERR, _("seteuid failed: %m"));
+			return;
+		}
+		euid_changed = 1;
+	}
+
+	rc = sd_bus_default_user(&bus);
+
+	if (rc < 0) {
+		syslog(LOG_NOTICE, _("user bus unavailable: %m"));
+		return;
+	}
+
+	rc = sd_bus_get_property(bus,
+				 "org.freedesktop.systemd1",
+				 "/org/freedesktop/systemd1",
+				 "org.freedesktop.systemd1.Manager",
+				 "Environment",
+				 &error,
+				 &reply,
+				 "as");
+
+	if (rc < 0) {
+		syslog(LOG_NOTICE, _("user bus unable to return environment: %m"));
+		goto out;
+	}
+
+	rc = sd_bus_message_enter_container(reply, SD_BUS_TYPE_ARRAY, "s");
+
+	if (rc < 0)
+		goto out;
+
+	while ((rc = sd_bus_message_read_basic(reply, SD_BUS_TYPE_STRING, &env_entry)) > 0) {
+		char **env_tuple;
+
+		env_tuple = strv_split(env_entry, "=");
+
+		if (env_tuple && env_tuple[0] && env_tuple[1])
+			xsetenv(env_tuple[0], env_tuple[1], 0);
+
+		strv_free (env_tuple);
+	}
+	sd_bus_message_exit_container(reply);
+
+out:
+	sd_bus_error_free(&error);
+	reply = sd_bus_message_unref(reply);
+	bus = sd_bus_unref(bus);
+
+	if (euid_changed && seteuid(old_euid) < 0) {
+		syslog(LOG_ALERT, _("seteuid() failed"));
+		exit(EXIT_FAILURE);
+	}
+}
+#endif
+
 /*
  * Initialize $TERM, $HOME, ...
  */
 static void init_environ(struct login_context *cxt)
 {
 	struct passwd *pwd = cxt->pwd;
 	char *termenv, **env;
 	char tmp[PATH_MAX];
 	int len, i;
 
 	termenv = getenv("TERM");
 	if (termenv)
 		termenv = xstrdup(termenv);
 
 	/* destroy environment unless user has requested preservation (-p) */
 	if (!cxt->keep_env) {
 		environ = xmalloc(sizeof(char *));
 		memset(environ, 0, sizeof(char *));
 	}
 
 	xsetenv("HOME", pwd->pw_dir, 0);	/* legal to override */
 	xsetenv("USER", pwd->pw_name, 1);
 	xsetenv("SHELL", pwd->pw_shell, 1);
 	xsetenv("TERM", termenv ? termenv : "dumb", 1);
 	free(termenv);
 
 	if (pwd->pw_uid) {
 		if (logindefs_setenv("PATH", "ENV_PATH", _PATH_DEFPATH) != 0)
 			err(EXIT_FAILURE, _("failed to set the %s environment variable"), "PATH");
 
 	} else if (logindefs_setenv("PATH", "ENV_ROOTPATH", NULL) != 0 &&
 		   logindefs_setenv("PATH", "ENV_SUPATH", _PATH_DEFPATH_ROOT) != 0) {
 			err(EXIT_FAILURE, _("failed to set the %s environment variable"), "PATH");
 	}
 
 	/* mailx will give a funny error msg if you forget this one */
 	len = snprintf(tmp, sizeof(tmp), "%s/%s", _PATH_MAILDIR, pwd->pw_name);
 	if (len > 0 && (size_t) len < sizeof(tmp))
 		xsetenv("MAIL", tmp, 0);
 
 	/* LOGNAME is not documented in login(1) but HP-UX 6.5 does it. We'll
 	 * not allow modifying it.
 	 */
 	xsetenv("LOGNAME", pwd->pw_name, 1);
 
 	env = pam_getenvlist(cxt->pamh);
 	for (i = 0; env && env[i]; i++)
 		putenv(env[i]);
+
+#ifdef HAVE_LIBSYSTEMD
+	import_systemd_user_environ(cxt);
+#endif
 }
 
 /*
  * This is called for the -h option, initializes cxt->{hostname,hostaddress}.
  */
 static void init_remote_info(struct login_context *cxt, char *remotehost)
 {
 	const char *domain;
 	char *p;
 	struct addrinfo hints, *info = NULL;
 
 	cxt->remote = 1;
 
 	get_thishost(cxt, &domain);
 
 	if (domain && (p = strchr(remotehost, '.')) &&
 	    strcasecmp(p + 1, domain) == 0)
 		*p = '\0';
 
 	cxt->hostname = xstrdup(remotehost);
 
 	memset(&hints, 0, sizeof(hints));
 	hints.ai_flags = AI_ADDRCONFIG;
 	cxt->hostaddress[0] = 0;
 
 	if (getaddrinfo(cxt->hostname, NULL, &hints, &info) == 0 && info) {
 		if (info->ai_family == AF_INET) {
 			struct sockaddr_in *sa =
 				    (struct sockaddr_in *) info->ai_addr;
 
-- 
2.7.4

