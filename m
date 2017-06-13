Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:50112 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753430AbdFMPc6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 13 Jun 2017 11:32:58 -0400
Received: from adsiz.fritz.box ([146.52.24.88]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJFBe-1dNYxq20L4-002lFE for
 <util-linux@vger.kernel.org>; Tue, 13 Jun 2017 17:32:36 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/5] libfdisk: cleanup sun label checksum usuage
Date: Tue, 13 Jun 2017 17:32:31 +0200
Message-Id: <20170613153235.11164-2-sweet_f_a@gmx.de>
In-Reply-To: <20170613153235.11164-1-sweet_f_a@gmx.de>
References: <20170613153235.11164-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

We are using now the formerly unused function sun_pt_checksum(). This
cleanup was motivated by clang compiler warning, see below. Also nice
that we are now always using uint16_t instead of short.

Warning was:

../libfdisk/src/sun.c:177:35: warning: taking address of packed member 'csum' of class or structure 'sun_disklabel' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
                while(ush < (unsigned short *)(&sunlabel->csum))

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 include/pt-sun.h   |  2 +-
 libfdisk/src/sun.c | 33 +++++++--------------------------
 2 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/include/pt-sun.h b/include/pt-sun.h
index b085268ca..e6a4ed13f 100644
--- a/include/pt-sun.h
+++ b/include/pt-sun.h
@@ -76,7 +76,7 @@ struct sun_disklabel {
 #define SUN_FLAG_UNMNT		0x01	/* Unmountable partition*/
 #define SUN_FLAG_RONLY		0x10	/* Read only		*/
 
-static inline uint16_t sun_pt_checksum(struct sun_disklabel *label)
+static inline uint16_t sun_pt_checksum(const struct sun_disklabel *label)
 {
 	uint16_t *ptr = ((uint16_t *) (label + 1)) - 1;
 	uint16_t sum;
diff --git a/libfdisk/src/sun.c b/libfdisk/src/sun.c
index a3a5b401e..0526227ce 100644
--- a/libfdisk/src/sun.c
+++ b/libfdisk/src/sun.c
@@ -110,8 +110,6 @@ static int sun_probe_label(struct fdisk_context *cxt)
 {
 	struct fdisk_sun_label *sun;
 	struct sun_disklabel *sunlabel;
-	unsigned short *ush;
-	int csum;
 	int need_fixing = 0;
 
 	assert(cxt);
@@ -128,11 +126,7 @@ static int sun_probe_label(struct fdisk_context *cxt)
 		return 0;		/* failed */
 	}
 
-	ush = ((unsigned short *) (sunlabel + 1)) - 1;
-	for (csum = 0; ush >= (unsigned short *)sunlabel;)
-		csum ^= *ush--;
-
-	if (csum) {
+	if (sun_pt_checksum(sunlabel)) {
 		fdisk_warnx(cxt, _("Detected sun disklabel with wrong checksum. "
 			      "Probably you'll have to set all the values, "
 			      "e.g. heads, sectors, cylinders and partitions "
@@ -171,12 +165,8 @@ static int sun_probe_label(struct fdisk_context *cxt)
 		sunlabel->vtoc.version = cpu_to_be32(SUN_VTOC_VERSION);
 		sunlabel->vtoc.sanity = cpu_to_be32(SUN_VTOC_SANITY);
 		sunlabel->vtoc.nparts = cpu_to_be16(SUN_MAXPARTITIONS);
-
-		ush = (unsigned short *)sunlabel;
-		csum = 0;
-		while(ush < (unsigned short *)(&sunlabel->csum))
-			csum ^= *ush++;
-		sunlabel->csum = csum;
+		sunlabel->csum = 0;
+		sunlabel->csum = sun_pt_checksum(sunlabel);
 
 		fdisk_label_set_changed(cxt->label, 1);
 	}
@@ -286,13 +276,8 @@ static int sun_create_disklabel(struct fdisk_context *cxt)
 			  SUN_TAG_WHOLEDISK);
 	}
 
-	{
-		unsigned short *ush = (unsigned short *)sunlabel;
-		unsigned short csum = 0;
-		while(ush < (unsigned short *)(&sunlabel->csum))
-			csum ^= *ush++;
-		sunlabel->csum = csum;
-	}
+	sunlabel->csum = 0;
+	sunlabel->csum = sun_pt_checksum(sunlabel);
 
 	fdisk_label_set_changed(cxt->label, 1);
 	cxt->label->nparts_cur = count_used_partitions(cxt);
@@ -979,8 +964,6 @@ int fdisk_sun_set_pcylcount(struct fdisk_context *cxt)
 static int sun_write_disklabel(struct fdisk_context *cxt)
 {
 	struct sun_disklabel *sunlabel;
-	unsigned short *ush;
-	unsigned short csum = 0;
 	const size_t sz = sizeof(struct sun_disklabel);
 
 	assert(cxt);
@@ -999,11 +982,9 @@ static int sun_write_disklabel(struct fdisk_context *cxt)
 		sunlabel->ncyl = a - b;
 	}
 
-	ush = (unsigned short *) sunlabel;
+	sunlabel->csum = 0;
+	sunlabel->csum = sun_pt_checksum(sunlabel);
 
-	while(ush < (unsigned short *)(&sunlabel->csum))
-		csum ^= *ush++;
-	sunlabel->csum = csum;
 	if (lseek(cxt->dev_fd, 0, SEEK_SET) < 0)
 		return -errno;
 	if (write_all(cxt->dev_fd, sunlabel, sz) != 0)
-- 
2.12.3

