Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:51315 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbeIZErQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 26 Sep 2018 00:47:16 -0400
Received: from adsiz.fritz.box ([95.90.40.253]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LoKHN-1fY33D0gC9-00gF0Q for
 <util-linux@vger.kernel.org>; Wed, 26 Sep 2018 00:37:30 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] libfdisk: fix OSX compiler warning
Date: Wed, 26 Sep 2018 00:37:28 +0200
Message-Id: <20180925223729.28934-2-sweet_f_a@gmx.de>
In-Reply-To: <20180925223729.28934-1-sweet_f_a@gmx.de>
References: <20180925223729.28934-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

libfdisk/src/context.c:1354:54: error: unused parameter 'cxt' [-Werror,-Wunused-parameter]
const char *fdisk_get_devmodel(struct fdisk_context *cxt)

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libfdisk/src/context.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/libfdisk/src/context.c b/libfdisk/src/context.c
index ad5f99de4..18ebeba18 100644
--- a/libfdisk/src/context.c
+++ b/libfdisk/src/context.c
@@ -1351,9 +1351,9 @@ dev_t fdisk_get_devno(struct fdisk_context *cxt)
  *
  * Returns: device model string or NULL.
  */
+#ifdef __linux__
 const char *fdisk_get_devmodel(struct fdisk_context *cxt)
 {
-#ifdef __linux__
 	assert(cxt);
 
 	if (cxt->dev_model_probed)
@@ -1369,11 +1369,13 @@ const char *fdisk_get_devmodel(struct fdisk_context *cxt)
 	}
 	cxt->dev_model_probed = 1;
 	return cxt->dev_model;
+}
 #else
+const char *fdisk_get_devmodel(struct fdisk_context *cxt __attribute__((__unused__)))
+{
 	return NULL;
-#endif
-
 }
+#endif
 
 /**
  * fdisk_get_devfd:
-- 
2.13.7
