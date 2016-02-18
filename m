Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:63475 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946087AbcBRNXP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Feb 2016 08:23:15 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0M8eAd-1Zk5I21uzr-00wEIB for
 <util-linux@vger.kernel.org>; Thu, 18 Feb 2016 14:23:13 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 14/15] libblkid: don't include endian.h
Date: Thu, 18 Feb 2016 14:23:12 +0100
Message-Id: <1455801792-10921-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
References: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libblkid/src/superblocks/drbdmanage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libblkid/src/superblocks/drbdmanage.c b/libblkid/src/superblocks/drbdmanage.c
index d7384df..e84efa3 100644
--- a/libblkid/src/superblocks/drbdmanage.c
+++ b/libblkid/src/superblocks/drbdmanage.c
@@ -11,7 +11,6 @@
  * (a DRBDmanage "cluster"); this file detects its control volume,
  * which is replicated (via DRBD 9) on some of the nodes.
  */
-#include <endian.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -21,6 +20,7 @@
 #include <inttypes.h>
 #include <stddef.h>
 
+#include "bitops.h"
 #include "superblocks.h"
 
 struct drbdmanage_hdr {
-- 
1.8.4.5

