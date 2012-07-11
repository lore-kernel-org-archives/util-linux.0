Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34550 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab2GKMue (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 11 Jul 2012 08:50:34 -0400
Received: by pbbrp8 with SMTP id rp8so1972335pbb.19
        for <util-linux-ng@vger.kernel.org>; Wed, 11 Jul 2012 05:50:34 -0700 (PDT)
From: Eryu Guan <guaneryu@gmail.com>
To: util-linux-ng@vger.kernel.org
Cc: Eryu Guan <guaneryu@gmail.com>
Subject: [PATCH] mount.8: mount option inode_readahead for ext4 should be inode_readahead_blks
Date: Wed, 11 Jul 2012 20:49:54 +0800
Message-Id: <1342010994-4085-1-git-send-email-guaneryu@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mount option inode_readahead should be inode_readahead_blks. Also the
value should be a power of 2.

Signed-off-by: Eryu Guan <guaneryu@gmail.com>
---
 sys-utils/mount.8 |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 0fb2448..3ddd3f1 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -1490,10 +1490,10 @@ with other ext4 mount options.
 
 The ext4 filesystem enables write barriers by default.
 .TP
-.BI inode_readahead= n
+.BI inode_readahead_blks= n
 This tuning parameter controls the maximum number of inode table blocks that
 ext4's inode table readahead algorithm will pre-read into the buffer cache.
-The default value is 32 blocks.
+The value must be a power of 2. The default value is 32 blocks.
 .TP
 .BI stripe= n
 Number of filesystem blocks that mballoc will try to use for allocation size
-- 
1.7.10.4

