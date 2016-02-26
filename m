Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:53946 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290AbcBZDDh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 25 Feb 2016 22:03:37 -0500
Received: from tenfore.ga-group.nl ([95.114.239.233]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0MLS74-1aYaiz0fQI-000ZNB for
 <util-linux@vger.kernel.org>; Fri, 26 Feb 2016 04:03:35 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 07/14] build-sys: build_init should check for flock
Date: Fri, 26 Feb 2016 04:03:30 +0100
Message-Id: <1456455812-19453-8-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

To let a plain ./configure work on systems without create_timer().
see 254743e4

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index e3b0bf5..80123d9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1408,7 +1408,7 @@ UL_REQUIRES_SYSCALL_CHECK([pivot_root], [UL_CHECK_SYSCALL([pivot_root])])
 AM_CONDITIONAL([BUILD_PIVOT_ROOT], [test "x$build_pivot_root" = xyes])
 
 
-UL_BUILD_INIT([flock], [yes])
+UL_BUILD_INIT([flock], [check])
 UL_REQUIRES_HAVE([flock], [timer], [timer_create function])
 AM_CONDITIONAL([BUILD_FLOCK], [test "x$build_flock" = xyes])
 
-- 
1.8.4.5

