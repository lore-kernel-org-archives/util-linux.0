Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f180.google.com ([74.125.82.180]:36702 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbbCOMzP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 Mar 2015 08:55:15 -0400
Received: by wetk59 with SMTP id k59so20841327wet.3
        for <util-linux@vger.kernel.org>; Sun, 15 Mar 2015 05:55:13 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 8/8] tests: add logger(1) error condition tests
Date: Sun, 15 Mar 2015 12:54:54 +0000
Message-Id: <1426424094-25451-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
References: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/logger/errors                       |  0
 tests/expected/logger/errors-id_with_space         |  2 +
 tests/expected/logger/errors-invalid_prio          |  1 +
 tests/expected/logger/errors-kern_priority         |  1 +
 tests/expected/logger/errors-kern_priority_numeric |  1 +
 tests/expected/logger/errors-rfc5424_exceed_size   |  1 +
 .../logger/errors-rfc5424_msgid_with_space         |  1 +
 tests/expected/logger/errors-tag_with_space        |  2 +
 tests/ts/logger/errors                             | 60 ++++++++++++++++++++++
 9 files changed, 69 insertions(+)
 create mode 100644 tests/expected/logger/errors
 create mode 100644 tests/expected/logger/errors-id_with_space
 create mode 100644 tests/expected/logger/errors-invalid_prio
 create mode 100644 tests/expected/logger/errors-kern_priority
 create mode 100644 tests/expected/logger/errors-kern_priority_numeric
 create mode 100644 tests/expected/logger/errors-rfc5424_exceed_size
 create mode 100644 tests/expected/logger/errors-rfc5424_msgid_with_space
 create mode 100644 tests/expected/logger/errors-tag_with_space
 create mode 100755 tests/ts/logger/errors

diff --git a/tests/expected/logger/errors b/tests/expected/logger/errors
new file mode 100644
index 0000000..e69de29
diff --git a/tests/expected/logger/errors-id_with_space b/tests/expected/logger/errors-id_with_space
new file mode 100644
index 0000000..081efac
--- /dev/null
+++ b/tests/expected/logger/errors-id_with_space
@@ -0,0 +1,2 @@
+test_logger: failed to parse id: 'A B'
+test_logger: failed to parse id: 'A B'
diff --git a/tests/expected/logger/errors-invalid_prio b/tests/expected/logger/errors-invalid_prio
new file mode 100644
index 0000000..cf79cf3
--- /dev/null
+++ b/tests/expected/logger/errors-invalid_prio
@@ -0,0 +1 @@
+test_logger: unknown priority name: 8
diff --git a/tests/expected/logger/errors-kern_priority b/tests/expected/logger/errors-kern_priority
new file mode 100644
index 0000000..6656db0
--- /dev/null
+++ b/tests/expected/logger/errors-kern_priority
@@ -0,0 +1 @@
+<8>Feb 13 23:31:30 prio: message
diff --git a/tests/expected/logger/errors-kern_priority_numeric b/tests/expected/logger/errors-kern_priority_numeric
new file mode 100644
index 0000000..6656db0
--- /dev/null
+++ b/tests/expected/logger/errors-kern_priority_numeric
@@ -0,0 +1 @@
+<8>Feb 13 23:31:30 prio: message
diff --git a/tests/expected/logger/errors-rfc5424_exceed_size b/tests/expected/logger/errors-rfc5424_exceed_size
new file mode 100644
index 0000000..35750b7
--- /dev/null
+++ b/tests/expected/logger/errors-rfc5424_exceed_size
@@ -0,0 +1 @@
+<13>1 2009-02-13T23:31:30.123456+00:00 test-hostname rfc5424_exceed_size - - [timeQuality tzKnown="1" isSynced="1" syncAccuracy="123456"] abc
diff --git a/tests/expected/logger/errors-rfc5424_msgid_with_space b/tests/expected/logger/errors-rfc5424_msgid_with_space
new file mode 100644
index 0000000..273bc9b
--- /dev/null
+++ b/tests/expected/logger/errors-rfc5424_msgid_with_space
@@ -0,0 +1 @@
+test_logger: --msgid cannot contain space
diff --git a/tests/expected/logger/errors-tag_with_space b/tests/expected/logger/errors-tag_with_space
new file mode 100644
index 0000000..31a86af
--- /dev/null
+++ b/tests/expected/logger/errors-tag_with_space
@@ -0,0 +1,2 @@
+<13>Feb 13 23:31:30 A B: tag_with_space
+<13>1 2009-02-13T23:31:30.123456+00:00 test-hostname A B - - [timeQuality tzKnown="1" isSynced="1" syncAccuracy="123456"] tag_with_space_rfc5424
diff --git a/tests/ts/logger/errors b/tests/ts/logger/errors
new file mode 100755
index 0000000..1051b55
--- /dev/null
+++ b/tests/ts/logger/errors
@@ -0,0 +1,60 @@
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
+TS_DESC="errors"
+
+. $TS_TOPDIR/functions.sh
+
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_LOGGER"
+
+ts_init_subtest "kern_priority"
+$TS_HELPER_LOGGER -s -t "prio" -p kern.emerg "message" > "$TS_OUTPUT" 2>&1
+ts_finalize_subtest
+
+ts_init_subtest "kern_priority_numeric"
+$TS_HELPER_LOGGER -s -t "prio" -p 0 "message" > "$TS_OUTPUT" 2>&1
+ts_finalize_subtest
+
+ts_init_subtest "invalid_prio"
+$TS_HELPER_LOGGER -s -t "prio" -p 8 "message" > "$TS_OUTPUT" 2>&1
+ts_finalize_subtest
+
+# should truncate
+ts_init_subtest "rfc5424_exceed_size"
+$TS_HELPER_LOGGER -s -t "rfc5424_exceed_size" --rfc5424 --size 3 "abcd" > "$TS_OUTPUT" 2>&1
+ts_finalize_subtest
+
+ts_init_subtest "id_with_space"
+$TS_HELPER_LOGGER -s -t "id_with_space" --id="A B" "message" > "$TS_OUTPUT" 2>&1
+$TS_HELPER_LOGGER -s -t "rfc5424_id_with_space" --rfc5424 --id="A B" "message" >> "$TS_OUTPUT" 2>&1
+ts_finalize_subtest
+
+# should not fail
+ts_init_subtest "tag_with_space"
+$TS_HELPER_LOGGER -s -t "A B" "tag_with_space" > "$TS_OUTPUT" 2>&1
+$TS_HELPER_LOGGER -s -t "A B" --rfc5424 "tag_with_space_rfc5424" >> "$TS_OUTPUT" 2>&1
+ts_finalize_subtest
+
+ts_init_subtest "rfc5424_msgid_with_space"
+$TS_HELPER_LOGGER -s -t "rfc5424_msgid_with_space" --rfc5424 --msgid="A B" "message" > "$TS_OUTPUT" 2>&1
+ts_finalize_subtest
+
+ts_finalize
-- 
2.3.2

