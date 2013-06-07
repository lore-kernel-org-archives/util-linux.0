Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f178.google.com ([74.125.82.178]:52342 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756778Ab3FGQO5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 7 Jun 2013 12:14:57 -0400
Received: by mail-we0-f178.google.com with SMTP id u53so3169947wes.23
        for <util-linux@vger.kernel.org>; Fri, 07 Jun 2013 09:14:56 -0700 (PDT)
Received: from ?IPv6:2a01:e35:8a2c:b230:c963:a32b:eca6:2292? ([2a01:e35:8a2c:b230:c963:a32b:eca6:2292])
        by mx.google.com with ESMTPSA id x13sm23481701wib.3.2013.06.07.09.14.54
        for <util-linux@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 09:14:55 -0700 (PDT)
Message-ID: <51B206FD.9060509@gmail.com>
Date: Fri, 07 Jun 2013 18:14:53 +0200
From: Gabriel de Perthuis <g2p.code@gmail.com>
MIME-Version: 1.0
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] libblkid: print PTUUID, the partition table uuid
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Gabriel de Perthuis <g2p.code@gmail.com>
---
 libblkid/src/partitions/dos.c        | 14 +++++++-------
 libblkid/src/partitions/gpt.c        |  8 ++++----
 libblkid/src/partitions/partitions.c | 14 +++++++++++---
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/libblkid/src/partitions/dos.c b/libblkid/src/partitions/dos.c
index 3a0a6d7..88db895 100644
--- a/libblkid/src/partitions/dos.c
+++ b/libblkid/src/partitions/dos.c
@@ -179,17 +179,10 @@ static int probe_dos_pt(blkid_probe pr,
 	}
 
 	blkid_probe_use_wiper(pr, BLKID_MSDOS_PT_OFFSET,
 				  512 - BLKID_MSDOS_PT_OFFSET);
 
-	/*
-	 * Well, all checks pass, it's MS-DOS partiton table
-	 */
-	if (blkid_partitions_need_typeonly(pr))
-		/* caller does not ask for details about partitions */
-		return 0;
-
 	ls = blkid_probe_get_partlist(pr);
 
 	/* sector size factor (the start and size are in the real sectors, but
 	 * we need to convert all sizes to 512 logical sectors
 	 */
@@ -206,10 +199,17 @@ static int probe_dos_pt(blkid_probe pr,
 
 		snprintf(buf, sizeof(buf), "0x%08x", id);
 		blkid_parttable_set_id(tab, (unsigned char *) buf);
 	}
 
+	/*
+	 * Well, all checks pass, it's MS-DOS partiton table
+	 */
+	if (blkid_partitions_need_typeonly(pr))
+		/* caller does not ask for details about partitions */
+		return 0;
+
 
 	/* Parse primary partitions */
 	for (p = p0, i = 0; i < 4; i++, p++) {
 		blkid_partition par;
 
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
index 87ca0c1..b3e97d9 100644
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
+			if (pt && pt->id)
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

