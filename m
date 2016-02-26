Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:57768 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752850AbcBZDIm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 25 Feb 2016 22:08:42 -0500
Received: from tenfore.ga-group.nl ([95.114.239.233]) by mail.gmx.com
 (mrgmx003) with ESMTPSA (Nemesis) id 0MMjgF-1aZRkG2mMR-008XFg for
 <util-linux@vger.kernel.org>; Fri, 26 Feb 2016 04:08:39 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 10/14] build-sys: add --disable-ipcrm --disable-ipcs
Date: Fri, 26 Feb 2016 04:08:34 +0100
Message-Id: <1456456118-19584-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

ipcs's source history looks like some people are using it on BSD
but it won't build on most non-Linux systems. That's why it's nice
let "./configure --disable-ipcrm --disable-ipcs" work.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 2f1a687..d6c0c05 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1422,10 +1422,18 @@ AM_CONDITIONAL([BUILD_FLOCK], [test "x$build_flock" = xyes])
 UL_BUILD_INIT([ipcmk], [yes])
 AM_CONDITIONAL([BUILD_IPCMK], [test "x$build_ipcmk" = xyes])
 
-UL_BUILD_INIT([ipcrm], [yes])
+AC_ARG_ENABLE([ipcrm],
+  AS_HELP_STRING([--disable-ipcrm], [do not build ipcrm]),
+  [], [UL_DEFAULT_ENABLE([ipcrm], [yes])]
+)
+UL_BUILD_INIT([ipcrm])
 AM_CONDITIONAL([BUILD_IPCRM], [test "x$build_ipcrm" = xyes])
 
-UL_BUILD_INIT([ipcs], [yes])
+AC_ARG_ENABLE([ipcs],
+  AS_HELP_STRING([--disable-ipcs], [do not build ipcs]),
+  [], [UL_DEFAULT_ENABLE([ipcs], [yes])]
+)
+UL_BUILD_INIT([ipcs])
 AM_CONDITIONAL([BUILD_IPCS], [test "x$build_ipcs" = xyes])
 
 UL_BUILD_INIT([lsipc], [check])
-- 
1.8.4.5

