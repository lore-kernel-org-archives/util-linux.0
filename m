Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:60166 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756475Ab1GANvs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Jul 2011 09:51:48 -0400
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Cc: lamont@debian.org
Subject: [PATCH 3/6] mount.8: fix typo
Date: Fri,  1 Jul 2011 15:51:42 +0200
Message-Id: <1309528305-12626-4-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1309528305-12626-1-git-send-email-petr.uzel@suse.cz>
References: <1309528305-12626-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reported-by: Lars Wirzenius <liw@liw.fi>
Addresses: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=605007

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 mount/mount.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mount/mount.8 b/mount/mount.8
index 598280c..4259824 100644
--- a/mount/mount.8
+++ b/mount/mount.8
@@ -1451,7 +1451,7 @@ RAID chunk size in filesystem blocks.
 Deferring block allocation until write-out time.
 .TP
 .BR nodelalloc
-Disable delayed allocation. Blocks are allocation when data is copied from user
+Disable delayed allocation. Blocks are allocated when data is copied from user
 to page cache.
 .TP
 .BI max_batch_time= usec
-- 
1.7.3.4

