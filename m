Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36706 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbcEMOBL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 13 May 2016 10:01:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id w143so3900018wmw.3
        for <util-linux@vger.kernel.org>; Fri, 13 May 2016 07:01:10 -0700 (PDT)
From: Sassan Panahinejad <sassan@sassan.me.uk>
To: util-linux@vger.kernel.org
Cc: Sassan Panahinejad <sassan@sassan.me.uk>
Subject: [PATCH v3 1/3] libfdisk: Add support for altering GPT size
Date: Fri, 13 May 2016 15:01:02 +0100
Message-Id: <1463148062-5599-1-git-send-email-sassan@sassan.me.uk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is useful in two situations:

1. More than 128 partitions are required. Or

2. The partition table must be restricted in size, such as when a system
expects to find a bootloader at a location that would otherwise overlap the
partition table.

The gdisk partitioner supports this feature.

libfdisk is already capable of reading and writing partition tables of any
size, but previously could only create ones of 128 entries and could not
resize.

This change should be fairly safe, as it has no effect unless explicitly
activated.
---
 libfdisk/src/gpt.c         | 100 +++++++++++++++++++++++++++++++++++++++++++++
 libfdisk/src/libfdisk.h.in |   1 +
 libfdisk/src/libfdisk.sym  |   1 +
 3 files changed, 102 insertions(+)

diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index 39c93bb..ff435e3 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -2453,6 +2453,106 @@ static int gpt_set_disklabel_id(struct fdisk_context *cxt)
 	return 0;
 }
 
+static int gpt_check_table_overlap(struct fdisk_context *cxt,
+				   uint64_t first_usable,
+				   uint64_t last_usable)
+{
+	struct fdisk_gpt_label *gpt = self_label(cxt);
+	unsigned int i;
+	int rc = 0;
+
+	/* First check if there's enough room for the table. last_lba may have wrapped */
+	if (first_usable > cxt->total_sectors || /* far too little space */
+	    last_usable > cxt->total_sectors || /* wrapped */
+	    first_usable > last_usable) { /* too little space */
+		fdisk_warnx(cxt, _("Not enough space for new partition table!"));
+		return -ENOSPC;
+	}
+
+	/* check that all partitions fit in the remaining space */
+	for (i = 0; i < le32_to_cpu(gpt->pheader->npartition_entries); i++) {
+		if (partition_unused(&gpt->ents[i]))
+		        continue;
+		if (gpt_partition_start(&gpt->ents[i]) < first_usable) {
+			fdisk_warnx(cxt, _("Partition #%u out of range (minimal start is %"PRIu64" sectors)"),
+		                    i + 1, first_usable);
+			rc = -EINVAL;
+		}
+		if (gpt_partition_end(&gpt->ents[i]) > last_usable) {
+			fdisk_warnx(cxt, _("Partition #%u out of range (maximal end is %"PRIu64" sectors)"),
+		                    i + 1, last_usable - 1);
+			rc = -EINVAL;
+		}
+	}
+	return rc;
+}
+
+int fdisk_gpt_set_npartitions(struct fdisk_context *cxt, unsigned long new)
+{
+	struct fdisk_gpt_label *gpt;
+	size_t old_size, new_size;
+	unsigned long old;
+	struct gpt_entry *ents;
+	uint64_t first_usable, last_usable;
+	int rc;
+
+	assert(cxt);
+	assert(cxt->label);
+	assert(fdisk_is_label(cxt, GPT));
+
+	gpt = self_label(cxt);
+
+	old = le32_to_cpu(gpt->pheader->npartition_entries);
+
+	/* calculate the size (bytes) of the entries array */
+	new_size = new * le32_to_cpu(gpt->pheader->sizeof_partition_entry);
+	old_size = old * le32_to_cpu(gpt->pheader->sizeof_partition_entry);
+
+	/* calculate new range of usable LBAs */
+	first_usable = (new_size / cxt->sector_size) + 2;
+	last_usable = cxt->total_sectors - 2 - (new_size / cxt->sector_size);
+
+	/* if expanding the table, first check that everything fits,
+	 * then allocate more memory and zero. */
+	if (new > old) {
+		rc = gpt_check_table_overlap(cxt, first_usable, last_usable);
+		if (rc)
+			return rc;
+		ents = realloc(gpt->ents, new_size);
+		if (!ents) {
+			fdisk_warnx(cxt, _("Cannot allocate memory!"));
+			return -ENOMEM;
+		}
+		memset(ents + old, 0, new_size - old_size);
+		gpt->ents = ents;
+	}
+
+	/* everything's ok, apply the new size */
+	gpt->pheader->npartition_entries = cpu_to_le32(new);
+	gpt->bheader->npartition_entries = cpu_to_le32(new);
+
+	/* usable LBA addresses will have changed */
+	fdisk_set_first_lba(cxt, first_usable);
+	fdisk_set_last_lba(cxt, last_usable);
+	gpt->pheader->first_usable_lba = cpu_to_le64(first_usable);
+	gpt->bheader->first_usable_lba = cpu_to_le64(first_usable);
+	gpt->pheader->last_usable_lba = cpu_to_le64(last_usable);
+	gpt->bheader->last_usable_lba = cpu_to_le64(last_usable);
+
+
+	/* The backup header must be recalculated */
+	gpt_mknew_header_common(cxt, gpt->bheader, le64_to_cpu(gpt->pheader->alternative_lba));
+
+	/* CRCs will have changed */
+	gpt_recompute_crc(gpt->pheader, gpt->ents);
+	gpt_recompute_crc(gpt->bheader, gpt->ents);
+
+	fdisk_info(cxt, _("Partition table length changed from %lu to %lu."), old, new);
+
+	fdisk_label_set_changed(cxt->label, 1);
+	return 0;
+}
+
 static int gpt_part_is_used(struct fdisk_context *cxt, size_t i)
 {
 	struct fdisk_gpt_label *gpt;
diff --git a/libfdisk/src/libfdisk.h.in b/libfdisk/src/libfdisk.h.in
index 6bd3a1e..f081711 100644
--- a/libfdisk/src/libfdisk.h.in
+++ b/libfdisk/src/libfdisk.h.in
@@ -602,6 +602,7 @@ enum fdisk_labelitem_sgi {
 #define GPT_FLAG_GUIDSPECIFIC	4
 
 extern int fdisk_gpt_is_hybrid(struct fdisk_context *cxt);
+extern int fdisk_gpt_set_npartitions(struct fdisk_context *cxt, unsigned long entries);
 extern int fdisk_gpt_get_partition_attrs(struct fdisk_context *cxt, size_t partnum, uint64_t *attrs);
 extern int fdisk_gpt_set_partition_attrs(struct fdisk_context *cxt, size_t partnum, uint64_t attrs);
 
diff --git a/libfdisk/src/libfdisk.sym b/libfdisk/src/libfdisk.sym
index c5aeac6..af0b401 100644
--- a/libfdisk/src/libfdisk.sym
+++ b/libfdisk/src/libfdisk.sym
@@ -262,4 +262,5 @@ FDISK_2.28 {
 
 FDISK_2.29 {
 	fdisk_wipe_partition;
+	fdisk_gpt_set_npartitions;
 } FDISK_2.28;
-- 
2.1.0

