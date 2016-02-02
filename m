Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:59598 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753038AbcBBSAU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Feb 2016 13:00:20 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id BA066AB9D
	for <util-linux@vger.kernel.org>; Tue,  2 Feb 2016 18:00:18 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] tests: add btrfs mount tests
Message-ID: <56B0EEB2.1060707@suse.cz>
Date: Tue, 2 Feb 2016 19:00:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

btrfs needs a special support in mount. Add a testcase for btrfs specific
problems.

Coverage:
352740e8: bind mounts pointing to btrfs subvolume
2cd28fc8: mounting default subvolume
d2f82678: use of "auto"
618a8814: use of "subvolid"

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 tests/expected/mount/fstab-btrfs |  1 +
 tests/ts/mount/fstab-btrfs       | 99 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 tests/expected/mount/fstab-btrfs
 create mode 100755 tests/ts/mount/fstab-btrfs

diff --git a/tests/expected/mount/fstab-btrfs b/tests/expected/mount/fstab-btrfs
new file mode 100644
index 0000000..3582111
--- /dev/null
+++ b/tests/expected/mount/fstab-btrfs
@@ -0,0 +1 @@
+Success
diff --git a/tests/ts/mount/fstab-btrfs b/tests/ts/mount/fstab-btrfs
new file mode 100755
index 0000000..1c1d0fd
--- /dev/null
+++ b/tests/ts/mount/fstab-btrfs
@@ -0,0 +1,99 @@
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
+TS_DESC="btrfs (fstab)"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
+ts_skip_nonroot
+ts_check_losetup
+ts_check_prog "mkfs.btrfs"
+ts_check_prog "btrfs"
+
+ts_device_init 42
+DEVICE=$TS_LODEV
+[ -d "$TS_MOUNTPOINT-create" ] || mkdir -p "$TS_MOUNTPOINT-create"
+[ -d "$TS_MOUNTPOINT-default" ] || mkdir -p "$TS_MOUNTPOINT-default"
+[ -d "$TS_MOUNTPOINT-subvol" ] || mkdir -p "$TS_MOUNTPOINT-subvol"
+[ -d "$TS_MOUNTPOINT-subvolid" ] || mkdir -p "$TS_MOUNTPOINT-subvolid"
+[ -d "$TS_MOUNTPOINT-bind" ] || mkdir -p "$TS_MOUNTPOINT-bind"
+mkfs.btrfs -f -d single -m single $DEVICE &> /dev/null || ts_die "Cannot make btrfs on $DEVICE"
+
+$TS_CMD_MOUNT -o loop "$DEVICE" "$TS_MOUNTPOINT-create"
+pushd . >/dev/null
+cd "$TS_MOUNTPOINT-create"
+mkdir -p d0/dd0/ddd0
+cd ./d0/dd0/ddd0
+touch file{1..5}
+btrfs subvol create s1 >/dev/null
+cd ./s1
+touch file{1..5}
+mkdir -p d1/dd1/ddd1
+cd ./d1/dd1/ddd1
+btrfs subvol create s2 >/dev/null
+DEFAULT_SUBVOLID=$(btrfs inspect rootid s2)
+btrfs subvol set-default $DEFAULT_SUBVOLID . >/dev/null
+NON_DEFAULT_SUBVOLID=$(btrfs subvol list "$TS_MOUNTPOINT-create" | while read dummy id rest ; do if test $id = $DEFAULT_SUBVOLID ; then continue ; fi ; echo $id ; done)
+cd ../../../..
+mkdir -p d2/dd2/ddd2
+cd ./d2/dd2/ddd2
+btrfs subvol create s3 >/dev/null
+popd >/dev/null
+NON_DEFAULT_SUBVOL=d0/dd0/ddd0/d2/dd2/ddd2/s3
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT-create"
+
+# Tests with fs == btrfs
+# mounting default subvolume, deep in the structure, without entry in fstab
+ts_fstab_add "$DEVICE" "$TS_MOUNTPOINT-default" "btrfs" ""
+# mounting default subvolume, deep in the structure
+ts_fstab_add "$DEVICE" "$TS_MOUNTPOINT-subvol" "btrfs" "subvol=$NON_DEFAULT_SUBVOL"
+# mounting non-default subvolume
+ts_fstab_add "$DEVICE" "$TS_MOUNTPOINT-subvolid" "btrfs" "subvolid=$NON_DEFAULT_SUBVOLID"
+
+# test bind mount pointing to subvolume root
+ts_fstab_add "$TS_MOUNTPOINT-subvol" "$TS_MOUNTPOINT-bind" "auto" "bind"
+
+$TS_CMD_MOUNT -a 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT -a 2>&1 >> $TS_OUTPUT
+
+ts_fstab_clean
+
+# Tests with fs == auto
+# mounting default subvolume, deep in the structure, without entry in fstab
+ts_fstab_add "$DEVICE" "$TS_MOUNTPOINT-default" "auto" ""
+# mounting default subvolume, deep in the structure
+ts_fstab_add "$DEVICE" "$TS_MOUNTPOINT-subvol" "auto" "subvol=$NON_DEFAULT_SUBVOL"
+# mounting non-default subvolume
+ts_fstab_add "$DEVICE" "$TS_MOUNTPOINT-subvolid" "auto" "subvolid=$NON_DEFAULT_SUBVOLID"
+
+# test bind mount pointing to subvolume sub-directory
+mkdir -p "$TS_MOUNTPOINT-subvol/bind-mnt"
+ts_fstab_add "$TS_MOUNTPOINT-subvol/bind-mnt" "$TS_MOUNTPOINT-bind" "auto" "bind"
+
+$TS_CMD_MOUNT -a 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT -a 2>&1 >> $TS_OUTPUT
+
+ts_fstab_clean
+
+ts_log "Success"
+ts_finalize
+
-- 
2.7.0

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
