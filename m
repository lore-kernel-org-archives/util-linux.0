Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f181.google.com ([74.125.82.181]:43652 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbaDOLP5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 15 Apr 2014 07:15:57 -0400
Received: by mail-we0-f181.google.com with SMTP id q58so9170595wes.40
        for <util-linux@vger.kernel.org>; Tue, 15 Apr 2014 04:15:55 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Bernhard Voelker <mail@bernhard-voelker.de>
Subject: [PATCH 6/9] tests: check kill print pid option
Date: Tue, 15 Apr 2014 12:15:32 +0100
Message-Id: <1397560535-14622-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
References: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

CC: Bernhard Voelker <mail@bernhard-voelker.de>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/kill/print_pid |  1 +
 tests/ts/kill/print_pid       | 58 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
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
index 0000000..ddb4973
--- /dev/null
+++ b/tests/ts/kill/print_pid
@@ -0,0 +1,58 @@
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
+. "$TS_TOPDIR/functions.sh"
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_KILL"
+all_ok=true
+
+TS_CWD="${0%/*}"
+HELPER_SYMLINK="$TS_CWD/$(mktemp -u XXXXXXXXXXXXXXX)"
+ln -s "$TS_HELPER_SIGRECEIVE" "$HELPER_SYMLINK"
+trap "rm -f $HELPER_SYMLINK" 0
+
+"$HELPER_SYMLINK" "$TS_CWD" >> "$TS_OUTPUT" 2>&1 &
+TEST_PID=$!
+# test_sigreceive needs time to start up
+up=0
+for i in 0.01 0.1 1 1 1 1; do
+	test -f "$TS_CWD/$TEST_PID" && { up=1; break; }
+	sleep $i
+done
+KILL_PID=$("$TS_CMD_KILL" -p ${HELPER_SYMLINK##*/} 2>> "$TS_OUTPUT" 2>&1)
+if [ $? -ne 0 ]; then
+	echo "kill -p did not work" >> "$TS_OUTPUT"
+	all_ok=false
+fi
+if [ "x$TEST_PID" != "x$KILL_PID" ]; then
+	echo "jobs -p $TEST_PID != kill -p $KILL_PID" >> "$TS_OUTPUT"
+	all_ok=false
+else
+	"$TS_CMD_KILL" -1 $TEST_PID
+	wait $TEST_PID
+	if [ $? -ne 1 ]; then
+		echo "wait $TEST_PID returned ${?}" >> "$TS_OUTPUT"
+		all_ok=false
+	fi
+fi
+
+if $all_ok; then
+	echo 'all ok' >> "$TS_OUTPUT"
+fi
+
+ts_finalize
-- 
1.9.2

