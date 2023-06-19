Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354CAEB64D7
	for <util-linux@archiver.kernel.org>; Mon, 19 Jun 2023 02:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjFSCi4 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 18 Jun 2023 22:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFSCiz (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 18 Jun 2023 22:38:55 -0400
X-Greylist: delayed 183 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Jun 2023 19:38:48 PDT
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45AA81B4
        for <util-linux@vger.kernel.org>; Sun, 18 Jun 2023 19:38:46 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
        by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7648fbef9066-65cba;
        Mon, 19 Jun 2023 10:35:37 +0800 (CST)
X-RM-TRANSID: 2ee7648fbef9066-65cba
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.98])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8648fbef8bf9-26c0f;
        Mon, 19 Jun 2023 10:35:37 +0800 (CST)
X-RM-TRANSID: 2ee8648fbef8bf9-26c0f
From:   zhujun2 <zhujun2@cmss.chinamobile.com>
To:     util-linux@vger.kernel.org
Cc:     zhujun2 <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] blkid: solve a bug that the disk device of the ceph_bluestore
Date:   Mon, 19 Jun 2023 10:35:32 +0800
Message-Id: <20230619023532.16534-1-zhujun2@cmss.chinamobile.com>
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



