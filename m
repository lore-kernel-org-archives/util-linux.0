Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:61131 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754302AbcCMWb0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 Mar 2016 18:31:26 -0400
Received: from tenfore.ga-group.nl ([2.247.85.77]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LmeGF-1a6Am71lS7-00aBBe for
 <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 23:31:24 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 08/12] build-sys: add missing "not found" strings
Date: Sun, 13 Mar 2016 23:31:16 +0100
Message-Id: <1457908280-15588-9-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
References: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Otherwise configure output looks like this:
  configure: WARNING:  not found; not building cfdisk

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 0bfe28c..bfb12ca 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1019,7 +1019,7 @@ AM_CONDITIONAL([BUILD_SFDISK], [test "x$build_sfdisk" = xyes])
 UL_BUILD_INIT([cfdisk], [check])
 UL_REQUIRES_BUILD([cfdisk], [libfdisk])
 UL_REQUIRES_BUILD([cfdisk], [libsmartcols])
-UL_REQUIRES_HAVE([cfdisk], [open_memstream])
+UL_REQUIRES_HAVE([cfdisk], [open_memstream], [open_memstream function])
 UL_REQUIRES_HAVE([cfdisk], [ncurses,slang], [ncurses or slang library])
 AM_CONDITIONAL([BUILD_CFDISK], [test "x$build_cfdisk" = xyes])
 
@@ -1469,7 +1469,7 @@ dnl we assume reboot() to be the 1-argument variant, because even considering
 dnl widely used alternative C libraries like uclibc, dietlibc and musl,
 dnl reboot() with multiple arguments is yet only found in glibc versions
 dnl earlier than 2.x.
-UL_REQUIRES_HAVE([ctrlaltdel], [reboot])
+UL_REQUIRES_HAVE([ctrlaltdel], [reboot], [reboot function])
 AM_CONDITIONAL([BUILD_CTRLALTDEL], [test "x$build_ctrlaltdel" = xyes])
 
 UL_BUILD_INIT([fsfreeze], [check])
-- 
1.8.4.5

