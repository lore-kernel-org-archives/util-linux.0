Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:61146 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792AbcDFNnN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Apr 2016 09:43:13 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0Lkzph-1bLldp3t37-00aijg for
 <util-linux@vger.kernel.org>; Wed, 06 Apr 2016 15:43:09 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH v2 1/2] build-sys: add --enable-libuuid-force-uuidd
Date: Wed,  6 Apr 2016 15:43:07 +0200
Message-Id: <1459950187-29394-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <20160406122220.24mkbuz3rrkyuqza@ws.net.home>
References: <20160406122220.24mkbuz3rrkyuqza@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

To build libuuid with uuidd support even though the daemon is
disabled (--disable-uuidd).

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index e42a2c4..cdd9ad6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -910,6 +910,11 @@ AC_SUBST([LIBUUID_VERSION])
 AC_SUBST([LIBUUID_VERSION_INFO])
 AM_CONDITIONAL(BUILD_LIBUUID, test "x$build_libuuid" = xyes)
 
+AC_ARG_ENABLE([libuuid-force-uuidd],
+  AS_HELP_STRING([--enable-libuuid-force-uuidd], [support uuidd even though the daemon is not built]),
+  [], [enable_libuuid_force_uuidd=no]
+)
+
 AS_IF([test "x$build_libuuid" = xyes], [
   AC_DEFINE(HAVE_LIBUUID, 1, [Define to 1 if you have the -luuid.])
 ])
@@ -1084,7 +1089,7 @@ UL_BUILD_INIT([uuidd])
 UL_REQUIRES_BUILD([uuidd], [libuuid])
 UL_REQUIRES_HAVE([uuidd], [timer], [timer_create function])
 UL_REQUIRES_HAVE([uuidd], [sys_signalfd_h], [sys/signalfd.h header])
-AS_IF([test "x$build_uuidd" = xyes], [
+AS_IF([test "x$build_uuidd" = xyes || test "x$enable_libuuid_force_uuidd" == xyes ], [
   AC_DEFINE([HAVE_UUIDD], [1], [Define to 1 if you want to use uuid daemon.])
 ])
 AM_CONDITIONAL([BUILD_UUIDD], [test "x$build_uuidd" = xyes])
-- 
1.8.4.5

