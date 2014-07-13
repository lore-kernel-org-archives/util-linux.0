Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35422 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbaGMUZ1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Jul 2014 16:25:27 -0400
Received: by mail-wi0-f175.google.com with SMTP id ho1so1577538wib.14
        for <util-linux@vger.kernel.org>; Sun, 13 Jul 2014 13:25:26 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/14] fdisk: avoid code duplication
Date: Sun, 13 Jul 2014 21:24:47 +0100
Message-Id: <1405283093-28182-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
References: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

To me having call to close() twice is less readable than one new
variable.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fdisk.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/disk-utils/fdisk.c b/disk-utils/fdisk.c
index e9b4fec..d6bb737 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -725,16 +725,15 @@ static void print_all_devices_pt(struct fdisk_context *cxt)
 
 static sector_t get_dev_blocks(char *dev)
 {
-	int fd;
+	int fd, ret;
 	sector_t size;
 
 	if ((fd = open(dev, O_RDONLY)) < 0)
 		err(EXIT_FAILURE, _("cannot open %s"), dev);
-	if (blkdev_get_sectors(fd, &size) == -1) {
-		close(fd);
-		err(EXIT_FAILURE, _("BLKGETSIZE ioctl failed on %s"), dev);
-	}
+	ret = blkdev_get_sectors(fd, &size);
 	close(fd);
+	if (ret < 0)
+		err(EXIT_FAILURE, _("BLKGETSIZE ioctl failed on %s"), dev);
 	return size/2;
 }
 
-- 
2.0.1

