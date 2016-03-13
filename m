Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:57792 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbcCMWb0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 Mar 2016 18:31:26 -0400
Received: from tenfore.ga-group.nl ([2.247.85.77]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0Mcgur-1aNIBZ3hNR-00HxVs for
 <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 23:31:25 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 10/12] build-sys: improve uuidd and script build conditions
Date: Sun, 13 Mar 2016 23:31:18 +0100
Message-Id: <1457908280-15588-11-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
References: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 5e89e3b..fafe762 100644
--- a/configure.ac
+++ b/configure.ac
@@ -244,6 +244,7 @@ AC_CHECK_HEADERS([ \
 	sys/param.h \
 	sys/prctl.h \
 	sys/resource.h \
+	sys/signalfd.h \
 	sys/socket.h \
 	sys/sockio.h \
 	sys/stat.h \
@@ -289,6 +290,7 @@ have_security_pam_appl_h=$ac_cv_header_security_pam_appl_h
 have_security_pam_misc_h=$ac_cv_header_security_pam_misc_h
 have_security_openpam_h=$ac_cv_header_security_openpam_h
 have_shadow_h=$ac_cv_header_shadow_h
+have_sys_signalfd_h=$ac_cv_header_sys_signalfd_h
 have_utmp_h=$ac_cv_header_utmp_h
 
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
@@ -1079,6 +1081,8 @@ AC_ARG_ENABLE([uuidd],
 )
 UL_BUILD_INIT([uuidd])
 UL_REQUIRES_BUILD([uuidd], [libuuid])
+UL_REQUIRES_HAVE([uuidd], [timer], [timer_create function])
+UL_REQUIRES_HAVE([uuidd], [sys_signalfd_h], [sys/signalfd.h header])
 AS_IF([test "x$build_uuidd" = xyes], [
   AC_DEFINE([HAVE_UUIDD], [1], [Define to 1 if you want to use uuid daemon.])
 ])
@@ -1494,7 +1498,7 @@ UL_REQUIRES_LINUX([setarch])
 AM_CONDITIONAL([BUILD_SETARCH], [test "x$build_setarch" = xyes])
 
 UL_BUILD_INIT([script], [check])
-UL_REQUIRES_LINUX([script])
+UL_REQUIRES_HAVE([script], [sys_signalfd_h], [sys/signalfd.h header])
 AM_CONDITIONAL([BUILD_SCRIPT], [test "x$build_script" = xyes])
 
 UL_BUILD_INIT([scriptreplay], [yes])
-- 
1.8.4.5

