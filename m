Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:41589 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563Ab3C0UpI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 27 Mar 2013 16:45:08 -0400
Message-ID: <51535A4C.4060604@suse.com>
Date: Wed, 27 Mar 2013 16:45:00 -0400
From: Jeff Mahoney <jeffm@suse.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: [PATCH v2] loopdev: sync capacity after setting it
References: <51438CF9.7020707@suse.com> <5145D0B4.1070207@suse.com> <20130318092700.GC2172@x2.net.home> <51471122.6030804@suse.com> <20130318131827.GE2172@x2.net.home>
In-Reply-To: <20130318131827.GE2172@x2.net.home>
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I recently tried to mount an hfsplus file system from an image file with
a partition table by using the loop offset and sizelimit options to specify
the location of the file system.

hfsplus stores some metadata at a set offset from the end of the partition,
so it's sensitive to the device size reported by the kernel.

It worked with this:
# losetup -r -o 32k --sizelimit=102400000 <loopdev> <imagefile>
# mount -r -t hfsplus <loopdev> <mountpoint>

But failed with this:
# mount -r -oloop,offset=32k,sizelimit=102400000 <imagefile> <mountpoint>

# losetup -a
/dev/loop0: [0089]:2 (<imagefile>), offset 32768, sizelimit 102400000
/dev/loop1: [0089]:2 (<imagefile>), offset 32768, sizelimit 102400000

/proc/partitions shows the correct number of blocks to match the sizelimit.

But if I set a breakpoint in mount before the mount syscall, I could see:
# blockdev --getsize64 /dev/loop[01]
102400000
102432768

The kernel loop driver will set the gendisk capacity of the device at
LOOP_SET_STATUS64 but won't sync it to the block device until one of two
conditions are met: All open file descriptors referring to the device are
closed (and it will sync when re-opened) or if the LOOP_SET_CAPACITY ioctl
is called to sync it. Since mount opens the device and passes it directly
to the mount syscall after LOOP_SET_STATUS64 without closing and reopening
it, the sizelimit argument is effectively ignroed. The capacity needs to
be synced immediately for it to work as expected.

This patch adds the LOOP_SET_CAPACITY call to loopctx_setup_device since
the device isn't yet released to the user, so it's safe to sync the capacity
immediately.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 include/loopdev.h        |    1 
 lib/Makefile.am          |    4 +-
 lib/blkdev.c             |    2 -
 lib/loopdev.c            |   89 +++++++++++++++++++++++++++++++++++++++++++++--
 libmount/src/Makefile.am |    1 
 mount/mount.8            |   16 ++++++++
 sys-utils/Makefile.am    |    3 +
 sys-utils/losetup.c      |   19 ++--------
 8 files changed, 114 insertions(+), 21 deletions(-)

--- a/include/loopdev.h
+++ b/include/loopdev.h
@@ -160,6 +160,7 @@ extern int loopcxt_next(struct loopdev_c
 
 extern int loopcxt_setup_device(struct loopdev_cxt *lc);
 extern int loopcxt_delete_device(struct loopdev_cxt *lc);
+extern int loopcxt_set_capacity(struct loopdev_cxt *lc);
 
 int loopcxt_set_offset(struct loopdev_cxt *lc, uint64_t offset);
 int loopcxt_set_sizelimit(struct loopdev_cxt *lc, uint64_t sizelimit);
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -13,6 +13,7 @@ noinst_PROGRAMS += test_sysfs test_loopd
 endif
 
 test_blkdev_SOURCES = blkdev.c
+test_blkdev_CFLAGS = -DTEST_PROGRAM_BLKDEV
 test_ismounted_SOURCES = ismounted.c
 test_wholedisk_SOURCES = wholedisk.c
 test_mangle_SOURCES = mangle.c
@@ -31,7 +32,8 @@ test_sysfs_CFLAGS = -DTEST_PROGRAM_SYSFS
 test_loopdev_SOURCES = loopdev.c \
 		       $(test_sysfs_SOURCES) \
 		       $(top_srcdir)/lib/linux_version.c \
-		       $(top_srcdir)/lib/canonicalize.c
+		       $(top_srcdir)/lib/canonicalize.c \
+		       $(top_srcdir)/lib/blkdev.c
 
 test_loopdev_CFLAGS = -DTEST_PROGRAM_LOOPDEV
 endif
--- a/lib/blkdev.c
+++ b/lib/blkdev.c
@@ -263,7 +263,7 @@ int blkdev_is_cdrom(int fd)
 #endif
 }
 
