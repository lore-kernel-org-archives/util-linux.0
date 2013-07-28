Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f169.google.com ([74.125.82.169]:61662 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab3G1VLe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Jul 2013 17:11:34 -0400
Received: by mail-we0-f169.google.com with SMTP id n5so2629435wev.0
        for <util-linux@vger.kernel.org>; Sun, 28 Jul 2013 14:11:32 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/7] build-sys: use m4 quoting consistently
Date: Sun, 28 Jul 2013 22:11:17 +0100
Message-Id: <1375045881-11978-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1375045881-11978-1-git-send-email-kerolasa@iki.fi>
References: <1375045881-11978-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac | 400 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 200 insertions(+), 200 deletions(-)

diff --git a/configure.ac b/configure.ac
index 006de93..fc45a5e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,11 +1,11 @@
-AC_INIT(util-linux,
+AC_INIT([util-linux],
 	m4_esyscmd([tools/git-version-gen .tarball-version]),
 	[kzak@redhat.com],,
 	[http://www.kernel.org/pub/linux/utils/util-linux/])
 
-AC_PREREQ(2.60)
+AC_PREREQ([2.60])
 
-AC_CONFIG_AUX_DIR(config)
+AC_CONFIG_AUX_DIR([config])
 AC_CONFIG_MACRO_DIR([m4])
 dnl AC_USE_SYSTEM_EXTENSIONS must be called before any macros that run
 dnl the compiler (like AC_PROG_LIBTOOL) to avoid autoconf errors.
@@ -15,7 +15,7 @@ AM_INIT_AUTOMAKE([-Wall foreign 1.10 tar-pax dist-bzip2 no-dist-gzip dist-xz -Wn
 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])],
 			    [AC_SUBST([AM_DEFAULT_VERBOSITY], [1])])
 
-AC_CONFIG_SRCDIR(sys-utils/mount.c)
+AC_CONFIG_SRCDIR([sys-utils/mount.c])
 AC_PREFIX_DEFAULT([/usr])
 
 dnl version details from <major>.<minor>[-<suffix>]
@@ -120,7 +120,7 @@ UL_WARN_ADD([-Wstrict-prototypes])
 UL_WARN_ADD([-Wformat-security])
 AC_SUBST([WARN_CFLAGS])
 
-UL_WARN_ADD([-Wno-clobbered], BSD_WARN_CFLAGS)
+UL_WARN_ADD([-Wno-clobbered], [BSD_WARN_CFLAGS])
 AC_SUBST([BSD_WARN_CFLAGS])
 
 dnl libtool-2
@@ -143,18 +143,18 @@ case ${host_os} in
     linux_os=yes
     ;;
 esac
-AM_CONDITIONAL([LINUX], test "x$linux_os" = xyes)
+AM_CONDITIONAL([LINUX], [test "x$linux_os" = xyes])
 
 dnl define ARCH_<NAME> conditionals
-UL_SET_ARCH(I86, i?86-*)
-UL_SET_ARCH(86_64, x86_64*)
-UL_SET_ARCH(IA64, ia64*)
-UL_SET_ARCH(S390, s390*)
-UL_SET_ARCH(SPARC, sparc*)
-UL_SET_ARCH(PPC, ppc*|powerpc*)
-UL_SET_ARCH(M68K, m68*)
-UL_SET_ARCH(MIPS, mips*)
-UL_SET_ARCH(HPPA, hppa*)
+UL_SET_ARCH([I86], [i?86-*])
+UL_SET_ARCH([86_64], [x86_64*])
+UL_SET_ARCH([IA64], [ia64*])
+UL_SET_ARCH([S390], [s390*])
+UL_SET_ARCH([SPARC], [sparc*])
+UL_SET_ARCH([PPC], [ppc*|powerpc*])
+UL_SET_ARCH([M68K], [m68*])
+UL_SET_ARCH([MIPS], [mips*])
+UL_SET_ARCH([HPPA], [hppa*])
 
 AC_SYS_LARGEFILE
 
@@ -243,7 +243,7 @@ AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
     if (a == -1)  /* false */
 	sleep(tm->tm_gmtoff);
 ]])],
-[AC_DEFINE(HAVE_TM_GMTOFF,1,[Does struct tm have a field tm_gmtoff?])
+[AC_DEFINE([HAVE_TM_GMTOFF], [1], [Does struct tm have a field tm_gmtoff?])
 ])
 
 AC_CHECK_MEMBERS([struct termios.c_line],,,
@@ -260,7 +260,7 @@ AC_COMPILE_IFELSE([AC_LANG_PROGRAM(
 #include <unistd.h>
 ]],
 [[swapon("/dev/null", 0);]])],
-[AC_DEFINE(SWAPON_HAS_TWO_ARGS, 1, [Is swapon() declared with two parameters?])
+[AC_DEFINE([SWAPON_HAS_TWO_ARGS], [1], [Is swapon() declared with two parameters?])
 ],
 [AC_MSG_NOTICE([Your libc thinks that swapon has 1 arg only.])
 ])
