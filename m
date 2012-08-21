Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdccac.dreamhost.com ([208.97.132.202]:58679 "EHLO
	homiemail-a6.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757121Ab2HUMD2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 21 Aug 2012 08:03:28 -0400
Subject: [PATCH 2/3] fdisk: add GPT support
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 21 Aug 2012 14:03:22 +0200
Message-ID: <1345550602.2664.6.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

This patch allows fdisk to handle GUID partition tables, based on the latest UEFI specifications
version 2.3.1, from June 27th, 2012. The following operations are supported:

  - Probing (detects both protective and hybrid MBRs)
  - Writing to disk
  - Listing used partitions
  - Adding partitions
  - Deleting partitions
  - Data integrity verifications (for both headers and partitions).

A few considerations:
  - Currently we do not fix invalid primary headers -- we just abort!
  - Header checksums are updated upon every change (ie: add/delete partitions), this allows us
    to mathematically verify the changes on-the-fly, and not only when writing to disk, like
    most other related tools do.
  - We are extremly picky when writing to disk, any error aborts the opeartion.
  - When creating a new partition, the following GUIDs are available:
     http://en.wikipedia.org/wiki/GUID_Partition_Table#Partition_type_GUIDs

For test cases, the gpt.img from libblkid tests, scsi_debug and my own hard drive (/dev/sda) were used.
For the image, all operations were tested successfully, and for /dev/sda all except write, which
was not tested - hey, I'm not suicidal!

Tested-and-reviewed-by: Petr Uzel <petr.uzel@suse.cz>
Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
Note that when adding libblkid support for probing, some of the local probing functions will go.

 fdisks/Makemodule.am |   12 +-
 fdisks/cfdisk.c      |    8 -
 fdisks/fdisk.c       |   41 +-
 fdisks/fdisk.h       |    3 +
 fdisks/gpt.c         | 1451 +++++++++++++++++++++++++++++++++++++++++++++-----
 fdisks/gpt.h         |    4 +-
 fdisks/sfdisk.c      |   25 -
 fdisks/utils.c       |    1 +
 8 files changed, 1343 insertions(+), 202 deletions(-)

diff --git a/fdisks/Makemodule.am b/fdisks/Makemodule.am
index f586769..97f5d48 100644
--- a/fdisks/Makemodule.am
+++ b/fdisks/Makemodule.am
@@ -1,8 +1,6 @@
 
 fdisk_common_sources = \
 	fdisks/common.h \
-	fdisks/gpt.c \
-	fdisks/gpt.h \
 	fdisks/i386_sys_types.c
 
 if !ARCH_M68K
@@ -25,16 +23,24 @@ fdisk_SOURCES = \
 	fdisks/fdisksunlabel.h \
 	fdisks/fdiskdoslabel.c \
 	fdisks/fdiskdoslabel.h \
+	fdisks/gpt.c \
+	fdisks/gpt.h \
 	fdisks/partname.c \
 	$(fdisk_common_sources)
 
 fdisk_LDADD = $(LDADD) libcommon.la
+fdisk_CFLAGS = $(AM_CFLAGS)
 
 if BUILD_LIBBLKID
-fdisk_CFLAGS = -I$(ul_libblkid_incdir)
+fdisk_CFLAGS += -I$(ul_libblkid_incdir)
 fdisk_LDADD += libblkid.la
 endif
 
+if BUILD_LIBUUID
+fdisk_CFLAGS += -I$(ul_libuuid_incdir)
+fdisk_LDADD += libuuid.la
+endif
+
 if HAVE_STATIC_FDISK
 sbin_PROGRAMS += fdisk.static
 fdisk_static_SOURCES = $(fdisk_SOURCES)
diff --git a/fdisks/cfdisk.c b/fdisks/cfdisk.c
index 3efa42c..704e0f6 100644
--- a/fdisks/cfdisk.c
+++ b/fdisks/cfdisk.c
@@ -103,7 +103,6 @@
 #include "blkdev.h"
 #include "strutils.h"
 #include "common.h"
-#include "gpt.h"
 #include "mbsalign.h"
 #include "widechar.h"
 
@@ -1501,13 +1500,6 @@ fill_p_info(void) {
 	 opentype = O_RDWR;
     opened = TRUE;
 
-    if (gpt_probe_signature_fd(fd)) {
-	 print_warning(_("Warning!!  Unsupported GPT (GUID Partition Table) detected. Use GNU Parted."));
-	 refresh();
-	 getch();
-	 clear_warning();
-    }
-
 #ifdef BLKFLSBUF
     /* Blocks are visible in more than one way:
        e.g. as block on /dev/hda and as block on /dev/hda3
diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 3a16c5f..901861d 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -83,7 +83,7 @@ static const struct menulist_descr menulist[] = {
 	{'c', N_("toggle the mountable flag"), {SUN_LABEL, 0}},
 	{'c', N_("select sgi swap partition"), {SGI_LABEL, 0}},
 	{'c', N_("change number of cylinders"), {0, DOS_LABEL | SUN_LABEL}},
-	{'d', N_("delete a partition"), {DOS_LABEL | SUN_LABEL | SGI_LABEL | OSF_LABEL, 0}},
+	{'d', N_("delete a partition"), {DOS_LABEL | SUN_LABEL | SGI_LABEL | OSF_LABEL | GPT_LABEL, 0}},
 	{'d', N_("print the raw data in the partition table"), {0, ANY_LABEL}},
 	{'e', N_("change number of extra sectors per cylinder"), {0, SUN_LABEL}},
 	{'e', N_("list extended partitions"), {0, DOS_LABEL}},
@@ -94,9 +94,9 @@ static const struct menulist_descr menulist[] = {
 	{'i', N_("change interleave factor"), {0, SUN_LABEL}},
 	{'i', N_("change the disk identifier"), {0, DOS_LABEL}},
 	{'i', N_("install bootstrap"), {OSF_LABEL, 0}},
-	{'l', N_("list known partition types"), {DOS_LABEL | SUN_LABEL | SGI_LABEL | OSF_LABEL, 0}},
+	{'l', N_("list known partition types"), {DOS_LABEL | SUN_LABEL | SGI_LABEL | OSF_LABEL  | GPT_LABEL, 0}},
 	{'m', N_("print this menu"), {ANY_LABEL, ANY_LABEL}},
-	{'n', N_("add a new partition"), {DOS_LABEL | SUN_LABEL | SGI_LABEL | OSF_LABEL, 0}},
+	{'n', N_("add a new partition"), {DOS_LABEL | SUN_LABEL | SGI_LABEL | OSF_LABEL | GPT_LABEL, 0}},
 	{'o', N_("create a new empty DOS partition table"), {~OSF_LABEL, 0}},
 	{'o', N_("change rotation speed (rpm)"), {0, SUN_LABEL}},
 	{'p', N_("print the partition table"), {DOS_LABEL | SUN_LABEL | SGI_LABEL | OSF_LABEL, DOS_LABEL | SUN_LABEL}},
@@ -108,7 +108,7 @@ static const struct menulist_descr menulist[] = {
 	{'t', N_("change a partition's system id"), {DOS_LABEL | SUN_LABEL | SGI_LABEL | OSF_LABEL, 0}},
 	{'u', N_("change display/entry units"), {DOS_LABEL | SUN_LABEL | SGI_LABEL | OSF_LABEL, 0}},
 	{'v', N_("verify the partition table"), {DOS_LABEL | SUN_LABEL | SGI_LABEL, DOS_LABEL | SUN_LABEL | SGI_LABEL}},
-	{'w', N_("write table to disk and exit"), {DOS_LABEL | SUN_LABEL | SGI_LABEL, DOS_LABEL | SUN_LABEL | SGI_LABEL}},
+	{'w', N_("write table to disk and exit"), {DOS_LABEL | SUN_LABEL | SGI_LABEL  | GPT_LABEL, DOS_LABEL | SUN_LABEL | SGI_LABEL}},
 	{'w', N_("write disklabel to disk"), {OSF_LABEL, 0}},
 	{'x', N_("extra functionality (experts only)"), {DOS_LABEL | SUN_LABEL | SGI_LABEL, 0}},
 #if !defined (__alpha__)
@@ -226,11 +226,11 @@ get_sysid(struct fdisk_context *cxt, int i) {
 		ptes[i].part_table->sys_ind);
 }
 
-static struct systypes *
-get_sys_types(void) {
+struct systypes *get_sys_types(void) {
 	return (
 		disklabel == SUN_LABEL ? sun_sys_types :
 		disklabel == SGI_LABEL ? sgi_sys_types :
+		disklabel == GPT_LABEL ? gpt_sys_types :
 		i386_sys_types);
 }
 
@@ -259,11 +259,11 @@ void list_types(struct systypes *sys)
 	i = done = 0;
 
 	do {
-		#define NAME_WIDTH 15
+		#define NAME_WIDTH 25
 		char name[NAME_WIDTH * MB_LEN_MAX];
 		size_t width = NAME_WIDTH;
 
-		printf("%c%2x  ", i ? ' ' : '\n', sys[next].type);
+		printf("%c%10x  ", i ? ' ' : '\n', sys[next].type);
 		size_t ret = mbsalign(_(sys[next].name), name, sizeof(name),
 				      &width, MBS_ALIGN_LEFT, 0);
 		if (ret == (size_t)-1 || ret >= sizeof(name))
@@ -736,7 +736,7 @@ get_partition_dflt(struct fdisk_context *cxt, int warn, int max, int dflt) {
 	i = read_int(cxt, 1, dflt, max, 0, _("Partition number")) - 1;
 	pe = &ptes[i];
 
-	if (warn) {
+	if (warn && disklabel != GPT_LABEL) {
 		if ((disklabel != SUN_LABEL && disklabel != SGI_LABEL && !pe->part_table->sys_ind)
 		    || (disklabel == SUN_LABEL &&
 			(!sunlabel->partitions[i].num_sectors ||
@@ -1158,8 +1158,8 @@ fix_partition_table_order(void) {
 
 }
 
-static void
-list_table(struct fdisk_context *cxt, int xtra) {
+static void list_table(struct fdisk_context *cxt, int xtra)
+{
 	struct partition *p;
 	char *type;
 	int i, w;
@@ -1176,6 +1176,11 @@ list_table(struct fdisk_context *cxt, int xtra) {
 
 	list_disk_geometry(cxt);
 
+	if (disklabel == GPT_LABEL) {
+		gpt_list_table(cxt, xtra);
+		return;
+	}
+
 	if (disklabel == OSF_LABEL) {
 		xbsd_print_disklabel(cxt, xtra);
 		return;
@@ -1336,7 +1341,8 @@ static void new_partition(struct fdisk_context *cxt)
 	if (warn_geometry(cxt))
 		return;
 
-	if (disklabel == SUN_LABEL || disklabel == SGI_LABEL)
+	if (disklabel == SUN_LABEL || disklabel == SGI_LABEL
+		|| disklabel == GPT_LABEL)
 		partnum = get_partition(cxt, 0, partitions);
 
 	/*
@@ -1592,14 +1598,6 @@ static int is_ide_cdrom_or_tape(char *device)
 	return ret;
 }
 
-static void
-gpt_warning(char *dev)
-{
-	if (dev && gpt_probe_signature_devname(dev))
-		fprintf(stderr, _("\nWARNING: GPT (GUID Partition Table) detected on '%s'! "
-			"The util fdisk doesn't support GPT. Use GNU Parted.\n\n"), dev);
-}
-
 /* Print disk geometry and partition table of a specified device (-l option) */
 static void print_partition_table_from_option(char *device, unsigned long sector_size)
 {
@@ -1615,7 +1613,6 @@ static void print_partition_table_from_option(char *device, unsigned long sector
 	if (user_cylinders || user_heads || user_sectors)
 		fdisk_context_set_user_geometry(cxt, user_cylinders,
 					user_heads, user_sectors);
-	gpt_warning(device);
 
 	if (!fdisk_dev_has_disklabel(cxt)) {
 		/*
@@ -1921,8 +1918,6 @@ int main(int argc, char **argv)
 		printf(_("Note: sector size is %ld (not %d)\n"),
 		       cxt->sector_size, DEFAULT_SECTOR_SIZE);
 
-	gpt_warning(cxt->dev_path);
-
 	if (!fdisk_dev_has_disklabel(cxt)) {
 		fprintf(stderr,
 			_("Device does not contain a recognized partition table\n"));
diff --git a/fdisks/fdisk.h b/fdisks/fdisk.h
index 05dc8a8..b17d492 100644
--- a/fdisks/fdisk.h
+++ b/fdisks/fdisk.h
@@ -160,6 +160,7 @@ extern const struct fdisk_label bsd_label;
 extern const struct fdisk_label mac_label;
 extern const struct fdisk_label sun_label;
 extern const struct fdisk_label sgi_label;
+extern const struct fdisk_label gpt_label;
 
 extern struct fdisk_context *fdisk_new_context_from_filename(const char *fname, int readonly);
 extern int fdisk_dev_has_topology(struct fdisk_context *cxt);
@@ -217,6 +218,7 @@ extern unsigned int read_int_with_suffix(struct fdisk_context *cxt,
 extern sector_t align_lba(struct fdisk_context *cxt, sector_t lba, int direction);
 extern int get_partition_dflt(struct fdisk_context *cxt, int warn, int max, int dflt);
 extern void update_sector_offset(struct fdisk_context *cxt);
+extern struct systypes *get_sys_types(void);
 
 #define PLURAL	0
 #define SINGULAR 1
@@ -234,6 +236,7 @@ enum fdisk_labeltype {
 	AIX_LABEL = 8,
 	OSF_LABEL = 16,
 	MAC_LABEL = 32,
+	GPT_LABEL = 64,
 	ANY_LABEL = -1
 };
 
diff --git a/fdisks/gpt.c b/fdisks/gpt.c
index bb6911a..4897736 100644
--- a/fdisks/gpt.c
+++ b/fdisks/gpt.c
@@ -1,4 +1,10 @@
 /*
+ * Copyright (C) 2007 Karel Zak <kzak@redhat.com>
+ * Copyright (C) 2012 Davidlohr Bueso <dave@gnu.org>
+ *
+ * GUID Partition Table (GPT) support. Based on UEFI Specs 2.3.1
+ * Chapter 5: GUID Partition Table (GPT) Disk Layout (Jun 27th, 2012).
+ * Some ideas and inspiration from GNU parted and gptfdisk.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -14,15 +20,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
  *
- *
- * GPT (GUID Partition Table) signature detection. Based on libparted and
- * util-linux/partx.
- *
- * Warning: this code doesn't do all GPT checks (CRC32, Protective MBR, ..).
- *          It's really GPT signature detection only.
- *
- * Copyright (C) 2007 Karel Zak <kzak@redhat.com>
- *
  */
 
 #include <stdio.h>
@@ -35,182 +32,1354 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <errno.h>
+#include <ctype.h>
+#include <uuid.h>
 
+#include "nls.h"
+#include "xalloc.h"
+#include "common.h"
+#include "fdisk.h"
+#include "crc32.h"
 #include "gpt.h"
 #include "blkdev.h"
 #include "bitops.h"
-#include "closestream.h"
-
-#define GPT_HEADER_SIGNATURE 0x5452415020494645LL
-#define GPT_PRIMARY_PARTITION_TABLE_LBA 1
-
-typedef struct {
-        uint32_t time_low;
-        uint16_t time_mid;
-        uint16_t time_hi_and_version;
-        uint8_t  clock_seq_hi_and_reserved;
-        uint8_t  clock_seq_low;
-        uint8_t  node[6];
-} /* __attribute__ ((packed)) */ efi_guid_t;
-/* commented out "__attribute__ ((packed))" to work around gcc bug (fixed
- * in gcc3.1): __attribute__ ((packed)) breaks addressing on initialized
- * data.  It turns out we don't need it in this case, so it doesn't break
- * anything :)
- */
-
-typedef struct _GuidPartitionTableHeader_t {
-	uint64_t Signature;
-	uint32_t Revision;
-	uint32_t HeaderSize;
-	uint32_t HeaderCRC32;
-	uint32_t Reserved1;
-	uint64_t MyLBA;
-	uint64_t AlternateLBA;
-	uint64_t FirstUsableLBA;
-	uint64_t LastUsableLBA;
-	efi_guid_t DiskGUID;
-	uint64_t PartitionEntryLBA;
-	uint32_t NumberOfPartitionEntries;
-	uint32_t SizeOfPartitionEntry;
-	uint32_t PartitionEntryArrayCRC32;
-	uint8_t Reserved2[512 - 92];
-} __attribute__ ((packed)) GuidPartitionTableHeader_t;
-
-static int
-_get_sector_size (int fd)
-{
-	int sector_size;
-
-	if (blkdev_get_sector_size(fd, &sector_size) == -1)
-		return DEFAULT_SECTOR_SIZE;
-	return sector_size;
-}
-
-static uint64_t
-_get_num_sectors(int fd)
-{
-	unsigned long long bytes=0;
-
-	if (blkdev_get_size(fd, &bytes) == -1)
-		return 0;
-	return bytes / _get_sector_size(fd);
+#include "strutils.h"
+
+#define GPT_HEADER_SIGNATURE 0x5452415020494645LL /* EFI PART */
+#define GPT_HEADER_REVISION_V1_02 0x00010200
+#define GPT_HEADER_REVISION_V1_00 0x00010000
+#define GPT_HEADER_REVISION_V0_99 0x00009900
+
+#define GPT_PMBR_LBA        0
+#define GPT_MBR_PROTECTIVE  1
+#define GPT_MBR_HYBRID      2
+
+#define GPT_PRIMARY_PARTITION_TABLE_LBA 0x00000001
+
+#define EFI_PMBR_OSTYPE     0xEE
+#define MSDOS_MBR_SIGNATURE 0xAA55
+#define GPT_PART_NAME_LEN 72 / sizeof(uint16_t)
+
+/* only checking that the GUID is 0 is enough to verify an empty partition. */
+#define GPT_UNUSED_ENTRY_GUID						\
+	((struct fdisk_guid) { 0x00000000, 0x0000, 0x0000, 0x00, 0x00,	\
+			     { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 }})
+
+/*
+ * Attribute bits
+ */
+struct gpt_attr {
+	uint64_t            required_to_function:1;
+	uint64_t            no_blockio_protocol:1;
+	uint64_t            legacy_bios_bootable:1;
+	uint64_t            reserved:45;
+	uint64_t            guid_secific:16;
+}  __attribute__ ((packed));
+
+/* The GPT Partition entry array contains an array of GPT entries. */
+struct gpt_entry {
+	struct fdisk_guid   partition_type_guid; /* purpose and type of the partition */
+	struct fdisk_guid   unique_partition_guid;
+	uint64_t            lba_start;
+	uint64_t            lba_end;
+	struct gpt_attr     attr;
+	uint16_t            partition_name[GPT_PART_NAME_LEN];
+}  __attribute__ ((packed));
+
+/* GPT header */
+struct gpt_header {
+	uint64_t            signature; /* header identification */
+	uint32_t            revision; /* header version */
+	uint32_t            size; /* in bytes */
+	uint32_t            crc32; /* header CRC checksum */
+	uint32_t            reserved1; /* must be 0 */
+	uint64_t            my_lba; /* LBA that contains this struct (LBA 1) */
+	uint64_t            alternative_lba; /* backup GPT header */
+	uint64_t            first_usable_lba; /* first usable logical block for partitions */
+	uint64_t            last_usable_lba; /* last usable logical block for partitions */
+	struct fdisk_guid   disk_guid; /* unique disk identifier */
+	uint64_t            partition_entry_lba; /* stat LBA of the partition entry array */
+	uint32_t            npartition_entries; /* total partition entries - normally 128 */
+	uint32_t            sizeof_partition_entry; /* bytes for each GUID pt */
+	uint32_t            partition_entry_array_crc32; /* partition CRC checksum */
+	uint8_t             reserved2[512 - 92]; /* must be 0 */
+} __attribute__ ((packed));
+
+struct gpt_record {
+	uint8_t             boot_indicator; /* unused by EFI, set to 0x80 for bootable */
+	uint8_t             start_head; /* unused by EFI, pt start in CHS */
+	uint8_t             start_sector; /* unused by EFI, pt start in CHS */
+	uint8_t             start_track;
+	uint8_t             os_type; /* EFI and legacy non-EFI OS types */
+	uint8_t             end_head; /* unused by EFI, pt end in CHS */
+	uint8_t             end_sector; /* unused by EFI, pt end in CHS */
+	uint8_t             end_track; /* unused by EFI, pt end in CHS */
+	uint32_t            starting_lba; /* used by EFI - start addr of the on disk pt */
+	uint32_t            size_in_lba; /* used by EFI - size of pt in LBA */
+} __attribute__ ((packed));
+
+/* Protected MBR and legacy MBR share same structure */
+struct gpt_legacy_mbr {
+	uint8_t             boot_code[440];
+	uint32_t            unique_mbr_signature;
+	uint16_t            unknown;
+	struct gpt_record   partition_record[4];
+	uint16_t            signature;
+} __attribute__ ((packed));
+
+/*
+ * Here be dragons!
+ * See: http://en.wikipedia.org/wiki/GUID_Partition_Table#Partition_type_GUIDs
+ */
+struct systypes gpt_sys_types[] = {
+	/* Generic OS */
+	{0xEF00, {0xC12A7328, 0xF81F, 0x11D2, 0xBA, 0x4B,
+		  { 0x00, 0xA0, 0xC9, 0x3E, 0xC9, 0x3B}}, N_("EFI System")},
+	{0xEF01, {0x024DEE41, 0x33E7, 0x11D3, 0x9D, 0x69,
+		  { 0x00, 0x08, 0xC7, 0x81, 0xF3, 0x9F}}, N_("MBR partition scheme")},
+	/* Hah!IdontneedEFI */
+	{0xEF02, {0x21686148, 0x6449, 0x6E6F, 0x74, 0x4E,
+		  { 0x65, 0x65, 0x64, 0x45, 0x46, 0x49}}, N_("BIOS boot partition")},
+
+	/* Windows */
+	{0x0C01, {0xE3C9E316, 0x0B5C, 0x4DB8, 0x81, 0x7D,
+		  { 0xF9, 0x2D, 0xF0, 0x02, 0x15, 0xAE}}, N_("Microsoft reserved")},
+	{0x0100, {0xEBD0A0A2, 0xB9E5, 0x4433, 0x87, 0xC0,
+		  { 0x68, 0xB6, 0xB7, 0x26, 0x99, 0xC7}}, N_("Microsoft basic data")},
+	{0x4201, {0x5808C8AA, 0x7E8F, 0x42E0, 0x85, 0xD2,
+		  { 0xE1, 0xE9, 0x04, 0x34, 0xCF, 0xB3}}, N_("Microsoft LDM metadata")},
+	{0x4200, {0xAF9B60A0, 0x1431, 0x4F62, 0xBC, 0x68,
+		  { 0x33, 0x11, 0x71, 0x4A, 0x69, 0xAD}}, N_("Microsoft LDM data")},
+	{0x2700, {0xDE94BBA4, 0x06D1, 0x4D40, 0xA1, 0x6A,
+		  { 0xBF, 0xD5, 0x01, 0x79, 0xD6, 0xAC}}, N_("Windows recovery evironmnet")},
+	{0x7501, {0x37AFFC90, 0xEF7D, 0x4E96, 0x91, 0xC3,
+		  { 0x2D, 0x7A, 0xE0, 0x55, 0xB1, 0x74}}, N_("IBM General Parallel Fs")},
+
+	/* HP-UX */
+	{0xC001, {0x75894C1E, 0x3AEB, 0x11D3, 0xB7, 0xC1,
+		  { 0x7B, 0x03, 0xA0, 0x00, 0x00, 0x00}}, N_("HP-UX data partition")},
+	{0xC002, {0xE2A1E728, 0x32E3, 0x11D6, 0xA6, 0x82,
+		  { 0x7B, 0x03, 0xA0, 0x00, 0x00, 0x00}}, N_("HP-UX service partition")},
+
+	/* Linux */
+	/* because we all love Linux, this is the default partition */
+	{0x8300, {0x0FC63DAF, 0x8483, 0x4772, 0x8E, 0x79,
+		  { 0x3D, 0x69, 0xD8, 0x47, 0x7D, 0xE4}}, N_("Linux filesystem")},
+	{0xFD00, {0xA19D880F, 0x05FC, 0x4D3B, 0xA0, 0x06,
+		  { 0x74, 0x3F, 0x0F, 0x84, 0x91, 0x1E}}, N_("Linux RAID")},
+	{0x8200, {0x0657FD6D, 0xA4AB, 0x43C4, 0x84, 0xE5,
+		  { 0x09, 0x33, 0xC8, 0x4B, 0x4F, 0x4F}}, N_("Linux swap")},
+	{0x8E00, {0xE6D6D379, 0xF507, 0x44C2, 0xA2, 0x3C,
+		  { 0x23, 0x8F, 0x2A, 0x3D, 0xF9, 0x28}}, N_("Linux LVM")},
+	{0x8301, {0x8DA63339, 0x0007, 0x60C0, 0xC4, 0x36,
+		  { 0x08, 0x3A, 0xC8, 0x23, 0x09, 0x08}}, N_("Linux reserved")},
+
+	/* FreeBSD */
+	{0xA500, {0x516E7CB4, 0x6ECF, 0x11D6, 0x8F, 0xF8,
+		  { 0x00, 0x02, 0x2D, 0x09, 0x71, 0x2B}}, N_("FreeBSD data")},
+	{0xA501, {0x83BD6B9D, 0x7F41, 0x11DC, 0xBE, 0x0B,
+		  { 0x00, 0x15, 0x60, 0xB8, 0x4F, 0x0F}}, N_("FreeBSD boot")},
+	{0xA502, {0x516E7CB5, 0x6ECF, 0x11D6, 0x8F, 0xF8,
+		  { 0x00, 0x02, 0x2D, 0x09, 0x71, 0x2B}}, N_("FreeBSD swap")},
+	{0xA503, {0x516E7CB6, 0x6ECF, 0x11D6, 0x8F, 0xF8,
+		  { 0x00, 0x02, 0x2D, 0x09, 0x71, 0x2B}}, N_("FreeBSD UFS")},
+	{0xA504, {0x516E7CBA, 0x6ECF, 0x11D6, 0x8F, 0xF8,
+		  { 0x00, 0x02, 0x2D, 0x09, 0x71, 0x2B}}, N_("FreeBSD ZFS")},
+	{0xA505, {0x516E7CB8, 0x6ECF, 0x11D6, 0x8F, 0xF8,
+		  { 0x00, 0x02, 0x2D, 0x09, 0x71, 0x2B}}, N_("FreeBSD Vinum")},
+
+	/* Apple OSX */
+	{0xAF00, {0x48465300, 0x0000, 0x11AA, 0xAA, 0x11,
+		  { 0x00, 0x30, 0x65, 0x43, 0xEC, 0xAC}}, N_("Apple HFS/HFS+")},
+	{0xA800, {0x55465300, 0x0000, 0x11AA, 0xAA, 0x11,
+		  { 0x00, 0x30, 0x65, 0x43, 0xEC, 0xAC}}, N_("Apple UFS")},
+	{0xAF01, {0x52414944, 0x0000, 0x11AA, 0xAA, 0x11,
+		  { 0x00, 0x30, 0x65, 0x43, 0xEC, 0xAC}}, N_("Apple RAID")},
+	{0xAF02, {0x52414944, 0x5F4F, 0x11AA, 0xAA, 0x11,
+		  { 0x00, 0x30, 0x65, 0x43, 0xEC, 0xAC}}, N_("Apple RAID offline")},
+	{0xAB00, {0x426F6F74, 0x0000, 0x11AA, 0xAA, 0x11,
+		  { 0x00, 0x30, 0x65, 0x43, 0xEC, 0xAC}}, N_("Apple boot")},
+	{0xAF03, {0x4C616265, 0x6C00, 0x11AA, 0xAA, 0x11,
+		  { 0x00, 0x30, 0x65, 0x43, 0xEC, 0xAC}}, N_("Apple label")},
+	{0xAF04, {0x5265636F, 0x7665, 0x11AA, 0xAA, 0x11,
+		  { 0x00, 0x30, 0x65, 0x43, 0xEC, 0xAC}}, N_("Apple TV recovery")},
+	{0xAF05, {0x53746F72, 0x6167, 0x11AA, 0xAA, 0x11,
+		  { 0x00, 0x30, 0x65, 0x43, 0xEC, 0xAC}}, N_("Apple Core storage")},
+
+	/* Solaris */
+	{0xBE00, {0x6A82CB45, 0x1DD2, 0x11B2, 0x99, 0xA6,
+		  { 0x08, 0x00, 0x20, 0x73, 0x66, 0x31}}, N_("Solaris boot")},
+	{0xBF00, {0x6A85CF4D, 0x1DD2, 0x11B2, 0x99, 0xA6,
+		  { 0x08, 0x00, 0x20, 0x73, 0x66, 0x31}}, N_("Solaris root")},
+	/* same as Apple ZFS */
+	{0xBF01, {0x6A898CC3, 0x1DD2, 0x11B2, 0x99, 0xA6,
+		  { 0x08, 0x00, 0x20, 0x73, 0x66, 0x31}}, N_("Solaris /usr & Apple ZFS")},
+	{0xBF02, {0x6A87C46F, 0x1DD2, 0x11B2, 0x99, 0xA6,
+		  { 0x08, 0x00, 0x20, 0x73, 0x66, 0x31}}, N_("Solaris swap")},
+	{0xBF03, {0x6A8B642B, 0x1DD2, 0x11B2, 0x99, 0xA6,
+		  { 0x08, 0x00, 0x20, 0x73, 0x66, 0x31}}, N_("Solaris backup")},
+	{0xBF04, {0x6A8EF2E9, 0x1DD2, 0x11B2, 0x99, 0xA6,
+		  { 0x08, 0x00, 0x20, 0x73, 0x66, 0x31}}, N_("Solaris /var")},
+	{0xBF05, {0x6A90BA39, 0x1DD2, 0x11B2, 0x99, 0xA6,
+		  { 0x08, 0x00, 0x20, 0x73, 0x66, 0x31}}, N_("Solaris /home")},
+	{0xBF06, {0x6A9283A5, 0x1DD2, 0x11B2, 0x99, 0xA6,
+		  { 0x08, 0x00, 0x20, 0x73, 0x66, 0x31}}, N_("Solaris alternate sector")},
+	{0xBF07, {0x6A945A3B, 0x1DD2, 0x11B2, 0x99, 0xA6,
+		  { 0x08, 0x00, 0x20, 0x73, 0x66, 0x31}}, N_("Solaris reserved 1")},
+	{0xBF08, {0x6A9630D1, 0x1DD2, 0x11B2, 0x99, 0xA6,
+		  { 0x08, 0x00, 0x20, 0x73, 0x66, 0x31}}, N_("Solaris reserved 2")},
+	{0xBF09, {0x6A980767, 0x1DD2, 0x11B2, 0x99, 0xA6,
+		  { 0x08, 0x00, 0x20, 0x73, 0x66, 0x31}}, N_("Solaris reserved 3")},
+	{0xBF0A, {0x6A96237F, 0x1DD2, 0x11B2, 0x99, 0xA6,
+		  { 0x08, 0x00, 0x20, 0x73, 0x66, 0x31}}, N_("Solaris reserved 4")},
+	{0xBF0B, {0x6A8D2AC7, 0x1DD2, 0x11B2, 0x99, 0xA6,
+		  { 0x08, 0x00, 0x20, 0x73, 0x66, 0x31}}, N_("Solaris reserved 5")},
+
+	/* NetBSD */
+	{0xA901, {0x49F48D32, 0xB10E, 0x11DC, 0xB9, 0x9B,
+		  { 0x00, 0x19, 0xD1, 0x87, 0x96, 0x48}}, N_("NetBSD swap")},
+	{0xA902, {0x49F48D5A, 0xB10E, 0x11DC, 0xB9, 0x9B,
+		  { 0x00, 0x19, 0xD1, 0x87, 0x96, 0x48}}, N_("NetBSD FFS")},
+	{0xA903, {0x49F48D82, 0xB10E, 0x11DC, 0xB9, 0x9B,
+		  { 0x00, 0x19, 0xD1, 0x87, 0x96, 0x48}}, N_("NetBSD LFS")},
+	{0xA904, {0x2DB519C4, 0xB10E, 0x11DC, 0xB9, 0x9B,
+		  { 0x00, 0x19, 0xD1, 0x87, 0x96, 0x48}}, N_("NetBSD concatenated")},
+	{0xA905, {0x2DB519EC, 0xB10E, 0x11DC, 0xB9, 0x9B,
+		  { 0x00, 0x19, 0xD1, 0x87, 0x96, 0x48}}, N_("NetBSD encrypted")},
+	{0xA906, {0x49F48DAA, 0xB10E, 0x11DC, 0xB9, 0x9B,
+		  { 0x00, 0x19, 0xD1, 0x87, 0x96, 0x48}}, N_("NetBSD RAID")},
+
+	/* ChromeOS */
+	{0x7F00, {0xFE3A2A5D, 0x4F32, 0x41A7, 0xB7, 0x25,
+		  { 0xAC, 0xCC, 0x32, 0x85, 0xA3, 0x09}}, N_("ChromeOS kernel")},
+	{0x7F01, {0x3CB8E202, 0x3B7E, 0x47DD, 0x8A, 0x3C,
+		  { 0x7F, 0xF2, 0xA1, 0x3C, 0xFC, 0xEC}}, N_("ChromeOS root fs")},
+	{0x7F02, {0x2E0A753D, 0x9E48, 0x43B0, 0x83, 0x37,
+		  { 0xB1, 0x51, 0x92, 0xCB, 0x1B, 0x5E}}, N_("ChromeOS reserved")},
+
+	/* MidnightBSD */
+	{0xA580, {0x85D5E45A, 0x237C, 0x11E1, 0xB4, 0xB3,
+		  { 0xE8, 0x9A, 0x8F, 0x7F, 0xC3, 0xA7}}, N_("MidnightBSD data")},
+	{0xA581, {0x85D5E45E, 0x237C, 0x11E1, 0xB4, 0xB3,
+		  { 0xE8, 0x9A, 0x8F, 0x7F, 0xC3, 0xA7}}, N_("MidnightBSD boot")},
+	{0xA582, {0x85D5E45B, 0x237C, 0x11E1, 0xB4, 0xB3,
+		  { 0xE8, 0x9A, 0x8F, 0x7F, 0xC3, 0xA7}}, N_("MidnightBSD swap")},
+	{0xA583, {0x0394Ef8B, 0x237C, 0x11E1, 0xB4, 0xB3,
+		  { 0xE8, 0x9A, 0x8F, 0x7F, 0xC3, 0xA7}}, N_("MidnightBSD UFS")},
+	{0xA584, {0x85D5E45D, 0x237C, 0x11E1, 0xB4, 0xB3,
+		  { 0xE8, 0x9A, 0x8F, 0x7F, 0xC3, 0xA7}}, N_("MidnightBSD ZFS")},
+	{0xA585, {0x85D5E45C, 0x237C, 0x11E1, 0xB4, 0xB3,
+		  { 0xE8, 0x9A, 0x8F, 0x7F, 0xC3, 0xA7}}, N_("MidnightBSD Vinum")},
+
+	{0, {0}, 0},
+};
+
+/* primary GPT header */
+static struct gpt_header *pheader = NULL;
+/* backup GPT header */
+static struct gpt_header *bheader = NULL;
+/* partition entry array */
+static struct gpt_entry *ents = NULL;
+
+static const char *gpt_get_header_revstr(struct gpt_header *header)
+{
+	if (!header)
+		goto unknown;
+
+	switch (header->revision) {
+	case GPT_HEADER_REVISION_V1_02:
+		return "1.2";
+	case GPT_HEADER_REVISION_V1_00:
+		return "1.0";
+	case GPT_HEADER_REVISION_V0_99:
+		return "0.99";
+	default:
+		goto unknown;
+	}
+
+unknown:
+	return "unknown";
+}
+
+static inline int partition_unused(struct gpt_entry e)
+{
+	return !memcmp(&e.partition_type_guid, &GPT_UNUSED_ENTRY_GUID,
+			sizeof(struct fdisk_guid));
+}
+
+/*
+ * Checks if there is a valid protective MBR partition table.
+ * Returns 0 if it is invalid or failure. Otherwise, return
+ * GPT_MBR_PROTECTIVE or GPT_MBR_HYBRID, depeding on the detection.
+ */
+static int valid_pmbr(struct fdisk_context *cxt)
+{
+	int i, ret = 0; /* invalid by default */
+	struct gpt_legacy_mbr *pmbr = NULL;
+
+	if (!cxt->firstsector)
+		goto done;
+
+	pmbr = (struct gpt_legacy_mbr *) cxt->firstsector;
+
+	if (pmbr->signature != cpu_to_le64(MSDOS_MBR_SIGNATURE))
+		goto done;
+
+	/* LBA of the GPT partition header */
+	if (pmbr->partition_record[0].starting_lba !=
+	    cpu_to_le32(GPT_PRIMARY_PARTITION_TABLE_LBA))
+		goto done;
+
+	/* seems like a valid MBR was found, check DOS primary partitions */
+	for (i = 0; i < 4; i++)
+		if (pmbr->partition_record[i].os_type == EFI_PMBR_OSTYPE) {
+			/*
+			 * Ok, we at least know that there's a protective MBR,
+			 * now check if there are other partition types for
+			 * hybrid MBR.
+			 */
+			ret = GPT_MBR_PROTECTIVE;
+			goto check_hybrid;
+		}
+
+check_hybrid:
+	if (ret != GPT_MBR_PROTECTIVE)
+		goto done;
+	for (i = 0 ; i < 4; i++)
+		if ((pmbr->partition_record[i].os_type != EFI_PMBR_OSTYPE) &&
+		    (pmbr->partition_record[i].os_type != 0x00))
+			ret = GPT_MBR_HYBRID;
+
+	/*
+	 * Protective MBRs take up the lesser of the whole disk
+	 * or 2 TiB (32bit LBA), ignoring the rest of the disk.
+	 *
+	 * Hybrid MBRs do not necessarily comply with this.
+	 */
+	if (ret == GPT_MBR_PROTECTIVE)
+		if (pmbr->partition_record[0].size_in_lba !=
+		    cpu_to_le32(min((uint32_t) cxt->total_sectors - 1, 0xFFFFFFFF)))
+			ret = 0;
+done:
+	return ret;
 }
 
-static uint64_t
-last_lba(int fd)
+static uint64_t last_lba(struct fdisk_context *cxt)
 {
-	int rc;
-	uint64_t sectors = 0;
 	struct stat s;
 
-	memset(&s, 0, sizeof (s));
-	rc = fstat(fd, &s);
-	if (rc == -1)
-	{
+	memset(&s, 0, sizeof(s));
+	if (fstat(cxt->dev_fd, &s) == -1) {
 		fprintf(stderr, "last_lba() could not stat: %m\n");
 		return 0;
 	}
+
 	if (S_ISBLK(s.st_mode))
-		sectors = _get_num_sectors(fd);
-	else if (S_ISREG(s.st_mode))
-		sectors = s.st_size >> _get_sector_size(fd);
-	else
-	{
+		return cxt->total_sectors - 1;
+	else if (S_ISREG(s.st_mode)) {
+		uint64_t sectors = s.st_size >> cxt->sector_size;
+		return (sectors / cxt->sector_size) - 1ULL;
+	} else {
 		fprintf(stderr,
 			"last_lba(): I don't know how to handle files with mode %o\n",
 			s.st_mode);
-		sectors = 1;
 	}
-	return sectors - 1;
+	return 0;
 }
 
-static ssize_t
-read_lba(int fd, uint64_t lba, void *buffer, size_t bytes)
+static ssize_t read_lba(struct fdisk_context *cxt, uint64_t lba,
+			void *buffer, const size_t bytes)
 {
-	int sector_size = _get_sector_size(fd);
-	off_t offset = lba * sector_size;
+	off_t offset = lba * cxt->sector_size;
 
-	lseek(fd, offset, SEEK_SET);
-	return read(fd, buffer, bytes);
+	lseek(cxt->dev_fd, offset, SEEK_SET);
+	return read(cxt->dev_fd, buffer, bytes);
 }
 
-static GuidPartitionTableHeader_t *
-alloc_read_gpt_header(int fd, uint64_t lba)
+
+/* Returns the GPT entry array */
+static struct gpt_entry *gpt_get_entries(struct fdisk_context *cxt,
+					 struct gpt_header *header, const ssize_t sz)
 {
-	GuidPartitionTableHeader_t *gpt =
-		(GuidPartitionTableHeader_t *) malloc(sizeof (GuidPartitionTableHeader_t));
-	if (!gpt)
+	struct gpt_entry *ret = xcalloc(1, sizeof(*ents) * sz);
+	off_t offset = le64_to_cpu(header->partition_entry_lba) *
+		       cxt->sector_size;
+
+	if (offset != lseek(cxt->dev_fd, offset, SEEK_SET))
 		return NULL;
-	memset(gpt, 0, sizeof (*gpt));
-	if (!read_lba(fd, lba, gpt, sizeof (GuidPartitionTableHeader_t)))
-	{
-		free(gpt);
+	if (sz != read(cxt->dev_fd, ret, sz))
 		return NULL;
+
+	return ret;
+}
+
+static inline uint32_t count_crc32(const unsigned char *buf, size_t len)
+{
+	return (crc32(~0L, buf, len) ^ ~0L);
+}
+
+/*
+ * Recompute header and partition array 32bit CRC checksums.
+ * This function does not fail - if there's corruption, then it
+ * will be reported when checksuming it again (ie: probing or verify).
+ */
+static void gpt_recompute_crc(struct gpt_header *header, struct gpt_entry *e)
+{
+	uint32_t crc = 0;
+	size_t entry_sz = 0;
+
+	if (!header)
+		return;
+
+	/* header CRC */
+	header->crc32 = 0;
+	crc = count_crc32((unsigned char *) header, le32_to_cpu(header->size));
+	header->crc32 = cpu_to_le32(crc);
+
+	/* partition entry array CRC */
+	header->partition_entry_array_crc32 = 0;
+	entry_sz = le32_to_cpu(header->npartition_entries) *
+		le32_to_cpu(header->sizeof_partition_entry);
+
+	crc = count_crc32((unsigned char *) e, entry_sz);
+	header->partition_entry_array_crc32 = cpu_to_le32(crc);
+}
+
+/*
+ * Compute the 32bit CRC checksum of the partition table header.
+ * Returns 1 if it is valid, otherwise 0.
+ */
+static int gpt_check_header_crc(struct gpt_header *header)
+{
+	uint32_t crc, orgcrc = le32_to_cpu(header->crc32);
+
+	header->crc32 = 0;
+	crc = count_crc32((unsigned char *) header, le32_to_cpu(header->size));
+	header->crc32 = cpu_to_le32(orgcrc);
+
+	/*
+	 * If we have checksum mismatch it may be due to stale data,
+	 * like a partition being added or deleted. Recompute the CRC again
+	 * and make sure this is not the case.
+	 */
+	if (crc != le32_to_cpu(header->crc32)) {
+		gpt_recompute_crc(header, ents);
+		orgcrc = le32_to_cpu(header->crc32);
+		header->crc32 = 0;
+		crc = count_crc32((unsigned char *) header, le32_to_cpu(header->size));
+		header->crc32 = cpu_to_le32(orgcrc);
+
+		return crc == le32_to_cpu(header->crc32);
+	} else
+		return 1;
+}
+
+/*
+ * It initializes the partition entry array.
+ * Returns 1 if the checksum is valid, otherwise 0.
+ */
+static int gpt_check_entryarr_crc(struct fdisk_context *cxt, struct gpt_header *header)
+{
+	int ret = 0;
+	ssize_t entry_sz;
+	uint32_t crc;
+
+	if (!header)
+		goto done;
+
+	entry_sz = le32_to_cpu(header->npartition_entries) *
+		   le32_to_cpu(header->sizeof_partition_entry);
+
+	if (!entry_sz)
+		goto done;
+
+	/* read header entries */
+	if (!ents)
+		ents = gpt_get_entries(cxt, header, entry_sz);
+	if (!ents)
+		goto done;
+
+	crc = count_crc32((unsigned char *) ents, entry_sz);
+	ret = (crc == le32_to_cpu(header->partition_entry_array_crc32));
+done:
+	return ret;
+}
+
+static int gpt_check_lba_sanity(struct fdisk_context *cxt, struct gpt_header *header)
+{
+	int ret = 0;
+	uint64_t lu, fu, lastlba = last_lba(cxt);
+
+	fu = le64_to_cpu(header->first_usable_lba);
+	lu = le64_to_cpu(header->last_usable_lba);
+
+	/* check if first and last usable LBA make sense */
+	if (lu < fu) {
+		DBG(LABEL, dbgprint("error: header last LBA is before first LBA"));
+		goto done;
+	}
+
+	/* check if first and last usable LBAs with the disk's last LBA */
+	if (fu > lastlba || lu > lastlba) {
+		DBG(LABEL, dbgprint("error: header LBAs are after the disk's last LBA"));
+		goto done;
+	}
+
+	/* the header has to be outside usable range */
+	if (fu < GPT_PRIMARY_PARTITION_TABLE_LBA &&
+	    GPT_PRIMARY_PARTITION_TABLE_LBA < lu) {
+		DBG(LABEL, dbgprint("error: header outside of usable range"));
+		goto done;
 	}
-	return gpt;
+
+	ret = 1; /* sane */
+done:
+	return ret;
+}
+
+/* Check if there is a valid header signature */
+static int gpt_check_signature(struct gpt_header *header)
+{
+	return header->signature == cpu_to_le64(GPT_HEADER_SIGNATURE);
+}
+
+/*
+ * Return the specified GPT Header, or NULL upon failure/invalid.
+ * Note that all tests must pass to ensure a valid header,
+ * we do not rely on only testing the signature for a valid probe.
+ */
+static struct gpt_header *gpt_get_header(struct fdisk_context *cxt, uint64_t lba)
+{
+	struct gpt_header *header = NULL;
+
+	if (!cxt)
+		return NULL;
+
+	header = xcalloc(1, sizeof(*header));
+
+	/* read specified LBA */
+	if (!read_lba(cxt, lba, header, sizeof(struct gpt_header)))
+		goto invalid;
+
+	if (!gpt_check_signature(header))
+		goto invalid;
+
+	if (!gpt_check_header_crc(header) ||
+	    !gpt_check_entryarr_crc(cxt, header))
+		goto invalid;
+
+	if (!gpt_check_lba_sanity(cxt, header))
+		goto invalid;
+
+	/* valid header must be at MyLBA */
+	if (le64_to_cpu(header->my_lba) != lba)
+		goto invalid;
+
+	return header;
+invalid:
+	free(header);
+	return NULL;
+}
+
+/*
+ * Return the Backup GPT Header, or NULL upon failure/invalid.
+ */
+static struct gpt_header *gpt_get_bheader(struct fdisk_context *cxt)
+{
+	return gpt_get_header(cxt, last_lba(cxt));
+}
+
+/*
+ * Return the Primary GPT Header, or NULL upon failure/invalid.
+ */
+static struct gpt_header *gpt_get_pheader(struct fdisk_context *cxt)
+{
+	return gpt_get_header(cxt, GPT_PRIMARY_PARTITION_TABLE_LBA);
+}
+
+/*
+ * Returns the number of partitions that are in use.
+ */
+static uint32_t partitions_in_use(struct gpt_header *header, struct gpt_entry *e)
+{
+	uint32_t i, used = 0;
+
+	if (!header || ! e)
+		return 0;
+
+	for (i = 0; i < le32_to_cpu(header->npartition_entries); i++)
+		if (!partition_unused(e[i]))
+			used++;
+	return used;
+}
+
+/*
+ * Returns the partition length, or 0 if end is before beginning.
+ */
+static uint64_t partition_size(struct gpt_entry e)
+{
+	uint64_t start = le64_to_cpu(e.lba_start);
+	uint64_t end = le64_to_cpu(e.lba_end);
+
+	return start > end ? 0 : end - start + 1ULL;
 }
 
-static int
-gpt_check_signature(int fd, uint64_t lba)
+/*
+ * Check if a partition is too big for the disk (sectors).
+ * Returns the faulting partition number, otherwise 0.
+ */
+static int partition_check_too_big(struct gpt_header *header,
+				   struct gpt_entry *e, uint64_t sectors)
 {
-	GuidPartitionTableHeader_t *gpt;
-	int res=0;
+	uint32_t i;
 
-	if ((gpt = alloc_read_gpt_header(fd, lba)))
-	{
-		if (gpt->Signature == cpu_to_le64(GPT_HEADER_SIGNATURE))
-			res = 1;
-		free(gpt);
+	for (i = 0; i < le32_to_cpu(header->npartition_entries); i++) {
+		if (partition_unused(e[i]))
+			continue;
+		if (e[i].lba_end >= sectors)
+			return i + 1;
 	}
-	return res;
+
+	return 0;
 }
 
-/* returns:
- *	0 not found GPT
- *	1 for valid primary GPT header
- *	2 for valid alternative GPT header
+/*
+ * Check if a partition ends before it begins
+ * Returns the faulting partition number, otherwise 0.
  */
-int
-gpt_probe_signature_fd(int fd)
+static int partition_start_after_end(struct gpt_header *header, struct gpt_entry *e)
 {
-	int res = 0;
+	uint32_t i;
 
-	/* check primary GPT header */
-	if (gpt_check_signature(fd, GPT_PRIMARY_PARTITION_TABLE_LBA))
-		res = 1;
-	else
-	{
-		/* check alternative GPT header */
-		uint64_t lastlba = last_lba(fd);
-		if (gpt_check_signature(fd, lastlba))
-			res = 2;
+	for (i = 0; i < le32_to_cpu(header->npartition_entries); i++) {
+		if (partition_unused(e[i]))
+			continue;
+		if (e[i].lba_start > e[i].lba_end)
+			return i + 1;
 	}
-	return res;
+
+	return 0;
 }
 
-int
-gpt_probe_signature_devname(char *devname)
+/*
+ * Check if partition e1 overlaps with partition e2
+ */
+static inline int partition_overlap(struct gpt_entry e1, struct gpt_entry e2)
 {
-	int res, fd;
-	if ((fd = open(devname, O_RDONLY)) < 0)
+	return (e1.lba_start && e2.lba_start &&
+		(e1.lba_start <= e2.lba_end) != (e1.lba_end < e2.lba_start));
+}
+
+/*
+ * Find any paritions that overlap.
+ */
+static int partition_check_overlaps(struct gpt_header *header, struct gpt_entry *e)
+{
+	uint32_t i, j;
+
+	for (i = 0; i < le32_to_cpu(header->npartition_entries); i++)
+		for (j = 0; j < i; j++) {
+			if (partition_unused(e[i]) ||
+			    partition_unused(e[j]))
+				continue;
+			if (partition_overlap(e[i], e[j]))
+				/* two overlaping partitions is enough! */
+				return i + 1;
+		}
+
+	return 0;
+}
+
+/*
+ * Find the first available block after the starting point; returns 0 if
+ * there are no available blocks left, or error. From gdisk.
+ */
+static uint64_t find_first_available(struct gpt_header *header,
+				     struct gpt_entry *e, uint64_t start)
+{
+	uint64_t first;
+	uint32_t i, first_moved = 0;
+
+	if (!header || !e)
 		return 0;
-	res = gpt_probe_signature_fd(fd);
-	close(fd);
-	return res;
+
+	/*
+	 * Begin from the specified starting point or from the first usable
+	 * LBA, whichever is greater...
+	 */
+	first = start < header->first_usable_lba ? header->first_usable_lba : start;
+
+	/*
+	 * Now search through all partitions; if first is within an
+	 * existing partition, move it to the next sector after that
+	 * partition and repeat. If first was moved, set firstMoved
+	 * flag; repeat until firstMoved is not set, so as to catch
+	 * cases where partitions are out of sequential order....
+	 */
+	do {
+		first_moved = 0;
+		for (i = 0; i < le32_to_cpu(header->npartition_entries); i++) {
+			if (partition_unused(e[i]))
+				continue;
+			if (first < e[i].lba_start)
+				continue;
+			if (first <= e[i].lba_end) {
+				first = e[i].lba_end + 1;
+				first_moved = 1;
+			}
+		}
+	} while (first_moved == 1);
+
+	if (first > header->last_usable_lba)
+		first = 0;
+
+	return first;
 }
 
-#ifdef GPT_TEST_MAIN
-int
-main(int argc, char **argv)
+
+/* Returns last available sector in the free space pointed to by start. From gdisk. */
+static uint64_t find_last_free(struct gpt_header *header,
+			       struct gpt_entry *e, uint64_t start)
 {
-	atexit(close_stdout);
-	if (argc!=2)
-	{
-		fprintf(stderr, "usage: %s <dev>\n", argv[0]);
-		exit(EXIT_FAILURE);
+	uint32_t i;
+	uint64_t nearest_start;
+
+	if (!header || !e)
+		return 0;
+
+	nearest_start = header->last_usable_lba;
+	for (i = 0; i < le32_to_cpu(header->npartition_entries); i++) {
+		if (nearest_start > e[i].lba_start &&
+		    e[i].lba_start > start)
+			nearest_start = e[i].lba_start - 1;
 	}
-	if (gpt_probe_signature_devname(argv[1]))
-		printf("GPT (GUID Partition Table) detected on %s\n", argv[1]);
-	exit(EXIT_SUCCESS);
+
+	return nearest_start;
 }
-#endif
+
+/* Returns the last free sector on the disk. From gdisk. */
+static uint64_t find_last_free_sector(struct gpt_header *header,
+				      struct gpt_entry *e)
+{
+	uint32_t i, last_moved;
+	uint64_t last = 0;
+
+	if (!header || !e)
+		goto done;
+
+	/* start by assuming the last usable LBA is available */
+	last = header->last_usable_lba;
+	do {
+		last_moved = 0;
+		for (i = 0; i < le32_to_cpu(header->npartition_entries); i++) {
+			if ((last >= e[i].lba_start) &&
+			    (last <= e[i].lba_end)) {
+				last = e[i].lba_start - 1;
+				last_moved = 1;
+			}
+		}
+	} while (last_moved == 1);
+done:
+	return last;
+}
+
+/*
+ * Finds the first available sector in the largest block of unallocated
+ * space on the disk. Returns 0 if there are no available blocks left.
+ * From gdisk.
+ */
+static uint64_t find_first_in_largest(struct gpt_header *header, struct gpt_entry *e)
+{
+	uint64_t start = 0, first_sect, last_sect;
+	uint64_t segment_size, selected_size = 0, selected_segment = 0;
+
+	if (!header || !e)
+		goto done;
+
+	do {
+		first_sect =  find_first_available(header, e, start);
+		if (first_sect != 0) {
+			last_sect = find_last_free(header, e, first_sect);
+			segment_size = last_sect - first_sect + 1;
+
+			if (segment_size > selected_size) {
+				selected_size = segment_size;
+				selected_segment = first_sect;
+			}
+			start = last_sect + 1;
+		}
+	} while (first_sect != 0);
+
+done:
+	return selected_segment;
+}
+
+/*
+ * Find the total number of free sectors, the number of segments in which
+ * they reside, and the size of the largest of those segments. From gdisk.
+ */
+static uint64_t get_free_sectors(struct fdisk_context *cxt, struct gpt_header *header,
+				 struct gpt_entry *e, uint32_t *nsegments,
+				 uint64_t *largest_segment)
+{
+	uint32_t num = 0;
+	uint64_t first_sect, last_sect;
+	uint64_t largest_seg = 0, segment_sz;
+	uint64_t totfound = 0, start = 0; /* starting point for each search */
+
+	if (!cxt->total_sectors)
+		goto done;
+
+	do {
+		first_sect = find_first_available(header, e, start);
+		if (first_sect) {
+			last_sect = find_last_free(header, e, first_sect);
+			segment_sz = last_sect - first_sect + 1;
+
+			if (segment_sz > largest_seg)
+				largest_seg = segment_sz;
+			totfound += segment_sz;
+			num++;
+			start = last_sect + 1;
+		}
+	} while (first_sect);
+
+done:
+	*nsegments = num;
+	*largest_segment = largest_seg;
+
+	return totfound;
+}
+
+/*
+ * Initialize fdisk-specific variables - call once probing passes!
+ */
+static void gpt_init(void)
+{
+	disklabel = GPT_LABEL;
+	partitions = le32_to_cpu(pheader->npartition_entries);
+}
+
+static int gpt_probe_label(struct fdisk_context *cxt)
+{
+	int mbr_type;
+
+	if (!cxt)
+		goto failed;
+
+	mbr_type = valid_pmbr(cxt);
+	if (!mbr_type)
+		goto failed;
+
+	DBG(LABEL, dbgprint("found a %s MBR", mbr_type == GPT_MBR_PROTECTIVE ?
+			    "protective" : "hybrid"));
+
+	pheader = gpt_get_pheader(cxt);
+
+	/*
+	 * TODO: If the primary GPT is corrupt, we must check the last LBA of the
+	 * device to see if it has a valid GPT Header and point to a valid GPT
+	 * Partition Entry Array.
+	 * If it points to a valid GPT Partition Entry Array, then software should
+	 * restore the primary GPT if allowed by platform policy settings.
+	 *
+	 * For now we just abort GPT probing!
+	 */
+	if (!pheader)
+		goto failed;
+
+	/* OK, probing passed, now initialize backup header and fdisk variables. */
+	bheader = gpt_get_bheader(cxt);
+	gpt_init();
+
+	printf(_("\nWARNING: fdisk GPT support is currently new, and therefore "
+		 "in an experimental phase. Use at your own discretion.\n\n"));
+
+	return 1;
+failed:
+	return 0;
+}
+
+/*
+ * Stolen from libblkid - can be removed once partition semantics
+ * are added to the fdisk API.
+ */
+static char *encode_to_utf8(unsigned char *src, size_t count)
+{
+	uint16_t c;
+	char *dest = xmalloc(count * sizeof(char));
+	size_t i, j, len = count;
+	memset(dest, 0, sizeof(char) * count);
+
+	for (j = i = 0; i + 2 <= count; i += 2) {
+		/* always little endian */
+		c = (src[i+1] << 8) | src[i];
+		if (c == 0) {
+			dest[j] = '\0';
+			break;
+		} else if (c < 0x80) {
+			if (j+1 >= len)
+				break;
+			dest[j++] = (uint8_t) c;
+		} else if (c < 0x800) {
+			if (j+2 >= len)
+				break;
+			dest[j++] = (uint8_t) (0xc0 | (c >> 6));
+			dest[j++] = (uint8_t) (0x80 | (c & 0x3f));
+		} else {
+			if (j+3 >= len)
+				break;
+			dest[j++] = (uint8_t) (0xe0 | (c >> 12));
+			dest[j++] = (uint8_t) (0x80 | ((c >> 6) & 0x3f));
+			dest[j++] = (uint8_t) (0x80 | (c & 0x3f));
+		}
+	}
+	dest[j] = '\0';
+
+	return dest;
+}
+
+/*
+ * List label partitions.
+ * This function must currently exist to comply with standard fdisk
+ * requirements, but once partition semantics are added to the fdisk
+ * API it can be removed for custom implementation (see gpt_label struct).
+ */
+void gpt_list_table(struct fdisk_context *cxt,
+		    int xtra  __attribute__ ((__unused__)))
+{
+	uint32_t i;
+	uint64_t fu = le64_to_cpu(pheader->first_usable_lba);
+	uint64_t lu = le64_to_cpu(pheader->last_usable_lba);
+
+	printf("\nPartNum   Start       End   Size        Name\n");
+
+	for (i = 0; i < le32_to_cpu(pheader->npartition_entries); i++) {
+		char *name = NULL, *sizestr = NULL;
+		uint64_t start = le64_to_cpu(ents[i].lba_start);
+		uint64_t size = partition_size(ents[i]);
+
+		if (partition_unused(ents[i]) || !size)
+			continue;
+
+		/* the partition has to inside usable range */
+		if (start < fu || start + size - 1 > lu)
+			continue;
+
+		name = encode_to_utf8((unsigned char *)ents[i].partition_name,
+				      sizeof(ents[i].partition_name));
+		if (!name)
+			continue;
+		sizestr = size_to_human_string(SIZE_SUFFIX_1LETTER,
+					       size * cxt->sector_size);
+		if (!sizestr)
+			continue;
+
+		printf("%2d %12ld   %9ld %4s\t %s\n",
+		       i+1,
+		       ents[i].lba_start,
+		       ents[i].lba_end,
+		       sizestr,
+		       name);
+		free(name);
+		free(sizestr);
+	}
+}
+
+/*
+ * Write partitions.
+ * Returns 0 on success, or corresponding error otherwise.
+ */
+static int gpt_write_partitions(struct fdisk_context *cxt,
+				struct gpt_header *header, struct gpt_entry *e)
+{
+	off_t offset = le64_to_cpu(header->partition_entry_lba) * cxt->sector_size;
+	uint32_t nparts = le32_to_cpu(header->npartition_entries);
+	uint32_t totwrite = nparts * le32_to_cpu(header->sizeof_partition_entry);
+
+	if (offset != lseek(cxt->dev_fd, offset, SEEK_SET))
+		goto fail;
+	if (totwrite == write(cxt->dev_fd, e, totwrite))
+		return 0;
+fail:
+	return -errno;
+}
+
+/*
+ * Write a GPT header to a specified LBA
+ * Returns 0 on success, or corresponding error otherwise.
+ */
+static int gpt_write_header(struct fdisk_context *cxt,
+			    struct gpt_header *header, uint64_t lba)
+{
+	off_t offset = lba * cxt->sector_size;
+
+	if (offset != lseek(cxt->dev_fd, offset, SEEK_SET))
+		goto fail;
+	if (cxt->sector_size ==
+	    (size_t) write(cxt->dev_fd, header, cxt->sector_size))
+		return 0;
+fail:
+	return -errno;
+}
+
+/*
+ * Write the protective MBR.
+ * Returns 0 on success, or corresponding error otherwise.
+ */
+static int gpt_write_pmbr(struct fdisk_context *cxt)
+{
+	off_t offset;
+	struct gpt_legacy_mbr *pmbr = NULL;
+
+	if (!cxt || !cxt->firstsector)
+		return -EINVAL;
+
+	pmbr = (struct gpt_legacy_mbr *) cxt->firstsector;
+
+	/* zero out the legacy partitions */
+	memset(pmbr->partition_record, 0, sizeof(pmbr->partition_record));
+
+	pmbr->signature = cpu_to_le16(MSDOS_MBR_SIGNATURE);
+	pmbr->partition_record[0].os_type      = EFI_PMBR_OSTYPE;
+	pmbr->partition_record[0].start_sector = 1;
+	pmbr->partition_record[0].end_head     = 0xFE;
+	pmbr->partition_record[0].end_sector   = 0xFF;
+	pmbr->partition_record[0].end_track    = 0xFF;
+	pmbr->partition_record[0].starting_lba = cpu_to_le32(1);
+
+	/*
+	 * Set size_in_lba to the size of the disk minus one. If the size of the disk
+	 * is too large to be represented by a 32bit LBA (2Tb), set it to 0xFFFFFFFF.
+	 */
+	if (cxt->total_sectors - 1 > 0xFFFFFFFFULL)
+		pmbr->partition_record[0].size_in_lba = cpu_to_le32(0xFFFFFFFF);
+	else
+		pmbr->partition_record[0].size_in_lba =
+			cpu_to_le32(cxt->total_sectors - 1UL);
+
+	offset = GPT_PMBR_LBA * cxt->sector_size;
+	if (offset != lseek(cxt->dev_fd, offset, SEEK_SET))
+		goto fail;
+
+	if (1 == write(cxt->dev_fd, pmbr, 1))
+		return 0;
+fail:
+	return -errno;
+}
+
+/*
+ * Writes in-memory GPT and pMBR data to disk.
+ * Returns 0 if successful write, otherwise, a corresponding error.
+ * Any indication of error will abort the operation.
+ */
+static int gpt_write_disklabel(struct fdisk_context *cxt)
+{
+	if (!cxt)
+		goto err0;
+
+	/* we do not want to mess up hybrid MBRs by creating a valid pmbr */
+	if (valid_pmbr(cxt) == GPT_MBR_HYBRID)
+		goto err0;
+
+	/* check that disk is big enough to handle the backup header */
+	if (pheader->alternative_lba > cxt->total_sectors)
+		goto err0;
+
+	/* check that the backup header is properly placed */
+	if (pheader->alternative_lba < cxt->total_sectors - 1)
+		/* TODO: correct this (with user authorization) and write */
+		goto err0;
+
+	if (partition_check_overlaps(pheader, ents))
+		goto err0;
+
+	/* recompute CRCs for both headers */
+	gpt_recompute_crc(pheader, ents);
+	gpt_recompute_crc(bheader, ents);
+
+	/*
+	 * UEFI requires writing in this specific order:
+	 *   1) backup partition tables
+	 *   2) backup GPT header
+	 *   3) primary partition tables
+	 *   4) primary GPT header
+	 *   5) protective MBR
+	 *
+	 * If any write fails, we abort the rest.
+	 */
+	if (gpt_write_partitions(cxt, bheader, ents) != 0)
+		goto err1;
+	if (gpt_write_header(cxt, bheader, pheader->alternative_lba) != 0)
+		goto err1;
+	if (gpt_write_partitions(cxt, pheader, ents) != 0)
+		goto err1;
+	if (gpt_write_header(cxt, pheader, GPT_PRIMARY_PARTITION_TABLE_LBA) != 0)
+		goto err1;
+	if (gpt_write_pmbr(cxt) != 0)
+		goto err1;
+
+	return 0;
+err0:
+	return -EINVAL;
+err1:
+	return -errno;
+}
+
+/*
+ * Verify data integrity and report any found problems for:
+ *   - primary and backup header validations
+ *   - paritition validations
+ */
+static int gpt_verify_disklabel(struct fdisk_context *cxt)
+{
+	int nerror = 0;
+	uint64_t ptnum;
+
+	if (!bheader) {
+		nerror++;
+		printf(_("Disk does not contain a valid backup header.\n"));
+	}
+
+	if (!gpt_check_header_crc(pheader)) {
+		nerror++;
+		printf(_("Invalid primary header CRC checksum.\n"));
+	}
+	if (bheader && !gpt_check_header_crc(bheader)) {
+		nerror++;
+		printf(_("Invalid backup header CRC checksum.\n"));
+	}
+
+	if (!gpt_check_entryarr_crc(cxt, pheader)) {
+		nerror++;
+		printf(_("Invalid partition entry checksum.\n"));
+	}
+
+	if (!gpt_check_lba_sanity(cxt, pheader)) {
+		nerror++;
+		printf(_("Invalid primary header LBA sanity checks.\n"));
+	}
+	if (bheader && !gpt_check_lba_sanity(cxt, bheader)) {
+		nerror++;
+		printf(_("Invalid backup header LBA sanity checks.\n"));
+	}
+
+	if (le64_to_cpu(pheader->my_lba) != GPT_PRIMARY_PARTITION_TABLE_LBA) {
+		nerror++;
+		printf(_("MyLBA mismatch with real position at primary header.\n"));
+	}
+	if (bheader && le64_to_cpu(bheader->my_lba) != last_lba(cxt)) {
+		nerror++;
+		printf(_("MyLBA mismatch with real position at backup header.\n"));
+
+	}
+
+	if (pheader->alternative_lba >= cxt->total_sectors) {
+		nerror++;
+		printf(_("Disk is to small to hold all data.\n"));
+	}
+
+	/*
+	 * if the GPT is the primary table, check the alternateLBA
+	 * to see if it is a valid GPT
+	 */
+	if (bheader && (pheader->my_lba != bheader->alternative_lba)) {
+		nerror++;
+		printf(_("Primary and backup header mismatch.\n"));
+	}
+
+	ptnum = partition_check_overlaps(pheader, ents);
+	if (ptnum) {
+		nerror++;
+		printf(_("Partition %ld overlaps with partition %ld.\n"), ptnum, ptnum+1);
+	}
+
+	ptnum = partition_check_too_big(pheader, ents, cxt->total_sectors);
+	if (ptnum) {
+		nerror++;
+		printf(_("Partition %ld is too big for the disk.\n"), ptnum);
+	}
+
+	ptnum = partition_start_after_end(pheader, ents);
+	if (ptnum) {
+		nerror++;
+		printf(_("Partition %ld ends before it starts.\n"), ptnum);
+	}
+
+	if (!nerror) { /* yay :-) */
+		uint32_t nsegments = 0;
+		uint64_t free_sectors = 0, largest_segment = 0;
+
+		printf(_("No errors detected\n"));
+		printf(_("Header version: %s\n"), gpt_get_header_revstr(pheader));
+		printf(_("Using %d out of %d partitions\n"),
+		       partitions_in_use(pheader, ents),
+		       le32_to_cpu(pheader->npartition_entries));
+
+		free_sectors = get_free_sectors(cxt, pheader, ents,
+						&nsegments, &largest_segment);
+		printf(_("A total of %ld free sectors available in %d segment(s) "
+			 "(largest %ld).\n"),
+		       free_sectors, nsegments, largest_segment);
+	} else
+		printf(_("Detected %d error(s).\n"), nerror);
+
+	return 0;
+}
+
+/* Delete a single GPT partition, specified by partnum. */
+static void gpt_delete_partition(struct fdisk_context *cxt, int partnum)
+{
+	if (!cxt || partition_unused(ents[partnum]) || partnum < 0)
+		return;
+
+	/* hasta la vista, baby! */
+	memset(&ents[partnum], 0, sizeof(ents[partnum]));
+	if (!partition_unused(ents[partnum]))
+		printf(_("Could not delete partition %d\n"), partnum + 1);
+	else {
+		gpt_recompute_crc(pheader, ents);
+		gpt_recompute_crc(bheader, ents);
+	}
+}
+
+/*
+ * Create a new GPT partition entry, specified by partnum, and with a range
+ * of fsect to lsenct sectors, of type sys.
+ * Returns 0 on success, or negative upon failure.
+ */
+static int gpt_create_new_partition(int partnum, uint64_t fsect, uint64_t lsect,
+				    int sys, struct gpt_entry *entries)
+{
+	size_t i;
+	struct gpt_entry *e = NULL;
+
+	if (fsect > lsect || partnum < 0)
+		return -EINVAL;
+
+	e = xcalloc(1, sizeof(*e));
+	e->lba_end = cpu_to_le64(lsect);
+	e->lba_start = cpu_to_le64(fsect);
+
+	/*
+	 * Copy corresponding partition type GUID.
+	 * Only the first three blocks are endian-aware.
+	 */
+	e->partition_type_guid.time_low = cpu_to_le32(gpt_sys_types[sys].guid.time_low);
+	e->partition_type_guid.time_mid = cpu_to_le16(gpt_sys_types[sys].guid.time_mid);
+	e->partition_type_guid.time_hi_and_version =
+		cpu_to_le16(gpt_sys_types[sys].guid.time_hi_and_version);
+	e->partition_type_guid.clock_seq_hi = gpt_sys_types[sys].guid.clock_seq_hi;
+	e->partition_type_guid.clock_seq_low = gpt_sys_types[sys].guid.clock_seq_low;
+	for (i = 0; i < 6; i++)
+		e->partition_type_guid.node[i] = gpt_sys_types[sys].guid.node[i];
+
+	/* deal with partition name */
+	for (i = 0; i < GPT_PART_NAME_LEN; i++)
+		e->partition_name[i] =
+			cpu_to_le16((uint16_t) gpt_sys_types[sys].name[i]);
+
+	/*
+	 * Any time a new partition entry is created a new GUID must be
+	 * generated for that partition, and every partition is guaranteed
+	 * to have a unique GUID.
+	 */
+	uuid_generate_random((unsigned char *) &e->unique_partition_guid);
+
+	/*
+	 * UUID is traditionally 16 byte big-endian array, except Intel EFI
+	 * specs where the UUID is a structure of little-endian fields, convert.
+	 */
+	e->unique_partition_guid.time_low =
+		cpu_to_le32(e->unique_partition_guid.time_low);
+	e->unique_partition_guid.time_mid =
+		cpu_to_le16(e->unique_partition_guid.time_mid);
+	e->unique_partition_guid.time_hi_and_version =
+		cpu_to_le16(e->unique_partition_guid.time_hi_and_version);
+
+	memcpy(&entries[partnum] , e, sizeof(*e));
+
+	gpt_recompute_crc(pheader, entries);
+	gpt_recompute_crc(bheader, entries);
+
+	return 0;
+}
+
+static int gpt_read_hex(void)
+{
+	int sys, done = 0;
+	size_t i = 1;
+
+	while (!done) {
+		sys = read_hex(gpt_sys_types);
+		for (i = 0; i < ARRAY_SIZE(gpt_sys_types) - 1; i++)
+			if (gpt_sys_types[i].type == sys) {
+				done = 1;
+				break;
+			}
+	}
+
+	return i;
+}
+
+/* Performs logical checks to add a new partition entry */
+static void gpt_add_partition(struct fdisk_context *cxt, int partnum, int sys)
+{
+	char msg[256];
+	uint32_t tmp;
+	uint64_t f0, f1; /* user input ranges for first and last sectors */
+	uint64_t def_sect, first_sect, last_sect; /* first and last available sector ranges */
+
+	/* check basic tests before even considering adding a new partition */
+	if (!cxt || partnum < 0)
+		return;
+	if (!partition_unused(ents[partnum])) {
+		printf(_("Partition %d is already defined. "
+			 "Delete it before re-adding it.\n"), partnum +1);
+		return;
+	}
+	if (le32_to_cpu(pheader->npartition_entries) == partitions_in_use(pheader, ents)) {
+		printf(_("All partitions are already in use.\n"));
+		return;
+	}
+
+	if (!get_free_sectors(cxt, pheader, ents, &tmp, &f0)) {
+		printf(_("No free sectors available.\n"));
+		return;
+	}
+
+	first_sect = find_first_available(pheader, ents, 0);
+	last_sect  = find_last_free_sector(pheader, ents);
+	def_sect   = find_first_in_largest(pheader, ents);
+
+	/* get user input for first and last sectors of the new partition */
+	snprintf(msg, sizeof(msg), _("First %s"), str_units(SINGULAR));
+	for (;;) {
+		f0 = read_int(cxt, first_sect, def_sect, last_sect, 0, msg);
+		if (f0 >= first_sect && f0 <= last_sect) {
+			last_sect  = find_last_free(pheader, ents, f0);
+			snprintf(msg, sizeof(msg), _("Last %s"), str_units(SINGULAR));
+			f1 = read_int(cxt, f0, last_sect, last_sect, 0, msg);
+			if (f1 >= f0 && f1 <= last_sect) {
+				sys = gpt_read_hex();
+				break;
+			}
+		}
+	}
+
+	if (gpt_create_new_partition(partnum, f0, f1, sys, ents) != 0)
+		printf(_("Could not create partition %d\n"), partnum + 1);
+	else
+		printf(_("Created partition %d\n"), partnum + 1);
+}
+
+const struct fdisk_label gpt_label =
+{
+	.name = "gpt",
+	.probe = gpt_probe_label,
+	.write = gpt_write_disklabel,
+	.verify = gpt_verify_disklabel,
+	.create = NULL,
+	.part_add = gpt_add_partition,
+	.part_delete = gpt_delete_partition,
+};
diff --git a/fdisks/gpt.h b/fdisks/gpt.h
index 2ac21c4..28326c4 100644
--- a/fdisks/gpt.h
+++ b/fdisks/gpt.h
@@ -1,7 +1,7 @@
 #ifndef FDISK_GPT_H
 #define FDISK_GPT_H
 
-extern int gpt_probe_signature_fd(int fd);
-extern int gpt_probe_signature_devname(char *devname);
+extern struct systypes gpt_sys_types[];
+extern void gpt_list_table(struct fdisk_context *cxt, int xtra);
 
 #endif /* FDISK_GPT_H */
diff --git a/fdisks/sfdisk.c b/fdisks/sfdisk.c
index 15c6d33..19bbb6f 100644
--- a/fdisks/sfdisk.c
+++ b/fdisks/sfdisk.c
@@ -50,7 +50,6 @@
 #include "linux_version.h"
 #include "common.h"
 #include "wholedisk.h"
-#include "gpt.h"
 #include "pathnames.h"
 #include "canonicalize.h"
 #include "rpmatch.h"
@@ -2526,25 +2525,6 @@ nextproc(FILE * procf) {
     return NULL;
 }
 
-static void
-gpt_warning(char *dev, int warn_only) {
-    if (force)
-	warn_only = 1;
-
-    if (dev && gpt_probe_signature_devname(dev)) {
-	fflush(stdout);
-	fprintf(stderr,
-		_("\nWARNING: GPT (GUID Partition Table) detected on '%s'! "
-		  "The util sfdisk doesn't support GPT. Use GNU Parted.\n\n"),
-		dev);
-	if (!warn_only) {
-	    fprintf(stderr,
-		    _("Use the --force flag to overrule this check.\n"));
-	    exit(1);
-	}
-    }
-}
-
 static void do_list(char *dev, int silent);
 static void do_size(char *dev, int silent);
 static void do_geom(char *dev, int silent);
@@ -2733,7 +2713,6 @@ main(int argc, char **argv) {
 	else {
 	    while ((dev = nextproc(procf)) != NULL) {
 		if (!is_ide_cdrom_or_tape(dev)) {
-		    gpt_warning(dev, 1);
 		    if (opt_out_geom)
 			do_geom(dev, 1);
 		    if (opt_out_pt_geom)
@@ -2765,7 +2744,6 @@ main(int argc, char **argv) {
 
     if (opt_list || opt_out_geom || opt_out_pt_geom || opt_size || verify) {
 	while (optind < argc) {
-	    gpt_warning(argv[optind], 1);
 	    if (opt_out_geom)
 		do_geom(argv[optind], 0);
 	    if (opt_out_pt_geom)
@@ -2779,9 +2757,6 @@ main(int argc, char **argv) {
 	exit(exit_status);
     }
 
-    if (optind != argc - 1)
-	gpt_warning(argv[optind], 0);
-
     if (activate) {
 	do_activate(argv + optind, argc - optind, activatearg);
 	exit(exit_status);
diff --git a/fdisks/utils.c b/fdisks/utils.c
index 84cdd4d..1d8e1af 100644
--- a/fdisks/utils.c
+++ b/fdisks/utils.c
@@ -39,6 +39,7 @@ int fdisk_debug_mask;
  */
 static const struct fdisk_label *labels[] =
 {
+	&gpt_label,
 	&dos_label,
 	&sun_label,
 	&sgi_label,
-- 
1.7.4.1




