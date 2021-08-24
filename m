Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD481C432BE
	for <util-linux@archiver.kernel.org>; Tue, 24 Aug 2021 01:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B907A61056
	for <util-linux@archiver.kernel.org>; Tue, 24 Aug 2021 01:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhHXBSM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 23 Aug 2021 21:18:12 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:10631 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhHXBSL (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 23 Aug 2021 21:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629767848; x=1661303848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/PHjlK0wpHkzDUnSPQWWnY3zTAPkjgQ348NMa24XINU=;
  b=T21aZ2WzfK4Nhw0zOABT3iLO0hz/jBQjfjTWuFHY5sf0tCdaajLe6lnW
   SDMmWZ+NwuhZrvO3Tz2rTPogFpNYldfTaane+tkHJFHgHyRZoY2zlZ+dW
   4sMCH/ayAnJwwNmrTiMY1QJEwGX5cuxZNz+ZwfpgXTM86tqCLmJl+HhuX
   eDcmd7WyKUs3uxOVpGxbUgD69ZtkJtFZh/tSRHJtrAbVXgfH3zDrDFgvy
   cIsDqfPd4mGG08w/z9h4SFxfJ5jo3j8OR7lN2B6fUgNj18nBm7jh1j0lS
   bm+N68rYC0i5BtbN7JPo5CKHbdHHAz0+2LTTHybRWXdKfWzeIUBUUKory
   w==;
X-IronPort-AV: E=Sophos;i="5.84,346,1620662400"; 
   d="scan'208";a="178172519"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2021 09:17:28 +0800
IronPort-SDR: xxTfBpjy351vgXdN23uG/6ZJuD20dxrPJ2aSoITlABbRIK7zD8WDAVGOSfaSN4pUeWJwrSv1zj
 VsanzuuS33Y7HQADDoveJtxoBUNCIo3Hndd1Ajd3KXrktnuSba9tkH7ElGlUfUA8Lp4lcAsBrb
 6KGu4TxUy8hdkc2ubN8bQa3FluJpEtd9il1+wkiP1htIt8rf1h2ssUXR31XI+fo1G883F3RfWo
 E6FLi+UZCPjB5JmnBi8XF0o7F7miCT5/MOzceqm4vm/QH16s7+JZsQ+NvfkvgTKwt9DwJhjFM5
 pFHgNT3fu6N2Q0q8MEoic5xc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 17:52:44 -0700
IronPort-SDR: HBnAPv22Pi4Wk547/KlLqWIprlz+6o19f+In2k8rNmNhqowUVAvSZRo0aSM4sLn5bqXJq0f+LA
 wRgu2ioGrPK2LXTJMC0X1kCyBCodg0YJtHKCkmt8bIaLF9yTlXb91dQL4OhQUd2dHeZQ0mYAAt
 nrG6abLYq1RW1DKNqBfUiqklfds/tzxczbRibDz+ra2mT4KVFCrVXFV4lepR1kwe/uUj8MwmAn
 G6vCI8fyZdEoH4jFDR77mxQaBqJmWojJxCAFIJODgtuOriEXQs96lNWW0D6qaO4Dl/+R/Z1nx7
 EiI=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.55.91])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Aug 2021 18:17:28 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/2] lsblk: add columns of zoned parameters
Date:   Tue, 24 Aug 2021 10:17:18 +0900
Message-Id: <20210824011718.300747-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210824011718.300747-1-naohiro.aota@wdc.com>
References: <20210824011718.300747-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Several parameters for zoned devices are missing from lsblk's columns. This
commit introduces them as following.

 ZONE-SIZE    zone size
 ZONE-WGRAN   zone write granularity
 ZONE-APPEND  zone append max bytes
 ZONES-NR     number of zones
 ZONES-OMAX   max open zones
 ZONES-AMAX   max active zones

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 misc-utils/lsblk.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 775a6d832076..6f1c5dc67060 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -123,6 +123,12 @@ enum {
 	COL_WSAME,
 	COL_WWN,
 	COL_ZONED,
+	COL_ZONESIZE,
+	COL_ZONEWRITEGRAN,
+	COL_ZONEAPPEND,
+	COL_ZONES_NR,
+	COL_ZONES_OMAX,
+	COL_ZONES_AMAX,
 };
 
 /* basic table settings */
@@ -213,6 +219,12 @@ static struct colinfo infos[] = {
 	[COL_WSAME] = { "WSAME", 6, SCOLS_FL_RIGHT, N_("write same max bytes"), COLTYPE_SIZE },
 	[COL_WWN] = { "WWN", 18, 0, N_("unique storage identifier") },
 	[COL_ZONED] = { "ZONED", 0.3, 0, N_("zone model") },
+	[COL_ZONESIZE] = { "ZONE-SIZE", 9, SCOLS_FL_RIGHT, N_("zone size"), COLTYPE_NUM },
+	[COL_ZONEWRITEGRAN] = { "ZONE-WGRAN", 10, SCOLS_FL_RIGHT, N_("zone write granularity"), COLTYPE_NUM },
+	[COL_ZONEAPPEND] = { "ZONE-APPEND", 11, SCOLS_FL_RIGHT, N_("zone append max bytes"), COLTYPE_NUM },
+	[COL_ZONES_NR] = { "ZONES-NR", 8, SCOLS_FL_RIGHT, N_("number of zones"), COLTYPE_NUM },
+	[COL_ZONES_OMAX] = { "ZONES-OMAX", 10, SCOLS_FL_RIGHT, N_("max open zones"), COLTYPE_NUM },
+	[COL_ZONES_AMAX] = { "ZONES-AMAX", 10, SCOLS_FL_RIGHT, N_("max active zones"), COLTYPE_NUM },
 };
 
 struct lsblk *lsblk;	/* global handler */
@@ -1067,6 +1079,46 @@ static char *device_get_data(
 	case COL_ZONED:
 		ul_path_read_string(dev->sysfs, &str, "queue/zoned");
 		break;
+	case COL_ZONESIZE:
+	{
+		uint64_t x;
+
+		if (ul_path_read_u64(dev->sysfs, &x, "queue/chunk_sectors") == 0) {
+			x <<= 9;
+			if (lsblk->bytes)
+				xasprintf(&str, "%ju", x);
+			else
+				str = size_to_human_string(SIZE_SUFFIX_1LETTER, x);
+			if (sortdata)
+				*sortdata = x;
+		}
+		break;
+	}
+	case COL_ZONEWRITEGRAN:
+		device_read_bytes(dev, "queue/zone_write_granularity", &str, sortdata);
+		break;
+	case COL_ZONEAPPEND:
+		device_read_bytes(dev, "queue/zone_append_max_bytes", &str, sortdata);
+		break;
+	case COL_ZONES_NR:
+		ul_path_read_string(dev->sysfs, &str, "queue/nr_zones");
+		if (sortdata)
+			str2u64(str, sortdata);
+		break;
+	case COL_ZONES_OMAX:
+		ul_path_read_string(dev->sysfs, &str, "queue/max_open_zones");
+		if (!str)
+			str = xstrdup("0");
+		if (sortdata)
+			str2u64(str, sortdata);
+		break;
+	case COL_ZONES_AMAX:
+		ul_path_read_string(dev->sysfs, &str, "queue/max_active_zones");
+		if (!str)
+			str = xstrdup("0");
+		if (sortdata)
+			str2u64(str, sortdata);
+		break;
 	case COL_DAX:
 		ul_path_read_string(dev->sysfs, &str, "queue/dax");
 		break;
-- 
2.33.0

