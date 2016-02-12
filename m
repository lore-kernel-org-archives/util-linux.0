Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:55891 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751724AbcBLQ2L (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Feb 2016 11:28:11 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] tests: mkfs.ext3 image-file needs option -F
Date: Fri, 12 Feb 2016 17:28:04 +0100
Message-Id: <1455294484-25186-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <201602121723.09217.sweet_f_a@gmx.de>
References: <201602121723.09217.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Maybe on newer systems it's not needed anymore.

CC: Stanislav Brabec <sbrabec@suse.cz>
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

