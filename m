Return-Path: util-linux-owner@vger.kernel.org
Received: from mailbigip.dreamhost.com ([208.97.132.5]:57663 "EHLO
	homiemail-a7.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759359Ab2J0RX5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 27 Oct 2012 13:23:57 -0400
Message-ID: <1351358627.2842.3.camel@offbook>
Subject: [PATCH v2 2/2] gpt: create empty disklabels
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Date: Sat, 27 Oct 2012 19:23:47 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch enables creating a new, empty, GPT disklabel from either
an empty disk or one that already has a disklabel. For this
purpose, a 'g' option is added to the main menu and is visible to all
labels. Here's an example for a scsi_debug device (/dev/sdb):

...
Device does not contain a recognized partition table
Building a new DOS disklabel with disk identifier 0x20a614c8.
3696: fdisk:  CONTEXT: zeroize in-memory first sector buffer

Command (m for help): g
3696: fdisk:    LABEL: changing to gpt label

3696: fdisk:  CONTEXT: zeroize in-memory first sector buffer
3696: fdisk:    LABEL: created new empty GPT disklabel (GUID: D4EA0706-F011-46DC-B7DE-6A72C7090AF8)

Command (m for help): w
The partition table has been altered!
...

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/fdisk.c |    4 ++
 fdisks/gpt.c   |  202 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 200 insertions(+), 6 deletions(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index e271ea1..a3ac087 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -90,6 +90,7 @@ static const struct menulist_descr menulist[] = {
 	{'e', N_("edit drive data"), {OSF_LABEL, 0}},
 	{'f', N_("fix partition order"), {0, DOS_LABEL}},
 	{'g', N_("create an IRIX (SGI) partition table"), {0, ANY_LABEL}},
+	{'g', N_("create a new empty GPT partition table"), {ANY_LABEL, 0}},
 	{'h', N_("change number of heads"), {0, DOS_LABEL | SUN_LABEL}},
 	{'i', N_("change interleave factor"), {0, SUN_LABEL}},
 	{'i', N_("change the disk identifier"), {0, DOS_LABEL}},
@@ -1694,6 +1695,9 @@ static void command_prompt(struct fdisk_context *cxt)
 		case 'd':
 			delete_partition(cxt, get_existing_partition(cxt, 1, partitions));
 			break;
+		case 'g':
+			fdisk_create_disklabel(cxt, "gpt");
+			break;
 		case 'i':
 			if (disklabel == SGI_LABEL)
 				create_sgiinfo(cxt);
diff --git a/fdisks/gpt.c b/fdisks/gpt.c
index 48397f3..843dc44 100644
--- a/fdisks/gpt.c
+++ b/fdisks/gpt.c
@@ -19,7 +19,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
- *
  */
 
 #include <stdio.h>
@@ -59,7 +58,8 @@
 
 #define EFI_PMBR_OSTYPE     0xEE
 #define MSDOS_MBR_SIGNATURE 0xAA55
-#define GPT_PART_NAME_LEN 72 / sizeof(uint16_t)
+#define GPT_PART_NAME_LEN   72 / sizeof(uint16_t)
+#define GPT_NPARTITIONS     128
 
 /* Globally unique identifier */
 struct gpt_guid {
@@ -96,8 +96,8 @@ struct gpt_attr {
 
 /* The GPT Partition entry array contains an array of GPT entries. */
 struct gpt_entry {
-	struct gpt_guid   partition_type_guid; /* purpose and type of the partition */
-	struct gpt_guid   unique_partition_guid;
+	struct gpt_guid     partition_type_guid; /* purpose and type of the partition */
+	struct gpt_guid     unique_partition_guid;
 	uint64_t            lba_start;
 	uint64_t            lba_end;
 	struct gpt_attr     attr;
@@ -115,7 +115,7 @@ struct gpt_header {
 	uint64_t            alternative_lba; /* backup GPT header */
 	uint64_t            first_usable_lba; /* first usable logical block for partitions */
 	uint64_t            last_usable_lba; /* last usable logical block for partitions */
-	struct gpt_guid   disk_guid; /* unique disk identifier */
+	struct gpt_guid     disk_guid; /* unique disk identifier */
 	uint64_t            partition_entry_lba; /* stat LBA of the partition entry array */
 	uint32_t            npartition_entries; /* total partition entries - normally 128 */
 	uint32_t            sizeof_partition_entry; /* bytes for each GUID pt */
@@ -298,6 +298,125 @@ static inline int partition_unused(struct gpt_entry e)
 }
 
 /*
+ * Builds a clean new valid protective MBR - will wipe out any existing data.
+ * Returns 0 on success, otherwise < 0 on error.
+ */
+static int gpt_mknew_pmbr(struct fdisk_context *cxt)
+{
+	struct gpt_legacy_mbr *pmbr = NULL;
+
+	if (!cxt || !cxt->firstsector)
+		return -ENOSYS;
+
+	fdisk_zeroize_firstsector(cxt);
+
+	pmbr = (struct gpt_legacy_mbr *) cxt->firstsector;
+
+	pmbr->signature = cpu_to_le16(MSDOS_MBR_SIGNATURE);
+	pmbr->partition_record[0].os_type      = EFI_PMBR_OSTYPE;
+	pmbr->partition_record[0].start_sector = 1;
+	pmbr->partition_record[0].end_head     = 0xFE;
+	pmbr->partition_record[0].end_sector   = 0xFF;
+	pmbr->partition_record[0].end_track    = 0xFF;
+	pmbr->partition_record[0].starting_lba = cpu_to_le32(1);
+	pmbr->partition_record[0].size_in_lba  =
+		cpu_to_le32(min((uint32_t) cxt->total_sectors - 1, 0xFFFFFFFF));
+
+	return 0;
+}
+
+/* some universal differences between the headers */
+static void gpt_mknew_header_common(struct fdisk_context *cxt,
+				    struct gpt_header *header, uint64_t lba)
+{
+	if (!cxt || !header)
+		return;
+
+	header->my_lba = cpu_to_le64(lba);
+
+	if (lba == GPT_PRIMARY_PARTITION_TABLE_LBA) { /* primary */
+		header->alternative_lba = cpu_to_le64(cxt->total_sectors - 1);
+		header->partition_entry_lba = cpu_to_le64(2);
+	} else { /* backup */
+		uint64_t esz = le32_to_cpu(header->npartition_entries) * sizeof(struct gpt_entry);
+		uint64_t esects = (esz + cxt->sector_size - 1) / cxt->sector_size;
+
+		header->alternative_lba = cpu_to_le64(GPT_PRIMARY_PARTITION_TABLE_LBA);
+		header->partition_entry_lba = cpu_to_le64(cxt->total_sectors - 1 - esects);
+       	}
+}
+
+/*
+ * Builds a new GPT header (at sector lba) from a backup header2.
+ * If building a primary header, then backup is the secondary, and vice versa.
+ *
+ * Always pass a new (zeroized) header to build upon as we don't
+ * explicitly zero-set some values such as CRCs and reserved.
+ *
+ * Returns 0 on success, otherwise < 0 on error.
+ */
+static int gpt_mknew_header_from_bkp(struct fdisk_context *cxt,
+				     struct gpt_header *header,
+				     uint64_t lba,
+				     struct gpt_header *header2)
+{
+	if (!cxt || !header || !header2)
+		return -ENOSYS;
+
+	header->signature              = header2->signature;
+	header->revision               = header2->revision;
+	header->size                   = header2->size;
+	header->npartition_entries     = header2->npartition_entries;
+	header->sizeof_partition_entry = header2->sizeof_partition_entry;
+	header->first_usable_lba       = header2->first_usable_lba;
+	header->last_usable_lba        = header2->last_usable_lba;
+
+	memcpy(&header->disk_guid,
+	       &header2->disk_guid, sizeof(header2->disk_guid));
+	gpt_mknew_header_common(cxt, header, lba);
+
+	return 0;
+}
+
+/*
+ * Builds a clean new GPT header (currently under revision 1.0).
+ *
+ * Always pass a new (zeroized) header to build upon as we don't
+ * explicitly zero-set some values such as CRCs and reserved.
+ *
+ * Returns 0 on success, otherwise < 0 on error.
+ */
+static int gpt_mknew_header(struct fdisk_context *cxt,
+			    struct gpt_header *header, uint64_t lba)
+{
+	uint64_t esz = 0;
+
+	if (!cxt || !header)
+		return -ENOSYS;
+
+	esz = sizeof(struct gpt_entry) * GPT_NPARTITIONS / cxt->sector_size;
+
+	header->signature = cpu_to_le64(GPT_HEADER_SIGNATURE);
+	header->revision  = cpu_to_le32(GPT_HEADER_REVISION_V1_00);
+	header->size      = cpu_to_le32(sizeof(struct gpt_header));
+
+	/*
+	 * 128 partitions is the default. It can go behond this, however,
+	 * we're creating a de facto header here, so no funny business.
+	 */
+	header->npartition_entries     = cpu_to_le32(GPT_NPARTITIONS);
+	header->sizeof_partition_entry = cpu_to_le32(sizeof(struct gpt_entry));
+	header->first_usable_lba       = cpu_to_le64(esz + 2);
+	header->last_usable_lba        = cpu_to_le64(cxt->total_sectors - 2 - esz);
+
+	gpt_mknew_header_common(cxt, header, lba);
+	uuid_generate_random((unsigned char *) &header->disk_guid);
+	swap_efi_guid(&header->disk_guid);
+
+	return 0;
+}
+
+/*
  * Checks if there is a valid protective MBR partition table.
  * Returns 0 if it is invalid or failure. Otherwise, return
  * GPT_MBR_PROTECTIVE or GPT_MBR_HYBRID, depeding on the detection.
@@ -850,6 +969,22 @@ static void gpt_init(void)
 	partitions = le32_to_cpu(pheader->npartition_entries);
 }
 
+/*
+ * Deinitialize fdisk-specific variables
+ */
+static void gpt_deinit(void)
+{
+	free(ents);
+	free(pheader);
+	free(bheader);
+	ents = NULL;
+	pheader = NULL;
+	bheader = NULL;
+
+	disklabel = ANY_LABEL;
+	partitions = 0;
+}
+
 static int gpt_probe_label(struct fdisk_context *cxt)
 {
 	int mbr_type;
@@ -899,6 +1034,7 @@ static char *encode_to_utf8(unsigned char *src, size_t count)
 	uint16_t c;
 	char *dest = xmalloc(count * sizeof(char));
 	size_t i, j, len = count;
+
 	memset(dest, 0, sizeof(char) * count);
 
 	for (j = i = 0; i + 2 <= count; i += 2) {
@@ -1363,6 +1499,60 @@ static void gpt_add_partition(struct fdisk_context *cxt, int partnum,
 		printf(_("Created partition %d\n"), partnum + 1);
 }
 
+/*
+ * Create a new GPT disklabel - destroys any previous data.
+ */
+static int gpt_create_disklabel(struct fdisk_context *cxt)
+{
+	int rc = 0;
+	ssize_t entry_sz = 0;
+
+	/*
+	 * Reset space or clear data from headers, pt entries and
+	 * protective MBR. Big fat warning: any previous content is
+	 * overwritten, so ask users to be sure!.
+	 *
+	 * When no header, entries or pmbr is set, we're probably
+	 * dealing with a new, empty disk - so always allocate memory
+	 * to deal with the data structures whatever the case is.
+	 */
+	gpt_deinit();
+
+	rc = gpt_mknew_pmbr(cxt);
+	if (rc < 0)
+		goto done;
+
+	pheader = xcalloc(1, sizeof(*pheader));
+       	rc = gpt_mknew_header(cxt, pheader, GPT_PRIMARY_PARTITION_TABLE_LBA);
+	if (rc < 0)
+		goto done;
+
+	bheader = xcalloc(1, sizeof(*bheader));
+	rc = gpt_mknew_header_from_bkp(cxt, bheader, last_lba(cxt), pheader);
+	if (rc < 0)
+		goto done;
+
+	entry_sz = le32_to_cpu(pheader->npartition_entries) *
+		le32_to_cpu(pheader->sizeof_partition_entry);
+	ents = xcalloc(1, sizeof(*ents) * entry_sz);
+
+	gpt_recompute_crc(pheader, ents);
+	gpt_recompute_crc(bheader, ents);
+
+	gpt_init();
+	DBG(LABEL, dbgprint("created new empty GPT disklabel "
+			    "(GUID: %08X-%04X-%04X-%02X%02X-%02X%02X%02X%02X%02X%02X)",
+			    pheader->disk_guid.time_low, pheader->disk_guid.time_mid,
+			    pheader->disk_guid.time_hi_and_version,
+			    pheader->disk_guid.clock_seq_hi,
+			    pheader->disk_guid.clock_seq_low,
+			    pheader->disk_guid.node[0], pheader->disk_guid.node[1],
+			    pheader->disk_guid.node[2], pheader->disk_guid.node[3],
+			    pheader->disk_guid.node[4], pheader->disk_guid.node[5]));
+done:
+	return rc;
+}
+
 static struct fdisk_parttype *gpt_get_partition_type(struct fdisk_context *cxt,
 						     int i)
 {
@@ -1409,7 +1599,7 @@ const struct fdisk_label gpt_label =
 	.probe = gpt_probe_label,
 	.write = gpt_write_disklabel,
 	.verify = gpt_verify_disklabel,
-	.create = NULL,
+	.create = gpt_create_disklabel,
 	.part_add = gpt_add_partition,
 	.part_delete = gpt_delete_partition,
 	.part_get_type = gpt_get_partition_type,
-- 
1.7.9.5




