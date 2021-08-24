Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E80C4320A
	for <util-linux@archiver.kernel.org>; Tue, 24 Aug 2021 01:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C726138B
	for <util-linux@archiver.kernel.org>; Tue, 24 Aug 2021 01:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhHXBSL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 23 Aug 2021 21:18:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:10631 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhHXBSL (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 23 Aug 2021 21:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629767847; x=1661303847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=slvoiQEkIQlePo6uRWoj2EWV3plWRvddqyNu6U2jlSA=;
  b=ipsRET4ymbcBX3FtDn7zzUQa7uplDB4NyUDhPvPv0ozhiDR0CYt8Rpyp
   Ec82bdF5ZOmPtOAZsCyIkHvmoLGvabSP6pBp5IAB6rG1jnatJWafNiRuf
   SEs3KA1cMb8+H0LUwu3BQHZmvJJBhumlJ0oQ2c1Z3LSHKzesN3+mMtjs2
   yDQdkLtlH8Do9wsi8KX1ReTOQNgPaFPLFd1sGvyDj1A800rRciQB1qS7P
   pFcRVjHTtP8nJg/GNv7QXDJFSFoh3hRtvrs4ZgCMGYp8hUPTt+RczktSO
   TVcCUsmaFz0Eb3zI8wT1O7J0OBaqogkIbvFwNvGhcjV2z5i3/F0P2kutc
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,346,1620662400"; 
   d="scan'208";a="178172515"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2021 09:17:27 +0800
IronPort-SDR: aAixGMyBo2KswJOVfhcHMg4dRiTWl+YD2UIgY3yqjfg4+Ie3KCdEr5yxtu/ekg9GNjg/xFqd7J
 Tiq45m/KOaTPbard4/TBQGLhHr8n+ji4+Bnv1aWEvpFEkOdTrcJzRouSwq9zt8Ocwm0F9AgmwH
 KWrAjBStnhL9ya6v2XKnbU22BRETRs8SN0YiTc+Cgs1XPUKK5P5M1UKJOpSGFV6FnfRP0xHjml
 OkNbNk0kZA1fmDj2BTJsav4yxB4lYcshg5pA2YDYSns9pc0FrsrLZj+CEWL/tCcRVlCqhRyPhY
 jFBITB+G70P0Rjq00BdI/LMn
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 17:52:43 -0700
IronPort-SDR: E5JT5lTrWRtCCwGHoh7vFiq4VNPxo5pSxhLc+1sGfFvUprOw7XL65NlZ4gia53Ym0yBT/C6FCZ
 Mtw4EThiT1BJ43ADclgAOvJzEM1wCpfzcjOla9kJisZpxmKRQGingDtrtDfD3bYaOPlhwZQsJx
 dpTGv2FmHnNuLKo9ElOouheSUcuq8piDGQY+pDIZPHcMshtqQUf0F37EVKZFeEl2+YORSqJaga
 ID3uPnaLBbmkrTjfz6iw7q1IyOv1/r3Vj5PGV7ZgulVdhrqOyvFEjLvf+C5jy7wgtJUyNFGE3C
 ztM=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.55.91])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Aug 2021 18:17:27 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/2] lsblk: factor out function to read sysfs param as bytes
Date:   Tue, 24 Aug 2021 10:17:17 +0900
Message-Id: <20210824011718.300747-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210824011718.300747-1-naohiro.aota@wdc.com>
References: <20210824011718.300747-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Factor out a new function device_read_bytes() to read a sysfs path as bytes
for a preparation for the next commit and to reduce the code duplication.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 misc-utils/lsblk.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 100eba0779f8..775a6d832076 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -708,6 +708,24 @@ static uint64_t device_get_discard_granularity(struct lsblk_device *dev)
 	return dev->discard_granularity;
 }
 
+static void device_read_bytes(struct lsblk_device *dev, char *path, char **str,
+			      uint64_t *sortdata)
+{
+	if (lsblk->bytes) {
+		ul_path_read_string(dev->sysfs, str, path);
+		if (sortdata)
+			str2u64(*str, sortdata);
+	} else {
+		uint64_t x;
+
+		if (ul_path_read_u64(dev->sysfs, &x, path) == 0) {
+			*str = size_to_human_string(SIZE_SUFFIX_1LETTER, x);
+			if (sortdata)
+				*sortdata = x;
+		}
+	}
+}
+
 /*
  * Generates data (string) for column specified by column ID for specified device. If sortdata
  * is not NULL then returns number usable to sort the column if the data are available for the
@@ -1033,18 +1051,7 @@ static char *device_get_data(
 		}
 		break;
 	case COL_DMAX:
-		if (lsblk->bytes) {
-			ul_path_read_string(dev->sysfs, &str, "queue/discard_max_bytes");
-			if (sortdata)
-				str2u64(str, sortdata);
-		} else {
-			uint64_t x;
-			if (ul_path_read_u64(dev->sysfs, &x, "queue/discard_max_bytes") == 0) {
-				str = size_to_human_string(SIZE_SUFFIX_1LETTER, x);
-				if (sortdata)
-					*sortdata = x;
-			}
-		}
+		device_read_bytes(dev, "queue/discard_max_bytes", &str, sortdata);
 		break;
 	case COL_DZERO:
 		if (device_get_discard_granularity(dev) > 0)
@@ -1053,19 +1060,7 @@ static char *device_get_data(
 			str = xstrdup("0");
 		break;
 	case COL_WSAME:
-		if (lsblk->bytes) {
-			ul_path_read_string(dev->sysfs, &str, "queue/write_same_max_bytes");
-			if (sortdata)
-				str2u64(str, sortdata);
-		} else {
-			uint64_t x;
-
-			if (ul_path_read_u64(dev->sysfs, &x, "queue/write_same_max_bytes") == 0) {
-				str = size_to_human_string(SIZE_SUFFIX_1LETTER, x);
-				if (sortdata)
-					*sortdata = x;
-			}
-		}
+		device_read_bytes(dev, "queue/write_same_max_bytes", &str, sortdata);
 		if (!str)
 			str = xstrdup("0");
 		break;
-- 
2.33.0

