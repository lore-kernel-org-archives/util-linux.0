Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41927 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727Ab3ASAJx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:09:53 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr12so2460955wgb.23
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:09:51 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 15/22] tests: add setarch(8) check
Date: Sat, 19 Jan 2013 00:09:04 +0000
Message-Id: <1358554151-25985-16-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh           |  1 +
 tests/expected/misc/setarch |  1 +
 tests/ts/misc/setarch       | 23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+)
 create mode 100644 tests/expected/misc/setarch
 create mode 100755 tests/ts/misc/setarch

diff --git a/tests/commands.sh b/tests/commands.sh
index 548f95f..401342f 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -75,3 +75,4 @@ TS_CMD_MORE=${TS_CMD_MORE-"$top_builddir/more"}
 TS_CMD_LINE=${TS_CMD_LINE-"$top_builddir/line"}
 TS_CMD_DMESG=${TS_CMD_DMESG-"$top_builddir/dmesg"}
 TS_CMD_SETSID=${TS_CMD_SETSID-"$top_builddir/setsid"}
+TS_CMD_SETARCH=${TS_CMD_SETARCH-"$top_builddir/setarch"}
diff --git a/tests/expected/misc/setarch b/tests/expected/misc/setarch
new file mode 100644
index 0000000..2e9ba47
--- /dev/null
+++ b/tests/expected/misc/setarch
@@ -0,0 +1 @@
+success
diff --git a/tests/ts/misc/setarch b/tests/ts/misc/setarch
new file mode 100755
index 0000000..8050556
--- /dev/null
+++ b/tests/ts/misc/setarch
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
+TS_DESC="setarch"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+$TS_CMD_SETARCH $(uname -m) -vRFZLXBIST3 --uname-2.6 echo "success" >$TS_OUTPUT 2>&1
+
+ts_finalize
-- 
1.8.1.1

