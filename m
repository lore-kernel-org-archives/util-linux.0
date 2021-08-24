Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B188C4338F
	for <util-linux@archiver.kernel.org>; Tue, 24 Aug 2021 01:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B8C61056
	for <util-linux@archiver.kernel.org>; Tue, 24 Aug 2021 01:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhHXBSK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 23 Aug 2021 21:18:10 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:10631 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhHXBSK (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 23 Aug 2021 21:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629767846; x=1661303846;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/K6UCKMK/aDbgsSLXzSFMMc+fdnz/oNuckq1cqdh1bE=;
  b=KTpxworfYNQ7No7f4rSIK9D6P8VQxdz9Z2lw6KeTwRZ0wFC23e9/kDeC
   7Gu3jRYuIXeVWqGAvh/zYK5sA9vwzKQv5jc5sjk9bzQ0ykxX02fqGpnUw
   5idAaF8TeJLpytmwcMMN1FlrFEEY9gpX2/BfQVULSg3WcNcBU4GX22LIw
   7+QuFPbMolyhgI8R0HXjpPFhgwRu1sbpeKqF5kK+ZYnfPBEjHqOBl+JHy
   1TVaQjmr4NORclitj00k8KnlUqfYCUjIfWVUZd8toY71wqu2RDWczS9my
   9TfAXNn76pfoDvm0GXfl7WHl6WRVFMa7Dzph1gk54ZuGqIeXEnPbFQQwq
   w==;
X-IronPort-AV: E=Sophos;i="5.84,346,1620662400"; 
   d="scan'208";a="178172514"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2021 09:17:26 +0800
IronPort-SDR: OnMZwkg/f1xIpLeZJDQlJqFfTcyFDF/lUmMfyLCTjqfhNnujFn6JlawFEVCca7pqnV1yP+aaT2
 STm18LgYxagj9w64rEuYijy6Lf7bkixs7bjwL6jxdnWZStl0DS1KDO0Ba/GcKJY6Vxogo3bexE
 IIi/6bWTWeQRO5zmmk49X+bymAH0aYnKFkESOTruKWju7QDczBKXIj+Zl8GG+ckrh8EU+XD++9
 gnJIQJ9IbOyRCzNnmR0fKYJpQ0WTHNaQQEYltxp8O/AUVnR29oBLWOIjIAcHY5YGjIaGj1O2KE
 RJEe/FfDWlsSkqSsUa/A+9BP
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 17:52:42 -0700
IronPort-SDR: Gn5g8VSwtTuAM987HQ7IsncIpPCKVwHRuo82qirBXlhwiZY6OCapxAdLo3K0JKxQ0nsUv3OI18
 FovLrFQg1BUMcyLBZJpm1d11tboMzUD8IS70bjreg+ngliYjAPNyxwC7FhErMFYRqLUkhr1hT3
 yYpSfgxdBj2LI4VAQSo9zeibuZ07XLAmcUQgoyYYuiswFN+5AtpKXU/jAqlu0sFclf/OTq/Tjg
 NJRz7N+wL3EYzs/+AhG6minvy5QnklJx+lr+S4kMiW/K6NzEmr3k+wY0qybcUXTRReokt/Vhfi
 k74=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.55.91])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Aug 2021 18:17:26 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/2] add columns for zoned parameters
Date:   Tue, 24 Aug 2021 10:17:16 +0900
Message-Id: <20210824011718.300747-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Several parameters for zoned devices are missing from lsblk's columns. This
series introduces them as following.

 Column Name      Description             Sysfs path
 ---------------------------------------------------------------------
 ZONE-SIZE        zone size               queue/chunk_sectors
 ZONE-WGRAN       zone write granularity  queue/zone_write_granularity
 ZONE-APPEND      zone append max bytes   queue/zone_append_max_bytes
 ZONES-NR         number of zones         queue/nr_zones
 ZONES-OMAX       max open zones          queue/max_open_zones
 ZONES-AMAX       max active zones        queue/max_active_zones

Sample output:

$ lsblk -o NAME,ZONED,ZONE-SIZE,ZONE-WGRAN,ZONE-APPEND,ZONES-NR,ZONES-OMAX,ZONES-AMAX -i
NAME        ZONED        ZONE-SIZE ZONE-WGRAN ZONE-APPEND ZONES-NR ZONES-OMAX ZONES-AMAX
sda         host-managed      256M         4K        672K    55880        128          0
sdb         host-managed      256M         4K        672K    55880        128          0
zram0       none                0B         0B          0B        0          0          0
nvme2n1     none                0B         0B          0B        0          0          0
|-nvme2n1p1 none                0B         0B          0B        0          0          0
|-nvme2n1p2 none                0B         0B          0B        0          0          0
`-nvme2n1p3 none                0B         0B          0B        0          0          0
nvme0n1     none                0B         0B          0B        0          0          0
nvme1n1     none                0B         0B          0B        0          0          0
nvme0n2     host-managed        2G         4K          4M     1844         14         14
nvme1n2     host-managed        2G         4K          4M     1844         14         14

$ lsblk --help|grep -i zone
 -z, --zoned          print zone model
        ZONED  zone model
    ZONE-SIZE  zone size
   ZONE-WGRAN  zone write granularity
  ZONE-APPEND  zone append max bytes
     ZONES-NR  number of zones
   ZONES-OMAX  max open zones
   ZONES-AMAX  max active zones


Naohiro Aota (2):
  lsblk: factor out function to read sysfs param as bytes
  lsblk: add columns of zoned parameters

 misc-utils/lsblk.c | 95 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 71 insertions(+), 24 deletions(-)

-- 
2.33.0

