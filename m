Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f47.google.com ([209.85.220.47]:39122 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbaLJCkq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 9 Dec 2014 21:40:46 -0500
Received: by mail-pa0-f47.google.com with SMTP id kq14so1826576pab.20
        for <util-linux@vger.kernel.org>; Tue, 09 Dec 2014 18:40:45 -0800 (PST)
From: Will Johansson <will.johansson@gmail.com>
To: util-linux@vger.kernel.org
Cc: Will Johansson <will.johansson@gmail.com>
Subject: [PATCH] login-utils: Enable building util-linux against OpenPAM
Date: Tue,  9 Dec 2014 18:40:31 -0800
Message-Id: <1418179231-21326-2-git-send-email-will.johansson@gmail.com>
In-Reply-To: <1418179231-21326-1-git-send-email-will.johansson@gmail.com>
References: <1418179231-21326-1-git-send-email-will.johansson@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

OpenPAM is compatible with util-linux, with a few changes, namely
using OpenPAM's conversation function, openpam_ttyconv.

We check for Linux-PAM by querying for security/pam_misc.h, and OpenPAM
by querying for security/openpam.h.

Signed-off-by: Will Johansson <will.johansson@gmail.com>
---
 configure.ac              | 29 ++++++++++++++++++++++-------
 include/pamfail.h         |  6 +++++-
 login-utils/Makemodule.am | 22 +++++++++++++++++-----
 login-utils/auth.c        |  5 ++++-
 login-utils/login.c       | 17 +++++++++++++----
 login-utils/su-common.c   | 11 +++++++++--
 6 files changed, 70 insertions(+), 20 deletions(-)

diff --git a/configure.ac b/configure.ac
index b3b6b9f..8eaa0ec 100644
--- a/configure.ac
+++ b/configure.ac
@@ -206,7 +206,7 @@ AC_CHECK_HEADERS([ \
 	netinet/in.h \
 	paths.h \
 	pty.h \
-	security/pam_misc.h \
+	security/pam_appl.h \
 	stdint.h \
 	stdio_ext.h \
 	stdlib.h \
@@ -235,6 +235,20 @@ AC_CHECK_HEADERS([ \
 	unistd.h \
 ])
 
+AC_CHECK_HEADERS([security/pam_misc.h],
+		[AM_CONDITIONAL([HAVE_LINUXPAM], [true])],
+		[AM_CONDITIONAL([HAVE_LINUXPAM], [false])], [
+#ifdef HAVE_SECURITY_PAM_APPL_H
+#include <security/pam_appl.h>
+#endif
+])
+
+AC_CHECK_HEADERS([security/openpam.h], [], [], [
+#ifdef HAVE_SECURITY_PAM_APPL_H
+#include <security/pam_appl.h>
+#endif
+])
+
 AC_CHECK_HEADERS([langinfo.h],
 		[AM_CONDITIONAL([HAVE_LANGINFO], [true])],
 		[AM_CONDITIONAL([HAVE_LANGINFO], [false])])
@@ -244,8 +258,9 @@ dnl
 have_linux_raw_h=$ac_cv_header_linux_raw_h
 have_linux_securebits_h=$ac_cv_header_linux_securebits_h
 have_linux_watchdog_h=$ac_cv_header_linux_watchdog_h
+have_security_pam_appl_h=$ac_cv_header_security_pam_appl_h
 have_security_pam_misc_h=$ac_cv_header_security_pam_misc_h
-
+have_security_openpam_h=$ac_cv_header_security_openpam_h
 
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
 #include <time.h>
@@ -659,7 +674,6 @@ AC_ARG_WITH([ncurses],
   [], [with_ncurses=auto]
 )
 AM_CONDITIONAL([HAVE_NCURSES], [false])
-
 AS_IF([test "x$with_ncurses" != xno], [
   have_ncurses=no
 
@@ -1472,7 +1486,7 @@ AC_ARG_ENABLE([chfn-chsh],
 UL_BUILD_INIT([chfn_chsh])
 
 AS_IF([test "x$enable_chfn_chsh_password" = xyes -o "x$have_user" = xyes], [
-  UL_REQUIRES_HAVE([chfn_chsh], [security_pam_misc_h], [PAM header file])
+  UL_REQUIRES_HAVE([chfn_chsh], [security_pam_appl_h], [PAM header file])
   AC_DEFINE([CHFN_CHSH_PASSWORD], [1], [Should chfn and chsh require the user to enter the password?])
 ])
 AM_CONDITIONAL([BUILD_CHFN_CHSH], [test "x$build_chfn_chsh" = xyes])
@@ -1493,7 +1507,8 @@ AC_ARG_ENABLE([login],
   [], [UL_DEFAULT_ENABLE([login], [check])]
 )
 UL_BUILD_INIT([login])
-UL_REQUIRES_HAVE([login], [security_pam_misc_h], [PAM header file])
+UL_REQUIRES_HAVE([login], [security_pam_appl_h], [PAM header file])
+UL_REQUIRES_HAVE([login], [security_pam_misc_h, security_openpam_h], [PAM conversation functions])
 AM_CONDITIONAL([BUILD_LOGIN], [test "x$build_login" = xyes])
 
 AC_ARG_ENABLE([login-chown-vcs],
@@ -1536,7 +1551,7 @@ AC_ARG_ENABLE([su],
   [], [UL_DEFAULT_ENABLE([su], [check])]
 )
 UL_BUILD_INIT([su])
-UL_REQUIRES_HAVE([su], [security_pam_misc_h], [PAM header file])
+UL_REQUIRES_HAVE([su], [security_pam_appl_h], [PAM header file])
 AM_CONDITIONAL([BUILD_SU], [test "x$build_su" = xyes])
 
 
@@ -1545,7 +1560,7 @@ AC_ARG_ENABLE([runuser],
   [], [UL_DEFAULT_ENABLE([runuser], [check])]
 )
 UL_BUILD_INIT([runuser])
-UL_REQUIRES_HAVE([runuser], [security_pam_misc_h], [PAM header file])
+UL_REQUIRES_HAVE([runuser], [security_pam_appl_h], [PAM header file])
 AM_CONDITIONAL([BUILD_RUNUSER], [test "x$build_runuser" = xyes])
 
 
diff --git a/include/pamfail.h b/include/pamfail.h
index e102df2..bb83b94 100644
--- a/include/pamfail.h
+++ b/include/pamfail.h
@@ -6,7 +6,11 @@
  */
 #ifndef UTIL_LINUX_PAMFAIL_H
 #include <security/pam_appl.h>
-#include <security/pam_misc.h>
+#ifdef HAVE_SECURITY_PAM_MISC_H
+# include <security/pam_misc.h>
+#elif defined(HAVE_SECURITY_OPENPAM_H)
+# include <security/openpam.h>
+#endif
 #include "c.h"
 
 static inline int
diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index 34c5fb4..47291af 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -50,7 +50,10 @@ login_SOURCES = \
 	login-utils/login.c \
 	login-utils/logindefs.c \
 	login-utils/logindefs.h
-login_LDADD = $(LDADD) libcommon.la -lpam -lpam_misc
+login_LDADD = $(LDADD) libcommon.la -lpam
+if HAVE_LINUXPAM
+login_LDADD += -lpam_misc
+endif
 if HAVE_AUDIT
 login_LDADD += -laudit
 endif
@@ -86,11 +89,14 @@ chfn_chsh_ldflags = $(SUID_LDFLAGS) $(AM_LDFLAGS)
 chfn_chsh_ldadd = libcommon.la
 
 if CHFN_CHSH_PASSWORD
-chfn_chsh_ldadd += -lpam -lpam_misc
+chfn_chsh_ldadd += -lpam
+if HAVE_LINUXPAM
+chfn_chsh_ldadd += -lpam_misc
+endif
 chfn_chsh_sources += \
 	login-utils/auth.c \
 	login-utils/auth.h
-endif
+endif # CHFN_CHSH_PASSWORD
 
 if HAVE_USER
 chfn_chsh_ldflags += $(LIBUSER_LIBS)
@@ -136,8 +142,11 @@ su_SOURCES = \
 	login-utils/logindefs.h
 su_CFLAGS = $(SUID_CFLAGS) $(AM_CFLAGS)
 su_LDFLAGS = $(SUID_LDFLAGS) $(AM_LDFLAGS)
-su_LDADD = $(LDADD) libcommon.la -lpam -lpam_misc
+su_LDADD = $(LDADD) libcommon.la -lpam
+if HAVE_LINUXPAM
+su_LDADD += -lpam_misc
 endif
+endif # BUILD_SU
 
 
 if BUILD_RUNUSER
@@ -149,8 +158,11 @@ runuser_SOURCES = \
 	login-utils/su-common.h \
 	login-utils/logindefs.c \
 	login-utils/logindefs.h
-runuser_LDADD = $(LDADD) libcommon.la -lpam -lpam_misc
+runuser_LDADD = $(LDADD) libcommon.la -lpam
+if HAVE_LINUXPAM
+runuser_LDADD += -lpam_misc
 endif
+endif # BUILD_RUNUSER
 
 
 if BUILD_NEWGRP
diff --git a/login-utils/auth.c b/login-utils/auth.c
index 18312d4..aaf6c53 100644
--- a/login-utils/auth.c
+++ b/login-utils/auth.c
@@ -7,7 +7,6 @@
  *   there is no warranty.
  *
  */
-
 #include "auth.h"
 #include "pamfail.h"
 
@@ -15,7 +14,11 @@ int auth_pam(const char *service_name, uid_t uid, const char *username)
 {
 	if (uid != 0) {
 		pam_handle_t *pamh = NULL;
+#ifdef HAVE_SECURITY_PAM_MISC_H
 		struct pam_conv conv = { misc_conv, NULL };
+#elif defined(HAVE_SECURITY_OPENPAM_H)
+		struct pam_conv conv = { openpam_ttyconv, NULL };
+#endif
 		int retcode;
 
 		retcode = pam_start(service_name, username, &conv, &pamh);
diff --git a/login-utils/login.c b/login-utils/login.c
index 5546435..540554e 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -55,7 +55,11 @@
 #include <netdb.h>
 #include <lastlog.h>
 #include <security/pam_appl.h>
-#include <security/pam_misc.h>
+#ifdef HAVE_SECURITY_PAM_MISC_H
+# include <security/pam_misc.h>
+#elif defined(HAVE_SECURITY_OPENPAM_H)
+# include <security/openpam.h>
+#endif
 #include <sys/sendfile.h>
 
 #ifdef HAVE_LIBAUDIT
@@ -1124,9 +1128,14 @@ int main(int argc, char **argv)
 	struct passwd *pwd = NULL, _pwd;
 
 	struct login_context cxt = {
-		.tty_mode = TTY_MODE,		/* tty chmod() */
-		.pid = getpid(),		/* PID */
-		.conv = { misc_conv, NULL }	/* PAM conversation function */
+		.tty_mode = TTY_MODE,		  /* tty chmod() */
+		.pid = getpid(),		  /* PID */
+#ifdef HAVE_SECURITY_PAM_MISC_H
+		.conv = { misc_conv, NULL }	  /* Linux-PAM conversation function */
+#elif defined(HAVE_SECURITY_OPENPAM_H)
+		.conv = { openpam_ttyconv, NULL } /* OpenPAM conversation function */
+#endif
+
 	};
 
 	timeout = (unsigned int)getlogindefs_num("LOGIN_TIMEOUT", LOGIN_TIMEOUT);
diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index eb3b844..57038ce 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -50,7 +50,11 @@ enum
 #include <pwd.h>
 #include <grp.h>
 #include <security/pam_appl.h>
-#include <security/pam_misc.h>
+#ifdef HAVE_SECURITY_PAM_MISC_H
+# include <security/pam_misc.h>
+#elif defined(HAVE_SECURITY_OPENPAM_H)
+# include <security/openpam.h>
+#endif
 #include <signal.h>
 #include <sys/wait.h>
 #include <syslog.h>
@@ -220,8 +224,11 @@ static int su_pam_conv(int num_msg, const struct pam_message **msg,
 	    && msg
 	    && msg[0]->msg_style == PAM_TEXT_INFO)
 		return PAM_SUCCESS;
-
+#ifdef HAVE_SECURITY_PAM_MISC_H
 	return misc_conv(num_msg, msg, resp, appdata_ptr);
+#elif defined(HAVE_SECURITY_OPENPAM_H)
+	return openpam_ttyconv(num_msg, msg, resp, appdata_ptr);
+#endif
 }
 
 static struct pam_conv conv =
-- 
1.8.3.1

