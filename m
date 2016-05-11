Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34315 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbcEKOyc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 11 May 2016 10:54:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id n129so9961495wmn.1
        for <util-linux@vger.kernel.org>; Wed, 11 May 2016 07:54:31 -0700 (PDT)
From: Sassan Panahinejad <sassan@sassan.me.uk>
To: util-linux@vger.kernel.org
Cc: Sassan Panahinejad <sassan@sassan.me.uk>
Subject: [PATCH 1/3] libfdisk: Add support for altering GPT size
Date: Wed, 11 May 2016 15:54:16 +0100
Message-Id: <1462978458-13908-1-git-send-email-sassan@sassan.me.uk>
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
 libfdisk/src/fdiskP.h      |  4 +++
 libfdisk/src/gpt.c         | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 libfdisk/src/label.c       | 34 ++++++++++++++++++++++++
 libfdisk/src/libfdisk.h.in |  2 ++
 libfdisk/src/libfdisk.sym  |  2 ++
 5 files changed, 107 insertions(+)

diff --git a/libfdisk/src/fdiskP.h b/libfdisk/src/fdiskP.h
index 6444c3d..cb17cb0 100644
--- a/libfdisk/src/fdiskP.h
+++ b/libfdisk/src/fdiskP.h
@@ -204,6 +204,10 @@ struct fdisk_label_operations {
 	int (*get_item)(struct fdisk_context *cxt, struct fdisk_labelitem *item);
 	/* set disk label ID */
 	int (*set_id)(struct fdisk_context *cxt);
+	/* get table length */
+	unsigned long (*get_length)(struct fdisk_context *cxt);
+	/* set table length */
+	int (*set_length)(struct fdisk_context *cxt, unsigned long length);
 
 
 	/* new partition */
diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index 39c93bb..86b6a6e 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -2453,6 +2453,69 @@ static int gpt_set_disklabel_id(struct fdisk_context *cxt)
 	return 0;
 }
 
