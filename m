Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcaid.dreamhost.com ([208.97.132.83]:40089 "EHLO
	homiemail-a6.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751795Ab1LTNmT (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 20 Dec 2011 08:42:19 -0500
Subject: [PATCH 5/5] s/fdisk: use CDROM_GET_CAPABILITY ioctl
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 20 Dec 2011 14:42:10 +0100
Message-ID: <1324388530.3316.11.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

And replace the current archaic logic of is_ide_cdrom_or_tape().

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c    |   35 +++++++----------------------------
 fdisk/sfdisk.c   |   37 +++++++++----------------------------
 include/blkdev.h |    9 +++++++++
 lib/blkdev.c     |   13 +++++++++++++
 4 files changed, 38 insertions(+), 56 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index c41da7a..d967d27 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -2746,37 +2746,16 @@ expert_command_prompt(void)
 	}
 }
 
-static int
-is_ide_cdrom_or_tape(char *device) {
-	FILE *procf;
-	char buf[100];
-	struct stat statbuf;
-	int is_ide = 0;
-
-	/* No device was given explicitly, and we are trying some
-	   likely things.  But opening /dev/hdc may produce errors like
-           "hdc: tray open or drive not ready"
-	   if it happens to be a CD-ROM drive. It even happens that
-	   the process hangs on the attempt to read a music CD.
-	   So try to be careful. This only works since 2.1.73. */
+static int is_ide_cdrom_or_tape(char *device)
+{
+	int fd, ret;
 
-	if (strncmp("/dev/hd", device, 7))
+	if (fd = open(device, O_RDONLY) < 0)
 		return 0;
+	ret = blkdev_is_cdrom(fd);
 
-	snprintf(buf, sizeof(buf), "/proc/ide/%s/media", device+5);
-	procf = fopen(buf, "r");
-	if (procf != NULL && fgets(buf, sizeof(buf), procf))
-		is_ide = (!strncmp(buf, "cdrom", 5) ||
-			  !strncmp(buf, "tape", 4));
-	else
-		/* Now when this proc file does not exist, skip the
-		   device when it is read-only. */
-		if (stat(device, &statbuf) == 0)
-			is_ide = ((statbuf.st_mode & 0222) == 0);
-
-	if (procf)
-		fclose(procf);
-	return is_ide;
+	close(fd);
+	return ret;
 }
 
 static void
diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index fdc63d6..6efe47f 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -58,6 +58,7 @@
 #include "gpt.h"
 #include "pathnames.h"
 #include "canonicalize.h"
+#include "blkdev.h"
 
 /*
  * Table of contents:
@@ -2499,36 +2500,16 @@ static const struct option long_opts[] = {
     { NULL, 0, NULL, 0 }
 };
 
-static int
-is_ide_cdrom_or_tape(char *device) {
-    FILE *procf;
-    char buf[100];
-    struct stat statbuf;
-    int is_ide = 0;
-
-    /* No device was given explicitly, and we are trying some
-       likely things.  But opening /dev/hdc may produce errors like
-       "hdc: tray open or drive not ready"
-       if it happens to be a CD-ROM drive. It even happens that
-       the process hangs on the attempt to read a music CD.
-       So try to be careful. This only works since 2.1.73. */
+static int is_ide_cdrom_or_tape(char *device)
+{
+	int fd, ret;
 
-    if (strncmp("/dev/hd", device, 7))
-	return 0;
+	if (fd = open(device, O_RDONLY) < 0)
+		return 0;
+	ret = blkdev_is_cdrom(fd);
 
-    snprintf(buf, sizeof(buf), "/proc/ide/%s/media", device + 5);
-    procf = fopen(buf, "r");
-    if (procf != NULL && fgets(buf, sizeof(buf), procf))
-	is_ide = (!strncmp(buf, "cdrom", 5) || !strncmp(buf, "tape", 4));
-    else
-	/* Now when this proc file does not exist, skip the
-	   device when it is read-only. */
-    if (stat(device, &statbuf) == 0)
-	is_ide = ((statbuf.st_mode & 0222) == 0);
-
-    if (procf)
-	fclose(procf);
-    return is_ide;
+	close(fd);
+	return ret;
 }
 
 static char *
diff --git a/include/blkdev.h b/include/blkdev.h
index 1e7409d..1a9119d 100644
--- a/include/blkdev.h
+++ b/include/blkdev.h
@@ -72,6 +72,12 @@
 # ifdef __linux__
 #  define HDIO_GETGEO 0x0301
 # endif
+
+/* uniform CD-ROM information */
+#ifndef CDROM_GET_CAPABILITY
+# define CDROM_GET_CAPABILITY 0x5331
+#endif
+
 struct hd_geometry {
 	unsigned char heads;
 	unsigned char sectors;
@@ -98,4 +104,7 @@ int blkdev_is_misaligned(int fd);
 /* get physical block device size */
 int blkdev_get_physector_size(int fd, int *sector_size);
 
+/* is the device cdrom capable? */
+int blkdev_is_cdrom(int fd);
+
 #endif /* BLKDEV_H */
diff --git a/lib/blkdev.c b/lib/blkdev.c
index 3f652bb..cc7aa8f 100644
--- a/lib/blkdev.c
+++ b/lib/blkdev.c
@@ -243,6 +243,19 @@ int blkdev_is_misaligned(int fd)
 #endif
 }
 
+int blkdev_is_cdrom(int fd)
+{
+#ifdef CDROM_GET_CAPABILITY
+	int ret;
+	
+	if ((ret = ioctl(fd, CDROM_GET_CAPABILITY, NULL)) < 0)
+		return 0;
+	else
+		return ret;
+#else
+	return 0;
+#endif
+}
 
 #ifdef TEST_PROGRAM
 #include <stdio.h>
-- 
1.7.4.1




