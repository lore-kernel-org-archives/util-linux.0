Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35311 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbaBPXyx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Feb 2014 18:54:53 -0500
Received: by mail-wi0-f169.google.com with SMTP id e4so1876381wiv.2
        for <util-linux@vger.kernel.org>; Sun, 16 Feb 2014 15:54:52 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 8/9] tests: add isosize --sectors and --divisor tests
Date: Sun, 16 Feb 2014 23:54:21 +0000
Message-Id: <1392594862-15807-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1392594862-15807-1-git-send-email-kerolasa@iki.fi>
References: <1392594862-15807-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/isosize/print-size                |  1 -
 tests/expected/isosize/print-size-default_output |  1 +
 tests/expected/isosize/print-size-divisor_output |  1 +
 tests/expected/isosize/print-size-sector_output  |  1 +
 tests/ts/isosize/print-size                      | 13 ++++++++++++-
 5 files changed, 15 insertions(+), 2 deletions(-)
 delete mode 100644 tests/expected/isosize/print-size
 create mode 100644 tests/expected/isosize/print-size-default_output
 create mode 100644 tests/expected/isosize/print-size-divisor_output
 create mode 100644 tests/expected/isosize/print-size-sector_output

diff --git a/tests/expected/isosize/print-size b/tests/expected/isosize/print-size
deleted file mode 100644
index 3def437..0000000
--- a/tests/expected/isosize/print-size
+++ /dev/null
@@ -1 +0,0 @@
-515899392
diff --git a/tests/expected/isosize/print-size-default_output b/tests/expected/isosize/print-size-default_output
new file mode 100644
index 0000000..3def437
--- /dev/null
+++ b/tests/expected/isosize/print-size-default_output
@@ -0,0 +1 @@
+515899392
diff --git a/tests/expected/isosize/print-size-divisor_output b/tests/expected/isosize/print-size-divisor_output
new file mode 100644
index 0000000..ee214a6
--- /dev/null
+++ b/tests/expected/isosize/print-size-divisor_output
@@ -0,0 +1 @@
+57322154
diff --git a/tests/expected/isosize/print-size-sector_output b/tests/expected/isosize/print-size-sector_output
new file mode 100644
index 0000000..dff3634
--- /dev/null
+++ b/tests/expected/isosize/print-size-sector_output
@@ -0,0 +1 @@
+sector count: 251904, sector size: 2048
diff --git a/tests/ts/isosize/print-size b/tests/ts/isosize/print-size
index 312fdc1..277c124 100755
--- a/tests/ts/isosize/print-size
+++ b/tests/ts/isosize/print-size
@@ -20,7 +20,18 @@ ts_init "$*"
 
 ts_check_test_command "$TS_CMD_ISOSIZE"
 
-gzip -cd $TS_SELF/sample.iso.gz > $TS_OUTDIR/sample.iso
+gzip -cd $TS_SELF/sample.iso.gz >| $TS_OUTDIR/sample.iso
+
+ts_init_subtest "default_output"
 $TS_CMD_ISOSIZE $TS_OUTDIR/sample.iso >| $TS_OUTPUT 2>&1
+ts_finalize_subtest
+
+ts_init_subtest "sector_output"
+$TS_CMD_ISOSIZE --sectors $TS_OUTDIR/sample.iso &> $TS_OUTPUT 2>&1
+ts_finalize_subtest
+
+ts_init_subtest "divisor_output"
+$TS_CMD_ISOSIZE --divisor=9 $TS_OUTDIR/sample.iso &> $TS_OUTPUT 2>&1
+ts_finalize_subtest
 
 ts_finalize
-- 
1.9.0