+static unsigned long gpt_get_disklabel_length(struct fdisk_context *cxt)
+{
+	struct fdisk_gpt_label *gpt;
+
+	assert(cxt);
+	assert(cxt->label);
+	assert(fdisk_is_label(cxt, GPT));
+
+	gpt = self_label(cxt);
+
+	return le32_to_cpu(gpt->pheader->npartition_entries);
+}
+
+static int gpt_set_disklabel_length(struct fdisk_context *cxt, unsigned long new)
+{
+	struct fdisk_gpt_label *gpt;
+	ssize_t esz;
+	unsigned long old;
+
+	assert(cxt);
+	assert(cxt->label);
+	assert(fdisk_is_label(cxt, GPT));
+
+	gpt = self_label(cxt);
+
+	old = le32_to_cpu(gpt->pheader->npartition_entries);
+
+	gpt->pheader->npartition_entries = cpu_to_le32(new);
+	gpt->bheader->npartition_entries = cpu_to_le32(new);
+
+	/* calculate new size of the entries array */
+	esz = le32_to_cpu(gpt->pheader->npartition_entries) *
+			le32_to_cpu(gpt->pheader->sizeof_partition_entry);
+
+	/* if expanding the table, allocate more memory and zero.
+	 * Warn the user that this can cause data loss! (if table overlaps partition) */
+	if (new > old) {
+		fdisk_warnx(cxt, _("Expanding GPT may cause data loss!"));
+		gpt->ents = realloc(gpt->ents, esz);
+		memset(gpt->ents + old, 0, (new - old) * le32_to_cpu(gpt->pheader->sizeof_partition_entry));
+	}
+	/* usable LBA addresses will have changed */
+	cxt->last_lba = cxt->total_sectors - 2 - (esz / cxt->sector_size);
+	cxt->first_lba = (esz / cxt->sector_size) + 2;
+	gpt->pheader->first_usable_lba = cpu_to_le32(cxt->first_lba);
+	gpt->bheader->first_usable_lba = cpu_to_le32(cxt->first_lba);
+	gpt->pheader->last_usable_lba = cpu_to_le32(cxt->last_lba);
+	gpt->bheader->last_usable_lba = cpu_to_le32(cxt->last_lba);
+
+
+	/* The backup header must be recalculated */
+	gpt_mknew_header_common(cxt, gpt->bheader, le64_to_cpu(gpt->pheader->alternative_lba));
+
+	/* CRCs will have changed */
+	gpt_recompute_crc(gpt->pheader, gpt->ents);
+	gpt_recompute_crc(gpt->bheader, gpt->ents);
+
+	fdisk_info(cxt, _("Partition table length changed from %u to %u."), old, new);
+
+	fdisk_label_set_changed(cxt->label, 1);
+	return 0;
+}
+
 static int gpt_part_is_used(struct fdisk_context *cxt, size_t i)
 {
 	struct fdisk_gpt_label *gpt;
@@ -2750,6 +2813,8 @@ static const struct fdisk_label_operations gpt_operations =
 	.locate		= gpt_locate_disklabel,
 	.get_item	= gpt_get_disklabel_item,
 	.set_id		= gpt_set_disklabel_id,
+	.get_length	= gpt_get_disklabel_length,
+	.set_length	= gpt_set_disklabel_length,
 
 	.get_part	= gpt_get_partition,
 	.set_part	= gpt_set_partition,
diff --git a/libfdisk/src/label.c b/libfdisk/src/label.c
index ee5ee3e..ec2e5c5 100644
--- a/libfdisk/src/label.c
+++ b/libfdisk/src/label.c
@@ -523,6 +523,40 @@ int fdisk_set_disklabel_id(struct fdisk_context *cxt)
 }
 
 /**
+ * fdisk_get_disklabel_length:
+ * @cxt: fdisk context
+ *
+ * Returns: 0 on success, otherwise, a corresponding error.
+ */
+unsigned long fdisk_get_disklabel_length(struct fdisk_context *cxt)
+{
+	if (!cxt || !cxt->label)
+		return -EINVAL;
+	if (!cxt->label->op->get_length)
+		return -ENOSYS;
+
+	DBG(CXT, ul_debugobj(cxt, "getting %s table length", cxt->label->name));
+	return cxt->label->op->get_length(cxt);
+}
+
+/**
+ * fdisk_set_disklabel_length:
+ * @cxt: fdisk context
+ *
+ * Returns: 0 on success, otherwise, a corresponding error.
+ */
+int fdisk_set_disklabel_length(struct fdisk_context *cxt, unsigned long entries)
+{
+	if (!cxt || !cxt->label)
+		return -EINVAL;
+	if (!cxt->label->op->set_length)
+		return -ENOSYS;
+
+	DBG(CXT, ul_debugobj(cxt, "setting %s label length", cxt->label->name));
+	return cxt->label->op->set_length(cxt, entries);
+}
+
+/**
  * fdisk_set_partition_type:
  * @cxt: fdisk context
  * @partnum: partition number
diff --git a/libfdisk/src/libfdisk.h.in b/libfdisk/src/libfdisk.h.in
index 6bd3a1e..71405a2 100644
--- a/libfdisk/src/libfdisk.h.in
+++ b/libfdisk/src/libfdisk.h.in
@@ -320,6 +320,8 @@ enum fdisk_labelitem_gen {
 extern int fdisk_get_disklabel_item(struct fdisk_context *cxt, int id, struct fdisk_labelitem *item);
 extern int fdisk_get_disklabel_id(struct fdisk_context *cxt, char **id);
 extern int fdisk_set_disklabel_id(struct fdisk_context *cxt);
+extern int fdisk_set_disklabel_length(struct fdisk_context *cxt, unsigned long entries);
+extern unsigned long fdisk_get_disklabel_length(struct fdisk_context *cxt);
 
 extern int fdisk_get_partition(struct fdisk_context *cxt, size_t partno, struct fdisk_partition **pa);
 extern int fdisk_set_partition(struct fdisk_context *cxt, size_t partno, struct fdisk_partition *pa);
diff --git a/libfdisk/src/libfdisk.sym b/libfdisk/src/libfdisk.sym
index c5aeac6..6ecec44 100644
--- a/libfdisk/src/libfdisk.sym
+++ b/libfdisk/src/libfdisk.sym
@@ -64,6 +64,7 @@ global:
 	fdisk_get_devfd;
 	fdisk_get_devname;
 	fdisk_get_disklabel_id;
+	fdisk_get_disklabel_length;
 	fdisk_get_first_lba;
 	fdisk_get_freespaces;
 	fdisk_get_geom_cylinders;
@@ -202,6 +203,7 @@ global:
 	fdisk_script_write_file;
 	fdisk_set_ask;
 	fdisk_set_disklabel_id;
+	fdisk_set_disklabel_length;
 	fdisk_set_first_lba;
 	fdisk_set_last_lba;
 	fdisk_set_partition;
-- 
2.1.0

