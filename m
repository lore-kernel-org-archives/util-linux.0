Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33609 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248Ab3ASAJg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:09:36 -0500
Received: by mail-wg0-f47.google.com with SMTP id dq11so2578213wgb.14
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:09:35 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/22] tests: add ionice(1) check
Date: Sat, 19 Jan 2013 00:08:57 +0000
Message-Id: <1358554151-25985-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh          |  1 +
 tests/expected/misc/ionice |  9 +++++++++
 tests/ts/misc/ionice       | 28 ++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)
 create mode 100644 tests/expected/misc/ionice
 create mode 100755 tests/ts/misc/ionice

diff --git a/tests/commands.sh b/tests/commands.sh
index fe79cf4..c5f7140 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -70,3 +70,4 @@ TS_CMD_GETOPT=${TS_CMD_GETOPT-"$top_builddir/getopt"}
 TS_CMD_MCOOKIE=${TS_CMD_MCOOKIE-"$top_builddir/mcookie"}
 TS_CMD_TAILF=${TS_CMD_TAILF-"$top_builddir/tailf"}
 TS_CMD_UL=${TS_CMD_UL-"$top_builddir/ul"}
+TS_CMD_IONICE=${TS_CMD_IONICE-"$top_builddir/ionice"}
diff --git a/tests/expected/misc/ionice b/tests/expected/misc/ionice
new file mode 100644
index 0000000..39cfb60
--- /dev/null
+++ b/tests/expected/misc/ionice
@@ -0,0 +1,9 @@
+ionice: ignoring given class data for none class
+ionice: unknown prio class 7
+ionice: ioprio_set failed: Invalid argument
+ionice: unknown prio class 7
+ionice: ioprio_set failed: Invalid argument
+ionice: unknown prio class 8
+ionice: ioprio_set failed: Invalid argument
+/etc/passwd
+unknown: prio 0
diff --git a/tests/ts/misc/ionice b/tests/ts/misc/ionice
new file mode 100755
index 0000000..d0cca8e
--- /dev/null
+++ b/tests/ts/misc/ionice
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
+TS_DESC="ionice"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+$TS_CMD_IONICE -p $$ -n 0 -c 0 >> $TS_OUTPUT 2>&1
+$TS_CMD_IONICE -p $$ -n 3 -c 7 >> $TS_OUTPUT 2>&1
+$TS_CMD_IONICE -p $$ -n 4 -c 7 >> $TS_OUTPUT 2>&1
+$TS_CMD_IONICE -p $$ -n 1 -c 8 >> $TS_OUTPUT 2>&1
+$TS_CMD_IONICE -n 3 ls /etc/passwd >> $TS_OUTPUT 2>&1
+$TS_CMD_IONICE -p $$ >> $TS_OUTPUT 2>&1
+
+ts_finalize
-- 
1.8.1.1

