Return-Path: util-linux-owner@vger.kernel.org
Received: from mx.datacom.ind.br ([177.66.5.10]:52230 "EHLO
        mail.datacom.ind.br" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753461AbdBRTqQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 18 Feb 2017 14:46:16 -0500
From: Carlos Santos <casantos@datacom.ind.br>
To: util-linux@vger.kernel.org
Cc: Aaron Holtzman <aholtzma@gmail.com>
Subject: [PATCH] schedutils: build when configured with --disable-all-programs
Date: Sat, 18 Feb 2017 17:46:03 -0200
Message-Id: <1487447163-12353-1-git-send-email-casantos@datacom.ind.br>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fix AM_CONDITIONAL parameters that conditioned ionice, taskset an chrt
to the values of build_{ionice,taskset,chrt} respectively, instead of
build_schedutils.

Fixes:
  https://bugs.busybox.net/show_bug.cgi?id=9656
  https://github.com/karelzak/util-linux/issues/415

Signed-off-by: Carlos Santos <casantos@datacom.ind.br>
---
 configure.ac | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index ad241fe..1933741 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1935,7 +1935,7 @@ UL_REQUIRES_SYSCALL_CHECK([ionice],
 	  [x86_64*],	[252])],
 	[ioprio_get])
 
-AM_CONDITIONAL([BUILD_IONICE], [test "x$build_ionice" = xyes])
+AM_CONDITIONAL([BUILD_IONICE], [test "x$build_schedutils" = xyes])
 
 UL_BUILD_INIT([taskset], [check])
 UL_REQUIRES_BUILD([taskset], [schedutils])
@@ -1943,7 +1943,7 @@ UL_REQUIRES_HAVE([taskset], [cpu_set_t], [cpu_set_t type])
 UL_REQUIRES_SYSCALL_CHECK([taskset],
 	[UL_CHECK_SYSCALL([sched_getaffinity])],
 	[sched_getaffinity])
-AM_CONDITIONAL([BUILD_TASKSET], [test "x$build_taskset" = xyes])
+AM_CONDITIONAL([BUILD_TASKSET], [test "x$build_schedutils" = xyes])
 
 
 have_schedsetter=no
@@ -1953,7 +1953,7 @@ AS_IF([test "x$ac_cv_func_sched_setscheduler" = xyes], [have_schedsetter=yes],
 UL_BUILD_INIT([chrt], [check])
 UL_REQUIRES_BUILD([chrt], [schedutils])
 UL_REQUIRES_HAVE([chrt], [schedsetter], [sched_set functions])
-AM_CONDITIONAL([BUILD_CHRT], [test "x$build_chrt" = xyes])
+AM_CONDITIONAL([BUILD_CHRT], [test "x$build_schedutils" = xyes])
 
 AS_IF([test "x$build_chrt" = xyes], [
 	UL_CHECK_SYSCALL([sched_setattr])
-- 
2.7.4