@@ -269,13 +269,13 @@ AC_COMPILE_IFELSE([AC_LANG_PROGRAM(
 AC_CHECK_DECLS([_NL_TIME_WEEK_1STDAY],[],[],[[#include <langinfo.h>]])
 
 AC_CHECK_DECL([llseek],
-	[AC_DEFINE(HAVE_LLSEEK_PROTOTYPE, 1,
+	[AC_DEFINE([HAVE_LLSEEK_PROTOTYPE], [1],
 			[Define to 1 if have llseek prototype])],
 	[],
 	[#include <unistd.h>])
 
 AC_CHECK_DECL([lseek64],
-	[AC_DEFINE(HAVE_LSEEK64_PROTOTYPE, 1,
+	[AC_DEFINE([HAVE_LSEEK64_PROTOTYPE], [1],
 			[Define to 1 if have lseek64 prototype])],
 	[],
 	[#define _LARGEFILE_SOURCE
@@ -283,12 +283,12 @@ AC_CHECK_DECL([lseek64],
 	 #include <unistd.h>])
 
 AC_CHECK_DECL([environ],
-	[AC_DEFINE(HAVE_ENVIRON_DECL, 1,
+	[AC_DEFINE([HAVE_ENVIRON_DECL], [1],
 		[Define to 1 if have **environ prototype])],
 )
 
 AC_CHECK_DECL([strsignal],
-	[AC_DEFINE(HAVE_STRSIGNAL_DECL, 1,
+	[AC_DEFINE([HAVE_STRSIGNAL_DECL], [1],
 		[Define to 1 if have strsignal function prototype])],
 )
 
@@ -336,8 +336,8 @@ AC_FUNC_FSEEKO
 AC_CHECK_FUNCS([openat fstatat unlinkat], [have_openat=yes], [have_openat=no])
 AC_CHECK_FUNCS([ioperm iopl], [have_io=yes])
 
-AC_CHECK_MEMBER(struct sockaddr.sa_len,
-		AC_DEFINE_UNQUOTED(HAVE_SA_LEN,1,[Define if struct sockaddr contains sa_len]),,
+AC_CHECK_MEMBER([struct sockaddr.sa_len],
+		AC_DEFINE_UNQUOTED([HAVE_SA_LEN], [1], [Define if struct sockaddr contains sa_len]), [],
 	[#include <sys/types.h>
 	 #include <sys/socket.h>])
 
@@ -389,9 +389,9 @@ AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
 AC_MSG_CHECKING([whether __progname is defined])
 AC_LINK_IFELSE([AC_LANG_PROGRAM([extern char *__progname;],
 	   [if (*__progname == 0) return;])],
-	   AC_DEFINE(HAVE___PROGNAME, 1, [Define if __progname is defined])
-	   AC_MSG_RESULT(yes),
-	   AC_MSG_RESULT(no))
+	   AC_DEFINE([HAVE___PROGNAME], [1], [Define if __progname is defined])
+	   AC_MSG_RESULT([yes]),
+	   AC_MSG_RESULT([no]))
 
 dnl Static compilation
 m4_define([UL_STATIC_PROGRAMS], [losetup, mount, umount, fdisk, sfdisk, blkid])
@@ -402,7 +402,7 @@ AC_ARG_ENABLE([static-programs],
       supported for ]m4_defn([UL_STATIC_PROGRAMS])[)])])
 
 case $enable_static_programs in
-yes) enable_static_programs=m4_quote(UL_STATIC_PROGRAMS) ;;
+yes) enable_static_programs=m4_quote([UL_STATIC_PROGRAMS]) ;;
 no) enable_static_programs= ;;
 esac
 
@@ -475,13 +475,13 @@ as)
   ;;
 esac
 
-UL_CHECK_LIB(util, openpty)
-UL_CHECK_LIB(termcap, tgetnum)
+UL_CHECK_LIB([util], [openpty])
+UL_CHECK_LIB([termcap], [tgetnum])
 
 AC_CHECK_TYPES([union semun], [], [], [[
 #include <sys/sem.h>
 ]])
-AC_CHECK_TYPES(loff_t)
+AC_CHECK_TYPES([loff_t])
 
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
 #include <wchar.h>
@@ -495,14 +495,14 @@ AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
   wc = w;
   fputwc(wc,stdout);
 ]])],
-[AC_DEFINE(HAVE_WIDECHAR,1,Do we have wide character support?)
+[AC_DEFINE([HAVE_WIDECHAR], [1], [Do we have wide character support?])
 ])
 
 AC_CHECK_TYPES([cpu_set_t], [have_cpu_set_t=yes], [], [[
 #include <sched.h>
 ]])
 
-AM_CONDITIONAL(HAVE_CPU_SET_T, [test "x$have_cpu_set_t" = xyes])
+AM_CONDITIONAL([HAVE_CPU_SET_T], [test "x$have_cpu_set_t" = xyes])
 
 AC_CHECK_DECLS([CPU_ALLOC], [], [], [[
 #include <sched.h>
@@ -533,27 +533,27 @@ char *c = crypt("abc","pw");
   ]], [[
   char *c = crypt("abc","pw");
   ]])],[
-  AC_DEFINE(HAVE_LIBCRYPT, 1, [Do we need -lcrypt?])
+  AC_DEFINE([HAVE_LIBCRYPT], [1], [Do we need -lcrypt?])
   have_libcrypt=yes
   ],[
   AC_MSG_ERROR([crypt() is not available])
   ])
 ])
-AM_CONDITIONAL(HAVE_LIBCRYPT, test "x$have_libcrypt" = xyes)
+AM_CONDITIONAL([HAVE_LIBCRYPT], [test "x$have_libcrypt" = xyes])
 
 
 AC_ARG_WITH([selinux],
   AS_HELP_STRING([--with-selinux], [compile with SELinux support]),
-  [], with_selinux=no
+  [], [with_selinux=no]
 )
 
 if test "x$with_selinux" = xno; then
-  AM_CONDITIONAL(HAVE_SELINUX, false)
+  AM_CONDITIONAL([HAVE_SELINUX], [false])
 else
   PKG_CHECK_MODULES([SELINUX], [libselinux >= 2.0],
-	[AC_DEFINE(HAVE_LIBSELINUX, 1, [Define if SELinux is available])
+	[AC_DEFINE([HAVE_LIBSELINUX], [1], [Define if SELinux is available])
 	 UL_PKG_STATIC([SELINUX_LIBS_STATIC], [libselinux])
-	 AM_CONDITIONAL(HAVE_SELINUX, true)
+	 AM_CONDITIONAL([HAVE_SELINUX], [true])
 	 have_selinux=yes],
 	[have_selinux=no])
 
@@ -573,13 +573,13 @@ AC_SUBST([SELINUX_LIBS_STATIC])
 
 AC_ARG_WITH([audit],
   AS_HELP_STRING([--with-audit], [compile with audit support]),
-  [], with_audit=no
+  [], [with_audit=no]
 )
 
 if test "x$with_audit" = xno; then
-  AM_CONDITIONAL(HAVE_AUDIT, false)
+  AM_CONDITIONAL([HAVE_AUDIT], [false])
 else
-  UL_CHECK_LIB(audit, audit_log_user_message)
+  UL_CHECK_LIB([audit], [audit_log_user_message])
   case "$with_audit:$have_audit" in
   yes:no)
    AC_MSG_ERROR([Audit selected but libaudit not found (or does not support audit_log_user_message())])
@@ -588,13 +588,13 @@ else
 fi
 
 AC_ARG_WITH([udev], AS_HELP_STRING([--without-udev], [compile without udev support]),
-  [], with_udev=auto
+  [], [with_udev=auto]
 )
 
 if test "x$with_udev" = xno; then
-  AM_CONDITIONAL(HAVE_UDEV, false)
+  AM_CONDITIONAL([HAVE_UDEV], [false])
 else
-  UL_CHECK_LIB(udev, udev_new)
+  UL_CHECK_LIB([udev], [udev_new])
   case "$with_udev:$have_udev" in
   yes:no)
    AC_MSG_ERROR([udev selected but libudev not found])
@@ -605,15 +605,15 @@ fi
 AC_ARG_WITH([ncurses],
   AS_HELP_STRING([--with-ncurses], [build with non-wide ncurses, default is wide version
 				    (--without-ncurses disables all ncurses(w) support)]),
-  [], with_ncurses=auto
+  [], [with_ncurses=auto]
 )
-AM_CONDITIONAL(HAVE_NCURSES, false)
+AM_CONDITIONAL([HAVE_NCURSES], [false])
 
 if test "x$with_ncurses" != xno; then
   have_ncurses=no
   AC_CHECK_HEADERS([ncurses.h ncurses/ncurses.h], [
     if test "x$with_ncurses" = xauto; then
-      UL_CHECK_LIB(ncursesw, initscr, ncurses)
+      UL_CHECK_LIB([ncursesw], [initscr], [ncurses])
       if test "x$have_ncurses" = xyes; then
 	AC_CHECK_HEADERS([ncursesw/ncurses.h])
 	NCURSES_LIBS="-lncursesw"
@@ -635,7 +635,7 @@ AC_SUBST([NCURSES_LIBS])
 
 AC_ARG_WITH([slang],
   AS_HELP_STRING([--with-slang], [compile cfdisk with slang]),
-  [], with_slang=no
+  [], [with_slang=no]
 )
 have_slang=no
 if test "x$with_slang" = xyes; then
@@ -652,35 +652,35 @@ if test "x$with_slang" = xyes; then
     AC_MSG_ERROR([slang selected but slcurses.h not found])
   fi
 fi
-AM_CONDITIONAL(HAVE_SLANG, test "x$have_slang" = xyes)
+AM_CONDITIONAL([HAVE_SLANG], [test "x$have_slang" = xyes])
 
 
-AM_CONDITIONAL(BUILD_CFDISK, test "x$have_slang" = xyes -o "x$have_ncurses" = xyes)
+AM_CONDITIONAL([BUILD_CFDISK], [test "x$have_slang" = xyes -o "x$have_ncurses" = xyes])
 
 
 have_tinfo=no
-AC_CHECK_LIB(tinfo, tgetent, [have_tinfo=yes])
-AM_CONDITIONAL(HAVE_TINFO, test "x$have_tinfo" = xyes)
+AC_CHECK_LIB([tinfo], [tgetent], [have_tinfo=yes])
+AM_CONDITIONAL([HAVE_TINFO], [test "x$have_tinfo" = xyes])
 
 
 AC_ARG_WITH([utempter],
   AS_HELP_STRING([--with-utempter], [compile script(1) with libutempter]),
-  [], with_utempter=no
+  [], [with_utempter=no]
 )
 
 if test "x$with_utempter" = xyes; then
-  UL_CHECK_LIB(utempter, utempter_add_record)
+  UL_CHECK_LIB([utempter], [utempter_add_record])
   if test "x$have_utempter" = xno; then
     AC_MSG_ERROR([utempter selected but libutempter not found])
   fi
 else
-  AM_CONDITIONAL(HAVE_UTEMPTER, false)
+  AM_CONDITIONAL([HAVE_UTEMPTER], [false])
 fi
 
 
 AC_ARG_ENABLE([most-builds],
   AS_HELP_STRING([--enable-most-builds], [build everything other than experimental code]),
-  [], enable_most_builds=no
+  [], [enable_most_builds=no]
 )
 if test "x$enable_most_builds" = xyes; then
   enable_chfn_chsh=yes
@@ -701,7 +701,7 @@ dnl libuuid
 dnl
 AC_ARG_ENABLE([libuuid],
   AS_HELP_STRING([--disable-libuuid], [do not build libuuid and uuid utilities]),
-  [], enable_libuuid=yes
+  [], [enable_libuuid=yes]
 )
 UL_BUILD_INIT([libuuid])
 AC_SUBST([LIBUUID_VERSION])
@@ -719,37 +719,37 @@ dnl libblkid
 dnl
 AC_ARG_ENABLE([libblkid],
   AS_HELP_STRING([--disable-libblkid], [do not build libblkid and many related utilities]),
-  [], enable_libblkid=yes
+  [], [enable_libblkid=yes]
 )
 UL_BUILD_INIT([libblkid])
 AC_SUBST([LIBBLKID_DATE])
 AC_SUBST([LIBBLKID_VERSION])
 AC_SUBST([LIBBLKID_VERSION_INFO])
-AC_DEFINE_UNQUOTED(LIBBLKID_VERSION, "$LIBBLKID_VERSION", [libblkid version string])
-AC_DEFINE_UNQUOTED(LIBBLKID_DATE, "$LIBBLKID_DATE", [libblkid date string])
+AC_DEFINE_UNQUOTED([LIBBLKID_VERSION], ["$LIBBLKID_VERSION"], [libblkid version string])
+AC_DEFINE_UNQUOTED([LIBBLKID_DATE], ["$LIBBLKID_DATE"], [libblkid date string])
 if test "x$build_libblkid" = xyes; then
-  AC_DEFINE(HAVE_LIBBLKID, 1, [Define to 1 if you have the -lblkid.])
+  AC_DEFINE([HAVE_LIBBLKID], [1], [Define to 1 if you have the -lblkid.])
 fi
-AM_CONDITIONAL(BUILD_LIBBLKID, test "x$build_libblkid" = xyes)
-AM_CONDITIONAL(BUILD_LIBBLKID_TESTS, test "x$build_libblkid" = xyes -a "x$enable_static" = xyes)
+AM_CONDITIONAL([BUILD_LIBBLKID], [test "x$build_libblkid" = xyes])
+AM_CONDITIONAL([BUILD_LIBBLKID_TESTS], [test "x$build_libblkid" = xyes -a "x$enable_static" = xyes])
 
 dnl
 dnl libmount
 dnl
 AC_ARG_ENABLE([libmount],
   AS_HELP_STRING([--disable-libmount], [do not build libmount]),
-  [], enable_libmount=check
+  [], [enable_libmount=check]
 )
 UL_BUILD_INIT([libmount])
 UL_REQUIRES_LINUX([libmount])
 UL_REQUIRES_BUILD([libmount], [libblkid])
 UL_REQUIRES_HAVE([libmount], [scanf_alloc_modifier], [scanf string alloc modifier])
-AM_CONDITIONAL(BUILD_LIBMOUNT, test "x$build_libmount" = xyes)
-AM_CONDITIONAL(BUILD_LIBMOUNT_TESTS, test "x$build_libmount" = xyes -a "x$enable_static" = xyes)
+AM_CONDITIONAL([BUILD_LIBMOUNT], [test "x$build_libmount" = xyes])
+AM_CONDITIONAL([BUILD_LIBMOUNT_TESTS], [test "x$build_libmount" = xyes -a "x$enable_static" = xyes])
 
 AC_SUBST([LIBMOUNT_VERSION])
 AC_SUBST([LIBMOUNT_VERSION_INFO])
-AC_DEFINE_UNQUOTED(LIBMOUNT_VERSION, "$LIBMOUNT_VERSION", [libmount version string])
+AC_DEFINE_UNQUOTED([LIBMOUNT_VERSION], ["$LIBMOUNT_VERSION"], [libmount version string])
 
 
 dnl
@@ -757,99 +757,99 @@ dnl libfdisk is enabled all time if possible
 dnl
 UL_BUILD_INIT([libfdisk], [check])
 UL_REQUIRES_BUILD([libfdisk], [libuuid])
-AM_CONDITIONAL(BUILD_LIBFDISK, test "x$build_libfdisk" = xyes)
+AM_CONDITIONAL([BUILD_LIBFDISK], [test "x$build_libfdisk" = xyes])
 
 UL_BUILD_INIT([fdisk], [check])
 UL_REQUIRES_BUILD([fdisk], [libfdisk])
-AM_CONDITIONAL(BUILD_FDISK, test "x$build_fdisk" = xyes)
+AM_CONDITIONAL([BUILD_FDISK], [test "x$build_fdisk" = xyes])
 
 
 AC_ARG_ENABLE([deprecated-mount],
   AS_HELP_STRING([--enable-deprecated-mount], [build old mount utilities]),
-  [], enable_deprecated_mount=no
+  [], [enable_deprecated_mount=no]
 )
 UL_BUILD_INIT([deprecated_mount])
 UL_REQUIRES_LINUX([deprecated_mount])
 UL_REQUIRES_BUILD([deprecated_mount], [libblkid])
-AM_CONDITIONAL(BUILD_DEPRECATED_MOUNT, test "x$build_deprecated_mount" = xyes)
+AM_CONDITIONAL([BUILD_DEPRECATED_MOUNT], [test "x$build_deprecated_mount" = xyes])
 
 
 AC_ARG_ENABLE([mount],
   AS_HELP_STRING([--disable-mount], [do not build mount(8) and umount(8)]),
-  [], enable_mount=check
+  [], [enable_mount=check]
 )
 UL_BUILD_INIT([mount])
 UL_REQUIRES_BUILD([mount], [libmount])
 UL_CONFLICTS_BUILD([mount], [deprecated_mount], [old deprecated mount version])
-AM_CONDITIONAL(BUILD_MOUNT, test "x$build_mount" = xyes)
+AM_CONDITIONAL([BUILD_MOUNT], [test "x$build_mount" = xyes])
 
 
 AC_ARG_ENABLE([losetup],
   AS_HELP_STRING([--disable-losetup], [do not build losetup]),
-  [], enable_losetup=check
+  [], [enable_losetup=check]
 )
 UL_BUILD_INIT([losetup])
 UL_REQUIRES_LINUX([losetup])
-AM_CONDITIONAL(BUILD_LOSETUP, test "x$build_losetup" = xyes)
+AM_CONDITIONAL([BUILD_LOSETUP], [test "x$build_losetup" = xyes])
 
 
 AC_ARG_ENABLE([cytune],
   AS_HELP_STRING([--disable-cytune], [do not build cytune]),
-  [], enable_cytune=check
+  [], [enable_cytune=check]
 )
 UL_BUILD_INIT([cytune])
 UL_REQUIRES_LINUX([cytune])
-AM_CONDITIONAL(BUILD_CYTUNE, test "x$build_cytune" = xyes)
+AM_CONDITIONAL([BUILD_CYTUNE], [test "x$build_cytune" = xyes])
 
 
 AC_ARG_ENABLE([fsck],
   AS_HELP_STRING([--disable-fsck], [do not build fsck]),
-  [], enable_fsck=check
+  [], [enable_fsck=check]
 )
 UL_BUILD_INIT([fsck])
 UL_REQUIRES_BUILD([fsck], [libmount])
-AM_CONDITIONAL(BUILD_FSCK, test "x$build_fsck" = xyes)
+AM_CONDITIONAL([BUILD_FSCK], [test "x$build_fsck" = xyes])
 
 
 AC_ARG_ENABLE([partx],
   AS_HELP_STRING([--disable-partx], [do not build addpart, delpart, partx]),
-  [], enable_partx=check
+  [], [enable_partx=check]
 )
 UL_BUILD_INIT([partx])
 UL_REQUIRES_LINUX([partx])
 UL_REQUIRES_BUILD([partx], [libblkid])
-AM_CONDITIONAL(BUILD_PARTX, test "x$build_partx" = xyes)
+AM_CONDITIONAL([BUILD_PARTX], [test "x$build_partx" = xyes])
 
 
 AC_ARG_ENABLE([uuidd],
   AS_HELP_STRING([--disable-uuidd], [do not build the uuid daemon]),
-  [], enable_uuidd=check
+  [], [enable_uuidd=check]
 )
 UL_BUILD_INIT([uuidd])
 UL_REQUIRES_BUILD([uuidd], [libuuid])
 if test "x$build_uuidd" = xyes; then
-  AC_DEFINE(HAVE_UUIDD, 1, [Define to 1 if you want to use uuid daemon.])
+  AC_DEFINE([HAVE_UUIDD], [1], [Define to 1 if you want to use uuid daemon.])
 fi
-AM_CONDITIONAL(BUILD_UUIDD, test "x$build_uuidd" = xyes)
+AM_CONDITIONAL([BUILD_UUIDD], [test "x$build_uuidd" = xyes])
 
 
 AC_ARG_ENABLE([mountpoint],
   AS_HELP_STRING([--disable-mountpoint], [do not build mountpoint]),
-  [], enable_mountpoint=check
+  [], [enable_mountpoint=check]
 )
 UL_BUILD_INIT([mountpoint])
 UL_REQUIRES_BUILD([mountpoint], [libmount])
-AM_CONDITIONAL(BUILD_MOUNTPOINT, test "x$build_mountpoint" = xyes)
+AM_CONDITIONAL([BUILD_MOUNTPOINT], [test "x$build_mountpoint" = xyes])
 
 
 AC_ARG_ENABLE([fallocate],
   AS_HELP_STRING([--disable-fallocate], [do not build fallocate]),
-  [], enable_fallocate=check
+  [], [enable_fallocate=check]
 )
 UL_BUILD_INIT([fallocate])
 UL_REQUIRES_LINUX([fallocate])
 UL_REQUIRES_SYSCALL_CHECK([fallocate], [UL_CHECK_SYSCALL([fallocate])])
-AM_CONDITIONAL(BUILD_FALLOCATE, test "x$build_fallocate" = xyes)
+AM_CONDITIONAL([BUILD_FALLOCATE], [test "x$build_fallocate" = xyes])
 
 if test "x$build_fallocate" = xyes; then
   dnl check for valid fallocate() function
@@ -880,29 +880,29 @@ if test "x$build_fallocate" = xyes; then
    }
    ]])],[
   AC_MSG_RESULT([yes])
-  AC_DEFINE(HAVE_FALLOCATE,1,[Have valid fallocate() function])],[
+  AC_DEFINE([HAVE_FALLOCATE], [1], [Have valid fallocate() function])],[
   AC_MSG_RESULT([no])])
 fi
 
 
 AC_ARG_ENABLE([unshare],
   AS_HELP_STRING([--disable-unshare], [do not build unshare]),
-  [], enable_unshare=check
+  [], [enable_unshare=check]
 )
 UL_BUILD_INIT([unshare])
 UL_REQUIRES_LINUX([unshare])
 UL_REQUIRES_SYSCALL_CHECK([unshare], [UL_CHECK_SYSCALL([unshare])])
