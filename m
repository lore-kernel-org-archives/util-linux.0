Return-Path: dave@gnu.org
Subject: [PATCH] blkdev: add blkdev_get_physector_size()
From: Davidlohr Bueso <dave@gnu.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 20 Jun 2011 22:58:24 -0400
Message-ID: <1308625104.3690.1.camel@offworld>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Mon, 20 Jun 2011 22:51:47 -0400

This function uses the BLKPBSZGET ioctl to get the physical block size of the device.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 include/blkdev.h |    3 +++
 lib/blkdev.c     |   14 ++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/include/blkdev.h b/include/blkdev.h
index 6a64172..0024897 100644
--- a/include/blkdev.h
+++ b/include/blkdev.h
@@ -95,4 +95,7 @@ int blkdev_get_sector_size(int fd, int *sector_size);
 /* specifies whether or not the device is misaligned */
 int blkdev_is_misaligned(int fd);
 
+/* get physical block device size */
+int blkdev_get_physector_size(int fd);
+
 #endif /* BLKDEV_H */
diff --git a/lib/blkdev.c b/lib/blkdev.c
index 5cb6554..94df803 100644
--- a/lib/blkdev.c
+++ b/lib/blkdev.c
@@ -221,6 +221,20 @@ int blkdev_is_misaligned(int fd)
 #endif
 }
 
+/* get physical block device size */
+int blkdev_get_physector_size(int fd)
+{
+#ifdef BLKPBSZGET
+	int bsz;
+
+	if (ioctl(fd, BLKPBSZGET, &bsz) < 0)
+		return 0;
+	return bsz;
+#else
+	return 0;
+#endif
+}
+
 #ifdef TEST_PROGRAM
 #include <stdio.h>
 #include <stdlib.h>
-- 
1.7.5.4
