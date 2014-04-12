Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f180.google.com ([74.125.82.180]:60712 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756089AbaDLK3I (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 12 Apr 2014 06:29:08 -0400
Received: by mail-we0-f180.google.com with SMTP id p61so6446996wes.11
        for <util-linux@vger.kernel.org>; Sat, 12 Apr 2014 03:29:07 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 7/7] tests: check kill all user processes
Date: Sat, 12 Apr 2014 11:28:44 +0100
Message-Id: <1397298524-3364-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1397298524-3364-1-git-send-email-kerolasa@iki.fi>
References: <1397298524-3364-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh                 |  1 +
 tests/expected/kill/all_processes |  5 ++++
 tests/ts/kill/all_processes       | 57 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 tests/expected/kill/all_processes
 create mode 100755 tests/ts/kill/all_processes

diff --git a/tests/commands.sh b/tests/commands.sh
index c67aa91..0da19f2 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -67,6 +67,7 @@ TS_CMD_REV=${TS_CMD_REV:-"$top_builddir/rev"}
 TS_CMD_SCRIPT=${TS_CMD_SCRIPT-"$top_builddir/script"}
 TS_CMD_SETARCH=${TS_CMD_SETARCH-"$top_builddir/setarch"}
 TS_CMD_SETSID=${TS_CMD_SETSID-"$top_builddir/setsid"}
+TS_CMD_SU=${TS_CMD_SU:-"$top_builddir/su"}
 TS_CMD_SWAPLABEL=${TS_CMD_SWAPLABEL:-"$top_builddir/swaplabel"}
 TS_CMD_SWAPOFF=${TS_CMD_SWAPOFF:-"$top_builddir/swapoff"}
 TS_CMD_SWAPON=${TS_CMD_SWAPON:-"$top_builddir/swapon"}
diff --git a/tests/expected/kill/all_processes b/tests/expected/kill/all_processes
new file mode 100644
index 0000000..c428372
--- /dev/null
+++ b/tests/expected/kill/all_processes
@@ -0,0 +1,5 @@
+test 1
+kill: cannot find process "test_sigreceive".
+test 2
+test 3
+kill: cannot find process "test_sigreceive".
diff --git a/tests/ts/kill/all_processes b/tests/ts/kill/all_processes
new file mode 100755
index 0000000..bc304ff
--- /dev/null
+++ b/tests/ts/kill/all_processes
@@ -0,0 +1,57 @@
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
+TS_DESC="all_processes"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_skip_nonroot
+
+ts_check_test_command "$TS_CMD_KILL"
+ts_check_test_command "$TS_CMD_FLOCK"
+ts_check_test_command "$TS_CMD_SU"
+
+if ! getent passwd nobody >/dev/null; then
+	ts_skip "no nobody user"
+fi
+
+# parallel kill checks could kill wrong sigreceiver
+exec 42<$TS_HELPER_SIGRECEIVE
+$TS_CMD_FLOCK 42
+
+su nobody -s /bin/sh -c $TS_HELPER_SIGRECEIVE &
+# test_sigreceive needs time to start up
+sleep 0.01
+
+echo "test 1" >> $TS_OUTPUT
+$TS_CMD_KILL ${TS_HELPER_SIGRECEIVE##*/} >> $TS_OUTPUT 2>&1
+if [ $? -ne 1 ]; then
+	echo "kill did not return 1" >> $TS_OUTPUT
+fi
+echo "test 2" >> $TS_OUTPUT
+$TS_CMD_KILL -a ${TS_HELPER_SIGRECEIVE##*/} >> $TS_OUTPUT 2>&1
+if [ $? -ne 0 ]; then
+	echo "kill did not return 0" >> $TS_OUTPUT
+fi
+echo "test 3" >> $TS_OUTPUT
+$TS_CMD_KILL -a -p ${TS_HELPER_SIGRECEIVE##*/} >> $TS_OUTPUT 2>&1
+if [ $? -ne 1 ]; then
+	echo "kill -a -p did not return 1" >> $TS_OUTPUT
+fi
+
+$TS_CMD_FLOCK -u 42
+
+ts_finalize
-- 
1.9.2

