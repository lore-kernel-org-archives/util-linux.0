Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:63752 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbcBZDIm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 25 Feb 2016 22:08:42 -0500
Received: from tenfore.ga-group.nl ([95.114.239.233]) by mail.gmx.com
 (mrgmx003) with ESMTPSA (Nemesis) id 0MWT8s-1aRz6T3ezi-00XfK1 for
 <util-linux@vger.kernel.org>; Fri, 26 Feb 2016 04:08:39 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 11/14] build-sys: chrt requires a sched_set* function
Date: Fri, 26 Feb 2016 04:08:35 +0100
Message-Id: <1456456118-19584-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456456118-19584-1-git-send-email-sweet_f_a@gmx.de>
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
 <1456456118-19584-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configure.ac b/configure.ac
index d6c0c05..727a875 100644
--- a/configure.ac
+++ b/configure.ac
@@ -379,6 +379,7 @@ AC_CHECK_FUNCS([ \
 	setresgid \
 	setresuid \
 	sched_setattr \
+	sched_setscheduler \
 	sigqueue \
 	srandom \
 	strnchr \
@@ -1808,8 +1809,14 @@ UL_REQUIRES_SYSCALL_CHECK([taskset],
 	[sched_getaffinity])
 AM_CONDITIONAL([BUILD_TASKSET], [test "x$build_taskset" = xyes])
 
+
+have_schedsetter=no
+AS_IF([test "x$ac_cv_func_sched_setscheduler" = xyes], [have_schedsetter=yes],
+      [test "x$ac_cv_func_sched_setattr" = xyes], [have_schedsetter=yes])
+
 UL_BUILD_INIT([chrt], [check])
 UL_REQUIRES_BUILD([chrt], [schedutils])
+UL_REQUIRES_HAVE([chrt], [schedsetter], [sched_set functions])
 AM_CONDITIONAL([BUILD_CHRT], [test "x$build_chrt" = xyes])
 
 AS_IF([test "x$build_chrt" = xyes], [
-- 
1.8.4.5

