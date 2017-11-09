Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.cs.msu.ru ([188.44.42.39]:60575 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751705AbdKIDrS (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 8 Nov 2017 22:47:18 -0500
Received: from [10.4.30.50] (port=34820)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89 (FreeBSD))
        (envelope-from <m.vorobyov@cs.msu.ru>)
        id 1eCdoC-000HQd-NZ
        for util-linux@vger.kernel.org; Thu, 09 Nov 2017 06:47:16 +0300
To: util-linux@vger.kernel.org
From: Mikhail Vorobyov <m.vorobyov@cs.msu.ru>
Message-ID: <a3e17905-347c-2561-d6e2-35dc8814b0a1@cs.msu.ru>
Date: Thu, 9 Nov 2017 06:47:16 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH v2 2/2] libfdisk: (sun) enhance searching of free space
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Potential partition start should be aligned to cylinders. So fdisk
wouldn't consider partition's last cylinder remains as eligible space
for new partition start.
---
 libfdisk/src/sun.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/libfdisk/src/sun.c b/libfdisk/src/sun.c
index 7ffd364f4..923b73e32 100644
--- a/libfdisk/src/sun.c
+++ b/libfdisk/src/sun.c
@@ -326,6 +326,7 @@ static void fetch_sun(struct fdisk_context *cxt,
 	struct sun_disklabel *sunlabel;
 	int continuous = 1;
 	size_t i;
+	int sectors_per_cylinder = cxt->geom.heads * cxt->geom.sectors;
 
 	assert(cxt);
 	assert(cxt);
@@ -335,7 +336,7 @@ static void fetch_sun(struct fdisk_context *cxt,
 	sunlabel = self_disklabel(cxt);
 
 	*start = 0;
-	*stop = cxt->geom.cylinders * cxt->geom.heads * cxt->geom.sectors;
+	*stop = cxt->geom.cylinders * sectors_per_cylinder;
 
 	for (i = 0; i < cxt->label->nparts_max; i++) {
 		struct sun_partition *part = &sunlabel->partitions[i];
@@ -345,12 +346,16 @@ static void fetch_sun(struct fdisk_context *cxt,
 		    be16_to_cpu(info->id) != SUN_TAG_UNASSIGNED &&
 		    be16_to_cpu(info->id) != SUN_TAG_WHOLEDISK) {
 			starts[i] = be32_to_cpu(part->start_cylinder) *
-				     cxt->geom.heads * cxt->geom.sectors;
+				     sectors_per_cylinder;
 			lens[i] = be32_to_cpu(part->num_sectors);
 			if (continuous) {
-				if (starts[i] == *start)
+				if (starts[i] == *start) {
 					*start += lens[i];
-				else if (starts[i] + lens[i] >= *stop)
+					int remained_sectors = *start % sectors_per_cylinder;
+					if (remained_sectors) {
+						*start += sectors_per_cylinder - remained_sectors;
+					}
+				} else if (starts[i] + lens[i] >= *stop)
 					*stop = starts[i];
 				else
 					continuous = 0;
-- 
2.13.6
