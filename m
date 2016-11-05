Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:52180 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755318AbcKEPIP (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 5 Nov 2016 11:08:15 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 2/3] tests: replace sleep by udevadm
Date: Sat,  5 Nov 2016 16:08:08 +0100
Message-Id: <1478358489-18103-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1478358489-18103-1-git-send-email-sweet_f_a@gmx.de>
References: <1478358489-18103-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
CC: Stanislav Brabec <sbrabec@suse.cz>
---
 tests/ts/losetup/losetup-loop | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/tests/ts/losetup/losetup-loop b/tests/ts/losetup/losetup-loop
index 310e76e..cff12c9 100755
--- a/tests/ts/losetup/losetup-loop
+++ b/tests/ts/losetup/losetup-loop
@@ -45,9 +45,8 @@ LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show $BACKFILE )
 $TS_CMD_LOSETUP -d $LODEV
 # The loop device may or may not exist here because no "udevadm settle".
 LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show $BACKFILE )
-sleep 3
+udevadm settle
 dd if=/dev/zero of=$LODEV count=1 bs=1 >/dev/null 2>&1
-sleep 3
 $TS_CMD_LOSETUP --list | grep -q $LODEV
 ts_log $?
 udevadm settle
@@ -55,7 +54,7 @@ $TS_CMD_LOSETUP -d $LODEV >/dev/null 2>&1
 ts_log "Success"
 ts_finalize_subtest
 
-sleep 3
+udevadm settle
 
 ts_init_subtest "find-re-use"
 LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show $BACKFILE )
@@ -79,7 +78,7 @@ $TS_CMD_LOSETUP -d $LODEV
 ts_log "Success"
 ts_finalize_subtest
 
-sleep 3
+udevadm settle
 
 ts_init_subtest "find-no-re-use"
 LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show --offset=0 --sizelimit=1MiB $BACKFILE )
@@ -103,7 +102,7 @@ $TS_CMD_LOSETUP -d $LODEV
 ts_log "Success"
 ts_finalize_subtest
 
-sleep 3
+udevadm settle
 
 ts_init_subtest "find-conflict"
 LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show --offset=1MiB --sizelimit=2MiB $BACKFILE )
@@ -127,7 +126,7 @@ $TS_CMD_LOSETUP -d $LODEV
 ts_log "Success"
 ts_finalize_subtest
 
-sleep 3
+udevadm settle
 
 ts_init_subtest "find-conflict-no-sizelimit"
 LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show --offset=1MiB $BACKFILE )
@@ -151,7 +150,7 @@ $TS_CMD_LOSETUP -d $LODEV
 ts_log "Success"
 ts_finalize_subtest
 
-sleep 3
+udevadm settle
 
 ts_init_subtest "find-conflict-readonly"
 LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show --read-only $BACKFILE )
@@ -176,7 +175,7 @@ $TS_CMD_LOSETUP -d $LODEVR >/dev/null 2>&1
 ts_log "Success"
 ts_finalize_subtest
 
-sleep 3
+udevadm settle
 
 ts_init_subtest "find-ok-no-sizelimit"
 LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show --offset=1MiB --sizelimit=1MiB $BACKFILE )
@@ -200,7 +199,7 @@ $TS_CMD_LOSETUP -d $LODEV
 ts_log "Success"
 ts_finalize_subtest
 
-sleep 3
+udevadm settle
 
 ts_init_subtest "plain-conflict"
 LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show $BACKFILE )
@@ -216,7 +215,7 @@ $TS_CMD_LOSETUP -d $LODEVR >/dev/null 2>&1
 ts_log "Success"
 ts_finalize_subtest
 
-sleep 3
+udevadm settle
 
 ts_init_subtest "plain-readonly"
 LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show --read-only $BACKFILE )
@@ -232,7 +231,7 @@ $TS_CMD_LOSETUP -d $LODEVR >/dev/null 2>&1
 ts_log "Success"
 ts_finalize_subtest
 
-sleep 3
+udevadm settle
 
 ts_log "Success"
 ts_finalize
-- 
1.8.5.6

