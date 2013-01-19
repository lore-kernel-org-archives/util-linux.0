Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:51501 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248Ab3ASAJn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:09:43 -0500
Received: by mail-wi0-f171.google.com with SMTP id hn14so5647314wib.16
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:09:42 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/22] tests: add line(1) check
Date: Sat, 19 Jan 2013 00:09:00 +0000
Message-Id: <1358554151-25985-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh        |  1 +
 tests/expected/misc/line |  1 +
 tests/ts/misc/line       | 24 ++++++++++++++++++++++++
 3 files changed, 26 insertions(+)
 create mode 100644 tests/expected/misc/line
 create mode 100755 tests/ts/misc/line

diff --git a/tests/commands.sh b/tests/commands.sh
index dad7010..f1e20ed 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -72,3 +72,4 @@ TS_CMD_TAILF=${TS_CMD_TAILF-"$top_builddir/tailf"}
 TS_CMD_UL=${TS_CMD_UL-"$top_builddir/ul"}
 TS_CMD_IONICE=${TS_CMD_IONICE-"$top_builddir/ionice"}
 TS_CMD_MORE=${TS_CMD_MORE-"$top_builddir/more"}
+TS_CMD_LINE=${TS_CMD_LINE-"$top_builddir/line"}
diff --git a/tests/expected/misc/line b/tests/expected/misc/line
new file mode 100644
index 0000000..7898192
--- /dev/null
+++ b/tests/expected/misc/line
@@ -0,0 +1 @@
+a
diff --git a/tests/ts/misc/line b/tests/ts/misc/line
new file mode 100755
index 0000000..41a95fe
--- /dev/null
+++ b/tests/ts/misc/line
@@ -0,0 +1,24 @@
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
+TS_DESC="line"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+printf "a\nb\n" |
+	$TS_CMD_LINE > $TS_OUTPUT 2>&1
+
+ts_finalize
-- 
1.8.1.1

