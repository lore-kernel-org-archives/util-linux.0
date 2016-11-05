Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:65072 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754771AbcKEPIP (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 5 Nov 2016 11:08:15 -0400
Received: from tenfore.ga-group.nl ([77.12.203.210]) by mail.gmx.com
 (mrgmx102) with ESMTPSA (Nemesis) id 0LbgyV-1ciwyd0OcN-00lBbt for
 <util-linux@vger.kernel.org>; Sat, 05 Nov 2016 16:08:12 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/3] tests: always quote $LODEV
Date: Sat,  5 Nov 2016 16:08:09 +0100
Message-Id: <1478358489-18103-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1478358489-18103-1-git-send-email-sweet_f_a@gmx.de>
References: <1478358489-18103-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Since there is no error handling in this test $LODEV
may be empty.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/losetup/losetup-loop | 46 +++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/tests/ts/losetup/losetup-loop b/tests/ts/losetup/losetup-loop
index cff12c9..13ccc65 100755
--- a/tests/ts/losetup/losetup-loop
+++ b/tests/ts/losetup/losetup-loop
@@ -42,15 +42,15 @@ BACKFILE="$TS_DEVICE"
 
 ts_init_subtest "find-race-condition"
 LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show $BACKFILE )
-$TS_CMD_LOSETUP -d $LODEV
+$TS_CMD_LOSETUP -d "$LODEV"
 # The loop device may or may not exist here because no "udevadm settle".
 LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show $BACKFILE )
 udevadm settle
-dd if=/dev/zero of=$LODEV count=1 bs=1 >/dev/null 2>&1
-$TS_CMD_LOSETUP --list | grep -q $LODEV
+dd if=/dev/zero of="$LODEV" count=1 bs=1 >/dev/null 2>&1
+$TS_CMD_LOSETUP --list | grep -q "$LODEV"
 ts_log $?
 udevadm settle
-$TS_CMD_LOSETUP -d $LODEV >/dev/null 2>&1
+$TS_CMD_LOSETUP -d "$LODEV" >/dev/null 2>&1
 ts_log "Success"
 ts_finalize_subtest
 
@@ -71,10 +71,10 @@ if test "$LODEV" = "$LODEVR" ; then
 else
 	echo "different" >>$TS_OUTPUT
 	if test -n "$LODEVR" ; then
-		$TS_CMD_LOSETUP -d $LODEVR
+		$TS_CMD_LOSETUP -d "$LODEVR"
 	fi
 fi
-$TS_CMD_LOSETUP -d $LODEV
+$TS_CMD_LOSETUP -d "$LODEV"
 ts_log "Success"
 ts_finalize_subtest
 
@@ -95,10 +95,10 @@ if test "$LODEV" = "$LODEVR" ; then
 else
 	echo "different" >>$TS_OUTPUT
 	if test -n "$LODEVR" ; then
-		$TS_CMD_LOSETUP -d $LODEVR
+		$TS_CMD_LOSETUP -d "$LODEVR"
 	fi
 fi
-$TS_CMD_LOSETUP -d $LODEV
+$TS_CMD_LOSETUP -d "$LODEV"
 ts_log "Success"
 ts_finalize_subtest
 
@@ -119,10 +119,10 @@ if test "$LODEV" = "$LODEVR" ; then
 else
 	echo "different" >>$TS_OUTPUT
 	if test -n "$LODEVR" ; then
-		$TS_CMD_LOSETUP -d $LODEVR
+		$TS_CMD_LOSETUP -d "$LODEVR"
 	fi
 fi
-$TS_CMD_LOSETUP -d $LODEV
+$TS_CMD_LOSETUP -d "$LODEV"
 ts_log "Success"
 ts_finalize_subtest
 
@@ -143,10 +143,10 @@ if test "$LODEV" = "$LODEVR" ; then
 else
 	echo "different" >>$TS_OUTPUT
 	if test -n "$LODEVR" ; then
-		$TS_CMD_LOSETUP -d $LODEVR
+		$TS_CMD_LOSETUP -d "$LODEVR"
 	fi
 fi
-$TS_CMD_LOSETUP -d $LODEV
+$TS_CMD_LOSETUP -d "$LODEV"
 ts_log "Success"
 ts_finalize_subtest
 
@@ -167,11 +167,11 @@ if test "$LODEV" = "$LODEVR" ; then
 else
 	echo "different" >>$TS_OUTPUT
 	if test -n "$LODEVR" ; then
-		$TS_CMD_LOSETUP -d $LODEVR
+		$TS_CMD_LOSETUP -d "$LODEVR"
 	fi
 fi
-$TS_CMD_LOSETUP -d $LODEV
-$TS_CMD_LOSETUP -d $LODEVR >/dev/null 2>&1
+$TS_CMD_LOSETUP -d "$LODEV"
+$TS_CMD_LOSETUP -d "$LODEVR" >/dev/null 2>&1
 ts_log "Success"
 ts_finalize_subtest
 
@@ -192,10 +192,10 @@ if test "$LODEV" = "$LODEVR" ; then
 else
 	echo "different" >>$TS_OUTPUT
 	if test -n "$LODEVR" ; then
-		$TS_CMD_LOSETUP -d $LODEVR
+		$TS_CMD_LOSETUP -d "$LODEVR"
 	fi
 fi
-$TS_CMD_LOSETUP -d $LODEV
+$TS_CMD_LOSETUP -d "$LODEV"
 ts_log "Success"
 ts_finalize_subtest
 
@@ -207,11 +207,11 @@ if [ -z "$LODEV" ]; then
 	ts_log "Failed to create loop device"
 fi
 LODEVR=$( $TS_CMD_LOSETUP --find )
-$TS_CMD_LOSETUP --nooverlap $LODEVR $BACKFILE >/dev/null 2>&1
+$TS_CMD_LOSETUP --nooverlap "$LODEVR" $BACKFILE >/dev/null 2>&1
 ts_log $?
 udevadm settle
-$TS_CMD_LOSETUP -d $LODEV
-$TS_CMD_LOSETUP -d $LODEVR >/dev/null 2>&1
+$TS_CMD_LOSETUP -d "$LODEV"
+$TS_CMD_LOSETUP -d "$LODEVR" >/dev/null 2>&1
 ts_log "Success"
 ts_finalize_subtest
 
@@ -223,11 +223,11 @@ if [ -z "$LODEV" ]; then
 	ts_log "Failed to create loop device"
 fi
 LODEVR=$( $TS_CMD_LOSETUP --find )
-$TS_CMD_LOSETUP --nooverlap $LODEVR $BACKFILE >/dev/null 2>&1
+$TS_CMD_LOSETUP --nooverlap "$LODEVR" $BACKFILE >/dev/null 2>&1
 ts_log $?
 udevadm settle
-$TS_CMD_LOSETUP -d $LODEV
-$TS_CMD_LOSETUP -d $LODEVR >/dev/null 2>&1
+$TS_CMD_LOSETUP -d "$LODEV"
+$TS_CMD_LOSETUP -d "$LODEVR" >/dev/null 2>&1
 ts_log "Success"
 ts_finalize_subtest
 
-- 
1.8.5.6

