Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:52493 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756290AbeATSG1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 20 Jan 2018 13:06:27 -0500
Received: from adsiz.fritz.box ([146.52.144.151]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVrQS-1eJI1C07QG-00X403 for
 <util-linux@vger.kernel.org>; Sat, 20 Jan 2018 19:06:26 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/5] build-sys: automake is able to find headers in builddir ...
Date: Sat, 20 Jan 2018 19:06:21 +0100
Message-Id: <20180120180624.15213-3-sweet_f_a@gmx.de>
In-Reply-To: <20180120180624.15213-1-sweet_f_a@gmx.de>
References: <20180120180624.15213-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libblkid/src/Makemodule.am     | 2 +-
 libfdisk/src/Makemodule.am     | 2 +-
 libmount/src/Makemodule.am     | 2 +-
 libsmartcols/src/Makemodule.am | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/libblkid/src/Makemodule.am b/libblkid/src/Makemodule.am
index b8843e896..f41f8383d 100644
--- a/libblkid/src/Makemodule.am
+++ b/libblkid/src/Makemodule.am
@@ -1,7 +1,7 @@
 
 # blkid.h is generated, so it's store in builddir!
 blkidincdir = $(includedir)/blkid
-nodist_blkidinc_HEADERS = $(top_builddir)/libblkid/src/blkid.h
+nodist_blkidinc_HEADERS = libblkid/src/blkid.h
 
 usrlib_exec_LTLIBRARIES += libblkid.la
 libblkid_la_SOURCES = \
diff --git a/libfdisk/src/Makemodule.am b/libfdisk/src/Makemodule.am
index 0e568381f..8ac19b60e 100644
--- a/libfdisk/src/Makemodule.am
+++ b/libfdisk/src/Makemodule.am
@@ -1,7 +1,7 @@
 
 # libfdisk.h is generated, so it's stored in builddir!
 fdiskincdir = $(includedir)/libfdisk
-nodist_fdiskinc_HEADERS = $(top_builddir)/libfdisk/src/libfdisk.h
+nodist_fdiskinc_HEADERS = libfdisk/src/libfdisk.h
 
 usrlib_exec_LTLIBRARIES += libfdisk.la
 libfdisk_la_SOURCES = \
diff --git a/libmount/src/Makemodule.am b/libmount/src/Makemodule.am
index 516bebbfa..9d693197b 100644
--- a/libmount/src/Makemodule.am
+++ b/libmount/src/Makemodule.am
@@ -1,7 +1,7 @@
 
 # libmount.h is generated, so it's store in builddir!
 mountincdir = $(includedir)/libmount
-nodist_mountinc_HEADERS = $(top_builddir)/libmount/src/libmount.h
+nodist_mountinc_HEADERS = libmount/src/libmount.h
 
 usrlib_exec_LTLIBRARIES += libmount.la
 libmount_la_SOURCES = \
diff --git a/libsmartcols/src/Makemodule.am b/libsmartcols/src/Makemodule.am
index 2b1c1fd1c..62fdf1051 100644
--- a/libsmartcols/src/Makemodule.am
+++ b/libsmartcols/src/Makemodule.am
@@ -2,7 +2,7 @@
 
 # smartcols.h is generated, so it's stored in builddir!
 smartcolsincdir = $(includedir)/libsmartcols
-nodist_smartcolsinc_HEADERS = $(top_builddir)/libsmartcols/src/libsmartcols.h
+nodist_smartcolsinc_HEADERS = libsmartcols/src/libsmartcols.h
 
 usrlib_exec_LTLIBRARIES += libsmartcols.la
 libsmartcols_la_SOURCES= \
-- 
2.13.6

