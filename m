Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:57744 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751345AbaJATfW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 1 Oct 2014 15:35:22 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] textual: grammarize an informative message, and tweak some comments
Date: Wed,  1 Oct 2014 21:35:17 +0200
Message-Id: <1412192117-2789-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also add two clarifying comments for translators.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 libfdisk/src/gpt.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index 082dcad..dfedb0b 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -99,16 +99,16 @@ struct gpt_header {
 	uint32_t            size; /* in bytes */
 	uint32_t            crc32; /* header CRC checksum */
 	uint32_t            reserved1; /* must be 0 */
-	uint64_t            my_lba; /* LBA that contains this struct (LBA 1) */
+	uint64_t            my_lba; /* LBA of block that contains this struct (LBA 1) */
 	uint64_t            alternative_lba; /* backup GPT header */
 	uint64_t            first_usable_lba; /* first usable logical block for partitions */
 	uint64_t            last_usable_lba; /* last usable logical block for partitions */
 	struct gpt_guid     disk_guid; /* unique disk identifier */
-	uint64_t            partition_entry_lba; /* stat LBA of the partition entry array */
+	uint64_t            partition_entry_lba; /* LBA of start of partition entries array */
 	uint32_t            npartition_entries; /* total partition entries - normally 128 */
 	uint32_t            sizeof_partition_entry; /* bytes for each GUID pt */
 	uint32_t            partition_entry_array_crc32; /* partition CRC checksum */
-	uint8_t             reserved2[512 - 92]; /* must be 0 */
+	uint8_t             reserved2[512 - 92]; /* must all be 0 */
 } __attribute__ ((packed));
 
 struct gpt_record {
@@ -1401,8 +1401,10 @@ static int gpt_list_disklabel(struct fdisk_context *cxt)
 
 		fdisk_info(cxt, _("First LBA: %ju"), h->first_usable_lba);
 		fdisk_info(cxt, _("Last LBA: %ju"), h->last_usable_lba);
+		/* TRANSLATORS: The LBA (Logical Block Address) of the backup GPT header. */
 		fdisk_info(cxt, _("Alternative LBA: %ju"), h->alternative_lba);
-		fdisk_info(cxt, _("Partitions entries LBA: %ju"), h->partition_entry_lba);
+		/* TRANSLATORS: The start of the array of partition entries. */
+		fdisk_info(cxt, _("Partition entries LBA: %ju"), h->partition_entry_lba);
 		fdisk_info(cxt, _("Allocated partition entries: %u"), h->npartition_entries);
 	}
 
-- 
1.7.0.4

