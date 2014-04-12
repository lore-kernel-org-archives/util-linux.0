Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f51.google.com ([74.125.82.51]:40749 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756021AbaDLK3A (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 12 Apr 2014 06:29:00 -0400
Received: by mail-wg0-f51.google.com with SMTP id k14so6439497wgh.22
        for <util-linux@vger.kernel.org>; Sat, 12 Apr 2014 03:28:59 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/7] tests: check kill is converting signals names correctly
Date: Sat, 12 Apr 2014 11:28:41 +0100
Message-Id: <1397298524-3364-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1397298524-3364-1-git-send-email-kerolasa@iki.fi>
References: <1397298524-3364-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh                  |  3 ++
 tests/expected/kill/name_to_number |  1 +
 tests/ts/kill/name_to_number       | 61 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 tests/expected/kill/name_to_number
 create mode 100755 tests/ts/kill/name_to_number

diff --git a/tests/commands.sh b/tests/commands.sh
index 68048fa..c67aa91 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -21,6 +21,7 @@ TS_HELPER_MD5="$top_builddir/test_md5"
 TS_HELPER_MORE=${TS_HELPER_MORE-"$top_builddir/test_more"}
 TS_HELPER_PARTITIONS="$top_builddir/sample-partitions"
 TS_HELPER_PATHS="$top_builddir/test_pathnames"
+TS_HELPER_SIGRECEIVE="$top_builddir/test_sigreceive"
 TS_HELPER_STRUTILS="$top_builddir/test_strutils"
 TS_HELPER_SYSINFO="$top_builddir/test_sysinfo"
 
@@ -37,6 +38,7 @@ TS_CMD_EJECT=${TS_CMD_EJECT-"$top_builddir/eject"}
 TS_CMD_FALLOCATE=${TS_CMD_FALLOCATE-"$top_builddir/fallocate"}
 TS_CMD_FDISK=${TS_CMD_FDISK-"$top_builddir/fdisk"}
 TS_CMD_FINDMNT=${TS_CMD_FINDMNT-"$top_builddir/findmnt"}
+TS_CMD_FLOCK=${TS_CMD_FLOCK:-"$top_builddir/flock"}
 TS_CMD_FSCKCRAMFS=${TS_CMD_FSCKCRAMFS:-"$top_builddir/test_fsck.cramfs"}
 TS_CMD_FSCKMINIX=${TS_CMD_FSCKMINIX:-"$top_builddir/fsck.minix"}
 TS_CMD_GETOPT=${TS_CMD_GETOPT-"$top_builddir/getopt"}
@@ -47,6 +49,7 @@ TS_CMD_IPCMK=${TS_CMD_IPCMK-"$top_builddir/ipcmk"}
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
index 0000000..b6db93a
--- /dev/null
+++ b/tests/ts/kill/name_to_number
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
+TS_DESC="name_to_number"
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
+	$TS_HELPER_SIGRECEIVE &
+	TEST_PID=$(jobs -p)
+	# test_sigreceive needs time to start up
+	sleep 0.01
+	$TS_CMD_KILL -$SIG ${TS_HELPER_SIGRECEIVE##*/} >> $TS_OUTPUT 2>&1
+	wait $TEST_PID
+	if [ $? -ne $EXPECTED ]; then
+		echo "$SIG returned $? while $EXPECTED was expected" >> $TS_OUTPUT
+		all_ok=false
+	fi
+done
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

