Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:52528 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756368AbeATSG2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 20 Jan 2018 13:06:28 -0500
Received: from adsiz.fritz.box ([146.52.144.151]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lwnem-1esLms30Ce-016Ool for
 <util-linux@vger.kernel.org>; Sat, 20 Jan 2018 19:06:26 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/5] build-sys: remove redundant EXTRA_DIST files
Date: Sat, 20 Jan 2018 19:06:24 +0100
Message-Id: <20180120180624.15213-6-sweet_f_a@gmx.de>
In-Reply-To: <20180120180624.15213-1-sweet_f_a@gmx.de>
References: <20180120180624.15213-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

The sources of AC_CONFIG_FILES (*.in) are automatically
distributed.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libblkid/Makemodule.am         | 2 +-
 libblkid/src/Makemodule.am     | 3 +--
 libfdisk/src/Makemodule.am     | 3 +--
 libmount/src/Makemodule.am     | 3 +--
 libsmartcols/src/Makemodule.am | 3 +--
 5 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/libblkid/Makemodule.am b/libblkid/Makemodule.am
index b4f6f9c4e..f1d1e8d00 100644
--- a/libblkid/Makemodule.am
+++ b/libblkid/Makemodule.am
@@ -11,6 +11,6 @@ endif
 pkgconfig_DATA += libblkid/blkid.pc
 PATHFILES      += libblkid/blkid.pc
 dist_man_MANS  += libblkid/libblkid.3
-EXTRA_DIST     += libblkid/libblkid.3 libblkid/COPYING
+EXTRA_DIST     += libblkid/COPYING
 
 endif # BUILD_LIBBLKID
diff --git a/libblkid/src/Makemodule.am b/libblkid/src/Makemodule.am
index 807cc21ee..1046be100 100644
--- a/libblkid/src/Makemodule.am
+++ b/libblkid/src/Makemodule.am
@@ -134,8 +134,7 @@ endif
 libblkid_la_LDFLAGS += -version-info $(LIBBLKID_VERSION_INFO)
 
 EXTRA_DIST += \
-	libblkid/src/libblkid.sym \
-	libblkid/src/blkid.h.in
+	libblkid/src/libblkid.sym
 
 if BUILD_LIBBLKID_TESTS
 check_PROGRAMS += \
diff --git a/libfdisk/src/Makemodule.am b/libfdisk/src/Makemodule.am
index 77eed0bfb..d273551a2 100644
--- a/libfdisk/src/Makemodule.am
+++ b/libfdisk/src/Makemodule.am
@@ -56,8 +56,7 @@ libfdisk_la_CFLAGS += -I$(ul_libblkid_incdir)
 endif
 
 EXTRA_DIST += \
-	libfdisk/src/libfdisk.sym \
-	libfdisk/src/libfdisk.h.in
+	libfdisk/src/libfdisk.sym
 
 if BUILD_LIBFDISK_TESTS
 check_PROGRAMS += \
diff --git a/libmount/src/Makemodule.am b/libmount/src/Makemodule.am
index 8d7433255..a59b98b55 100644
--- a/libmount/src/Makemodule.am
+++ b/libmount/src/Makemodule.am
@@ -63,8 +63,7 @@ libmount_la_LDFLAGS += -version-info $(LIBMOUNT_VERSION_INFO)
 
 
 EXTRA_DIST += \
-	libmount/src/libmount.sym \
-	libmount/src/libmount.h.in
+	libmount/src/libmount.sym
 
 if BUILD_LIBMOUNT_TESTS
 check_PROGRAMS += \
diff --git a/libsmartcols/src/Makemodule.am b/libsmartcols/src/Makemodule.am
index 175f9f206..664aca30b 100644
--- a/libsmartcols/src/Makemodule.am
+++ b/libsmartcols/src/Makemodule.am
@@ -37,8 +37,7 @@ endif
 libsmartcols_la_LDFLAGS += -version-info $(LIBSMARTCOLS_VERSION_INFO)
 
 EXTRA_DIST += \
-	libsmartcols/src/libsmartcols.sym \
-	libsmartcols/src/libsmartcols.h.in
+	libsmartcols/src/libsmartcols.sym
 
 # move lib from $(usrlib_execdir) to $(libdir) if needed
 install-exec-hook-libsmartcols:
-- 
2.13.6

