Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:52675 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756716AbdDFH4M (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 6 Apr 2017 03:56:12 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Masatake YAMATO <yamato@redhat.com>
Subject: [PATCH 4/5] tests: handle dd errors in fincore/count
Date: Thu,  6 Apr 2017 09:56:04 +0200
Message-Id: <1491465365-7515-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1491465365-7515-1-git-send-email-sweet_f_a@gmx.de>
References: <1491465365-7515-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

On dd error the test will fail earlier and the test diff will be
more useful.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/fincore/count | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/tests/ts/fincore/count b/tests/ts/fincore/count
index be81552..fd50ff8 100755
--- a/tests/ts/fincore/count
+++ b/tests/ts/fincore/count
@@ -17,6 +17,20 @@ function make_input_name
     echo ${prefix}$(sed -e "s/[^-+a-zA-Z0-9_]/_/g"<<<"$header")
 }
 
+function _dd
+{
+	local msg
+	local ret=0
+
+	msg=$(dd "$@" 2>&1)
+	ret=$?
+	if [ $ret != 0 ]; then
+		echo "failed: dd $@" >&2
+		echo "$msg" >&2
+	fi
+	return $ret
+}
+
 function run_dd_test
 {
     header=$1
@@ -25,11 +39,12 @@ function run_dd_test
 
     input=$(make_input_name "$header")
     INPUT="${INPUT} ${input}"
+	rm -f "$input"
 
     if [ "$bs" = 0 ]; then
-	touch $input
+		touch $input
     else
-	$DD if=/dev/zero of=$input count=1 bs=$bs $flags &> /dev/null
+		_dd if=/dev/zero of=$input count=1 bs=$bs $flags || return
     fi
 
     $TS_CMD_FINCORE --output $COLUMNS  --bytes --noheadings $input
@@ -47,9 +62,10 @@ function run_dd_dd_test
 
     input=$(make_input_name "$header")
     INPUT="${INPUT} ${input}"
+	rm -f "$input"
 
-    $DD if=/dev/zero of=$input count=1 bs=$bs $flags0 &> /dev/null
-    $DD if=/dev/zero of=$input count=1 bs=$bs $flags1 &> /dev/null
+    _dd if=/dev/zero of=$input count=1 bs=$bs $flags0 || return
+    _dd if=/dev/zero of=$input count=1 bs=$bs $flags1 || return
 
     $TS_CMD_FINCORE --output $COLUMNS --bytes --noheadings $input
 
@@ -75,13 +91,6 @@ else
 fi
 
 
-# seems unsupported by some dd(1) version
-#DD_FLAGS="status=none"
-
-DD_FLAGS=
-DD="dd $DD_FLAGS"
-
-
 ts_check_test_command "$TS_CMD_FINCORE"
 ts_cd "$TS_OUTDIR"
 
-- 
1.8.5.6

