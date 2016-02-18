Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:55213 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426663AbcBRPvu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Feb 2016 10:51:50 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0MfEsY-1aLvQc3PCc-00OpCh for
 <util-linux@vger.kernel.org>; Thu, 18 Feb 2016 16:51:48 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH v2 07/15] include: provide MAP_ANONYMOUS on OSX
Date: Thu, 18 Feb 2016 16:51:48 +0100
Message-Id: <1455810708-28022-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1455801169-10470-8-git-send-email-sweet_f_a@gmx.de>
References: <1455801169-10470-8-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Hope there are no side effect when defining _DARWIN_C_SOURCE
globally.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac | 6 ++++++
 include/c.h  | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/configure.ac b/configure.ac
index e9c8ef5..dbdcea4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -158,11 +158,17 @@ bsd_os=no
 AS_CASE([${host_os}],
   [*linux*],
      [linux_os=yes],
+  [*darwin*],
+     [darwin_os=yes],
   [*bsd*],
      [bsd_os=yes])
 AM_CONDITIONAL([LINUX], [test "x$linux_os" = xyes])
+AM_CONDITIONAL([DARWIN], [test "x$darwin_os" = xyes])
 AM_CONDITIONAL([BSD], [test "x$bsd_os" = xyes])
 
+AS_IF([test  "x$darwin_os" = xyes], [
+  AC_DEFINE([_DARWIN_C_SOURCE], [1], [Enable MAP_ANON in sys/mman.h on Mac OS X])
+])
 
 dnl define ARCH_<NAME> conditionals
 UL_SET_ARCH([I86], [i?86-*])
diff --git a/include/c.h b/include/c.h
index ca028ba..aec3439 100644
--- a/include/c.h
+++ b/include/c.h
@@ -355,4 +355,12 @@ static inline int xusleep(useconds_t usec)
  */
 #define UL_GETPW_BUFSIZ	(16 * 1024)
 
+/*
+ * Darwin or other BSDs may only have MAP_ANON. To get it on Darwin we must
+ * define _DARWIN_C_SOURCE before including sys/mman.h. We do this in config.h.
+ */
+#if !defined MAP_ANONYMOUS && defined MAP_ANON
+# define MAP_ANONYMOUS  (MAP_ANON)
+#endif
+
 #endif /* UTIL_LINUX_C_H */
-- 
1.8.4.5

