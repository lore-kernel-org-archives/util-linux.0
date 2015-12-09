Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:63713 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700AbbLIRnY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Dec 2015 12:43:24 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Federico Simoncelli <fsimonce@redhat.com>
Subject: [PATCH 4/5] tests: blkdiscard, check return values
Date: Wed,  9 Dec 2015 18:43:13 +0100
Message-Id: <1449682994-32154-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1449682994-32154-1-git-send-email-sweet_f_a@gmx.de>
References: <1449682994-32154-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

CC: Federico Simoncelli <fsimonce@redhat.com>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/blkdiscard/offsets | 31 +++++++++++++++++
 tests/ts/blkdiscard/offsets       | 73 ++++++++++++++++++++++-----------------
 2 files changed, 72 insertions(+), 32 deletions(-)

diff --git a/tests/expected/blkdiscard/offsets b/tests/expected/blkdiscard/offsets
index 2596fc6..aa90f2f 100644
--- a/tests/expected/blkdiscard/offsets
+++ b/tests/expected/blkdiscard/offsets
@@ -1,39 +1,70 @@
 create loop device from image
 testing offsets with full block size
 Discarded 10485760 bytes from the offset 0
+ret: 0
 blkdiscard: offset 1 is not aligned to sector size 512
+ret: 1
 blkdiscard: offset 511 is not aligned to sector size 512
+ret: 1
 Discarded 10485248 bytes from the offset 512
+ret: 0
 Discarded 10484736 bytes from the offset 1024
+ret: 0
 testing offsets with specific length
 Discarded 5242880 bytes from the offset 0
+ret: 0
 blkdiscard: length 5242881 is not aligned to sector size 512
+ret: 1
 blkdiscard: length 5243391 is not aligned to sector size 512
+ret: 1
 blkdiscard: offset 1 is not aligned to sector size 512
+ret: 1
 blkdiscard: offset 511 is not aligned to sector size 512
+ret: 1
 Discarded 5242880 bytes from the offset 512
+ret: 0
 Discarded 5242880 bytes from the offset 1024
+ret: 0
 testing aligned steps full device
 Discarded 10485760 bytes from the offset 0
+ret: 0
 Discarded 10485760 bytes from the offset 0
+ret: 0
 testing aligned steps with offsets and length
 Discarded 1024 bytes from the offset 0
+ret: 0
 blkdiscard: offset 1 is not aligned to sector size 512
+ret: 1
 blkdiscard: offset 1 is not aligned to sector size 512
+ret: 1
 blkdiscard: offset 511 is not aligned to sector size 512
+ret: 1
 Discarded 1536 bytes from the offset 512
+ret: 0
 Discarded 1024 bytes from the offset 1024
+ret: 0
 testing misaligned steps full device
 blkdiscard: length 1 is not aligned to sector size 512
+ret: 1
 blkdiscard: length 256 is not aligned to sector size 512
+ret: 1
 blkdiscard: length 511 is not aligned to sector size 512
+ret: 1
 blkdiscard: length 513 is not aligned to sector size 512
+ret: 1
 blkdiscard: length 768 is not aligned to sector size 512
+ret: 1
 testing misaligned steps with offsets and length
 blkdiscard: length 511 is not aligned to sector size 512
+ret: 1
 blkdiscard: offset 1 is not aligned to sector size 512
+ret: 1
 blkdiscard: offset 511 is not aligned to sector size 512
+ret: 1
 blkdiscard: length 511 is not aligned to sector size 512
+ret: 1
 blkdiscard: offset 1 is not aligned to sector size 512
+ret: 1
 blkdiscard: offset 511 is not aligned to sector size 512
+ret: 1
 detach loop device from image
diff --git a/tests/ts/blkdiscard/offsets b/tests/ts/blkdiscard/offsets
index eb0097e..29597ad 100755
--- a/tests/ts/blkdiscard/offsets
+++ b/tests/ts/blkdiscard/offsets
@@ -35,50 +35,59 @@ truncate -s 10M $IMAGE_PATH
 ts_log "create loop device from image"
 DEVICE=$($TS_CMD_LOSETUP --show -f $IMAGE_PATH)
 ts_register_loop_device "$DEVICE"
-CMD_SED_DEVICE="sed s#$DEVICE:\s##"
+
+function run_tscmd {
+	local ret
+	"$@" >> $TS_OUTPUT 2>&1
+	ret=$?
+	echo "ret: $ret" >> "$TS_OUTPUT"
+	return $ret
+}
 
 ts_log "testing offsets with full block size"
-$TS_CMD_BLKDISCARD -v $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -o 1 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -o 511 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -o 512 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -o 1024 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+run_tscmd $TS_CMD_BLKDISCARD -v $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -o 1 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -o 511 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -o 512 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -o 1024 $DEVICE
 
 ts_log "testing offsets with specific length"
-$TS_CMD_BLKDISCARD -v -l 5242880 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -l 5242881 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -l 5243391 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -o 1 -l 5242880 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -o 511 -l 5242880 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -o 512 -l 5242880 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -o 1024 -l 5242880 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+run_tscmd $TS_CMD_BLKDISCARD -v -l 5242880 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -l 5242881 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -l 5243391 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -o 1 -l 5242880 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -o 511 -l 5242880 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -o 512 -l 5242880 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -o 1024 -l 5242880 $DEVICE
 
 ts_log "testing aligned steps full device"
-$TS_CMD_BLKDISCARD -v -p 5242880 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -p 1310720 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+run_tscmd $TS_CMD_BLKDISCARD -v -p 5242880 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -p 1310720 $DEVICE
 
 ts_log "testing aligned steps with offsets and length"
-$TS_CMD_BLKDISCARD -v -p 512 -l 1024 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -p 512 -o 1 -l 1024 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -p 512 -o 1 -l 1536 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -p 512 -o 511 -l 1536 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -p 512 -o 512 -l 1536 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -p 512 -o 1024 -l 1024 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+run_tscmd $TS_CMD_BLKDISCARD -v -p 512 -l 1024 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -p 512 -o 1 -l 1024 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -p 512 -o 1 -l 1536 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -p 512 -o 511 -l 1536 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -p 512 -o 512 -l 1536 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -p 512 -o 1024 -l 1024 $DEVICE
 
 ts_log "testing misaligned steps full device"
-$TS_CMD_BLKDISCARD -v -p 1 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -p 256 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -p 511 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -p 513 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -p 768 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+run_tscmd $TS_CMD_BLKDISCARD -v -p 1 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -p 256 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -p 511 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -p 513 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -p 768 $DEVICE
 
 ts_log "testing misaligned steps with offsets and length"
-$TS_CMD_BLKDISCARD -v -p 511 -l 1024 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -p 511 -o 1 -l 1536 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -p 511 -o 511 -l 1536 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -p 511 -l 10240 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -p 511 -o 1 -l 10240 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
-$TS_CMD_BLKDISCARD -v -p 511 -o 511 -l 10240 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+run_tscmd $TS_CMD_BLKDISCARD -v -p 511 -l 1024 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -p 511 -o 1 -l 1536 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -p 511 -o 511 -l 1536 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -p 511 -l 10240 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -p 511 -o 1 -l 10240 $DEVICE
+run_tscmd $TS_CMD_BLKDISCARD -v -p 511 -o 511 -l 10240 $DEVICE
+
+sed -i "s#$DEVICE:\s##" $TS_OUTPUT
 
 ts_log "detach loop device from image"
 
-- 
1.8.4.5

