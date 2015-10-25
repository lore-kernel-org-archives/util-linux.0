Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36665 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbbJYQFN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 25 Oct 2015 12:05:13 -0400
Received: by wicfx6 with SMTP id fx6so84662205wic.1
        for <util-linux@vger.kernel.org>; Sun, 25 Oct 2015 09:05:12 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/4] tests: add uuidgen output check
Date: Sun, 25 Oct 2015 16:04:59 +0000
Message-Id: <1445789100-1781-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1445789100-1781-1-git-send-email-kerolasa@iki.fi>
References: <1445789100-1781-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/uuid/uuidgen |  8 ++++++++
 tests/ts/uuid/uuidgen       | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 tests/expected/uuid/uuidgen
 create mode 100755 tests/ts/uuid/uuidgen

diff --git a/tests/expected/uuid/uuidgen b/tests/expected/uuid/uuidgen
new file mode 100644
index 0000000..b0d1d98
--- /dev/null
+++ b/tests/expected/uuid/uuidgen
@@ -0,0 +1,8 @@
+option: -r
+return values: 0 and 0
+option: -t
+return values: 0 and 0
+option: --random
+return values: 0 and 0
+option: --time
+return values: 0 and 0
diff --git a/tests/ts/uuid/uuidgen b/tests/ts/uuid/uuidgen
new file mode 100755
index 0000000..6aa1b5b
--- /dev/null
+++ b/tests/ts/uuid/uuidgen
@@ -0,0 +1,45 @@
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
+TS_DESC="uuidgen"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_UUID_PARSER"
+ts_check_test_command "$TS_CMD_UUIDGEN"
+
+OUTPUT_FILE="$(mktemp "${TS_OUTDIR}/uuidgenXXXXXXXXXXXXX")"
+
+test_flag() {
+	echo "option: $1" >> $TS_OUTPUT
+	$TS_CMD_UUIDGEN $1 > "$OUTPUT_FILE" 2>>$TS_OUTPUT
+	ret=$?
+	$TS_HELPER_UUID_PARSER "$OUTPUT_FILE" >> $TS_OUTPUT 2>&1
+	if [ $? -ne 0 ] || [ $ret -ne 0 ]; then 
+		echo "something wrong with $OUTPUT_FILE" >> $TS_OUTPUT
+		cat $OUTPUT_FILE >> $TS_OUTPUT 2>&1
+	fi
+	echo "return values: $ret and $?" >> $TS_OUTPUT
+}
+
+test_flag -r
+test_flag -t
+test_flag --random
+test_flag --time
+
+rm -f "$OUTPUT_FILE"
+
+ts_finalize
-- 
2.6.2

