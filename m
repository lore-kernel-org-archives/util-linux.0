Return-Path: sbrabec@suse.cz
Subject: [PATCH] tests: add btrfs mount tests
To: Karel Zak <kzak@redhat.com>
References: <56B0EEB2.1060707@suse.cz> <56B10E38.7040407@suse.cz>
 <20160211094352.6ncnnirhyd4jjd34@ws.net.home> <56BC9101.60908@suse.cz>
 <56BCB813.5090300@suse.cz>
Cc: util-linux@vger.kernel.org, David Sterba <dsterba@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56BCCDDA.6040300@suse.cz>
Date: Thu, 11 Feb 2016 19:07:22 +0100
MIME-Version: 1.0
In-Reply-To: <56BCB813.5090300@suse.cz>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>

btrfs needs a special support in mount. Add a testcase for btrfs specific
problems.

Coverage:
352740e8: bind mounts pointing to btrfs
2cd28fc8: mounting default subvolume
d2f82678: use of "auto"
618a8814: use of "subvolid"

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 tests/expected/mount/fstab-btrfs       |   1 +
 tests/expected/mount/fstab-btrfs-auto  |   1 +
 tests/expected/mount/fstab-btrfs-btrfs |   1 +
 tests/ts/mount/fstab-btrfs             | 128 +++++++++++++++++++++++++++++++++
 4 files changed, 131 insertions(+)
 create mode 100644 tests/expected/mount/fstab-btrfs
 create mode 100644 tests/expected/mount/fstab-btrfs-auto
 create mode 100644 tests/expected/mount/fstab-btrfs-btrfs
 create mode 100755 tests/ts/mount/fstab-btrfs

