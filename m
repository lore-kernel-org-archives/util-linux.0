Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:64940 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756278AbeATSG1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 20 Jan 2018 13:06:27 -0500
Received: from adsiz.fritz.box ([146.52.144.151]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MRCCJ-1eF91310tb-00UZAK for
 <util-linux@vger.kernel.org>; Sat, 20 Jan 2018 19:06:26 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/5] build-sys: remove unneeded dependencies on bla.h.in
Date: Sat, 20 Jan 2018 19:06:22 +0100
Message-Id: <20180120180624.15213-4-sweet_f_a@gmx.de>
In-Reply-To: <20180120180624.15213-1-sweet_f_a@gmx.de>
References: <20180120180624.15213-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

We have already automakes's automatic dependencies like
  bla.h.in -> bla.h -> foo.o -> bar.la

An explicit direct dependency bla.h.in -> bar.la
is redundant and useless anyways.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libblkid/src/Makemodule.am     | 3 +--
 libfdisk/src/Makemodule.am     | 3 +--
 libmount/src/Makemodule.am     | 3 +--
 libsmartcols/src/Makemodule.am | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/libblkid/src/Makemodule.am b/libblkid/src/Makemodule.am
index f41f8383d..2bd19959f 100644
--- a/libblkid/src/Makemodule.am
+++ b/libblkid/src/Makemodule.am
@@ -115,8 +115,7 @@ libblkid_la_LIBADD = libcommon.la
 
 libblkid_la_DEPENDENCIES = \
 	libcommon.la \
-	libblkid/src/libblkid.sym \
-	libblkid/src/blkid.h.in
+	libblkid/src/libblkid.sym
 
 libblkid_la_CFLAGS = \
 	$(AM_CFLAGS) \
diff --git a/libfdisk/src/Makemodule.am b/libfdisk/src/Makemodule.am
index 8ac19b60e..73bc89a95 100644
--- a/libfdisk/src/Makemodule.am
+++ b/libfdisk/src/Makemodule.am
@@ -43,8 +43,7 @@ libfdisk_la_CFLAGS = \
 libfdisk_la_DEPENDENCIES = \
 	libcommon.la \
 	libuuid.la \
-	libfdisk/src/libfdisk.sym \
-	libfdisk/src/libfdisk.h.in
+	libfdisk/src/libfdisk.sym
 
 libfdisk_la_LDFLAGS = $(SOLIB_LDFLAGS)
 if HAVE_VSCRIPT
diff --git a/libmount/src/Makemodule.am b/libmount/src/Makemodule.am
index 9d693197b..1a6a8374a 100644
--- a/libmount/src/Makemodule.am
+++ b/libmount/src/Makemodule.am
@@ -55,8 +55,7 @@ libmount_la_CFLAGS = \
 libmount_la_DEPENDENCIES = \
 	libcommon.la \
 	libblkid.la \
-	libmount/src/libmount.sym \
-	libmount/src/libmount.h.in
+	libmount/src/libmount.sym
 
 libmount_la_LDFLAGS = $(SOLIB_LDFLAGS)
 if HAVE_VSCRIPT
diff --git a/libsmartcols/src/Makemodule.am b/libsmartcols/src/Makemodule.am
index 62fdf1051..6f5f6072c 100644
--- a/libsmartcols/src/Makemodule.am
+++ b/libsmartcols/src/Makemodule.am
@@ -29,8 +29,7 @@ libsmartcols_la_CFLAGS = \
 
 libsmartcols_la_DEPENDENCIES = \
 	libcommon.la \
-	libsmartcols/src/libsmartcols.sym \
-	libsmartcols/src/libsmartcols.h.in
+	libsmartcols/src/libsmartcols.sym
 
 libsmartcols_la_LDFLAGS = $(SOLIB_LDFLAGS)
 if HAVE_VSCRIPT
-- 
2.13.6

