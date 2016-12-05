Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:56162 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbcLENZi (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 5 Dec 2016 08:25:38 -0500
Received: from zappa.ga.local ([87.128.112.108]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1W5x-1cXTVp33Jx-00tVPa for
 <util-linux@vger.kernel.org>; Mon, 05 Dec 2016 14:24:56 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] build-sys: disable tailf by default
Date: Mon,  5 Dec 2016 14:24:55 +0100
Message-Id: <1480944295-4328-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

It's deprecated since 3f8478a7, so we shouldn't build it by default.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index dddc6a9..4f7eda3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1587,7 +1587,11 @@ AM_CONDITIONAL([BUILD_HEXDUMP], [test "x$build_hexdump" = xyes])
 UL_BUILD_INIT([rev], [yes])
 AM_CONDITIONAL([BUILD_REV], [test "x$build_rev" = xyes])
 
-UL_BUILD_INIT([tailf], [yes])
+AC_ARG_ENABLE([tailf],
+  AS_HELP_STRING([--enable-tailf], [build tailf (deprecated)]),
+  [], [UL_DEFAULT_ENABLE([tailf], [no])]
+)
+UL_BUILD_INIT([tailf])
 AM_CONDITIONAL([BUILD_TAILF], [test "x$build_tailf" = xyes])
 
 
-- 
1.8.5.6

