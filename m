Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:52269 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbdBJVGj (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 10 Feb 2017 16:06:39 -0500
Subject: [PATCH 2/3] build-sys: configure gnulib parse-datetime module
To: Karel Zak <kzak@redhat.com>
References: <bbd64daa-5431-8c7d-580b-3382a33edccd@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <faf0d5cf-1566-fc53-187d-a497ee7cd421@gmx.com>
Date: Fri, 10 Feb 2017 16:05:28 -0500
MIME-Version: 1.0
In-Reply-To: <bbd64daa-5431-8c7d-580b-3382a33edccd@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 Makefile.am             | 10 +++++++---
 autogen.sh              |  2 +-
 configure.ac            |  6 +++++-
 sys-utils/Makemodule.am |  3 ++-
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 0bfc27f..f6fe860 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -28,6 +28,9 @@ ul_libfdisk_incdir  = $(top_builddir)/libfdisk/src
 
 ul_libuuid_incdir  = $(top_srcdir)/libuuid/src
 
+gl_libgnu_incdir = $(top_srcdir)/gllib
+gl_libgnu_la = $(top_srcdir)/gllib/libgnu.la
+
 pkgconfigdir = $(usrlib_execdir)/pkgconfig
 
 bashcompletiondir = @bashcompletiondir@
@@ -60,19 +63,20 @@ CHECK_LOCALS =
 EXTRA_DIST =
 CLEANFILES =
 
-SUBDIRS = po
+SUBDIRS = po gllib
 
 RCS_FIND_IGNORE = \( -name SCCS -o -name BitKeeper -o -name .svn -o \
 		-name CVS -o -name .pc -o -name .hg -o -name .git \) -prune -o
 
-ACLOCAL_AMFLAGS = -I m4
+ACLOCAL_AMFLAGS = -I glm4 -I m4
 
 EXTRA_DIST += \
 	.version \
 	autogen.sh \
 	Documentation \
 	po/update-potfiles \
-	README.licensing
+	README.licensing \
+	glm4/gnulib-cache.m4
 
 include tools/Makemodule.am
 include include/Makemodule.am
diff --git a/autogen.sh b/autogen.sh
index 116885b..03ce936 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -116,7 +116,7 @@ if ! grep -q datarootdir po/Makefile.in.in; then
 datadir = @datadir@/g' po/Makefile.in.in
 fi
 $LIBTOOLIZE --force $LT_OPTS
-aclocal -I m4 $AL_OPTS
+aclocal -I glm4 -I m4 $AL_OPTS
 autoconf $AC_OPTS
 autoheader $AH_OPTS
 
diff --git a/configure.ac b/configure.ac
index ad241fe..e69bc77 100644
--- a/configure.ac
+++ b/configure.ac
@@ -7,7 +7,7 @@ AC_INIT([util-linux],
 AC_PREREQ([2.60])
 
 AC_CONFIG_AUX_DIR([config])
-AC_CONFIG_MACRO_DIR([m4])
+AC_CONFIG_MACRO_DIR([glm4])
 dnl AC_USE_SYSTEM_EXTENSIONS must be called before any macros that run
 dnl the compiler (like AC_PROG_LIBTOOL) to avoid autoconf errors.
 AC_USE_SYSTEM_EXTENSIONS
@@ -99,6 +99,7 @@ AC_SUBST([usrlib_execdir])
 AM_PROG_CC_C_O
 AC_PROG_MKDIR_P
 AC_PROG_CC_STDC
+gl_EARLY
 AC_CANONICAL_HOST
 AC_C_CONST
 AC_C_VOLATILE
@@ -195,6 +196,8 @@ AS_IF([test -d "$srcdir/po"], [
   ALL_LINGUAS="af am ar as be bg bn_IN bn ca cs cy da de el en_GB es et eu_ES fa fi fr gl gu he hi hr hu hy id is it ja ka kn ko ku lo lt lv mk ml mr ms my nb nl nn no nso or pa pl pt_BR pt ro ru si sk sl sq sr@Latn sr sv ta te th tr uk ur vi zh_CN zh_TW zu"
 ])
 
+gl_INIT
+
 AC_CHECK_HEADERS([linux/compiler.h linux/blkpg.h linux/major.h], [], [], [
 #ifdef HAVE_LINUX_COMPILER_H
 #include <linux/compiler.h>
@@ -2254,6 +2257,7 @@ libsmartcols/docs/Makefile
 libsmartcols/docs/version.xml
 libsmartcols/src/libsmartcols.h
 po/Makefile.in
+gllib/Makefile
 ])
 
 AC_OUTPUT
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 91d3bf0..3e50134 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -437,7 +437,8 @@ hwclock_SOURCES = \
 if LINUX
 hwclock_SOURCES += sys-utils/hwclock-rtc.c
 endif
-hwclock_LDADD = $(LDADD) libcommon.la -lm
+hwclock_LDADD = $(LDADD) $(LIB_CLOCK_GETTIME) $(gl_libgnu_la) libcommon.la -lm
+hwclock_CFLAGS = $(AM_CFLAGS) -I$(gl_libgnu_incdir)
 if HAVE_AUDIT
 hwclock_LDADD += -laudit
 endif
