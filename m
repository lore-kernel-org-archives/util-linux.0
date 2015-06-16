Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:63040 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755065AbbFPO1C (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Jun 2015 10:27:02 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MGBB1-1ZJwVY0v5T-00FErP for
 <util-linux@vger.kernel.org>; Tue, 16 Jun 2015 16:26:59 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] tests: always kill helper
Date: Tue, 16 Jun 2015 16:26:57 +0200
Message-Id: <1434464817-8851-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1434464817-8851-1-git-send-email-sweet_f_a@gmx.de>
References: <1434464817-8851-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/kill/print_pid | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/ts/kill/print_pid b/tests/ts/kill/print_pid
index 1b3052b..c6187f1 100755
--- a/tests/ts/kill/print_pid
+++ b/tests/ts/kill/print_pid
@@ -41,13 +41,13 @@ fi
 if [ "x$TEST_PID" != "x$KILL_PID" ]; then
 	echo "jobs -p $TEST_PID != kill -p $KILL_PID" >> "$TS_OUTPUT"
 	all_ok=false
-else
-	"$TS_CMD_KILL" -1 $TEST_PID
-	wait $TEST_PID
-	if [ $? -ne 1 ]; then
-		echo "wait $TEST_PID returned ${?}" >> "$TS_OUTPUT"
-		all_ok=false
-	fi
+fi
+
+"$TS_CMD_KILL" -1 $TEST_PID
+wait $TEST_PID
+if [ $? -ne 1 ]; then
+	echo "wait $TEST_PID returned ${?}" >> "$TS_OUTPUT"
+	all_ok=false
 fi
 
 if $all_ok; then
-- 
1.8.4.5

