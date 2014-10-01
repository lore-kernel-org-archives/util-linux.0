Return-Path: util-linux-owner@vger.kernel.org
Received: from mx-aarh-1.stofanet.dk ([212.10.10.11]:42788 "EHLO
	mx-aarh-1.stofanet.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbaJAOO2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 1 Oct 2014 10:14:28 -0400
Received: from 5634f347.rev.stofanet.dk ([86.52.243.71] helo=asrock)
	by mx-aarh-1.stofanet.dk (envelope-from
	<sgh@sgh.dk>)
	with esmtp id 1XZKfi-00060B-20
	for util-linux@vger.kernel.org; Wed, 01 Oct 2014 16:14:26 +0200
From: =?UTF-8?q?S=C3=B8ren=20Holm?= <sgh@sgh.dk>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?S=C3=B8ren=20Holm?= <sgh@sgh.dk>
Subject: [PATCH] Provide libmount version as int for better compiletime test.
Date: Wed,  1 Oct 2014 16:14:02 +0200
Message-Id: <1412172842-4137-1-git-send-email-sgh@sgh.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Søren Holm <sgh@sgh.dk>
---
 Makefile.am                | 3 +++
 configure.ac               | 3 +++
 libmount/src/libmount.h.in | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 08269e2..122344e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -120,6 +120,9 @@ edit_cmd = sed \
 	 -e 's|@ADJTIME_PATH[@]|$(ADJTIME_PATH)|g' \
 	 -e 's|@LIBUUID_VERSION[@]|$(LIBUUID_VERSION)|g' \
 	 -e 's|@LIBMOUNT_VERSION[@]|$(LIBMOUNT_VERSION)|g' \
+	 -e 's|@LIBMOUNT_MAJOR_VERSION[@]|$(LIBMOUNT_MAJOR_VERSION)|g' \
+	 -e 's|@LIBMOUNT_MINOR_VERSION[@]|$(LIBMOUNT_MINOR_VERSION)|g' \
+	 -e 's|@LIBMOUNT_PATCH_VERSION[@]|$(LIBMOUNT_PATCH_VERSION)|g' \
 	 -e 's|@LIBSMARTCOLS_VERSION[@]|$(LIBSMARTCOLS_VERSION)|g' \
 	 -e 's|@LIBBLKID_VERSION[@]|$(LIBBLKID_VERSION)|g'
 
diff --git a/configure.ac b/configure.ac
index 974ac0b..215d8cc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -806,6 +806,9 @@ AM_CONDITIONAL([BUILD_LIBMOUNT], [test "x$build_libmount" = xyes])
 AM_CONDITIONAL([BUILD_LIBMOUNT_TESTS], [test "x$build_libmount" = xyes -a "x$enable_static" = xyes])
 
 AC_SUBST([LIBMOUNT_VERSION])
+AC_SUBST([LIBMOUNT_MAJOR_VERSION], $PACKAGE_VERSION_MAJOR)
+AC_SUBST([LIBMOUNT_MINOR_VERSION], $PACKAGE_VERSION_MINOR)
+AC_SUBST([LIBMOUNT_PATCH_VERSION], $PACKAGE_VERSION_RELEASE)
 AC_SUBST([LIBMOUNT_VERSION_INFO])
 AC_DEFINE_UNQUOTED([LIBMOUNT_VERSION], ["$LIBMOUNT_VERSION"], [libmount version string])
 
diff --git a/libmount/src/libmount.h.in b/libmount/src/libmount.h.in
index d54e876..91e2287 100644
--- a/libmount/src/libmount.h.in
+++ b/libmount/src/libmount.h.in
@@ -30,6 +30,9 @@ extern "C" {
 #include <sys/types.h>
 
 #define LIBMOUNT_VERSION   "@LIBMOUNT_VERSION@"
+#define LIBMOUNT_MAJOR_VERSION   @LIBMOUNT_MAJOR_VERSION@
+#define LIBMOUNT_MINOR_VERSION   @LIBMOUNT_MINOR_VERSION@
+#define LIBMOUNT_PATCH_VERSION   @LIBMOUNT_PATCH_VERSION@
 
 /**
  * libmnt_cache:
-- 
2.1.0

