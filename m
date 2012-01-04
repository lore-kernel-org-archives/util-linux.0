Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdccac.dreamhost.com ([208.97.132.202]:48364 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757163Ab2ADXCQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 4 Jan 2012 18:02:16 -0500
Subject: [PATCH 2/2] sfdisk: use is_blkdev
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Jan 2012 00:02:11 +0100
Message-ID: <1325718131.7056.6.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/sfdisk.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index 469e87f..70a5e2a 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -794,13 +794,6 @@ reread_ioctl(int fd) {
     return 0;
 }
 
-static int
-is_blockdev(int fd) {
-    struct stat statbuf;
-
-    return (fstat(fd, &statbuf) == 0 && S_ISBLK(statbuf.st_mode));
-}
-
 /* reread after writing */
 static int
 reread_disk_partition(char *dev, int fd) {
@@ -808,7 +801,7 @@ reread_disk_partition(char *dev, int fd) {
     fflush(stdout);
     sync();
 
-    if (reread_ioctl(fd) && is_blockdev(fd)) {
+    if (reread_ioctl(fd) && is_blkdev(fd)) {
 	do_warn(_("The command to re-read the partition table failed.\n"
 		  "Run partprobe(8), kpartx(8) or reboot your system now,\n"
 		  "before using mkfs\n"));
-- 
1.7.4.1




