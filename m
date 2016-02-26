Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:53466 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752727AbcBZDDh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 25 Feb 2016 22:03:37 -0500
Received: from tenfore.ga-group.nl ([95.114.239.233]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0LguAU-1aBPX72bDC-00oE3x for
 <util-linux@vger.kernel.org>; Fri, 26 Feb 2016 04:03:35 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 09/14] build-sys: disable login-utils if shadow.h or utmp.h is missing
Date: Fri, 26 Feb 2016 04:03:32 +0100
Message-Id: <1456455812-19453-10-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Actually we could have also used UL_REQUIRES_LINUX because our
utmp usage and the shadow.h header is unlikely to be portable.
However only requiring these headers may help others who are
curious what needs to be done to port something.

Note, we could easily make the utmp stuff more portable by using
utmpx which is POSIX standard and on LINUX (glibc) basically just
renaming work. See getutxent(3).

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 80123d9..2f1a687 100644
--- a/configure.ac
+++ b/configure.ac
@@ -256,6 +256,8 @@ AC_CHECK_HEADERS([ \
 	sys/ucred.h \
 	sys/un.h \
 	unistd.h \
+	shadow.h \
+	utmp.h \
 ])
 
 AC_CHECK_HEADERS([security/pam_misc.h],
@@ -285,6 +287,8 @@ have_linux_watchdog_h=$ac_cv_header_linux_watchdog_h
 have_security_pam_appl_h=$ac_cv_header_security_pam_appl_h
 have_security_pam_misc_h=$ac_cv_header_security_pam_misc_h
 have_security_openpam_h=$ac_cv_header_security_openpam_h
+have_shadow_h=$ac_cv_header_shadow_h
+have_utmp_h=$ac_cv_header_utmp_h
 
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
 #include <time.h>
@@ -1204,9 +1208,10 @@ AM_CONDITIONAL([BUILD_EJECT], [test "x$build_eject" = xyes])
 
 AC_ARG_ENABLE([agetty],
   AS_HELP_STRING([--disable-agetty], [do not build agetty]),
-  [], [UL_DEFAULT_ENABLE([agetty], [yes])]
+  [], [UL_DEFAULT_ENABLE([agetty], [check])]
 )
 UL_BUILD_INIT([agetty])
+UL_REQUIRES_HAVE([agetty], [utmp_h], [utmp.h header])
 AM_CONDITIONAL([BUILD_AGETTY], [test "x$build_agetty" = xyes])
 AS_IF([test "x$have_futimens" = xyes -a "x$have_inotify_init1" = xyes ], [
   AC_DEFINE([AGETTY_RELOAD], [1], [Enable agetty --reload feature])
@@ -1307,6 +1312,8 @@ AM_CONDITIONAL([BUILD_LSCPU], [test "x$build_lscpu" = xyes])
 
 UL_BUILD_INIT([lslogins], [check])
 UL_REQUIRES_BUILD([lslogins], [libsmartcols])
+UL_REQUIRES_HAVE([lslogins], [shadow_h], [shadow.h header])
+UL_REQUIRES_HAVE([lslogins], [utmp_h], [utmp.h header])
 AM_CONDITIONAL([BUILD_LSLOGINS], [test "x$build_lslogins" = xyes])
 
 
@@ -1526,14 +1533,16 @@ AC_ARG_ENABLE([last],
   [], [UL_DEFAULT_ENABLE([last], [check])]
 )
 UL_BUILD_INIT([last])
+UL_REQUIRES_HAVE([last], [utmp_h], [utmp.h header])
 AM_CONDITIONAL([BUILD_LAST], [test "x$build_last" = xyes])
 
 
 AC_ARG_ENABLE([utmpdump],
   AS_HELP_STRING([--disable-utmpdump], [do not build utmpdump]),
-  [], [UL_DEFAULT_ENABLE([utmpdump], [yes])]
+  [], [UL_DEFAULT_ENABLE([utmpdump], [check])]
 )
 UL_BUILD_INIT([utmpdump])
+UL_REQUIRES_HAVE([utmpdump], [utmp_h], [utmp.h header])
 AM_CONDITIONAL([BUILD_UTMPDUMP], [test "x$build_utmpdump" = xyes])
 
 
@@ -1584,6 +1593,7 @@ AC_ARG_ENABLE([vipw],
   [], [UL_DEFAULT_ENABLE([vipw], [no])]
 )
 UL_BUILD_INIT([vipw])
+UL_REQUIRES_HAVE([vipw], [shadow_h], [shadow.h header])
 AM_CONDITIONAL([BUILD_VIPW], [test "x$build_vipw" = xyes])
 
 
@@ -1625,6 +1635,7 @@ AC_ARG_ENABLE([chfn-chsh],
   [], [UL_DEFAULT_ENABLE([chfn_chsh], [check])]
 )
 UL_BUILD_INIT([chfn_chsh])
+UL_REQUIRES_HAVE([chfn_chsh], [shadow_h], [shadow.h header])
 
 AS_IF([test "x$enable_chfn_chsh_password" = xyes -o "x$have_user" = xyes], [
   UL_REQUIRES_HAVE([chfn_chsh], [security_pam_appl_h], [PAM header file])
@@ -1650,6 +1661,7 @@ AC_ARG_ENABLE([login],
 UL_BUILD_INIT([login])
 UL_REQUIRES_HAVE([login], [security_pam_appl_h], [PAM header file])
 UL_REQUIRES_HAVE([login], [security_pam_misc_h, security_openpam_h], [PAM conversation functions])
+UL_REQUIRES_HAVE([login], [utmp_h], [utmp.h header])
 AM_CONDITIONAL([BUILD_LOGIN], [test "x$build_login" = xyes])
 
 AC_ARG_ENABLE([login-chown-vcs],
@@ -1681,9 +1693,10 @@ AM_CONDITIONAL([BUILD_NOLOGIN], [test "x$build_nologin" = xyes])
 
 AC_ARG_ENABLE([sulogin],
   AS_HELP_STRING([--disable-sulogin], [do not build sulogin]),
-  [], [UL_DEFAULT_ENABLE([sulogin], [yes])]
+  [], [UL_DEFAULT_ENABLE([sulogin], [check])]
 )
 UL_BUILD_INIT([sulogin])
+UL_REQUIRES_HAVE([sulogin], [shadow_h], [shadow.h header])
 AM_CONDITIONAL([BUILD_SULOGIN], [test "x$build_sulogin" = xyes])
 
 
@@ -1693,6 +1706,7 @@ AC_ARG_ENABLE([su],
 )
 UL_BUILD_INIT([su])
 UL_REQUIRES_HAVE([su], [security_pam_appl_h], [PAM header file])
+UL_REQUIRES_HAVE([su], [utmp_h], [utmp.h header])
 AM_CONDITIONAL([BUILD_SU], [test "x$build_su" = xyes])
 
 
@@ -1702,6 +1716,7 @@ AC_ARG_ENABLE([runuser],
 )
 UL_BUILD_INIT([runuser])
 UL_REQUIRES_HAVE([runuser], [security_pam_appl_h], [PAM header file])
+UL_REQUIRES_HAVE([runuser], [utmp_h], [utmp.h header])
 AM_CONDITIONAL([BUILD_RUNUSER], [test "x$build_runuser" = xyes])
 
 
@@ -1796,9 +1811,10 @@ AS_IF([test "x$build_chrt" = xyes], [
 
 AC_ARG_ENABLE([wall],
   AS_HELP_STRING([--disable-wall], [do not build wall]),
-  [], [UL_DEFAULT_ENABLE([wall], [yes])]
+  [], [UL_DEFAULT_ENABLE([wall], [check])]
 )
 UL_BUILD_INIT([wall])
+UL_REQUIRES_HAVE([wall], [utmp_h], [utmp.h header])
 AM_CONDITIONAL([BUILD_WALL], [test "x$build_wall" = xyes])
 
 
@@ -1807,6 +1823,7 @@ AC_ARG_ENABLE([write],
   [], [UL_DEFAULT_ENABLE([write], [no])]
 )
 UL_BUILD_INIT([write])
+UL_REQUIRES_HAVE([write], [utmp_h], [utmp.h header])
 AM_CONDITIONAL([BUILD_WRITE], [test "x$build_write" = xyes])
 
 
-- 
1.8.4.5

