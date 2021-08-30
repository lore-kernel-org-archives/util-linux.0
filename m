Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC25C4320E
	for <util-linux@archiver.kernel.org>; Mon, 30 Aug 2021 05:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 632B560F4B
	for <util-linux@archiver.kernel.org>; Mon, 30 Aug 2021 05:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhH3FyG (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 30 Aug 2021 01:54:06 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:32306 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbhH3FyG (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 30 Aug 2021 01:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630302792; x=1661838792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ps9D2scMr+m2S/SJTL2FVBoZez4gUTBpYDvDDzppgxM=;
  b=P09cwAA38lrNScwCSVLUjunqDqvgjcrylTFoAyCksrhJOuV5ThqRzy6x
   vYfnRr8A6s35Fh5K6ukqCRoVBPRZ5GWfzQv/EjsQgNBQD1drUFdPHl1mG
   ov3LVrdMN/6MpRrbmLhfqAC9Czo6OFTpa6Ah90efHakSTi1JuRyeZ/EB9
   8DFu1tZCvk5MX8R3tddj8ze6mXPrVOe6lK6+3Uj1a97lKiYLRPfhUUdn3
   p6lkL7+HUT67eV86bxfXEjtbVxviBDkSbIZyC3ixVGdevOEtUUbpbaKoX
   WrszwIERkl0kPFP/wQX5c1P3SXKMFv0Ib633NGbvHD/QPhUtmocatvcii
   g==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="290338006"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 13:53:12 +0800
IronPort-SDR: EuEV1LBM+4g9oDbEUQQcGSd1ZWA/gcyrrOKzExPOR10mQab8O9B8pXr/Nw0xb36fiyymwZGqm3
 RH2TpESOrkiO2i1iJ8TahwUjHqgPX6bMU4PLtN8kuOQ8Lf0Rte0aCK5fHAHIuk33scZMphO9FM
 5UjakWSGHEQAoVyv1Gb0iuXlZ8o//TuTtK/BwhMUJJ3Np4Gf9kUfcaSIzkP/6tRqRtAscAuWRz
 ZXWp5x5GtNiIjOZpwhRKtlGdzHcsd5USW5gbVImL/Jlp76Y2cQ/Ii/kx8pbocgKt2RRamKcKmO
 d5Qn541gqL6H9RdjZSGdhgTk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 22:30:04 -0700
IronPort-SDR: nQMAfAxfGnFh448nCfYM2iGh+Gy1Z4GwHrO5WsvJkzjx5AMMWsWJ3KydO+RJOS2Np+452UyoMq
 kxNy0G5paqsrQggyWzwy0JAuo5vV9OXzZfJPLWWnPbeZY9eQAbvHEtUmVWGmGG+O4foZcPb5a2
 wrEYLtFweBRRxDHZFz1wEz2QlUE1yE6juwCwfT+V1bxtvG5Wh0IDoAk0Cn+F0P/0qbr4ERWmkP
 9Av/JmRJAhsK5X1fe+o+Ki1EdGB1uLfK8tbZSkhUyLvzk8/ibXWq4ituEY7QGcwLyFbbv2mjV5
 wBk=
WDCIronportException: Internal
Received: from jpf008021.ad.shared (HELO naota-xeon.wdc.com) ([10.225.60.33])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Aug 2021 22:53:13 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Damien.LeMoal@wdc.com,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v3 3/3] lsblk: add zoned columns to "lsblk -z"
Date:   Mon, 30 Aug 2021 14:52:57 +0900
Message-Id: <20210830055257.1832523-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830055257.1832523-1-naohiro.aota@wdc.com>
References: <20210830055257.1832523-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Add zoned columns to the "-z" option as follow.

$ lsblk -z -i
NAME        ZONED        ZONE-SZ ZONE-NR ZONE-AMAX ZONE-OMAX ZONE-APP ZONE-WGRAN
sda         host-managed    256M   55880         0       128     672K         4K
sdb         host-managed    256M   55880         0       128     672K         4K
zram0       none              0B       0         0         0       0B         0B
nvme2n1     none              0B       0         0         0       0B         0B
|-nvme2n1p1 none              0B       0         0         0       0B         0B
|-nvme2n1p2 none              0B       0         0         0       0B         0B
`-nvme2n1p3 none              0B       0         0         0       0B         0B
nvme0n1     none              0B       0         0         0       0B         0B
nvme1n1     none              0B       0         0         0       0B         0B
nvme0n2     host-managed      2G    1844        14        14       4M         4K
nvme1n2     host-managed      2G    1844        14        14       4M         4K

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 misc-utils/lsblk.8.adoc | 2 +-
 misc-utils/lsblk.c      | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/misc-utils/lsblk.8.adoc b/misc-utils/lsblk.8.adoc
index 7356976403a7..9e68a847ce0c 100644
--- a/misc-utils/lsblk.8.adoc
+++ b/misc-utils/lsblk.8.adoc
@@ -116,7 +116,7 @@ Specifies output width as a number of characters. The default is the number of t
 Sort output lines by _column_. This option enables *--list* output format by default. It is possible to use the option *--tree* to force tree-like output and than the tree branches are sorted by the _column_.
 
 *-z*, *--zoned*::
-Print the zone model for each device.
+Print the zone related information for each device.
 
 *--sysroot* _directory_::
 Gather data for a Linux instance other than the instance from which the *lsblk* command is issued. The specified directory is the system root of the Linux instance to be inspected. The real device nodes in the target directory can be replaced by text files with udev attributes.
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 807ddcfea631..b4696f5ec5c9 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -1920,7 +1920,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -t, --topology       output info about topology\n"), out);
 	fputs(_(" -w, --width <num>    specifies output width as number of characters\n"), out);
 	fputs(_(" -x, --sort <column>  sort output by <column>\n"), out);
-	fputs(_(" -z, --zoned          print zone model\n"), out);
+	fputs(_(" -z, --zoned          print zone related information\n"), out);
 	fputs(_("     --sysroot <dir>  use specified directory as system root\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	printf(USAGE_HELP_OPTIONS(22));
@@ -2042,6 +2042,12 @@ int main(int argc, char *argv[])
 		case 'z':
 			add_uniq_column(COL_NAME);
 			add_uniq_column(COL_ZONED);
+			add_uniq_column(COL_ZONE_SZ);
+			add_uniq_column(COL_ZONE_NR);
+			add_uniq_column(COL_ZONE_AMAX);
+			add_uniq_column(COL_ZONE_OMAX);
+			add_uniq_column(COL_ZONE_APP);
+			add_uniq_column(COL_ZONE_WGRAN);
 			break;
 		case 'e':
 			parse_excludes(optarg);
-- 
2.33.0

