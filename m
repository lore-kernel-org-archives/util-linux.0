Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:35231 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbcGNNaL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Jul 2016 09:30:11 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id ADBE2AC8D
	for <util-linux@vger.kernel.org>; Thu, 14 Jul 2016 13:30:09 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 7/7] tests: Add loop-overlay test
Message-ID: <ab19aca9-5f05-9d4e-8105-c36fa77e664c@suse.cz>
Date: Thu, 14 Jul 2016 15:30:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The test will check proper loop device reuse and error in case of overlapping
loop device.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 tests/expected/libmount/loop-overlay |  7 ++++
 tests/ts/libmount/loop-overlay       | 64 ++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 tests/expected/libmount/loop-overlay
 create mode 100755 tests/ts/libmount/loop-overlay

diff --git a/tests/expected/libmount/loop-overlay b/tests/expected/libmount/loop-overlay
new file mode 100644
index 0000000..ab6c68b
--- /dev/null
+++ b/tests/expected/libmount/loop-overlay
@@ -0,0 +1,7 @@
+second should fail
+ overlapping loop device exists
+should succeed
+both should fail
+ overlapping loop device exists
+ overlapping loop device exists
+Success
diff --git a/tests/ts/libmount/loop-overlay b/tests/ts/libmount/loop-overlay
new file mode 100755
index 0000000..6fcb81d
--- /dev/null
+++ b/tests/ts/libmount/loop-overlay
@@ -0,0 +1,64 @@
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
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="loop (fstab)"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_LOSETUP"
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
+ts_skip_nonroot
+ts_check_prog "mkfs.ext3"
+ts_check_prog "dd"
+ts_check_prog "stat"
+# Default from functions.sh:ts_image_init()
+mib=${1:-"5"}
+
+IMG=$(ts_image_init)
+
+mkfs.ext3 -F "$IMG" &> /dev/null || ts_die "Cannot make ext3 on $IMG"
+OFFSET=`stat -c %s "$IMG"`
+dd if=$IMG of=$IMG oflag=append bs=${mib}M count=1 conv=notrunc status=none
+
+[ -d "$TS_MOUNTPOINT-1" ] || mkdir -p $TS_MOUNTPOINT-1
+[ -d "$TS_MOUNTPOINT-2" ] || mkdir -p $TS_MOUNTPOINT-2
+
+echo "second should fail" >>$TS_OUTPUT
+$TS_CMD_MOUNT -oloop "$IMG" "$TS_MOUNTPOINT-1" >> $TS_OUTPUT 2>&1
+$TS_CMD_MOUNT -oloop,offset=$OFFSET "$IMG" "$TS_MOUNTPOINT-2" 2>&1 | sed 's/.*://' >>$TS_OUTPUT
+
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT-1" >> $TS_OUTPUT 2>&1
+
+echo "should succeed" >>$TS_OUTPUT
+$TS_CMD_MOUNT -oloop,sizelimit=$OFFSET "$IMG" "$TS_MOUNTPOINT-1" >> $TS_OUTPUT 2>&1
+$TS_CMD_MOUNT -oloop,offset=$OFFSET "$IMG" "$TS_MOUNTPOINT-2" >> $TS_OUTPUT 2>&1
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT-1" >> $TS_OUTPUT 2>&1
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT-2" >> $TS_OUTPUT 2>&1
+
+echo "both should fail" >>$TS_OUTPUT
+LOOPDEV=$($TS_CMD_LOSETUP --find)
+$TS_CMD_LOSETUP --offset 1 --sizelimit $OFFSET $LOOPDEV "$IMG"
+$TS_CMD_MOUNT -oloop,sizelimit=$OFFSET "$IMG" "$TS_MOUNTPOINT-1" 2>&1 | sed 's/.*://' >>$TS_OUTPUT
+$TS_CMD_MOUNT -oloop,offset=$OFFSET "$IMG" "$TS_MOUNTPOINT-2" 2>&1 | sed 's/.*://' >>$TS_OUTPUT
+$TS_CMD_LOSETUP --detach $LOOPDEV
+
+ts_log "Success"
+ts_finalize
-- 
2.9.0

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
