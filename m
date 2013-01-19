Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38588 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466Ab3ASAJb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:09:31 -0500
Received: by mail-wi0-f181.google.com with SMTP id hq4so3442145wib.2
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:09:30 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/22] tests: add tailf(1) check
Date: Sat, 19 Jan 2013 00:08:55 +0000
Message-Id: <1358554151-25985-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh           |  1 +
 tests/expected/tailf/simple |  2 ++
 tests/ts/tailf/simple       | 29 +++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)
 create mode 100644 tests/expected/tailf/simple
 create mode 100755 tests/ts/tailf/simple

diff --git a/tests/commands.sh b/tests/commands.sh
index 3465d41..2718640 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -68,3 +68,4 @@ TS_CMD_HEXDUMP=${TS_CMD_HEXDUMP-"$top_builddir/hexdump"}
 TS_CMD_UTMPDUMP=${TS_CMD_UTMPDUMP-"$top_builddir/utmpdump"}
 TS_CMD_GETOPT=${TS_CMD_GETOPT-"$top_builddir/getopt"}
 TS_CMD_MCOOKIE=${TS_CMD_MCOOKIE-"$top_builddir/mcookie"}
+TS_CMD_TAILF=${TS_CMD_TAILF-"$top_builddir/tailf"}
diff --git a/tests/expected/tailf/simple b/tests/expected/tailf/simple
new file mode 100644
index 0000000..ddf72de
--- /dev/null
+++ b/tests/expected/tailf/simple
@@ -0,0 +1,2 @@
+a b c d e f g h i j k l m n o p q r s t u v w x y z
+0 1 2 3 4 5 6 7 8 9
diff --git a/tests/ts/tailf/simple b/tests/ts/tailf/simple
new file mode 100755
index 0000000..ad00b25
--- /dev/null
+++ b/tests/ts/tailf/simple
@@ -0,0 +1,29 @@
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
+TS_DESC="simple"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+rm -f $TS_SELF/input
+echo {a..z}  > $TS_SELF/input
+$TS_CMD_TAILF  $TS_SELF/input > $TS_OUTPUT 2>&1 &
+sleep 0.1
+echo {0..9} >> $TS_SELF/input
+sleep 0.1
+rm -f $TS_SELF/input
+
+ts_finalize
-- 
1.8.1.1