-AM_CONDITIONAL(BUILD_UNSHARE, test "x$build_unshare" = xyes)
+AM_CONDITIONAL([BUILD_UNSHARE], [test "x$build_unshare" = xyes])
 AC_CHECK_FUNCS([unshare])
 
 AC_ARG_ENABLE([nsenter],
   AS_HELP_STRING([--disable-nsenter], [do not build nsenter]),
-  [], enable_nsenter=check
+  [], [enable_nsenter=check]
 )
 UL_BUILD_INIT([nsenter])
 UL_REQUIRES_LINUX([nsenter])
 UL_REQUIRES_SYSCALL_CHECK([nsenter], [UL_CHECK_SYSCALL([setns])], [setns])
-AM_CONDITIONAL(BUILD_NSENTER, test "x$build_nsenter" = xyes)
+AM_CONDITIONAL([BUILD_NSENTER], [test "x$build_nsenter" = xyes])
 AC_CHECK_FUNCS([setns])
 
 dnl setpriv depends on libcap-ng.  It would be possible to build
@@ -911,116 +911,116 @@ dnl but this isn't currently supported.
 UL_CHECK_LIB([cap-ng], [capng_apply], [cap_ng])
 AC_ARG_ENABLE([setpriv],
   AS_HELP_STRING([--disable-setpriv], [do not build setpriv]),
-  [], enable_setpriv=check
+  [], [enable_setpriv=check]
 )
 UL_BUILD_INIT([setpriv])
 UL_REQUIRES_LINUX([setpriv])
 UL_REQUIRES_HAVE([setpriv], [linux_securebits_h], [securebits.h header file])
 UL_REQUIRES_HAVE([setpriv], [cap_ng], [libcap-ng library])
