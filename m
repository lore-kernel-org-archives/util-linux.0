Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:36993 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbaLGKOE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Dec 2014 05:14:04 -0500
Received: by mail-wg0-f52.google.com with SMTP id x12so1554961wgg.11
        for <util-linux@vger.kernel.org>; Sun, 07 Dec 2014 02:14:03 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>,
        Frodo Looijaard <frodo@frodo.looijaard.name>
Subject: [PATCH 01/11] tests: copy test-suite from Frodo Looijaard's getopt
Date: Sun,  7 Dec 2014 10:13:45 +0000
Message-Id: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The test cases and their names are the same, but the surrounding testing
facility with Frodo's svn and util-linux are pretty different so this is
not exactly 1:1 copy.

Reference: svn://svn.frodo.looijaard.name/public/getopt/trunk/tests
CC: Frodo Looijaard <frodo@frodo.looijaard.name>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/misc/getopt2                        |  19 +++
 .../expected/misc/getopt2-alternative_option_clash |   2 +
 .../expected/misc/getopt2-alternative_option_long  |   2 +
 .../expected/misc/getopt2-alternative_option_short |   2 +
 tests/expected/misc/getopt2-invalid_getopt_option  |   3 +
 tests/expected/misc/getopt2-invocation_model_one   |   2 +
 .../misc/getopt2-invocation_model_three_as_one     |   2 +
 .../misc/getopt2-invocation_model_two_as_one       |   2 +
 .../misc/getopt2-invocation_without_parameters     |   3 +
 .../expected/misc/getopt2-long_option_ambiguous_1  |   3 +
 tests/expected/misc/getopt2-longopts               |   2 +
 tests/expected/misc/getopt2-name_option_long       |   4 +
 tests/expected/misc/getopt2-name_option_short      |   4 +
 tests/expected/misc/getopt2-quiet_option_long      |   2 +
 tests/expected/misc/getopt2-quiet_option_short     |   2 +
 .../expected/misc/getopt2-quiet_output_option_long |   5 +
 .../misc/getopt2-quiet_output_option_short         |   5 +
 .../expected/misc/getopt2-same_long_short_options  |   2 +
 .../expected/misc/getopt2-test_for_enhanced_getopt |   1 +
 tests/expected/misc/getopt2-unknown_options        |   4 +
 tests/expected/misc/getopt2-unquoted_option_bash   |   5 +
 tests/expected/misc/getopt2-unquoted_option_tcsh   |   5 +
 tests/expected/misc/getopt2-weird_quoting_bash     |   5 +
 tests/expected/misc/getopt2-weird_quoting_tcsh     |   2 +
 tests/ts/misc/getopt2                              | 176 +++++++++++++++++++++
 25 files changed, 264 insertions(+)
 create mode 100644 tests/expected/misc/getopt2
 create mode 100644 tests/expected/misc/getopt2-alternative_option_clash
 create mode 100644 tests/expected/misc/getopt2-alternative_option_long
 create mode 100644 tests/expected/misc/getopt2-alternative_option_short
 create mode 100644 tests/expected/misc/getopt2-invalid_getopt_option
 create mode 100644 tests/expected/misc/getopt2-invocation_model_one
 create mode 100644 tests/expected/misc/getopt2-invocation_model_three_as_one
 create mode 100644 tests/expected/misc/getopt2-invocation_model_two_as_one
 create mode 100644 tests/expected/misc/getopt2-invocation_without_parameters
 create mode 100644 tests/expected/misc/getopt2-long_option_ambiguous_1
 create mode 100644 tests/expected/misc/getopt2-longopts
 create mode 100644 tests/expected/misc/getopt2-name_option_long
 create mode 100644 tests/expected/misc/getopt2-name_option_short
 create mode 100644 tests/expected/misc/getopt2-quiet_option_long
 create mode 100644 tests/expected/misc/getopt2-quiet_option_short
 create mode 100644 tests/expected/misc/getopt2-quiet_output_option_long
 create mode 100644 tests/expected/misc/getopt2-quiet_output_option_short
 create mode 100644 tests/expected/misc/getopt2-same_long_short_options
 create mode 100644 tests/expected/misc/getopt2-test_for_enhanced_getopt
 create mode 100644 tests/expected/misc/getopt2-unknown_options
 create mode 100644 tests/expected/misc/getopt2-unquoted_option_bash
 create mode 100644 tests/expected/misc/getopt2-unquoted_option_tcsh
 create mode 100644 tests/expected/misc/getopt2-weird_quoting_bash
 create mode 100644 tests/expected/misc/getopt2-weird_quoting_tcsh
 create mode 100755 tests/ts/misc/getopt2

