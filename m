Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:61932 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932716AbcCGXMH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Mar 2016 18:12:07 -0500
Received: from assos.lan ([84.185.129.97]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MIuSH-1ab8Vp3nxJ-002VCZ for
 <util-linux@vger.kernel.org>; Tue, 08 Mar 2016 00:12:04 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 05/12] libfdisk: remove ifdef HDIO_GETGEO
Date: Tue,  8 Mar 2016 00:11:55 +0100
Message-Id: <1457392322-4974-6-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
References: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

We don't use HDIO_GETGEO since e5b5a349.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libfdisk/src/sgi.c | 3 +--
 libfdisk/src/sun.c | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/libfdisk/src/sgi.c b/libfdisk/src/sgi.c
index 6228cf8..c77724a 100644
--- a/libfdisk/src/sgi.c
+++ b/libfdisk/src/sgi.c
@@ -968,7 +968,6 @@ static int sgi_create_disklabel(struct fdisk_context *cxt)
 	assert(cxt->label);
 	assert(fdisk_is_label(cxt, SGI));
 
-#ifdef HDIO_GETGEO
 	if (cxt->geom.heads && cxt->geom.sectors) {
 		fdisk_sector_t llsectors;
 
@@ -990,7 +989,7 @@ static int sgi_create_disklabel(struct fdisk_context *cxt)
 				  "> 33.8 GB."), cxt->dev_path, cxt->geom.cylinders);
 		}
 	}
-#endif
+
 	rc = fdisk_init_firstsector_buffer(cxt, 0, 0);
 	if (rc)
 		return rc;
diff --git a/libfdisk/src/sun.c b/libfdisk/src/sun.c
index a50076a..a97ecac 100644
--- a/libfdisk/src/sun.c
+++ b/libfdisk/src/sun.c
@@ -225,7 +225,6 @@ static int sun_create_disklabel(struct fdisk_context *cxt)
 	sunlabel->vtoc.sanity = cpu_to_be32(SUN_VTOC_SANITY);
 	sunlabel->vtoc.nparts = cpu_to_be16(SUN_MAXPARTITIONS);
 
-#ifdef HDIO_GETGEO
 	if (cxt->geom.heads && cxt->geom.sectors) {
 		fdisk_sector_t llsectors;
 
@@ -246,7 +245,6 @@ static int sun_create_disklabel(struct fdisk_context *cxt)
 				cxt->dev_path, cxt->geom.cylinders);
 		}
 	} else
-#endif
 		ask_geom(cxt);
 
 	sunlabel->acyl   = cpu_to_be16(0);
-- 
1.9.1

