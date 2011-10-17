Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 05/49] build-sys: require PAM for login-utils
Date: Mon, 17 Oct 2011 13:14:44 +0200
Message-Id: <1318850128-23458-6-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 configure.ac |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/configure.ac b/configure.ac
index 88aced9..66d0794 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1099,19 +1099,12 @@ AC_ARG_ENABLE([login-utils],
 )
 AM_CONDITIONAL(BUILD_LOGIN_UTILS, test "x$enable_login_utils" = xyes)
 
-AC_ARG_WITH([pam],
-  [AS_HELP_STRING([--without-pam], [compile login-utils without PAM support])])
-
-AM_CONDITIONAL(HAVE_PAM, false)
-if test "x$enable_login_utils" = xyes && test "x$with_pam" != xno; then
-  AC_CHECK_HEADERS([security/pam_misc.h],
-    [AM_CONDITIONAL(HAVE_PAM, true)],
-    [if test "x$with_pam" = xyes; then
-	AC_MSG_ERROR([PAM selected but security/pam_misc.h not found])
-     fi
-    ])
+if test "x$enable_login_utils" = xyes; then
+  AC_CHECK_HEADERS([security/pam_misc.h], [],
+    [AC_MSG_ERROR([login-utils enabled, but security/pam_misc.h not found])])
 fi
 
+
 AC_ARG_WITH([selinux],
   AS_HELP_STRING([--with-selinux], [compile with SELinux support]),
   [], with_selinux=no
-- 
1.7.6.4
