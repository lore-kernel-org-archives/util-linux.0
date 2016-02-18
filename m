Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:63198 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425675AbcBRNMw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Feb 2016 08:12:52 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0LgptO-1a9lDh0zFW-00oE3Z for
 <util-linux@vger.kernel.org>; Thu, 18 Feb 2016 14:12:51 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 03/15] build-sys: check linker support for version scripts
Date: Thu, 18 Feb 2016 14:12:43 +0100
Message-Id: <1455801169-10470-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
References: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

The macro AX_CHECK_VSCRIPT was taken from gnu autoconf archive.
http://www.gnu.org/software/autoconf-archive/

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac                   |   3 +
 libblkid/src/Makemodule.am     |   4 +-
 libfdisk/src/Makemodule.am     |   4 +-
 libmount/src/Makemodule.am     |   4 +-
 libsmartcols/src/Makemodule.am |   4 +-
 libuuid/src/Makemodule.am      |   4 +-
 m4/ax_check_vscript.m4         | 142 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 160 insertions(+), 5 deletions(-)
 create mode 100644 m4/ax_check_vscript.m4

diff --git a/configure.ac b/configure.ac
index 4559573..17917af 100644
--- a/configure.ac
+++ b/configure.ac
@@ -138,6 +138,9 @@ AC_SUBST([BSD_WARN_CFLAGS])
 dnl libtool-2
 LT_INIT
 
