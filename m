Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:64210 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab3G1VLg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Jul 2013 17:11:36 -0400
Received: by mail-wg0-f46.google.com with SMTP id k13so4263812wgh.25
        for <util-linux@vger.kernel.org>; Sun, 28 Jul 2013 14:11:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/7] build-sys: prefer AS_CASE rather than shell 'case'
Date: Sun, 28 Jul 2013 22:11:18 +0100
Message-Id: <1375045881-11978-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1375045881-11978-1-git-send-email-kerolasa@iki.fi>
References: <1375045881-11978-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

References: http://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/html_node/Limitations-of-Builtins.html#case
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac | 161 ++++++++++++++++++++++++++---------------------------------
 1 file changed, 72 insertions(+), 89 deletions(-)

diff --git a/configure.ac b/configure.ac
index fc45a5e..5bf6f59 100644
--- a/configure.ac
+++ b/configure.ac
@@ -47,29 +47,21 @@ LIBMOUNT_LT_MICRO=0
 LIBMOUNT_VERSION_INFO=`expr $LIBMOUNT_LT_MAJOR + $LIBMOUNT_LT_MINOR`:$LIBMOUNT_LT_MICRO:$LIBMOUNT_LT_MINOR
 
 # Check whether exec_prefix=/usr:
-case $exec_prefix:$prefix in
-NONE:NONE | NONE:/usr | /usr:*)
-  AC_MSG_NOTICE([Default --exec-prefix detected.])
-  case $bindir in
-  '${exec_prefix}/bin') bindir=/bin
-    AC_MSG_NOTICE([  --bindir defaults to /bin]) ;;
-  esac
-  case $sbindir in
-  '${exec_prefix}/sbin') sbindir=/sbin
-    AC_MSG_NOTICE([  --sbindir defaults to /sbin]) ;;
-  esac
-  case $libdir in
-  '${exec_prefix}/lib') libdir=/lib
-    AC_MSG_NOTICE([  --libdir defaults to /lib]) ;;
-  esac ;;
-esac
-
-case $prefix:$localstatedir in
-  NONE:'${prefix}/var' | /usr:'${prefix}/var')
-    localstatedir=/run
-    AC_MSG_NOTICE([  --localstatedir defaults to /run])
-    ;;
-esac
+AS_CASE([$exec_prefix:$prefix],
+[NONE:NONE | NONE:/usr | /usr:*],
+  [AC_MSG_NOTICE([Default --exec-prefix detected.])
+   AS_CASE([$bindir],  [${exec_prefix}/bin],  [bindir=/bin;  AC_MSG_NOTICE([  --bindir defaults to /bin])  ])
+   AS_CASE([$sbindir], [${exec_prefix}/sbin], [bindir=/sbin; AC_MSG_NOTICE([  --sbindir defaults to /sbin])])
+   AS_CASE([$libdir],  [${exec_prefix}/lib],  [bindir=/lib;  AC_MSG_NOTICE([  --libdir defaults to /lib])  ])
+  ]
+)
+
+AS_CASE([$prefix:$localstatedir],
+  [NONE:${prefix}/var | /usr:${prefix}/var],
+    [localstatedir=/run
+     AC_MSG_NOTICE([  --localstatedir defaults to /run])
+    ]
+)
 AC_SUBST([localstatedir])
 
 
@@ -80,12 +72,11 @@ AC_SUBST([usrbin_execdir])
 usrsbin_execdir='${exec_prefix}/sbin'
 AC_SUBST([usrsbin_execdir])
 
