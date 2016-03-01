Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:58714 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549AbcCALoS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 1 Mar 2016 06:44:18 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LpPg1-1ZvdH33cjl-00f7Bn for
 <util-linux@vger.kernel.org>; Tue, 01 Mar 2016 12:44:16 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/4] build-sys: add and use openat build conditionals
Date: Tue,  1 Mar 2016 12:44:14 +0100
Message-Id: <1456832654-11268-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456832654-11268-1-git-send-email-sweet_f_a@gmx.de>
References: <1456832654-11268-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac                       |  7 ++++++-
 include/fileutils.h                |  2 ++
 lib/Makemodule.am                  | 14 ++++++++++----
 libsmartcols/samples/Makemodule.am |  4 +++-
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7b6a9e7..1653130 100644
--- a/configure.ac
+++ b/configure.ac
@@ -397,6 +397,8 @@ AC_CHECK_FUNCS([inotify_init1], [have_inotify_init1=yes])
 AC_CHECK_FUNCS([open_memstream], [have_open_memstream=yes],[have_open_memstream=no])
 AC_CHECK_FUNCS([reboot], [have_reboot=yes],[have_reboot=no])
 
+AM_CONDITIONAL([HAVE_OPENAT], [test "x$have_openat" = xyes])
+
 dnl lib/mononotic.c may require -lrt
 AC_CHECK_FUNCS([clock_gettime], [],
 	[AC_CHECK_LIB([rt], [clock_gettime], [REALTIME_LIBS="-lrt"])]
@@ -910,9 +912,10 @@ dnl libblkid
 dnl
 AC_ARG_ENABLE([libblkid],
   AS_HELP_STRING([--disable-libblkid], [do not build libblkid and many related utilities]),
-  [], [UL_DEFAULT_ENABLE([libblkid], [yes])]
+  [], [UL_DEFAULT_ENABLE([libblkid], [check])]
 )
 UL_BUILD_INIT([libblkid])
+UL_REQUIRES_HAVE([libblkid], [openat], [openat functions])
 AC_SUBST([LIBBLKID_DATE])
 AC_SUBST([LIBBLKID_VERSION])
 AC_SUBST([LIBBLKID_VERSION_INFO])
@@ -997,12 +1000,14 @@ AC_DEFINE_UNQUOTED([LIBFDISK_VERSION], ["$LIBFDISK_VERSION"], [libfdisk version
 
 
 UL_BUILD_INIT([fdisk], [check])
+UL_REQUIRES_HAVE([fdisk], [openat], [openat functions])
 UL_REQUIRES_BUILD([fdisk], [libfdisk])
 UL_REQUIRES_BUILD([fdisk], [libsmartcols])
 AM_CONDITIONAL([BUILD_FDISK], [test "x$build_fdisk" = xyes])
 
 
 UL_BUILD_INIT([sfdisk], [check])
+UL_REQUIRES_HAVE([sfdisk], [openat], [openat functions])
 UL_REQUIRES_BUILD([sfdisk], [libfdisk])
 UL_REQUIRES_BUILD([sfdisk], [libsmartcols])
 AM_CONDITIONAL([BUILD_SFDISK], [test "x$build_sfdisk" = xyes])
diff --git a/include/fileutils.h b/include/fileutils.h
index e016f99..7c757fb 100644
--- a/include/fileutils.h
+++ b/include/fileutils.h
@@ -26,6 +26,7 @@ static inline FILE *xfmkstemp(char **tmpname, const char *dir, const char *prefi
 	return ret;
 }
 
+#ifdef HAVE_OPENAT
 static inline FILE *fopen_at(int dir, const char *filename,
                              int flags, const char *mode)
 {
@@ -35,6 +36,7 @@ static inline FILE *fopen_at(int dir, const char *filename,
 
 	return fdopen(fd, mode);
 }
+#endif
 
 static inline int is_same_inode(const int fd, const struct stat *st)
 {
diff --git a/lib/Makemodule.am b/lib/Makemodule.am
index 81504b9..34bf1ca 100644
--- a/lib/Makemodule.am
+++ b/lib/Makemodule.am
@@ -17,11 +17,9 @@ libcommon_la_SOURCES = \
 	lib/md5.c \
 	lib/pager.c \
 	lib/path.c \
-	lib/procutils.c \
 	lib/randutils.c \
 	lib/setproctitle.c \
 	lib/strutils.c \
-	lib/sysfs.c \
 	lib/timeutils.c \
 	lib/ttyutils.c \
 	lib/exec_shell.c \
@@ -41,6 +39,10 @@ if HAVE_CPU_SET_T
 libcommon_la_SOURCES += lib/cpuset.c
 endif
 
+if HAVE_OPENAT
+libcommon_la_SOURCES += lib/procutils.c
+libcommon_la_SOURCES += lib/sysfs.c
+endif
 
 noinst_LTLIBRARIES += libtcolors.la
 libtcolors_la_CFLAGS = $(AM_CFLAGS) $(TINFO_CFLAGS)
@@ -57,14 +59,12 @@ check_PROGRAMS += \
 	test_fileutils \
 	test_ismounted \
 	test_mangle \
-	test_procutils \
 	test_randutils \
 	test_strutils \
 	test_ttyutils
 
 
 
-
 if LINUX
 if HAVE_CPU_SET_T
 check_PROGRAMS += test_cpuset
@@ -74,6 +74,10 @@ check_PROGRAMS += \
 	test_pager
 endif
 
+if HAVE_OPENAT
+check_PROGRAMS += test_procutils
+endif
+
 test_ttyutils_SOURCES = lib/ttyutils.c
 test_ttyutils_CFLAGS = $(AM_CFLAGS) -DTEST_PROGRAM
 test_ttyutils_LDADD = $(LDADD) libcommon.la
@@ -99,8 +103,10 @@ test_colors_LDADD = $(LDADD) $(TINFO_LIBS)
 test_randutils_SOURCES = lib/randutils.c
 test_randutils_CFLAGS = $(AM_CFLAGS) -DTEST_PROGRAM
 
+if HAVE_OPENAT
 test_procutils_SOURCES = lib/procutils.c
 test_procutils_CFLAGS = $(AM_CFLAGS) -DTEST_PROGRAM
+endif
 
 if LINUX
 test_cpuset_SOURCES = lib/cpuset.c
diff --git a/libsmartcols/samples/Makemodule.am b/libsmartcols/samples/Makemodule.am
index be74fc3..0a2d892 100644
--- a/libsmartcols/samples/Makemodule.am
+++ b/libsmartcols/samples/Makemodule.am
@@ -1,6 +1,5 @@
 
 check_PROGRAMS += \
-	sample-scols-tree \
 	sample-scols-title \
 	sample-scols-wrap \
 	sample-scols-continuous
@@ -9,9 +8,12 @@ sample_scols_cflags = $(AM_CFLAGS) $(NO_UNUSED_WARN_CFLAGS) \
                       -I$(ul_libsmartcols_incdir)
 sample_scols_ldadd = $(LDADD) libsmartcols.la
 
+if HAVE_OPENAT
+check_PROGRAMS += sample-scols-tree
 sample_scols_tree_SOURCES = libsmartcols/samples/tree.c
 sample_scols_tree_LDADD = $(sample_scols_ldadd) libcommon.la
 sample_scols_tree_CFLAGS = $(sample_scols_cflags)
+endif
 
 sample_scols_title_SOURCES = libsmartcols/samples/title.c
 sample_scols_title_LDADD = $(sample_scols_ldadd)
-- 
1.8.4.5

