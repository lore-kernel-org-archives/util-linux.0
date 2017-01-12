Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:55826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750720AbdALOqr (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 12 Jan 2017 09:46:47 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9BD9575015
        for <util-linux@vger.kernel.org>; Thu, 12 Jan 2017 14:45:56 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 3/3] tests: Introduce libmount/loop
Message-ID: <249f2ceb-3a84-08e6-9cfc-e21e244d06e7@suse.cz>
Date: Thu, 12 Jan 2017 15:45:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add libmount/loop test that tests various loop mount options.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 tests/expected/libmount/loop                       |   1 +
 tests/expected/libmount/loop-conflict              |   2 +
 tests/expected/libmount/loop-dev-loop              |   1 +
 tests/expected/libmount/loop-file                  |   1 +
 tests/expected/libmount/loop-file-o-loop           |   1 +
 tests/expected/libmount/loop-o-loop-val            |   1 +
 tests/expected/libmount/loop-o-loop-val-conflict   |   2 +
 .../expected/libmount/loop-o-loop-val-initialized  |   2 +
 tests/expected/libmount/loop-reuse                 |   1 +
 tests/ts/libmount/loop                             | 133 +++++++++++++++++++++
 tests/ts/losetup/losetup-loop                      |   2 +-
 11 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100644 tests/expected/libmount/loop
 create mode 100644 tests/expected/libmount/loop-conflict
 create mode 100644 tests/expected/libmount/loop-dev-loop
 create mode 100644 tests/expected/libmount/loop-file
 create mode 100644 tests/expected/libmount/loop-file-o-loop
 create mode 100644 tests/expected/libmount/loop-o-loop-val
 create mode 100644 tests/expected/libmount/loop-o-loop-val-conflict
 create mode 100644 tests/expected/libmount/loop-o-loop-val-initialized
 create mode 100644 tests/expected/libmount/loop-reuse
 create mode 100755 tests/ts/libmount/loop

