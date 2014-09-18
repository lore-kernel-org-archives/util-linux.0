Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:46883 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbaIRXhT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 18 Sep 2014 19:37:19 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 5E86AE3FE
	for <util-linux@vger.kernel.org>; Fri, 19 Sep 2014 01:36:47 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH 3/5] build-sys: build libmount everywhere
Date: Fri, 19 Sep 2014 01:36:35 +0200
Message-Id: <1411083397-8056-3-git-send-email-andreas@fatal.se>
In-Reply-To: <1411083397-8056-1-git-send-email-andreas@fatal.se>
References: <1411083397-8056-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This enables libmount to build on non-linux, which also
means we can build fsck on non-linux again.
(Since the context part of libmount still needs porting,
building the mount utility has instead been restricted
to only build on Linux.)

This has been build-tested on Debian GNU/kFreeBSD.

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 387372f..ed3a65d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -799,7 +799,6 @@ AC_ARG_ENABLE([libmount],
   [], [UL_DEFAULT_ENABLE([libmount], [check])]
 )
 UL_BUILD_INIT([libmount])
-UL_REQUIRES_LINUX([libmount])
 UL_REQUIRES_BUILD([libmount], [libblkid])
 UL_REQUIRES_HAVE([libmount], [scanf_alloc_modifier], [scanf string alloc modifier])
 AM_CONDITIONAL([BUILD_LIBMOUNT], [test "x$build_libmount" = xyes])
@@ -856,6 +855,7 @@ AC_ARG_ENABLE([mount],
   [], [UL_DEFAULT_ENABLE([mount], [check])]
 )
 UL_BUILD_INIT([mount])
+UL_REQUIRES_LINUX([mount])
 UL_REQUIRES_BUILD([mount], [libmount])
 AM_CONDITIONAL([BUILD_MOUNT], [test "x$build_mount" = xyes])
 
-- 
2.1.0.rc1

