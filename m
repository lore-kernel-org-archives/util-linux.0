Return-Path: dave@gnu.org
Message-ID: <1352880264.2577.3.camel@offbook>
Subject: [PATCH 1/3] fdisk: gpt: check header size
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Date: Wed, 14 Nov 2012 00:04:24 -0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

UEFI states that the size of the GPT header must be between 92 and
the sector size. Add the check when verifying a valid header.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/gpt.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fdisks/gpt.c b/fdisks/gpt.c
index 4a535f2..df26696 100644
--- a/fdisks/gpt.c
+++ b/fdisks/gpt.c
@@ -49,6 +49,7 @@
 #define GPT_HEADER_REVISION_V1_02 0x00010200
 #define GPT_HEADER_REVISION_V1_00 0x00010000
 #define GPT_HEADER_REVISION_V0_99 0x00009900
+#define GPT_HEADER_MINSZ          92 /* bytes */
 
 #define GPT_PMBR_LBA        0
 #define GPT_MBR_PROTECTIVE  1
@@ -183,7 +184,7 @@ static struct fdisk_parttype gpt_parttypes[] =
 	DEF_GUID("E6D6D379-F507-44C2-A23C-238F2A3DF928", N_("Linux LVM")),
 	DEF_GUID("8DA63339-0007-60C0-C436-083AC8230908", N_("Linux reserved")),
 
-      /* FreeBSD */
+	/* FreeBSD */
 	DEF_GUID("516E7CB4-6ECF-11D6-8FF8-00022D09712B", N_("FreeBSD data")),
 	DEF_GUID("83BD6B9D-7F41-11DC-BE0B-001560B84F0F", N_("FreeBSD boot")),
 	DEF_GUID("516E7CB5-6ECF-11D6-8FF8-00022D09712B", N_("FreeBSD swap")),
@@ -660,6 +661,7 @@ static int gpt_check_signature(struct gpt_header *header)
 static struct gpt_header *gpt_get_header(struct fdisk_context *cxt, uint64_t lba)
 {
 	struct gpt_header *header = NULL;
+	uint32_t hsz;
 
 	if (!cxt)
 		return NULL;
@@ -684,6 +686,11 @@ static struct gpt_header *gpt_get_header(struct fdisk_context *cxt, uint64_t lba
 	if (le64_to_cpu(header->my_lba) != lba)
 		goto invalid;
 
+	/* make sure header size is between 92 and sector size bytes */
+	hsz = le32_to_cpu(header->size);
+	if (hsz < GPT_HEADER_MINSZ || hsz > cxt->sector_size)
+		goto invalid;
+
 	return header;
 invalid:
 	free(header);
-- 
1.7.9.5
