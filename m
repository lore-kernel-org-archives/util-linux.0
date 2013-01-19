Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33575 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570Ab3ASAJ3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:09:29 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so2466028wgb.1
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:09:28 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/22] tests: add mcookie(1) check
Date: Sat, 19 Jan 2013 00:08:54 +0000
Message-Id: <1358554151-25985-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh           |  1 +
 tests/expected/misc/mcookie |  1 +
 tests/ts/misc/mcookie       | 26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 tests/expected/misc/mcookie
 create mode 100755 tests/ts/misc/mcookie

diff --git a/tests/commands.sh b/tests/commands.sh
index cb2f444..3465d41 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -67,3 +67,4 @@ TS_CMD_HEXDUMP=${TS_CMD_HEXDUMP-"$top_builddir/hexdump"}
 
 TS_CMD_UTMPDUMP=${TS_CMD_UTMPDUMP-"$top_builddir/utmpdump"}
 TS_CMD_GETOPT=${TS_CMD_GETOPT-"$top_builddir/getopt"}
+TS_CMD_MCOOKIE=${TS_CMD_MCOOKIE-"$top_builddir/mcookie"}
diff --git a/tests/expected/misc/mcookie b/tests/expected/misc/mcookie
new file mode 100644
index 0000000..d1c0351
--- /dev/null
+++ b/tests/expected/misc/mcookie
@@ -0,0 +1 @@
+the string meets expecations
diff --git a/tests/ts/misc/mcookie b/tests/ts/misc/mcookie
new file mode 100755
index 0000000..9e650b2
--- /dev/null
+++ b/tests/ts/misc/mcookie
@@ -0,0 +1,26 @@
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
+TS_DESC="mcookie"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+$TS_CMD_MCOOKIE -f /etc/services |
+	# The sed will convert only 32 characters long hexadecimal string
+	# to expected string, but nothing else.
+	sed 's/^[0-9a-f]\{32\}$/the string meets expecations/' > $TS_OUTPUT 2>&1
+
+ts_finalize
-- 
1.8.1.1

