Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35669 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277AbcFTUlH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 20 Jun 2016 16:41:07 -0400
Received: by mail-lf0-f65.google.com with SMTP id w130so6673512lfd.2
        for <util-linux@vger.kernel.org>; Mon, 20 Jun 2016 13:40:51 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 6/6] tests: utmpdump add subsecond accuracy test
Date: Mon, 20 Jun 2016 21:40:37 +0100
Message-Id: <20160620204037.3292-7-kerolasa@iki.fi>
In-Reply-To: <20160620204037.3292-1-kerolasa@iki.fi>
References: <20160620204037.3292-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/utmp/utmpdump-subsecond |  5 +++++
 tests/ts/utmp/subsec                   |  3 +++
 tests/ts/utmp/utmpdump-subsecond       | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)
 create mode 100644 tests/expected/utmp/utmpdump-subsecond
 create mode 100644 tests/ts/utmp/subsec
 create mode 100755 tests/ts/utmp/utmpdump-subsecond

diff --git a/tests/expected/utmp/utmpdump-subsecond b/tests/expected/utmp/utmpdump-subsecond
new file mode 100644
index 0000000..9ec40da
--- /dev/null
+++ b/tests/expected/utmp/utmpdump-subsecond
@@ -0,0 +1,5 @@
+last 9 is expected to disappear in conversion
+3c3
+< [0] [00000] [ts/0] [nonvalid] [foo         ] [zero                ] [0.0.0.0        ] [2013-08-28T12:00:00,123456789+0000]
+---
+> [0] [00000] [ts/0] [nonvalid] [foo         ] [zero                ] [0.0.0.0        ] [2013-08-28T12:00:00,12345678+0000]
diff --git a/tests/ts/utmp/subsec b/tests/ts/utmp/subsec
new file mode 100644
index 0000000..4881e7c
--- /dev/null
+++ b/tests/ts/utmp/subsec
@@ -0,0 +1,3 @@
+[7] [00010] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:30:40,123456+0000]
+[8] [00011] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:40:50,999999+0000]
+[0] [00000] [ts/0] [nonvalid] [foo         ] [zero                ] [0.0.0.0        ] [2013-08-28T12:00:00,123456789+0000]
diff --git a/tests/ts/utmp/utmpdump-subsecond b/tests/ts/utmp/utmpdump-subsecond
new file mode 100755
index 0000000..f753a6d
--- /dev/null
+++ b/tests/ts/utmp/utmpdump-subsecond
@@ -0,0 +1,34 @@
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
+TS_DESC="subsecond"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+# this test is arch independent, no need for utmp_functions.sh
+ts_check_test_command "$TS_CMD_UTMPDUMP"
+
+OUT_BIN=${TS_OUTDIR}/${TS_TESTNAME}.bin
+OUT_TXT=${TS_OUTDIR}/${TS_TESTNAME}.txt
+
+echo "last 9 is expected to disappear in conversion" > $TS_OUTPUT
+$TS_CMD_UTMPDUMP -r $TS_SELF/subsec > $OUT_BIN 2>/dev/null
+$TS_CMD_UTMPDUMP $OUT_BIN > $OUT_TXT 2>/dev/null
+diff $TS_SELF/subsec $OUT_TXT >> $TS_OUTPUT 2>&1
+
+rm -f "$OUT_BIN" "$OUT_TXT"
+
+ts_finalize
-- 
2.9.0

