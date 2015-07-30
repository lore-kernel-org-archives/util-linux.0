Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37217 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbbG3OSi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 30 Jul 2015 10:18:38 -0400
Received: by wibud3 with SMTP id ud3so70544600wib.0
        for <util-linux@vger.kernel.org>; Thu, 30 Jul 2015 07:18:37 -0700 (PDT)
From: Milan Broz <gmazyland@gmail.com>
To: util-linux@vger.kernel.org
Cc: Milan Broz <gmazyland@gmail.com>
Subject: [PATCH] lsblk: Display mountpoint even for top-level device
Date: Thu, 30 Jul 2015 16:18:28 +0200
Message-Id: <1438265908-4603-1-git-send-email-gmazyland@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If a filesystem is mounted on top-level block device
with existing partitions, the mountpoint is not displayed
in the lsblk output.

This situation can happen by a configuration mistake
and lsblk could be used to detect such a mistake.

This patch allows searching for a mountpoint for all displayed
devices, not only for leaf nodes.
(It should be pretty cheap operation, mtab is parsed only once.)

For example: lsblk /dev/loop1
NAME      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
loop1       7:1    0  128M  0 loop /mnt/tst
└─loop1p1 259:0    0  127M  0 loop

Signed-off-by: Milan Broz <gmazyland@gmail.com>
---
 misc-utils/lsblk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index cfd304a..4cfeef8 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -916,8 +916,7 @@ static void set_scols_data(struct blkdev_cxt *cxt, int col, int id, struct libsc
 			str = xstrdup(cxt->fstype);
 		break;
 	case COL_TARGET:
-		if (!(cxt->nholders + cxt->npartitions))
-			str = get_device_mountpoint(cxt);
+		str = get_device_mountpoint(cxt);
 		break;
 	case COL_LABEL:
 		probe_device(cxt);
-- 
2.5.0