diff --git a/tests/expected/mount/fstab-btrfs b/tests/expected/mount/fstab-btrfs
new file mode 100644
index 0000000..3582111
--- /dev/null
+++ b/tests/expected/mount/fstab-btrfs
@@ -0,0 +1 @@
+Success
diff --git a/tests/expected/mount/fstab-btrfs-auto b/tests/expected/mount/fstab-btrfs-auto
new file mode 100644
index 0000000..3582111
--- /dev/null
+++ b/tests/expected/mount/fstab-btrfs-auto
@@ -0,0 +1 @@
+Success
diff --git a/tests/expected/mount/fstab-btrfs-btrfs b/tests/expected/mount/fstab-btrfs-btrfs
new file mode 100644
index 0000000..3582111
--- /dev/null
+++ b/tests/expected/mount/fstab-btrfs-btrfs
@@ -0,0 +1 @@
+Success
diff --git a/tests/ts/mount/fstab-btrfs b/tests/ts/mount/fstab-btrfs
new file mode 100755
index 0000000..0b11fd6
--- /dev/null
+++ b/tests/ts/mount/fstab-btrfs
@@ -0,0 +1,128 @@
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
+TS_MOUNTPOINT_ANY="$TS_MOUNTPOINT"
+TS_MOUNTPOINT_CREATE="$TS_MOUNTPOINT-create"
+TS_MOUNTPOINT_DEFAULT="$TS_MOUNTPOINT-default"
+TS_MOUNTPOINT_SUBVOL="$TS_MOUNTPOINT-subvol"
+TS_MOUNTPOINT_SUBVOLID="$TS_MOUNTPOINT-subvolid"
+TS_MOUNTPOINT_BIND="$TS_MOUNTPOINT-bind"
+
+ts_device_init 42
+DEVICE=$TS_LODEV
+[ -d "$TS_MOUNTPOINT_CREATE" ] || mkdir -p "$TS_MOUNTPOINT_CREATE"
+[ -d "$TS_MOUNTPOINT_DEFAULT" ] || mkdir -p "$TS_MOUNTPOINT_DEFAULT"
+[ -d "$TS_MOUNTPOINT_SUBVOL" ] || mkdir -p "$TS_MOUNTPOINT_SUBVOL"
+[ -d "$TS_MOUNTPOINT_SUBVOLID" ] || mkdir -p "$TS_MOUNTPOINT_SUBVOLID"
+[ -d "$TS_MOUNTPOINT_BIND" ] || mkdir -p "$TS_MOUNTPOINT_BIND"
+mkfs.btrfs -f -d single -m single $DEVICE &> /dev/null || ts_die "Cannot make btrfs on $DEVICE"
+
+$TS_CMD_MOUNT -o loop "$DEVICE" "$TS_MOUNTPOINT_CREATE"
+pushd . >/dev/null
+cd "$TS_MOUNTPOINT_CREATE"
+mkdir -p d0/dd0/ddd0
+cd ./d0/dd0/ddd0
+touch file{1..5}
+btrfs subvol create s1 >/dev/null
+cd ./s1
+touch file{1..5}
+mkdir bind-point
+mkdir -p d1/dd1/ddd1
+cd ./d1/dd1/ddd1
+btrfs subvol create s2 >/dev/null
+DEFAULT_SUBVOLID=$(btrfs inspect rootid s2)
+btrfs subvol set-default $DEFAULT_SUBVOLID . >/dev/null
+NON_DEFAULT_SUBVOLID=$(btrfs subvol list "$TS_MOUNTPOINT_CREATE" | while read dummy id rest ; do if test $id = $DEFAULT_SUBVOLID ; then continue ; fi ; echo $id ; done)
+cd ../../../..
+mkdir -p d2/dd2/ddd2
+cd ./d2/dd2/ddd2
+btrfs subvol create s3 >/dev/null
+mkdir -p s3/bind-mnt
+popd >/dev/null
+NON_DEFAULT_SUBVOL=d0/dd0/ddd0/d2/dd2/ddd2/s3
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_CREATE"
+
+
+ts_init_subtest "btrfs"
+# Tests with fs == btrfs
+# mounting default subvolume, deep in the structure, without entry in fstab
+ts_fstab_add "$DEVICE" "$TS_MOUNTPOINT_DEFAULT" "btrfs" ""
+# mounting default subvolume, deep in the structure
+ts_fstab_add "$DEVICE" "$TS_MOUNTPOINT_SUBVOL" "btrfs" "subvol=$NON_DEFAULT_SUBVOL"
+# mounting non-default subvolume
+ts_fstab_add "$DEVICE" "$TS_MOUNTPOINT_SUBVOLID" "btrfs" "subvolid=$NON_DEFAULT_SUBVOLID"
+# test bind mount pointing to subvolume root
+ts_fstab_add "$TS_MOUNTPOINT_SUBVOLID" "$TS_MOUNTPOINT_BIND" "auto" "bind"
+
+$TS_CMD_MOUNT -a 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT -a 2>&1 >> $TS_OUTPUT
+
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_BIND" 2>&1 >> $TS_OUTPUT
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_DEFAULT" 2>&1 >> $TS_OUTPUT
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_SUBVOL" 2>&1 >> $TS_OUTPUT
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_SUBVOLID" 2>&1 >> $TS_OUTPUT
+
+# check that everything was unmounted
+$TS_CMD_MOUNT | grep "$TS_MOUNTPOINT_ANY" 2>&1 >> $TS_OUTPUT
+
+ts_fstab_clean
+ts_log "Success"
+ts_finalize_subtest
+
+ts_init_subtest "auto"
+# Tests with fs == auto
+# mounting default subvolume, deep in the structure, without entry in fstab
+ts_fstab_add "$DEVICE" "$TS_MOUNTPOINT_DEFAULT" "auto" ""
+# mounting default subvolume, deep in the structure
+ts_fstab_add "$DEVICE" "$TS_MOUNTPOINT_SUBVOL" "auto" "subvol=$NON_DEFAULT_SUBVOL"
+# mounting non-default subvolume
+ts_fstab_add "$DEVICE" "$TS_MOUNTPOINT_SUBVOLID" "auto" "subvolid=$NON_DEFAULT_SUBVOLID"
+# test bind mount pointing to subvolume sub-directory
+ts_fstab_add "$TS_MOUNTPOINT_SUBVOL/bind-mnt" "$TS_MOUNTPOINT_BIND" "auto" "bind"
+
+$TS_CMD_MOUNT -a 2>&1 >> $TS_OUTPUT
+$TS_CMD_MOUNT -a 2>&1 >> $TS_OUTPUT
+
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_BIND" 2>&1 >> $TS_OUTPUT
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_DEFAULT" 2>&1 >> $TS_OUTPUT
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_SUBVOL" 2>&1 >> $TS_OUTPUT
+$TS_CMD_UMOUNT "$TS_MOUNTPOINT_SUBVOLID" 2>&1 >> $TS_OUTPUT
+
+# check that everything was unmounted
+$TS_CMD_MOUNT | grep "$TS_MOUNTPOINT_ANY" 2>&1 >> $TS_OUTPUT
+
+ts_fstab_clean
+ts_log "Success"
+ts_finalize_subtest
+
+
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