-AM_CONDITIONAL(BUILD_SETPRIV, test "x$build_setpriv" = xyes)
+AM_CONDITIONAL([BUILD_SETPRIV], [test "x$build_setpriv" = xyes])
 
 
 AC_ARG_ENABLE([eject],
   AS_HELP_STRING([--disable-eject], [do not build eject]),
-  [], enable_eject=check
+  [], [enable_eject=check]
 )
 UL_BUILD_INIT([eject])
 UL_REQUIRES_LINUX([eject])
 UL_REQUIRES_BUILD([eject], [libmount])
-AM_CONDITIONAL(BUILD_EJECT, test "x$build_eject" = xyes)
+AM_CONDITIONAL([BUILD_EJECT], [test "x$build_eject" = xyes])
 
 
 AC_ARG_ENABLE([agetty],
   AS_HELP_STRING([--disable-agetty], [do not build agetty]),
-  [], enable_agetty=yes
+  [], [enable_agetty=yes]
 )
 UL_BUILD_INIT([agetty])
-AM_CONDITIONAL(BUILD_AGETTY, test "x$build_agetty" = xyes)
+AM_CONDITIONAL([BUILD_AGETTY], [test "x$build_agetty" = xyes])
 
 
 AC_ARG_ENABLE([cramfs],
   AS_HELP_STRING([--disable-cramfs], [do not build fsck.cramfs, mkfs.cramfs]),
-  [], enable_cramfs=check
+  [], [enable_cramfs=check]
 )
 UL_BUILD_INIT([cramfs])
