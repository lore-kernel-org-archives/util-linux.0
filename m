Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:51036 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757567AbaE2PZJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 May 2014 11:25:09 -0400
Received: from tenfore.ga-group.nl ([77.12.144.175]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0Lx4dh-1WneZu3U2T-016kDT for
 <util-linux@vger.kernel.org>; Thu, 29 May 2014 17:25:07 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] tests: fix fdisk/bsd for big endian systems
Date: Thu, 29 May 2014 17:25:07 +0200
Message-Id: <1401377107-23101-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <201405291701.55218.sweet_f_a@gmx.de>
References: <201405291701.55218.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/fdisk/bsd | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/ts/fdisk/bsd b/tests/ts/fdisk/bsd
index 7e3c787..32b3f31 100755
--- a/tests/ts/fdisk/bsd
+++ b/tests/ts/fdisk/bsd
@@ -39,6 +39,17 @@ FDISK_CMD_BSD_LIST_TYPES="b\nl\nq\n"         # list supported PT types and quit
 
 #set -x
 
+# BSD disklabel depends on endianess
+BYTE_ORDER=$($TS_HELPER_SYSINFO byte-order)
+function fdisk_bsd_byte_order_clean
+{
+	[ $BYTE_ORDER = "BE" ] || return
+	sed -i \
+	-e s/2e1cee529cb59c9341afef0443f196a1/c2273b52976351db75596c47c10b0725/\
+	-e s/b5c121c2091b2ff26b880551feac7112/9a234a5b99e37d2ce0d92b65437b93cd/\
+	"$TS_OUTPUT"
+}
+
 function print_layout {
 	echo -ne "\n---layout----------" >> $TS_OUTPUT
 	$TS_CMD_FDISK -l ${TEST_IMAGE_NAME}  >> $TS_OUTPUT
@@ -102,5 +113,6 @@ echo -e "${FDISK_CMD_BSD_LIST_TYPES}" | \
 	$TS_CMD_FDISK ${TEST_IMAGE_NAME} | \
 	sed 's/Reading .*//g; s/Welcome to fdisk .*//' >> $TS_OUTPUT 2>&1
 
+fdisk_bsd_byte_order_clean
 ts_fdisk_clean ${TEST_IMAGE_NAME}
 ts_finalize
-- 
1.8.4.5

