Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:60953 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbdFABIu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 31 May 2017 21:08:50 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/6] tests: avoid diff of diffs
Date: Thu,  1 Jun 2017 03:08:36 +0200
Message-Id: <1496279320-14541-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de>
References: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Certain diff implementations do not produce comparable output.

Noticed on Alpine Linux/busybox.

CC: Sami Kerola <kerolasa@iki.fi>
Reported-by: Assaf Gordon <assafgordon@gmail.com>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/utmp/utmpdump-subsecond | 7 +++----
 tests/ts/utmp/utmpdump-subsecond       | 4 +---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/tests/expected/utmp/utmpdump-subsecond b/tests/expected/utmp/utmpdump-subsecond
index 9ec40da..649ab7f 100644
--- a/tests/expected/utmp/utmpdump-subsecond
+++ b/tests/expected/utmp/utmpdump-subsecond
@@ -1,5 +1,4 @@
 last 9 is expected to disappear in conversion
-3c3
-< [0] [00000] [ts/0] [nonvalid] [foo         ] [zero                ] [0.0.0.0        ] [2013-08-28T12:00:00,123456789+0000]
----
-> [0] [00000] [ts/0] [nonvalid] [foo         ] [zero                ] [0.0.0.0        ] [2013-08-28T12:00:00,12345678+0000]
+[7] [00010] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:30:40,123456+0000]
+[8] [00011] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:40:50,999999+0000]
+[0] [00000] [ts/0] [nonvalid] [foo         ] [zero                ] [0.0.0.0        ] [2013-08-28T12:00:00,12345678+0000]
diff --git a/tests/ts/utmp/utmpdump-subsecond b/tests/ts/utmp/utmpdump-subsecond
index f753a6d..49dc9d6 100755
--- a/tests/ts/utmp/utmpdump-subsecond
+++ b/tests/ts/utmp/utmpdump-subsecond
@@ -22,12 +22,10 @@ ts_init "$*"
 ts_check_test_command "$TS_CMD_UTMPDUMP"
 
 OUT_BIN=${TS_OUTDIR}/${TS_TESTNAME}.bin
-OUT_TXT=${TS_OUTDIR}/${TS_TESTNAME}.txt
 
 echo "last 9 is expected to disappear in conversion" > $TS_OUTPUT
 $TS_CMD_UTMPDUMP -r $TS_SELF/subsec > $OUT_BIN 2>/dev/null
-$TS_CMD_UTMPDUMP $OUT_BIN > $OUT_TXT 2>/dev/null
-diff $TS_SELF/subsec $OUT_TXT >> $TS_OUTPUT 2>&1
+$TS_CMD_UTMPDUMP $OUT_BIN >> $TS_OUTPUT 2>/dev/null
 
 rm -f "$OUT_BIN" "$OUT_TXT"
 
-- 
1.8.5.6