-case $libdir in
- '${exec_prefix}/'* | '${prefix}/'* | /usr/*)
-    usrlib_execdir=$libdir ;;
- *)
-    usrlib_execdir='${exec_prefix}'$libdir ;;
-esac
+AS_CASE([$libdir],
+ [${exec_prefix}/* | ${prefix}/* | /usr/*],
+   [usrlib_execdir=$libdir],
+ [usrlib_execdir='${exec_prefix}'$libdir]
+)
 AC_SUBST([usrlib_execdir])
 
 
@@ -138,11 +129,7 @@ GTK_DOC_CHECK([1.10])
 AC_PATH_PROG([XSLTPROC], [xsltproc])
 
 linux_os=no
-case ${host_os} in
-  *linux*)
-    linux_os=yes
-    ;;
-esac
+AS_CASE([${host_os}], [*linux*], [linux_os=yes])
 AM_CONDITIONAL([LINUX], [test "x$linux_os" = xyes])
 
 dnl define ARCH_<NAME> conditionals
@@ -366,10 +353,10 @@ if test x"$have_dirfd" = xno ; then
 		 #include <dirent.h>])
 fi
 
-case "$have_dirfd:$have_ddfd" in
-no:no)
-  AC_MSG_ERROR([cannot find a method to get filedescriptor of directory]) ;;
-esac
+AS_CASE([$have_dirfd:$have_ddfd],
+  [no:no],
+    [AC_MSG_ERROR([cannot find a method to get filedescriptor of directory])]
+)
 
 
 AC_MSG_CHECKING([whether program_invocation_short_name is defined])
@@ -401,16 +388,18 @@ AC_ARG_ENABLE([static-programs],
       [link static the programs in LIST (comma-separated,
       supported for ]m4_defn([UL_STATIC_PROGRAMS])[)])])
 
-case $enable_static_programs in
-yes) enable_static_programs=m4_quote([UL_STATIC_PROGRAMS]) ;;
-no) enable_static_programs= ;;
-esac
+AS_CASE([$enable_static_programs],
+  [yes],
+    [enable_static_programs=m4_quote([UL_STATIC_PROGRAMS])],
+  [no],
+    [enable_static_programs=]
+)
 
 dnl Set all the individual AM_CONDITIONALs
 m4_foreach([UL_PRG], m4_defn([UL_STATIC_PROGRAMS]), [
-  case ,$enable_static_programs, in
-   *,UL_PRG,*) static_[]UL_PRG=yes ;;
-  esac
+  AS_CASE([,$enable_static_programs,],
+   [*,UL_PRG,*], [static_[]UL_PRG=yes]
+  )
   AM_CONDITIONAL([HAVE_STATIC_]m4_toupper(UL_PRG),
     [test "x$static_[]UL_PRG" = xyes])
 ])
@@ -458,22 +447,18 @@ AC_CACHE_VAL([scanf_cv_alloc_modifier],
 )
 
 AC_MSG_CHECKING([scanf string alloc modifiers])
-case "$scanf_cv_alloc_modifier" in
-ms)
-  AC_MSG_RESULT([(%ms) yes])
-  AC_DEFINE([HAVE_SCANF_MS_MODIFIER], [1], [scanf %ms modifier])
-  have_scanf_alloc_modifier=yes
-  ;;
-as)
-  AC_MSG_RESULT([(%as) yes])
-  have_scanf_alloc_modifier=yes
-  AC_DEFINE([HAVE_SCANF_AS_MODIFIER], [1], [scanf %as modifier])
-  ;;
-*)
-  AC_MSG_RESULT([no])
-  have_scanf_alloc_modifier=no
-  ;;
-esac
+AS_CASE([$scanf_cv_alloc_modifier],
+  [ms],
+    [AC_MSG_RESULT([(%ms) yes])
+     AC_DEFINE([HAVE_SCANF_MS_MODIFIER], [1], [scanf %ms modifier])
+     have_scanf_alloc_modifier=yes],
+  [as],
+    [AC_MSG_RESULT([(%as) yes])
+     have_scanf_alloc_modifier=yes
+     AC_DEFINE([HAVE_SCANF_AS_MODIFIER], [1], [scanf %as modifier])],
+  [AC_MSG_RESULT([no])
+   have_scanf_alloc_modifier=no]
+)
 
 UL_CHECK_LIB([util], [openpty])
 UL_CHECK_LIB([termcap], [tgetnum])
@@ -557,9 +542,9 @@ else
 	 have_selinux=yes],
 	[have_selinux=no])
 
-  case "$with_selinux:$have_selinux" in
-  yes:no) AC_MSG_ERROR([SELinux selected but libselinux not found or too old]);;
-  esac
+  AS_CASE([$with_selinux:$have_selinux],
+    [yes:no], [AC_MSG_ERROR([SELinux selected but libselinux not found or too old])]
+  )
 
   if test "x$have_selinux" = xyes; then
     UL_SET_FLAGS([], [], [$SELINUX_LIBS])
@@ -580,11 +565,10 @@ if test "x$with_audit" = xno; then
   AM_CONDITIONAL([HAVE_AUDIT], [false])
 else
   UL_CHECK_LIB([audit], [audit_log_user_message])
-  case "$with_audit:$have_audit" in
-  yes:no)
-   AC_MSG_ERROR([Audit selected but libaudit not found (or does not support audit_log_user_message())])
-   ;;
-  esac
+  AS_CASE([$with_audit:$have_audit],
+    [yes:no],
+      [AC_MSG_ERROR([Audit selected but libaudit not found (or does not support audit_log_user_message())])]
+  )
 fi
 
 AC_ARG_WITH([udev], AS_HELP_STRING([--without-udev], [compile without udev support]),
@@ -595,11 +579,10 @@ if test "x$with_udev" = xno; then
   AM_CONDITIONAL([HAVE_UDEV], [false])
 else
   UL_CHECK_LIB([udev], [udev_new])
-  case "$with_udev:$have_udev" in
-  yes:no)
-   AC_MSG_ERROR([udev selected but libudev not found])
-   ;;
-  esac
+  AS_CASE([$with_udev:$have_udev],
+    [yes:no],
+      [AC_MSG_ERROR([udev selected but libudev not found])]
+  )
 fi
 
 AC_ARG_WITH([ncurses],
@@ -1159,12 +1142,12 @@ AC_ARG_WITH([user], AS_HELP_STRING([--without-user], [compile without libuser (r
 have_user=no
 if test "x$with_user" != xno; then
   PKG_CHECK_MODULES(LIBUSER,[libuser >= 0.58], [have_user=yes], [have_user=no])
-  case "$with_user:$have_user" in
-  yes:no)
-   AC_MSG_ERROR([user selected but libuser not found]) ;;
-  *:yes)
-   AC_DEFINE([HAVE_LIBUSER], [1], [Define if libuser is available]) ;;
-  esac
+  AS_CASE([$with_user:$have_user],
+    [yes:no],
+      [AC_MSG_ERROR([user selected but libuser not found])],
+    [*:yes],
+      [AC_DEFINE([HAVE_LIBUSER], [1], [Define if libuser is available])]
+  )
   # temporary solution, libuser has stupid .pc where are exported all
   # private dependencies to Requires: instead of Requires.private:
   if test "x$have_user" = xyes; then
@@ -1405,19 +1388,19 @@ fi
 AC_DEFUN([FS_PATHS_DEFAULT], [/sbin:/sbin/fs.d:/sbin/fs])
 AC_ARG_ENABLE([fs-paths-default],
   AS_HELP_STRING([--enable-fs-paths-default=paths], [default search path for fs helpers @<:@FS_PATHS_DEFAULT@:>@]),
-  [case "$enableval" in
-     yes) fs_paths_defaults="FS_PATHS_DEFAULT" ;;
-      no) fs_paths_defaults="" ;;
-       *) fs_paths_defaults="$enableval" ;;
-   esac],
+  [AS_CASE([$enableval],
+    [yes], [fs_paths_defaults="FS_PATHS_DEFAULT"],
+    [no],  [fs_paths_defaults=""],
+    [fs_paths_defaults="$enableval"]
+  )],
   [fs_paths_defaults="FS_PATHS_DEFAULT"]
 )
 AC_ARG_ENABLE([fs-paths-extra],
   AS_HELP_STRING([--enable-fs-paths-extra=paths], [additional search paths for fs helpers]),
-  [case "$enableval" in
-     yes|no) fs_paths_extra="" ;;
-	  *) fs_paths_extra="$enableval" ;;
-    esac],
+  [AS_CASE([$enableval],
+     [yes|no], [fs_paths_extra=""],
+     [fs_paths_extra="$enableval"]
+  )],
   [fs_paths_extra=""]
 )
 fs_paths="$fs_paths_defaults"
-- 
1.8.3.4

