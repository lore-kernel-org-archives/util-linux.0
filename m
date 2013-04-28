Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f180.google.com ([74.125.82.180]:40289 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755633Ab3D1RLg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Apr 2013 13:11:36 -0400
Received: by mail-we0-f180.google.com with SMTP id x43so4758569wey.11
        for <util-linux@vger.kernel.org>; Sun, 28 Apr 2013 10:11:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/11] tests: add cal day highlight corner cases
Date: Sun, 28 Apr 2013 18:11:05 +0100
Message-Id: <1367169067-23705-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
References: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Check the first, last, and strange Sep 1752 dates are highlighted
correctly.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/cal/highlight | 55 ++++++++++++++++++++++++++++++++++
 tests/ts/cal/highlight       | 70 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)
 create mode 100644 tests/expected/cal/highlight
 create mode 100755 tests/ts/cal/highlight

diff --git a/tests/expected/cal/highlight b/tests/expected/cal/highlight
new file mode 100644
index 0000000..9e70d12
--- /dev/null
+++ b/tests/expected/cal/highlight
@@ -0,0 +1,55 @@
+
+First day
+      January 1     
+Su Mo Tu We Th Fr Sa
+                  [7m 1[27m
+ 2  3  4  5  6  7  8
+ 9 10 11 12 13 14 15
+16 17 18 19 20 21 22
+23 24 25 26 27 28 29
+30 31
+Reformation corner cases 1
+   September 1752   
+Su Mo Tu We Th Fr Sa
+       1 [7m 2[27m 14 15 16
+17 18 19 20 21 22 23
+24 25 26 27 28 29 30
+
+
+
+Reformation corner cases 2
+   September 1752   
+Su Mo Tu We Th Fr Sa
+       1  2 14 15 16
+17 18 19 20 21 22 23
+24 25 26 27 28 29 30
+
+
+
+Reformation corner cases 3
+   September 1752   
+Su Mo Tu We Th Fr Sa
+       1  2 14 15 16
+17 18 19 20 21 22 23
+24 25 26 27 28 29 30
+
+
+
+Reformation corner cases 4
+   September 1752   
+Su Mo Tu We Th Fr Sa
+       1  2 [7m14[27m 15 16
+17 18 19 20 21 22 23
+24 25 26 27 28 29 30
+
+
+
+Last day
+    December 9999   
+Su Mo Tu We Th Fr Sa
+          1  2  3  4
+ 5  6  7  8  9 10 11
+12 13 14 15 16 17 18
+19 20 21 22 23 24 25
+26 27 28 29 30 [7m31[27m
+
diff --git a/tests/ts/cal/highlight b/tests/ts/cal/highlight
new file mode 100755
index 0000000..9532ee7
--- /dev/null
+++ b/tests/ts/cal/highlight
@@ -0,0 +1,70 @@
+#!/bin/bash
+
+#
+# Copyright (C) 2007 Karel Zak <kzak@redhat.com>
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
+TS_TOPDIR="$(dirname $0)/../.."
+TS_DESC="highlights"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+set -o pipefail
+
+USETERM=$( ts_has_option "useterm" "$*" )
+
+[ "$USETERM" == "yes" ] && TS_VERBOSE="yes"
+ts_log ""
+
+ts_log "First day"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL 1 1 1
+fi
+$TS_CMD_CAL 1 1 1 >> $TS_OUTPUT
+
+ts_log "Reformation corner cases 1"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL 2 9 1752
+fi
+$TS_CMD_CAL 2 9 1752 >> $TS_OUTPUT
+
+ts_log "Reformation corner cases 2"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL 3 9 1752
+fi
+$TS_CMD_CAL 3 9 1752 >> $TS_OUTPUT
+
+ts_log "Reformation corner cases 3"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL 13 9 1752
+fi
+$TS_CMD_CAL 13 9 1752 >> $TS_OUTPUT
+
+ts_log "Reformation corner cases 4"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL 14 9 1752
+fi
+$TS_CMD_CAL 14 9 1752 >> $TS_OUTPUT
+
+ts_log "Last day"
+if [ "$USETERM" == "yes" ]; then
+	$TS_CMD_CAL 31 12 9999
+fi
+$TS_CMD_CAL 31 12 9999 >> $TS_OUTPUT
+
+
+ts_finalize
+
-- 
1.8.2.2

