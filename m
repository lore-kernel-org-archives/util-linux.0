Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE87C432BE
	for <util-linux@archiver.kernel.org>; Fri, 27 Aug 2021 07:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7385C60FD8
	for <util-linux@archiver.kernel.org>; Fri, 27 Aug 2021 07:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244431AbhH0Hf7 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 27 Aug 2021 03:35:59 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:37294 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244287AbhH0Hfz (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 27 Aug 2021 03:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630049707; x=1661585707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=slvoiQEkIQlePo6uRWoj2EWV3plWRvddqyNu6U2jlSA=;
  b=Wey2VHB8T79ElXoxThEZqw9bKqQsinoJEjCWQTqBRtjNmyHWchuUiL7u
   +TGe63WX3BAyPV604/8lldTWTMOaWdaMlb2kzYxzXmGJNcKr85SFA2Evm
   72mqvT4SbtDziDpdy7SH0IU8QX7vdIWVeTCaIPsByxzqeouisXhlLOjbF
   Q+VsMyJfBuIuPGdSaZp7EQQN9nDNr6E6qnEgaxOKOFKox89psw7UEXR/c
   rpvKBjc5Zt3OfNwADkHtrdK2RzbZxrSyBCRoH7M5lGTsnU0ogqSLTUB/f
   Ul+Pmz17oMLfzeOL2YiuYHvJ5ZdoE0hOWlKLBHqTr8sfIRmXWkyoVCoEH
   g==;
X-IronPort-AV: E=Sophos;i="5.84,355,1620662400"; 
   d="scan'208";a="290159628"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2021 15:35:06 +0800
IronPort-SDR: czcJ53XDB21WTuOFX/Mff0e5EqJyFukZwHX+XLV2yDxv/auSdcc+Mwpql6MaEJV6Pnh3LRy5j+
 FZLKXeQ8lespw/cWGW1OcPSSkvjxguhiSTXrusO61TmYIX9dTakskCSerh/9AuTfw/6d9oKDvg
 L3FO8ibEmqaQlL1RaHP4iSh3AbnJ8fLYONb7KZxR1YWxDZZE6Pw4St0a4LOQobOMJ+TVqYU2pu
 QJkXST4y0YON4r/3bu+cKbAGTK/wK5gXroEafrNRGhZRuLCacnYiCkoIT62swrJaTlEHSRfKkr
 Q8w0z+v8TeCP8qFViMRL70E/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 00:12:01 -0700
IronPort-SDR: LiDZ+psa9EY8Tpwblgmj53LtiZqVKDheqVDrIwapCKxO1yDOStrEBz90XDLbISeCnZaGCLVBwd
 sHq/3KE3f5btw2+SOLz8JToJSZgqDteA8n7ePHjt1dIemPwkjBLgicl/UDBJnx/6Ms1O8iNJKx
 lRnALzJYMr8UOe4eCm075U9XiGs76yGC75sr90kDZkNq5r1EErDXDXeLbwgU+CWP6qJdGSev9R
 NzfEf3is9gkY08TONqU5iTJF5vEC4YcnoMD4D1JBDZE4a08TkQSvLBQ8GjMGnpr0zqzy58rB8o
 fJQ=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.59.69])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Aug 2021 00:35:05 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Damien.LeMoal@wdc.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/3] lsblk: factor out function to read sysfs param as bytes
Date:   Fri, 27 Aug 2021 16:34:51 +0900
Message-Id: <20210827073453.4079636-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210827073453.4079636-1-naohiro.aota@wdc.com>
References: <20210827073453.4079636-1-naohiro.aota@wdc.com>
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

