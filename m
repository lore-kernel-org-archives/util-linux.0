Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34027 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357Ab3JCJja (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 3 Oct 2013 05:39:30 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so2328243pad.30
        for <util-linux@vger.kernel.org>; Thu, 03 Oct 2013 02:39:29 -0700 (PDT)
From: Michael Forney <mforney@mforney.org>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/4] Check for type sighandler_t and use if present
Date: Thu,  3 Oct 2013 02:39:18 -0700
Message-Id: <1380793159-27602-3-git-send-email-mforney@mforney.org>
In-Reply-To: <1380792968-1176-1-git-send-email-mforney@mforney.org>
References: <1380792968-1176-1-git-send-email-mforney@mforney.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

__sighandler_t is libc implementation specific and should not be relied
upon. Instead, we fall back upon void (*)(int), as specified by POSIX.
---
 configure.ac    | 4 ++++
 fdisks/cfdisk.c | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 12d0bab..93572fe 100644
--- a/configure.ac
+++ b/configure.ac
@@ -497,6 +497,10 @@ AC_CHECK_TYPES([cpu_set_t], [have_cpu_set_t=yes], [], [[
 
 AM_CONDITIONAL([HAVE_CPU_SET_T], [test "x$have_cpu_set_t" = xyes])
 
+AC_CHECK_TYPES([sighandler_t], [], [], [[
+#include <signal.h>
+]])
+
 AC_CHECK_DECLS([CPU_ALLOC], [], [], [[
 #include <sched.h>
 ]])
diff --git a/fdisks/cfdisk.c b/fdisks/cfdisk.c
index 5007fc9..bb32433 100644
--- a/fdisks/cfdisk.c
+++ b/fdisks/cfdisk.c
@@ -324,7 +324,11 @@ int num_parts = 0;
 int logical = 0;
 long long logical_sectors[MAXIMUM_PARTS];
 
-__sighandler_t old_SIGINT, old_SIGTERM;
+#ifdef HAVE_SIGHANDLER_T
+sighandler_t old_SIGINT, old_SIGTERM;
+#else
+void (* old_SIGINT)(int), (* old_SIGTERM)(int);
+#endif
 
 int arrow_cursor = FALSE;
 int display_units = MEGABYTES;
-- 
1.8.4

