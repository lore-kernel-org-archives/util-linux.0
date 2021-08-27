Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F96C4320E
	for <util-linux@archiver.kernel.org>; Fri, 27 Aug 2021 07:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A74560F92
	for <util-linux@archiver.kernel.org>; Fri, 27 Aug 2021 07:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244412AbhH0HgB (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 27 Aug 2021 03:36:01 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:37295 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244425AbhH0Hf4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 27 Aug 2021 03:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630049708; x=1661585708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ctyd9XCNu7BpxhM0A7Fa4B177mWzC3F1kfTQjQeVlHI=;
  b=K1tvQ3V0iZWXVQyjJsBJEfnGZVrY1Bw5pG/MhePoPRpVGoEqW4yrkHRv
   ttLZ+nU/4dJ7+A3ARaMEgZ4gUhQQJAm54zEzlcDsPZzzpcr7UR2wXb+97
   t+LMYXPWi8C1qcDs6tjY7xA7W6weGh5vK08Cy27CoJymlHmUup2IMTcFK
   FXRGZmikMPngBHATxB1JRSY7teoP3W+bq+lfbpfAbM8Rd7f5le+3uhe/U
   s9aUrakPyYhJ0akyglyA3WFbYuqQd6HSdo+ccGFaYd7CI8Pow7YTGq+vb
   D3Dm6bQ1pzhAXR5XH2kazvtO2e6QPUsJGXrdkMeqEUfgJfWdXeR5QQysv
   w==;
X-IronPort-AV: E=Sophos;i="5.84,355,1620662400"; 
   d="scan'208";a="290159632"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2021 15:35:07 +0800
IronPort-SDR: XfZ5zCIfDFrePgcBTYdNnIVl97ulMvfFzEUq0hsE6BZROVjYYZU/tkc18qAWGNUUyiAUSKQn1Y
 d0Cht1DIHMRvBrMNquaDS2/uK3Ia1Ym9wPy6KiJfImXtYmYut63OdQddNvkur6cfTjpnYiZa31
 7zeAgVz8QKzMzwSBTwuKoQ8Qq2Rj0FpcDZFAlZph9dsm4zHHXPhBmlzuHKTB9pFJ8aWrD38JCG
 CehGSclGjaAPOlp1quV9Fl809EUg3E4pNYhEAVxkmMt0t3KQjUQxL4gDo06KSq+E9E60n7Ca8F
 AGd5HDYEXqVuKey5ko8S4nOD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 00:12:02 -0700
IronPort-SDR: S3Jzuml832epDJi25uW8Kfu6sipjYIMYAHvzgtFpEOk5MXmTNODf5Ffk0euZYCrKVZ/8yq1+9c
 2EyfHrJ7u6uMGjG1V1YvY+pJWadT+XnkOHRh7wF/TSORf8VHuHNTrM01JBeItP1t26bPCWRGpG
 sbDcsJurXSiJY96FgxbQvVc17wynGXvBsCbFEUmUUUqc0kHJpe3YdA73bRdR06z0UB8KeIg75h
 4VAHUCkQYTACdPFHUBG1M+k2CVTPEmzHItC9/CiLdDBpw5EvcOZUUuIFCT/GKdlmA9Qd8qQrVB
 1yk=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.59.69])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Aug 2021 00:35:06 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Damien.LeMoal@wdc.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 2/3] lsblk: add columns of zoned parameters
Date:   Fri, 27 Aug 2021 16:34:52 +0900
Message-Id: <20210827073453.4079636-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210827073453.4079636-1-naohiro.aota@wdc.com>
References: <20210827073453.4079636-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Several parameters for zoned devices are missing from lsblk's columns. This
commit introduces them as following.

 ZONE-SZ    zone size
 ZONE-GRAN  zone write granularity
 ZONE-APP   zone append max bytes
 ZONE-NR    number of zones
 ZONE-OMAX  max open zones
 ZONE-AMAX  max active zones

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 bash-completion/lsblk |  3 ++-
 misc-utils/lsblk.c    | 52 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/bash-completion/lsblk b/bash-completion/lsblk
index 731ef3f4095d..c9ebbdcedef6 100644
--- a/bash-completion/lsblk
+++ b/bash-completion/lsblk
@@ -10,7 +10,8 @@ _lsblk_module()
 		LABEL UUID PTUUID PTTYPE PARTTYPE PARTTYPENAME PARTLABEL PARTUUID PARTFLAGS RA
 		RO RM HOTPLUG MODEL SERIAL SIZE STATE OWNER GROUP MODE ALIGNMENT MIN-IO OPT-IO
 		PHY-SEC LOG-SEC ROTA SCHED RQ-SIZE TYPE DISC-ALN DISC-GRAN DISC-MAX DISC-ZERO
-		WSAME WWN RAND PKNAME HCTL TRAN SUBSYSTEMS REV VENDOR ZONED DAX
+		WSAME WWN RAND PKNAME HCTL TRAN SUBSYSTEMS REV VENDOR ZONED ZONE-SZ ZONE-GRAN
+		ZONE-APP ZONE-NR ZONE-OMAX ZONE-AMAX DAX
 	"
 
 	case $prev in
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 775a6d832076..108c8187498e 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -123,6 +123,12 @@ enum {
 	COL_WSAME,
 	COL_WWN,
 	COL_ZONED,
+	COL_ZONESIZE,
+	COL_ZONEWRITEGRAN,
+	COL_ZONEAPPEND,
+	COL_ZONE_NR,
+	COL_ZONE_OMAX,
+	COL_ZONE_AMAX,
 };
 
 /* basic table settings */
@@ -213,6 +219,12 @@ static struct colinfo infos[] = {
 	[COL_WSAME] = { "WSAME", 6, SCOLS_FL_RIGHT, N_("write same max bytes"), COLTYPE_SIZE },
 	[COL_WWN] = { "WWN", 18, 0, N_("unique storage identifier") },
 	[COL_ZONED] = { "ZONED", 0.3, 0, N_("zone model") },
+	[COL_ZONESIZE] = { "ZONE-SZ", 9, SCOLS_FL_RIGHT, N_("zone size"), COLTYPE_NUM },
+	[COL_ZONEWRITEGRAN] = { "ZONE-GRAN", 10, SCOLS_FL_RIGHT, N_("zone write granularity"), COLTYPE_NUM },
+	[COL_ZONEAPPEND] = { "ZONE-APP", 11, SCOLS_FL_RIGHT, N_("zone append max bytes"), COLTYPE_NUM },
+	[COL_ZONE_NR] = { "ZONE-NR", 8, SCOLS_FL_RIGHT, N_("number of zones"), COLTYPE_NUM },
+	[COL_ZONE_OMAX] = { "ZONE-OMAX", 10, SCOLS_FL_RIGHT, N_("max open zones"), COLTYPE_NUM },
+	[COL_ZONE_AMAX] = { "ZONE-AMAX", 10, SCOLS_FL_RIGHT, N_("max active zones"), COLTYPE_NUM },
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
+	case COL_ZONE_NR:
+		ul_path_read_string(dev->sysfs, &str, "queue/nr_zones");
+		if (sortdata)
+			str2u64(str, sortdata);
+		break;
+	case COL_ZONE_OMAX:
+		ul_path_read_string(dev->sysfs, &str, "queue/max_open_zones");
+		if (!str)
+			str = xstrdup("0");
+		if (sortdata)
+			str2u64(str, sortdata);
+		break;
+	case COL_ZONE_AMAX:
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

