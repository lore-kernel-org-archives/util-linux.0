Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34733 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932726AbbHJVOI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Aug 2015 17:14:08 -0400
Received: by wicne3 with SMTP id ne3so151909361wic.1
        for <util-linux@vger.kernel.org>; Mon, 10 Aug 2015 14:14:05 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/4] tests: add colcrt regression tests
Date: Mon, 10 Aug 2015 22:13:54 +0100
Message-Id: <1439241234-2527-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Thanks to Alaa Mubaied for providing crash1 input file making colcrt to
crash.  The crash2 was generated using American Fuzzy Lop.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh                        |   1 +
 tests/expected/colcrt/regressions-crash1 |   1 +
 tests/expected/colcrt/regressions-crash2 | 386 +++++++++++++++++++++++++++++++
 tests/ts/colcrt/crash1                   | Bin 0 -> 314 bytes
 tests/ts/colcrt/crash2                   | Bin 0 -> 776 bytes
 tests/ts/colcrt/regressions              |  34 +++
 6 files changed, 422 insertions(+)
 create mode 100644 tests/expected/colcrt/regressions-crash1
 create mode 100644 tests/expected/colcrt/regressions-crash2
 create mode 100644 tests/ts/colcrt/crash1
 create mode 100644 tests/ts/colcrt/crash2
 create mode 100755 tests/ts/colcrt/regressions

diff --git a/tests/commands.sh b/tests/commands.sh
index bb985c7..737918f 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -37,6 +37,7 @@ TS_CMD_DELPART=${TS_CMD_DELPART:-"$top_builddir/delpart"}
 TS_CMD_BLKDISCARD=${TS_CMD_BLKID-"$top_builddir/blkdiscard"}
 TS_CMD_BLKID=${TS_CMD_BLKID-"$top_builddir/blkid"}
 TS_CMD_CAL=${TS_CMD_CAL-"$top_builddir/cal"}
+TS_CMD_COLCRT=${TS_CMD_COLCRT:-"$top_builddir/colcrt"}
 TS_CMD_COLRM=${TS_CMD_COLRM:-"$top_builddir/colrm"}
 TS_CMD_COL=${TS_CMD_COL:-"$top_builddir/col"}
 TS_CMD_COLUMN=${TS_CMD_COLUMN:-"$top_builddir/column"}
diff --git a/tests/expected/colcrt/regressions-crash1 b/tests/expected/colcrt/regressions-crash1
new file mode 100644
index 0000000..a221b56
--- /dev/null
+++ b/tests/expected/colcrt/regressions-crash1
@@ -0,0 +1 @@
+return value: 0
diff --git a/tests/expected/colcrt/regressions-crash2 b/tests/expected/colcrt/regressions-crash2
new file mode 100644
index 0000000..a4472fa
--- /dev/null
+++ b/tests/expected/colcrt/regressions-crash2
@@ -0,0 +1,386 @@
+        
+
+FGHIKIJKN\|
+
+MN9|    
+XYZRnT RnTUV|   NXP:w|  
+
+MN
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+'QRnTUVWXYZQRnTU|
+
+MN9|    
+|       
+
+return value: 0
diff --git a/tests/ts/colcrt/crash1 b/tests/ts/colcrt/crash1
new file mode 100644
index 0000000000000000000000000000000000000000..668118134ef6a76439c0741e0f4cfa8514da02b9
GIT binary patch
literal 314
zcmazS#|{_-u#1x?8cv=zB6RT+p$1(Es-E~z>v$jlkuLG^X$S^T5G(+s?c(DV6yhDi
P<KtuNfL!nR_$hS&Rqrbz

literal 0
HcmV?d00001

diff --git a/tests/ts/colcrt/crash2 b/tests/ts/colcrt/crash2
new file mode 100644
index 0000000000000000000000000000000000000000..0843cb677a52068f453b6aa3705cbb75a5333f55
GIT binary patch
literal 776
zcmZQzWMbyv<Z^TO@MQ4z^zvr#ixCrNVUUux6kw<UN^$x6L0Oz!5s^_rc_9iw92y3e
z<n)UOuqsDU&k58Z%SB%xLSO3!t8KDW0P5tM5eQBf;lM-!X5mUf@x-Jc{{Rek=wXOZ
IQQ)jB08vdz82|tP

literal 0
HcmV?d00001

diff --git a/tests/ts/colcrt/regressions b/tests/ts/colcrt/regressions
new file mode 100755
index 0000000..067523f
--- /dev/null
+++ b/tests/ts/colcrt/regressions
@@ -0,0 +1,34 @@
+#!/bin/bash
+
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
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="regressions"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_COLCRT"
+
+check_input_file() {
+	ts_init_subtest ${1##*/}
+	$TS_CMD_COLCRT < $1 > $TS_OUTPUT 2>&1
+	echo "return value: $?" >> $TS_OUTPUT
+	ts_finalize_subtest
+}
+
+check_input_file "$TS_SELF/crash1"
+check_input_file "$TS_SELF/crash2"
+
+ts_finalize
-- 
2.5.0