diff --git a/tests/expected/libmount/loop b/tests/expected/libmount/loop
new file mode 100644
index 000000000..35821117c
--- /dev/null
+++ b/tests/expected/libmount/loop
@@ -0,0 +1 @@
+Success
diff --git a/tests/expected/libmount/loop-conflict b/tests/expected/libmount/loop-conflict
new file mode 100644
index 000000000..e26f99a4f
--- /dev/null
+++ b/tests/expected/libmount/loop-conflict
@@ -0,0 +1,2 @@
+: overlapping loop device exists
+Success
diff --git a/tests/expected/libmount/loop-dev-loop b/tests/expected/libmount/loop-dev-loop
new file mode 100644
index 000000000..35821117c
--- /dev/null
+++ b/tests/expected/libmount/loop-dev-loop
@@ -0,0 +1 @@
+Success
diff --git a/tests/expected/libmount/loop-file b/tests/expected/libmount/loop-file
new file mode 100644
index 000000000..35821117c
--- /dev/null
+++ b/tests/expected/libmount/loop-file
@@ -0,0 +1 @@
+Success
diff --git a/tests/expected/libmount/loop-file-o-loop b/tests/expected/libmount/loop-file-o-loop
new file mode 100644
index 000000000..35821117c
--- /dev/null
+++ b/tests/expected/libmount/loop-file-o-loop
@@ -0,0 +1 @@
+Success
diff --git a/tests/expected/libmount/loop-o-loop-val b/tests/expected/libmount/loop-o-loop-val
new file mode 100644
index 000000000..35821117c
--- /dev/null
+++ b/tests/expected/libmount/loop-o-loop-val
@@ -0,0 +1 @@
+Success
diff --git a/tests/expected/libmount/loop-o-loop-val-conflict b/tests/expected/libmount/loop-o-loop-val-conflict
new file mode 100644
index 000000000..043847449
--- /dev/null
+++ b/tests/expected/libmount/loop-o-loop-val-conflict
@@ -0,0 +1,2 @@
+: failed to setup loop device: Device or resource busy
+Success
diff --git a/tests/expected/libmount/loop-o-loop-val-initialized b/tests/expected/libmount/loop-o-loop-val-initialized
new file mode 100644
index 000000000..e26f99a4f
--- /dev/null
+++ b/tests/expected/libmount/loop-o-loop-val-initialized
@@ -0,0 +1,2 @@
+: overlapping loop device exists
+Success
diff --git a/tests/expected/libmount/loop-reuse b/tests/expected/libmount/loop-reuse
new file mode 100644
index 000000000..35821117c
--- /dev/null
+++ b/tests/expected/libmount/loop-reuse
@@ -0,0 +1 @@
+Success
diff --git a/tests/ts/libmount/loop b/tests/ts/libmount/loop
new file mode 100755
index 000000000..452732f32
--- /dev/null
+++ b/tests/ts/libmount/loop
@@ -0,0 +1,133 @@
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
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_LOSETUP"
+
+ts_skip_nonroot
+ts_check_losetup
+ts_check_prog "mkfs.ext3"
+
+#
+# file-* tests: Backing file is a regular file
+#
+BACKFILE=$(ts_image_init 10)
+
+mkfs.ext3 -F $BACKFILE &> /dev/null || ts_die "Cannot make ext3 on $BACKFILE"
+
+# All tests are separated by "udevadm settle" because loop device exists some time after
+# "losetup -d". This device confuses some tests. And find-race-condition, tests,
+# whether re-use of this device works.
+udevadm settle
+
+ts_init_subtest "file"
+[ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
+$TS_CMD_MOUNT "$BACKFILE" "$TS_MOUNTPOINT" >> $TS_OUTPUT 2>&1
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT" >> $TS_OUTPUT 2>&1
+udevadm settle
+ts_log "Success"
+ts_finalize_subtest
+
+ts_init_subtest "file-o-loop"
+[ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
+$TS_CMD_MOUNT -oloop "$BACKFILE" "$TS_MOUNTPOINT" >> $TS_OUTPUT 2>&1
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT" >> $TS_OUTPUT 2>&1
+udevadm settle
+ts_log "Success"
+ts_finalize_subtest
+
+ts_init_subtest "dev-loop"
+[ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
+LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show $BACKFILE 2>> $TS_OUTPUT )
+$TS_CMD_MOUNT $LODEV "$TS_MOUNTPOINT" >> $TS_OUTPUT 2>&1
+MOUNTED_LODEV="$( $TS_CMD_MOUNT | grep "$TS_MOUNTPOINT" | while read LODEV REST ; do echo $LODEV ; done )"
+if test "$MOUNTED_LODEV" != "$LODEV" ; then
+    echo "Mounted incorrect device mounts: $MOUNTED_LODEV, wants: $LODEV" >> $TS_OUTPUT
+fi
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT" >> $TS_OUTPUT 2>&1
+$TS_CMD_LOSETUP --detach $LODEV >> $TS_OUTPUT 2>&1
+udevadm settle
+ts_log "Success"
+ts_finalize_subtest
+
+ts_init_subtest "o-loop-val"
+[ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
+LODEV=$( $TS_CMD_LOSETUP --find 2>> $TS_OUTPUT )
+$TS_CMD_MOUNT -oloop=$LODEV "$BACKFILE" "$TS_MOUNTPOINT" >> $TS_OUTPUT 2>&1
+MOUNTED_LODEV="$( cat /proc/self/mounts |  grep "$TS_MOUNTPOINT" | while read LODEV REST ; do echo $LODEV ; done )"
+if test "$MOUNTED_LODEV" != "$LODEV" ; then
+    echo "Mounted incorrect device mounts: $MOUNTED_LODEV, wants: $LODEV" >> $TS_OUTPUT
+fi
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT" >> $TS_OUTPUT 2>&1
+udevadm settle
+ts_log "Success"
+ts_finalize_subtest
+
+ts_init_subtest "reuse"
+[ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
+LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show "$BACKFILE" 2>> $TS_OUTPUT )
+$TS_CMD_MOUNT "$BACKFILE" "$TS_MOUNTPOINT" >> $TS_OUTPUT 2>&1
+MOUNTED_LODEV="$( cat /proc/self/mounts |  grep "$TS_MOUNTPOINT" | while read LODEV REST ; do echo $LODEV ; done )"
+if test "$MOUNTED_LODEV" != "$LODEV" ; then
+    echo "Mounted incorrect device mounts: $MOUNTED_LODEV, wants: $LODEV" >> $TS_OUTPUT
+fi
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT" >> $TS_OUTPUT 2>&1
+$TS_CMD_LOSETUP --detach $LODEV >> $TS_OUTPUT 2>&1
+udevadm settle
+ts_log "Success"
+ts_finalize_subtest
+
+ts_init_subtest "conflict"
+[ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
+LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show --offset=1000 "$BACKFILE" 2>> $TS_OUTPUT )
+$TS_CMD_MOUNT "$BACKFILE" "$TS_MOUNTPOINT" 2>&1 | sed 's/^.*\.img//' > $TS_OUTPUT
+$TS_CMD_LOSETUP --detach $LODEV >> $TS_OUTPUT 2>&1
+udevadm settle
+ts_log "Success"
+ts_finalize_subtest
+
+ts_init_subtest "o-loop-val-initialized"
+[ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
+LODEV=$( $TS_CMD_LOSETUP --find 2>> $TS_OUTPUT )
+$TS_CMD_LOSETUP $LODEV "$BACKFILE" >> $TS_OUTPUT 2>&1
+$TS_CMD_MOUNT -oloop=$LODEV "$BACKFILE" "$TS_MOUNTPOINT" 2>&1 | sed 's/^.*\.img//' > $TS_OUTPUT
+$TS_CMD_LOSETUP --detach $LODEV >> $TS_OUTPUT 2>&1
+udevadm settle
+ts_log "Success"
+ts_finalize_subtest
+
+ts_init_subtest "o-loop-val-conflict"
+[ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
+cp "$BACKFILE" "$BACKFILE"-2
+LODEV=$( $TS_CMD_LOSETUP --find 2>> $TS_OUTPUT )
+$TS_CMD_LOSETUP $LODEV "$BACKFILE"-2 >> $TS_OUTPUT 2>&1
+$TS_CMD_MOUNT -oloop=$LODEV "$BACKFILE" "$TS_MOUNTPOINT" 2>&1 | sed 's/^.*\.img//' > $TS_OUTPUT
+$TS_CMD_LOSETUP --detach $LODEV >> $TS_OUTPUT 2>&1
+rm "$BACKFILE"-2
+udevadm settle
+ts_log "Success"
+ts_finalize_subtest
+
+ts_log "Success"
+ts_finalize
diff --git a/tests/ts/losetup/losetup-loop b/tests/ts/losetup/losetup-loop
index 13ccc6508..6ec521e3a 100755
--- a/tests/ts/losetup/losetup-loop
+++ b/tests/ts/losetup/losetup-loop
@@ -36,7 +36,7 @@ ts_check_losetup
 ts_scsi_debug_init dev_size_mb=11
 BACKFILE="$TS_DEVICE"
 
-# All tests are separated by sleep 3, because loop device exists some time after
+# All tests are separated by "udevadm settle" because loop device exists some time after
 # "losetup -d". This device confuses some tests. And find-race-condition, tests,
 # whether re-use of this device works.
 
-- 
2.11.0

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
