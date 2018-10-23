Return-Path: <SRS0=SGaj=ND=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78842C46475
	for <util-linux@archiver.kernel.org>; Tue, 23 Oct 2018 09:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7AC20665
	for <util-linux@archiver.kernel.org>; Tue, 23 Oct 2018 09:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ef2/vm0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7AC20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeJWRyL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:54:11 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:25503 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeJWRyL (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 23 Oct 2018 13:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1540287112; x=1571823112;
  h=from:to:cc:subject:date:message-id;
  bh=19Zxf78k9mrXAQCgdw7xStkf/4SUm+16H2GIZblTb3w=;
  b=Ef2/vm0XiImfqizavDv7gNYc6lacmXQBU4H4jbMlKgc/f+FIDUPK7UHH
   tWzpM6NtSsvLUr0UyC1dDweaxjwFWooRJ8HCQpeZhwbD34ZgCgRlxiPVu
   LhSdj2UPpqfOfepTQIqSOjz0D1LOmgx9QttxJEdDW/jsvkLhEHIVuxVw3
   8SeYSLjFcZanjZHK3eYEo2O1oHLWVfh62YN8eOdULMHmbjM+jQF1lCgJT
   dkZ8r7B9YAc+4N+x+VlBjM6X60c9gzQc2G9dJjjVCYu5Ygh9MdqmQITnP
   zft1oU1VE1RreWBWY/ug4LeLJyk5UcJ50bTpqram10JaAexEdAdQ7julW
   w==;
X-IronPort-AV: E=Sophos;i="5.54,415,1534780800"; 
   d="scan'208";a="190278382"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2018 17:31:52 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 23 Oct 2018 02:15:54 -0700
Received: from yusei.dhcp.fujisawa.hgst.com ([10.149.52.150])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2018 02:31:36 -0700
From:   Masato Suzuki <masato.suzuki@wdc.com>
To:     util-linux@vger.kernel.org
Cc:     Damien.LeMoal@wdc.com
Subject: [PATCH] blkzone: fix report zones sector offset check
Date:   Tue, 23 Oct 2018 18:31:35 +0900
Message-Id: <20181023093135.13414-1-masato.suzuki@wdc.com>
X-Mailer: git-send-email 2.14.4
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

To catch an offset error, an offset should be begger than or equal to
a device size in the condition.

Signed-off-by: Masato Suzuki <masato.suzuki@wdc.com>
---
 sys-utils/blkzone.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sys-utils/blkzone.c b/sys-utils/blkzone.c
index b6a3aa46c..1dcbdf500 100644
--- a/sys-utils/blkzone.c
+++ b/sys-utils/blkzone.c
@@ -179,8 +179,9 @@ static int blkzone_report(struct blkzone_control *ctl)
 
 	fd = init_device(ctl, O_RDONLY);
 
-	if (ctl->offset > ctl->total_sectors)
-		errx(EXIT_FAILURE, _("%s: offset is greater than device size"), ctl->devname);
+	if (ctl->offset >= ctl->total_sectors)
+		errx(EXIT_FAILURE,
+		     _("%s: offset is greater than or equal to device size"), ctl->devname);
 
 	zonesize = blkdev_chunk_sectors(ctl->devname);
 	if (!zonesize)
-- 
2.14.4