-#ifdef TEST_PROGRAM
+#ifdef TEST_PROGRAM_BLKDEV
 #include <stdio.h>
 #include <stdlib.h>
 #include <fcntl.h>
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -37,6 +37,7 @@
 #include "pathnames.h"
 #include "loopdev.h"
 #include "canonicalize.h"
+#include "blkdev.h"
 
 #define CONFIG_LOOPDEV_DEBUG
 
@@ -968,6 +969,66 @@ int loopcxt_set_backing_file(struct loop
 }
 
 /*
+ * In kernels prior to v3.9, if the offset or sizelimit options
+ * are used, the block device's size won't be synced automatically.
+ * blockdev --getsize64 and filesystems will use the backing
+ * file size until the block device has been re-opened or the
+ * LOOP_SET_CAPACITY ioctl is called to sync the sizes.
+ *
+ * Since mount -oloop uses the LO_FLAGS_AUTOCLEAR option and passes
+ * the open file descriptor to the mount system call, we need to use
+ * the ioctl. Calling losetup directly doesn't have this problem since
+ * it closes the device when it exits and whatever consumes the device
+ * next will re-open it, causing the resync.
+ */
+static int
+loopcxt_check_size(struct loopdev_cxt *lc, int file_fd)
+{
+	unsigned long long size, expected_size;
+	int dev_fd;
+	struct stat st;
+	int retry = 2;
+
+	if (!lc->info.lo_offset && !lc->info.lo_sizelimit)
+		return 0;
+
+	if (fstat(file_fd, &st))
+		return -errno;
+
+	expected_size = st.st_size;
+
+	if (lc->info.lo_offset > 0)
+		expected_size -= lc->info.lo_offset;
+
+	if (lc->info.lo_sizelimit > 0 && lc->info.lo_sizelimit < expected_size)
+		expected_size = lc->info.lo_sizelimit;
+
+	dev_fd = loopcxt_get_fd(lc);
+	if (dev_fd < 0)
+		return -errno;
+
+	if (blkdev_get_size(dev_fd, &size))
+		return -errno;
+
+	if (expected_size != size) {
+		if (loopcxt_set_capacity(lc)) {
+			/* ioctl not available */
+			if (errno == ENOTTY || errno == EINVAL)
+				errno = ERANGE;
+			return -errno;
+		}
+
+		if (blkdev_get_size(dev_fd, &size))
+			return -errno;
+
+		if (expected_size != size)
+			return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
  * @cl: context
  *
  * Associate the current device (see loopcxt_{set,get}_device()) with
@@ -1045,9 +1106,6 @@ int loopcxt_setup_device(struct loopdev_
 
 	DBG(lc, loopdev_debug("setup: LOOP_SET_FD: OK"));
 
-	close(file_fd);
-	file_fd = -1;
-
 	if (ioctl(dev_fd, LOOP_SET_STATUS64, &lc->info)) {
 		DBG(lc, loopdev_debug("LOOP_SET_STATUS64 failed: %m"));
 		goto err;
@@ -1055,6 +1113,12 @@ int loopcxt_setup_device(struct loopdev_
 
 	DBG(lc, loopdev_debug("setup: LOOP_SET_STATUS64: OK"));
 
+	if ((rc = loopcxt_check_size(lc, file_fd)))
+		goto err;
+
+	close(file_fd);
+	file_fd = -1;
+
 	memset(&lc->info, 0, sizeof(lc->info));
 	lc->has_info = 0;
 	lc->info_failed = 0;
@@ -1071,6 +1135,25 @@ err:
 	return rc;
 }
 
+int loopcxt_set_capacity(struct loopdev_cxt *lc)
+{
+	int fd = loopcxt_get_fd(lc);
+	int rc;
+
+	if (fd < 0)
+		return -EINVAL;
+
+	/* Kernels prior to v2.6.30 don't support this ioctl */
+	if (ioctl(fd, LOOP_SET_CAPACITY, 0) < 0) {
+		int rc = -errno;
+		DBG(lc, loopdev_debug("LOOP_SET_CAPACITY failed: %m"));
+		return rc;
+	}
+
+	DBG(lc, loopdev_debug("capacity set"));
+	return 0;
+}
+
 int loopcxt_delete_device(struct loopdev_cxt *lc)
 {
 	int fd = loopcxt_get_fd(lc);
--- a/libmount/src/Makefile.am
+++ b/libmount/src/Makefile.am
@@ -23,6 +23,7 @@ libmount_la_SOURCES =	mountP.h version.c
 			$(top_srcdir)/lib/strutils.c \
 			$(top_srcdir)/lib/env.c \
 			$(top_srcdir)/lib/loopdev.c \
+			$(top_srcdir)/lib/blkdev.c \
 			$(top_srcdir)/lib/sysfs.c \
 			$(top_srcdir)/lib/linux_version.c
 
--- a/mount/mount.8
+++ b/mount/mount.8
@@ -2844,6 +2844,22 @@ and
 .BR ioctl
 families of functions) may lead to inconsistent result due to the lack of
 consistency check in kernel even if noac is used.
+.PP
+The
+.B loop
+option with the
+.B offset
+or
+.B sizelimit
+options used may fail when using older kernels if the
+.B mount
+command can't confirm that the size of the block device has been configured
+as requested. This situation can be worked around by using
+the
+.B losetup
+command manually before calling
+.B mount
+with the configured loop device.
 .SH HISTORY
 A
 .B mount
--- a/sys-utils/Makefile.am
+++ b/sys-utils/Makefile.am
@@ -34,7 +34,8 @@ losetup_SOURCES = losetup.c \
 		$(top_srcdir)/lib/loopdev.c \
 		$(top_srcdir)/lib/canonicalize.c \
 		$(top_srcdir)/lib/xgetpass.c \
-		$(top_srcdir)/lib/strutils.c
+		$(top_srcdir)/lib/strutils.c \
+		$(top_srcdir)/lib/blkdev.c
 
 if HAVE_STATIC_LOSETUP
 bin_PROGRAMS += losetup.static
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -107,20 +107,6 @@ static int show_all_loops(struct loopdev
 	return 0;
 }
 
-static int set_capacity(struct loopdev_cxt *lc)
-{
-	int fd = loopcxt_get_fd(lc);
-
-	if (fd < 0)
-		warn(_("%s: open failed"), loopcxt_get_device(lc));
-	else if (ioctl(fd, LOOP_SET_CAPACITY) != 0)
-		warnx(_("%s: set capacity failed"), loopcxt_get_device(lc));
-	else
-		return 0;
-
-	return -1;
-}
-
 static int delete_loop(struct loopdev_cxt *lc)
 {
 	if (loopcxt_delete_device(lc))
@@ -394,7 +380,10 @@ int main(int argc, char **argv)
 			warn(_("%s"), loopcxt_get_device(&lc));
 		break;
 	case A_SET_CAPACITY:
-		res = set_capacity(&lc);
+		res = loopcxt_set_capacity(&lc);
+		if (res)
+			warn(_("%s: set capacity failed"),
+			        loopcxt_get_device(&lc));
 		break;
 	default:
 		usage(stderr);



-- 
Jeff Mahoney
SUSE Labs
