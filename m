Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:63658 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbcDFKvL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Apr 2016 06:51:11 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0Man6U-1b81l02ALS-00KRWR for
 <util-linux@vger.kernel.org>; Wed, 06 Apr 2016 12:51:08 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] build-sys: add --disable-logger and --disable-lslogins
Date: Wed,  6 Apr 2016 12:51:07 +0200
Message-Id: <1459939867-20719-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1459939867-20719-1-git-send-email-sweet_f_a@gmx.de>
References: <1459939867-20719-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Now we are able to disable all programs which have systemd/journald
support. This feature is needed by openSUSE packagers who are building
util-linux in 2 stages to avoid build cycles.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 82eb8db..194bc41 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1315,7 +1315,11 @@ UL_REQUIRES_HAVE([lscpu], [cpu_set_t], [cpu_set_t type])
 AM_CONDITIONAL([BUILD_LSCPU], [test "x$build_lscpu" = xyes])
 
 
-UL_BUILD_INIT([lslogins], [check])
+AC_ARG_ENABLE([lslogins],
+  AS_HELP_STRING([--disable-lslogins], [do not build lslogins]),
+  [], [UL_DEFAULT_ENABLE([lslogins], [check])]
+)
+UL_BUILD_INIT([lslogins])
 UL_REQUIRES_BUILD([lslogins], [libsmartcols])
 UL_REQUIRES_HAVE([lslogins], [shadow_h], [shadow.h header])
 UL_REQUIRES_HAVE([lslogins], [utmp_h], [utmp.h header])
@@ -1358,8 +1362,11 @@ AC_ARG_ENABLE([cal],
 UL_BUILD_INIT([cal])
 AM_CONDITIONAL([BUILD_CAL], [test "x$build_cal" = xyes])
 
-
-UL_BUILD_INIT([logger], [yes])
+AC_ARG_ENABLE([logger],
+  AS_HELP_STRING([--disable-logger], [do not build logger]),
+  [], [UL_DEFAULT_ENABLE([logger], [check])]
+)
+UL_BUILD_INIT([logger])
 AM_CONDITIONAL([BUILD_LOGGER], [test "x$build_logger" = xyes])
 
 UL_BUILD_INIT([look], [yes])
-- 
1.8.4.5

