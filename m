Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:50366 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691Ab3FGQo1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 7 Jun 2013 12:44:27 -0400
Received: by mail-wi0-f171.google.com with SMTP id hm9so1537642wib.4
        for <util-linux@vger.kernel.org>; Fri, 07 Jun 2013 09:44:26 -0700 (PDT)
Received: from ?IPv6:2a01:e35:8a2c:b230:c963:a32b:eca6:2292? ([2a01:e35:8a2c:b230:c963:a32b:eca6:2292])
        by mx.google.com with ESMTPSA id e5sm23613745wiy.5.2013.06.07.09.44.25
        for <util-linux@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 09:44:26 -0700 (PDT)
Message-ID: <51B20DE8.7090701@gmail.com>
Date: Fri, 07 Jun 2013 18:44:24 +0200
From: Gabriel de Perthuis <g2p.code@gmail.com>
MIME-Version: 1.0
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH v2] libblkid: print PTUUID, the partition table uuid
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Gabriel de Perthuis <g2p.code@gmail.com>
---
v2: only enable this for GPT, dos ids are too weak and not unique

 libblkid/src/partitions/gpt.c        |  8 ++++----
 libblkid/src/partitions/partitions.c | 14 +++++++++++---
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/libblkid/src/partitions/gpt.c b/libblkid/src/partitions/gpt.c
index 4441939..87b5ff6 100644
--- a/libblkid/src/partitions/gpt.c
+++ b/libblkid/src/partitions/gpt.c
@@ -320,14 +320,10 @@ static int probe_gpt_pt(blkid_probe pr,
 	if (blkid_probe_set_magic(pr, lba << 9,
 			      sizeof(GPT_HEADER_SIGNATURE_STR) - 1,
 			      (unsigned char *) GPT_HEADER_SIGNATURE_STR))
 		goto err;
 
-	if (blkid_partitions_need_typeonly(pr))
-		/* caller does not ask for details about partitions */
-		return 0;
-
 	ls = blkid_probe_get_partlist(pr);
 	if (!ls)
 		goto err;
 
 	tab = blkid_partlist_new_parttable(ls, "gpt", lba << 9);
@@ -336,10 +332,14 @@ static int probe_gpt_pt(blkid_probe pr,
 
 	guid = h->disk_guid;
 	swap_efi_guid(&guid);
 	blkid_parttable_set_id(tab, (const unsigned char *) &guid);
 
+	if (blkid_partitions_need_typeonly(pr))
+		/* caller does not ask for details about partitions */
+		return 0;
+
 	ssf = blkid_probe_get_sectorsize(pr) / 512;
 
 	fu = le64_to_cpu(h->first_usable_lba);
 	lu = le64_to_cpu(h->last_usable_lba);
 
diff --git a/libblkid/src/partitions/partitions.c b/libblkid/src/partitions/partitions.c
index 87ca0c1..f732527 100644
--- a/libblkid/src/partitions/partitions.c
+++ b/libblkid/src/partitions/partitions.c
@@ -35,10 +35,12 @@
  *
  * NAME=value interface, supported tags:
  *
  * @PTTYPE: partition table type (dos, gpt, etc.).
  *
+ * @PTUUID: partition table uuid (gpt only)
+ *
  * @PART_ENTRY_SCHEME: partition table type
  *
  * @PART_ENTRY_NAME: partition name (gpt and mac only)
  *
  * @PART_ENTRY_UUID: partition UUID (gpt only)
@@ -568,17 +570,18 @@ nothing:
  */
 static int partitions_probe(blkid_probe pr, struct blkid_chain *chn)
 {
 	int rc = 1;
 	size_t i;
+	blkid_partlist ls;
+	blkid_parttable pt;
 
 	if (!pr || chn->idx < -1)
 		return -1;
 	blkid_probe_chain_reset_vals(pr, chn);
 
-	if (chn->binary)
-		partitions_init_data(chn);
+	ls = partitions_init_data(chn);
 
 	if (!pr->wipe_size && (pr->prob_flags & BLKID_PROBE_FL_IGNORE_PT))
 		goto details_only;
 
 	DBG(LOWPROBE, blkid_debug("--> starting probing loop [PARTS idx=%d]",
@@ -600,14 +603,19 @@ static int partitions_probe(blkid_probe pr, struct blkid_chain *chn)
 			continue;
 
 		name = idinfos[i]->name;
 
 		/* all checks passed */
-		if (!chn->binary)
+		if (!chn->binary) {
 			blkid_probe_set_value(pr, "PTTYPE",
 						(unsigned char *) name,
 						strlen(name) + 1);
+			pt = blkid_partlist_get_table(ls);
+			if (pt && pt->id && strcmp(name, "gpt") == 0)
+				blkid_probe_set_value(pr, "PTUUID",
+						      pt->id, 37);
+		}
 		DBG(LOWPROBE, blkid_debug("<-- leaving probing loop (type=%s) [PARTS idx=%d]",
 			name, chn->idx));
 		rc = 0;
 		break;
 	}
-- 
1.8.3.222.g430da9e

