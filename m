Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lf0-f67.google.com ([209.85.215.67]:50328 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbdKIDcW (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 8 Nov 2017 22:32:22 -0500
Received: by mail-lf0-f67.google.com with SMTP id a132so5550491lfa.7
        for <util-linux@vger.kernel.org>; Wed, 08 Nov 2017 19:32:21 -0800 (PST)
Received: from [10.4.30.50] (wifi.cs.msu.ru. [188.44.42.48])
        by smtp.googlemail.com with ESMTPSA id z17sm960580lfi.82.2017.11.08.19.32.19
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Nov 2017 19:32:19 -0800 (PST)
To: util-linux@vger.kernel.org
From: Mikhail Vorobyov <vorobyov.mikhail@gmail.com>
Subject: [PATCH 1/2] libfdisk: (sun) move aligning of the first sector before
 availability check
Message-ID: <2cdd22e9-0767-372b-bd14-bb6084266cb0@gmail.com>
Date: Thu, 9 Nov 2017 06:32:18 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
