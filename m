Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:59904 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751216AbdFABIn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 31 May 2017 21:08:43 -0400
Received: from tenfore.ga-group.nl ([77.12.147.210]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M7YF5-1e9b8o0yG7-00xMRI for
 <util-linux@vger.kernel.org>; Thu, 01 Jun 2017 03:08:41 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/6] tests: grep's short option -A is more portable
Date: Thu,  1 Jun 2017 03:08:35 +0200
Message-Id: <1496279320-14541-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de>
References: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Noticed on Alpine Linux/busybox.

Reported-by: Assaf Gordon <assafgordon@gmail.com>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/ipcs/headers | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tests/ts/ipcs/headers b/tests/ts/ipcs/headers
index 5089ea5..475ed56 100755
--- a/tests/ts/ipcs/headers
+++ b/tests/ts/ipcs/headers
@@ -24,35 +24,35 @@ ts_init "$*"
 ts_check_test_command "$TS_CMD_IPCS"
 
 ts_log "test: shm headers"
-$TS_CMD_IPCS -m -t | grep --after-context=1 "^---"  >> $TS_OUTPUT
-$TS_CMD_IPCS -m -p | grep --after-context=1 "^---"  >> $TS_OUTPUT
-$TS_CMD_IPCS -m -c | grep --after-context=1 "^---"  >> $TS_OUTPUT
+$TS_CMD_IPCS -m -t | grep -A1 "^---"  >> $TS_OUTPUT
+$TS_CMD_IPCS -m -p | grep -A1 "^---"  >> $TS_OUTPUT
+$TS_CMD_IPCS -m -c | grep -A1 "^---"  >> $TS_OUTPUT
 $TS_CMD_IPCS -m -l | grep "^---"  >> $TS_OUTPUT
 $TS_CMD_IPCS -m -u | grep "^---"  >> $TS_OUTPUT
 echo >> $TS_OUTPUT
 
 ts_log "test: mesg headers"
-$TS_CMD_IPCS -q -t | grep --after-context=1 "^---"  >> $TS_OUTPUT
-$TS_CMD_IPCS -q -p | grep --after-context=1 "^---"  >> $TS_OUTPUT
-$TS_CMD_IPCS -q -c | grep --after-context=1 "^---"  >> $TS_OUTPUT
+$TS_CMD_IPCS -q -t | grep -A1 "^---"  >> $TS_OUTPUT
+$TS_CMD_IPCS -q -p | grep -A1 "^---"  >> $TS_OUTPUT
+$TS_CMD_IPCS -q -c | grep -A1 "^---"  >> $TS_OUTPUT
 $TS_CMD_IPCS -q -l | grep  "^---"  >> $TS_OUTPUT
 $TS_CMD_IPCS -q -u | grep  "^---"  >> $TS_OUTPUT
 echo >> $TS_OUTPUT
 
 ts_log "test: sem headers"
-$TS_CMD_IPCS -s -t | grep --after-context=1 "^---"  >> $TS_OUTPUT
-$TS_CMD_IPCS -s -p | grep --after-context=1 "^---"  >> $TS_OUTPUT
-$TS_CMD_IPCS -s -c | grep --after-context=1 "^---"  >> $TS_OUTPUT
+$TS_CMD_IPCS -s -t | grep -A1 "^---"  >> $TS_OUTPUT
+$TS_CMD_IPCS -s -p | grep -A1 "^---"  >> $TS_OUTPUT
+$TS_CMD_IPCS -s -c | grep -A1 "^---"  >> $TS_OUTPUT
 $TS_CMD_IPCS -s -l | grep  "^---"  >> $TS_OUTPUT
 $TS_CMD_IPCS -s -u | grep  "^---"  >> $TS_OUTPUT
 echo >> $TS_OUTPUT
 
 ts_log "test: all headers"
-$TS_CMD_IPCS -a | grep --after-context=1 "^---"  >> $TS_OUTPUT
+$TS_CMD_IPCS -a | grep -A1 "^---"  >> $TS_OUTPUT
 
-$TS_CMD_IPCS -a -t | grep --after-context=1 "^---"  >> $TS_OUTPUT
-$TS_CMD_IPCS -a -p | grep --after-context=1 "^---"  >> $TS_OUTPUT
-$TS_CMD_IPCS -a -c | grep --after-context=1 "^---"  >> $TS_OUTPUT
+$TS_CMD_IPCS -a -t | grep -A1 "^---"  >> $TS_OUTPUT
+$TS_CMD_IPCS -a -p | grep -A1 "^---"  >> $TS_OUTPUT
+$TS_CMD_IPCS -a -c | grep -A1 "^---"  >> $TS_OUTPUT
 $TS_CMD_IPCS -a -l | grep "^---"  >> $TS_OUTPUT
 $TS_CMD_IPCS -a -u | grep "^---"  >> $TS_OUTPUT
 
-- 
1.8.5.6

