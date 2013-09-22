Return-Path: davidlohr@hp.com
From: Davidlohr Bueso <davidlohr@hp.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Davidlohr Bueso <davidlohr@hp.com>
Subject: [PATCH 2/3] libfdisk: gpt: do not assume first pt record is always pmbr
Date: Sat, 21 Sep 2013 20:45:15 -0700
Message-Id: <1379821516-2540-2-git-send-email-davidlohr@hp.com>
In-Reply-To: <1379821516-2540-1-git-send-email-davidlohr@hp.com>
References: <1379821516-2540-1-git-send-email-davidlohr@hp.com>
List-ID: <util-linux.vger.kernel.org>

The 0xEE (GPT protective) partition does not always have to be
the first element in the array of MBR partition records.

Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
---
 libfdisk/src/gpt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index 2a6284a..bb9e9a7 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -475,7 +475,7 @@ static int gpt_mknew_header(struct fdisk_context *cxt,
  */
 static int valid_pmbr(struct fdisk_context *cxt)
 {
-	int i, ret = 0; /* invalid by default */
+	int i, part = 0, ret = 0; /* invalid by default */
 	struct gpt_legacy_mbr *pmbr = NULL;
 
 	if (!cxt->firstsector)
@@ -494,6 +494,7 @@ static int valid_pmbr(struct fdisk_context *cxt)
 	/* seems like a valid MBR was found, check DOS primary partitions */
 	for (i = 0; i < 4; i++) {
 		if (pmbr->partition_record[i].os_type == EFI_PMBR_OSTYPE) {
+			part = i;
 			/*
 			 * Ok, we at least know that there's a protective MBR,
 			 * now check if there are other partition types for
@@ -520,7 +521,7 @@ check_hybrid:
 	 * Hybrid MBRs do not necessarily comply with this.
 	 */
 	if (ret == GPT_MBR_PROTECTIVE) {
-		if (le32_to_cpu(pmbr->partition_record[0].size_in_lba) !=
+		if (le32_to_cpu(pmbr->partition_record[part].size_in_lba) !=
 		    min((uint32_t) cxt->total_sectors - 1, 0xFFFFFFFF))
 			ret = 0;
 	}
-- 
1.7.11.7
