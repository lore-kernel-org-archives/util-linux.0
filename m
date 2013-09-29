Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:38561 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111Ab3I2Eok (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 29 Sep 2013 00:44:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id E1B8733EAE4
	for <util-linux@vger.kernel.org>; Sun, 29 Sep 2013 04:44:39 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] clean up term lib handling
Date: Sun, 29 Sep 2013 00:44:43 -0400
Message-Id: <1380429883-25187-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The ncurses package has been providing pkg-config files for a while now.
So let's start using them to get the proper linker & compiler flags.  It
can make a difference when ncurses is configured in a way that requires
extra link time flags but util-linux doesn't provide them, or when the
headers live in a weird place and util-linux can't find them.

Since the NCURSES_LIBS is always defined for the Makefile, there's no need
to gate on the HAVE_NCURSES conditional.  When it's disabled, the var will
simply be empty.

With a minor tweak to how tinfo is handled, we can do the same thing -- we
just always use TINFO_LIBS in the Makefile's.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 configure.ac             | 53 ++++++++++++++++++++++++++++++++++++------------
 fdisks/Makemodule.am     |  7 +++----
 misc-utils/Makemodule.am | 12 ++---------
 term-utils/Makemodule.am |  7 ++-----
 text-utils/Makemodule.am | 27 +++++++-----------------
 5 files changed, 54 insertions(+), 52 deletions(-)

