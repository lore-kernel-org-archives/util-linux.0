Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:57214 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466Ab3ASAJe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:09:34 -0500
Received: by mail-wg0-f45.google.com with SMTP id dq12so2573193wgb.12
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:09:33 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/22] tests: add ul(1) check
Date: Sat, 19 Jan 2013 00:08:56 +0000
Message-Id: <1358554151-25985-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh      |  1 +
 tests/expected/misc/ul |  3 +++
 tests/ts/misc/ul       | 24 ++++++++++++++++++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 tests/expected/misc/ul
 create mode 100755 tests/ts/misc/ul

diff --git a/tests/commands.sh b/tests/commands.sh
index 2718640..fe79cf4 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -69,3 +69,4 @@ TS_CMD_UTMPDUMP=${TS_CMD_UTMPDUMP-"$top_builddir/utmpdump"}
 TS_CMD_GETOPT=${TS_CMD_GETOPT-"$top_builddir/getopt"}
 TS_CMD_MCOOKIE=${TS_CMD_MCOOKIE-"$top_builddir/mcookie"}
 TS_CMD_TAILF=${TS_CMD_TAILF-"$top_builddir/tailf"}
+TS_CMD_UL=${TS_CMD_UL-"$top_builddir/ul"}
diff --git a/tests/expected/misc/ul b/tests/expected/misc/ul
new file mode 100644
index 0000000..f3aecd1
--- /dev/null
+++ b/tests/expected/misc/ul
@@ -0,0 +1,3 @@
+[1ma(B[mb[4mc[24m
+        tab
+
\ No newline at end of file
diff --git a/tests/ts/misc/ul b/tests/ts/misc/ul
new file mode 100755
index 0000000..bc0ecf7
--- /dev/null
+++ b/tests/ts/misc/ul
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
+TS_DESC="ul"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+printf "a\x08ab\x5F\x08c\\n\\ttab\\f\\b\\r" |
+	$TS_CMD_UL -t xterm > $TS_OUTPUT 2>&1
+
+ts_finalize
-- 
1.8.1.1

