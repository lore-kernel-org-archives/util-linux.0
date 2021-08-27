Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6413DC43214
	for <util-linux@archiver.kernel.org>; Fri, 27 Aug 2021 07:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C9A460F92
	for <util-linux@archiver.kernel.org>; Fri, 27 Aug 2021 07:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244425AbhH0HgC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 27 Aug 2021 03:36:02 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:37290 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244429AbhH0Hf5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 27 Aug 2021 03:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630049708; x=1661585708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UbHDeRwcM/IfpR8rgh0jixDV0q4Co+jYFud9P6JEBUk=;
  b=YibGCbEOobT2rkjJm6e0GVxBl7xuIwWmTjRuj2j73LseQrnfnH0vIHb2
   LzTvTLfTt6yH0oKY3rpRK4CNiER6ypv+SCMFr7QjpaGl1JqMHMtTiDs5y
   KvnPQNB1cYU2jVeU/iEe7fCvPqRmyCkqbCX5Tqrb9OwCPHPrEuIEOKkNd
   JkHpIO4QECdn//3xuvVzT62jgZ1bsQYzBIX30FDNiWgbnxqs90/zjCAdt
   T6QnJbrp4P4h+lw0I08Q9ZuRUV2BKiC54xdcHw1Qg0LTLjaa/4EQ5BxVG
   CqOwSLj0ePBdWBwhUDm8jvy/O0bf2623WI8le+uYyJ00fPlswWmD0icsh
   w==;
X-IronPort-AV: E=Sophos;i="5.84,355,1620662400"; 
   d="scan'208";a="290159633"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2021 15:35:08 +0800
IronPort-SDR: 0KpOXCzYB9A5o0MtX3C5ys+S/xmMcd8HxlZLoQvtkKGONN1gOkIzyd+2akHJXZQc2uwuRvNlVD
 IJN9+0nQ1xhOo808/DBdqlcZvpoGcKDebk0toKxE7yJEpcMR999acalBi3i3hQimJQj9VyrHMS
 VBU26ohmpxUN/Rh+gk3nD/WD0HPi1CFnWNDxlT7IkkIGxRfYNzWz3wuGYHMWmm+5WCRx7vGTl9
 /vYFcwZArLVObyTrNWaYGvs+Q+deC/hUNHaIYArTvc9USptLjzTa+UHrBWxeIWs4bgZFCxNA5h
 dFuJRrOQVp42Vs9ah6cSZ62m
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 00:12:03 -0700
IronPort-SDR: m4DeFWo4fpEK3kPCAVpAwoOCxT/0F2+bKqyv0ZpI8ZbOQIsa+1LuAZN+QhIUjPYnpT94H5D3Ud
 1eySwquHP+ZyGPegAhQTPyCnkvMXK55vS8HDbgoMxo1FSh7zewysvMwzTR2zhPL/O+Pu/zx1DB
 lmPUMaWNXEgR2+gftBJgqOqNjYYSWTajIZOL4OrpL1bjXmBtVs0yu+eWC+7/N71EpHMu3YSha1
 WOjIdV+cwo7rohBHXPNMFhcJpwkpOyUQASuGWYNisD3p4Q0vk4plhLIz/8QgoImHAsBeNta1uR
 fss=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.59.69])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Aug 2021 00:35:07 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Damien.LeMoal@wdc.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 3/3] lsblk: add zoned columns to "lsblk -z"
Date:   Fri, 27 Aug 2021 16:34:53 +0900
Message-Id: <20210827073453.4079636-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210827073453.4079636-1-naohiro.aota@wdc.com>
References: <20210827073453.4079636-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Add zoned columns to the "-z" option as follow.

$ lsblk -z -i
NAME        ZONED        ZONE-SZ ZONE-NR ZONE-AMAX ZONE-OMAX ZONE-APP ZONE-GRAN
sda         host-managed    256M   55880         0       128     672K        4K
sdb         host-managed    256M   55880         0       128     672K        4K
zram0       none              0B       0         0         0       0B        0B
nvme2n1     none              0B       0         0         0       0B        0B
|-nvme2n1p1 none              0B       0         0         0       0B        0B
|-nvme2n1p2 none              0B       0         0         0       0B        0B
`-nvme2n1p3 none              0B       0         0         0       0B        0B
nvme0n1     none              0B       0         0         0       0B        0B
nvme1n1     none              0B       0         0         0       0B        0B
nvme0n2     host-managed      2G    1844        14        14       4M        4K
nvme1n2     host-managed      2G    1844        14        14       4M        4K

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
index 108c8187498e..8a2578312f0d 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -1919,7 +1919,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -t, --topology       output info about topology\n"), out);
 	fputs(_(" -w, --width <num>    specifies output width as number of characters\n"), out);
 	fputs(_(" -x, --sort <column>  sort output by <column>\n"), out);
-	fputs(_(" -z, --zoned          print zone model\n"), out);
+	fputs(_(" -z, --zoned          print zone related information\n"), out);
 	fputs(_("     --sysroot <dir>  use specified directory as system root\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	printf(USAGE_HELP_OPTIONS(22));
@@ -2041,6 +2041,12 @@ int main(int argc, char *argv[])
 		case 'z':
 			add_uniq_column(COL_NAME);
 			add_uniq_column(COL_ZONED);
+			add_uniq_column(COL_ZONESIZE);
+			add_uniq_column(COL_ZONE_NR);
+			add_uniq_column(COL_ZONE_AMAX);
+			add_uniq_column(COL_ZONE_OMAX);
+			add_uniq_column(COL_ZONEAPPEND);
+			add_uniq_column(COL_ZONEWRITEGRAN);
 			break;
 		case 'e':
 			parse_excludes(optarg);
-- 
2.33.0