-AC_CHECK_LIB(z, crc32, [have_z=yes], [have_z=no])
+AC_CHECK_LIB([z], [crc32], [have_z=yes], [have_z=no])
 UL_REQUIRES_HAVE([cramfs], [z], [z library])
-AM_CONDITIONAL(BUILD_CRAMFS, test "x$build_cramfs" = xyes)
+AM_CONDITIONAL([BUILD_CRAMFS], [test "x$build_cramfs" = xyes])
 
 
 AC_ARG_ENABLE([bfs],
   AS_HELP_STRING([--disable-bfs], [do not build mkfs.bfs]),
-  [], enable_bfs=yes
+  [], [enable_bfs=yes]
 )
 UL_BUILD_INIT([bfs])
-AM_CONDITIONAL(BUILD_BFS, test "x$build_bfs" = xyes)
+AM_CONDITIONAL([BUILD_BFS], [test "x$build_bfs" = xyes])
 
 
 AC_ARG_ENABLE([fdformat],
   AS_HELP_STRING([--disable-fdformat], [do not build fdformat]),
-  [], enable_fdformat=check
+  [], [enable_fdformat=check]
 )
 UL_BUILD_INIT([fdformat])
 UL_REQUIRES_LINUX([fdformat])
-AM_CONDITIONAL(BUILD_FDFORMAT, test "x$build_fdformat" = xyes)
+AM_CONDITIONAL([BUILD_FDFORMAT], [test "x$build_fdformat" = xyes])
 
 
 AC_ARG_ENABLE([hwclock],
   AS_HELP_STRING([--disable-hwclock], [do not build hwclock]),
-  [], enable_hwclock=check
+  [], [enable_hwclock=check]
 )
 have_linuxdummy=$linux_os
 
 UL_BUILD_INIT([hwclock])
 UL_REQUIRES_HAVE([hwclock], [io, linuxdummy], [ioperm iopl function or Linux])
-AM_CONDITIONAL(BUILD_HWCLOCK, test "x$build_hwclock" = xyes)
+AM_CONDITIONAL([BUILD_HWCLOCK], [test "x$build_hwclock" = xyes])
 
 
 UL_BUILD_INIT([swapon], [check])
 UL_REQUIRES_LINUX([swapon])
 UL_REQUIRES_BUILD([swapon], [libblkid])
 UL_REQUIRES_BUILD([swapon], [libmount])
-AM_CONDITIONAL(BUILD_SWAPON, test "x$build_swapon" = xyes)
+AM_CONDITIONAL([BUILD_SWAPON], [test "x$build_swapon" = xyes])
 
 
 UL_BUILD_INIT([lsblk], [check])
 UL_REQUIRES_LINUX([lsblk])
 UL_REQUIRES_BUILD([lsblk], [libblkid])
 UL_REQUIRES_BUILD([lsblk], [libmount])
-AM_CONDITIONAL(BUILD_LSBLK, test "x$build_lsblk" = xyes)
+AM_CONDITIONAL([BUILD_LSBLK], [test "x$build_lsblk" = xyes])
 
 
 UL_BUILD_INIT([lscpu], [check])
 UL_REQUIRES_LINUX([lscpu])
 UL_REQUIRES_HAVE([lscpu], [cpu_set_t], [cpu_set_t type])
-AM_CONDITIONAL(BUILD_LSCPU, test "x$build_lscpu" = xyes)
+AM_CONDITIONAL([BUILD_LSCPU], [test "x$build_lscpu" = xyes])
 
 
 UL_BUILD_INIT([chcpu], [check])
 UL_REQUIRES_LINUX([chcpu])
 UL_REQUIRES_HAVE([chcpu], [cpu_set_t], [cpu_set_t type])
-AM_CONDITIONAL(BUILD_CHCPU, test "x$build_chcpu" = xyes)
+AM_CONDITIONAL([BUILD_CHCPU], [test "x$build_chcpu" = xyes])
 
 
 AC_ARG_ENABLE([wdctl],
   AS_HELP_STRING([--disable-wdctl], [do not build wdctl]),
-  [], enable_wdctl=check
+  [], [enable_wdctl=check]
 )
 UL_BUILD_INIT([wdctl])
 UL_REQUIRES_LINUX([wdctl])
 UL_REQUIRES_HAVE([wdctl], [linux_watchdog_h], [linux/watchdog.h header file])
-AM_CONDITIONAL(BUILD_WDCTL, test "x$build_wdctl" = xyes)
+AM_CONDITIONAL([BUILD_WDCTL], [test "x$build_wdctl" = xyes])
 
 
 UL_BUILD_INIT([swaplabel], [check])
 UL_REQUIRES_BUILD([swaplabel], [libblkid])
-AM_CONDITIONAL(BUILD_SWAPLABEL, test "x$build_swaplabel" = xyes)
+AM_CONDITIONAL([BUILD_SWAPLABEL], [test "x$build_swaplabel" = xyes])
 
 
 UL_BUILD_INIT([prlimit], [check])
 UL_REQUIRES_LINUX([prlimit])
 UL_REQUIRES_SYSCALL_CHECK([prlimit], [UL_CHECK_SYSCALL([prlimit64])], [prlimit64])
-AM_CONDITIONAL(BUILD_PRLIMIT, test "x$build_prlimit" = xyes)
+AM_CONDITIONAL([BUILD_PRLIMIT], [test "x$build_prlimit" = xyes])
 if test "x$build_prlimit" = xyes; then
   AC_CHECK_FUNCS([prlimit])
 fi
@@ -1029,132 +1029,132 @@ fi
 UL_BUILD_INIT([lslocks], [check])
 UL_REQUIRES_LINUX([lslocks])
 UL_REQUIRES_BUILD([lslocks], [libmount])
-AM_CONDITIONAL(BUILD_LSLOCKS, test "x$build_lslocks" = xyes)
+AM_CONDITIONAL([BUILD_LSLOCKS], [test "x$build_lslocks" = xyes])
 
 
 AC_ARG_ENABLE([switch_root],
   AS_HELP_STRING([--disable-switch_root], [do not build switch_root]),
-  [], enable_switch_root=check
+  [], [enable_switch_root=check]
 )
 UL_BUILD_INIT([switch_root])
 UL_REQUIRES_LINUX([switch_root])
 UL_REQUIRES_HAVE([switch_root], [openat], [openat function])
-AM_CONDITIONAL(BUILD_SWITCH_ROOT, test "x$build_switch_root" = xyes)
+AM_CONDITIONAL([BUILD_SWITCH_ROOT], [test "x$build_switch_root" = xyes])
 
 
 AC_ARG_ENABLE([pivot_root],
   AS_HELP_STRING([--disable-pivot_root], [do not build pivot_root]),
-  [], enable_pivot_root=check
+  [], [enable_pivot_root=check]
 )
 UL_BUILD_INIT([pivot_root])
 UL_REQUIRES_LINUX([switch_root])
 UL_REQUIRES_SYSCALL_CHECK([pivot_root], [UL_CHECK_SYSCALL([pivot_root])])
