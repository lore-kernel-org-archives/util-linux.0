Return-Path: util-linux-owner@vger.kernel.org
Received: from rrcs-67-78-168-186.se.biz.rr.com ([67.78.168.186]:59371 "EHLO
	iriserv.iradimed.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755819Ab1LEUMq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Dec 2011 15:12:46 -0500
From: Phillip Susi <psusi@cfl.rr.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/4] partx: don't treat empty partition table as error
Date: Mon,  5 Dec 2011 15:02:52 -0500
Message-Id: <1323115372-3983-4-git-send-email-psusi@cfl.rr.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If a partition table was detected, but it had no partitions
in it, a poorly worded error message was printed and further
action halted.  For partx -a, this gave an unnecessary error
and for partx -u, prevented update from removing all partitions.

Signed-off-by: Phillip Susi <psusi@cfl.rr.com>
---
 partx/partx.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/partx/partx.c b/partx/partx.c
index 50b0c20..f4f2db1 100644
--- a/partx/partx.c
+++ b/partx/partx.c
@@ -696,12 +696,6 @@ static blkid_partlist get_partlist(blkid_probe pr,
 		printf(_("%s: partition table type '%s' detected\n"),
 		       device, blkid_parttable_get_type(tab));
 
-	if (!blkid_partlist_numof_partitions(ls)) {
-		warnx(_("%s: %s partition table does not contains "
-			"usable partitions"), device,
-			blkid_parttable_get_type(tab));
-		return NULL;
-	}
 	return ls;
 }
 
-- 
1.7.5.4

