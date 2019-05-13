Return-Path: <SRS0=wrJr=TN=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEBFC04AB1
	for <util-linux@archiver.kernel.org>; Mon, 13 May 2019 12:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3073120578
	for <util-linux@archiver.kernel.org>; Mon, 13 May 2019 12:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfEMMcq (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 13 May 2019 08:32:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:35084 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728083AbfEMMcq (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 13 May 2019 08:32:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A7E2AEB7;
        Mon, 13 May 2019 12:32:45 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] libblkid: Set BLKID_BID_FL_VERIFIED in case revalidation is not needed
Date:   Mon, 13 May 2019 15:32:42 +0300
Message-Id: <20190513123242.23673-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513123242.23673-1-nborisov@suse.com>
References: <20190513123242.23673-1-nborisov@suse.com>
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

If blkid_verify deems that device revalidation is not needed since BLKID_PROBE_MIN
seconds haven't elapsed since the last revalidation of the device it returns
a blkid_dev. However, if this device has been read from the cache file on disk then 
it wont' have BLKID_BID_FL_VERIFIED bit set. This in turn could lead to a later 
call to blkid_dev_get free this device in case its part of a multi device
configuration. This is particularly relevant to btrfs raid configurations. 

Namely this  was exhibited by btrfs-progs which use blkid for device enumeration.
In case of a multi-device filesystem (i.e raid10) running xfstest btrfs/011
would fail sporadically since cached devices read from cache were not revalidated
due to being recently validated (according to timestamp in the cache file) at 
the same time their in-memory blkid_dev structures didn't have BLKID_BID_FL_VERIFIED
set. This lead to their untimely removal from the cache from blkid_get_dev. 

Fix this by setting the BLKID_BID_FL_VERIFIED when returning from blkid_verify
with a valid device irrespective of whether full revalidation was performed or 
the device is deemed valid due to being recently validated. 

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 libblkid/src/verify.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libblkid/src/verify.c b/libblkid/src/verify.c
index 49fc11d228b8..58b347751e73 100644
--- a/libblkid/src/verify.c
+++ b/libblkid/src/verify.c
@@ -97,7 +97,9 @@ blkid_dev blkid_verify(blkid_cache cache, blkid_dev dev)
 #endif
 	    (diff < BLKID_PROBE_MIN ||
 		dev->bid_flags & BLKID_BID_FL_VERIFIED)) {
+		dev->bid_flags |= BLKID_BID_FL_VERIFIED;
 		return dev;
+	}
 
 #ifndef HAVE_STRUCT_STAT_ST_MTIM_TV_NSEC
 	DBG(PROBE, ul_debug("need to revalidate %s (cache time %lu, stat time %lu,\t"
-- 
2.7.4