diff --git a/configure.ac b/configure.ac
index 553228a..db828ef 100644
--- a/configure.ac
+++ b/configure.ac
@@ -595,25 +595,50 @@ AM_CONDITIONAL([HAVE_NCURSES], [false])
 
 AS_IF([test "x$with_ncurses" != xno], [
   have_ncurses=no
-  AC_CHECK_HEADERS([ncurses.h ncurses/ncurses.h], [
-    AS_IF([test "x$with_ncurses" = xauto], [
-      UL_CHECK_LIB([ncursesw], [initscr], [ncurses])
-      AS_IF([test "x$have_ncurses" = xyes], [
-	AC_CHECK_HEADERS([ncursesw/ncurses.h])
-	NCURSES_LIBS="-lncursesw"
+
+  dnl First try to find the pkg-config module.
+  PKG_CHECK_MODULES(NCURSESW, [ncursesw], [
+    have_ncurses=yes
+    NCURSES_LIBS=${NCURSESW_LIBS}
+    NCURSES_CFLAGS=${NCURSESW_CFLAGS}
+    AC_DEFINE([HAVE_LIBNCURSESW])
+  ], [
+    PKG_CHECK_MODULES(NCURSES, [ncurses], [
+      have_ncurses=yes
+      AC_DEFINE([HAVE_LIBNCURSES])
+    ], [:])
+  ])
+
+  AS_IF([test "x$have_ncurses" = xyes], [
+    dnl If that worked, setup the defines that the code expects.
+    save_CPPFLAGS="$CPPFLAGS"
+    CPPFLAGS="$CPPFLAGS $NCURSES_CFLAGS"
+    AC_CHECK_HEADERS([ncurses.h])
+    CPPFLAGS="$save_CPPFLAGS"
+  ], [
+    dnl If that failed, fall back to classic searching.
+    AC_CHECK_HEADERS([ncurses.h ncurses/ncurses.h], [
+      AS_IF([test "x$with_ncurses" = xauto], [
+	UL_CHECK_LIB([ncursesw], [initscr], [ncurses])
+	AS_IF([test "x$have_ncurses" = xyes], [
+	  AC_CHECK_HEADERS([ncursesw/ncurses.h])
+	  NCURSES_LIBS="-lncursesw"
+	])
       ])
-    ])
-    AS_IF([test "x$have_ncurses" = xno], [
-      UL_CHECK_LIB(ncurses, initscr)
-      AS_IF([test "x$have_ncurses" = xyes], [
-	NCURSES_LIBS="-lncurses"
+      AS_IF([test "x$have_ncurses" = xno], [
+	UL_CHECK_LIB(ncurses, initscr)
+	AS_IF([test "x$have_ncurses" = xyes], [
+	  NCURSES_LIBS="-lncurses"
+	])
       ])
     ])
   ])
+
   AS_IF([test "x$have_ncurses" = xno], [
     AC_MSG_ERROR([ncurses or ncursesw selected, but library not found (--without-ncurses to disable)])
   ])
 ])
+AC_SUBST([NCURSES_CFLAGS])
 AC_SUBST([NCURSES_LIBS])
 
 
@@ -642,9 +667,11 @@ AM_CONDITIONAL([HAVE_SLANG], [test "x$have_slang" = xyes])
 AM_CONDITIONAL([BUILD_CFDISK], [test "x$have_slang" = xyes -o "x$have_ncurses" = xyes])
 
 
-have_tinfo=no
 AC_CHECK_LIB([tinfo], [tgetent], [have_tinfo=yes])
-AM_CONDITIONAL([HAVE_TINFO], [test "x$have_tinfo" = xyes])
+AS_IF([test "x$have_tinfo" = xyes], [
+  TINFO_LIBS="-ltinfo"
+])
+AC_SUBST([TINFO_LIBS])
 
 
 AC_ARG_WITH([utempter],
diff --git a/fdisks/Makemodule.am b/fdisks/Makemodule.am
index f2c594c..239e8ae 100644
--- a/fdisks/Makemodule.am
+++ b/fdisks/Makemodule.am
@@ -56,7 +56,7 @@ if BUILD_CFDISK
 sbin_PROGRAMS += cfdisk
 dist_man_MANS += fdisks/cfdisk.8
 cfdisk_SOURCES = fdisks/cfdisk.c
-cfdisk_CFLAGS =
+cfdisk_CFLAGS = $(AM_CFLAGS)
 cfdisk_LDADD = $(LDADD) libcommon.la
 
 if BUILD_LIBBLKID
@@ -67,9 +67,8 @@ endif
 if HAVE_SLANG
 cfdisk_LDADD += -lslang
 else
-if HAVE_NCURSES
-cfdisk_LDADD += @NCURSES_LIBS@
-endif
+cfdisk_CFLAGS += $(NCURSES_CFLAGS)
+cfdisk_LDADD += $(NCURSES_LIBS)
 endif
 endif # BUILD_CFDISK
 
diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index fcfec7b..70bb339 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -10,19 +10,11 @@ if !HAVE_LANGINFO
 cal_SOURCES += lib/langinfo.c
 endif
 
-cal_LDADD = $(LDADD) libcommon.la
-
-if HAVE_TINFO
-cal_LDADD += -ltinfo @NCURSES_LIBS@
-else
-if HAVE_NCURSES
-cal_LDADD += @NCURSES_LIBS@
-else
+cal_CFLAGS = $(AM_CFLAGS) $(NCURSES_CFLAGS)
+cal_LDADD = $(LDADD) libcommon.la $(NCURSES_LIBS) $(TINFO_LIBS)
 if HAVE_TERMCAP
 cal_LDADD += -ltermcap
 endif
-endif # !HAVE_NCURSES
-endif # !HAVE_TINFO
 
 
 usrbin_exec_PROGRAMS += logger
diff --git a/term-utils/Makemodule.am b/term-utils/Makemodule.am
index 4709873..b1c28f2 100644
--- a/term-utils/Makemodule.am
+++ b/term-utils/Makemodule.am
@@ -28,11 +28,8 @@ if BUILD_SETTERM
 usrbin_exec_PROGRAMS += setterm
 dist_man_MANS += term-utils/setterm.1
 setterm_SOURCES = term-utils/setterm.c
-if HAVE_TINFO
-setterm_LDADD = $(LDADD) -ltinfo
-else
-setterm_LDADD = $(LDADD) @NCURSES_LIBS@
-endif
+setterm_CFLAGS = $(AM_CFLAGS) $(NCURSES_CFLAGS)
+setterm_LDADD = $(LDADD) $(NCURSES_LIBS) $(TINFO_LIBS)
 endif
 
 
diff --git a/text-utils/Makemodule.am b/text-utils/Makemodule.am
index d3ebfdc..a2b6fe9 100644
--- a/text-utils/Makemodule.am
+++ b/text-utils/Makemodule.am
@@ -53,11 +53,8 @@ if BUILD_PG
 usrbin_exec_PROGRAMS += pg
 dist_man_MANS += text-utils/pg.1
 pg_SOURCES = text-utils/pg.c
-pg_CFLAGS = $(AM_CFLAGS) $(BSD_WARN_CFLAGS)
-pg_LDADD = $(LDADD) libcommon.la @NCURSES_LIBS@
-if HAVE_TINFO
-pg_LDADD += -ltinfo
-endif
+pg_CFLAGS = $(AM_CFLAGS) $(BSD_WARN_CFLAGS) $(NCURSES_CFLAGS)
+pg_LDADD = $(LDADD) libcommon.la $(NCURSES_LIBS) $(TINFO_LIBS)
 endif # BUILD_PG
 
 
@@ -65,12 +62,8 @@ if BUILD_UL
 usrbin_exec_PROGRAMS += ul
 dist_man_MANS += text-utils/ul.1
 ul_SOURCES = text-utils/ul.c
-ul_LDADD = $(LDADD)
-if HAVE_TINFO
-ul_LDADD += -ltinfo
-else 
-ul_LDADD += @NCURSES_LIBS@
-endif
+ul_CFLAGS = $(AM_CFLAGS) $(NCURSES_CFLAGS)
+ul_LDADD = $(LDADD) $(NCURSES_LIBS) $(TINFO_LIBS)
 endif # BUILD_UL
 
 
@@ -78,17 +71,11 @@ if BUILD_MORE
 bin_PROGRAMS += more
 dist_man_MANS += text-utils/more.1
 more_SOURCES = text-utils/more.c
-more_CFLAGS = $(AM_CFLAGS) $(BSD_WARN_CFLAGS)
-more_LDADD = $(LDADD)
-if HAVE_TINFO
-more_LDADD += -ltinfo
-else
-if HAVE_NCURSES
-more_LDADD += @NCURSES_LIBS@
-else
+more_CFLAGS = $(AM_CFLAGS) $(BSD_WARN_CFLAGS) $(NCURSES_CFLAGS)
+more_LDADD = $(LDADD) $(NCURSES_LIBS) $(TINFO_LIBS)
+if HAVE_TERMCAP
 more_LDADD += -ltermcap
 endif
-endif
 
 check_PROGRAMS += test_more
 test_more_SOURCES = $(more_SOURCES)
-- 
1.8.3.2

