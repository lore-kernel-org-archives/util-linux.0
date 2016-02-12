Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:62021 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204AbcBLQXW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Feb 2016 11:23:22 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0MEnX8-1aENFK1Z74-00FzdA for
 <util-linux@vger.kernel.org>; Fri, 12 Feb 2016 17:23:20 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] tests: mkfs.ext3 image-file needs option -F
Date: Fri, 12 Feb 2016 17:23:18 +0100
Message-Id: <1455294198-25046-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <201507021206.47499.sweet_f_a@gmx.de>
References: <201507021206.47499.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Maybe on newer systems it's not needed anymore.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/mount/fstab-loop | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ts/mount/fstab-loop b/tests/ts/mount/fstab-loop
index 3178b95..9e17943 100755
--- a/tests/ts/mount/fstab-loop
+++ b/tests/ts/mount/fstab-loop
@@ -30,7 +30,7 @@ ts_check_prog "mkfs.ext3"
 
 IMG=$(ts_image_init)
 
-mkfs.ext3 $IMG &> /dev/null || ts_die "Cannot make ext3 on $DEVICE"
+mkfs.ext3 -F $IMG &> /dev/null || ts_die "Cannot make ext3 on $IMG"
 
 [ -d "$TS_MOUNTPOINT-1" ] || mkdir -p $TS_MOUNTPOINT-1
 [ -d "$TS_MOUNTPOINT-2" ] || mkdir -p $TS_MOUNTPOINT-2
-- 
1.8.4.5

