Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:59448 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754540AbcDFHQQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Apr 2016 03:16:16 -0400
Received: from tenfore.ga-group.nl ([2.247.82.193]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0MdnN3-1bB8G80lq9-00Pegu for
 <util-linux@vger.kernel.org>; Wed, 06 Apr 2016 09:16:13 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/3] tests: fix fdisk/bsd for hppa
Date: Wed,  6 Apr 2016 09:16:10 +0200
Message-Id: <1459926971-26313-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1459926971-26313-1-git-send-email-sweet_f_a@gmx.de>
References: <1459926971-26313-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/fdisk/bsd | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/ts/fdisk/bsd b/tests/ts/fdisk/bsd
index 8d2e762..19e999b 100755
--- a/tests/ts/fdisk/bsd
+++ b/tests/ts/fdisk/bsd
@@ -46,7 +46,8 @@ BYTE_ORDER=$($TS_HELPER_SYSINFO byte-order)
 # and also on arch-specific offset (see include/pt-bsd.h)
 ARCH=$(uname -m)
 case $ARCH in
-	*ppc* | *alpha* | *ia64*) 
+	# see include/pt-bsd.h
+	*alpha* | *ppc* | *ia64* | *hppa* )
 		BSD_LABELSECTOR=0
 		BSD_LABELOFFSET=64 
 		;;
-- 
1.8.4.5

