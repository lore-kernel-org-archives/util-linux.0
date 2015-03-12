Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:56636 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751540AbbCLSIa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Mar 2015 14:08:30 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LpPg1-1ZANxe3DhF-00f9Qj for
 <util-linux@vger.kernel.org>; Thu, 12 Mar 2015 19:08:27 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] tests: improve readability for fdisk/bsd
Date: Thu, 12 Mar 2015 19:08:25 +0100
Message-Id: <1426183706-30366-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1426183706-30366-1-git-send-email-sweet_f_a@gmx.de>
References: <1426183706-30366-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/fdisk/bsd | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tests/ts/fdisk/bsd b/tests/ts/fdisk/bsd
index 381f228..dcad115 100755
--- a/tests/ts/fdisk/bsd
+++ b/tests/ts/fdisk/bsd
@@ -47,23 +47,27 @@ FDISK_CMD_BSD_LIST_TYPES="b\nl\nq\n"         # list supported PT types and quit
 BYTE_ORDER=$($TS_HELPER_SYSINFO byte-order)
 function fdisk_bsd_offset_and_byte_order_clean
 {
+		# expected md5sums are from x86 systems
+		local md5_bsdimg1_LE_0_64="2e1cee529cb59c9341afef0443f196a1"
+		local md5_bsdimg2_LE_0_64="b5c121c2091b2ff26b880551feac7112"
+
         if [ $BYTE_ORDER = "BE" ] ; then
 		# BSD_LABELSECTOR = 0, BSD_LABELOFFSET = 64
 		sed -i \
-		-e "s/c2273b52976351db75596c47c10b0725/2e1cee529cb59c9341afef0443f196a1/" \
-		-e "s/9a234a5b99e37d2ce0d92b65437b93cd/b5c121c2091b2ff26b880551feac7112/" \
+		-e "s/c2273b52976351db75596c47c10b0725/$md5_bsdimg1_LE_0_64/" \
+		-e "s/9a234a5b99e37d2ce0d92b65437b93cd/$md5_bsdimg2_LE_0_64/" \
 		"$TS_OUTPUT"
 
 		# BSD_LABELSECTOR = 1, BSD_LABELOFFSET = 0
 		sed -i \
-		-e "s/e990c8a1c2106a4cd4b008f16d71aaa6/2e1cee529cb59c9341afef0443f196a1/" \
-		-e "s/187a48c26e83d146b866868addc93702/b5c121c2091b2ff26b880551feac7112/" \
+		-e "s/e990c8a1c2106a4cd4b008f16d71aaa6/$md5_bsdimg1_LE_0_64/" \
+		-e "s/187a48c26e83d146b866868addc93702/$md5_bsdimg2_LE_0_64/" \
 		"$TS_OUTPUT"
 	else
 		# BSD_LABELSECTOR = 0, BSD_LABELOFFSET = 64
 		sed -i \
-		-e "s/78a922a80361cb73049bced72e0f8f1d/2e1cee529cb59c9341afef0443f196a1/" \
-		-e "s/fc2803672a0643ffe46da325629616fc/b5c121c2091b2ff26b880551feac7112/" \
+		-e "s/78a922a80361cb73049bced72e0f8f1d/$md5_bsdimg1_LE_0_64/" \
+		-e "s/fc2803672a0643ffe46da325629616fc/$md5_bsdimg2_LE_0_64/" \
 		"$TS_OUTPUT"
 	fi
 }
-- 
1.8.4.5