-AM_CONDITIONAL(BUILD_PIVOT_ROOT, test "x$build_pivot_root" = xyes)
+AM_CONDITIONAL([BUILD_PIVOT_ROOT], [test "x$build_pivot_root" = xyes])
 
 
 AC_ARG_ENABLE([elvtune],
   AS_HELP_STRING([--enable-elvtune], [build elvtune (only works with 2.2 and 2.4 kernels)]),
-  [], enable_elvtune=no
+  [], [enable_elvtune=no]
 )
 UL_BUILD_INIT([elvtune])
 UL_REQUIRES_LINUX([elvtune])
-AM_CONDITIONAL(BUILD_ELVTUNE, test "x$build_elvtune" = xyes)
+AM_CONDITIONAL([BUILD_ELVTUNE], [test "x$build_elvtune" = xyes])
 
 
 AC_ARG_ENABLE([tunelp],
   AS_HELP_STRING([--enable-tunelp], [build tunelp]),
-  [], enable_tunelp=no
+  [], [enable_tunelp=no]
 )
 UL_BUILD_INIT([tunelp])
 UL_REQUIRES_LINUX([tunelp])
-AM_CONDITIONAL(BUILD_TUNELP, test "x$build_tunelp" = xyes)
+AM_CONDITIONAL([BUILD_TUNELP], [test "x$build_tunelp" = xyes])
 
 
 AC_ARG_ENABLE([kill],
   AS_HELP_STRING([--disable-kill], [do not build kill]),
-  [], enable_kill=check
+  [], [enable_kill=check]
 )
 UL_BUILD_INIT([kill])
 UL_REQUIRES_LINUX([kill])
-AM_CONDITIONAL(BUILD_KILL, test "x$build_kill" = xyes)
+AM_CONDITIONAL([BUILD_KILL], [test "x$build_kill" = xyes])
 
 
 AC_ARG_ENABLE([last],
   AS_HELP_STRING([--enable-last], [build last]),
-  [], enable_last=no
+  [], [enable_last=no]
 )
 UL_BUILD_INIT([last])
-AM_CONDITIONAL(BUILD_LAST, test "x$build_last" = xyes)
+AM_CONDITIONAL([BUILD_LAST], [test "x$build_last" = xyes])
 
 
 AC_ARG_ENABLE([utmpdump],
   AS_HELP_STRING([--disable-utmpdump], [do not build utmpdump]),
-  [], enable_utmpdump=yes
+  [], [enable_utmpdump=yes]
 )
 UL_BUILD_INIT([utmpdump])
-AM_CONDITIONAL(BUILD_UTMPDUMP, test "x$build_utmpdump" = xyes)
+AM_CONDITIONAL([BUILD_UTMPDUMP], [test "x$build_utmpdump" = xyes])
 
 
 AC_ARG_ENABLE([line],
   AS_HELP_STRING([--enable-line], [build line]),
-  [], enable_line=no
+  [], [enable_line=no]
 )
 UL_BUILD_INIT([line])
-AM_CONDITIONAL(BUILD_LINE, test "x$build_line" = xyes)
+AM_CONDITIONAL([BUILD_LINE], [test "x$build_line" = xyes])
 
 
 AC_ARG_ENABLE([mesg],
   AS_HELP_STRING([--enable-mesg], [build mesg]),
-  [], enable_mesg=no
+  [], [enable_mesg=no]
 )
 UL_BUILD_INIT([mesg])
-AM_CONDITIONAL(BUILD_MESG, test "x$build_mesg" = xyes)
+AM_CONDITIONAL([BUILD_MESG], [test "x$build_mesg" = xyes])
 
 
 AC_ARG_ENABLE([raw],
 	      AS_HELP_STRING([--disable-raw], [do not build raw]),
-  [], enable_raw=check
+  [], [enable_raw=check]
 )
 UL_BUILD_INIT([raw])
 UL_REQUIRES_LINUX([raw])
 UL_REQUIRES_HAVE([raw], [linux_raw_h], [raw.h header file])
-AM_CONDITIONAL(BUILD_RAW, test "x$build_raw" = xyes)
+AM_CONDITIONAL([BUILD_RAW], [test "x$build_raw" = xyes])
 
 
 AC_ARG_ENABLE([rename],
   AS_HELP_STRING([--disable-rename], [do not build rename]),
-  [], enable_rename=yes
+  [], [enable_rename=yes]
 )
 UL_BUILD_INIT([rename])
-AM_CONDITIONAL(BUILD_RENAME, test "x$build_rename" = xyes)
+AM_CONDITIONAL([BUILD_RENAME], [test "x$build_rename" = xyes])
 
 
 AC_ARG_ENABLE([reset],
   AS_HELP_STRING([--enable-reset], [build reset]),
-  [], enable_reset=no
+  [], [enable_reset=no]
 )
 UL_BUILD_INIT([reset])
-AM_CONDITIONAL(BUILD_RESET, test "x$build_reset" = xyes)
+AM_CONDITIONAL([BUILD_RESET], [test "x$build_reset" = xyes])
 
 
 AC_ARG_ENABLE([vipw],
   AS_HELP_STRING([--enable-vipw], [build vipw]),
-  [], enable_vipw=no
+  [], [enable_vipw=no]
 )
 UL_BUILD_INIT([vipw])
-AM_CONDITIONAL(BUILD_VIPW, test "x$build_vipw" = xyes)
+AM_CONDITIONAL([BUILD_VIPW], [test "x$build_vipw" = xyes])
 
 
 AC_ARG_ENABLE([newgrp],
   AS_HELP_STRING([--enable-newgrp], [build newgrp]),
-  [], enable_newgrp=no
+  [], [enable_newgrp=no]
 )
 UL_BUILD_INIT([newgrp])
-AM_CONDITIONAL(BUILD_NEWGRP, test "x$build_newgrp" = xyes)
+AM_CONDITIONAL([BUILD_NEWGRP], [test "x$build_newgrp" = xyes])
 
 
 AC_ARG_WITH([user], AS_HELP_STRING([--without-user], [compile without libuser (remote chsh)]),
-  [], with_user=check
+  [], [with_user=check]
 )
 have_user=no
 if test "x$with_user" != xno; then
@@ -1163,7 +1163,7 @@ if test "x$with_user" != xno; then
   yes:no)
    AC_MSG_ERROR([user selected but libuser not found]) ;;
   *:yes)
-   AC_DEFINE(HAVE_LIBUSER, 1, [Define if libuser is available]) ;;
+   AC_DEFINE([HAVE_LIBUSER], [1], [Define if libuser is available]) ;;
   esac
   # temporary solution, libuser has stupid .pc where are exported all
   # private dependencies to Requires: instead of Requires.private:
@@ -1171,25 +1171,25 @@ if test "x$with_user" != xno; then
     LIBUSER_LIBS=-luser
   fi
 fi
-AM_CONDITIONAL(HAVE_USER, test "x$have_user" = xyes)
+AM_CONDITIONAL([HAVE_USER], [test "x$have_user" = xyes])
 
 AC_ARG_ENABLE([chfn-chsh-password],
   AS_HELP_STRING([--disable-chfn-chsh-password], [do not require the user to enter the password in chfn and chsh]),
-  [], enable_chfn_chsh_password=yes
+  [], [enable_chfn_chsh_password=yes]
 )
 
 AC_ARG_ENABLE([chfn-chsh],
   AS_HELP_STRING([--enable-chfn-chsh], [build chfn and chsh]),
-  [], enable_chfn_chsh=no
+  [], [enable_chfn_chsh=no]
 )
 UL_BUILD_INIT([chfn_chsh])
 
 if test "x$enable_chfn_chsh_password" = xyes -o "x$have_user" = xyes; then
   UL_REQUIRES_HAVE([chfn_chsh], [security_pam_misc_h], [PAM header file])
