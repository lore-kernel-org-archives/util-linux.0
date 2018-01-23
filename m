Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:62286 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752202AbeAWP7c (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 23 Jan 2018 10:59:32 -0500
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M86Cn-1ezmvj3gTx-00vcDz for <util-linux@vger.kernel.org>; Tue, 23 Jan 2018
 16:59:30 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 6/7] tests: fix fincore/count KNOWN_FAIL
Date: Tue, 23 Jan 2018 16:59:27 +0100
Message-Id: <20180123155928.7629-7-sweet_f_a@gmx.de>
In-Reply-To: <20180123155928.7629-1-sweet_f_a@gmx.de>
References: <20180123155928.7629-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

It has to be set after calling ts_init.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/fincore/count | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/ts/fincore/count b/tests/ts/fincore/count
index c2dff7e34..46700a32e 100755
--- a/tests/ts/fincore/count
+++ b/tests/ts/fincore/count
@@ -3,15 +3,14 @@
 TS_TOPDIR="${0%/*}/../.."
 TS_DESC="count file contents in core"
 
-# Send patch if you know how to keep it portable and robust. Thanks.
-TS_KNOWN_FAIL="yes"
-
-
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
 ts_check_test_command "$TS_HELPER_SYSINFO"
 
+# Send patch if you know how to keep it portable and robust. Thanks.
+TS_KNOWN_FAIL="yes"
+
 function header
 {
     echo "[" "$1" "]"
-- 
2.13.6

