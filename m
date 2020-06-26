Return-Path: <SRS0=6mcD=AH=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B3BC433DF
	for <util-linux@archiver.kernel.org>; Fri, 26 Jun 2020 12:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AC3320775
	for <util-linux@archiver.kernel.org>; Fri, 26 Jun 2020 12:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oNCbPUKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgFZMM2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:12:28 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:21889 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgFZMM1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 26 Jun 2020 08:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593173548; x=1624709548;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sggDT4on9l/MdfraCRu5Ra47ysvvZbgijt/BnB0IKow=;
  b=oNCbPUKYCiVcq+O3//ffTFtR/t5gBo36wqMXg+DGRhrI+VRNL1LlENuU
   qY+5Vzzn0VZhgQu+qwfeR7R7kAi1Ox6A2NXYIU7dFfMDvsgypBueIehET
   ysee9AHTRXzxHIGilLY7FKS538UgFtfz+EsZWOE/V7PzMZ+sH3c1CaSQ6
   hc8v+Ic+frY9xPy+bHcrRp7h61hs+ozRlT74Yc9YhiITM1XGbtUxj1C6F
   VXsZFWa4/dMqdOLAnbvE28xndDddgvMrBf7rcwTtGTDl1jhG3tNQBibd8
   bkBgJ0eLZ+s24GZP5+FDxRk3ZVo/Gr3/hYcgYwWwpcUOKIXrpQa5dsMxy
   w==;
IronPort-SDR: bvMu8MkzRqJakPyTLUcSbGBoxx1xBFJ5ICw/reKheFCysv5lpdWprHA+7mq5DYMYqKhgriKuDb
 LaHgs1tb9dMN9R8V5X/BHvvOQ0lTutmtdTiuRu0/yy4klWGFNNoqEdRUm3izDY46V1oAz6ErsN
 jFKhmZ1T4/Dnb/wo5nd+DYoRfpi/eAMTboYC/K3yc5rBhVbEO9IJBPPIGhQiUpsUnTEL5qj7fr
 Qwrr3fSrD7Im0MXc7qw/q5bFh4TmFJPwkByhLwHvo6p5My53kIzv2FD3p7SnYDI4wybZgjWl0T
 NuI=
X-IronPort-AV: E=Sophos;i="5.75,283,1589212800"; 
   d="scan'208";a="141230621"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 20:12:28 +0800
IronPort-SDR: Qv+NWHeuONPvEbgS6sWH2TqkpgVJkQVMBUs5/rFA/z6p8yubXdp9282jO34gZtH8DX/74oaVdG
 fodGSrZ5lFfqQH5Nfakxrj2/Tlty/0ryk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 05:01:25 -0700
IronPort-SDR: O+zOiUj4vjeVHU+zE3/dWBjQWh0Fka0F8vb5EDtzj+lXVxGpImWSHVhO7KcTdeYSltbLS7BMn7
 CjyfBCiaGULw==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.87])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 05:12:26 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Cc:     Hans Holmberg <hans.holmberg@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH RFC] blkzone: add capacity field to zone report
Date:   Fri, 26 Jun 2020 21:12:25 +0900
Message-Id: <20200626121225.428611-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

NVMe ZNS specification defines zone capacity. To support it in the
report zone interface, Linux kernel side patch review is ongoing. [1]
Expose it in report zone by blkzone command.

[1] https://www.spinics.net/lists/linux-block/msg55494.html

Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 configure.ac        |  4 ++++
 sys-utils/blkzone.8 |  1 +
 sys-utils/blkzone.c | 20 ++++++++++++++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index e31dc3767..f3e9f5d0d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -322,6 +322,10 @@ AC_CHECK_HEADERS([security/pam_misc.h],
 
 AC_CHECK_HEADERS([linux/blkzoned.h])
 
+AC_CHECK_DECLS([BLK_ZONE_REP_CAPACITY], [], [], [
+	#include <linux/blkzoned.h>
+])
+
 AC_CHECK_HEADERS([security/openpam.h], [], [], [
 #ifdef HAVE_SECURITY_PAM_APPL_H
 #include <security/pam_appl.h>
diff --git a/sys-utils/blkzone.8 b/sys-utils/blkzone.8
index 64ad23bb3..043bc96e2 100644
--- a/sys-utils/blkzone.8
+++ b/sys-utils/blkzone.8
@@ -29,6 +29,7 @@ tab(:);
 l l.
 start:Zone start sector
 len:Zone length in number of sectors
+cap:Zone capacity in number of sectors
 wptr:Zone write pointer position
 reset:Reset write pointer recommended
 non-seq:Non-sequential write resources active
diff --git a/sys-utils/blkzone.c b/sys-utils/blkzone.c
index 11e90fb0e..0f62ca395 100644
--- a/sys-utils/blkzone.c
+++ b/sys-utils/blkzone.c
@@ -24,6 +24,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <stdint.h>
+#include <stdbool.h>
 #include <fcntl.h>
 #include <limits.h>
 #include <getopt.h>
@@ -189,6 +190,14 @@ done:
 	return rc == 0 ? sz : 0;
 }
 
+#if HAVE_DECL_BLK_ZONE_REP_CAPACITY
+#define has_zone_capacity(zi)	((zi)->flags & BLK_ZONE_REP_CAPACITY)
+#define zone_capacity(z)	(z)->capacity
+#else
+#define has_zone_capacity(zi)	(false)
+#define zone_capacity(z)	(z)->len
+#endif
+
 /*
  * blkzone report
  */
@@ -262,15 +271,22 @@ static int blkzone_report(struct blkzone_control *ctl)
 			uint64_t wp = entry->wp;
 			uint8_t cond = entry->cond;
 			uint64_t len = entry->len;
+			uint64_t cap;
 
 			if (!len) {
 				nr_zones = 0;
 				break;
 			}
 
-			printf(_("  start: 0x%09"PRIx64", len 0x%06"PRIx64", wptr 0x%06"PRIx64
+			if (has_zone_capacity(zi))
+				cap = zone_capacity(entry);
+			else
+				cap = entry->len;
+
+			printf(_("  start: 0x%09"PRIx64", len 0x%06"PRIx64
+				", cap 0x%06"PRIx64", wptr 0x%06"PRIx64
 				" reset:%u non-seq:%u, zcond:%2u(%s) [type: %u(%s)]\n"),
-				start, len, (type == 0x1) ? 0 : wp - start,
+				start, len, cap, (type == 0x1) ? 0 : wp - start,
 				entry->reset, entry->non_seq,
 				cond, condition_str[cond & (ARRAY_SIZE(condition_str) - 1)],
 				type, type_text[type]);
-- 
2.26.2

