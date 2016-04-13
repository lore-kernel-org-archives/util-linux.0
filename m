Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:33574 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030829AbcDMOgs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Apr 2016 10:36:48 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1aqLuQ-0003mE-66
	for util-linux@vger.kernel.org; Wed, 13 Apr 2016 16:36:46 +0200
Received: from ppp37-190-56-86.pppoe.spdop.ru ([37.190.56.86])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 13 Apr 2016 16:36:46 +0200
Received: from yumkam by ppp37-190-56-86.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 13 Apr 2016 16:36:46 +0200
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: [trivial/cosmetics] [PATCH] losetup: fix outdated comment
Date: Wed, 13 Apr 2016 17:36:36 +0300
Message-ID: <m37fg1pocr.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/x-diff
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>From abb2a420924c792be33aa3ed825b1348ea7d51a9 Mon Sep 17 00:00:00 2001
From: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Date: Wed, 13 Apr 2016 17:30:10 +0300
Subject: [PATCH] losetup: fix outdated comment

--direct-io argument was made optional by
f98d9641a371421640a8f1cfe497030758f86dca, but this comment was not
updated accordingly

Signed-off-by: Yuriy M. Kaminskiy <yumkam@gmail.com>
---
 sys-utils/losetup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index 1d57ab3..2ae6ace 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -626,7 +626,7 @@ int main(int argc, char **argv)
 		/*
 		 * losetup [--list] <device>
 		 * OR
-		 * losetup --direct-io DIO <device>
+		 * losetup --direct-io[=off] <device>
 		 */
 		if (!set_dio)
 			act = A_SHOW_ONE;
-- 
2.1.4


