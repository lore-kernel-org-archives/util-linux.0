Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49394 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727Ab3ASAJz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:09:55 -0500
Received: by mail-wi0-f172.google.com with SMTP id o1so5651393wic.5
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:09:54 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 16/22] tests: add fallocate(1) check
Date: Sat, 19 Jan 2013 00:09:05 +0000
Message-Id: <1358554151-25985-17-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh             |  1 +
 tests/expected/misc/fallocate |  1 +
 tests/ts/misc/fallocate       | 25 +++++++++++++++++++++++++
 3 files changed, 27 insertions(+)
 create mode 100644 tests/expected/misc/fallocate
 create mode 100755 tests/ts/misc/fallocate

diff --git a/tests/commands.sh b/tests/commands.sh
index 401342f..e502aeb 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -76,3 +76,4 @@ TS_CMD_LINE=${TS_CMD_LINE-"$top_builddir/line"}
 TS_CMD_DMESG=${TS_CMD_DMESG-"$top_builddir/dmesg"}
 TS_CMD_SETSID=${TS_CMD_SETSID-"$top_builddir/setsid"}
 TS_CMD_SETARCH=${TS_CMD_SETARCH-"$top_builddir/setarch"}
+TS_CMD_FALLOCATE=${TS_CMD_FALLOCATE-"$top_builddir/fallocate"}
diff --git a/tests/expected/misc/fallocate b/tests/expected/misc/fallocate
new file mode 100644
index 0000000..e45b99e
--- /dev/null
+++ b/tests/expected/misc/fallocate
@@ -0,0 +1 @@
+384
diff --git a/tests/ts/misc/fallocate b/tests/ts/misc/fallocate
new file mode 100755
index 0000000..4b9db70
--- /dev/null
+++ b/tests/ts/misc/fallocate
@@ -0,0 +1,25 @@
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
+TS_DESC="fallocate"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+$TS_CMD_FALLOCATE -o 128 -l 256 $TS_SELF/fallocate_test > $TS_OUTPUT 2>&1
+stat -c "%s" $TS_SELF/fallocate_test > $TS_OUTPUT 2>&1
+rm -f $TS_SELF/fallocate_test
+
+ts_finalize
-- 
1.8.1.1

