Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:33071 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757327AbcHBSeD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Aug 2016 14:34:03 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 037CEACE1
	for <util-linux@vger.kernel.org>; Tue,  2 Aug 2016 18:00:47 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 8/8] tests: Add losetup-loop test suite
Message-ID: <18234339-b95c-4f96-fd13-45feaea1cf04@suse.cz>
Date: Tue, 2 Aug 2016 20:00:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add losetup loop test suite that tests proper behavior of conflicting and
re-used loop devices.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 tests/expected/losetup/losetup-loop                |   1 +
 tests/expected/losetup/losetup-loop-find-conflict  |   3 +
 .../losetup-loop-find-conflict-no-sizelimit        |   3 +
 .../losetup/losetup-loop-find-conflict-readonly    |   3 +
 tests/expected/losetup/losetup-loop-find-no-re-use |   2 +
 .../losetup/losetup-loop-find-ok-no-sizelimit      |   2 +
 .../losetup/losetup-loop-find-race-condition       |   2 +
 tests/expected/losetup/losetup-loop-find-re-use    |   2 +
 tests/expected/losetup/losetup-loop-plain-conflict |   2 +
 tests/expected/losetup/losetup-loop-plain-re-use   |   2 +
 tests/expected/losetup/losetup-loop-plain-readonly |   2 +
 tests/ts/losetup/losetup-loop                      | 228 +++++++++++++++++++++
 12 files changed, 252 insertions(+)
 create mode 100644 tests/expected/losetup/losetup-loop
 create mode 100644 tests/expected/losetup/losetup-loop-find-conflict
 create mode 100644 tests/expected/losetup/losetup-loop-find-conflict-no-sizelimit
 create mode 100644 tests/expected/losetup/losetup-loop-find-conflict-readonly
 create mode 100644 tests/expected/losetup/losetup-loop-find-no-re-use
 create mode 100644 tests/expected/losetup/losetup-loop-find-ok-no-sizelimit
 create mode 100644 tests/expected/losetup/losetup-loop-find-race-condition
 create mode 100644 tests/expected/losetup/losetup-loop-find-re-use
 create mode 100644 tests/expected/losetup/losetup-loop-plain-conflict
 create mode 100644 tests/expected/losetup/losetup-loop-plain-re-use
 create mode 100644 tests/expected/losetup/losetup-loop-plain-readonly
 create mode 100755 tests/ts/losetup/losetup-loop

