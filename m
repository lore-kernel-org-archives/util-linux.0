Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B880C4320A
	for <util-linux@archiver.kernel.org>; Mon, 30 Aug 2021 05:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1853B60F57
	for <util-linux@archiver.kernel.org>; Mon, 30 Aug 2021 05:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhH3FyE (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 30 Aug 2021 01:54:04 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:32306 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhH3FyE (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 30 Aug 2021 01:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630302790; x=1661838790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UI5RMuriAeEQ/zTGnhX5XYWndDdjfZ4Hh4GEKBO5PIY=;
  b=WtINwHtaSr4QhDeK61OOAfrT4zR1Mf6c840Xbn414Zv6iICOyKaMMN06
   QMGhlQZaRtAXcRlk0/vHTWXiZSmFhNBjzw+uxlR0/6b7dSXk+yO7OObwK
   QSA3BzKz3BKFripDBDK/Q90Uwjt1ZoEKYzlgGimnHlgQeTNUfpP42Xjms
   fqUcI05/P/ykVzN+R4H9hQ4AXAk6PLILme16p7SfAC5Rum2hNeq/zllyF
   KyCUCz+h6O7Lk+IN8fKBIK8gh5lriQhkkzQHDfiaqILpvkbuP7NPGHDz7
   9xN2JX+jrHTelsqWMRZAEkXeTmR4uOCfrEJ0yLRrwkuFbU9uHmM+9m4xV
   w==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="290338000"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 13:53:10 +0800
IronPort-SDR: kDlYne/vOASRxDHRWQhr9grghij1pjDVolOaqk9ra9M0jztEzmULrufUxFj44AUtdz5IkP/tQC
 LpxGNqog6f6/DgIVpFzkVDnFn7Qdh3iF9NTbZvCm73boc43e4gMM0SIbpK/wsAWMq4Ih7KO+OC
 EVZ+4cLHu0x9Lnya77hvrRvQPUZDePxSnAddzdeYEDBVoXzwd2LddxQRfy9/PeRlf2ZnOVu5gP
 5gw9fnBDR45ruW090eWGppvwU8jNo4kuS0BzBAzJi+Rm5NIBwCW7DxQyi+/qXolXtUQd2jjFdg
 3Fc7+XZleMXavU5JxZunEPby
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 22:30:01 -0700
IronPort-SDR: Ty70QRMl91zkPQlSTERl++CLDQE12orachnkANisFKZUs3PcGUriS/JkMOJ4dK72lz3M4Rxr4y
 5DyR1rJeY96hOE/5wxfDU6ik3mKB0ueeTa9aAkxXfuanXemPw1O2fqJxIU4gotXBkJHoD85rvl
 IaB2wH7IzpEkqQRxmQt9KyEROShpoH1qLhNdcg6Ex8S4fDBmMT6Y2sekBG8owSj3rEYAbPTw0+
 KgYlZeVCWpd+OAQoJ+X+wfeLqfa97V874cY+kLWXH41a1u7f3vA7ATnl69L5CtQPiDGQK7x5wx
 X+w=
WDCIronportException: Internal
Received: from jpf008021.ad.shared (HELO naota-xeon.wdc.com) ([10.225.60.33])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Aug 2021 22:53:11 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Damien.LeMoal@wdc.com,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v3 1/3] lsblk: factor out function to read sysfs param as bytes
Date:   Mon, 30 Aug 2021 14:52:55 +0900
Message-Id: <20210830055257.1832523-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830055257.1832523-1-naohiro.aota@wdc.com>
References: <20210830055257.1832523-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Factor out a new function device_read_bytes() to read a sysfs path as bytes
for a preparation for the next commit and to reduce the code duplication.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 misc-utils/lsblk.c | 46 +++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 100eba0779f8..9c41e70adad7 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -708,6 +708,25 @@ static uint64_t device_get_discard_granularity(struct lsblk_device *dev)
 	return dev->discard_granularity;
 }
 
+static void device_read_bytes(struct lsblk_device *dev, char *path, char **str,
+			      uint64_t *sortdata)
+{
+	uint64_t x;
+
+	if (lsblk->bytes) {
+		ul_path_read_string(dev->sysfs, str, path);
+		if (sortdata)
+			str2u64(*str, sortdata);
+		return;
+	}
+
+	if (ul_path_read_u64(dev->sysfs, &x, path) == 0) {
+		*str = size_to_human_string(SIZE_SUFFIX_1LETTER, x);
+		if (sortdata)
+			*sortdata = x;
+	}
+}
+
 /*
  * Generates data (string) for column specified by column ID for specified device. If sortdata
  * is not NULL then returns number usable to sort the column if the data are available for the
@@ -1033,18 +1052,7 @@ static char *device_get_data(
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
@@ -1053,19 +1061,7 @@ static char *device_get_data(
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

