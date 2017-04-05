Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:50068 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932343AbdDEJ4c (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 5 Apr 2017 05:56:32 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LbgyV-1cGY2X0pr9-00lDgO for <util-linux@vger.kernel.org>; Wed, 05 Apr 2017
 11:56:30 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] libfdisk: fix gpt for 32bit systems
Date: Wed,  5 Apr 2017 11:56:29 +0200
Message-Id: <1491386189-8163-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

test libfdisk/gpt failed since bb676203 because UINT32_MAX does
not fit into ssize_t on 32bit systems.

This patch rewrites parts of commit f71b96bf. Also handling
multiplication overflow and some typos. Note that it still looks
questionable that we would try to read() SSIZE_MAX bytes in
gpt_read_entries().

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libfdisk/src/gpt.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index c99b16f..2091673 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -820,19 +820,19 @@ static ssize_t read_lba(struct fdisk_context *cxt, uint64_t lba,
 static struct gpt_entry *gpt_read_entries(struct fdisk_context *cxt,
 					 struct gpt_header *header)
 {
-	ssize_t sz;
+	uint64_t sz;
 	struct gpt_entry *ret = NULL;
 	off_t offset;
 
 	assert(cxt);
 	assert(header);
 
-	sz = (ssize_t) le32_to_cpu(header->npartition_entries) *
+	sz = (uint64_t) le32_to_cpu(header->npartition_entries) *
 	     le32_to_cpu(header->sizeof_partition_entry);
 
-	if (sz == 0 || sz >= (ssize_t) UINT32_MAX ||
+	if (sz == 0 || sz >= UINT32_MAX || sz > SSIZE_MAX ||
 	    le32_to_cpu(header->sizeof_partition_entry) != sizeof(struct gpt_entry)) {
-		DBG(LABEL, ul_debug("GPT entreis array size check failed"));
+		DBG(LABEL, ul_debug("GPT entries array size check failed"));
 		return NULL;
 	}
 
@@ -844,7 +844,7 @@ static struct gpt_entry *gpt_read_entries(struct fdisk_context *cxt,
 
 	if (offset != lseek(cxt->dev_fd, offset, SEEK_SET))
 		goto fail;
-	if (sz != read(cxt->dev_fd, ret, sz))
+	if ((ssize_t)sz != read(cxt->dev_fd, ret, sz))
 		goto fail;
 
 	return ret;
@@ -2522,10 +2522,10 @@ static int gpt_check_table_overlap(struct fdisk_context *cxt,
 int fdisk_gpt_set_npartitions(struct fdisk_context *cxt, uint32_t entries)
 {
 	struct fdisk_gpt_label *gpt;
-	size_t old_size, new_size;
+	size_t old_size;
 	uint32_t old;
 	struct gpt_entry *ents;
-	uint64_t first_usable, last_usable;
+	uint64_t first_usable, last_usable, new_size;
 	int rc;
 
 	assert(cxt);
@@ -2541,10 +2541,10 @@ int fdisk_gpt_set_npartitions(struct fdisk_context *cxt, uint32_t entries)
 		return 0;	/* do nothing, say nothing */
 
 	/* calculate the size (bytes) of the entries array */
-	new_size = entries * le32_to_cpu(gpt->pheader->sizeof_partition_entry);
-	if (new_size >= UINT32_MAX) {
-		fdisk_warnx(cxt, _("The number of the partition has be smaller than %zu."),
-				UINT32_MAX / le32_to_cpu(gpt->pheader->sizeof_partition_entry));
+	new_size = (uint64_t) entries *
+	           le32_to_cpu(gpt->pheader->sizeof_partition_entry);
+	if (new_size >= UINT32_MAX || new_size > SIZE_MAX) {
+		fdisk_warnx(cxt, _("The number of partitions is too large."));
 		return -EINVAL;
 	}
 
-- 
1.8.5.6

