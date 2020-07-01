Return-Path: <SRS0=4DiG=AM=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D309CC433DF
	for <util-linux@archiver.kernel.org>; Wed,  1 Jul 2020 11:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE1CA20760
	for <util-linux@archiver.kernel.org>; Wed,  1 Jul 2020 11:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DNx86Ysq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgGALd3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Jul 2020 07:33:29 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:52134 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730196AbgGALd3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Jul 2020 07:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593603210; x=1625139210;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w3ed1Y+K+DO6dmEgNTmxvSbcQOrEbJNzkuT0U257YRM=;
  b=DNx86YsqbQNfa+EyHkjX2029NTyU7iXeMZ7Z4lDFxEJ3d3K4nMeqPkxH
   BXuuffvj0eK35wx41H3Hc4woTw7V3ynRFYFJH+pPxv5Byx+F5qRQ+zT8/
   v/vX2KKqpM2XJrwF3dGupw8aFtnixIwFBhhfhhvx4YwmYLXt68BmsqEf8
   GwRDYHpZT2WDPvVrav3K56khufAecUP2yEUmk+g83rVuIfaxDLtva7U3J
   sQhbUPTnKFLsEOZcjFoNjAuV4M2G45BGt+IfLztZzLw3obx9v3qf6XgDC
   dTfmf1piE11KE4Ji2G5TWnhEsh43LHEaGMcONkPf+90/IMYvhvACQgt1K
   w==;
IronPort-SDR: AuyYZQa9ZTo0ZBZCRItByG2E51agEuzmJ5H6gvjJXdZ+SX/c9IoJ8bqXDEw6xDYOshIE1sSHeN
 Z6F/3E23UriAQLSuZ+EM14NUK2y6HtTiNC6795ZwrWAQUFiQ/lWvkP+M4uIdTY0H3KqKidNl3T
 BOqjWnVbOxuSBpisP6y2AQGBM9ji8w0pgCMl4+ezJ7X8dqcwZSJzraqz4Mco/TUdxNBSYh+sWs
 BHqCQcMXxrCuGY+csmwMzuxDAuiSC9ay3HlRNwByJD2drSVgJ7QMIc27+Zht9U2+GnQ4xowoqX
 tvc=
X-IronPort-AV: E=Sophos;i="5.75,300,1589212800"; 
   d="scan'208";a="141576118"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 19:33:29 +0800
IronPort-SDR: AR5iZf5Zzjx3ojCi+IfJAZ1oL9Qp9JpZ0PJ4X68uBDxJbB4ZZV32RkirLCsMLeC8GTSjwlUGzk
 vo1t8Vcud7P2WUuvoYyuMtF4FVKXWRQrc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 04:22:18 -0700
IronPort-SDR: fYsvEdZ4xBbFPaYDHFUlauugzbAjHgtNc3ao/1wZ/cjdFbjwLopxiZwVyPS2LcqWVDJqJ8IZ+n
 gWoqRtRGHvRA==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.87])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Jul 2020 04:33:27 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Cc:     Hans Holmberg <hans.holmberg@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] blkzone: add capacity field to zone report
Date:   Wed,  1 Jul 2020 20:33:26 +0900
Message-Id: <20200701113326.153550-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

NVMe ZNS specification defines zone capacity. The report zone interface
of Linux kernel supports it. Expose it in report zone by blkzone command.

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

