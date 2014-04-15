Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f182.google.com ([209.85.212.182]:42221 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116AbaDOLP7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 15 Apr 2014 07:15:59 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so5457410wiv.9
        for <util-linux@vger.kernel.org>; Tue, 15 Apr 2014 04:15:58 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Bernhard Voelker <mail@bernhard-voelker.de>
Subject: [PATCH 7/9] tests: check kill all user processes
Date: Tue, 15 Apr 2014 12:15:33 +0100
Message-Id: <1397560535-14622-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
References: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

CC: Bernhard Voelker <mail@bernhard-voelker.de>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh                 |  1 +
 tests/expected/kill/all_processes |  5 ++++
 tests/ts/kill/all_processes       | 61 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 tests/expected/kill/all_processes
 create mode 100755 tests/ts/kill/all_processes

diff --git a/tests/commands.sh b/tests/commands.sh
index 33bb1ab..8ba0325 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -66,6 +66,7 @@ TS_CMD_REV=${TS_CMD_REV:-"$top_builddir/rev"}
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
index 0000000..c85f856
--- /dev/null
+++ b/tests/ts/kill/all_processes
@@ -0,0 +1,61 @@
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
+. "$TS_TOPDIR/functions.sh"
+ts_init "$*"
+
+ts_skip_nonroot
+
+ts_check_test_command "$TS_CMD_KILL"
+ts_check_test_command "$TS_CMD_SU"
+
+if ! getent passwd nobody >/dev/null; then
+	ts_skip "no nobody user"
+fi
+
+TEST_PID=''
+TS_CWD="${0%/*}"
+HELPER_SYMLINK="$TS_CWD/$(mktemp -u XXXXXXXXXXXXXXX)"
+ln -s "$TS_HELPER_SIGRECEIVE" "$HELPER_SYMLINK"
+trap "rm -f $HELPER_SYMLINK" 0
+
+su nobody -s /bin/sh -c "$HELPER_SYMLINK $TS_CWD/nobody" >> "$TS_OUTPUT" 2>&1 &
+# test_sigreceive needs time to start up
+for i in 0.01 0.1 1 1 1 1; do
+	test -f "$TS_CWD/nobody" && { up=1; break; }
+	sleep $i
+done
+
+echo "test 1" >> "$TS_OUTPUT"
+"$TS_CMD_KILL" ${HELPER_SYMLINK##*/} >> "$TS_OUTPUT" 2>&1
+if [ $? -ne 1 ]; then
+	echo "kill did not return 1" >> "$TS_OUTPUT"
+fi
+echo "test 2" >> "$TS_OUTPUT"
+"$TS_CMD_KILL" -a ${HELPER_SYMLINK##*/} >> "$TS_OUTPUT" 2>&1
+if [ $? -ne 0 ]; then
+	echo "kill did not return 0" >> "$TS_OUTPUT"
+fi
+echo "test 3" >> "$TS_OUTPUT"
+"$TS_CMD_KILL" -a -p ${HELPER_SYMLINK##*/} >> "$TS_OUTPUT" 2>&1
+if [ $? -ne 1 ]; then
+	echo "kill -a -p did not return 1" >> "$TS_OUTPUT"
+fi
+
+sed -i "s/${HELPER_SYMLINK##*/}/${TS_HELPER_SIGRECEIVE##*/}/" "$TS_OUTPUT"
+
+ts_finalize
-- 
1.9.2

