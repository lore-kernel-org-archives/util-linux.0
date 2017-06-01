Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:51392 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751374AbdFABIo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 31 May 2017 21:08:44 -0400
Received: from tenfore.ga-group.nl ([77.12.147.210]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MYg42-1dSng81MCw-00VQDZ for
 <util-linux@vger.kernel.org>; Thu, 01 Jun 2017 03:08:42 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/6] tests: handle non glibc error message for fallocate
Date: Thu,  1 Jun 2017 03:08:39 +0200
Message-Id: <1496279320-14541-6-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de>
References: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/misc/fallocate | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/ts/misc/fallocate b/tests/ts/misc/fallocate
index e938abb..b37d025 100755
--- a/tests/ts/misc/fallocate
+++ b/tests/ts/misc/fallocate
@@ -30,9 +30,8 @@ else
 	# fs type of $TS_OUTDIR, could be used to skip this test early
 	fs_type=$(${TS_CMD_FINDMNT} -n -o FSTYPE -T ${TS_OUTDIR})
 
-	test "$(<$TS_OUTPUT)" \
-	     = "fallocate: fallocate failed: Operation not supported" \
-	&& ts_skip "'${fs_type}' not supported"
+	grep -qi "fallocate: fallocate failed:.*not supported" $TS_OUTPUT \
+		&& ts_skip "'${fs_type}' not supported"
 fi
 
 rm -f $IMAGE
-- 
1.8.5.6

