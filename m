Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdccac.dreamhost.com ([208.97.132.202]:45535 "EHLO
	homiemail-a37.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753376Ab2EFMKj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 6 May 2012 08:10:39 -0400
Subject: [PATCH 5/5] fdisk: sgi: abort on HDIO_GETGEO failure
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 06 May 2012 14:10:25 +0200
Message-ID: <1336306225.2685.14.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

When the HDIO_GETGEO ioctl fails on non IRIX/MIPS platforms (ie: inappropriate ioctl for device) the variables that describe the geometry are compromissed.
One clear example is a division by 0 bug because the cylinder size is 0 is verify_sgi():

$> fdisk sgi.img
Welcome to fdisk (util-linux 2.21.392-4b1c).

...

Command (m for help): x

Expert command (m for help): g
Building a new SGI disklabel.
Partition 11 of type SGI volume and of size 7.9 MiB is set
Floating point exception

Fix this by simply exiting the program instead of leaving it in a vulnerable state.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisksgilabel.c |   39 ++++++++++++++++++++-------------------
 1 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/fdisk/fdisksgilabel.c b/fdisk/fdisksgilabel.c
index 822f55d..b61f102 100644
--- a/fdisk/fdisksgilabel.c
+++ b/fdisk/fdisksgilabel.c
@@ -705,25 +705,26 @@ create_sgilabel(void)
 	res = blkdev_get_sectors(fd, &llsectors);
 
 #ifdef HDIO_GETGEO
-	if (!ioctl(fd, HDIO_GETGEO, &geometry)) {
-		heads = geometry.heads;
-		sectors = geometry.sectors;
-		if (res == 0) {
-			/* the get device size ioctl was successful */
-			unsigned long long llcyls;
-			llcyls = llsectors / (heads * sectors * sec_fac);
-			cylinders = llcyls;
-			if (cylinders != llcyls)	/* truncated? */
-				cylinders = ~0;
-		} else {
-			/* otherwise print error and use truncated version */
-			cylinders = geometry.cylinders;
-			fprintf(stderr,
-				_("Warning:  BLKGETSIZE ioctl failed on %s.  "
-				  "Using geometry cylinder value of %d.\n"
-				  "This value may be truncated for devices"
-				  " > 33.8 GB.\n"), disk_device, cylinders);
-		}
+	if (ioctl(fd, HDIO_GETGEO, &geometry) < 0)
+		err(EXIT_FAILURE, _("ioctl failed on %s"), disk_device);
+
+	heads = geometry.heads;
+	sectors = geometry.sectors;
+	if (res == 0) {
+		/* the get device size ioctl was successful */
+		unsigned long long llcyls;
+		llcyls = llsectors / (heads * sectors * sec_fac);
+		cylinders = llcyls;
+		if (cylinders != llcyls)	/* truncated? */
+			cylinders = ~0;
+	} else {
+		/* otherwise print error and use truncated version */
+		cylinders = geometry.cylinders;
+		fprintf(stderr,
+			_("Warning:  BLKGETSIZE ioctl failed on %s.  "
+			  "Using geometry cylinder value of %d.\n"
+			  "This value may be truncated for devices"
+			  " > 33.8 GB.\n"), disk_device, cylinders);
 	}
 #endif
 	for (i = 0; i < 4; i++) {
-- 
1.7.4.1




