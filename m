Return-Path: util-linux-owner@vger.kernel.org
Received: from domu-toccata.ens-lyon.fr ([140.77.166.138]:50606 "EHLO
	sonata.ens-lyon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbaKICTG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Nov 2014 21:19:06 -0500
Date: Sun, 9 Nov 2014 03:19:01 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: libfdisk: fdisk_read_firstsector should seek to offset 0
Message-ID: <20141109021901.GA2799@type.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The current offset of cxt->dev_fd may not be still 0, notably when
blkdev_get_size has to resort to using blkdev_find_size

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org

--- libfdisk/src/utils.c.original	2014-11-09 02:06:55.000000000 +0000
+++ libfdisk/src/utils.c	2014-11-09 02:07:58.000000000 +0000
@@ -49,6 +49,13 @@ int fdisk_read_firstsector(struct fdisk_
 	DBG(CXT, ul_debugobj(cxt, "reading first sector "
 				"buffer [sector_size=%lu]", cxt->sector_size));
 
+	r = lseek(cxt->dev_fd, 0, SEEK_SET);
+	if (r == -1)
+	{
+		DBG(CXT, ul_debugobj(cxt, "failed to seek to first sector %m"));
+		return -errno;
+	}
+
 	r = read(cxt->dev_fd, cxt->firstsector, cxt->sector_size);
 
 	if (r != cxt->sector_size) {
