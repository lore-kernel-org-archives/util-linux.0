Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcagg.dreamhost.com ([208.97.132.66]:52322 "EHLO
	homiemail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756854Ab2DDRB2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 4 Apr 2012 13:01:28 -0400
Subject: [PATCH] fdisk: move kernel geometry into blkdev
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 Apr 2012 19:01:24 +0200
Message-ID: <1333558884.2573.4.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

This is a more generic place for this ioctl.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c    |   15 +--------------
 include/blkdev.h |    3 +++
 lib/blkdev.c     |   23 +++++++++++++++++++++++
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 8893a01..126efb3 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -954,19 +954,6 @@ get_topology(int fd) {
 }
 
 static void
-get_kernel_geometry(int fd) {
-#ifdef HDIO_GETGEO
-	struct hd_geometry geometry;
-
-	if (!ioctl(fd, HDIO_GETGEO, &geometry)) {
-		kern_heads = geometry.heads;
-		kern_sectors = geometry.sectors;
-		/* never use geometry.cylinders - it is truncated */
-	}
-#endif
-}
-
-static void
 get_partition_table_geometry(void) {
 	unsigned char *bufp = MBRbuffer;
 	struct partition *p;
@@ -1057,7 +1044,7 @@ get_geometry(int fd, struct geom *g) {
 	kern_heads = kern_sectors = 0;
 	pt_heads = pt_sectors = 0;
 
-	get_kernel_geometry(fd);
+	blkdev_get_geometry(fd, &kern_heads, &kern_sectors);
 	get_partition_table_geometry();
 
 	heads = user_heads ? user_heads :
diff --git a/include/blkdev.h b/include/blkdev.h
index 6b18879..56dbce7 100644
--- a/include/blkdev.h
+++ b/include/blkdev.h
@@ -110,4 +110,7 @@ int blkdev_get_physector_size(int fd, int *sector_size);
 /* is the device cdrom capable? */
 int blkdev_is_cdrom(int fd);
 
+/* get device's geometry - legacy */
+int blkdev_get_geometry(int fd, unsigned int *h, unsigned int *s);
+
 #endif /* BLKDEV_H */
diff --git a/lib/blkdev.c b/lib/blkdev.c
index c59386d..45c754d 100644
--- a/lib/blkdev.c
+++ b/lib/blkdev.c
@@ -263,6 +263,29 @@ int blkdev_is_cdrom(int fd)
 #endif
 }
 
+/*
+ * Get kernel's interpretation of the device's geometry.
+ * 
+ * Returns the heads and sectors - but not cylinders
+ * as it's truncated for disks with more than 65535 tracks.
+ *
+ * Note that this is deprecated in favor of LBA addressing.
+ */
+int blkdev_get_geometry(int fd, unsigned int *h, unsigned int *s)
+{
+#ifdef HDIO_GETGEO
+	struct hd_geometry geometry;
+
+	if (!ioctl(fd, HDIO_GETGEO, &geometry)) {
+		*h = geometry.heads;
+		*s = geometry.sectors;
+	}
+#else
+	*h = 0;
+	*s = 0;
+#endif
+}
+
 #ifdef TEST_PROGRAM
 #include <stdio.h>
 #include <stdlib.h>
-- 
1.7.4.1



