Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34083 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbcDUHZ0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 21 Apr 2016 03:25:26 -0400
Received: by mail-pf0-f180.google.com with SMTP id y69so10429238pfb.1
        for <util-linux@vger.kernel.org>; Thu, 21 Apr 2016 00:25:26 -0700 (PDT)
From: Victor Dodon <dodonvictor@gmail.com>
To: util-linux@vger.kernel.org
Cc: Victor Dodon <dodonvictor@gmail.com>
Subject: [PATCH] sfdisk: exit with error if rereading partition table fails
Date: Thu, 21 Apr 2016 00:24:58 -0700
Message-Id: <1461223498-19392-1-git-send-email-dodonvictor@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use the return value of fdisk_reread_partition_table in write_changes so that
sfdisk exits with error if re-reading the partition table fails.

Signed-off-by: Victor Dodon <dodonvictor@gmail.com>
---
 disk-utils/sfdisk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 15fa99c..b520c9b 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -534,7 +534,7 @@ static int write_changes(struct sfdisk *sf)
 			rc = move_partition_data(sf, sf->partno, sf->orig_pa);
 		if (!rc) {
 			fdisk_info(sf->cxt, _("\nThe partition table has been altered."));
-			fdisk_reread_partition_table(sf->cxt);
+			rc = fdisk_reread_partition_table(sf->cxt);
 		}
 	}
 	if (!rc)
-- 
2.8.0

