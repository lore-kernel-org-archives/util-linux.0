Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f176.google.com ([74.125.82.176]:35807 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbaDOLPv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 15 Apr 2014 07:15:51 -0400
Received: by mail-we0-f176.google.com with SMTP id x48so9089599wes.7
        for <util-linux@vger.kernel.org>; Tue, 15 Apr 2014 04:15:50 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Bernhard Voelker <mail@bernhard-voelker.de>
Subject: [PATCH 4/9] tests: check kill is converting signals names correctly
Date: Tue, 15 Apr 2014 12:15:30 +0100
Message-Id: <1397560535-14622-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
References: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

CC: Bernhard Voelker <mail@bernhard-voelker.de>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh                  |  2 ++
 tests/expected/kill/name_to_number |  1 +
 tests/ts/kill/name_to_number       | 64 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 tests/expected/kill/name_to_number
 create mode 100755 tests/ts/kill/name_to_number

diff --git a/tests/commands.sh b/tests/commands.sh
index 68048fa..33bb1ab 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -21,6 +21,7 @@ TS_HELPER_MD5="$top_builddir/test_md5"
 TS_HELPER_MORE=${TS_HELPER_MORE-"$top_builddir/test_more"}
 TS_HELPER_PARTITIONS="$top_builddir/sample-partitions"
 TS_HELPER_PATHS="$top_builddir/test_pathnames"
+TS_HELPER_SIGRECEIVE="$top_builddir/test_sigreceive"
 TS_HELPER_STRUTILS="$top_builddir/test_strutils"
 TS_HELPER_SYSINFO="$top_builddir/test_sysinfo"
 
@@ -47,6 +48,7 @@ TS_CMD_IPCMK=${TS_CMD_IPCMK-"$top_builddir/ipcmk"}
 TS_CMD_IPCRM=${TS_CMD_IPCRM-"$top_builddir/ipcrm"}
 TS_CMD_IPCS=${TS_CMD_IPCS:-"$top_builddir/ipcs"}
 TS_CMD_ISOSIZE=${TS_CMD_ISOSIZE-"$top_builddir/isosize"}
+TS_CMD_KILL=${TS_CMD_KILL-"$top_builddir/kill"}
 TS_CMD_LAST=${TS_CMD_LAST-"$top_builddir/last"}
 TS_CMD_LINE=${TS_CMD_LINE-"$top_builddir/line"}
 TS_CMD_LOOK=${TS_CMD_LOOK-"$top_builddir/look"}
diff --git a/tests/expected/kill/name_to_number b/tests/expected/kill/name_to_number
new file mode 100644
index 0000000..d48ce72
--- /dev/null
+++ b/tests/expected/kill/name_to_number
@@ -0,0 +1 @@
+all ok
diff --git a/tests/ts/kill/name_to_number b/tests/ts/kill/name_to_number
new file mode 100755
index 0000000..6e10b8e
--- /dev/null
+++ b/tests/ts/kill/name_to_number
@@ -0,0 +1,64 @@
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
+TS_DESC="name_to_number"
+
+. "$TS_TOPDIR/functions.sh"
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_KILL"
+all_ok=true
+
+TS_CWD="${0%/*}"
+
+for SIG in $($TS_CMD_KILL -L); do
+	if [ "x${SIG//[0-9]/}" = "x" ]; then
+		EXPECTED=$SIG
+		continue
+	fi
+	if [ "x$SIG" = "xSTOP" ] || [ "x$SIG" = "xKILL" ]; then
+		continue
+	fi
+	if [ "x$SIG" = "xRTMIN" ]; then
+		SIG="$SIG+0"
+	fi
+	if [ "x$SIG" = "xRTMAX" ]; then
+		SIG="$SIG-0"
+	fi
+	HELPER_SYMLINK="$TS_CWD/$(mktemp -u XXXXXXXXXXXXXXX)"
+	ln -s "$TS_HELPER_SIGRECEIVE" "$HELPER_SYMLINK"
+	"$HELPER_SYMLINK" "$TS_CWD" >> "$TS_OUTPUT" 2>&1 &
+	TEST_PID=$!
+	# test_sigreceive needs time to start up
+	up=0
+	for i in 0.01 0.1 1 1 1 1; do
+		test -f "$TS_CWD/$TEST_PID" && { up=1; break; }
+		sleep $i
+	done
+	test $up = 0 && echo "$SIG sigreceive ${HELPER_SYMLINK##*/} helper did not start" >> "$TS_OUTPUT"
+	"$TS_CMD_KILL" -$SIG ${HELPER_SYMLINK##*/} >> "$TS_OUTPUT" 2>&1
+	wait $TEST_PID
+	if [ $? -ne $EXPECTED ]; then
+		echo "$SIG returned $? while $EXPECTED was expected" >> "$TS_OUTPUT"
+		all_ok=false
+	fi
+	rm -f "$HELPER_SYMLINK"
+done
+
+if $all_ok; then
+	echo 'all ok' >> $TS_OUTPUT
+fi
+
+ts_finalize
-- 
1.9.2

