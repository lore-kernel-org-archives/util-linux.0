Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:64578 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754865AbbAZNjT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 Jan 2015 08:39:19 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0Me5Q2-1Y337r3ydK-00Ps88 for
 <util-linux@vger.kernel.org>; Mon, 26 Jan 2015 14:39:18 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/3] tests: fix fdisk/bsd again for big endian
Date: Mon, 26 Jan 2015 14:39:16 +0100
Message-Id: <1422279556-8846-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1422279556-8846-1-git-send-email-sweet_f_a@gmx.de>
References: <1422279556-8846-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Looks this line was accidentally out-commented in 06d199e8.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/fdisk/bsd | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ts/fdisk/bsd b/tests/ts/fdisk/bsd
index 6b5b47a..381f228 100755
--- a/tests/ts/fdisk/bsd
+++ b/tests/ts/fdisk/bsd
@@ -131,6 +131,6 @@ echo -e "${FDISK_CMD_BSD_LIST_TYPES}" | \
 	$TS_CMD_FDISK ${TEST_IMAGE_NAME} | \
 	sed 's/Reading .*//g; s/Welcome to fdisk .*//' >> $TS_OUTPUT 2>&1
 
-#fdisk_bsd_offset_and_byte_order_clean
+fdisk_bsd_offset_and_byte_order_clean
 ts_fdisk_clean ${TEST_IMAGE_NAME}
 ts_finalize
-- 
1.8.4.5

