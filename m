Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f182.google.com ([74.125.82.182]:32770 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbaBPPXF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Feb 2014 10:23:05 -0500
Received: by mail-we0-f182.google.com with SMTP id u57so10051736wes.13
        for <util-linux@vger.kernel.org>; Sun, 16 Feb 2014 07:23:04 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/4] build-sys: allow per directory build targets
Date: Sun, 16 Feb 2014 15:22:53 +0000
Message-Id: <1392564176-11596-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1392564176-11596-1-git-send-email-kerolasa@iki.fi>
References: <1392564176-11596-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The new --disable-miscutils type of options are meant added for
distribution maintainers who need sometimes only to build util-linux
libraries to bootstrap fresh systems or new architectures.

References: http://www.spinics.net/lists/util-linux-ng/index.html#08695
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac              | 65 +++++++++++++++++++++++++++++++++++++++++------
 disk-utils/Makemodule.am  |  3 +++
 fdisks/Makemodule.am      |  3 +++
 login-utils/Makemodule.am |  3 +++
 misc-utils/Makemodule.am  |  3 +++
 sys-utils/Makemodule.am   |  3 +++
 term-utils/Makemodule.am  |  3 +++
 text-utils/Makemodule.am  |  2 ++
 8 files changed, 77 insertions(+), 8 deletions(-)

diff --git a/configure.ac b/configure.ac
index e742801..e63eee9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1260,6 +1260,63 @@ AS_IF([test "x$enable_login_stat_mail" = xyes], [
 ])
 
 
