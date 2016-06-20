Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f195.google.com ([209.85.217.195]:36138 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754261AbcFTUlH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 20 Jun 2016 16:41:07 -0400
Received: by mail-lb0-f195.google.com with SMTP id z2so160773lbu.3
        for <util-linux@vger.kernel.org>; Mon, 20 Jun 2016 13:40:50 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 5/6] tests: remove utmpdump localization go-around
Date: Mon, 20 Jun 2016 21:40:36 +0100
Message-Id: <20160620204037.3292-6-kerolasa@iki.fi>
In-Reply-To: <20160620204037.3292-1-kerolasa@iki.fi>
References: <20160620204037.3292-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The utmpdump timestamps are unambiguous, so forcing locale environment is
never needed.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/ts/utmp/utmpdump-circle     | 2 --
 tests/ts/utmp/utmpdump-tobin      | 2 --
 tests/ts/utmp/utmpdump-tobin-ipv6 | 2 --
 tests/ts/utmp/utmpdump-totxt      | 2 --
 tests/ts/utmp/utmpdump-totxt-ipv6 | 2 --
 5 files changed, 10 deletions(-)

diff --git a/tests/ts/utmp/utmpdump-circle b/tests/ts/utmp/utmpdump-circle
index 9663dba..41d7de6 100755
--- a/tests/ts/utmp/utmpdump-circle
+++ b/tests/ts/utmp/utmpdump-circle
@@ -21,8 +21,6 @@ ts_init "$*"
 # this test is arch independent, no need for utmp_functions.sh
 ts_check_test_command "$TS_CMD_UTMPDUMP"
 
-export LANG=C
-export TZ=GMT
 OUT_BIN1=${TS_OUTDIR}/${TS_TESTNAME}.bin1
 OUT_BIN2=${TS_OUTDIR}/${TS_TESTNAME}.bin2
 OUT_TXT=${TS_OUTDIR}/${TS_TESTNAME}.txt
diff --git a/tests/ts/utmp/utmpdump-tobin b/tests/ts/utmp/utmpdump-tobin
index 2f14bfc..4054952 100755
--- a/tests/ts/utmp/utmpdump-tobin
+++ b/tests/ts/utmp/utmpdump-tobin
@@ -21,8 +21,6 @@ ts_init "$*"
 . "$TS_SELF/utmp_functions.sh"
 [ $SIZEOF_UTMP -eq 384 ] || ts_skip "utmp struct size $SIZEOF_UTMP"
 
-export LANG=C
-export TZ=GMT
 OUTFILE=${TS_OUTDIR}/${TS_TESTNAME}.file
 $TS_CMD_UTMPDUMP -r $TS_SELF/txt-b >| $OUTFILE 2>/dev/null
 if diff -q $TS_SELF/wtmp-b.$BYTE_ORDER $OUTFILE; then
diff --git a/tests/ts/utmp/utmpdump-tobin-ipv6 b/tests/ts/utmp/utmpdump-tobin-ipv6
index e0b19cd..3198d3c 100755
--- a/tests/ts/utmp/utmpdump-tobin-ipv6
+++ b/tests/ts/utmp/utmpdump-tobin-ipv6
@@ -21,8 +21,6 @@ ts_init "$*"
 . "$TS_SELF/utmp_functions.sh"
 [ $SIZEOF_UTMP -eq 384 ] || ts_skip "utmp struct size $SIZEOF_UTMP"
 
-export LANG=C
-export TZ=GMT
 OUTFILE=${TS_OUTDIR}/${TS_TESTNAME}.file
 $TS_CMD_UTMPDUMP -r $TS_SELF/txt-ipv6 >| $OUTFILE 2>/dev/null
 if diff -q $TS_SELF/wtmp-ipv6.$BYTE_ORDER $OUTFILE; then
diff --git a/tests/ts/utmp/utmpdump-totxt b/tests/ts/utmp/utmpdump-totxt
index 37d376a..cde1f4c 100755
--- a/tests/ts/utmp/utmpdump-totxt
+++ b/tests/ts/utmp/utmpdump-totxt
@@ -21,8 +21,6 @@ ts_init "$*"
 . "$TS_SELF/utmp_functions.sh"
 [ $SIZEOF_UTMP -eq 384 ] || ts_skip "utmp struct size $SIZEOF_UTMP"
 
-export LANG=C
-export TZ=GMT
 $TS_CMD_UTMPDUMP $TS_SELF/wtmp-b.$BYTE_ORDER >| $TS_OUTPUT 2>/dev/null
 
 ts_finalize
diff --git a/tests/ts/utmp/utmpdump-totxt-ipv6 b/tests/ts/utmp/utmpdump-totxt-ipv6
index 1b21783..5fc3d9c 100755
--- a/tests/ts/utmp/utmpdump-totxt-ipv6
+++ b/tests/ts/utmp/utmpdump-totxt-ipv6
@@ -21,8 +21,6 @@ ts_init "$*"
 . "$TS_SELF/utmp_functions.sh"
 [ $SIZEOF_UTMP -eq 384 ] || ts_skip "utmp struct size $SIZEOF_UTMP"
 
-export LANG=C
-export TZ=GMT
 $TS_CMD_UTMPDUMP $TS_SELF/wtmp-ipv6.$BYTE_ORDER >| $TS_OUTPUT 2>/dev/null
 
 ts_finalize
-- 
2.9.0