diff --git a/tests/expected/losetup/losetup-loop b/tests/expected/losetup/losetup-loop
new file mode 100644
index 0000000..3582111
--- /dev/null
+++ b/tests/expected/losetup/losetup-loop
@@ -0,0 +1 @@
+Success
diff --git a/tests/expected/losetup/losetup-loop-find-conflict b/tests/expected/losetup/losetup-loop-find-conflict
new file mode 100644
index 0000000..6fd668b
--- /dev/null
+++ b/tests/expected/losetup/losetup-loop-find-conflict
@@ -0,0 +1,3 @@
+Failed to create loop device
+different
+Success
diff --git a/tests/expected/losetup/losetup-loop-find-conflict-no-sizelimit b/tests/expected/losetup/losetup-loop-find-conflict-no-sizelimit
new file mode 100644
index 0000000..6fd668b
--- /dev/null
+++ b/tests/expected/losetup/losetup-loop-find-conflict-no-sizelimit
@@ -0,0 +1,3 @@
+Failed to create loop device
+different
+Success
diff --git a/tests/expected/losetup/losetup-loop-find-conflict-readonly b/tests/expected/losetup/losetup-loop-find-conflict-readonly
new file mode 100644
index 0000000..6fd668b
--- /dev/null
+++ b/tests/expected/losetup/losetup-loop-find-conflict-readonly
@@ -0,0 +1,3 @@
+Failed to create loop device
+different
+Success
diff --git a/tests/expected/losetup/losetup-loop-find-no-re-use b/tests/expected/losetup/losetup-loop-find-no-re-use
new file mode 100644
index 0000000..3acb7f8
--- /dev/null
+++ b/tests/expected/losetup/losetup-loop-find-no-re-use
@@ -0,0 +1,2 @@
+different
+Success
diff --git a/tests/expected/losetup/losetup-loop-find-ok-no-sizelimit b/tests/expected/losetup/losetup-loop-find-ok-no-sizelimit
new file mode 100644
index 0000000..3acb7f8
--- /dev/null
+++ b/tests/expected/losetup/losetup-loop-find-ok-no-sizelimit
@@ -0,0 +1,2 @@
+different
+Success
diff --git a/tests/expected/losetup/losetup-loop-find-race-condition b/tests/expected/losetup/losetup-loop-find-race-condition
new file mode 100644
index 0000000..6533079
--- /dev/null
+++ b/tests/expected/losetup/losetup-loop-find-race-condition
@@ -0,0 +1,2 @@
+0
+Success
diff --git a/tests/expected/losetup/losetup-loop-find-re-use b/tests/expected/losetup/losetup-loop-find-re-use
new file mode 100644
index 0000000..f58a43c
--- /dev/null
+++ b/tests/expected/losetup/losetup-loop-find-re-use
@@ -0,0 +1,2 @@
+equal
+Success
diff --git a/tests/expected/losetup/losetup-loop-plain-conflict b/tests/expected/losetup/losetup-loop-plain-conflict
new file mode 100644
index 0000000..3c8cd8f
--- /dev/null
+++ b/tests/expected/losetup/losetup-loop-plain-conflict
@@ -0,0 +1,2 @@
+1
+Success
diff --git a/tests/expected/losetup/losetup-loop-plain-re-use b/tests/expected/losetup/losetup-loop-plain-re-use
new file mode 100644
index 0000000..6533079
--- /dev/null
+++ b/tests/expected/losetup/losetup-loop-plain-re-use
@@ -0,0 +1,2 @@
+0
+Success
diff --git a/tests/expected/losetup/losetup-loop-plain-readonly b/tests/expected/losetup/losetup-loop-plain-readonly
new file mode 100644
index 0000000..3c8cd8f
--- /dev/null
+++ b/tests/expected/losetup/losetup-loop-plain-readonly
@@ -0,0 +1,2 @@
+1
+Success
diff --git a/tests/ts/losetup/losetup-loop b/tests/ts/losetup/losetup-loop
new file mode 100755
index 0000000..45403cb
--- /dev/null
+++ b/tests/ts/losetup/losetup-loop
@@ -0,0 +1,228 @@
+#!/bin/bash
+
+#
+# Copyright (C) 2016 Stanislav Brabec <sbrabec@suse.cz>
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
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="losetup-loop"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_LOSETUP"
+ts_check_test_command "$TS_CMD_LSBLK"
+
+ts_skip_nonroot
+ts_check_losetup
+
+. "$TS_SELF/losetup_functions.sh"
+
+#
+# Backing file is a block device
+#
+ts_scsi_debug_init dev_size_mb=11
+BACKFILE="$TS_DEVICE"
+
+# All tests are separated by sleep 3, because loop device exists some time after
+# "losetup -d". This device confuses some tests. And find-race-condition, tests,
+# whether re-use of this device works.
+
+ts_init_subtest "find-race-condition"
+LODEV=$( $TS_CMD_LOSETUP --find --show $BACKFILE )
+$TS_CMD_LOSETUP -d $LODEV
+LODEV=$( $TS_CMD_LOSETUP --find --show $BACKFILE )
+sleep 3
+dd if=/dev/zero of=$LODEV count=1 bs=1 >/dev/null 2>&1
+sleep 3
+$TS_CMD_LOSETUP --list | grep -q $LODEV
+ts_log $?
+$TS_CMD_LOSETUP -d $LODEV >/dev/null 2>&1
+ts_log "Success"
+ts_finalize_subtest
+
+sleep 3
+
+ts_init_subtest "find-re-use"
+LODEV=$( $TS_CMD_LOSETUP --find --show $BACKFILE )
+if [ -z "$LODEV" ]; then
+	ts_log "Failed to create loop device"
+fi
+LODEVR=$( $TS_CMD_LOSETUP --find --show $BACKFILE )
+if [ -z "$LODEVR" ]; then
+	ts_log "Failed to create loop device"
+fi
+if test "$LODEV" = "$LODEVR" ; then
+	echo "equal" >>$TS_OUTPUT
+else
+	echo "different" >>$TS_OUTPUT
+	if test -n "$LODEVR" ; then
+		$TS_CMD_LOSETUP -d $LODEVR
+	fi
+fi
+$TS_CMD_LOSETUP -d $LODEV
+ts_log "Success"
+ts_finalize_subtest
+
+sleep 3
+
+ts_init_subtest "find-no-re-use"
+LODEV=$( $TS_CMD_LOSETUP --find --show --offset=0 --sizelimit=1MiB $BACKFILE )
+if [ -z "$LODEV" ]; then
+	ts_log "Failed to create loop device"
+fi
+LODEVR=$( $TS_CMD_LOSETUP --find --show --offset=1MiB --sizelimit=1MiB $BACKFILE )
+if [ -z "$LODEVR" ]; then
+	ts_log "Failed to create loop device"
+fi
+if test "$LODEV" = "$LODEVR" ; then
+	echo "equal" >>$TS_OUTPUT
+else
+	echo "different" >>$TS_OUTPUT
+	if test -n "$LODEVR" ; then
+		$TS_CMD_LOSETUP -d $LODEVR
+	fi
+fi
+$TS_CMD_LOSETUP -d $LODEV
+ts_log "Success"
+ts_finalize_subtest
+
+sleep 3
+
+ts_init_subtest "find-conflict"
+LODEV=$( $TS_CMD_LOSETUP --find --show --offset=1MiB --sizelimit=2MiB $BACKFILE )
+if [ -z "$LODEV" ]; then
+	ts_log "Failed to create loop device"
+fi
+LODEVR=$( $TS_CMD_LOSETUP --find --show --offset=2MiB --sizelimit=2MiB $BACKFILE >/dev/null 2>&1 )
+if [ -z "$LODEVR" ]; then
+	ts_log "Failed to create loop device"
+fi
+if test "$LODEV" = "$LODEVR" ; then
+	echo "equal" >>$TS_OUTPUT
+else
+	echo "different" >>$TS_OUTPUT
+	if test -n "$LODEVR" ; then
+		$TS_CMD_LOSETUP -d $LODEVR
+	fi
+fi
+$TS_CMD_LOSETUP -d $LODEV
+ts_log "Success"
+ts_finalize_subtest
+
+sleep 3
+
+ts_init_subtest "find-conflict-no-sizelimit"
+LODEV=$( $TS_CMD_LOSETUP --find --show --offset=1MiB $BACKFILE )
+if [ -z "$LODEV" ]; then
+	ts_log "Failed to create loop device"
+fi
+LODEVR=$( $TS_CMD_LOSETUP --find --show --offset=2MiB --sizelimit=2MiB $BACKFILE >/dev/null 2>&1 )
+if [ -z "$LODEVR" ]; then
+	ts_log "Failed to create loop device"
+fi
+if test "$LODEV" = "$LODEVR" ; then
+	echo "equal" >>$TS_OUTPUT
+else
+	echo "different" >>$TS_OUTPUT
+	if test -n "$LODEVR" ; then
+		$TS_CMD_LOSETUP -d $LODEVR
+	fi
+fi
+$TS_CMD_LOSETUP -d $LODEV
+ts_log "Success"
+ts_finalize_subtest
+
+sleep 3
+
+ts_init_subtest "find-conflict-readonly"
+LODEV=$( $TS_CMD_LOSETUP --find --show --read-only $BACKFILE )
+if [ -z "$LODEV" ]; then
+	ts_log "Failed to create loop device"
+fi
+LODEVR=$( $TS_CMD_LOSETUP --find --show --offset=2MiB --sizelimit=2MiB $BACKFILE >/dev/null 2>&1 )
+if [ -z "$LODEVR" ]; then
+	ts_log "Failed to create loop device"
+fi
+if test "$LODEV" = "$LODEVR" ; then
+	echo "equal" >>$TS_OUTPUT
+else
+	echo "different" >>$TS_OUTPUT
+	if test -n "$LODEVR" ; then
+		$TS_CMD_LOSETUP -d $LODEVR
+	fi
+fi
+$TS_CMD_LOSETUP -d $LODEV
+$TS_CMD_LOSETUP -d $LODEVR >/dev/null 2>&1
+ts_log "Success"
+ts_finalize_subtest
+
+sleep 3
+
+ts_init_subtest "find-ok-no-sizelimit"
+LODEV=$( $TS_CMD_LOSETUP --find --show --offset=1MiB --sizelimit=1MiB $BACKFILE )
+if [ -z "$LODEV" ]; then
+	ts_log "Failed to create loop device"
+fi
+LODEVR=$( $TS_CMD_LOSETUP --find --show --offset=2MiB $BACKFILE )
+if [ -z "$LODEVR" ]; then
+	ts_log "Failed to create loop device"
+fi
+if test "$LODEV" = "$LODEVR" ; then
+	echo "equal" >>$TS_OUTPUT
+else
+	echo "different" >>$TS_OUTPUT
+	if test -n "$LODEVR" ; then
+		$TS_CMD_LOSETUP -d $LODEVR
+	fi
+fi
+$TS_CMD_LOSETUP -d $LODEV
+ts_log "Success"
+ts_finalize_subtest
+
+sleep 3
+
+ts_init_subtest "plain-conflict"
+LODEV=$( $TS_CMD_LOSETUP --find --show $BACKFILE )
+if [ -z "$LODEV" ]; then
+	ts_log "Failed to create loop device"
+fi
+LODEVR=$( $TS_CMD_LOSETUP --find )
+$TS_CMD_LOSETUP $LODEVR $BACKFILE >/dev/null 2>&1
+ts_log $?
+$TS_CMD_LOSETUP -d $LODEV
+$TS_CMD_LOSETUP -d $LODEVR >/dev/null 2>&1
+ts_log "Success"
+ts_finalize_subtest
+
+sleep 3
+
+ts_init_subtest "plain-readonly"
+LODEV=$( $TS_CMD_LOSETUP --find --show --read-only $BACKFILE )
+if [ -z "$LODEV" ]; then
+	ts_log "Failed to create loop device"
+fi
+LODEVR=$( $TS_CMD_LOSETUP --find )
+$TS_CMD_LOSETUP $LODEVR $BACKFILE >/dev/null 2>&1
+ts_log $?
+$TS_CMD_LOSETUP -d $LODEV
+$TS_CMD_LOSETUP -d $LODEVR >/dev/null 2>&1
+ts_log "Success"
+ts_finalize_subtest
+
+sleep 3
+
+ts_log "Success"
+ts_finalize
-- 
2.9.2

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
