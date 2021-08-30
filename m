Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C260AC432BE
	for <util-linux@archiver.kernel.org>; Mon, 30 Aug 2021 05:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C6860F4B
	for <util-linux@archiver.kernel.org>; Mon, 30 Aug 2021 05:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhH3FyF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 30 Aug 2021 01:54:05 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:32306 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbhH3FyF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 30 Aug 2021 01:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630302791; x=1661838791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BYAPjnOGwDOsdx4dQS/SsFLeRkXmFhQPggYdU1LwV5I=;
  b=h89xgKJMggH0K90DauCFmQJRAexKGOn+iEcJc51RbbpKl6Ii0cYwoHeh
   7KRIRYEVYxIor2fDHg8//BEiEBiAgaNorPVhQl5XAVKf8Q7ATR+iKEptu
   iHIwAdE6Xk6x0x7rDOKvsptVwxORZ2hKhZtcdtUCxeOygu7ky4UrqPQEq
   eJG6DHMKFOjl3AafwvCsIcjzZAZzQL75cOtFglYIcOit+9joUqjvYZLm2
   6Kefz3x5iA2jSiOPTpp0q4FJ4NPYYMYx0jlu2OMG7FBFKLZrNLfd6dwiX
   IFuZASRsEHeJSK6ApQF6s0PXXZbhsptAco1tbjImCHdGkIR3DdYV0tUYT
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="290338001"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 13:53:11 +0800
IronPort-SDR: GvHN/RGkYcOvNbHwVWPVI/i4BWzPLv/ScMn/dEw7GhxToSplNESWWFq3ukRy8Zl8HnNFupytuf
 Z6WFvt+b4lcxUK6cZAyy4mPmxJTlLfDpQl3ea+QPIE8fyOFeFat4cW++mv3puzgdf9XUHfX8ZJ
 cSMmCA4z11gFbYyIdRqRo2QDMe1Il9so6lNwCEofwz3I1/QRA7T2Kh6h6wF2o/yyXd2RMlGp3N
 roKlY3xQ5na8AVtnkeebX8PmReUTYyKQ6xz6d/DAicX93h/Ep8e5e6fZJ4jbmLNBaTU4HmTOxI
 pzkdfsRZQOZiowofV+bs4FmM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 22:30:02 -0700
IronPort-SDR: l7EmzNHq4THKBb3a0ah/3xR+N1Wva/tvAsj5e4xSJ8iZuZQ9w7Z+i2MDiy3yALVOYp1U48+ojc
 9lA8EOBPX6W5lQaezTauoSPhSv1WM4pgpXtvb8+4IqlzZmmFFhVMC5AWk6E8UWeHTQaYUWAh+w
 73Yd0PyZ0n3HIRSNOm82445gcX1KjpRo6WrzwB/tv70C2gKXNRm1ekh+9MPUL4T8UIUyNLTsU1
 LaGyrvf7kNvwgr9jRcVLlwa4GUorU1bTRseV3ANtfnqyDI4GYMe5p62RudkGVK6KntOwNJx5ST
 aBY=
WDCIronportException: Internal
Received: from jpf008021.ad.shared (HELO naota-xeon.wdc.com) ([10.225.60.33])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Aug 2021 22:53:12 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Damien.LeMoal@wdc.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 2/3] lsblk: add columns of zoned parameters
Date:   Mon, 30 Aug 2021 14:52:56 +0900
Message-Id: <20210830055257.1832523-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830055257.1832523-1-naohiro.aota@wdc.com>
References: <20210830055257.1832523-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Several parameters for zoned devices are missing from lsblk's columns. This
commit introduces them as following.

 ZONE-SZ     zone size
 ZONE-WGRAN  zone write granularity
 ZONE-APP    zone append max bytes
 ZONE-NR     number of zones
 ZONE-OMAX   maximum number of open zones
 ZONE-AMAX   maximum number of active zones

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 bash-completion/lsblk |  3 ++-
 misc-utils/lsblk.c    | 52 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/bash-completion/lsblk b/bash-completion/lsblk
index 731ef3f4095d..ca0ad39d7345 100644
--- a/bash-completion/lsblk
+++ b/bash-completion/lsblk
@@ -10,7 +10,8 @@ _lsblk_module()
 		LABEL UUID PTUUID PTTYPE PARTTYPE PARTTYPENAME PARTLABEL PARTUUID PARTFLAGS RA
 		RO RM HOTPLUG MODEL SERIAL SIZE STATE OWNER GROUP MODE ALIGNMENT MIN-IO OPT-IO
 		PHY-SEC LOG-SEC ROTA SCHED RQ-SIZE TYPE DISC-ALN DISC-GRAN DISC-MAX DISC-ZERO
-		WSAME WWN RAND PKNAME HCTL TRAN SUBSYSTEMS REV VENDOR ZONED DAX
+		WSAME WWN RAND PKNAME HCTL TRAN SUBSYSTEMS REV VENDOR ZONED ZONE-SZ ZONE-WGRAN
+		ZONE-APP ZONE-NR ZONE-OMAX ZONE-AMAX DAX
 	"
 
 	case $prev in
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 9c41e70adad7..807ddcfea631 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -123,6 +123,12 @@ enum {
 	COL_WSAME,
 	COL_WWN,
 	COL_ZONED,
+	COL_ZONE_SZ,
+	COL_ZONE_WGRAN,
+	COL_ZONE_APP,
+	COL_ZONE_NR,
+	COL_ZONE_OMAX,
+	COL_ZONE_AMAX,
 };
 
 /* basic table settings */
@@ -213,6 +219,12 @@ static struct colinfo infos[] = {
 	[COL_WSAME] = { "WSAME", 6, SCOLS_FL_RIGHT, N_("write same max bytes"), COLTYPE_SIZE },
 	[COL_WWN] = { "WWN", 18, 0, N_("unique storage identifier") },
 	[COL_ZONED] = { "ZONED", 0.3, 0, N_("zone model") },
+	[COL_ZONE_SZ] = { "ZONE-SZ", 9, SCOLS_FL_RIGHT, N_("zone size"), COLTYPE_NUM },
+	[COL_ZONE_WGRAN] = { "ZONE-WGRAN", 10, SCOLS_FL_RIGHT, N_("zone write granularity"), COLTYPE_NUM },
+	[COL_ZONE_APP] = { "ZONE-APP", 11, SCOLS_FL_RIGHT, N_("zone append max bytes"), COLTYPE_NUM },
+	[COL_ZONE_NR] = { "ZONE-NR", 8, SCOLS_FL_RIGHT, N_("number of zones"), COLTYPE_NUM },
+	[COL_ZONE_OMAX] = { "ZONE-OMAX", 10, SCOLS_FL_RIGHT, N_("maximum number of open zones"), COLTYPE_NUM },
+	[COL_ZONE_AMAX] = { "ZONE-AMAX", 10, SCOLS_FL_RIGHT, N_("maximum number of active zones"), COLTYPE_NUM },
 };
 
 struct lsblk *lsblk;	/* global handler */
@@ -1068,6 +1080,46 @@ static char *device_get_data(
 	case COL_ZONED:
 		ul_path_read_string(dev->sysfs, &str, "queue/zoned");
 		break;
+	case COL_ZONE_SZ:
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
+	case COL_ZONE_WGRAN:
+		device_read_bytes(dev, "queue/zone_write_granularity", &str, sortdata);
+		break;
+	case COL_ZONE_APP:
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