+AC_ARG_ENABLE([diskutils],
+  AS_HELP_STRING([--disable-diskutils], [do not build disk utils]),
+  [], [enable_diskutils=yes]
+)
+UL_BUILD_INIT([diskutils])
+AM_CONDITIONAL([BUILD_DISKUTILS], [test "x$build_diskutils" = xyes])
+
+AC_ARG_ENABLE([fdisks],
+  AS_HELP_STRING([--disable-fdisks], [do not build fdisk]),
+  [], [enable_fdisks=yes]
+)
+UL_BUILD_INIT([fdisks])
+AM_CONDITIONAL([BUILD_FDISKS], [test "x$build_fdisks" = xyes])
+
+AC_ARG_ENABLE([loginutils],
+  AS_HELP_STRING([--disable-loginutils], [do not build login utils]),
+  [], [enable_loginutils=yes]
+)
+UL_BUILD_INIT([loginutils])
+AM_CONDITIONAL([BUILD_LOGINUTILS], [test "x$build_loginutils" = xyes])
+
+AC_ARG_ENABLE([miscutils],
+  AS_HELP_STRING([--disable-miscutils], [do not build misc utils]),
+  [], [enable_miscutils=yes]
+)
+UL_BUILD_INIT([miscutils])
+AM_CONDITIONAL([BUILD_MISCUTILS], [test "x$build_miscutils" = xyes])
+
+AC_ARG_ENABLE([schedutils],
+  AS_HELP_STRING([--disable-schedutils], [do not build sched utils]),
+  [], [enable_schedutils=yes]
+)
+UL_BUILD_INIT([schedutils])
+AM_CONDITIONAL([BUILD_SCHEDUTILS], [test "x$build_schedutils" = xyes])
+
+AC_ARG_ENABLE([sysutils],
+  AS_HELP_STRING([--disable-sysutils], [do not build sys utils]),
+  [], [enable_sysutils=yes]
+)
+UL_BUILD_INIT([sysutils])
+AM_CONDITIONAL([BUILD_SYSUTILS], [test "x$build_sysutils" = xyes])
+
+AC_ARG_ENABLE([termutils],
+  AS_HELP_STRING([--disable-termutils], [do not build term utils]),
+  [], [enable_termutils=yes]
+)
+UL_BUILD_INIT([termutils])
+AM_CONDITIONAL([BUILD_TERMUTILS], [test "x$build_termutils" = xyes])
+
+AC_ARG_ENABLE([textutils],
+  AS_HELP_STRING([--disable-textutils], [do not build text utils]),
+  [], [enable_textutils=yes]
+)
+UL_BUILD_INIT([textutils])
+AM_CONDITIONAL([BUILD_TEXTUTILS], [test "x$build_textutils" = xyes])
+
+
 AC_ARG_ENABLE([nologin],
   AS_HELP_STRING([--disable-nologin], [do not build nologin]),
   [], [enable_nologin=yes]
@@ -1330,14 +1387,6 @@ UL_REQUIRES_LINUX([setterm])
 UL_REQUIRES_HAVE([setterm], [ncurses], [ncurses library])
 AM_CONDITIONAL([BUILD_SETTERM], [test "x$build_setterm" = xyes])
 
-
-AC_ARG_ENABLE([schedutils],
-  AS_HELP_STRING([--disable-schedutils], [do not build chrt, ionice, taskset]),
-  [], [enable_schedutils=yes]
-)
-UL_BUILD_INIT([schedutils])
-AM_CONDITIONAL([BUILD_SCHEDUTILS], [test "x$build_schedutils" = xyes])
-
 UL_BUILD_INIT([ionice], [check])
 UL_REQUIRES_BUILD([ionice], [schedutils])
 UL_REQUIRES_SYSCALL_CHECK([ionice],
diff --git a/disk-utils/Makemodule.am b/disk-utils/Makemodule.am
index 5801392..81d16a8 100644
--- a/disk-utils/Makemodule.am
+++ b/disk-utils/Makemodule.am
@@ -1,3 +1,4 @@
+if BUILD_DISKUTILS
 
 sbin_PROGRAMS += fsck.minix
 dist_man_MANS += disk-utils/fsck.minix.8
@@ -142,3 +143,5 @@ partx_CFLAGS = -I$(ul_libblkid_incdir)
 partx_LDADD = $(LDADD) libblkid.la libcommon.la
 
 endif # BUILD_PARTX
+
+endif # BUILD_DISKUTILS
diff --git a/fdisks/Makemodule.am b/fdisks/Makemodule.am
index 239e8ae..50200cd 100644
--- a/fdisks/Makemodule.am
+++ b/fdisks/Makemodule.am
@@ -1,3 +1,4 @@
+if BUILD_FDISKS
 
 if !ARCH_M68K
 
@@ -74,3 +75,5 @@ endif # BUILD_CFDISK
 
 endif # !ARCH_SPARC
 endif # !ARCH_M68K
+
+endif # BUILD_FDISKS
diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index aca028a..6d7797e 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -1,3 +1,4 @@
+if BUILD_LOGINUTILS
 
 if BUILD_LAST
 usrbin_exec_PROGRAMS += last
@@ -207,3 +208,5 @@ endif
 if BUILD_VIPW
 	cd $(DESTDIR)$(usrsbin_execdir) && ln -sf vipw vigr
 endif
+
+endif # BUILD_LOGINUTILS
diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index d30229d..9bfad53 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -1,3 +1,4 @@
+if BUILD_MISCUTILS
 
 usrbin_exec_PROGRAMS += cal
 dist_man_MANS += misc-utils/cal.1
@@ -148,3 +149,5 @@ getoptexampledir = $(docdir)/getopt/
 dist_getoptexample_SCRIPTS = \
 	misc-utils/getopt-parse.bash \
 	misc-utils/getopt-parse.tcsh
+
+endif # BUILD_MISCUTILS
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 30b5d3e..e7b230d 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -1,3 +1,4 @@
+if BUILD_SYSUTILS
 
 usrbin_exec_PROGRAMS += flock
 dist_man_MANS += sys-utils/flock.1
@@ -328,3 +329,5 @@ dist_man_MANS += sys-utils/setpriv.1
 setpriv_SOURCES = sys-utils/setpriv.c
 setpriv_LDADD = $(LDADD) -lcap-ng libcommon.la
 endif
+
+endif # BUILD_SYSUTILS
diff --git a/term-utils/Makemodule.am b/term-utils/Makemodule.am
index e53471f..308aa31 100644
--- a/term-utils/Makemodule.am
+++ b/term-utils/Makemodule.am
@@ -1,3 +1,4 @@
+if BUILD_TERMUTILS
 
 usrbin_exec_PROGRAMS += script
 dist_man_MANS += term-utils/script.1
@@ -93,3 +94,5 @@ INSTALL_EXEC_HOOKS += install-exec-hook-write
 endif
 endif
 endif # BUILD_WRITE
+
+endif # BUILD_TERMUTILS
diff --git a/text-utils/Makemodule.am b/text-utils/Makemodule.am
index ff9fb51..10ed1a3 100644
--- a/text-utils/Makemodule.am
+++ b/text-utils/Makemodule.am
@@ -1,3 +1,4 @@
+if BUILD_TEXTUTILS
 
 usrbin_exec_PROGRAMS += \
 	col \
@@ -98,3 +99,4 @@ test_more_LDADD = $(more_LDADD)
 
 endif # BUILD_MORE
 
+endif # BUILD_TEXTUTILS
-- 
1.8.5.5

