Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:51033 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756043AbaDLK3D (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 12 Apr 2014 06:29:03 -0400
Received: by mail-wg0-f46.google.com with SMTP id b13so6296654wgh.17
        for <util-linux@vger.kernel.org>; Sat, 12 Apr 2014 03:29:01 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 5/7] tests: check various ways to specify kill signal
Date: Sat, 12 Apr 2014 11:28:42 +0100
Message-Id: <1397298524-3364-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1397298524-3364-1-git-send-email-kerolasa@iki.fi>
References: <1397298524-3364-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/kill/options |  1 +
 tests/ts/kill/options       | 63 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 tests/expected/kill/options
 create mode 100755 tests/ts/kill/options

diff --git a/tests/expected/kill/options b/tests/expected/kill/options
new file mode 100644
index 0000000..d48ce72
--- /dev/null
+++ b/tests/expected/kill/options
@@ -0,0 +1 @@
+all ok
diff --git a/tests/ts/kill/options b/tests/ts/kill/options
new file mode 100755
index 0000000..6cf2251
--- /dev/null
+++ b/tests/ts/kill/options
@@ -0,0 +1,63 @@
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
+TS_DESC="options"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_KILL"
+ts_check_test_command "$TS_CMD_FLOCK"
+all_ok=true
+
+try_option()
+{
+	$TS_HELPER_SIGRECEIVE &
+	TEST_PID=$(jobs -p)
+	# test_sigreceive needs time to start up
+	sleep 0.01
+	$TS_CMD_KILL $@ ${TS_HELPER_SIGRECEIVE##*/} >> $TS_OUTPUT 2>&1
+	if [ $? -ne 0 ]; then
+		echo "kill $@ did not work" >> $TS_OUTPUT
+		all_ok=false
+	fi
+	wait $TEST_PID
+	if [ $? -ne 1 ]; then
+		echo "wait $TEST_PID for $@ did not work" >> $TS_OUTPUT
+		all_ok=false
+	fi
+}
+
+# parallel kill checks could kill wrong sigreceiver
+exec 42<$TS_HELPER_SIGRECEIVE
+$TS_CMD_FLOCK 42
+
+try_option -s 1
+try_option --signal 1
+try_option --signal HUP
+try_option --signal SIGHUP
+try_option -q HUP
+try_option --queue HUP
+try_option -1
+try_option -HUP
+try_option -SIGHUP
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

