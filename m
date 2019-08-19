Return-Path: <SRS0=DPLT=WP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E842C3A59B
	for <util-linux@archiver.kernel.org>; Mon, 19 Aug 2019 08:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC602082C
	for <util-linux@archiver.kernel.org>; Mon, 19 Aug 2019 08:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfHSIdQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 19 Aug 2019 04:33:16 -0400
Received: from mail.windriver.com ([147.11.1.11]:49657 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfHSIdQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 19 Aug 2019 04:33:16 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x7J8XBpl016305
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
        for <util-linux@vger.kernel.org>; Mon, 19 Aug 2019 01:33:11 -0700 (PDT)
Received: from pek-lpggp6.wrs.com (128.224.153.40) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.468.0; Mon, 19 Aug 2019
 01:33:10 -0700
From:   Kevin Hao <kexin.hao@windriver.com>
To:     <util-linux@vger.kernel.org>
Subject: [PATCH] libmount: Keep the mnt_tab info for the existent dest in mnt_copy_fs()
Date:   Mon, 19 Aug 2019 16:30:22 +0800
Message-ID: <20190819083022.12289-1-kexin.hao@windriver.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The "umount -f -a -r" get stuck in a endless loop when run with a
mountinfo like below:
  15 0 179:2 / / ro,relatime - ext4 /dev/root ro
  16 15 0:6 / /dev rw,relatime - devtmpfs devtmpfs rw,size=242896k,nr_inodes=60724,mode=755
  17 15 0:4 / /proc rw,relatime - proc proc rw
  18 15 0:15 / /mnt/.psplash rw,relatime - tmpfs tmpfs rw,size=40k
  19 15 0:16 / /sys rw,relatime - sysfs sysfs rw
  20 19 0:7 / /sys/kernel/debug rw,relatime - debugfs debugfs rw
  21 15 0:17 / /run rw,nosuid,nodev - tmpfs tmpfs rw,mode=755
  22 15 0:18 / /var/volatile rw,relatime - tmpfs tmpfs rw
  23 15 179:1 / /boot rw,relatime - vfat /dev/mmcblk0p1 rw,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro
  24 16 0:19 / /dev/pts rw,relatime - devpts devpts rw,gid=5,mode=620,ptmxmode=000
  25 18 0:20 / /mnt/.psplash rw,relatime - tmpfs tmpfs rw,size=40k

The reason is that the two same mnt entry "/mnt/.psplash" will cause
the dst->tab set to NULL when umount this mnt entry the second time.
This will trigger an endless loop in mnt_reset_table() because that
mnt entry is linked on the libmnt_table but its .tab is set to NULL.

Signed-off-by: Kevin Hao <kexin.hao@windriver.com>
---
 libmount/src/fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libmount/src/fs.c b/libmount/src/fs.c
index eb89bb8a39be..4126ee9dce85 100644
--- a/libmount/src/fs.c
+++ b/libmount/src/fs.c
@@ -188,9 +188,10 @@ struct libmnt_fs *mnt_copy_fs(struct libmnt_fs *dest,
 		dest = mnt_new_fs();
 		if (!dest)
 			return NULL;
+
+		dest->tab	 = NULL;
 	}
 
-	dest->tab	 = NULL;
 	dest->id         = src->id;
 	dest->parent     = src->parent;
 	dest->devno      = src->devno;
-- 
2.14.4

