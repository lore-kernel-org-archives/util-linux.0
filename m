Return-Path: <SRS0=YmJi=65=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4D2C433DF
	for <util-linux@archiver.kernel.org>; Fri, 15 May 2020 08:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A7BB2054F
	for <util-linux@archiver.kernel.org>; Fri, 15 May 2020 08:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GOSQmJyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgEOIlv (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 15 May 2020 04:41:51 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:57252 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgEOIlv (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 15 May 2020 04:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589532110; x=1621068110;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ecN2iLewQWIKPCj7QyrvUg4F0AHOuy/cWv+FInpCSnE=;
  b=GOSQmJyA3Sa3j15m5T2rgQinMmTNcx66WJbL8uXSx/A5Q++9edJXMymt
   ehOxV40hzjwxgsYDxNSUHVrva05Dt2keovZT0K00NLxWaqt8dC9JpdxS/
   V0ScFGWZ7HTXRU7iKfh/+2baAc0vrJYzX5RxsXi8muIOFGsz0GNGWcyi3
   A5N+hojyxq4fKq1heGqC0dna6AKqzTpsH/KETmK9MPl4UdWCFFVjBzxlL
   pi218hc5T0Sx5RB1CkenBrAPjCF2NZH3xOR0Bfgn6tnLPriEu4a7LOVRn
   5AXRBEtcsE00/1gVVeHjNQesuQUp/8/wKXgxHvW09OZFe0bAfuOCrk8vM
   g==;
IronPort-SDR: yw/Kq3mNpoQEMe467e4lTR77slzMf/YUnsS4E4WqQzYxzNNNT/MQFBW4qmLvicMYzl2ajNMT2k
 vEHCwDrWDxqyofDyMGvADiBZ8JBfe4n1c8QEZdT/ihQndCezyFw54/wwsMPqAJPIrFL8XzBV0i
 Ax9y9T1SHH6AR83v8kSwNMZZRk35JzVau03rgZHtmG5uoV+kseNFQxZ9eaprwYCUmiih8/fimN
 qLht666zH2CDEjOSLB99DrHfQgv6vDuueAkLzYIicFxh9fNRnzme9OLx8jxgYCJ/RwwMK+y2Hw
 gFM=
X-IronPort-AV: E=Sophos;i="5.73,394,1583164800"; 
   d="scan'208";a="137760996"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2020 16:41:50 +0800
IronPort-SDR: YUMxsUvBynGIy4pa1Jk1dVTBKc33dq1t/NV6dVWupMPeJI3kA/7H+1ETTZcq0kbNLaZ/O+smAd
 4USBZoxcCQow2IvQ1FdCOh0eEtopVlHhY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 01:32:01 -0700
IronPort-SDR: JKDJ8a0WmAJnseWqDWj8TcQAgc4AuCBi/827nukjw+t4ajJhHWkIwQsOb1pKIW3OY5NivWqlLQ
 NqAC5czFrRlA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 May 2020 01:41:48 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Coly Li <colyli@suse.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [PATCH] blkzone: deny destructive ioctls on busy blockdev
Date:   Fri, 15 May 2020 17:41:33 +0900
Message-Id: <20200515084133.21896-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

If a user submits a zone management ioctl from user-space, like a zone
reset and a file-system (like zonefs or f2fs) is mounted on the zoned
block device, the zone will get reset and the file-system's cached value
of the zone's write-pointer becomes invalid.

Subsequent writes to this zone from the file-system will result in
unaligned writes and the drive will error out.

Open the block device file in exclusive mode for submitting these ioctls.
If a file-system is mounted the kernel will return -EBUSY and we can't
continue issuing the ioctl.

Reported-by: Coly Li <colyli@suse.de>
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 sys-utils/blkzone.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sys-utils/blkzone.c b/sys-utils/blkzone.c
index 8d9de2e1bba7..a4b59754616e 100644
--- a/sys-utils/blkzone.c
+++ b/sys-utils/blkzone.c
@@ -301,7 +301,9 @@ static int blkzone_action(struct blkzone_control *ctl)
 	if (!zonesize)
 		errx(EXIT_FAILURE, _("%s: unable to determine zone size"), ctl->devname);
 
-	fd = init_device(ctl, O_WRONLY);
+	fd = init_device(ctl, O_WRONLY | O_EXCL);
+	if (fd < 0)
+		errx(EXIT_FAILURE, _("%s: unable to open"), ctl->devname);
 
 	if (ctl->offset & (zonesize - 1))
 		errx(EXIT_FAILURE, _("%s: offset %" PRIu64 " is not aligned "
-- 
2.24.1

