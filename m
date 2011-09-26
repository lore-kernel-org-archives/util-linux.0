Return-Path: dave@gnu.org
Subject: [PATCH 1/5] lomount: accomodate building with loopdev
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <1317066156.3401.1.camel@offbook>
References: <1317066156.3401.1.camel@offbook>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Sep 2011 16:49:55 -0300
Message-ID: <1317066595.2896.1.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Mon, 26 Sep 2011 14:56:45 -0300

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 mount/Makefile.am |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/mount/Makefile.am b/mount/Makefile.am
index e9237b7..f0e16d5 100644
--- a/mount/Makefile.am
+++ b/mount/Makefile.am
@@ -5,7 +5,9 @@ sbin_PROGRAMS = losetup swapon
 dist_man_MANS = fstab.5 mount.8 swapoff.8 swapon.8 umount.8 losetup.8
 
 # generic sources for all programs (mount, umount, losetup)
-srcs_common = sundries.c $(top_srcdir)/lib/canonicalize.c sundries.h
+srcs_common = sundries.c $(top_srcdir)/lib/canonicalize.c \
+	$(top_srcdir)/lib/linux_version.c $(top_srcdir)/lib/at.c \
+	$(top_srcdir)/lib/sysfs.c $(top_srcdir)/lib/loopdev.c sundries.h
 
 # generic header for mount and umount
 hdrs_mount = fstab.h mount_mntent.h mount_constants.h \
@@ -14,7 +16,7 @@ hdrs_mount = fstab.h mount_mntent.h mount_constants.h \
 # generic sources for mount and umount
 srcs_mount = fstab.c mount_mntent.c getusername.c lomount.c devname.c devname.h \
 	$(srcs_common) $(hdrs_mount) $(top_srcdir)/lib/env.c \
-	$(top_srcdir)/lib/linux_version.c $(top_srcdir)/lib/blkdev.c \
+	$(top_srcdir)/lib/blkdev.c \
 	$(top_srcdir)/lib/fsprobe.c $(top_srcdir)/lib/mangle.c
 
 # generic flags for all programs (except losetup)
@@ -42,8 +44,7 @@ swapon_SOURCES = swapon.c swap_constants.h $(top_srcdir)/lib/linux_version.c \
 swapon_CFLAGS = $(cflags_common)
 swapon_LDADD = $(ldadd_common)
 
-losetup_SOURCES = lomount.c $(srcs_common) loop.h lomount.h \
-		$(top_srcdir)/lib/strutils.c
+losetup_SOURCES = lomount.c $(srcs_common) loop.h lomount.h $(top_srcdir)/lib/strutils.c 
 losetup_CPPFLAGS = -DMAIN $(AM_CPPFLAGS)
 
 mount_static_LDADD =
-- 
1.7.4.1
