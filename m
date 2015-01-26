Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:64203 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754743AbbAZNjT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 Jan 2015 08:39:19 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LpPg1-1XkH1E37VF-00fCzL for
 <util-linux@vger.kernel.org>; Mon, 26 Jan 2015 14:39:17 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/3] tests: fix swaplabel test for 9a83b03c
Date: Mon, 26 Jan 2015 14:39:15 +0100
Message-Id: <1422279556-8846-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1422279556-8846-1-git-send-email-sweet_f_a@gmx.de>
References: <1422279556-8846-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/misc/swaplabel | 2 +-
 tests/ts/misc/swaplabel       | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/expected/misc/swaplabel b/tests/expected/misc/swaplabel
index fd442af..623139e 100644
--- a/tests/expected/misc/swaplabel
+++ b/tests/expected/misc/swaplabel
@@ -1,6 +1,6 @@
 mkswap: error: swap area needs to be at least 10 pages
 mkswap: Label was truncated.
-Setting up swapspace version 1, size = 9 pages
+Setting up swapspace version 1, size = 9 pages (9xPGSZ bytes)
 LABEL=1234567890abcde, UUID=12345678-abcd-abcd-abcd-1234567890ab
 LABEL: 1234567890abcde
 UUID:  12345678-abcd-abcd-abcd-1234567890ab
diff --git a/tests/ts/misc/swaplabel b/tests/ts/misc/swaplabel
index 052ee18..8f29360 100755
--- a/tests/ts/misc/swaplabel
+++ b/tests/ts/misc/swaplabel
@@ -51,7 +51,8 @@ $TS_CMD_MKSWAP \
 	--label 1234567890abcdef \
 	--uuid 12345678-abcd-abcd-abcd-1234567890ab \
 	$IMAGE 2>&1 |\
-	sed "s/ $(( $MIN_SWAP_SIZE_KB - $PAGE_SIZE_KB )) KiB/ 9 pages/" \
+	sed -e "s/ $(( $MIN_SWAP_SIZE_KB - $PAGE_SIZE_KB )) KiB/ 9 pages/" \
+	    -e "s/($((9 * $PAGE_SIZE)) bytes)/(9xPGSZ bytes)/" \
 	>> $TS_OUTPUT 2>&1
 $TS_CMD_SWAPLABEL $IMAGE >> $TS_OUTPUT 2>&1
 
-- 
1.8.4.5

