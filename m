Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f171.google.com ([74.125.82.171]:34686 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbbCOMzK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 Mar 2015 08:55:10 -0400
Received: by wegp1 with SMTP id p1so20827485weg.1
        for <util-linux@vger.kernel.org>; Sun, 15 Mar 2015 05:55:08 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/8] tests: add logger(1) command line options tests
Date: Sun, 15 Mar 2015 12:54:50 +0000
Message-Id: <1426424094-25451-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
References: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/logger/input_empty_line             |  3 ++
 tests/expected/logger/input_prio_prefix            |  1 +
 tests/expected/logger/input_simple                 |  1 +
 tests/expected/logger/options                      |  0
 .../expected/logger/options-input_file_empty_line  |  3 ++
 .../expected/logger/options-input_file_prio_prefix |  1 +
 tests/expected/logger/options-input_file_simple    |  1 +
 .../expected/logger/options-input_file_skip_empty  |  2 +
 tests/expected/logger/options-log_pid              |  1 +
 tests/expected/logger/options-log_pid_define       |  1 +
 tests/expected/logger/options-log_pid_long         |  1 +
 tests/expected/logger/options-log_pid_no_arg       |  1 +
 tests/expected/logger/options-simple               |  1 +
 tests/ts/logger/options                            | 57 ++++++++++++++++++++++
 14 files changed, 74 insertions(+)
 create mode 100644 tests/expected/logger/input_empty_line
 create mode 100644 tests/expected/logger/input_prio_prefix
 create mode 100644 tests/expected/logger/input_simple
 create mode 100644 tests/expected/logger/options
 create mode 100644 tests/expected/logger/options-input_file_empty_line
 create mode 100644 tests/expected/logger/options-input_file_prio_prefix
 create mode 100644 tests/expected/logger/options-input_file_simple
 create mode 100644 tests/expected/logger/options-input_file_skip_empty
 create mode 100644 tests/expected/logger/options-log_pid
 create mode 100644 tests/expected/logger/options-log_pid_define
 create mode 100644 tests/expected/logger/options-log_pid_long
 create mode 100644 tests/expected/logger/options-log_pid_no_arg
 create mode 100644 tests/expected/logger/options-simple
 create mode 100755 tests/ts/logger/options

