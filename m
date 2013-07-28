Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f181.google.com ([74.125.82.181]:49972 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab3G1VLj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Jul 2013 17:11:39 -0400
Received: by mail-we0-f181.google.com with SMTP id p58so3317762wes.40
        for <util-linux@vger.kernel.org>; Sun, 28 Jul 2013 14:11:38 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 5/7] build-sys: prefer AS_IF rather than shell 'if'
Date: Sun, 28 Jul 2013 22:11:19 +0100
Message-Id: <1375045881-11978-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1375045881-11978-1-git-send-email-kerolasa@iki.fi>
References: <1375045881-11978-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac | 170 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 85 insertions(+), 85 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5bf6f59..6fae31e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -147,12 +147,12 @@ AC_SYS_LARGEFILE
 
 AM_GNU_GETTEXT_VERSION([0.14.1])
 AM_GNU_GETTEXT([external])
-if test -d "$srcdir/po"
-then
-    ALL_LINGUAS=`cd $srcdir/po > /dev/null && echo *.po | sed 's/\.po//g'`
-else
-    ALL_LINGUAS="af am ar as be bg bn_IN bn ca cs cy da de el en_GB es et eu_ES fa fi fr gl gu he hi hr hu hy id is it ja ka kn ko ku lo lt lv mk ml mr ms my nb nl nn no nso or pa pl pt_BR pt ro ru si sk sl sq sr@Latn sr sv ta te th tr uk ur vi zh_CN zh_TW zu"
-fi
+
+AS_IF([test -d "$srcdir/po"], [
+  ALL_LINGUAS=`cd $srcdir/po > /dev/null && echo *.po | sed 's/\.po//g'`
+], [
+  ALL_LINGUAS="af am ar as be bg bn_IN bn ca cs cy da de el en_GB es et eu_ES fa fi fr gl gu he hi hr hu hy id is it ja ka kn ko ku lo lt lv mk ml mr ms my nb nl nn no nso or pa pl pt_BR pt ro ru si sk sl sq sr@Latn sr sv ta te th tr uk ur vi zh_CN zh_TW zu"
+])
 
 AC_CHECK_HEADERS([linux/compiler.h linux/blkpg.h linux/major.h], [], [], [
 #ifdef HAVE_LINUX_COMPILER_H
@@ -330,28 +330,28 @@ AC_CHECK_MEMBER([struct sockaddr.sa_len],
 
 SOCKET_LIBS=
 AC_SEARCH_LIBS([socket], [socket],
-	[if test x"$ac_cv_search_socket" != x"none required"; then
-		SOCKET_LIBS="$SOCKET_LIBS -lsocket";
-	fi])
+	[AS_IF([test x"$ac_cv_search_socket" != x"none required"],
+		[SOCKET_LIBS="$SOCKET_LIBS -lsocket"])
+])
 AC_SUBST([SOCKET_LIBS])
 
 
 have_dirfd=no
 AC_CHECK_FUNCS([dirfd], [have_dirfd=yes], [have_dirfd=no])
-if test x"$have_dirfd" = xno ; then
+AS_IF([test x"$have_dirfd" = xno], [
 	AC_CHECK_DECLS([dirfd],
 		[have_dirfd=yes], [have_dirfd=no],
 		[#include <sys/types.h>
 		 #include <dirent.h>])
-fi
+])
 
 have_ddfd=no
-if test x"$have_dirfd" = xno ; then
+AS_IF([test x"$have_dirfd" = xno], [
 	AC_CHECK_MEMBERS([DIR.dd_fd],
 		[have_ddfd=yes], [have_ddfd=no],
 		[#include <sys/types.h>
 		 #include <dirent.h>])
-fi
+])
 
 AS_CASE([$have_dirfd:$have_ddfd],
   [no:no],
@@ -532,9 +532,9 @@ AC_ARG_WITH([selinux],
   [], [with_selinux=no]
 )
 
-if test "x$with_selinux" = xno; then
+AS_IF([test "x$with_selinux" = xno], [
   AM_CONDITIONAL([HAVE_SELINUX], [false])
-else
+], [
   PKG_CHECK_MODULES([SELINUX], [libselinux >= 2.0],
 	[AC_DEFINE([HAVE_LIBSELINUX], [1], [Define if SELinux is available])
 	 UL_PKG_STATIC([SELINUX_LIBS_STATIC], [libselinux])
@@ -546,13 +546,13 @@ else
     [yes:no], [AC_MSG_ERROR([SELinux selected but libselinux not found or too old])]
   )
 
-  if test "x$have_selinux" = xyes; then
+  AS_IF([test "x$have_selinux" = xyes], [
     UL_SET_FLAGS([], [], [$SELINUX_LIBS])
     # This function is missing in old libselinux 1.xx versions
     AC_CHECK_FUNCS([security_get_initial_context])
     UL_RESTORE_FLAGS
-  fi
-fi
+  ])
+])
 AC_SUBST([SELINUX_LIBS])
 AC_SUBST([SELINUX_LIBS_STATIC])
 
@@ -561,29 +561,29 @@ AC_ARG_WITH([audit],
   [], [with_audit=no]
 )
 
-if test "x$with_audit" = xno; then
+AS_IF([test "x$with_audit" = xno], [
   AM_CONDITIONAL([HAVE_AUDIT], [false])
-else
+], [
   UL_CHECK_LIB([audit], [audit_log_user_message])
   AS_CASE([$with_audit:$have_audit],
     [yes:no],
       [AC_MSG_ERROR([Audit selected but libaudit not found (or does not support audit_log_user_message())])]
   )
-fi
+])
 
 AC_ARG_WITH([udev], AS_HELP_STRING([--without-udev], [compile without udev support]),
   [], [with_udev=auto]
 )
 
-if test "x$with_udev" = xno; then
+AS_IF([test "x$with_udev" = xno], [
   AM_CONDITIONAL([HAVE_UDEV], [false])
-else
+], [
   UL_CHECK_LIB([udev], [udev_new])
   AS_CASE([$with_udev:$have_udev],
     [yes:no],
       [AC_MSG_ERROR([udev selected but libudev not found])]
   )
-fi
+])
 
 AC_ARG_WITH([ncurses],
   AS_HELP_STRING([--with-ncurses], [build with non-wide ncurses, default is wide version
@@ -592,27 +592,27 @@ AC_ARG_WITH([ncurses],
 )
 AM_CONDITIONAL([HAVE_NCURSES], [false])
 
-if test "x$with_ncurses" != xno; then
+AS_IF([test "x$with_ncurses" != xno], [
   have_ncurses=no
   AC_CHECK_HEADERS([ncurses.h ncurses/ncurses.h], [
-    if test "x$with_ncurses" = xauto; then
+    AS_IF([test "x$with_ncurses" = xauto], [
       UL_CHECK_LIB([ncursesw], [initscr], [ncurses])
-      if test "x$have_ncurses" = xyes; then
+      AS_IF([test "x$have_ncurses" = xyes], [
 	AC_CHECK_HEADERS([ncursesw/ncurses.h])
 	NCURSES_LIBS="-lncursesw"
-      fi
-    fi
-    if test "x$have_ncurses" = xno; then
+      ])
+    ])
+    AS_IF([test "x$have_ncurses" = xno], [
       UL_CHECK_LIB(ncurses, initscr)
-      if test "x$have_ncurses" = xyes; then
+      AS_IF([test "x$have_ncurses" = xyes], [
 	NCURSES_LIBS="-lncurses"
-      fi
-    fi
+      ])
+    ])
   ])
-  if test "x$have_ncurses" = xno; then
+  AS_IF([test "x$have_ncurses" = xno], [
     AC_MSG_ERROR([ncurses or ncursesw selected, but library not found (--without-ncurses to disable)])
-  fi
-fi
+  ])
+])
 AC_SUBST([NCURSES_LIBS])
 
 
@@ -621,7 +621,7 @@ AC_ARG_WITH([slang],
   [], [with_slang=no]
 )
 have_slang=no
-if test "x$with_slang" = xyes; then
+AS_IF([test "x$with_slang" = xyes], [
   AC_CHECK_HEADERS([slang.h slang/slang.h])
   AC_CHECK_HEADERS([slcurses.h slang/slcurses.h],
 		   [have_slang=yes], [], [
@@ -631,10 +631,10 @@ if test "x$with_slang" = xyes; then
 #include <slang/slang.h>
 #endif
 ])
-  if test "x$have_slang" = xno; then
+  AS_IF([test "x$have_slang" = xno], [
     AC_MSG_ERROR([slang selected but slcurses.h not found])
-  fi
-fi
+  ])
+])
 AM_CONDITIONAL([HAVE_SLANG], [test "x$have_slang" = xyes])
 
 
@@ -651,21 +651,21 @@ AC_ARG_WITH([utempter],
   [], [with_utempter=no]
 )
 
-if test "x$with_utempter" = xyes; then
+AS_IF([test "x$with_utempter" = xyes], [
   UL_CHECK_LIB([utempter], [utempter_add_record])
-  if test "x$have_utempter" = xno; then
+  AS_IF([test "x$have_utempter" = xno], [
     AC_MSG_ERROR([utempter selected but libutempter not found])
-  fi
-else
+  ])
+], [
   AM_CONDITIONAL([HAVE_UTEMPTER], [false])
-fi
+])
 
 
 AC_ARG_ENABLE([most-builds],
   AS_HELP_STRING([--enable-most-builds], [build everything other than experimental code]),
   [], [enable_most_builds=no]
 )
-if test "x$enable_most_builds" = xyes; then
+AS_IF([test "x$enable_most_builds" = xyes], [
   enable_chfn_chsh=yes
   enable_elvtune=check
   enable_last=yes
@@ -677,7 +677,7 @@ if test "x$enable_most_builds" = xyes; then
   enable_tunelp=yes
   enable_vipw=yes
   enable_write=yes
-fi
+])
 
 dnl
 dnl libuuid
@@ -691,11 +691,11 @@ AC_SUBST([LIBUUID_VERSION])
 AC_SUBST([LIBUUID_VERSION_INFO])
 AM_CONDITIONAL(BUILD_LIBUUID, test "x$build_libuuid" = xyes)
 
-if test "x$enable_libuuid" = xyes; then
+AS_IF([test "x$enable_libuuid" = xyes], [
   AC_DEFINE(HAVE_LIBUUID, 1, [Define to 1 if you have the -luuid.])
-else
+], [
   AC_MSG_WARN([uuid library is not found; mkswap(8) will not generate UUIDs])
-fi
+])
 
 dnl
 dnl libblkid
@@ -710,9 +710,9 @@ AC_SUBST([LIBBLKID_VERSION])
 AC_SUBST([LIBBLKID_VERSION_INFO])
 AC_DEFINE_UNQUOTED([LIBBLKID_VERSION], ["$LIBBLKID_VERSION"], [libblkid version string])
 AC_DEFINE_UNQUOTED([LIBBLKID_DATE], ["$LIBBLKID_DATE"], [libblkid date string])
-if test "x$build_libblkid" = xyes; then
+AS_IF([test "x$build_libblkid" = xyes], [
   AC_DEFINE([HAVE_LIBBLKID], [1], [Define to 1 if you have the -lblkid.])
-fi
+])
 AM_CONDITIONAL([BUILD_LIBBLKID], [test "x$build_libblkid" = xyes])
 AM_CONDITIONAL([BUILD_LIBBLKID_TESTS], [test "x$build_libblkid" = xyes -a "x$enable_static" = xyes])
 
@@ -810,9 +810,9 @@ AC_ARG_ENABLE([uuidd],
 )
 UL_BUILD_INIT([uuidd])
 UL_REQUIRES_BUILD([uuidd], [libuuid])
-if test "x$build_uuidd" = xyes; then
+AS_IF([test "x$build_uuidd" = xyes], [
   AC_DEFINE([HAVE_UUIDD], [1], [Define to 1 if you want to use uuid daemon.])
-fi
+])
 AM_CONDITIONAL([BUILD_UUIDD], [test "x$build_uuidd" = xyes])
 
 
@@ -834,7 +834,7 @@ UL_REQUIRES_LINUX([fallocate])
 UL_REQUIRES_SYSCALL_CHECK([fallocate], [UL_CHECK_SYSCALL([fallocate])])
 AM_CONDITIONAL([BUILD_FALLOCATE], [test "x$build_fallocate" = xyes])
 
-if test "x$build_fallocate" = xyes; then
+AS_IF([test "x$build_fallocate" = xyes], [
   dnl check for valid fallocate() function
   dnl with 32 bits glibc 2.10, fallocate() exists but not fallocate64()
   dnl when _FILE_OFFSET_BITS==64, fallocate() is redirect to fallocate64()
@@ -865,7 +865,7 @@ if test "x$build_fallocate" = xyes; then
   AC_MSG_RESULT([yes])
   AC_DEFINE([HAVE_FALLOCATE], [1], [Have valid fallocate() function])],[
   AC_MSG_RESULT([no])])
-fi
+])
 
 
 AC_ARG_ENABLE([unshare],
@@ -1004,9 +1004,9 @@ UL_BUILD_INIT([prlimit], [check])
 UL_REQUIRES_LINUX([prlimit])
 UL_REQUIRES_SYSCALL_CHECK([prlimit], [UL_CHECK_SYSCALL([prlimit64])], [prlimit64])
 AM_CONDITIONAL([BUILD_PRLIMIT], [test "x$build_prlimit" = xyes])
-if test "x$build_prlimit" = xyes; then
+AS_IF([test "x$build_prlimit" = xyes], [
   AC_CHECK_FUNCS([prlimit])
-fi
+])
 
 
 UL_BUILD_INIT([lslocks], [check])
@@ -1140,7 +1140,7 @@ AC_ARG_WITH([user], AS_HELP_STRING([--without-user], [compile without libuser (r
   [], [with_user=check]
 )
 have_user=no
-if test "x$with_user" != xno; then
+AS_IF([test "x$with_user" != xno], [
   PKG_CHECK_MODULES(LIBUSER,[libuser >= 0.58], [have_user=yes], [have_user=no])
   AS_CASE([$with_user:$have_user],
     [yes:no],
@@ -1150,10 +1150,10 @@ if test "x$with_user" != xno; then
   )
   # temporary solution, libuser has stupid .pc where are exported all
   # private dependencies to Requires: instead of Requires.private:
-  if test "x$have_user" = xyes; then
+  AS_IF([test "x$have_user" = xyes], [
     LIBUSER_LIBS=-luser
-  fi
-fi
+  ])
+])
 AM_CONDITIONAL([HAVE_USER], [test "x$have_user" = xyes])
 
 AC_ARG_ENABLE([chfn-chsh-password],
@@ -1167,10 +1167,10 @@ AC_ARG_ENABLE([chfn-chsh],
 )
 UL_BUILD_INIT([chfn_chsh])
 
-if test "x$enable_chfn_chsh_password" = xyes -o "x$have_user" = xyes; then
+AS_IF([test "x$enable_chfn_chsh_password" = xyes -o "x$have_user" = xyes], [
   UL_REQUIRES_HAVE([chfn_chsh], [security_pam_misc_h], [PAM header file])
   AC_DEFINE([CHFN_CHSH_PASSWORD], [1], [Should chfn and chsh require the user to enter the password?])
-fi
+])
 AM_CONDITIONAL([BUILD_CHFN_CHSH], [test "x$build_chfn_chsh" = xyes])
 AM_CONDITIONAL([CHFN_CHSH_PASSWORD], [test "x$enable_chfn_chsh_password" = xyes])
 
@@ -1179,9 +1179,9 @@ AS_HELP_STRING([--disable-chsh-only-listed], [chsh: allow shells not in /etc/she
 [], enable_chsh_only_listed=yes
 )
 
-if test "x$enable_chsh_only_listed" = xyes; then
-AC_DEFINE([ONLY_LISTED_SHELLS], [1], [Should chsh allow only shells in /etc/shells?])
-fi
+AS_IF([test "x$enable_chsh_only_listed" = xyes], [
+  AC_DEFINE([ONLY_LISTED_SHELLS], [1], [Should chsh allow only shells in /etc/shells?])
+])
 
 
 AC_ARG_ENABLE([login],
@@ -1197,18 +1197,18 @@ AC_ARG_ENABLE([login-chown-vcs],
   [], [enable_login_chown_vcs=no]
 )
 
-if test "x$enable_login_chown_vcs" = xyes; then
+AS_IF([test "x$enable_login_chown_vcs" = xyes], [
   AC_DEFINE([LOGIN_CHOWN_VCS], [1], [Should login chown /dev/vcsN?])
-fi
+])
 
 AC_ARG_ENABLE([login-stat-mail],
   AS_HELP_STRING([--enable-login-stat-mail], [let login stat() the mailbox]),
   [], [enable_login_stat_mail=no]
 )
 
-if test "x$enable_login_stat_mail" = xyes; then
+AS_IF([test "x$enable_login_stat_mail" = xyes], [
   AC_DEFINE([LOGIN_STAT_MAIL], [1], [Should login stat() the mailbox?])
-fi
+])
 
 
 AC_ARG_ENABLE([sulogin],
@@ -1341,17 +1341,17 @@ AC_ARG_ENABLE([socket-activation],
 
 AM_CONDITIONAL([USE_SOCKET_ACTIVATION], [test "x$enable_socket_activation" = xyes])
 
-if test "x$enable_socket_activation" = xyes; then
+AS_IF([test "x$enable_socket_activation" = xyes], [
   AC_DEFINE([USE_SOCKET_ACTIVATION], [1], [Should uuidd support socket activation?])
-fi
+])
 
 AC_ARG_WITH([systemdsystemunitdir],
   AS_HELP_STRING([--with-systemdsystemunitdir=DIR], [directory for systemd service files]),
   [], [with_systemdsystemunitdir=$($PKG_CONFIG --variable=systemdsystemunitdir systemd)])
 
-if test "x$with_systemdsystemunitdir" != "xno"; then
+AS_IF([test "x$with_systemdsystemunitdir" != "xno"], [
   AC_SUBST([systemdsystemunitdir], [$with_systemdsystemunitdir])
-fi
+])
 
 AM_CONDITIONAL([HAVE_SYSTEMD], [test -n "$with_systemdsystemunitdir" -a "x$with_systemdsystemunitdir" != "xno" ])
 
@@ -1380,9 +1380,9 @@ AC_ARG_ENABLE([pg-bell],
   [], [enable_pg_bell=yes]
 )
 
-if test "x$enable_pg_bell" = xyes; then
+AS_IF([test "x$enable_pg_bell" = xyes], [
   AC_DEFINE([PG_BELL], [1], [Should pg ring the bell on invalid keys?])
-fi
+])
 
 
 AC_DEFUN([FS_PATHS_DEFAULT], [/sbin:/sbin/fs.d:/sbin/fs])
@@ -1404,12 +1404,12 @@ AC_ARG_ENABLE([fs-paths-extra],
   [fs_paths_extra=""]
 )
 fs_paths="$fs_paths_defaults"
-if test "x$fs_paths_extra" != "x"; then
-  if test "x$fs_paths" != "x"; then
+AS_IF([test "x$fs_paths_extra" != "x"], [
+  AS_IF([test "x$fs_paths" != "x"], [
     fs_paths="${fs_paths}:"
-  fi
+  ])
   fs_paths="${fs_paths}${fs_paths_extra}"
-fi
+])
 AC_DEFINE_UNQUOTED([FS_SEARCH_PATH], "$fs_paths", [search path for fs helpers])
 
 
@@ -1419,9 +1419,9 @@ AC_ARG_ENABLE([use-tty-group],
 )
 AM_CONDITIONAL([USE_TTY_GROUP], [test "x$enable_use_tty_group" = xyes])
 
-if test "x$enable_use_tty_group" = xyes; then
+AS_IF([test "x$enable_use_tty_group" = xyes], [
   AC_DEFINE([USE_TTY_GROUP], [1], [Should wall and write be installed setgid tty?])
-fi
+])
 
 
 AC_ARG_ENABLE([sulogin-emergency-mount],
@@ -1430,10 +1430,10 @@ AC_ARG_ENABLE([sulogin-emergency-mount],
   [], [enable_sulogin_emergency_mount=no]
 )
 
-if test "x$enable_sulogin_emergency_mount" = xyes; then
+AS_IF([test "x$enable_sulogin_emergency_mount" = xyes], [
   AC_DEFINE([USE_SULOGIN_EMERGENCY_MOUNT], [1],
 	    [Should sulogin use a emergency mount of /dev and /proc?])
-fi
+])
 
 
 AC_ARG_ENABLE([makeinstall-chown],
-- 
1.8.3.4