+dnl check supported linker flags
+AX_CHECK_VSCRIPT
+
 m4_ifndef([PKG_PROG_PKG_CONFIG],
   [m4_fatal([Could not locate the pkg-config autoconf
     macros. These are usually located in /usr/share/aclocal/pkg.m4.
diff --git a/libblkid/src/Makemodule.am b/libblkid/src/Makemodule.am
index 52d0b0a..1d03d92 100644
--- a/libblkid/src/Makemodule.am
+++ b/libblkid/src/Makemodule.am
@@ -129,7 +129,9 @@ endif
 
 libblkid_la_LDFLAGS = \
 	$(SOLIB_LDFLAGS) \
-	-Wl,--version-script=$(top_srcdir)/libblkid/src/libblkid.sym \
+if HAVE_VSCRIPT
+	$(VSCRIPT_LDFLAGS),$(top_srcdir)/libblkid/src/libblkid.sym \
+endif
 	-version-info $(LIBBLKID_VERSION_INFO)
 
 EXTRA_DIST += \
diff --git a/libfdisk/src/Makemodule.am b/libfdisk/src/Makemodule.am
index 00c3d9f..69a3f3e 100644
--- a/libfdisk/src/Makemodule.am
+++ b/libfdisk/src/Makemodule.am
@@ -48,7 +48,9 @@ libfdisk_la_DEPENDENCIES = \
 
 libfdisk_la_LDFLAGS = \
 	$(SOLIB_LDFLAGS) \
-	-Wl,--version-script=$(top_srcdir)/libfdisk/src/libfdisk.sym \
+if HAVE_VSCRIPT
+	$(VSCRIPT_LDFLAGS),$(top_srcdir)/libfdisk/src/libfdisk.sym \
+endif
 	-version-info $(LIBFDISK_VERSION_INFO)
 
 if BUILD_LIBBLKID
diff --git a/libmount/src/Makemodule.am b/libmount/src/Makemodule.am
index 3a89d0d..36bb00c 100644
--- a/libmount/src/Makemodule.am
+++ b/libmount/src/Makemodule.am
@@ -61,7 +61,9 @@ libmount_la_DEPENDENCIES = \
 
 libmount_la_LDFLAGS = \
 	$(SOLIB_LDFLAGS) \
-	-Wl,--version-script=$(top_srcdir)/libmount/src/libmount.sym \
+if HAVE_VSCRIPT
+	$(VSCRIPT_LDFLAGS),$(top_srcdir)/libmount/src/libmount.sym \
+endif
 	-version-info $(LIBMOUNT_VERSION_INFO)
 
 EXTRA_DIST += \
diff --git a/libsmartcols/src/Makemodule.am b/libsmartcols/src/Makemodule.am
index c2ec515..257d46d 100644
--- a/libsmartcols/src/Makemodule.am
+++ b/libsmartcols/src/Makemodule.am
@@ -36,7 +36,9 @@ libsmartcols_la_DEPENDENCIES = \
 
 libsmartcols_la_LDFLAGS = \
 	$(SOLIB_LDFLAGS) \
-	-Wl,--version-script=$(top_srcdir)/libsmartcols/src/libsmartcols.sym \
+if HAVE_VSCRIPT
+	$(VSCRIPT_LDFLAGS),$(top_srcdir)/libsmartcols/src/libsmartcols.sym \
+endif
 	-version-info $(LIBSMARTCOLS_VERSION_INFO)
 
 EXTRA_DIST += \
diff --git a/libuuid/src/Makemodule.am b/libuuid/src/Makemodule.am
index 180ac01..dc8d867 100644
--- a/libuuid/src/Makemodule.am
+++ b/libuuid/src/Makemodule.am
@@ -37,7 +37,9 @@ libuuid_la_CFLAGS = \
 
 libuuid_la_LDFLAGS = \
 	$(SOLIB_LDFLAGS) \
-	-Wl,--version-script=$(top_srcdir)/libuuid/src/libuuid.sym \
+if HAVE_VSCRIPT
+	libuuid_la_LDFLAGS += $(VSCRIPT_LDFLAGS),$(top_srcdir)/libuuid/src/libuuid.sym \
+endif
 	-version-info $(LIBUUID_VERSION_INFO)
 
 EXTRA_DIST += libuuid/src/libuuid.sym
diff --git a/m4/ax_check_vscript.m4 b/m4/ax_check_vscript.m4
new file mode 100644
index 0000000..219ad22
--- /dev/null
+++ b/m4/ax_check_vscript.m4
@@ -0,0 +1,142 @@
+# ===========================================================================
+#     http://www.gnu.org/software/autoconf-archive/ax_check_vscript.html
+# ===========================================================================
+#
+# SYNOPSIS
+#
+#   AX_CHECK_VSCRIPT
+#
+# DESCRIPTION
+#
+#   Check whether the linker supports version scripts.  Version scripts are
+#   used when building shared libraries to bind symbols to version nodes
+#   (helping to detect incompatibilities) or to limit the visibility of
+#   non-public symbols.
+#
+#   Output:
+#
+#   If version scripts are supported, VSCRIPT_LDFLAGS will contain the
+#   appropriate flag to pass to the linker.  On GNU systems this would
+#   typically be "-Wl,--version-script", and on Solaris it would typically
+#   be "-Wl,-M".
+#
+#   Two Automake conditionals are also set:
+#
+#    HAVE_VSCRIPT is true if the linker supports version scripts with
+#    entries that use simple wildcards, like "local: *".
+#
+#    HAVE_VSCRIPT_COMPLEX is true if the linker supports version scripts with
+#    pattern matching wildcards, like "global: Java_*".
+#
+#   On systems that do not support symbol versioning, such as Mac OS X, both
+#   conditionals will be false.  They will also be false if the user passes
+#   "--disable-symvers" on the configure command line.
+#
+#   Example:
+#
+#    configure.ac:
+#
+#     AX_CHECK_VSCRIPT
+#
+#    Makefile.am:
+#
+#     if HAVE_VSCRIPT
+#     libfoo_la_LDFLAGS += $(VSCRIPT_LDFLAGS),@srcdir@/libfoo.map
+#     endif
+#
+#     if HAVE_VSCRIPT_COMPLEX
+#     libbar_la_LDFLAGS += $(VSCRIPT_LDFLAGS),@srcdir@/libbar.map
+#     endif
+#
+# LICENSE
+#
+#   Copyright (c) 2014 Kevin Cernekee <cernekee@gmail.com>
+#
+#   Copying and distribution of this file, with or without modification, are
+#   permitted in any medium without royalty provided the copyright notice
+#   and this notice are preserved. This file is offered as-is, without any
+#   warranty.
+
+#serial 1
+
+# _AX_CHECK_VSCRIPT(flag, global-sym, action-if-link-succeeds, [junk-file=no])
+AC_DEFUN([_AX_CHECK_VSCRIPT], [
+  AC_LANG_PUSH([C])
+  ax_check_vscript_save_flags="$LDFLAGS"
+  echo "V1 { global: $2; local: *; };" > conftest.map
+  AS_IF([test x$4 = xyes], [
+    echo "{" >> conftest.map
+  ])
+  LDFLAGS="$LDFLAGS -Wl,$1,conftest.map"
+  AC_LINK_IFELSE([AC_LANG_PROGRAM([[int show, hide;]], [])], [$3])
+  LDFLAGS="$ax_check_vscript_save_flags"
+  rm -f conftest.map
+  AC_LANG_POP([C])
+]) dnl _AX_CHECK_VSCRIPT
+
+AC_DEFUN([AX_CHECK_VSCRIPT], [
+
+  AC_ARG_ENABLE([symvers],
+    AS_HELP_STRING([--disable-symvers],
+                   [disable library symbol versioning [default=auto]]),
+    [want_symvers=$enableval],
+    [want_symvers=yes]
+  )
+
+  AS_IF([test x$want_symvers = xyes], [
+
+    dnl First test --version-script and -M with a simple wildcard.
+
+    AC_CACHE_CHECK([linker version script flag], ax_cv_check_vscript_flag, [
+      ax_cv_check_vscript_flag=unsupported
+      _AX_CHECK_VSCRIPT([--version-script], [show], [
+        ax_cv_check_vscript_flag=--version-script
+      ])
+      AS_IF([test x$ax_cv_check_vscript_flag = xunsupported], [
+        _AX_CHECK_VSCRIPT([-M], [show], [ax_cv_check_vscript_flag=-M])
+      ])
+
+      dnl The linker may interpret -M (no argument) as "produce a load map."
+      dnl If "-M conftest.map" doesn't fail when conftest.map contains
+      dnl obvious syntax errors, assume this is the case.
+
+      AS_IF([test x$ax_cv_check_vscript_flag != xunsupported], [
+        _AX_CHECK_VSCRIPT([$ax_cv_check_vscript_flag], [show],
+	                  [ax_cv_check_vscript_flag=unsupported], [yes])
+      ])
+    ])
+
+    dnl If the simple wildcard worked, retest with a complex wildcard.
+
+    AS_IF([test x$ax_cv_check_vscript_flag != xunsupported], [
+      ax_check_vscript_flag=$ax_cv_check_vscript_flag
+      AC_CACHE_CHECK([if version scripts can use complex wildcards],
+                     ax_cv_check_vscript_complex_wildcards, [
+        ax_cv_check_vscript_complex_wildcards=no
+        _AX_CHECK_VSCRIPT([$ax_cv_check_vscript_flag], [sh*], [
+        ax_cv_check_vscript_complex_wildcards=yes])
+      ])
+      ax_check_vscript_complex_wildcards="$ax_cv_check_vscript_complex_wildcards"
+    ], [
+      ax_check_vscript_flag=
+      ax_check_vscript_complex_wildcards=no
+    ])
+  ], [
+    AC_MSG_CHECKING([linker version script flag])
+    AC_MSG_RESULT([disabled])
+
+    ax_check_vscript_flag=
+    ax_check_vscript_complex_wildcards=no
+  ])
+
+  AS_IF([test x$ax_check_vscript_flag != x], [
+    VSCRIPT_LDFLAGS="-Wl,$ax_check_vscript_flag"
+    AC_SUBST([VSCRIPT_LDFLAGS])
+  ])
+
+  AM_CONDITIONAL([HAVE_VSCRIPT],
+    [test x$ax_check_vscript_flag != x])
+  AM_CONDITIONAL([HAVE_VSCRIPT_COMPLEX],
+    [test x$ax_check_vscript_complex_wildcards = xyes])
+
+]) dnl AX_CHECK_VSCRIPT
-- 
1.8.4.5

