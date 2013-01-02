Return-Path: util-linux-owner@vger.kernel.org
Received: from rrcs-67-78-168-186.se.biz.rr.com ([67.78.168.186]:34986 "EHLO
	iriserv.iradimed.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab3ABQkx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 2 Jan 2013 11:40:53 -0500
From: Phillip Susi <psusi@ubuntu.com>
To: util-linux@vger.kernel.org
Cc: Phillip Susi <psusi@ubuntu.com>
Subject: [PATCH] libblkid: add missing promise raid metadata locations
Date: Wed,  2 Jan 2013 11:40:46 -0500
Message-Id: <1357144846-14945-1-git-send-email-psusi@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There are some additional locations where dmraid can find
and use pdc raid metadata that libblkid was not checking.
---
 libblkid/src/superblocks/promise_raid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libblkid/src/superblocks/promise_raid.c b/libblkid/src/superblocks/promise_raid.c
index 221146d..01e4e37 100644
--- a/libblkid/src/superblocks/promise_raid.c
+++ b/libblkid/src/superblocks/promise_raid.c
@@ -29,7 +29,7 @@ static int probe_pdcraid(blkid_probe pr,
 {
 	unsigned int i;
 	static unsigned int sectors[] = {
-		63, 255, 256, 16, 399, 0
+	  63, 255, 256, 16, 399, 591, 675, 735, 911, 974, 991, 951, 3087, 0
 	};
 
 	if (pr->size < 0x40000)
-- 
1.7.9.5

