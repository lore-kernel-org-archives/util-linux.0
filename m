Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:38406
	"EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404AbcCMR4W (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Mar 2016 13:56:22 -0400
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] build: uuidd requires linux now, uses signalfd
Date: Sun, 13 Mar 2016 18:56:07 +0100
Message-Id: <1457891767-16753-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Specify that uuidd can only be built on Linux now since
commit 25d66b4e3232d7b "uuidd: use signalfd() and setup_timer()"

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index 8d808b7..e5ee3fb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1079,6 +1079,7 @@ AC_ARG_ENABLE([uuidd],
   [], [UL_DEFAULT_ENABLE([uuidd], [check])]
 )
 UL_BUILD_INIT([uuidd])
+UL_REQUIRES_LINUX([uuidd])
 UL_REQUIRES_BUILD([uuidd], [libuuid])
 AS_IF([test "x$build_uuidd" = xyes], [
   AC_DEFINE([HAVE_UUIDD], [1], [Define to 1 if you want to use uuid daemon.])
-- 
2.1.4

