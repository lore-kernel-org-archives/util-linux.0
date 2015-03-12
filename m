Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:60205 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbbCLSI3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Mar 2015 14:08:29 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MZwYd-1YrEFY3wQp-00LrDz for
 <util-linux@vger.kernel.org>; Thu, 12 Mar 2015 19:08:28 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] tests: fix fdisk/bsd for ppc64le
Date: Thu, 12 Mar 2015 19:08:26 +0100
Message-Id: <1426183706-30366-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1426183706-30366-1-git-send-email-sweet_f_a@gmx.de>
References: <1426183706-30366-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Actually Aurelien's patch a80886e9 should have addressed this already
because it's the case LE, BSD_LABELSECTOR = 0, BSD_LABELOFFSET = 64.

I've asked about this on mailing list but couldn't get more
informations.
Thread "test fdisk/bsd on exotic archs":
http://comments.gmane.org/gmane.linux.utilities.util-linux-ng/10621

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/fdisk/bsd | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/ts/fdisk/bsd b/tests/ts/fdisk/bsd
index dcad115..b76852c 100755
--- a/tests/ts/fdisk/bsd
+++ b/tests/ts/fdisk/bsd
@@ -66,8 +66,8 @@ function fdisk_bsd_offset_and_byte_order_clean
 	else
 		# BSD_LABELSECTOR = 0, BSD_LABELOFFSET = 64
 		sed -i \
-		-e "s/78a922a80361cb73049bced72e0f8f1d/$md5_bsdimg1_LE_0_64/" \
-		-e "s/fc2803672a0643ffe46da325629616fc/$md5_bsdimg2_LE_0_64/" \
+		-e "s/6d760d7a8ef33b27cc6e27f1e8807d48/$md5_bsdimg1_LE_0_64/" \
+		-e "s/3739c7959adb42693a69edb7a99914e8/$md5_bsdimg2_LE_0_64/" \
 		"$TS_OUTPUT"
 	fi
 }
-- 
1.8.4.5

