Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:51673 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660AbcDFKvL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Apr 2016 06:51:11 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0LhB9P-1bZjFz1Ssx-00oUxe for
 <util-linux@vger.kernel.org>; Wed, 06 Apr 2016 12:51:08 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] libuuid: remove HAVE_UUIDD
Date: Wed,  6 Apr 2016 12:51:06 +0200
Message-Id: <1459939867-20719-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

configure --disable-uuidd disabled both the build of uuidd and also
disabled uuidd support of libuuid.

Now we build libuuid always with uuidd support. We could add another
configure switch --without-uuidd to have the old behavior but IMO
there is no need for that.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac           | 3 ---
 libuuid/src/gen_uuid.c | 4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7efe5e5..82eb8db 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1083,9 +1083,6 @@ UL_BUILD_INIT([uuidd])
 UL_REQUIRES_BUILD([uuidd], [libuuid])
 UL_REQUIRES_HAVE([uuidd], [timer], [timer_create function])
 UL_REQUIRES_HAVE([uuidd], [sys_signalfd_h], [sys/signalfd.h header])
-AS_IF([test "x$build_uuidd" = xyes], [
-  AC_DEFINE([HAVE_UUIDD], [1], [Define to 1 if you want to use uuid daemon.])
-])
 AM_CONDITIONAL([BUILD_UUIDD], [test "x$build_uuidd" = xyes])
 
 
diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index f9a937c..4fb9430 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -329,7 +329,7 @@ try_again:
 	return ret;
 }
 
-#if defined(HAVE_UUIDD) && defined(HAVE_SYS_UN_H)
+#ifdef HAVE_SYS_UN_H
 
 /*
  * Try using the uuidd daemon to generate the UUID
@@ -392,7 +392,7 @@ fail:
 	return -1;
 }
 
-#else /* !defined(HAVE_UUIDD) && defined(HAVE_SYS_UN_H) */
+#else /* HAVE_SYS_UN_H */
 static int get_uuid_via_daemon(int op, uuid_t out, int *num)
 {
 	return -1;
-- 
1.8.4.5

