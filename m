Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:54223 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292AbbAZNjT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 Jan 2015 08:39:19 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MeMOx-1Y3K6k2CcB-00Q973 for
 <util-linux@vger.kernel.org>; Mon, 26 Jan 2015 14:39:17 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/3] Revert "tests: simplify and update swaplabel test"
Date: Mon, 26 Jan 2015 14:39:14 +0100
Message-Id: <1422279556-8846-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1422279556-8846-1-git-send-email-sweet_f_a@gmx.de>
References: <1422279556-8846-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

After mkswap refactoring we have still a "minimal swap size"
wich depend on PAGE_SIZE. Next commit will fix the test for
output changes made in 9a83b03c.

This reverts commit b4d27255f24cddbdf3480ca0988dada340abe2d3.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/misc/swaplabel | 4 ++--
 tests/ts/misc/swaplabel       | 8 ++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/expected/misc/swaplabel b/tests/expected/misc/swaplabel
index 17c9a6f..fd442af 100644
--- a/tests/expected/misc/swaplabel
+++ b/tests/expected/misc/swaplabel
@@ -1,6 +1,6 @@
-mkswap: error: swap area needs to be at least 40 KiB
+mkswap: error: swap area needs to be at least 10 pages
 mkswap: Label was truncated.
-Setting up swapspace version 1, size = 36 KiB (36864 bytes)
+Setting up swapspace version 1, size = 9 pages
 LABEL=1234567890abcde, UUID=12345678-abcd-abcd-abcd-1234567890ab
 LABEL: 1234567890abcde
 UUID:  12345678-abcd-abcd-abcd-1234567890ab
diff --git a/tests/ts/misc/swaplabel b/tests/ts/misc/swaplabel
index 45f3bb9..052ee18 100755
--- a/tests/ts/misc/swaplabel
+++ b/tests/ts/misc/swaplabel
@@ -41,14 +41,18 @@ fallocate_or_skip $(( $MIN_SWAP_SIZE - 1 )) $IMAGE
 $TS_CMD_MKSWAP \
 	--label 1234567890abcdef \
 	--uuid 12345678-abcd-abcd-abcd-1234567890ab \
-	$IMAGE >> $TS_OUTPUT 2>&1
+	$IMAGE 2>&1 |\
+	sed "s/ $MIN_SWAP_SIZE_KB KiB/ 10 pages/" \
+	>> $TS_OUTPUT 2>&1
 
 rm -f $IMAGE
 fallocate_or_skip $MIN_SWAP_SIZE $IMAGE
 $TS_CMD_MKSWAP \
 	--label 1234567890abcdef \
 	--uuid 12345678-abcd-abcd-abcd-1234567890ab \
-	$IMAGE >> $TS_OUTPUT 2>&1
+	$IMAGE 2>&1 |\
+	sed "s/ $(( $MIN_SWAP_SIZE_KB - $PAGE_SIZE_KB )) KiB/ 9 pages/" \
+	>> $TS_OUTPUT 2>&1
 $TS_CMD_SWAPLABEL $IMAGE >> $TS_OUTPUT 2>&1
 
 #rm -f $IMAGE
-- 
1.8.4.5

