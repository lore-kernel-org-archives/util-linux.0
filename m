Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33898 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbbJYQFP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 25 Oct 2015 12:05:15 -0400
Received: by wikq8 with SMTP id q8so133904456wik.1
        for <util-linux@vger.kernel.org>; Sun, 25 Oct 2015 09:05:14 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/4] tests: add uuidd output check
Date: Sun, 25 Oct 2015 16:05:00 +0000
Message-Id: <1445789100-1781-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1445789100-1781-1-git-send-email-kerolasa@iki.fi>
References: <1445789100-1781-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh         |  1 +
 tests/expected/uuid/uuidd | 11 +++++++++
 tests/ts/uuid/uuidd       | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 tests/expected/uuid/uuidd
 create mode 100755 tests/ts/uuid/uuidd

diff --git a/tests/commands.sh b/tests/commands.sh
index 84bf661..5518dc3 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -85,6 +85,7 @@ TS_CMD_TAILF=${TS_CMD_TAILF-"$top_builddir/tailf"}
 TS_CMD_UL=${TS_CMD_UL-"$top_builddir/ul"}
 TS_CMD_UMOUNT=${TS_CMD_UMOUNT:-"$top_builddir/umount"}
 TS_CMD_UTMPDUMP=${TS_CMD_UTMPDUMP-"$top_builddir/utmpdump"}
+TS_CMD_UUIDD=${TS_CMD_UUIDD-"$top_builddir/uuidd"}
 TS_CMD_UUIDGEN=${TS_CMD_UUIDGEN-"$top_builddir/uuidgen"}
 TS_CMD_WHEREIS=${TS_CMD_WHEREIS-"$top_builddir/whereis"}
 TS_CMD_WIPEFS=${TS_CMD_WIPEFS-"$top_builddir/wipefs"}
diff --git a/tests/expected/uuid/uuidd b/tests/expected/uuid/uuidd
new file mode 100644
index 0000000..ae440b2
--- /dev/null
+++ b/tests/expected/uuid/uuidd
@@ -0,0 +1,11 @@
+options: -t
+return value: 0
+options: --time
+return value: 0
+options: -r
+return value: 0
+options: --random
+return value: 0
+options: -r -n 65
+return value: 0
+Killed uuidd running at pid <num>.
diff --git a/tests/ts/uuid/uuidd b/tests/ts/uuid/uuidd
new file mode 100755
index 0000000..147f289
--- /dev/null
+++ b/tests/ts/uuid/uuidd
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
+TS_DESC="uuidd"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_UUID_PARSER"
+ts_check_test_command "$TS_CMD_UUIDD"
+
+OUTPUT_FILE="$(mktemp "${TS_OUTDIR}/uuiddXXXXXXXXXXXXX")"
+UUIDD_PID="$(mktemp -u "${TS_OUTDIR}/uuiddXXXXXXXXXXXXX")"
+UUIDD_SOCKET="$(mktemp -u "${TS_OUTDIR}/uuiddXXXXXXXXXXXXX")"
+
+$TS_CMD_UUIDD -p "$UUIDD_PID" -s "$UUIDD_SOCKET"
+if [ $? -ne 0 ]; then
+	ts_failed "daemon start"
+fi
+
+test_flag() {
+	echo "options: $*" >> $TS_OUTPUT
+	$TS_CMD_UUIDD -s $UUIDD_SOCKET $* |
+		sed -E '/List of UUIDs:/d; s/^[[:space:]]+//' > "$OUTPUT_FILE" 2>>$TS_OUTPUT
+	$TS_HELPER_UUID_PARSER "$OUTPUT_FILE" >> $TS_OUTPUT 2>&1
+	ret=$?
+	if [ $ret -ne 0 ]; then
+		echo "something wrong with $OUTPUT_FILE" >> $TS_OUTPUT
+		cat $OUTPUT_FILE >> $TS_OUTPUT 2>&1
+	fi
+	echo "return value: $ret" >> $TS_OUTPUT
+}
+
+test_flag -t
+test_flag --time
+test_flag -r
+test_flag --random
+test_flag -r -n 65
+
+$TS_CMD_UUIDD -k -s "$UUIDD_SOCKET" 2>&1 |
+	sed 's/pid [0-9]*.$/pid <num>./' >> "$TS_OUTPUT"
+
+rm -f "$OUTPUT_FILE" "$UUIDD_PID" "$UUIDD_SOCKET"
+
+ts_finalize
-- 
2.6.2

