Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.cs.msu.ru ([188.44.42.39]:62517 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751550AbdKIDhb (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 8 Nov 2017 22:37:31 -0500
Received: from [10.4.30.50] (port=34758)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89 (FreeBSD))
        (envelope-from <m.vorobyov@cs.msu.ru>)
        id 1eCdej-0009x1-1f
        for util-linux@vger.kernel.org; Thu, 09 Nov 2017 06:37:29 +0300
To: util-linux@vger.kernel.org
From: Mikhail Vorobyov <m.vorobyov@cs.msu.ru>
Message-ID: <adcf7175-1dff-231d-46fd-bc146c114317@cs.msu.ru>
Date: Thu, 9 Nov 2017 06:37:28 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH v2 1/2] libfdisk: (sun) move aligning of the first sector
 before availability check
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

So it will check a sector which would be actualy used as the first sector
of the partition.
---
 libfdisk/src/sun.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/libfdisk/src/sun.c b/libfdisk/src/sun.c
index d10fea0d7..7ffd364f4 100644
--- a/libfdisk/src/sun.c
+++ b/libfdisk/src/sun.c
@@ -566,6 +566,19 @@ static int sun_add_partition(
 			if (fdisk_use_cylinders(cxt))
 				first *= fdisk_get_units_per_sector(cxt);
 
+			if (!fdisk_use_cylinders(cxt)) {
+				/* Starting sector has to be properly aligned */
+				int cs = cxt->geom.heads * cxt->geom.sectors;
+				int x = first % cs;
+
+				if (x) {
+					fdisk_info(cxt, _("Aligning the first sector from %u to %u "
+							  "to be on cylinder boundary."),
+							first, first + cs - x);
+					first += cs - x;
+				}
+			}
+
 			/* ewt asks to add: "don't start a partition at cyl 0"
 			   However, edmundo@rano.demon.co.uk writes:
 			   "In addition to having a Sun partition table, to be able to
@@ -593,20 +606,6 @@ static int sun_add_partition(
 		}
 	}
 
-
-	if (!fdisk_use_cylinders(cxt)) {
-		/* Starting sector has to be properly aligned */
-		int cs = cxt->geom.heads * cxt->geom.sectors;
-		int x = first % cs;
-
-		if (x) {
-			fdisk_info(cxt, _("Aligning the first sector from %u to %u "
-					  "to be on cylinder boundary."),
-					first, first + cs - x);
-			first += cs - x;
-		}
-	}
-
 	stop = cxt->geom.cylinders * cxt->geom.heads * cxt->geom.sectors;	/* ancient */
 	stop2 = stop;
 	for (i = 0; i < cxt->label->nparts_max; i++) {
-- 
2.13.6