diff --git a/tests/expected/misc/getopt2 b/tests/expected/misc/getopt2
new file mode 100644
index 0000000..59ec59b
--- /dev/null
+++ b/tests/expected/misc/getopt2
@@ -0,0 +1,19 @@
+exit value: 0
+exit value: 0
+exit value: 0
+exit value: 1
+exit value: 0
+exit value: 0
+exit value: 0
+exit value: 0
+exit value: 1
+exit value: 0
+exit value: 0
+exit value: 0
+exit value: 0
+exit value: 0
+exit value: 1
+exit value: 1
+exit value: 0
+exit value: 0
+exit value: 1
diff --git a/tests/expected/misc/getopt2-alternative_option_clash b/tests/expected/misc/getopt2-alternative_option_clash
new file mode 100644
index 0000000..04ae19d
--- /dev/null
+++ b/tests/expected/misc/getopt2-alternative_option_clash
@@ -0,0 +1,2 @@
+ -a --abcde --abcde -a -c --
+exit value: 0
diff --git a/tests/expected/misc/getopt2-alternative_option_long b/tests/expected/misc/getopt2-alternative_option_long
new file mode 100644
index 0000000..0f5fc19
--- /dev/null
+++ b/tests/expected/misc/getopt2-alternative_option_long
@@ -0,0 +1,2 @@
+ -a --one --two 'MANDATORY' --three 'OPTIONAL' --
+exit value: 0
diff --git a/tests/expected/misc/getopt2-alternative_option_short b/tests/expected/misc/getopt2-alternative_option_short
new file mode 100644
index 0000000..0f5fc19
--- /dev/null
+++ b/tests/expected/misc/getopt2-alternative_option_short
@@ -0,0 +1,2 @@
+ -a --one --two 'MANDATORY' --three 'OPTIONAL' --
+exit value: 0
diff --git a/tests/expected/misc/getopt2-invalid_getopt_option b/tests/expected/misc/getopt2-invalid_getopt_option
new file mode 100644
index 0000000..531cc98
--- /dev/null
+++ b/tests/expected/misc/getopt2-invalid_getopt_option
@@ -0,0 +1,3 @@
+getopt: invalid option -- 'b'
+Try `getopt --help' for more information.
+exit value: 2
diff --git a/tests/expected/misc/getopt2-invocation_model_one b/tests/expected/misc/getopt2-invocation_model_one
new file mode 100644
index 0000000..ca4ddca
--- /dev/null
+++ b/tests/expected/misc/getopt2-invocation_model_one
@@ -0,0 +1,2 @@
+ -b -d  -e OPTIONAL1 -f  -a -c -ISREQUIRED -g BECOMES THREE ARGUMENTS -- ARG0 ARG1 NOT_OPTIONAL ARG2 ARG3
+exit value: 0
diff --git a/tests/expected/misc/getopt2-invocation_model_three_as_one b/tests/expected/misc/getopt2-invocation_model_three_as_one
new file mode 100644
index 0000000..1d4701f
--- /dev/null
+++ b/tests/expected/misc/getopt2-invocation_model_three_as_one
@@ -0,0 +1,2 @@
+ -b -d '' -e 'OPTIONAL1' -f '' -a -c '-ISREQUIRED' -g 'BECOMES THREE ARGUMENTS' -- 'ARG0' 'ARG1' 'NOT_OPTIONAL' 'ARG2' 'ARG3'
+exit value: 0
diff --git a/tests/expected/misc/getopt2-invocation_model_two_as_one b/tests/expected/misc/getopt2-invocation_model_two_as_one
new file mode 100644
index 0000000..1d4701f
--- /dev/null
+++ b/tests/expected/misc/getopt2-invocation_model_two_as_one
@@ -0,0 +1,2 @@
+ -b -d '' -e 'OPTIONAL1' -f '' -a -c '-ISREQUIRED' -g 'BECOMES THREE ARGUMENTS' -- 'ARG0' 'ARG1' 'NOT_OPTIONAL' 'ARG2' 'ARG3'
+exit value: 0
diff --git a/tests/expected/misc/getopt2-invocation_without_parameters b/tests/expected/misc/getopt2-invocation_without_parameters
new file mode 100644
index 0000000..08b3ed5
--- /dev/null
+++ b/tests/expected/misc/getopt2-invocation_without_parameters
@@ -0,0 +1,3 @@
+getopt: missing optstring argument
+Try `getopt --help' for more information.
+exit value: 2
diff --git a/tests/expected/misc/getopt2-long_option_ambiguous_1 b/tests/expected/misc/getopt2-long_option_ambiguous_1
new file mode 100644
index 0000000..c8cfbb3
--- /dev/null
+++ b/tests/expected/misc/getopt2-long_option_ambiguous_1
@@ -0,0 +1,3 @@
+getopt: option '--long' is ambiguous; possibilities: '--long1' '--long2'
+ --
+exit value: 1
diff --git a/tests/expected/misc/getopt2-longopts b/tests/expected/misc/getopt2-longopts
new file mode 100644
index 0000000..379b5ab
--- /dev/null
+++ b/tests/expected/misc/getopt2-longopts
@@ -0,0 +1,2 @@
+ --long1 --thirdlong 'ARGUMENT' --secondlong 'ARG' --abbriviation 'ABBRARG' -a -- 'EXTRA1'
+exit value: 0
diff --git a/tests/expected/misc/getopt2-name_option_long b/tests/expected/misc/getopt2-name_option_long
new file mode 100644
index 0000000..60b9e6b
--- /dev/null
+++ b/tests/expected/misc/getopt2-name_option_long
@@ -0,0 +1,4 @@
+THIS_PROGRAM: invalid option -- 'b'
+THIS_PROGRAM: unrecognized option '--whatever'
+ --long -a --
+exit value: 1
diff --git a/tests/expected/misc/getopt2-name_option_short b/tests/expected/misc/getopt2-name_option_short
new file mode 100644
index 0000000..60b9e6b
--- /dev/null
+++ b/tests/expected/misc/getopt2-name_option_short
@@ -0,0 +1,4 @@
+THIS_PROGRAM: invalid option -- 'b'
+THIS_PROGRAM: unrecognized option '--whatever'
+ --long -a --
+exit value: 1
diff --git a/tests/expected/misc/getopt2-quiet_option_long b/tests/expected/misc/getopt2-quiet_option_long
new file mode 100644
index 0000000..3e1a967
--- /dev/null
+++ b/tests/expected/misc/getopt2-quiet_option_long
@@ -0,0 +1,2 @@
+ --
+exit value: 1
diff --git a/tests/expected/misc/getopt2-quiet_option_short b/tests/expected/misc/getopt2-quiet_option_short
new file mode 100644
index 0000000..3e1a967
--- /dev/null
+++ b/tests/expected/misc/getopt2-quiet_option_short
@@ -0,0 +1,2 @@
+ --
+exit value: 1
diff --git a/tests/expected/misc/getopt2-quiet_output_option_long b/tests/expected/misc/getopt2-quiet_output_option_long
new file mode 100644
index 0000000..3e05ca7
--- /dev/null
+++ b/tests/expected/misc/getopt2-quiet_output_option_long
@@ -0,0 +1,5 @@
+getopt: invalid option -- 'c'
+getopt: unrecognized option '--unknown'
+getopt: option '--long' is ambiguous; possibilities: '--long1' '--long2'
+getopt: option requires an argument -- 'b'
+exit value: 1
diff --git a/tests/expected/misc/getopt2-quiet_output_option_short b/tests/expected/misc/getopt2-quiet_output_option_short
new file mode 100644
index 0000000..3e05ca7
--- /dev/null
+++ b/tests/expected/misc/getopt2-quiet_output_option_short
@@ -0,0 +1,5 @@
+getopt: invalid option -- 'c'
+getopt: unrecognized option '--unknown'
+getopt: option '--long' is ambiguous; possibilities: '--long1' '--long2'
+getopt: option requires an argument -- 'b'
+exit value: 1
diff --git a/tests/expected/misc/getopt2-same_long_short_options b/tests/expected/misc/getopt2-same_long_short_options
new file mode 100644
index 0000000..919d227
--- /dev/null
+++ b/tests/expected/misc/getopt2-same_long_short_options
@@ -0,0 +1,2 @@
+ -a --a --
+exit value: 0
diff --git a/tests/expected/misc/getopt2-test_for_enhanced_getopt b/tests/expected/misc/getopt2-test_for_enhanced_getopt
new file mode 100644
index 0000000..539db06
--- /dev/null
+++ b/tests/expected/misc/getopt2-test_for_enhanced_getopt
@@ -0,0 +1 @@
+exit value: 4
diff --git a/tests/expected/misc/getopt2-unknown_options b/tests/expected/misc/getopt2-unknown_options
new file mode 100644
index 0000000..6edba2b
--- /dev/null
+++ b/tests/expected/misc/getopt2-unknown_options
@@ -0,0 +1,4 @@
+getopt: invalid option -- 'b'
+getopt: unrecognized option '--whatever'
+ --long -a --
+exit value: 1
diff --git a/tests/expected/misc/getopt2-unquoted_option_bash b/tests/expected/misc/getopt2-unquoted_option_bash
new file mode 100644
index 0000000..8da362f
--- /dev/null
+++ b/tests/expected/misc/getopt2-unquoted_option_bash
@@ -0,0 +1,5 @@
+ -a $?!*  --long1 "\' -- More
+ than
+one
+line
+exit value: 0
diff --git a/tests/expected/misc/getopt2-unquoted_option_tcsh b/tests/expected/misc/getopt2-unquoted_option_tcsh
new file mode 100644
index 0000000..8da362f
--- /dev/null
+++ b/tests/expected/misc/getopt2-unquoted_option_tcsh
@@ -0,0 +1,5 @@
+ -a $?!*  --long1 "\' -- More
+ than
+one
+line
+exit value: 0
diff --git a/tests/expected/misc/getopt2-weird_quoting_bash b/tests/expected/misc/getopt2-weird_quoting_bash
new file mode 100644
index 0000000..db871ce
--- /dev/null
+++ b/tests/expected/misc/getopt2-weird_quoting_bash
@@ -0,0 +1,5 @@
+ -a '$?!* ' --long1 '"\'\''' -- 'More
+ than
+one
+line'
+exit value: 0
diff --git a/tests/expected/misc/getopt2-weird_quoting_tcsh b/tests/expected/misc/getopt2-weird_quoting_tcsh
new file mode 100644
index 0000000..9e5b71d
--- /dev/null
+++ b/tests/expected/misc/getopt2-weird_quoting_tcsh
@@ -0,0 +1,2 @@
+ -a '$?'\!'*'\ '' --long1 '"\\'\''' -- 'More\n'\ 'than\none\nline'
+exit value: 0
diff --git a/tests/ts/misc/getopt2 b/tests/ts/misc/getopt2
new file mode 100755
index 0000000..14deb0d
--- /dev/null
+++ b/tests/ts/misc/getopt2
@@ -0,0 +1,176 @@
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
+TS_DESC="getopt2"
+
+. $TS_TOPDIR/functions.sh
+
+ts_init "$*"
+ts_check_test_command "$TS_CMD_GETOPT"
+
+export LANG=C
+
+ts_init_subtest alternative_option_clash
+$TS_CMD_GETOPT -a -o abcde -l abcde -- -a -ab -abc -ac >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+echo "exit value: $?" >> $TS_OUTPUT
+ts_init_subtest alternative_option_long
+$TS_CMD_GETOPT --alternative -o a -l one,two:,three::,four:: -- -a -one -two=MANDATORY -three=OPTIONAL >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+echo "exit value: $?" >> $TS_OUTPUT
+ts_init_subtest alternative_option_short
+$TS_CMD_GETOPT -a -o a -l one,two:,three::,four:: -- -a -one -two=MANDATORY -three=OPTIONAL >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+echo "exit value: $?" >> $TS_OUTPUT
+ts_init_subtest invalid_getopt_option
+$TS_CMD_GETOPT -b >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+sed -i '1,1s/.*\///' $TS_OUTPUT
+ts_finalize_subtest
+
+echo "exit value: $?" >> $TS_OUTPUT
+ts_init_subtest invocation_model_one
+$TS_CMD_GETOPT abc:d::e::f::g: ARG0 -b ARG1 -d -eOPTIONAL1 -f NOT_OPTIONAL ARG2 -a -c -ISREQUIRED ARG3 -g "BECOMES THREE ARGUMENTS" >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+echo "exit value: $?" >> $TS_OUTPUT
+ts_init_subtest invocation_model_three_as_one
+$TS_CMD_GETOPT -o abc:d::e::f::g: -- ARG0 -b ARG1 -d -eOPTIONAL1 -f NOT_OPTIONAL ARG2 -a -c -ISREQUIRED ARG3 -g "BECOMES THREE ARGUMENTS" >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+echo "exit value: $?" >> $TS_OUTPUT
+ts_init_subtest invocation_model_two_as_one
+$TS_CMD_GETOPT -- abc:d::e::f::g: ARG0 -b ARG1 -d -eOPTIONAL1 -f NOT_OPTIONAL ARG2 -a -c -ISREQUIRED ARG3 -g "BECOMES THREE ARGUMENTS" >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+echo "exit value: $?" >> $TS_OUTPUT
+ts_init_subtest invocation_without_parameters
+$TS_CMD_GETOPT >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+echo "exit value: $?" >> $TS_OUTPUT
+ts_init_subtest long_option_ambiguous_1
+$TS_CMD_GETOPT -o a -l long1,long2 -- --long >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+sed -i '1,1s/.*\///' $TS_OUTPUT
+ts_finalize_subtest
+
+echo "exit value: $?" >> $TS_OUTPUT
+ts_init_subtest longopts
+$TS_CMD_GETOPT -o a -l long1,secondlong:,thirdlong::,abbriviation: -- --long1 EXTRA1 --thirdlong=ARGUMENT --secondlong=ARG --abbr ABBRARG -a >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+echo "exit value: $?" >> $TS_OUTPUT
+ts_init_subtest name_option_long
+$TS_CMD_GETOPT -n THIS_PROGRAM -o a -l long -- -b --long --whatever -a >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+echo "exit value: $?" >> $TS_OUTPUT
+ts_init_subtest name_option_short
+$TS_CMD_GETOPT --name THIS_PROGRAM -o a -l long -- -b --long --whatever -a >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+echo "exit value: $?" >> $TS_OUTPUT
+ts_init_subtest quiet_option_long
+$TS_CMD_GETOPT --quiet -o a,b: -l long1,long2 -- -c --unknown --long -b >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+echo "exit value: $?" >> $TS_OUTPUT
+ts_init_subtest quiet_option_short
+$TS_CMD_GETOPT -q -o a,b: -l long1,long2 -- -c --unknown --long -b >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+echo "exit value: $?" >> $TS_OUTPUT
+ts_init_subtest quiet_output_option_long
+$TS_CMD_GETOPT --quiet-output -o a,b: -l long1,long2 -- -c --unknown --long -b >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+sed -i '1,4s/.*\///' $TS_OUTPUT
+ts_finalize_subtest
+
+echo "exit value: $?" >> $TS_OUTPUT
+ts_init_subtest quiet_output_option_short
+$TS_CMD_GETOPT -Q -o a,b: -l long1,long2 -- -c --unknown --long -b >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+sed -i '1,4s/.*\///' $TS_OUTPUT
+ts_finalize_subtest
+
+echo "exit value: $?" >> $TS_OUTPUT
+ts_init_subtest same_long_short_options
+$TS_CMD_GETOPT -o a -l a -- -a --a >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+echo "exit value: $?" >> $TS_OUTPUT
+ts_init_subtest test_for_enhanced_getopt
+$TS_CMD_GETOPT -T >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+echo "exit value: $?" >> $TS_OUTPUT
+ts_init_subtest unknown_options
+$TS_CMD_GETOPT -o a -l long -- -b --long --whatever -a >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+sed -i '1,2s/.*\///' $TS_OUTPUT
+ts_finalize_subtest
+
+echo "exit value: $?" >> $TS_OUTPUT
+ts_init_subtest unquoted_option_bash
+$TS_CMD_GETOPT -s bash -u -o a: -l long1: -- -a '$?!* ' --long \"\\\' 'More
+ than
+one
+line' >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+ts_init_subtest unquoted_option_tcsh
+$TS_CMD_GETOPT -s tcsh --unquoted -o a: -l long1: -- -a '$?!* ' --long \"\\\' 'More
+ than
+one
+line' >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+ts_init_subtest weird_quoting_bash
+$TS_CMD_GETOPT -s bash -o a: -l long1: -- -a '$?!* ' --long \"\\\' 'More
+ than
+one
+line' >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+ts_init_subtest weird_quoting_tcsh
+$TS_CMD_GETOPT --shell tcsh -o a: -l long1: -- -a '$?!* ' --long \"\\\' 'More
+ than
+one
+line' >> $TS_OUTPUT 2>&1
+echo "exit value: $?" >> $TS_OUTPUT
+ts_finalize_subtest
+
+ts_finalize
-- 
2.1.3

