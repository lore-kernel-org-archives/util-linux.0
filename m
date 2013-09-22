Return-Path: util-linux-owner@vger.kernel.org
Received: from g4t0014.houston.hp.com ([15.201.24.17]:31861 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615Ab3IVDpU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 21 Sep 2013 23:45:20 -0400
From: Davidlohr Bueso <davidlohr@hp.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Davidlohr Bueso <davidlohr@hp.com>
Subject: [PATCH 3/3] libfdisk: gpt: loosen check fot pmbr size in lba
Date: Sat, 21 Sep 2013 20:45:16 -0700
Message-Id: <1379821516-2540-3-git-send-email-davidlohr@hp.com>
In-Reply-To: <1379821516-2540-1-git-send-email-davidlohr@hp.com>
References: <1379821516-2540-1-git-send-email-davidlohr@hp.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

While most disk partitioning tools out there create a pMBR's size in lba
to be the lesser of the whole disk or 2Tib, Microsoft apparently does not[1].
It always sets the entry to the maximum 32-bit limitation - even though a
drive may be smaller than that.

Loosen this check and only verify that the size is either the whole disk
or 0xFFFFFFFF.  No tool in its right mind would set it to any value
other than these.

[1] http://thestarman.pcministry.com/asm/mbr/GPT.htm#GPTPT

Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
---
 libfdisk/src/gpt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index bb9e9a7..83659cb 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -477,6 +477,7 @@ static int valid_pmbr(struct fdisk_context *cxt)
 {
 	int i, part = 0, ret = 0; /* invalid by default */
 	struct gpt_legacy_mbr *pmbr = NULL;
+	uint32_t sz_lba = 0;
 
 	if (!cxt->firstsector)
 		goto done;
@@ -517,12 +518,15 @@ check_hybrid:
 	/*
 	 * Protective MBRs take up the lesser of the whole disk
 	 * or 2 TiB (32bit LBA), ignoring the rest of the disk.
+	 * Some partitioning programs, nonetheless, choose to set
+	 * the size to the maximum 32-bit limitation, disregarding
+	 * the disk size.
 	 *
 	 * Hybrid MBRs do not necessarily comply with this.
 	 */
 	if (ret == GPT_MBR_PROTECTIVE) {
-		if (le32_to_cpu(pmbr->partition_record[part].size_in_lba) !=
-		    min((uint32_t) cxt->total_sectors - 1, 0xFFFFFFFF))
+		sz_lba = le32_to_cpu(pmbr->partition_record[part].size_in_lba);
+		if (sz_lba != (uint32_t) cxt->total_sectors - 1 && sz_lba != 0xFFFFFFFF)
 			ret = 0;
 	}
 done:
-- 
1.7.11.7

