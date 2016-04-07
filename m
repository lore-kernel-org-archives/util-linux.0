Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:48864 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366AbcDGV7n (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 7 Apr 2016 17:59:43 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1aoHxl-0003dM-Js
	for util-linux@vger.kernel.org; Thu, 07 Apr 2016 23:59:41 +0200
Received: from ppp37-190-56-86.pppoe.spdop.ru ([37.190.56.86])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Thu, 07 Apr 2016 23:59:41 +0200
Received: from yumkam by ppp37-190-56-86.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Thu, 07 Apr 2016 23:59:41 +0200
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: fsck -l: fix racing between unlock/unlink and open
Date: Fri, 08 Apr 2016 00:59:29 +0300
Message-ID: <m3bn5lqdvi.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--=-=-=
Content-Type: text/plain

Probably, there are better solutions, but I prefer KISS.

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-fsck-fix-racing-between-unlock-and-unlink.patch

>From fcb97ddcbc336bc8860828c47cdaf21c7b1ca655 Mon Sep 17 00:00:00 2001
From: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Date: Fri, 8 Apr 2016 00:38:56 +0300
Subject: [PATCH] fsck: fix racing between unlock/unlink and open

Process A	Process B	Process C
open()
[creates file]
lock()
[succeed]
		open()
		[open existing]
		lock()...
running()
close()
		[...succeed]
unlink()
		running()
				open()
				[creates file] {BAD!}
				lock()
				[succeed] {BAD!}
				running() {BAD!}
		close()

Cons: leaves empty (unlocked/harmless) .lock files in /run/fsck/
Signed-off-by: Yuriy M. Kaminskiy <yumkam@gmail.com>
---
 disk-utils/fsck.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index 05cfbc4..84d2dcc 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -410,7 +410,6 @@ static void unlock_disk(struct fsck_instance *inst)
 		printf(_("Unlocking %s.\n"), inst->lockpath);
 
 	close(inst->lock);			/* unlock */
-	unlink(inst->lockpath);
 
 	free(inst->lockpath);
 
-- 
2.1.4


--=-=-=--

