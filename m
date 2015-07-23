Return-Path: util-linux-owner@vger.kernel.org
Received: from auth.a.painless.aa.net.uk ([90.155.4.51]:52537 "EHLO
	auth.a.painless.aa.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642AbbGWXUq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 23 Jul 2015 19:20:46 -0400
From: Joel Holdsworth <joel.holdsworth@vcatechnology.com>
To: util-linux@vger.kernel.org
Cc: Joel Holdsworth <joel@airwebreathe.org.uk>
Subject: [PATCH] build-sys: cal requires both ncurses and tinfo
Date: Thu, 23 Jul 2015 23:56:39 +0100
Message-Id: <1437692199-7557-1-git-send-email-joel.holdsworth@vcatechnology.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Joel Holdsworth <joel@airwebreathe.org.uk>

This fixes a bug in the build system when building without ncurses
and tinfo. When cal is linked, it depends on both these libraries
and will fail to link if either of them is not available.

This patch resolves the issue by explicitly declaring these
dependencies in the confgure.ac.
---
 configure.ac | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 6bc9efd..76ba349 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1232,7 +1232,9 @@ AS_IF([test "x$build_mkswap" = xyes -a "x$build_libuuid" != xyes], [
   AC_MSG_WARN([uuid library is not found; mkswap(8) will not generate UUIDs])
 ])
 
-UL_BUILD_INIT([cal], [yes])
+UL_BUILD_INIT([cal], [check])
+UL_REQUIRES_HAVE([cal], [ncurses], [ncurses library])
+UL_REQUIRES_HAVE([cal], [tinfo], [tinfo library])
 AM_CONDITIONAL([BUILD_CAL], [test "x$build_cal" = xyes])
 
 UL_BUILD_INIT([logger], [yes])
-- 
1.9.1