-  AC_DEFINE(CHFN_CHSH_PASSWORD, 1, [Should chfn and chsh require the user to enter the password?])
+  AC_DEFINE([CHFN_CHSH_PASSWORD], [1], [Should chfn and chsh require the user to enter the password?])
 fi
-AM_CONDITIONAL(BUILD_CHFN_CHSH, test "x$build_chfn_chsh" = xyes)
-AM_CONDITIONAL(CHFN_CHSH_PASSWORD, test "x$enable_chfn_chsh_password" = xyes)
+AM_CONDITIONAL([BUILD_CHFN_CHSH], [test "x$build_chfn_chsh" = xyes])
+AM_CONDITIONAL([CHFN_CHSH_PASSWORD], [test "x$enable_chfn_chsh_password" = xyes])
 
 AC_ARG_ENABLE([chsh-only-listed],
 AS_HELP_STRING([--disable-chsh-only-listed], [chsh: allow shells not in /etc/shells]),
@@ -1197,106 +1197,106 @@ AS_HELP_STRING([--disable-chsh-only-listed], [chsh: allow shells not in /etc/she
 )
 
 if test "x$enable_chsh_only_listed" = xyes; then
-AC_DEFINE(ONLY_LISTED_SHELLS, 1, [Should chsh allow only shells in /etc/shells?])
+AC_DEFINE([ONLY_LISTED_SHELLS], [1], [Should chsh allow only shells in /etc/shells?])
 fi
 
 
 AC_ARG_ENABLE([login],
   AS_HELP_STRING([--disable-login], [do not build login]),
-  [], enable_login=check
+  [], [enable_login=check]
 )
 UL_BUILD_INIT([login])
 UL_REQUIRES_HAVE([login], [security_pam_misc_h], [PAM header file])
-AM_CONDITIONAL(BUILD_LOGIN, test "x$build_login" = xyes)
+AM_CONDITIONAL([BUILD_LOGIN], [test "x$build_login" = xyes])
 
 AC_ARG_ENABLE([login-chown-vcs],
   AS_HELP_STRING([--enable-login-chown-vcs], [let login chown /dev/vcsN]),
-  [], enable_login_chown_vcs=no
+  [], [enable_login_chown_vcs=no]
 )
 
 if test "x$enable_login_chown_vcs" = xyes; then
-  AC_DEFINE(LOGIN_CHOWN_VCS, 1, [Should login chown /dev/vcsN?])
+  AC_DEFINE([LOGIN_CHOWN_VCS], [1], [Should login chown /dev/vcsN?])
 fi
 
 AC_ARG_ENABLE([login-stat-mail],
   AS_HELP_STRING([--enable-login-stat-mail], [let login stat() the mailbox]),
-  [], enable_login_stat_mail=no
+  [], [enable_login_stat_mail=no]
 )
 
 if test "x$enable_login_stat_mail" = xyes; then
-  AC_DEFINE(LOGIN_STAT_MAIL, 1, [Should login stat() the mailbox?])
+  AC_DEFINE([LOGIN_STAT_MAIL], [1], [Should login stat() the mailbox?])
 fi
 
 
 AC_ARG_ENABLE([sulogin],
   AS_HELP_STRING([--disable-sulogin], [do not build sulogin]),
-  [], enable_sulogin=yes
+  [], [enable_sulogin=yes]
 )
 UL_BUILD_INIT([sulogin])
-AM_CONDITIONAL(BUILD_SULOGIN, test "x$build_sulogin" = xyes)
+AM_CONDITIONAL([BUILD_SULOGIN], [test "x$build_sulogin" = xyes])
 
 
 AC_ARG_ENABLE([su],
   AS_HELP_STRING([--disable-su], [do not build su]),
-  [], enable_su=check
+  [], [enable_su=check]
 )
 UL_BUILD_INIT([su])
 UL_REQUIRES_HAVE([su], [security_pam_misc_h], [PAM header file])
-AM_CONDITIONAL(BUILD_SU, test "x$build_su" = xyes)
+AM_CONDITIONAL([BUILD_SU], [test "x$build_su" = xyes])
 
 
 AC_ARG_ENABLE([runuser],
   AS_HELP_STRING([--disable-runuser], [do not build runuser]),
-  [], enable_runuser=check
+  [], [enable_runuser=check]
 )
 UL_BUILD_INIT([runuser])
 UL_REQUIRES_HAVE([runuser], [security_pam_misc_h], [PAM header file])
-AM_CONDITIONAL(BUILD_RUNUSER, test "x$build_runuser" = xyes)
+AM_CONDITIONAL([BUILD_RUNUSER], [test "x$build_runuser" = xyes])
 
 
 AC_ARG_ENABLE([ul],
   AS_HELP_STRING([--disable-ul], [do not build ul]),
-  [], enable_ul=check
+  [], [enable_ul=check]
 )
 UL_BUILD_INIT([ul])
 UL_REQUIRES_HAVE([ul], [ncurses, tinfo], [ncurses or tinfo libraries])
-AM_CONDITIONAL(BUILD_UL, test "x$build_ul" = xyes)
+AM_CONDITIONAL([BUILD_UL], [test "x$build_ul" = xyes])
 
 
 AC_ARG_ENABLE([more],
   AS_HELP_STRING([--disable-more], [do not build more]),
-  [], enable_more=check
+  [], [enable_more=check]
 )
 UL_BUILD_INIT([more])
 UL_REQUIRES_HAVE([more], [ncurses, tinfo, termcap], [ncurses, tinfo or termcap libraries])
-AM_CONDITIONAL(BUILD_MORE, test "x$build_more" = xyes)
+AM_CONDITIONAL([BUILD_MORE], [test "x$build_more" = xyes])
 
 
 AC_ARG_ENABLE([pg],
   AS_HELP_STRING([--disable-pg], [do not build pg]),
-  [], enable_pg=check
+  [], [enable_pg=check]
 )
 UL_BUILD_INIT([pg])
 UL_REQUIRES_HAVE([pg], [ncurses], [ncurses or ncursesw library])
-AM_CONDITIONAL(BUILD_PG, test "x$build_pg" = xyes)
+AM_CONDITIONAL([BUILD_PG], [test "x$build_pg" = xyes])
 
 
 AC_ARG_ENABLE([setterm],
   AS_HELP_STRING([--disable-setterm], [do not build setterm]),
-  [], enable_setterm=check
+  [], [enable_setterm=check]
 )
 UL_BUILD_INIT([setterm])
 UL_REQUIRES_LINUX([setterm])
 UL_REQUIRES_HAVE([setterm], [ncurses], [ncurses library])
-AM_CONDITIONAL(BUILD_SETTERM, test "x$build_setterm" = xyes)
+AM_CONDITIONAL([BUILD_SETTERM], [test "x$build_setterm" = xyes])
 
 
 AC_ARG_ENABLE([schedutils],
   AS_HELP_STRING([--disable-schedutils], [do not build chrt, ionice, taskset]),
-  [], enable_schedutils=yes
+  [], [enable_schedutils=yes]
 )
 UL_BUILD_INIT([schedutils])
-AM_CONDITIONAL(BUILD_SCHEDUTILS, test "x$build_schedutils" = xyes)
+AM_CONDITIONAL([BUILD_SCHEDUTILS], [test "x$build_schedutils" = xyes])
 
 UL_BUILD_INIT([ionice], [check])
 UL_REQUIRES_BUILD([ionice], [schedutils])
@@ -1324,7 +1324,7 @@ UL_REQUIRES_SYSCALL_CHECK([ionice],
 	  [x86_64*],	[252])],
 	[ioprio_get])
 
