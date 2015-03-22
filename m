Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37998 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbbCVXFg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Mar 2015 19:05:36 -0400
Received: by wibgn9 with SMTP id gn9so44927286wib.1
        for <util-linux@vger.kernel.org>; Sun, 22 Mar 2015 16:05:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/5] tests: add dmesg multiline message check
Date: Sun, 22 Mar 2015 23:05:27 +0000
Message-Id: <1427065530-10695-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1427065530-10695-1-git-send-email-kerolasa@iki.fi>
References: <1427065530-10695-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/dmesg/indentation | 20 ++++++++++++++++++++
 tests/ts/dmesg/indentation       | 31 +++++++++++++++++++++++++++++++
 tests/ts/dmesg/newlines          |  5 +++++
 3 files changed, 56 insertions(+)
 create mode 100644 tests/expected/dmesg/indentation
 create mode 100755 tests/ts/dmesg/indentation
 create mode 100644 tests/ts/dmesg/newlines

diff --git a/tests/expected/dmesg/indentation b/tests/expected/dmesg/indentation
new file mode 100644
index 0000000..e32d87f
--- /dev/null
+++ b/tests/expected/dmesg/indentation
@@ -0,0 +1,20 @@
+[    1.000000] new
+               line
+[    2.000000] two
+               new
+               lines
+user  :crit  : [    1.000000] new
+                              line
+mail  :warn  : [    2.000000] two
+                              new
+                              lines
+[<    0.000000>] new
+                 line
+[<    1.000000>] two
+                 new
+                 lines
+new
+line
+two
+new
+lines
diff --git a/tests/ts/dmesg/indentation b/tests/ts/dmesg/indentation
new file mode 100755
index 0000000..7419888
--- /dev/null
+++ b/tests/ts/dmesg/indentation
@@ -0,0 +1,31 @@
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
+TS_DESC="indentation"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_DMESG"
+
+$TS_CMD_DMESG -F $TS_SELF/newlines > $TS_OUTPUT 2>&1
+
+$TS_CMD_DMESG -F $TS_SELF/newlines -x >> $TS_OUTPUT 2>&1
+
+$TS_CMD_DMESG --time-format=delta --file $TS_SELF/newlines >> $TS_OUTPUT 2>&1
+
+$TS_CMD_DMESG --time-format=notime --file $TS_SELF/newlines >> $TS_OUTPUT 2>&1
+
+ts_finalize
diff --git a/tests/ts/dmesg/newlines b/tests/ts/dmesg/newlines
new file mode 100644
index 0000000..6b298c6
--- /dev/null
+++ b/tests/ts/dmesg/newlines
@@ -0,0 +1,5 @@
+<10>[    1.000000] new
+line
+<20>[    2.000000] two
+new
+lines
-- 
2.3.3

