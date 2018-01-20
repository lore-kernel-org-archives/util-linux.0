Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:53083 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755212AbeATSG1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 20 Jan 2018 13:06:27 -0500
Received: from adsiz.fritz.box ([146.52.144.151]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LabZr-1f5jdW3MpL-00mN8G for
 <util-linux@vger.kernel.org>; Sat, 20 Jan 2018 19:06:25 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/5] build-sys: remove generated headers from dist tar ball
Date: Sat, 20 Jan 2018 19:06:20 +0100
Message-Id: <20180120180624.15213-2-sweet_f_a@gmx.de>
In-Reply-To: <20180120180624.15213-1-sweet_f_a@gmx.de>
References: <20180120180624.15213-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Headers should only be listed in either *_HEADERS or
*_SOURCES, especially when we want nodist_*_HEADERS.

Since all the generated headers are made by configure we
don't even need to use BUILT_SOURCES or other tricks.

Also see automake docs 9.4.1 Built Sources Example:
  case "Build bindir.h from configure"

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libblkid/src/Makemodule.am     | 2 --
 libfdisk/src/Makemodule.am     | 6 +-----
 libmount/src/Makemodule.am     | 6 ++----
 libsmartcols/src/Makemodule.am | 5 +----
 libuuid/src/Makemodule.am      | 4 +---
 5 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/libblkid/src/Makemodule.am b/libblkid/src/Makemodule.am
index 65d2e66ed..b8843e896 100644
--- a/libblkid/src/Makemodule.am
+++ b/libblkid/src/Makemodule.am
@@ -26,7 +26,6 @@ libblkid_la_SOURCES = \
 	libblkid/src/tag.c \
 	libblkid/src/verify.c \
 	libblkid/src/version.c \
-	$(nodist_blkidinc_HEADERS) \
 	\
 	libblkid/src/partitions/aix.c \
 	libblkid/src/partitions/aix.h \
@@ -112,7 +111,6 @@ libblkid_la_SOURCES += \
 	libblkid/src/topology/sysfs.c
 endif
 
-nodist_libblkid_la_SOURCES = libblkid/src/blkid.h
 libblkid_la_LIBADD = libcommon.la
 
 libblkid_la_DEPENDENCIES = \
diff --git a/libfdisk/src/Makemodule.am b/libfdisk/src/Makemodule.am
index b51de58f4..0e568381f 100644
--- a/libfdisk/src/Makemodule.am
+++ b/libfdisk/src/Makemodule.am
@@ -29,11 +29,7 @@ libfdisk_la_SOURCES = \
 	libfdisk/src/sgi.c \
 	libfdisk/src/dos.c \
 	libfdisk/src/bsd.c \
-	libfdisk/src/gpt.c \
-	$(nodist_fdiskinc_HEADERS)
-
-
-nodist_libfdisk_la_SOURCES = libfdisk/src/fdiskP.h
+	libfdisk/src/gpt.c
 
 libfdisk_la_LIBADD = libcommon.la libuuid.la
 
diff --git a/libmount/src/Makemodule.am b/libmount/src/Makemodule.am
index e5861b0ba..516bebbfa 100644
--- a/libmount/src/Makemodule.am
+++ b/libmount/src/Makemodule.am
@@ -8,12 +8,12 @@ libmount_la_SOURCES = \
 	include/list.h \
 	lib/monotonic.c \
 	\
+	libmount/src/mountP.h \
 	libmount/src/cache.c \
 	libmount/src/fs.c \
 	libmount/src/init.c \
 	libmount/src/iter.c \
 	libmount/src/lock.c \
-	libmount/src/mountP.h \
 	libmount/src/optmap.c \
 	libmount/src/optstr.c \
 	libmount/src/tab.c \
@@ -22,8 +22,7 @@ libmount_la_SOURCES = \
 	libmount/src/tab_update.c \
 	libmount/src/test.c \
 	libmount/src/utils.c \
-	libmount/src/version.c \
-	$(nodist_mountinc_HEADERS)
+	libmount/src/version.c
 
 if LINUX
 libmount_la_SOURCES += \
@@ -39,7 +38,6 @@ endif
 
 endif # LINUX
 
-nodist_libmount_la_SOURCES = libmount/src/mountP.h
 
 libmount_la_LIBADD = \
 	libcommon.la \
diff --git a/libsmartcols/src/Makemodule.am b/libsmartcols/src/Makemodule.am
index 83c12ca54..2b1c1fd1c 100644
--- a/libsmartcols/src/Makemodule.am
+++ b/libsmartcols/src/Makemodule.am
@@ -17,10 +17,7 @@ libsmartcols_la_SOURCES= \
 	libsmartcols/src/table.c \
 	libsmartcols/src/table_print.c \
 	libsmartcols/src/version.c \
-	libsmartcols/src/init.c \
-	$(nodist_smartcolsinc_HEADERS)
-
-nodist_libsmartcols_la_SOURCES = libsmartcols/src/smartcolsP.h
+	libsmartcols/src/init.c
 
 libsmartcols_la_LIBADD = libcommon.la
 
diff --git a/libuuid/src/Makemodule.am b/libuuid/src/Makemodule.am
index 0816fac4a..a1c1e4ab3 100644
--- a/libuuid/src/Makemodule.am
+++ b/libuuid/src/Makemodule.am
@@ -11,6 +11,7 @@ uuidinc_HEADERS = libuuid/src/uuid.h
 usrlib_exec_LTLIBRARIES += libuuid.la
 
 libuuid_la_SOURCES = \
+	libuuid/src/uuidP.h \
 	libuuid/src/clear.c \
 	libuuid/src/compare.c \
 	libuuid/src/copy.c \
@@ -21,11 +22,8 @@ libuuid_la_SOURCES = \
 	libuuid/src/unpack.c \
 	libuuid/src/unparse.c \
 	libuuid/src/uuidd.h \
-	libuuid/src/uuidd.h \
-	libuuid/src/uuidP.h \
 	libuuid/src/uuid_time.c \
 	libuuid/src/predefined.c \
-	$(uuidinc_HEADERS) \
 	lib/randutils.c \
 	lib/md5.c \
 	lib/sha1.c
-- 
2.13.6