-AM_CONDITIONAL(BUILD_IONICE, test "x$build_ionice" = xyes)
+AM_CONDITIONAL([BUILD_IONICE], [test "x$build_ionice" = xyes])
 
 UL_BUILD_INIT([taskset], [check])
 UL_REQUIRES_BUILD([taskset], [schedutils])
@@ -1332,34 +1332,34 @@ UL_REQUIRES_HAVE([taskset], [cpu_set_t], [cpu_set_t type])
 UL_REQUIRES_SYSCALL_CHECK([taskset],
 	[UL_CHECK_SYSCALL([sched_getaffinity])],
 	[sched_getaffinity])
-AM_CONDITIONAL(BUILD_TASKSET, test "x$build_taskset" = xyes)
+AM_CONDITIONAL([BUILD_TASKSET], [test "x$build_taskset" = xyes])
 
 
 AC_ARG_ENABLE([wall],
   AS_HELP_STRING([--disable-wall], [do not build wall]),
-  [], enable_wall=yes
+  [], [enable_wall=yes]
 )
 UL_BUILD_INIT([wall])
-AM_CONDITIONAL(BUILD_WALL, test "x$build_wall" = xyes)
+AM_CONDITIONAL([BUILD_WALL], [test "x$build_wall" = xyes])
 
 
 AC_ARG_ENABLE([write],
   AS_HELP_STRING([--enable-write], [build write]),
-  [], enable_write=no
+  [], [enable_write=no]
 )
 UL_BUILD_INIT([write])
-AM_CONDITIONAL(BUILD_WRITE, test "x$build_write" = xyes)
+AM_CONDITIONAL([BUILD_WRITE], [test "x$build_write" = xyes])
 
 
 AC_ARG_ENABLE([socket-activation],
   AS_HELP_STRING([--enable-socket-activation], [build uuidd with support for systemd socket activation]),
-  [], enable_socket_activation=no
+  [], [enable_socket_activation=no]
 )
 
-AM_CONDITIONAL(USE_SOCKET_ACTIVATION, test "x$enable_socket_activation" = xyes)
+AM_CONDITIONAL([USE_SOCKET_ACTIVATION], [test "x$enable_socket_activation" = xyes])
 
 if test "x$enable_socket_activation" = xyes; then
-  AC_DEFINE(USE_SOCKET_ACTIVATION, 1, [Should uuidd support socket activation?])
+  AC_DEFINE([USE_SOCKET_ACTIVATION], [1], [Should uuidd support socket activation?])
 fi
 
 AC_ARG_WITH([systemdsystemunitdir],
@@ -1370,7 +1370,7 @@ if test "x$with_systemdsystemunitdir" != "xno"; then
   AC_SUBST([systemdsystemunitdir], [$with_systemdsystemunitdir])
 fi
 
-AM_CONDITIONAL(HAVE_SYSTEMD, [test -n "$with_systemdsystemunitdir" -a "x$with_systemdsystemunitdir" != "xno" ])
+AM_CONDITIONAL([HAVE_SYSTEMD], [test -n "$with_systemdsystemunitdir" -a "x$with_systemdsystemunitdir" != "xno" ])
 
 
 AC_ARG_WITH([bashcompletiondir],
@@ -1386,19 +1386,19 @@ AC_SUBST([bashcompletiondir], [$with_bashcompletiondir])
 
 AC_ARG_ENABLE([bash-completion],
   AS_HELP_STRING([--disable-bash-completion], [do not install bash completion files]),
-  [], enable_bash_completion=yes
+  [], [enable_bash_completion=yes]
 )
 
-AM_CONDITIONAL(BUILD_BASH_COMPLETION, test "x$enable_bash_completion" = xyes)
+AM_CONDITIONAL([BUILD_BASH_COMPLETION], [test "x$enable_bash_completion" = xyes])
 
 
 AC_ARG_ENABLE([pg-bell],
   AS_HELP_STRING([--disable-pg-bell], [let pg not ring the bell on invalid keys]),
-  [], enable_pg_bell=yes
+  [], [enable_pg_bell=yes]
 )
 
 if test "x$enable_pg_bell" = xyes; then
-  AC_DEFINE(PG_BELL, 1, [Should pg ring the bell on invalid keys?])
+  AC_DEFINE([PG_BELL], [1], [Should pg ring the bell on invalid keys?])
 fi
 
 
@@ -1432,38 +1432,38 @@ AC_DEFINE_UNQUOTED([FS_SEARCH_PATH], "$fs_paths", [search path for fs helpers])
 
 AC_ARG_ENABLE([use-tty-group],
   AS_HELP_STRING([--disable-use-tty-group], [do not install wall and write setgid tty]),
-  [], enable_use_tty_group=yes
+  [], [enable_use_tty_group=yes]
 )
-AM_CONDITIONAL(USE_TTY_GROUP, test "x$enable_use_tty_group" = xyes)
+AM_CONDITIONAL([USE_TTY_GROUP], [test "x$enable_use_tty_group" = xyes])
 
 if test "x$enable_use_tty_group" = xyes; then
-  AC_DEFINE(USE_TTY_GROUP, 1, [Should wall and write be installed setgid tty?])
+  AC_DEFINE([USE_TTY_GROUP], [1], [Should wall and write be installed setgid tty?])
 fi
 
 
 AC_ARG_ENABLE([sulogin-emergency-mount],
   AS_HELP_STRING([--enable-sulogin-emergency-mount],
 		 [use emergency mount of /dev and /proc for sulogin]),
-  [], enable_sulogin_emergency_mount=no
+  [], [enable_sulogin_emergency_mount=no]
 )
 
 if test "x$enable_sulogin_emergency_mount" = xyes; then
-  AC_DEFINE(USE_SULOGIN_EMERGENCY_MOUNT, 1,
+  AC_DEFINE([USE_SULOGIN_EMERGENCY_MOUNT], [1],
 	    [Should sulogin use a emergency mount of /dev and /proc?])
 fi
 
 
 AC_ARG_ENABLE([makeinstall-chown],
   AS_HELP_STRING([--disable-makeinstall-chown], [do not do chown-like operations during "make install"]),
-  [], enable_makeinstall_chown=yes
+  [], [enable_makeinstall_chown=yes]
 )
-AM_CONDITIONAL(MAKEINSTALL_DO_CHOWN, test "x$enable_makeinstall_chown" = xyes)
+AM_CONDITIONAL([MAKEINSTALL_DO_CHOWN], [test "x$enable_makeinstall_chown" = xyes])
 
 AC_ARG_ENABLE([makeinstall-setuid],
   AS_HELP_STRING([--disable-makeinstall-setuid], [do not do setuid chmod operations during "make install"]),
-  [], enable_makeinstall_setuid=yes
+  [], [enable_makeinstall_setuid=yes]
 )
-AM_CONDITIONAL(MAKEINSTALL_DO_SETUID, test "x$enable_makeinstall_setuid" = xyes)
+AM_CONDITIONAL([MAKEINSTALL_DO_SETUID], [test "x$enable_makeinstall_setuid" = xyes])
 
 
 AC_ARG_VAR([SUID_CFLAGS],
@@ -1474,7 +1474,7 @@ AC_ARG_VAR([SUID_LDFLAGS],
 LIBS=""
 
 
-AC_CONFIG_HEADERS(config.h)
+AC_CONFIG_HEADERS([config.h])
 
 #
 # Don't use configure.ac to replace install paths! See Makefile PATHFILES for
-- 
1.8.3.4

