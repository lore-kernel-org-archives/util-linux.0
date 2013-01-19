Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f54.google.com ([74.125.82.54]:63253 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755711Ab3ASAJu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:09:50 -0500
Received: by mail-wg0-f54.google.com with SMTP id fg15so2604622wgb.9
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:09:49 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 14/22] tests: add setsid(1) check
Date: Sat, 19 Jan 2013 00:09:03 +0000
Message-Id: <1358554151-25985-15-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh          |  1 +
 tests/expected/misc/setsid |  1 +
 tests/ts/misc/setsid       | 23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+)
 create mode 100644 tests/expected/misc/setsid
 create mode 100755 tests/ts/misc/setsid

diff --git a/tests/commands.sh b/tests/commands.sh
index d4f30a3..548f95f 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -74,3 +74,4 @@ TS_CMD_IONICE=${TS_CMD_IONICE-"$top_builddir/ionice"}
 TS_CMD_MORE=${TS_CMD_MORE-"$top_builddir/more"}
 TS_CMD_LINE=${TS_CMD_LINE-"$top_builddir/line"}
 TS_CMD_DMESG=${TS_CMD_DMESG-"$top_builddir/dmesg"}
+TS_CMD_SETSID=${TS_CMD_SETSID-"$top_builddir/setsid"}
diff --git a/tests/expected/misc/setsid b/tests/expected/misc/setsid
new file mode 100644
index 0000000..2e9ba47
--- /dev/null
+++ b/tests/expected/misc/setsid
@@ -0,0 +1 @@
+success
diff --git a/tests/ts/misc/setsid b/tests/ts/misc/setsid
new file mode 100755
index 0000000..43a76f9
--- /dev/null
+++ b/tests/ts/misc/setsid
@@ -0,0 +1,23 @@
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
+TS_DESC="setsid"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+$TS_CMD_SETSID echo "success" > $TS_OUTPUT 2>&1
+
+ts_finalize
-- 
1.8.1.1

