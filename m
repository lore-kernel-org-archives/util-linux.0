Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:44469 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890Ab3ASAKD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:10:03 -0500
Received: by mail-wg0-f41.google.com with SMTP id ds1so714908wgb.2
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:10:01 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 19/22] tests: add whereis(1) check
Date: Sat, 19 Jan 2013 00:09:08 +0000
Message-Id: <1358554151-25985-20-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh           |  1 +
 tests/expected/misc/whereis |  1 +
 tests/ts/misc/whereis       | 28 ++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+)
 create mode 100644 tests/expected/misc/whereis
 create mode 100755 tests/ts/misc/whereis

diff --git a/tests/commands.sh b/tests/commands.sh
index 6c172ba..4792ce1 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -78,3 +78,4 @@ TS_CMD_SETSID=${TS_CMD_SETSID-"$top_builddir/setsid"}
 TS_CMD_SETARCH=${TS_CMD_SETARCH-"$top_builddir/setarch"}
 TS_CMD_FALLOCATE=${TS_CMD_FALLOCATE-"$top_builddir/fallocate"}
 TS_CMD_ISOSIZE=${TS_CMD_ISOSIZE-"$top_builddir/isosize"}
+TS_CMD_WHEREIS=${TS_CMD_WHEREIS-"$top_builddir/whereis"}
diff --git a/tests/expected/misc/whereis b/tests/expected/misc/whereis
new file mode 100644
index 0000000..2e9ba47
--- /dev/null
+++ b/tests/expected/misc/whereis
@@ -0,0 +1 @@
+success
diff --git a/tests/ts/misc/whereis b/tests/ts/misc/whereis
new file mode 100755
index 0000000..853b27a
--- /dev/null
+++ b/tests/ts/misc/whereis
@@ -0,0 +1,28 @@
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
+TS_TOPDIR="$(dirname $0)/../.."
+TS_DESC="whereis"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+LS_COUNT=$($TS_CMD_WHEREIS ls | wc -w)
+if [ $LS_COUNT -lt 2 ]; then
+	echo "ls binary nor manual not found?" > $TS_OUTPUT
+else
+	echo "success" > $TS_OUTPUT
+fi
+
+ts_finalize
-- 
1.8.1.1

