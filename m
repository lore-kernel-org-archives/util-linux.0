Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50296 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500Ab1HPWTL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 16 Aug 2011 18:19:11 -0400
Received: by wyg24 with SMTP id 24so281588wyg.19
        for <util-linux@vger.kernel.org>; Tue, 16 Aug 2011 15:19:10 -0700 (PDT)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 2/5] fdisk: print partition deleted message
Date: Wed, 17 Aug 2011 00:19:03 +0200
Message-Id: <1313533146-2806-2-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1313533146-2806-1-git-send-email-cosoleto@gmail.com>
References: <1313533146-2806-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index a08a4d4..d3fc200 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -1676,27 +1676,18 @@ delete_partition(int i) {
 		return;		/* C/H/S not set */
 	pe->changed = 1;
 
-	if (disklabel == SUN_LABEL) {
+	if (disklabel == SUN_LABEL)
 		sun_delete_partition(i);
-		return;
-	}
-
-	if (disklabel == SGI_LABEL) {
+	else if (disklabel == SGI_LABEL)
 		sgi_delete_partition(i);
-		return;
-	}
-
-	if (i < 4) {
+	else if (i < 4) {
 		if (IS_EXTENDED (p->sys_ind) && i == ext_index) {
 			partitions = 4;
 			ptes[ext_index].ext_pointer = NULL;
 			extended_offset = 0;
 		}
 		clear_partition(p);
-		return;
-	}
-
-	if (!q->sys_ind && i > 4) {
+	} else if (!q->sys_ind && i > 4) {
 		/* the last one in the chain - just delete */
 		--partitions;
 		--i;
@@ -1733,6 +1724,7 @@ delete_partition(int i) {
 			/* the only logical: clear only */
 			clear_partition(ptes[i].part_table);
 	}
+	printf(_("Partition %d is deleted\n"), i + 1);
 }
 
 static void
-- 
1.7.3.4

