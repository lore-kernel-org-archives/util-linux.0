Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:57825 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755312AbcCUNEt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Mar 2016 09:04:49 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MACmL-1aWgpb280P-00BJbK for
 <util-linux@vger.kernel.org>; Mon, 21 Mar 2016 14:04:46 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/5] build-sys: some libmount test progs are Linux only
Date: Mon, 21 Mar 2016 14:04:41 +0100
Message-Id: <1458565485-27856-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1458565485-27856-1-git-send-email-sweet_f_a@gmx.de>
References: <1458565485-27856-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <rudi@localhost>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libmount/src/Makemodule.am | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/libmount/src/Makemodule.am b/libmount/src/Makemodule.am
index fd007a4..8c5ef08 100644
--- a/libmount/src/Makemodule.am
+++ b/libmount/src/Makemodule.am
@@ -74,7 +74,6 @@ EXTRA_DIST += \
 if BUILD_LIBMOUNT_TESTS
 check_PROGRAMS += \
 	test_mount_cache \
-	test_mount_context \
 	test_mount_lock \
 	test_mount_optstr \
 	test_mount_tab \
@@ -82,8 +81,11 @@ check_PROGRAMS += \
 	test_mount_tab_update \
 	test_mount_utils \
 	test_mount_version \
-	test_mount_monitor \
 	test_mount_debug
+if LINUX
+check_PROGRAMS += test_mount_context
+check_PROGRAMS += test_mount_monitor
+endif
 
 libmount_tests_cflags  = -DTEST_PROGRAM $(libmount_la_CFLAGS) $(NO_UNUSED_WARN_CFLAGS)
 libmount_tests_ldflags = libblkid.la -static
-- 
1.8.4.5

