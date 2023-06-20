Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AC2EB64D9
	for <util-linux@archiver.kernel.org>; Tue, 20 Jun 2023 01:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjFTBdC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 19 Jun 2023 21:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFTBdB (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 19 Jun 2023 21:33:01 -0400
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF83B1A7
        for <util-linux@vger.kernel.org>; Mon, 19 Jun 2023 18:32:56 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
        by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4649101c466f-6c4d7;
        Tue, 20 Jun 2023 09:32:53 +0800 (CST)
X-RM-TRANSID: 2ee4649101c466f-6c4d7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.96])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee3649101c35c4-4779e;
        Tue, 20 Jun 2023 09:32:53 +0800 (CST)
X-RM-TRANSID: 2ee3649101c35c4-4779e
From:   zhujun2 <zhujun2@cmss.chinamobile.com>
To:     util-linux@vger.kernel.org
Cc:     kzak@redhat.com, tytso@mit.edu,
        zhujun2 <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] blkid: solve a bug that the disk device of the ceph_bluestore
Date:   Tue, 20 Jun 2023 09:32:45 +0800
Message-Id: <20230620013245.8915-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

file system, the disk by-partlabel probability loss problem

The superblock of ceph_bluestore exists in the first 1024 bytes, and the
real data is stored after 8K (that is, 16 sectors). By checking the source
code of blkid, it is found to check whether it is the xfs_external_log file
system, which is to cycle through the first 256k data range (the first
512 sectors ). That is to say, when blkid judges whether the partition is
an xfs_external_log file system, it will mistakenly judge the real data of
ceph_bluestore. This means that if the user's data itself conforms to
the xfs_external_log format and is stored in sectors 17~512, it will be mistakenly
considered as the xfs_external_log file system.

Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
---
 libblkid/src/superblocks/xfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libblkid/src/superblocks/xfs.c b/libblkid/src/superblocks/xfs.c
index d8c6fb6d4..3686bd52b 100644
--- a/libblkid/src/superblocks/xfs.c
+++ b/libblkid/src/superblocks/xfs.c
@@ -259,6 +259,11 @@ static int probe_xfs_log(blkid_probe pr,
 		if (memcmp(&buf[i*512], "XFSB", 4) == 0)
 			return 1;
 
+		if (memcmp(&buf[i*512], "bluestore block device", 22) == 0) {
+			DBG(LOWPROBE, ul_debug("\t device has ceph_bluestore ambivalent"));
+			return 1;
+		}
+
 		rhead = (struct xlog_rec_header *)&buf[i*512];
 
 		if (xlog_valid_rec_header(rhead)) {
-- 
2.20.1



