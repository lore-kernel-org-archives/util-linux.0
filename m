Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:33617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeIZErR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 26 Sep 2018 00:47:17 -0400
Received: from adsiz.fritz.box ([95.90.40.253]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LiWzQ-1fUUg21qW4-00ce6l for
 <util-linux@vger.kernel.org>; Wed, 26 Sep 2018 00:37:30 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] libfdisk: fix printf format modifier
Date: Wed, 26 Sep 2018 00:37:29 +0200
Message-Id: <20180925223729.28934-3-sweet_f_a@gmx.de>
In-Reply-To: <20180925223729.28934-1-sweet_f_a@gmx.de>
References: <20180925223729.28934-1-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

libfdisk/src/script.c: In function ‘fdisk_script_read_context’:
libfdisk/src/script.c:452:33: error: format ‘%zu’ expects argument of type ‘size_t’, but argument 4 has type ‘long unsigned int’ [-Werror=format=]
   snprintf(buf, sizeof(buf), "%zu", fdisk_get_grain_size(cxt));
                                 ^

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libfdisk/src/script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libfdisk/src/script.c b/libfdisk/src/script.c
index 24c40f8ce..e7cf1254e 100644
--- a/libfdisk/src/script.c
+++ b/libfdisk/src/script.c
@@ -449,7 +449,7 @@ int fdisk_script_read_context(struct fdisk_script *dp, struct fdisk_context *cxt
 	if (!rc && fdisk_get_grain_size(cxt) != 2048 * 512) {
 		char buf[64];
 
-		snprintf(buf, sizeof(buf), "%zu", fdisk_get_grain_size(cxt));
+		snprintf(buf, sizeof(buf), "%lu", fdisk_get_grain_size(cxt));
 		rc = fdisk_script_set_header(dp, "grain", buf);
 	}
 
-- 
2.13.7