diff --git a/tests/expected/logger/input_empty_line b/tests/expected/logger/input_empty_line
new file mode 100644
index 0000000..78578ae
--- /dev/null
+++ b/tests/expected/logger/input_empty_line
@@ -0,0 +1,3 @@
+a1 a2 a3 a4 a5 b1 b2 b3 b4 b5 c1 c2 c3 c4 c5
+
+5{c..1} 4{c..1} 3{c..1} 2{c..1} 1{c..1}
diff --git a/tests/expected/logger/input_prio_prefix b/tests/expected/logger/input_prio_prefix
new file mode 100644
index 0000000..25a5f54
--- /dev/null
+++ b/tests/expected/logger/input_prio_prefix
@@ -0,0 +1 @@
+<66> prio_prefix
diff --git a/tests/expected/logger/input_simple b/tests/expected/logger/input_simple
new file mode 100644
index 0000000..9e5c66d
--- /dev/null
+++ b/tests/expected/logger/input_simple
@@ -0,0 +1 @@
+a1 a2 a3 a4 a5 b1 b2 b3 b4 b5 c1 c2 c3 c4 c5
diff --git a/tests/expected/logger/options b/tests/expected/logger/options
new file mode 100644
index 0000000..e69de29
diff --git a/tests/expected/logger/options-input_file_empty_line b/tests/expected/logger/options-input_file_empty_line
new file mode 100644
index 0000000..a10fd1c
--- /dev/null
+++ b/tests/expected/logger/options-input_file_empty_line
@@ -0,0 +1,3 @@
+<13>Feb 13 23:31:30 test_tag: a1 a2 a3 a4 a5 b1 b2 b3 b4 b5 c1 c2 c3 c4 c5
+<13>Feb 13 23:31:30 test_tag: 
+<13>Feb 13 23:31:30 test_tag: 5{c..1} 4{c..1} 3{c..1} 2{c..1} 1{c..1}
diff --git a/tests/expected/logger/options-input_file_prio_prefix b/tests/expected/logger/options-input_file_prio_prefix
new file mode 100644
index 0000000..b0f9785
--- /dev/null
+++ b/tests/expected/logger/options-input_file_prio_prefix
@@ -0,0 +1 @@
+<66>Feb 13 23:31:30 test_tag:  prio_prefix
diff --git a/tests/expected/logger/options-input_file_simple b/tests/expected/logger/options-input_file_simple
new file mode 100644
index 0000000..e8a2ca8
--- /dev/null
+++ b/tests/expected/logger/options-input_file_simple
@@ -0,0 +1 @@
+<13>Feb 13 23:31:30 test_tag: a1 a2 a3 a4 a5 b1 b2 b3 b4 b5 c1 c2 c3 c4 c5
diff --git a/tests/expected/logger/options-input_file_skip_empty b/tests/expected/logger/options-input_file_skip_empty
new file mode 100644
index 0000000..cdbe87a
--- /dev/null
+++ b/tests/expected/logger/options-input_file_skip_empty
@@ -0,0 +1,2 @@
+<13>Feb 13 23:31:30 test_tag: a1 a2 a3 a4 a5 b1 b2 b3 b4 b5 c1 c2 c3 c4 c5
+<13>Feb 13 23:31:30 test_tag: 5{c..1} 4{c..1} 3{c..1} 2{c..1} 1{c..1}
diff --git a/tests/expected/logger/options-log_pid b/tests/expected/logger/options-log_pid
new file mode 100644
index 0000000..d21ecd4
--- /dev/null
+++ b/tests/expected/logger/options-log_pid
@@ -0,0 +1 @@
+<13>Feb 13 23:31:30 test_tag[98765]: test
diff --git a/tests/expected/logger/options-log_pid_define b/tests/expected/logger/options-log_pid_define
new file mode 100644
index 0000000..14024b1
--- /dev/null
+++ b/tests/expected/logger/options-log_pid_define
@@ -0,0 +1 @@
+<13>Feb 13 23:31:30 test_tag[12345]: test
diff --git a/tests/expected/logger/options-log_pid_long b/tests/expected/logger/options-log_pid_long
new file mode 100644
index 0000000..d21ecd4
--- /dev/null
+++ b/tests/expected/logger/options-log_pid_long
@@ -0,0 +1 @@
+<13>Feb 13 23:31:30 test_tag[98765]: test
diff --git a/tests/expected/logger/options-log_pid_no_arg b/tests/expected/logger/options-log_pid_no_arg
new file mode 100644
index 0000000..d21ecd4
--- /dev/null
+++ b/tests/expected/logger/options-log_pid_no_arg
@@ -0,0 +1 @@
+<13>Feb 13 23:31:30 test_tag[98765]: test
diff --git a/tests/expected/logger/options-simple b/tests/expected/logger/options-simple
new file mode 100644
index 0000000..1d0c3a0
--- /dev/null
+++ b/tests/expected/logger/options-simple
@@ -0,0 +1 @@
+<13>Feb 13 23:31:30 test_tag: test
diff --git a/tests/ts/logger/options b/tests/ts/logger/options
new file mode 100755
index 0000000..f68b33f
--- /dev/null
+++ b/tests/ts/logger/options
@@ -0,0 +1,57 @@
+#!/bin/bash
+
+#
+# Copyright (C) 2015 Sami Kerola <kerolasa@iki.fi>
+#
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
+#
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="options"
+
+. $TS_TOPDIR/functions.sh
+
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_LOGGER"
+
+# Create --file option input files.
+echo {a..c}{1..5}	 > $TS_OUTDIR/input_simple
+echo {a..c}{1..5}	 > $TS_OUTDIR/input_empty_line
+echo ""			>> $TS_OUTDIR/input_empty_line
+echo {5..1}{c..1}	>> $TS_OUTDIR/input_empty_line
+echo "<66>" prio_prefix	 > $TS_OUTDIR/input_prio_prefix
+
+# bash 4 might not be available, use go-around hash
+tests_array=(
+	"simple:--stderr test"
+	"log_pid:--stderr -i test"
+	"log_pid_long:--stderr --id test"
+	"log_pid_define:--stderr --id=12345 test"
+	"log_pid_no_arg:-is test"
+	"input_file_simple:--stderr -f $TS_OUTDIR/input_simple"
+	"input_file_empty_line:--stderr -f $TS_OUTDIR/input_empty_line"
+	"input_file_skip_empty:--stderr --file $TS_OUTDIR/input_empty_line -e"
+	"input_file_prio_prefix:--stderr --file $TS_OUTDIR/input_prio_prefix --skip-empty --prio-prefix"
+)
+
+for i in "${tests_array[@]}"; do
+	name="${i%%:*}"
+	options="${i##*:}"
+
+	ts_init_subtest "$name"
+	$TS_HELPER_LOGGER -t "test_tag" $options > "$TS_OUTPUT" 2>&1
+	ts_finalize_subtest
+done
+
+ts_finalize
-- 
2.3.2

