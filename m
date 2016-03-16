Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:58985 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbcCPAky (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Mar 2016 20:40:54 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] tests: fix fdisk/bsd for alpha
Date: Wed, 16 Mar 2016 01:40:44 +0100
Message-Id: <1458088844-23523-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

There are special __alpha__ ifdefs in libfdisk/src/bsd.c
Regarding 565964a9 and a80886e9.

BTW it was a bad idea to use md5sum. In case of failure it
would be much easier to debug hexdump diffs. Now it's nearly
impossible to collect all these exotic hexdumps.

CC: Andreas Henriksson <andreas@fatal.se>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/fdisk/bsd | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/ts/fdisk/bsd b/tests/ts/fdisk/bsd
index cd7a6c6..347c0d0 100755
--- a/tests/ts/fdisk/bsd
+++ b/tests/ts/fdisk/bsd
@@ -51,7 +51,7 @@ function fdisk_bsd_offset_and_byte_order_clean
 		local md5_bsdimg1_LE_0_64="2e1cee529cb59c9341afef0443f196a1"
 		local md5_bsdimg2_LE_0_64="b5c121c2091b2ff26b880551feac7112"
 
-        if [ $BYTE_ORDER = "BE" ] ; then
+	if [ $BYTE_ORDER = "BE" ] ; then
 		# BSD_LABELSECTOR = 0, BSD_LABELOFFSET = 64
 		sed -i \
 		-e "s/c2273b52976351db75596c47c10b0725/$md5_bsdimg1_LE_0_64/" \
@@ -69,6 +69,15 @@ function fdisk_bsd_offset_and_byte_order_clean
 		-e "s/6d760d7a8ef33b27cc6e27f1e8807d48/$md5_bsdimg1_LE_0_64/" \
 		-e "s/3739c7959adb42693a69edb7a99914e8/$md5_bsdimg2_LE_0_64/" \
 		"$TS_OUTPUT"
+
+		# special case for alpha
+		if grep -q "78a922a80361cb73049bced72e0f8f1d" $TS_OUTPUT; then
+			sed -i \
+				-e "s/78a922a80361cb73049bced72e0f8f1d/$md5_bsdimg1_LE_0_64/" \
+				-e "s/fc2803672a0643ffe46da325629616fc/$md5_bsdimg2_LE_0_64/" \
+				-e 's/\(3 *Version 7 *8 *\)ext2  /\1MS-DOS/' \
+				"$TS_OUTPUT"
+		fi
 	fi
 }
 
-- 
1.8.4.5

