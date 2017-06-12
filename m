Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:57917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751949AbdFLIuB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 12 Jun 2017 04:50:01 -0400
Received: from adsiz.fritz.box ([146.52.24.88]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0McR00-1dbrvj0rIG-00Hbwg for
 <util-linux@vger.kernel.org>; Mon, 12 Jun 2017 10:49:59 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/6] tests: fix fincore, don't use variable COLUMNS
Date: Mon, 12 Jun 2017 10:49:53 +0200
Message-Id: <20170612084958.22054-2-sweet_f_a@gmx.de>
In-Reply-To: <20170612084958.22054-1-sweet_f_a@gmx.de>
References: <20170612084958.22054-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

COLUMNS is automatically set by bash and may result in stupid
errors like

  fincore: unknown column: 160

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/fincore/count | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/ts/fincore/count b/tests/ts/fincore/count
index 7a1c5d426..0151016ee 100755
--- a/tests/ts/fincore/count
+++ b/tests/ts/fincore/count
@@ -70,7 +70,7 @@ function run_dd_test
 		_dd if=/dev/zero of=$input count=1 bs=$bs $flags || return
     fi
 
-    $TS_CMD_FINCORE --output $COLUMNS  --bytes --noheadings $input
+    $TS_CMD_FINCORE --output $OUT_COLUMNS  --bytes --noheadings $input
 
     footer "$?"
 }
@@ -90,7 +90,7 @@ function run_dd_dd_test
     _dd if=/dev/zero of=$input count=1 bs=$bs $flags0 || return
     _dd if=/dev/zero of=$input count=1 bs=$bs $flags1 || return
 
-    $TS_CMD_FINCORE --output $COLUMNS --bytes --noheadings $input
+    $TS_CMD_FINCORE --output $OUT_COLUMNS --bytes --noheadings $input
 
     footer "$?"
 }
@@ -102,10 +102,10 @@ WINDOW_SIZE=$(( 32 * 1024 * PAGE_SIZE ))
 # we use PAGE_SIZE dependent output for a few systems
 if test -f "$TS_EXPECTED.$PAGE_SIZE"; then
 	TS_EXPECTED+=".$PAGE_SIZE"
-	COLUMNS="PAGES,SIZE,FILE"
+	OUT_COLUMNS="PAGES,SIZE,FILE"
 else
 	TS_EXPECTED+=".nosize"
-	COLUMNS="PAGES,FILE"
+	OUT_COLUMNS="PAGES,FILE"
 fi
 
 
@@ -122,7 +122,7 @@ input=
     INPUT="${INPUT} ${input}"
 
     header "NO EXCITING FILE"
-    $TS_CMD_FINCORE --output $COLUMNS --bytes --noheadings $input
+    $TS_CMD_FINCORE --output $OUT_COLUMNS --bytes --noheadings $input
     footer "$?"
 } >> $TS_OUTPUT 2>&1
 
@@ -220,7 +220,7 @@ input=
 
 {
     header "MULTIPLE FILES"
-    $TS_CMD_FINCORE --output $COLUMNS --bytes $INPUT
+    $TS_CMD_FINCORE --output $OUT_COLUMNS --bytes $INPUT
     footer "$?"
 } >> $TS_OUTPUT 2>&1
 
-- 
2.12.3

