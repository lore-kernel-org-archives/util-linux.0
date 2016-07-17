Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35624 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbcGQNA2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Jul 2016 09:00:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so8763440wmg.2
        for <util-linux@vger.kernel.org>; Sun, 17 Jul 2016 06:00:27 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 03/13] libfdisk: collapse indentation [oclint]
Date: Sun, 17 Jul 2016 14:00:05 +0100
Message-Id: <20160717130015.31760-4-kerolasa@iki.fi>
In-Reply-To: <20160717130015.31760-1-kerolasa@iki.fi>
References: <20160717130015.31760-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Move conditionals to be together to avoid code blocks that are length of
full logical segment.  This allows fewer indentation steps, and improves
general readability.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libfdisk/src/sun.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/libfdisk/src/sun.c b/libfdisk/src/sun.c
index 55ec877..902596e 100644
--- a/libfdisk/src/sun.c
+++ b/libfdisk/src/sun.c
@@ -399,7 +399,8 @@ static int verify_sun_cmp(int *a, int *b, void *data)
 static int sun_verify_disklabel(struct fdisk_context *cxt)
 {
     uint32_t starts[SUN_MAXPARTITIONS], lens[SUN_MAXPARTITIONS], start, stop;
-    uint32_t i,j,k,starto,endo;
+    uint32_t i, j, k, starto, endo;
+
 #ifdef HAVE_QSORT_R
     int array[SUN_MAXPARTITIONS];
     unsigned int *verify_sun_starts;
@@ -413,30 +414,29 @@ static int sun_verify_disklabel(struct fdisk_context *cxt)
     for (k = 0; k < 7; k++) {
 	for (i = 0; i < SUN_MAXPARTITIONS; i++) {
 	    if (k && (lens[i] % (cxt->geom.heads * cxt->geom.sectors)))
-	        fdisk_warnx(cxt, _("Partition %u doesn't end on cylinder boundary."), i+1);
+		fdisk_warnx(cxt, _("Partition %u doesn't end on cylinder boundary."), i + 1);
 	    if (lens[i]) {
-	        for (j = 0; j < i; j++)
-	            if (lens[j]) {
-	                if (starts[j] == starts[i]+lens[i]) {
-	                    starts[j] = starts[i]; lens[j] += lens[i];
-	                    lens[i] = 0;
-	                } else if (starts[i] == starts[j]+lens[j]){
-	                    lens[j] += lens[i];
-	                    lens[i] = 0;
-	                } else if (!k) {
-	                    if (starts[i] < starts[j]+lens[j] &&
-				starts[j] < starts[i]+lens[i]) {
-	                        starto = starts[i];
-	                        if (starts[j] > starto)
-					starto = starts[j];
-	                        endo = starts[i]+lens[i];
-	                        if (starts[j]+lens[j] < endo)
-					endo = starts[j]+lens[j];
-	                        fdisk_warnx(cxt, _("Partition %u overlaps with others in "
-				       "sectors %u-%u."), i+1, starto, endo);
-	                    }
-	                }
-	            }
+		for (j = 0; j < i && lens[j]; j++)
+		    if (starts[j] == starts[i] + lens[i]) {
+			starts[j] = starts[i];
+			lens[j] += lens[i];
+			lens[i] = 0;
+		    } else if (starts[i] == starts[j] + lens[j]) {
+			lens[j] += lens[i];
+			lens[i] = 0;
+		    } else if (!k &&
+			       starts[i] < starts[j] + lens[j] &&
+			       starts[j] < starts[i] + lens[i]) {
+			starto = starts[i];
+			if (starts[j] > starto)
+			    starto = starts[j];
+			endo = starts[i] + lens[i];
+			if (starts[j] + lens[j] < endo)
+			    endo = starts[j] + lens[j];
+			fdisk_warnx(cxt,
+				    _("Partition %u overlaps with others in "
+				      "sectors %u-%u."), i + 1, starto, endo);
+		    }
 	    }
 	}
     }
-- 
2.9.0

