Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:58313 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946087AbcBRNXD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Feb 2016 08:23:03 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0MbsV8-1aEAwF0MSc-00JKTy for
 <util-linux@vger.kernel.org>; Thu, 18 Feb 2016 14:23:01 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 12/15] lib: remove unused variable
Date: Thu, 18 Feb 2016 14:22:59 +0100
Message-Id: <1455801779-10822-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
References: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 lib/blkdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/blkdev.c b/lib/blkdev.c
index f6df92d..403e9e4 100644
--- a/lib/blkdev.c
+++ b/lib/blkdev.c
@@ -150,7 +150,6 @@ blkdev_get_size(int fd, unsigned long long *bytes)
 		int part = -1;
 		struct disklabel lab;
 		struct partition *pp;
-		char ch;
 		struct stat st;
 
 		if ((fstat(fd, &st) >= 0) &&
-- 
1.8.4.5

