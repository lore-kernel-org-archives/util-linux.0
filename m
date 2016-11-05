Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:53161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755474AbcKEPIP (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 5 Nov 2016 11:08:15 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 1/3] tests: udevadm settle before losetup -d
Date: Sat,  5 Nov 2016 16:08:07 +0100
Message-Id: <1478358489-18103-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Fails on Debian 7 (wheezy), Kernel 3.2.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
CC: Stanislav Brabec <sbrabec@suse.cz>
---
 tests/ts/losetup/losetup-loop | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/ts/losetup/losetup-loop b/tests/ts/losetup/losetup-loop
index 839f100..310e76e 100755
--- a/tests/ts/losetup/losetup-loop
+++ b/tests/ts/losetup/losetup-loop
@@ -43,12 +43,14 @@ BACKFILE="$TS_DEVICE"
 ts_init_subtest "find-race-condition"
 LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show $BACKFILE )
 $TS_CMD_LOSETUP -d $LODEV
+# The loop device may or may not exist here because no "udevadm settle".
 LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show $BACKFILE )
 sleep 3
 dd if=/dev/zero of=$LODEV count=1 bs=1 >/dev/null 2>&1
 sleep 3
 $TS_CMD_LOSETUP --list | grep -q $LODEV
 ts_log $?
+udevadm settle
 $TS_CMD_LOSETUP -d $LODEV >/dev/null 2>&1
 ts_log "Success"
 ts_finalize_subtest
@@ -64,6 +66,7 @@ LODEVR=$( $TS_CMD_LOSETUP --find --nooverlap --show $BACKFILE )
 if [ -z "$LODEVR" ]; then
 	ts_log "Failed to create loop device"
 fi
+udevadm settle
 if test "$LODEV" = "$LODEVR" ; then
 	echo "equal" >>$TS_OUTPUT
 else
@@ -87,6 +90,7 @@ LODEVR=$( $TS_CMD_LOSETUP --find --nooverlap --show --offset=1MiB --sizelimit=1M
 if [ -z "$LODEVR" ]; then
 	ts_log "Failed to create loop device"
 fi
+udevadm settle
 if test "$LODEV" = "$LODEVR" ; then
 	echo "equal" >>$TS_OUTPUT
 else
@@ -110,6 +114,7 @@ LODEVR=$( $TS_CMD_LOSETUP --find --nooverlap --show --offset=2MiB --sizelimit=2M
 if [ -z "$LODEVR" ]; then
 	ts_log "Failed to create loop device"
 fi
+udevadm settle
 if test "$LODEV" = "$LODEVR" ; then
 	echo "equal" >>$TS_OUTPUT
 else
@@ -133,6 +138,7 @@ LODEVR=$( $TS_CMD_LOSETUP --find --nooverlap --show --offset=2MiB --sizelimit=2M
 if [ -z "$LODEVR" ]; then
 	ts_log "Failed to create loop device"
 fi
+udevadm settle
 if test "$LODEV" = "$LODEVR" ; then
 	echo "equal" >>$TS_OUTPUT
 else
@@ -156,6 +162,7 @@ LODEVR=$( $TS_CMD_LOSETUP --find --nooverlap --show --offset=2MiB --sizelimit=2M
 if [ -z "$LODEVR" ]; then
 	ts_log "Failed to create loop device"
 fi
+udevadm settle
 if test "$LODEV" = "$LODEVR" ; then
 	echo "equal" >>$TS_OUTPUT
 else
@@ -180,6 +187,7 @@ LODEVR=$( $TS_CMD_LOSETUP --find --nooverlap --show --offset=2MiB $BACKFILE )
 if [ -z "$LODEVR" ]; then
 	ts_log "Failed to create loop device"
 fi
+udevadm settle
 if test "$LODEV" = "$LODEVR" ; then
 	echo "equal" >>$TS_OUTPUT
 else
@@ -202,6 +210,7 @@ fi
 LODEVR=$( $TS_CMD_LOSETUP --find )
 $TS_CMD_LOSETUP --nooverlap $LODEVR $BACKFILE >/dev/null 2>&1
 ts_log $?
+udevadm settle
 $TS_CMD_LOSETUP -d $LODEV
 $TS_CMD_LOSETUP -d $LODEVR >/dev/null 2>&1
 ts_log "Success"
@@ -217,6 +226,7 @@ fi
 LODEVR=$( $TS_CMD_LOSETUP --find )
 $TS_CMD_LOSETUP --nooverlap $LODEVR $BACKFILE >/dev/null 2>&1
 ts_log $?
+udevadm settle
 $TS_CMD_LOSETUP -d $LODEV
 $TS_CMD_LOSETUP -d $LODEVR >/dev/null 2>&1
 ts_log "Success"
-- 
1.8.5.6

