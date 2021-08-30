Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1CBC432BE
	for <util-linux@archiver.kernel.org>; Mon, 30 Aug 2021 05:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF8360F4B
	for <util-linux@archiver.kernel.org>; Mon, 30 Aug 2021 05:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhH3FyD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 30 Aug 2021 01:54:03 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:32306 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhH3FyC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 30 Aug 2021 01:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630302789; x=1661838789;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xLX2T43mPAz9z3qYJZTwYroqN2l8MfA06Wd5SkDvgWo=;
  b=kv0mwL8iibLUdllNJVQ96UYc2BUdXN11QhZM90dxkKzIFB5QrPjCBH+/
   zTl9EiIbeuu3dbp48zajQ/PLyBs9owHNn6oRNKYCowbvCqnE/wtzdxN1x
   PBMBL2/zdv29MPQusPgqbkqiVFitqw18DGYUAw2q4d4gGrnwwCFGVIwJC
   RHAh+7rkArfJTrJ04MXI1TA4anYlOaNH8/HlGHVdE1ZuHFw/q47Id0pVM
   NaPs473TQhU4d7r9CSwtH51ezpNKSYYvIl7n5HTaRX+F8z9Ke3jHBu3w5
   qj/7CjcmGbffA2hsgfw2YeeaQeuDClSz4x2t0WuHc3VQ3C/9f9/unM0C2
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="290337999"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 13:53:09 +0800
IronPort-SDR: YK8HCXj3tusLMsH+hY9usK/S848hHCfNnYGuWcNkXRACeH14IaiRsZ/ck7elPWKI/euAA+P1G+
 WGXr47k5WmYoHbie2P9R5ZJZOcNZfTONZxhuQxD0F0YItHg3StjH7UXFxkIPVvwvcZ/oaeddK2
 yZEpveRExKMMhqf3Brz1UAo/T5AI1C7ZS+9dEFyvCerIh6qPTh9nHT4nswidVBaCPJMZn8ZvDs
 oSdLATmNafE7cQtmvZuu3izRa10k73EfPmEJhqdg/vTeNkeRopxFs6daugrCGfcXpjJma1ECvd
 5rIXBNe9QYO7DMv8f9fKlpxc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 22:30:00 -0700
IronPort-SDR: e7lEZGlL8afjsSrF4HEXXxRv+s7VgDM2FLsU8bnA6oWzvdons1kJ4aabte5/3f/tnTaYcDCE5h
 UpOLlW3vBqtwjLdZXL/G/h4sEl7iuZZ4vbvFDWLF30G156PNJ4GVuvmZfJPVXdYv9NASc7goco
 Y3MPtZLbq6wO39bAB6hJmJweuCGdG2C1txYNwhWFddEi7RnRfIN//5xx5odIoJeGsubjNH1nRa
 /4ew9+dZQMUhM3HqXbeaJhFdjpYFhdTmbXJgs1oFh1HHdronzaeAOzujWRXPT3QBAs7BgBNJY8
 fWs=
WDCIronportException: Internal
Received: from jpf008021.ad.shared (HELO naota-xeon.wdc.com) ([10.225.60.33])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Aug 2021 22:53:09 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Damien.LeMoal@wdc.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 0/3] add columns for zoned parameters
Date:   Mon, 30 Aug 2021 14:52:54 +0900
Message-Id: <20210830055257.1832523-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Several parameters for zoned devices are missing from lsblk's columns. This
series introduces them as following.

 Column Name    Description                     Sysfs path
 ------------------------------------------------------------------
 ZONE-SZ        zone size                       queue/chunk_sectors
 ZONE-WGRAN     zone write granularity          queue/zone_write_granularity
 ZONE-APP       zone append max bytes           queue/zone_append_max_bytes
 ZONE-NR        number of zones                 queue/nr_zones
 ZONE-OMAX      maximum number of open zones    queue/max_open_zones
 ZONE-AMAX      maximum number of active zones  queue/max_active_zones

These columns are also added to the "-z" output.

Sample output:

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

$ lsblk --help|grep -i zone
 -z, --zoned          print zone related information
        ZONED  zone model
      ZONE-SZ  zone size
   ZONE-WGRAN  zone write granularity
     ZONE-APP  zone append max bytes
      ZONE-NR  number of zones
    ZONE-OMAX  maximum number of open zones
    ZONE-AMAX  maximum number of active zones

Naohiro Aota (3):
  lsblk: factor out function to read sysfs param as bytes
  lsblk: add columns of zoned parameters
  lsblk: add zoned columns to "lsblk -z"

 bash-completion/lsblk   |   3 +-
 misc-utils/lsblk.8.adoc |   2 +-
 misc-utils/lsblk.c      | 104 ++++++++++++++++++++++++++++++----------
 3 files changed, 82 insertions(+), 27 deletions(-)

-- 
2.33.0

