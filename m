Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37795 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbbJaTVk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 31 Oct 2015 15:21:40 -0400
Received: by wmff134 with SMTP id f134so33207579wmf.0
        for <util-linux@vger.kernel.org>; Sat, 31 Oct 2015 12:21:39 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 07/12] include/blkdev: add open_blkdev_or_file() function
Date: Sat, 31 Oct 2015 19:21:19 +0000
Message-Id: <1446319284-24778-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
References: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Purpose of this function is to open a path that is potentially pointing to a
block device or file without races, and checking ensuring block device is
not busy when path points to such.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/blkdev.h |  3 +++
 lib/blkdev.c     | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/blkdev.h b/include/blkdev.h
index c994795..fde2dbf 100644
--- a/include/blkdev.h
+++ b/include/blkdev.h
@@ -97,6 +97,9 @@ struct hd_geometry {
 /* are we working with block device? */
 int is_blkdev(int fd);
 
+/* open block device or file */
+int open_blkdev_or_file(const char *name, const int oflag);
+
 /* Determine size in bytes */
 off_t blkdev_find_size (int fd);
 
diff --git a/lib/blkdev.c b/lib/blkdev.c
index 5f49582..da8d835 100644
--- a/lib/blkdev.c
+++ b/lib/blkdev.c
@@ -25,9 +25,15 @@
 # include <sys/disk.h>
 #endif
 
+#ifndef EBADFD
+# define EBADFD 77		/* File descriptor in bad state */
+#endif
+
 #include "blkdev.h"
 #include "c.h"
 #include "linux_version.h"
+#include "fileutils.h"
+#include "nls.h"
 
 static long
 blkdev_valid_offset (int fd, off_t offset) {
@@ -254,6 +260,27 @@ int blkdev_is_misaligned(int fd)
 #endif
 }
 
+int open_blkdev_or_file(const char *name, const int oflag)
+{
+	int fd;
+	struct stat ftype;
+
+	if (stat(name, &ftype) < 0)
+		return -1;
+	if (S_ISBLK(ftype.st_mode)) {
+		fd = open(name, oflag | O_EXCL);
+	} else
+		fd = open(name, oflag);
+	if (-1 < fd && !is_same_inode(fd, name)) {
+		close(fd);
+		errno = EBADFD;
+		return -1;
+	}
+	if (-1 < fd && S_ISBLK(ftype.st_mode) && blkdev_is_misaligned(fd))
+		warnx(_("warning: %s is misaligned"), name);
+	return fd;
+}
+
 int blkdev_is_cdrom(int fd)
 {
 #ifdef CDROM_GET_CAPABILITY
-- 
2.6.2

