Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49260 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756086AbaDLK3F (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 12 Apr 2014 06:29:05 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi2so2133259wib.5
        for <util-linux@vger.kernel.org>; Sat, 12 Apr 2014 03:29:04 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 6/7] tests: check kill print pid option
Date: Sat, 12 Apr 2014 11:28:43 +0100
Message-Id: <1397298524-3364-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1397298524-3364-1-git-send-email-kerolasa@iki.fi>
References: <1397298524-3364-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/kill/print_pid |  1 +
 tests/ts/kill/print_pid       | 56 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 tests/expected/kill/print_pid
 create mode 100755 tests/ts/kill/print_pid

diff --git a/tests/expected/kill/print_pid b/tests/expected/kill/print_pid
new file mode 100644
index 0000000..d48ce72
--- /dev/null
+++ b/tests/expected/kill/print_pid
@@ -0,0 +1 @@
+all ok
diff --git a/tests/ts/kill/print_pid b/tests/ts/kill/print_pid
new file mode 100755
index 0000000..c2a1ec4
--- /dev/null
+++ b/tests/ts/kill/print_pid
@@ -0,0 +1,56 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="print_pid"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_KILL"
+ts_check_test_command "$TS_CMD_FLOCK"
+all_ok=true
+
+# parallel kill checks could kill wrong sigreceiver
+exec 42<$TS_HELPER_SIGRECEIVE
+$TS_CMD_FLOCK 42
+
+$TS_HELPER_SIGRECEIVE &
+TEST_PID=$(jobs -p)
+# test_sigreceive needs time to start up
+sleep 0.01
+KILL_PID=$($TS_CMD_KILL -p ${TS_HELPER_SIGRECEIVE##*/} 2>> $TS_OUTPUT)
+if [ $? -ne 0 ]; then
+	echo "kill -p did not work" >> $TS_OUTPUT
+	all_ok=false
+fi
+if [ "x$TEST_PID" != "x$KILL_PID" ]; then
+	echo "jobs -p $TEST_PID != kill -p $KILL_PID" >> $TS_OUTPUT
+	all_ok=false
+else
+	$TS_CMD_KILL -1 $TEST_PID
+	wait $TEST_PID
+	if [ $? -ne 1 ]; then
+		echo "wait $TEST_PID for $@ did not work" >> $TS_OUTPUT
+		all_ok=false
+	fi
+fi
+
+$TS_CMD_FLOCK -u 42
+
+if $all_ok; then
+	echo 'all ok' >> $TS_OUTPUT
+fi
+
+ts_finalize
-- 
1.9.2

