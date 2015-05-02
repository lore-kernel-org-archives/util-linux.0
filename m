Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35643 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbbEBEpd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 2 May 2015 00:45:33 -0400
Received: by pabtp1 with SMTP id tp1so108913674pab.2
        for <util-linux@vger.kernel.org>; Fri, 01 May 2015 21:45:32 -0700 (PDT)
From: Michael Marineau <michael.marineau@coreos.com>
To: util-linux@vger.kernel.org
Cc: Michael Marineau <michael.marineau@coreos.com>
Subject: [PATCH] libfdisk: (gpt) fix check for beginning of protective partition
Date: Fri,  1 May 2015 21:44:33 -0700
Message-Id: <1430541873-27791-1-git-send-email-michael.marineau@coreos.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Search for the protective partition before attempting to validate that
it covers the GPT header. Some hybrid MBRs list partitions out of order.
For example, CoreOS images ship with a hybrid MBR that lists the boot
partition first and the protective partition second in order to maintain
compatibility with old versions of Xen's PV-GRUB.

Signed-off-by: Michael Marineau <michael.marineau@coreos.com>
---
 libfdisk/src/gpt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index a7766da..989fd75 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -678,11 +678,6 @@ static int valid_pmbr(struct fdisk_context *cxt)
 	if (le16_to_cpu(pmbr->signature) != MSDOS_MBR_SIGNATURE)
 		goto done;
 
-	/* LBA of the GPT partition header */
-	if (pmbr->partition_record[0].starting_lba !=
-	    cpu_to_le32(GPT_PRIMARY_PARTITION_TABLE_LBA))
-		goto done;
-
 	/* seems like a valid MBR was found, check DOS primary partitions */
 	for (i = 0; i < 4; i++) {
 		if (pmbr->partition_record[i].os_type == EFI_PMBR_OSTYPE) {
@@ -693,13 +688,18 @@ static int valid_pmbr(struct fdisk_context *cxt)
 			 */
 			part = i;
 			ret = GPT_MBR_PROTECTIVE;
-			goto check_hybrid;
+			break;
 		}
 	}
 
 	if (ret != GPT_MBR_PROTECTIVE)
 		goto done;
-check_hybrid:
+
+	/* LBA of the GPT partition header */
+	if (pmbr->partition_record[part].starting_lba !=
+	    cpu_to_le32(GPT_PRIMARY_PARTITION_TABLE_LBA))
+		goto done;
+
 	for (i = 0 ; i < 4; i++) {
 		if ((pmbr->partition_record[i].os_type != EFI_PMBR_OSTYPE) &&
 		    (pmbr->partition_record[i].os_type != 0x00))
-- 
2.0.5

