Return-Path: <SRS0=O4jj=OW=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C56C67839
	for <util-linux@archiver.kernel.org>; Thu, 13 Dec 2018 15:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573242086D
	for <util-linux@archiver.kernel.org>; Thu, 13 Dec 2018 15:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573242086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbeLMPDa (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:03:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44481 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbeLMPD3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 13 Dec 2018 10:03:29 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8BEF4750CB
        for <util-linux@vger.kernel.org>; Thu, 13 Dec 2018 15:03:29 +0000 (UTC)
Received: from sulaco.redhat.com (ovpn-116-28.phx2.redhat.com [10.3.116.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F2461019630
        for <util-linux@vger.kernel.org>; Thu, 13 Dec 2018 15:03:29 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH] libblkid: stratis: correct byte order
Date:   Thu, 13 Dec 2018 09:03:28 -0600
Message-Id: <20181213150328.23129-1-tasleson@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 13 Dec 2018 15:03:29 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Stratis superblock is little endian, ensure we retrieve the
number of sectors and initialization time correctly.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 libblkid/src/superblocks/stratis.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libblkid/src/superblocks/stratis.c b/libblkid/src/superblocks/stratis.c
index 7fdee2b38..7a889b2d4 100644
--- a/libblkid/src/superblocks/stratis.c
+++ b/libblkid/src/superblocks/stratis.c
@@ -83,9 +83,9 @@ static int probe_stratis(blkid_probe pr,
 				sizeof(stratis->pool_uuid));
 
 	blkid_probe_sprintf_value(pr, "BLOCKDEV_SECTORS", "%" PRIu64,
-					stratis->sectors);
+				le64_to_cpu(stratis->sectors));
 	blkid_probe_sprintf_value(pr, "BLOCKDEV_INITTIME", "%" PRIu64,
-					stratis->initialization_time);
+				le64_to_cpu(stratis->initialization_time));
 
 	return 0;
 }
-- 
2.17.2

