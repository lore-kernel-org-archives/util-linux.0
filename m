Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:63014 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753195AbdFMPco (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 13 Jun 2017 11:32:44 -0400
Received: from adsiz.fritz.box ([146.52.24.88]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MAkkB-1dWfeQ0Fat-00Brvp for
 <util-linux@vger.kernel.org>; Tue, 13 Jun 2017 17:32:37 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/5] tests: add more tests for line(1)
Date: Tue, 13 Jun 2017 17:32:35 +0200
Message-Id: <20170613153235.11164-6-sweet_f_a@gmx.de>
In-Reply-To: <20170613153235.11164-1-sweet_f_a@gmx.de>
References: <20170613153235.11164-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/misc/line | 18 ++++++++++++++++++
 tests/ts/misc/line       | 28 ++++++++++++++++++++++++----
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/tests/expected/misc/line b/tests/expected/misc/line
index fa7dcebb0..783ef801f 100644
--- a/tests/expected/misc/line
+++ b/tests/expected/misc/line
@@ -1,7 +1,25 @@
+# usually behave like "head -n 1"
 a
 ret: 0
+# never consume more than one line
 1
 2
 ret: 0
+# add a newline
+abc
+ret: 1
+# print one newline on empty input
 
 ret: 1
+# add a newline, return 1 when EOF
+xyz
+ret: 1
+# print one newline on empty input, return 1 when EOF
+
+ret: 1
+# large line of zero bytes
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00100000  0a                                                |.|
+00100001
+ret: 0
diff --git a/tests/ts/misc/line b/tests/ts/misc/line
index 71d5c0424..ec92f7abc 100755
--- a/tests/ts/misc/line
+++ b/tests/ts/misc/line
@@ -20,18 +20,38 @@ ts_init "$*"
 
 ts_check_test_command "$TS_CMD_LINE"
 
-# usually behave like "head -n 1"
+ts_log '# usually behave like "head -n 1"'
 printf "a\nb\n" |
-	$TS_CMD_LINE > $TS_OUTPUT 2>&1
+	$TS_CMD_LINE >> $TS_OUTPUT 2>&1
 echo "ret: $?" >> $TS_OUTPUT
 
-# never consume more than one line
+ts_log '# never consume more than one line'
 printf "1\n2\n" |
 	($TS_CMD_LINE && $TS_CMD_LINE) >> $TS_OUTPUT 2>&1
 echo "ret: $?" >> $TS_OUTPUT
 
-# always print one newline, return 1 on EOF
+ts_log '# add a newline'
+printf "abc" |
+	$TS_CMD_LINE >> $TS_OUTPUT 2>&1
+echo "ret: $?" >> $TS_OUTPUT
+
+ts_log '# print one newline on empty input'
+printf "" |
+	$TS_CMD_LINE >> $TS_OUTPUT 2>&1
+echo "ret: $?" >> $TS_OUTPUT
+
+ts_log '# add a newline, return 1 when EOF'
+(printf "xyz" && cat </dev/null) |
+	$TS_CMD_LINE >> $TS_OUTPUT 2>&1
+echo "ret: $?" >> $TS_OUTPUT
+
+ts_log '# print one newline on empty input, return 1 when EOF'
 $TS_CMD_LINE </dev/null >> $TS_OUTPUT 2>&1
 echo "ret: $?" >> $TS_OUTPUT
 
+ts_log '# large line of zero bytes'
+dd if=/dev/zero  bs=1K count=1K 2>/dev/null |
+	$TS_CMD_LINE line | hexdump -C >> $TS_OUTPUT 2>&1
+echo "ret: $?" >> $TS_OUTPUT
+
 ts_finalize
-- 
2.12.3

