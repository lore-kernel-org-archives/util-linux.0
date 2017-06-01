Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:49276 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbdFABIn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 31 May 2017 21:08:43 -0400
Received: from tenfore.ga-group.nl ([77.12.147.210]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LkOeR-1dmXPm3tRz-00cQKm for
 <util-linux@vger.kernel.org>; Thu, 01 Jun 2017 03:08:42 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/6] build-sys: fix library order when linking
Date: Thu,  1 Jun 2017 03:08:37 +0200
Message-Id: <1496279320-14541-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de>
References: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

We got some errors on Alpine Linux where $LTLIBINTL is non-empty:

./.libs/libcommon.a(libcommon_la-blkdev.o): In function `open_blkdev_or_file':
lib/blkdev.c:282: undefined reference to `libintl_gettext
collect2: error: ld returned 1 exit status

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 lib/Makemodule.am                  | 2 +-
 libblkid/samples/Makemodule.am     | 8 ++++----
 libfdisk/src/Makemodule.am         | 2 +-
 libmount/src/Makemodule.am         | 2 +-
 libsmartcols/samples/Makemodule.am | 2 +-
 libuuid/src/Makemodule.am          | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/Makemodule.am b/lib/Makemodule.am
index 8909f92..82fefba 100644
--- a/lib/Makemodule.am
+++ b/lib/Makemodule.am
@@ -104,7 +104,7 @@ test_blkdev_LDADD = $(LDADD) libcommon.la
 
 test_ismounted_SOURCES = lib/ismounted.c
 test_ismounted_CFLAGS = $(AM_CFLAGS) -DTEST_PROGRAM_ISMOUNTED
-test_ismounted_LDADD = $(LDADD) libcommon.la
+test_ismounted_LDADD = libcommon.la $(LDADD)
 
 test_mangle_SOURCES = lib/mangle.c
 test_mangle_CFLAGS = $(AM_CFLAGS) -DTEST_PROGRAM_MANGLE
diff --git a/libblkid/samples/Makemodule.am b/libblkid/samples/Makemodule.am
index e14d13f..dd05fc9 100644
--- a/libblkid/samples/Makemodule.am
+++ b/libblkid/samples/Makemodule.am
@@ -6,17 +6,17 @@ check_PROGRAMS += \
 	sample-topology
 
 sample_mkfs_SOURCES = libblkid/samples/mkfs.c
-sample_mkfs_LDADD = $(LDADD) libblkid.la
+sample_mkfs_LDADD = libblkid.la $(LDADD)
 sample_mkfs_CFLAGS = $(AM_CFLAGS) -I$(ul_libblkid_incdir)
 
 sample_partitions_SOURCES = libblkid/samples/partitions.c
-sample_partitions_LDADD = $(LDADD) libblkid.la
+sample_partitions_LDADD = libblkid.la $(LDADD)
 sample_partitions_CFLAGS = $(AM_CFLAGS) -I$(ul_libblkid_incdir)
 
 sample_superblocks_SOURCES = libblkid/samples/superblocks.c
-sample_superblocks_LDADD = $(LDADD) libblkid.la
+sample_superblocks_LDADD = libblkid.la $(LDADD)
 sample_superblocks_CFLAGS = $(AM_CFLAGS) -I$(ul_libblkid_incdir)
 
 sample_topology_SOURCES = libblkid/samples/topology.c
-sample_topology_LDADD = $(LDADD) libblkid.la
+sample_topology_LDADD = libblkid.la $(LDADD)
 sample_topology_CFLAGS = $(AM_CFLAGS) -I$(ul_libblkid_incdir)
diff --git a/libfdisk/src/Makemodule.am b/libfdisk/src/Makemodule.am
index e3baf90..9ebfa65 100644
--- a/libfdisk/src/Makemodule.am
+++ b/libfdisk/src/Makemodule.am
@@ -78,7 +78,7 @@ check_PROGRAMS += \
 
 libfdisk_tests_cflags  = -DTEST_PROGRAM $(libfdisk_la_CFLAGS) $(NO_UNUSED_WARN_CFLAGS)
 libfdisk_tests_ldflags = libuuid.la -static
-libfdisk_tests_ldadd   = $(LDADD) libfdisk.la $(UUID_LIBS)
+libfdisk_tests_ldadd   = libfdisk.la $(LDADD) $(UUID_LIBS)
 
 if BUILD_LIBBLKID
 libfdisk_tests_ldflags += libblkid.la
diff --git a/libmount/src/Makemodule.am b/libmount/src/Makemodule.am
index 8c5ef08..af4a921 100644
--- a/libmount/src/Makemodule.am
+++ b/libmount/src/Makemodule.am
@@ -89,7 +89,7 @@ endif
 
 libmount_tests_cflags  = -DTEST_PROGRAM $(libmount_la_CFLAGS) $(NO_UNUSED_WARN_CFLAGS)
 libmount_tests_ldflags = libblkid.la -static
-libmount_tests_ldadd   = $(LDADD) libmount.la $(UUID_LIBS) $(REALTIME_LIBS)
+libmount_tests_ldadd   = libmount.la $(LDADD) $(UUID_LIBS) $(REALTIME_LIBS)
 
 if HAVE_SELINUX
 libmount_tests_ldadd += $(SELINUX_LIBS)
diff --git a/libsmartcols/samples/Makemodule.am b/libsmartcols/samples/Makemodule.am
index 0a54abb..644ac12 100644
--- a/libsmartcols/samples/Makemodule.am
+++ b/libsmartcols/samples/Makemodule.am
@@ -8,7 +8,7 @@ check_PROGRAMS += \
 
 sample_scols_cflags = $(AM_CFLAGS) $(NO_UNUSED_WARN_CFLAGS) \
                       -I$(ul_libsmartcols_incdir)
-sample_scols_ldadd = $(LDADD) libsmartcols.la
+sample_scols_ldadd = libsmartcols.la $(LDADD)
 
 if HAVE_OPENAT
 check_PROGRAMS += sample-scols-tree
diff --git a/libuuid/src/Makemodule.am b/libuuid/src/Makemodule.am
index d3fc811..f1de0f1 100644
--- a/libuuid/src/Makemodule.am
+++ b/libuuid/src/Makemodule.am
@@ -1,7 +1,7 @@
 
 check_PROGRAMS += test_uuid_parser
 test_uuid_parser_SOURCES = libuuid/src/test_uuid.c
-test_uuid_parser_LDADD = $(LDADD) libuuid.la $(SOCKET_LIBS)
+test_uuid_parser_LDADD = libuuid.la $(SOCKET_LIBS) $(LDADD)
 test_uuid_parser_CFLAGS = $(AM_CFLAGS) -I$(ul_libuuid_incdir)
 
 # includes
-- 
1.8.5.6

