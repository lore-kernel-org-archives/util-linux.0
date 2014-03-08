Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oa0-f47.google.com ([209.85.219.47]:50343 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbaCHRCM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Mar 2014 12:02:12 -0500
Received: by mail-oa0-f47.google.com with SMTP id i11so5470774oag.20
        for <util-linux@vger.kernel.org>; Sat, 08 Mar 2014 09:02:11 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/5] tests: check swaplabel, and perform more swapon boundary tests
Date: Sat,  8 Mar 2014 11:01:54 -0600
Message-Id: <1394298117-16531-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1394298117-16531-1-git-send-email-kerolasa@iki.fi>
References: <1394298117-16531-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh             |  1 +
 tests/expected/misc/swaplabel |  6 ++++++
 tests/ts/misc/swaplabel       | 44 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 tests/expected/misc/swaplabel
 create mode 100755 tests/ts/misc/swaplabel

diff --git a/tests/commands.sh b/tests/commands.sh
index fcd74dc..68048fa 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -64,6 +64,7 @@ TS_CMD_REV=${TS_CMD_REV:-"$top_builddir/rev"}
 TS_CMD_SCRIPT=${TS_CMD_SCRIPT-"$top_builddir/script"}
 TS_CMD_SETARCH=${TS_CMD_SETARCH-"$top_builddir/setarch"}
 TS_CMD_SETSID=${TS_CMD_SETSID-"$top_builddir/setsid"}
+TS_CMD_SWAPLABEL=${TS_CMD_SWAPLABEL:-"$top_builddir/swaplabel"}
 TS_CMD_SWAPOFF=${TS_CMD_SWAPOFF:-"$top_builddir/swapoff"}
 TS_CMD_SWAPON=${TS_CMD_SWAPON:-"$top_builddir/swapon"}
 TS_CMD_TAILF=${TS_CMD_TAILF-"$top_builddir/tailf"}
diff --git a/tests/expected/misc/swaplabel b/tests/expected/misc/swaplabel
new file mode 100644
index 0000000..061f5bb
--- /dev/null
+++ b/tests/expected/misc/swaplabel
@@ -0,0 +1,6 @@
+mkswap: error: swap area needs to be at least 40 KiB
+mkswap: Label was truncated.
+Setting up swapspace version 1, size = 36 KiB
+LABEL=1234567890abcde, UUID=12345678-abcd-abcd-abcd-1234567890ab
+LABEL: 1234567890abcde
+UUID:  12345678-abcd-abcd-abcd-1234567890ab
diff --git a/tests/ts/misc/swaplabel b/tests/ts/misc/swaplabel
new file mode 100755
index 0000000..e876874
--- /dev/null
+++ b/tests/ts/misc/swaplabel
@@ -0,0 +1,44 @@
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
+TS_DESC="swaplabel"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+#ts_check_test_command "$TS_CMD_FALLOCATE"
+#ts_check_test_command "$TS_CMD_MKSWAP"
+#ts_check_test_command "$TS_CMD_SWAPLABEL"
+
+IMAGE=${TS_OUTDIR}/${TS_TESTNAME}.file
+
+rm -f $IMAGE
+$TS_CMD_FALLOCATE -l 40959 $IMAGE > $TS_OUTPUT 2>&1
+$TS_CMD_MKSWAP \
+	--label 1234567890abcdef \
+	--uuid 12345678-abcd-abcd-abcd-1234567890ab \
+	$IMAGE >> $TS_OUTPUT 2>&1
+
+rm -f $IMAGE
+$TS_CMD_FALLOCATE -l 40960 $IMAGE >> $TS_OUTPUT 2>&1
+$TS_CMD_MKSWAP \
+	--label 1234567890abcdef \
+	--uuid 12345678-abcd-abcd-abcd-1234567890ab \
+	$IMAGE >> $TS_OUTPUT 2>&1
+$TS_CMD_SWAPLABEL $IMAGE >> $TS_OUTPUT 2>&1
+
+#rm -f $IMAGE
+
+ts_finalize
-- 
1.9.0

