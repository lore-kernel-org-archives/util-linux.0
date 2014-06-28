Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:46972 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121AbaF1SaT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 28 Jun 2014 14:30:19 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi2so4202219wib.1
        for <util-linux@vger.kernel.org>; Sat, 28 Jun 2014 11:30:18 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 7/7] tests: add rename(1) return value check
Date: Sat, 28 Jun 2014 19:30:09 +0100
Message-Id: <1403980209-15694-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1403980209-15694-1-git-send-email-kerolasa@iki.fi>
References: <1403980209-15694-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/rename/exit_codes |  7 +++++++
 tests/ts/rename/exit_codes       | 41 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 tests/expected/rename/exit_codes
 create mode 100755 tests/ts/rename/exit_codes

diff --git a/tests/expected/rename/exit_codes b/tests/expected/rename/exit_codes
new file mode 100644
index 0000000..c577817
--- /dev/null
+++ b/tests/expected/rename/exit_codes
@@ -0,0 +1,7 @@
+RENAME_EXIT_NOTHING: 4
+`rename_exit_codes.1' -> `rename_exit_values.1'
+`rename_exit_codes.2' -> `rename_exit_values.2'
+EXIT_SUCCESS: 0
+rename: rename_exit_values.2: rename to rename_exit_codes.2 failed: Is a directory
+`rename_exit_values.1' -> `rename_exit_codes.1'
+RENAME_EXIT_SOMEOK: 2
diff --git a/tests/ts/rename/exit_codes b/tests/ts/rename/exit_codes
new file mode 100755
index 0000000..3702816
--- /dev/null
+++ b/tests/ts/rename/exit_codes
@@ -0,0 +1,41 @@
+#!/bin/bash
+
+#
+# Copyright (C) 2014 Sami Kerola <kerolasa@iki.fi>
+#
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
+#
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="exit codes"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_RENAME"
+ts_cd "$TS_OUTDIR"
+
+touch rename_exit_codes.{1..2}
+$TS_CMD_RENAME -v not_a_match impossible rename_exit_codes.? >> $TS_OUTPUT 2>&1
+echo "RENAME_EXIT_NOTHING: $?" >> $TS_OUTPUT
+
+$TS_CMD_RENAME -v codes values rename_exit_codes.? >> $TS_OUTPUT 2>&1
+echo "EXIT_SUCCESS: $?" >> $TS_OUTPUT
+
+mkdir rename_exit_codes.2
+$TS_CMD_RENAME -v values codes rename_exit_values.? >> $TS_OUTPUT 2>&1
+echo "RENAME_EXIT_SOMEOK: $?" >> $TS_OUTPUT
+
+rmdir rename_exit_codes.2
+rm rename_exit_codes.? rename_exit_values.?
+
+ts_finalize
-- 
2.0.1

