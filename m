Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:54877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756341AbeATSG2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 20 Jan 2018 13:06:28 -0500
Received: from adsiz.fritz.box ([146.52.144.151]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7kwW-1eyuIs1eXw-00vMCh for
 <util-linux@vger.kernel.org>; Sat, 20 Jan 2018 19:06:26 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/5] build-sys: avoid using prog_DEPENDENCIES
Date: Sat, 20 Jan 2018 19:06:23 +0100
Message-Id: <20180120180624.15213-5-sweet_f_a@gmx.de>
In-Reply-To: <20180120180624.15213-1-sweet_f_a@gmx.de>
References: <20180120180624.15213-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Use EXTRA_prog_DEPENDENCIES to have the benefit
of automake's automatic prog_DEPENDENCIES.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libblkid/src/Makemodule.am     | 4 +---
 libfdisk/src/Makemodule.am     | 5 +----
 libmount/src/Makemodule.am     | 4 +---
 libsmartcols/src/Makemodule.am | 3 +--
 libuuid/src/Makemodule.am      | 4 +++-
 5 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/libblkid/src/Makemodule.am b/libblkid/src/Makemodule.am
index 2bd19959f..807cc21ee 100644
--- a/libblkid/src/Makemodule.am
+++ b/libblkid/src/Makemodule.am
@@ -113,8 +113,7 @@ endif
 
 libblkid_la_LIBADD = libcommon.la
 
-libblkid_la_DEPENDENCIES = \
-	libcommon.la \
+EXTRA_libblkid_la_DEPENDENCIES = \
 	libblkid/src/libblkid.sym
 
 libblkid_la_CFLAGS = \
@@ -125,7 +124,6 @@ libblkid_la_CFLAGS = \
 
 if BUILD_LIBUUID
 libblkid_la_LIBADD += libuuid.la
-libblkid_la_DEPENDENCIES += libuuid.la
 libblkid_la_CFLAGS += -I$(ul_libuuid_incdir)
 endif
 
diff --git a/libfdisk/src/Makemodule.am b/libfdisk/src/Makemodule.am
index 73bc89a95..77eed0bfb 100644
--- a/libfdisk/src/Makemodule.am
+++ b/libfdisk/src/Makemodule.am
@@ -40,9 +40,7 @@ libfdisk_la_CFLAGS = \
 	-I$(ul_libfdisk_incdir) \
 	-I$(top_srcdir)/libfdisk/src
 
-libfdisk_la_DEPENDENCIES = \
-	libcommon.la \
-	libuuid.la \
+EXTRA_libfdisk_la_DEPENDENCIES = \
 	libfdisk/src/libfdisk.sym
 
 libfdisk_la_LDFLAGS = $(SOLIB_LDFLAGS)
@@ -54,7 +52,6 @@ libfdisk_la_LDFLAGS += -version-info $(LIBFDISK_VERSION_INFO)
 
 if BUILD_LIBBLKID
 libfdisk_la_LIBADD += libblkid.la
-libfdisk_la_DEPENDENCIES += libblkid.la
 libfdisk_la_CFLAGS += -I$(ul_libblkid_incdir)
 endif
 
diff --git a/libmount/src/Makemodule.am b/libmount/src/Makemodule.am
index 1a6a8374a..8d7433255 100644
--- a/libmount/src/Makemodule.am
+++ b/libmount/src/Makemodule.am
@@ -52,9 +52,7 @@ libmount_la_CFLAGS = \
 	-I$(ul_libmount_incdir) \
 	-I$(top_srcdir)/libmount/src
 
-libmount_la_DEPENDENCIES = \
-	libcommon.la \
-	libblkid.la \
+EXTRA_libmount_la_DEPENDENCIES = \
 	libmount/src/libmount.sym
 
 libmount_la_LDFLAGS = $(SOLIB_LDFLAGS)
diff --git a/libsmartcols/src/Makemodule.am b/libsmartcols/src/Makemodule.am
index 6f5f6072c..175f9f206 100644
--- a/libsmartcols/src/Makemodule.am
+++ b/libsmartcols/src/Makemodule.am
@@ -27,8 +27,7 @@ libsmartcols_la_CFLAGS = \
 	-I$(ul_libsmartcols_incdir) \
 	-I$(top_srcdir)/libsmartcols/src
 
-libsmartcols_la_DEPENDENCIES = \
-	libcommon.la \
+EXTRA_libsmartcols_la_DEPENDENCIES = \
 	libsmartcols/src/libsmartcols.sym
 
 libsmartcols_la_LDFLAGS = $(SOLIB_LDFLAGS)
diff --git a/libuuid/src/Makemodule.am b/libuuid/src/Makemodule.am
index a1c1e4ab3..5122622a5 100644
--- a/libuuid/src/Makemodule.am
+++ b/libuuid/src/Makemodule.am
@@ -28,7 +28,9 @@ libuuid_la_SOURCES = \
 	lib/md5.c \
 	lib/sha1.c
 
-libuuid_la_DEPENDENCIES = libuuid/src/libuuid.sym
+EXTRA_libuuid_la_DEPENDENCIES = \
+	libuuid/src/libuuid.sym
+
 libuuid_la_LIBADD       = $(SOCKET_LIBS)
 
 libuuid_la_CFLAGS = \
-- 
2.13.6

