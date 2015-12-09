Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:54517 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932AbbLIRnY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Dec 2015 12:43:24 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Federico Simoncelli <fsimonce@redhat.com>
Subject: [PATCH 5/5] tests: skip BLKDISCARD if unsupported
Date: Wed,  9 Dec 2015 18:43:14 +0100
Message-Id: <1449682994-32154-6-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1449682994-32154-1-git-send-email-sweet_f_a@gmx.de>
References: <1449682994-32154-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

CC: Federico Simoncelli <fsimonce@redhat.com>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/blkdiscard/offsets | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/ts/blkdiscard/offsets b/tests/ts/blkdiscard/offsets
index 29597ad..2888411 100755
--- a/tests/ts/blkdiscard/offsets
+++ b/tests/ts/blkdiscard/offsets
@@ -46,6 +46,11 @@ function run_tscmd {
 
 ts_log "testing offsets with full block size"
 run_tscmd $TS_CMD_BLKDISCARD -v $DEVICE
+if [ "$?" != "0" ]; then
+	# Skip the rest? For example loop backing files on NFS seem unsupported.
+	grep -q "BLKDISCARD ioctl failed: Operation not supported" "$TS_OUTPUT" \
+		&& ts_skip "BLKDISCARD not supported"
+fi
 run_tscmd $TS_CMD_BLKDISCARD -v -o 1 $DEVICE
 run_tscmd $TS_CMD_BLKDISCARD -v -o 511 $DEVICE
 run_tscmd $TS_CMD_BLKDISCARD -v -o 512 $DEVICE
-- 
1.8.4.5

