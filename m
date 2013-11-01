Return-Path: util-linux-owner@vger.kernel.org
Received: from rrcs-67-78-168-186.se.biz.rr.com ([67.78.168.186]:58431 "EHLO
	iriserv.iradimed.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab3KARok (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 1 Nov 2013 13:44:40 -0400
From: Phillip Susi <psusi@ubuntu.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] blockdev: don't use HDIO_GETGEO
Date: Fri,  1 Nov 2013 13:37:05 -0400
Message-Id: <1383327425-2694-1-git-send-email-psusi@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

blockdev was still using this depreciated ioctl and that was
causing blockdev --report to fail on loop and nbd devices.
Switch to reading the partition start from sysfs instead.
This also allows it to correctly report > 2^32 sector counts.

Signed-off-by: Phillip Susi <psusi@ubuntu.com>
---
 disk-utils/blockdev.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/disk-utils/blockdev.c b/disk-utils/blockdev.c
index d030217..2ebe0e1 100644
--- a/disk-utils/blockdev.c
+++ b/disk-utils/blockdev.c
@@ -16,6 +16,7 @@
 #include "blkdev.h"
 #include "pathnames.h"
 #include "closestream.h"
+#include "sysfs.h"
 
 struct bdc {
 	long		ioc;		/* ioctl code */
@@ -436,7 +437,9 @@ static void report_device(char *device, int quiet)
 	int ro, ssz, bsz;
 	long ra;
 	unsigned long long bytes;
-	struct hd_geometry g;
+	unsigned long long start = 0;
+	struct sysfs_cxt cxt;
+	struct stat st;
 
 	fd = open(device, O_RDONLY | O_NONBLOCK);
 	if (fd < 0) {
@@ -446,15 +449,19 @@ static void report_device(char *device, int quiet)
 	}
 
 	ro = ssz = bsz = 0;
-	g.start = ra = 0;
+	ra = 0;
+	if (fstat(fd, &st) == 0) {
+		sysfs_init(&cxt, st.st_rdev, NULL);
+		sysfs_read_u64(&cxt, "start", &start);
+		sysfs_deinit(&cxt);
+	}
 	if (ioctl(fd, BLKROGET, &ro) == 0 &&
 	    ioctl(fd, BLKRAGET, &ra) == 0 &&
 	    ioctl(fd, BLKSSZGET, &ssz) == 0 &&
 	    ioctl(fd, BLKBSZGET, &bsz) == 0 &&
-	    ioctl(fd, HDIO_GETGEO, &g) == 0 &&
 	    blkdev_get_size(fd, &bytes) == 0) {
-		printf("%s %5ld %5d %5d %10ld %15lld   %s\n",
-		       ro ? "ro" : "rw", ra, ssz, bsz, g.start, bytes, device);
+		printf("%s %5ld %5d %5d %10lld %15lld   %s\n",
+		       ro ? "ro" : "rw", ra, ssz, bsz, start, bytes, device);
 	} else {
 		if (!quiet)
 			warnx(_("ioctl error on %s"), device);
-- 
1.8.1.2

