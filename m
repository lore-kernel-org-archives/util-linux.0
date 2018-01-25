Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:43602 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933218AbeAYEVw (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 24 Jan 2018 23:21:52 -0500
Received: from vapier.lan (localhost [127.0.0.1])
        by smtp.gentoo.org (Postfix) with ESMTP id B5387335C2C
        for <util-linux@vger.kernel.org>; Thu, 25 Jan 2018 04:21:51 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] configure: fix bashisms
Date: Wed, 24 Jan 2018 23:21:49 -0500
Message-Id: <20180125042149.17476-1-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The `test` command only recognizes =, not ==.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 configure.ac | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 89afca602930..a579c8eed78b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -146,7 +146,7 @@ AC_ARG_ENABLE([asan],
   AS_HELP_STRING([--enable-asan], [compile with Address Sanitizer]),
   [], [enable_asan=no]
 )
-AS_IF([test "x$enable_asan" == xyes], [
+AS_IF([test "x$enable_asan" = xyes], [
   UL_WARN_ADD([-fsanitize=address])
 ])
 
@@ -1080,7 +1080,7 @@ AC_ARG_ENABLE([libmount-support-mtab],
   [], [enable_libmount_support_mtab=no]
 )
 
-AS_IF([test "x$enable_libmount_support_mtab" == xyes], [
+AS_IF([test "x$enable_libmount_support_mtab" = xyes], [
   AC_DEFINE([USE_LIBMOUNT_SUPPORT_MTAB], [1], [Define to 1 if want to support mtab.])
 ])
 
@@ -1202,7 +1202,7 @@ UL_BUILD_INIT([uuidd])
 UL_REQUIRES_BUILD([uuidd], [libuuid])
 UL_REQUIRES_HAVE([uuidd], [timer], [timer_create function])
 UL_REQUIRES_HAVE([uuidd], [sys_signalfd_h], [sys/signalfd.h header])
-AS_IF([test "x$build_uuidd" = xyes || test "x$enable_libuuid_force_uuidd" == xyes ], [
+AS_IF([test "x$build_uuidd" = xyes || test "x$enable_libuuid_force_uuidd" = xyes], [
   AC_DEFINE([HAVE_UUIDD], [1], [Define to 1 if you want to use uuid daemon.])
 ])
 AM_CONDITIONAL([BUILD_UUIDD], [test "x$build_uuidd" = xyes])
@@ -2281,7 +2281,7 @@ AC_ARG_ENABLE([usrdir-path],
   [], [enable_usrdir_path=no]
 )
 
-AS_IF([test "x$enable_usrdir_path" == xyes], [
+AS_IF([test "x$enable_usrdir_path" = xyes], [
   AC_DEFINE([USE_USRDIR_PATHS_ONLY], [1], [Define to 1 to remove /bin and /sbin from PATH env.variable])
 ])
 
-- 
2.15.1

