Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbef.dreamhost.com ([208.97.132.145]:51776 "EHLO
	homiemail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752123Ab2DPJor (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Apr 2012 05:44:47 -0400
Subject: [PATCH 3/8] fdisk: kernel/bios sectors and heads need not be global
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 16 Apr 2012 11:44:39 +0200
Message-ID: <1334569479.2552.12.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 0954028..1c0d7d8 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -225,8 +225,7 @@ int	fd,				/* the disk */
 	partitions = 4;			/* maximum partition + 1 */
 
 unsigned int	user_cylinders, user_heads, user_sectors;
-unsigned int	pt_heads, pt_sectors;
-unsigned int	kern_heads, kern_sectors;
+unsigned int   pt_heads, pt_sectors;
 
 unsigned long long sector_offset = 1, extended_offset = 0, sectors;
 
@@ -998,10 +997,10 @@ update_sector_offset(void)
 void
 get_geometry(int fd, struct geom *g) {
 	unsigned long long llcyls, nsects = 0;
+	unsigned int kern_heads = 0, kern_sectors = 0;
 
 	get_topology(fd);
 	heads = cylinders = sectors = 0;
-	kern_heads = kern_sectors = 0;
 	pt_heads = pt_sectors = 0;
 
 	blkdev_get_geometry(fd, &kern_heads, &kern_sectors);
-- 
1.7.4.1




