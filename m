Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59840 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751186AbeCTQSy (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Mar 2018 12:18:54 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2KGI7i7007798
        for <util-linux@vger.kernel.org>; Tue, 20 Mar 2018 12:18:53 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gu46pd69e-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Tue, 20 Mar 2018 12:18:53 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <util-linux@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Tue, 20 Mar 2018 16:18:49 -0000
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
To: util-linux@vger.kernel.org
Cc: wild@linux.vnet.ibm.com, gerald.schaefer@de.ibm.com
Subject: [PATCH] lsmem: fix total online/offline memory calculation
Date: Tue, 20 Mar 2018 17:17:38 +0100
Message-Id: <20180320161738.49439-1-gerald.schaefer@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

lsmem currently calculates the total online/offline memory by iterating
over all lsmem->blocks. Depending on the lsmem options, there may be
only one lsmem->block, because all sysfs memory blocks could be merged
into one. In this case, the calculation is wrong, because the individual
online/offline state of the sysfs memory blocks is not preserved, but
rather lsmem->blocks[0].state is set to the state of the first sysfs
memory block, typically MEMORY_STATE_ONLINE (at least on s390).

This means that "Total offline memory" will always be calculated as 0
in such cases, e.g. when using "lsmem --summary", or any options that
would merge the table output to one line, like "lsmem -o RANGE":

~# lsmem --summary
Memory block size:         1G
Total online memory:      20G
Total offline memory:      0B

Adding the "-a" option shows the real summary, since there is no block
merging going on, and the calculation is therefore correct:

~# lsmem -a --summary
Memory block size:         1G
Total online memory:      16G
Total offline memory:      4G

Fix this by moving the online/offline calculation into the loop that
is iterating over all sysfs memory blocks, instead of iterating over
potentially merged lsmem->blocks.

Reported-by: Andre Wild <wild@linux.vnet.ibm.com>
Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
---
 sys-utils/lsmem.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sys-utils/lsmem.c b/sys-utils/lsmem.c
index 3e06e43be74e..517207431c83 100644
--- a/sys-utils/lsmem.c
+++ b/sys-utils/lsmem.c
@@ -443,6 +443,10 @@ static void read_info(struct lsmem *lsmem)
 
 	for (i = 0; i < lsmem->ndirs; i++) {
 		memory_block_read_attrs(lsmem, lsmem->dirs[i]->d_name, &blk);
+		if (blk.state == MEMORY_STATE_ONLINE)
+			lsmem->mem_online += lsmem->block_size;
+		else
+			lsmem->mem_offline += lsmem->block_size;
 		if (is_mergeable(lsmem, &blk)) {
 			lsmem->blocks[lsmem->nblocks - 1].count++;
 			continue;
@@ -451,12 +455,6 @@ static void read_info(struct lsmem *lsmem)
 		lsmem->blocks = xrealloc(lsmem->blocks, lsmem->nblocks * sizeof(blk));
 		*&lsmem->blocks[lsmem->nblocks - 1] = blk;
 	}
-	for (i = 0; i < lsmem->nblocks; i++) {
-		if (lsmem->blocks[i].state == MEMORY_STATE_ONLINE)
-			lsmem->mem_online += lsmem->block_size * lsmem->blocks[i].count;
-		else
-			lsmem->mem_offline += lsmem->block_size * lsmem->blocks[i].count;
-	}
 }
 
 static int memory_block_filter(const struct dirent *de)
-- 
2.13.5

