Return-Path: util-linux-owner@vger.kernel.org
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:23955 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753444Ab2CIR44 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 9 Mar 2012 12:56:56 -0500
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120309175654.ITNZ15590.mtaout02-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>
          for <util-linux@vger.kernel.org>; Fri, 9 Mar 2012 17:56:54 +0000
Received: from zog.reactivated.net ([86.14.215.141])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120309175653.QFSK5924.aamtaout02-winn.ispmail.ntl.com@zog.reactivated.net>
          for <util-linux@vger.kernel.org>; Fri, 9 Mar 2012 17:56:53 +0000
From: Daniel Drake <dsd@laptop.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] losetup: Fix setting of sizelimit on new loop devices
Message-Id: <20120309175650.E88509D401E@zog.reactivated.net>
Date: Fri,  9 Mar 2012 17:56:50 +0000 (GMT)
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

"losetup --offset 10 --sizelimit 20 foo.img" was producing
a loop device with offset 20 and no sizelimit. Looks like a typo,
fix it.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 sys-utils/losetup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index 16ace6f..9f03151 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -362,7 +362,7 @@ int main(int argc, char **argv)
 			if (flags & LOOPDEV_FL_OFFSET)
 				loopcxt_set_offset(&lc, offset);
 			if (flags & LOOPDEV_FL_SIZELIMIT)
-				loopcxt_set_offset(&lc, sizelimit);
+				loopcxt_set_sizelimit(&lc, sizelimit);
 			if (lo_flags)
 				loopcxt_set_flags(&lc, lo_flags);
 			if ((res = loopcxt_set_backing_file(&lc, file))) {
-- 
1.7.7.6

