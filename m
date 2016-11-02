Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:61614 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755301AbcKBOcA (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 2 Nov 2016 10:32:00 -0400
Received: from zappa.ga.local ([87.128.112.108]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0MfmZs-1cGA2a1lNE-00N89j for
 <util-linux@vger.kernel.org>; Wed, 02 Nov 2016 15:31:56 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] tests: wait for flock background process
Date: Wed,  2 Nov 2016 15:31:55 +0100
Message-Id: <1478097115-3203-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Maybe we should add a --daemonize option to flock to cover
this use case.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/misc/flock | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/ts/misc/flock b/tests/ts/misc/flock
index b2fc772..39e88de 100755
--- a/tests/ts/misc/flock
+++ b/tests/ts/misc/flock
@@ -19,6 +19,7 @@ TS_DESC="flock"
 ts_init "$*"
 
 ts_check_test_command "$TS_CMD_FLOCK"
+ts_check_prog "ps"
 
 
 function do_lock {
@@ -42,10 +43,19 @@ function do_lock {
 # general lock
 GEN_OUTPUT="$TS_OUTPUT"
 START=$(date '+%s')
+# running flock in background is not the best usage example
 $TS_CMD_FLOCK --shared $TS_OUTDIR/lockfile \
 	bash -c 'echo "Locking"; sleep 3; echo "Unlocking"' \
 	> $GEN_OUTPUT 2>&1 &
+pid=$!
 
+# check for running background process
+if [ "$pid" -le "0" ] || ! kill -s 0 "$pid" &>/dev/null; then
+	ts_die "unable to run flock"
+fi
+# the lock should be established when flock has a child
+timeout 1s bash -c "while [ \$(ps --ppid $pid |wc -l) -lt 2 ]; do sleep 0.1 ;done" \
+	|| ts_die "timeout waiting for flock child"
 
 ts_init_subtest "non-block"
 do_lock "--nonblock --conflict-exit-code 123" 123 "You will never see this!"
-- 
1.8.5.6

