Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:60954 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752107AbdFLIuB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 12 Jun 2017 04:50:01 -0400
Received: from adsiz.fritz.box ([146.52.24.88]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKLeM-1dIgcL49bC-001jDo for
 <util-linux@vger.kernel.org>; Mon, 12 Jun 2017 10:50:00 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 6/6] libblkid: fix gcc-7 warning -Wint-in-bool-context
Date: Mon, 12 Jun 2017 10:49:58 +0200
Message-Id: <20170612084958.22054-7-sweet_f_a@gmx.de>
In-Reply-To: <20170612084958.22054-1-sweet_f_a@gmx.de>
References: <20170612084958.22054-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

BLOCK_SIZE(sb) should be unsigned so that the left shift is defined.

This was the warning:

../libblkid/src/superblocks/exfat.c: In function 'probe_exfat':
../libblkid/src/superblocks/exfat.c:40:42: warning: '<<' in boolean context, did you mean '<' ? [-Wint-in-bool-context]
 #define CLUSTER_SIZE(sb) (BLOCK_SIZE(sb) << (sb)->bpc_bits)
                          ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
../libblkid/src/superblocks/exfat.c:122:14: note: in expansion of macro 'CLUSTER_SIZE'
  if (!sb || !CLUSTER_SIZE(sb))
              ^~~~~~~~~~~~

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libblkid/src/superblocks/exfat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libblkid/src/superblocks/exfat.c b/libblkid/src/superblocks/exfat.c
index 659e196c2..f5a22ee81 100644
--- a/libblkid/src/superblocks/exfat.c
+++ b/libblkid/src/superblocks/exfat.c
@@ -36,8 +36,8 @@ struct exfat_entry_label {
 	uint8_t name[30];
 } __attribute__((__packed__));
 
-#define BLOCK_SIZE(sb) (1 << (sb)->block_bits)
-#define CLUSTER_SIZE(sb) (BLOCK_SIZE(sb) << (sb)->bpc_bits)
+#define BLOCK_SIZE(sb) (1u << (sb)->block_bits)
+#define CLUSTER_SIZE(sb) ((BLOCK_SIZE(sb) << (sb)->bpc_bits))
 #define EXFAT_FIRST_DATA_CLUSTER 2
 #define EXFAT_LAST_DATA_CLUSTER 0xffffff6
 #define EXFAT_ENTRY_SIZE 32
-- 
2.12.3

