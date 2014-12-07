Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:43943 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbaLGKOG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Dec 2014 05:14:06 -0500
Received: by mail-wg0-f46.google.com with SMTP id x13so1551239wgg.5
        for <util-linux@vger.kernel.org>; Sun, 07 Dec 2014 02:14:04 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>,
        Frodo Looijaard <frodo@frodo.looijaard.name>
Subject: [PATCH 02/11] tests: add more getopt tests
Date: Sun,  7 Dec 2014 10:13:46 +0000
Message-Id: <1417947235-24229-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
References: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

After importing Frodo's tests I ran coverage to see if something had
remained unchecked, and there were couple tests that could be done.

CC: Frodo Looijaard <frodo@frodo.looijaard.name>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/misc/getopt3                 |  0
 tests/expected/misc/getopt3-compatible      |  5 +++
 tests/expected/misc/getopt3-csh             |  2 +
 tests/expected/misc/getopt3-no-arguments    |  3 ++
 tests/expected/misc/getopt3-non-option      |  4 ++
 tests/expected/misc/getopt3-posix_correctly |  4 ++
 tests/expected/misc/getopt3-sh              |  2 +
 tests/ts/misc/getopt3                       | 63 +++++++++++++++++++++++++++++
 8 files changed, 83 insertions(+)
 create mode 100644 tests/expected/misc/getopt3
 create mode 100644 tests/expected/misc/getopt3-compatible
 create mode 100644 tests/expected/misc/getopt3-csh
 create mode 100644 tests/expected/misc/getopt3-no-arguments
 create mode 100644 tests/expected/misc/getopt3-non-option
 create mode 100644 tests/expected/misc/getopt3-posix_correctly
 create mode 100644 tests/expected/misc/getopt3-sh
 create mode 100755 tests/ts/misc/getopt3

diff --git a/tests/expected/misc/getopt3 b/tests/expected/misc/getopt3
new file mode 100644
index 0000000..e69de29
diff --git a/tests/expected/misc/getopt3-compatible b/tests/expected/misc/getopt3-compatible
new file mode 100644
index 0000000..585de60
--- /dev/null
+++ b/tests/expected/misc/getopt3-compatible
@@ -0,0 +1,5 @@
+getopt: missing optstring argument
+Try `getopt --help' for more information.
+exit value: 2
+ --
+exit value: 0
diff --git a/tests/expected/misc/getopt3-csh b/tests/expected/misc/getopt3-csh
new file mode 100644
index 0000000..86e48f4
--- /dev/null
+++ b/tests/expected/misc/getopt3-csh
@@ -0,0 +1,2 @@
+ -a -b '1' -c '2' --a-long --b-long '3' --c-long '' -- 'foo' 'bar'
+exit value: 0
diff --git a/tests/expected/misc/getopt3-no-arguments b/tests/expected/misc/getopt3-no-arguments
new file mode 100644
index 0000000..08b3ed5
--- /dev/null
+++ b/tests/expected/misc/getopt3-no-arguments
@@ -0,0 +1,3 @@
+getopt: missing optstring argument
+Try `getopt --help' for more information.
+exit value: 2
diff --git a/tests/expected/misc/getopt3-non-option b/tests/expected/misc/getopt3-non-option
new file mode 100644
index 0000000..73f0b65
--- /dev/null
+++ b/tests/expected/misc/getopt3-non-option
@@ -0,0 +1,4 @@
+ -a 'x' -- 'y' '-b' 'z' 'w'
+ -a 'x' -b 'z' -- 'y' 'w'
+ -a 'x' 'y' -b 'z' 'w' --
+exit value: 0
diff --git a/tests/expected/misc/getopt3-posix_correctly b/tests/expected/misc/getopt3-posix_correctly
new file mode 100644
index 0000000..5b2bc33
--- /dev/null
+++ b/tests/expected/misc/getopt3-posix_correctly
@@ -0,0 +1,4 @@
+ -a -b '1' -c '2' --a-long --b-long '3' --c-long '' -- 'foo' 'bar' 'xyxxy' '--a-long'
+exit value: 0
+ -a -b '1' -c '2' --a-long --b-long '3' --c-long '' -- 'foo' 'bar' 'xyxxy' '--a-long'
+exit value: 0
diff --git a/tests/expected/misc/getopt3-sh b/tests/expected/misc/getopt3-sh
new file mode 100644
index 0000000..86e48f4
--- /dev/null
+++ b/tests/expected/misc/getopt3-sh
@@ -0,0 +1,2 @@
+ -a -b '1' -c '2' --a-long --b-long '3' --c-long '' -- 'foo' 'bar'
+exit value: 0
diff --git a/tests/ts/misc/getopt3 b/tests/ts/misc/getopt3
new file mode 100755
index 0000000..68dc069
--- /dev/null
+++ b/tests/ts/misc/getopt3
@@ -0,0 +1,63 @@
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
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="getopt3"
+
+. $TS_TOPDIR/functions.sh
+
+ts_init "$*"
+ts_check_test_command "$TS_CMD_GETOPT"
+
+export LANG=C
+
+ts_init_subtest compatible
+$TS_CMD_GETOPT >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+GETOPT_COMPATIBLE='' $TS_CMD_GETOPT >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+sed -i '1,1s/.*\///' $TS_OUTPUT
+ts_finalize_subtest
+
+ts_init_subtest sh
+$TS_CMD_GETOPT --shell=sh -o ab:c:: --long a-long,b-long:,c-long:: -n 'example.sh' -- -a -b 1 -c2  --a-long --b-long 3 --c-long foo bar >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+ts_init_subtest csh
+$TS_CMD_GETOPT --shell=csh -o ab:c:: --long a-long,b-long:,c-long:: -n 'example.csh' -- -a -b 1 -c2  --a-long --b-long 3 --c-long foo bar >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+ts_init_subtest no-arguments
+$TS_CMD_GETOPT >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+sed -i '1,1s/.*\///' $TS_OUTPUT
+ts_finalize_subtest
+
+ts_init_subtest posix_correctly
+$TS_CMD_GETOPT -o +ab:c:: --long a-long,b-long:,c-long:: -n 'example' -- -a -b 1 -c2  --a-long --b-long 3 --c-long foo bar xyxxy --a-long >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+POSIXLY_CORRECT='' $TS_CMD_GETOPT -o ab:c:: --long a-long,b-long:,c-long:: -n 'example' -- -a -b 1 -c2  --a-long --b-long 3 --c-long foo bar xyxxy --a-long >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+ts_init_subtest non-option
+$TS_CMD_GETOPT -o +a:b: -- -a x y -b z w >> $TS_OUTPUT 2>&1
+$TS_CMD_GETOPT -o  a:b: -- -a x y -b z w >> $TS_OUTPUT 2>&1
+$TS_CMD_GETOPT -o -a:b: -- -a x y -b z w >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+ts_finalize
-- 
2.1.3

