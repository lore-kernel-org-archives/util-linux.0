Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:49256 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752239AbcCNBUx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 Mar 2016 21:20:53 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: [PATCH] tests: add btrfs mount tests
Date: Mon, 14 Mar 2016 02:20:47 +0100
Cc: util-linux@vger.kernel.org
References: <56B0EEB2.1060707@suse.cz>
In-Reply-To: <56B0EEB2.1060707@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <201603140220.47345.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 02 February 2016, Stanislav Brabec wrote:
> btrfs needs a special support in mount. Add a testcase for btrfs
> specific problems.

IMO this test needs some more error handling, see below.

> Coverage:
> 352740e8: bind mounts pointing to btrfs subvolume
> 2cd28fc8: mounting default subvolume
> d2f82678: use of "auto"
> 618a8814: use of "subvolid"
>
> Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
> ---
>  tests/expected/mount/fstab-btrfs |  1 +
>  tests/ts/mount/fstab-btrfs       | 99
> ++++++++++++++++++++++++++++++++++++++++ 2 files changed, 100
> insertions(+)
>  create mode 100644 tests/expected/mount/fstab-btrfs
>  create mode 100755 tests/ts/mount/fstab-btrfs
>
> diff --git a/tests/expected/mount/fstab-btrfs
> b/tests/expected/mount/fstab-btrfs new file mode 100644
> index 0000000..3582111
> --- /dev/null
> +++ b/tests/expected/mount/fstab-btrfs
> @@ -0,0 +1 @@
> +Success
> diff --git a/tests/ts/mount/fstab-btrfs b/tests/ts/mount/fstab-btrfs
> new file mode 100755
> index 0000000..1c1d0fd
> --- /dev/null
> +++ b/tests/ts/mount/fstab-btrfs
> @@ -0,0 +1,99 @@
> +#!/bin/bash
> +
> +#
> +# Copyright (C) 2016 Stanislav Brabec <sbrabec@suse.cz>
> +#
> +# This file is part of util-linux.
> +#
> +# This file is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published
> by +# the Free Software Foundation; either version 2 of the License,
> or +# (at your option) any later version.
> +#
> +# This file is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +TS_TOPDIR="${0%/*}/../.."
> +TS_DESC="btrfs (fstab)"
> +
> +. $TS_TOPDIR/functions.sh
> +ts_init "$*"
> +
> +ts_check_test_command "$TS_CMD_MOUNT"
> +ts_check_test_command "$TS_CMD_UMOUNT"
> +
> +ts_skip_nonroot
> +ts_check_losetup
> +ts_check_prog "mkfs.btrfs"
> +ts_check_prog "btrfs"
> +
> +ts_device_init 42
> +DEVICE=$TS_LODEV
> +[ -d "$TS_MOUNTPOINT-create" ] || mkdir -p "$TS_MOUNTPOINT-create"
> +[ -d "$TS_MOUNTPOINT-default" ] || mkdir -p "$TS_MOUNTPOINT-default"
> +[ -d "$TS_MOUNTPOINT-subvol" ] || mkdir -p "$TS_MOUNTPOINT-subvol"
> +[ -d "$TS_MOUNTPOINT-subvolid" ] || mkdir -p
> "$TS_MOUNTPOINT-subvolid" +[ -d "$TS_MOUNTPOINT-bind" ] || mkdir -p
> "$TS_MOUNTPOINT-bind" +mkfs.btrfs -f -d single -m single $DEVICE &>
> /dev/null || ts_die "Cannot make btrfs on $DEVICE" +
> +$TS_CMD_MOUNT -o loop "$DEVICE" "$TS_MOUNTPOINT-create"
> +pushd . >/dev/null
> +cd "$TS_MOUNTPOINT-create"
> +mkdir -p d0/dd0/ddd0
> +cd ./d0/dd0/ddd0
> +touch file{1..5}
> +btrfs subvol create s1 >/dev/null
> +cd ./s1
> +touch file{1..5}
> +mkdir -p d1/dd1/ddd1
> +cd ./d1/dd1/ddd1
> +btrfs subvol create s2 >/dev/null

For example if you comment out above line (or if it would fail) then
all subtests below still succeed. This can't be right.

> +DEFAULT_SUBVOLID=$(btrfs inspect rootid s2)
> +btrfs subvol set-default $DEFAULT_SUBVOLID . >/dev/null
> +NON_DEFAULT_SUBVOLID=$(btrfs subvol list "$TS_MOUNTPOINT-create" |
> while read dummy id rest ; do if test $id = $DEFAULT_SUBVOLID ; then
> continue ; fi ; echo $id ; done) +cd ../../../..
> +mkdir -p d2/dd2/ddd2
> +cd ./d2/dd2/ddd2
> +btrfs subvol create s3 >/dev/null
> +popd >/dev/null
> +NON_DEFAULT_SUBVOL=d0/dd0/ddd0/d2/dd2/ddd2/s3
> +$TS_CMD_UMOUNT "$TS_MOUNTPOINT-create"
> +
> +# Tests with fs == btrfs
> +# mounting default subvolume, deep in the structure, without entry
> in fstab +ts_fstab_add "$DEVICE" "$TS_MOUNTPOINT-default" "btrfs" ""
> +# mounting default subvolume, deep in the structure
> +ts_fstab_add "$DEVICE" "$TS_MOUNTPOINT-subvol" "btrfs"
> "subvol=$NON_DEFAULT_SUBVOL" +# mounting non-default subvolume
> +ts_fstab_add "$DEVICE" "$TS_MOUNTPOINT-subvolid" "btrfs"
> "subvolid=$NON_DEFAULT_SUBVOLID" +
> +# test bind mount pointing to subvolume root
> +ts_fstab_add "$TS_MOUNTPOINT-subvol" "$TS_MOUNTPOINT-bind" "auto"
> "bind" +
> +$TS_CMD_MOUNT -a 2>&1 >> $TS_OUTPUT
> +$TS_CMD_MOUNT -a 2>&1 >> $TS_OUTPUT
> +
> +ts_fstab_clean
> +
> +# Tests with fs == auto
> +# mounting default subvolume, deep in the structure, without entry
> in fstab +ts_fstab_add "$DEVICE" "$TS_MOUNTPOINT-default" "auto" ""
> +# mounting default subvolume, deep in the structure
> +ts_fstab_add "$DEVICE" "$TS_MOUNTPOINT-subvol" "auto"
> "subvol=$NON_DEFAULT_SUBVOL" +# mounting non-default subvolume
> +ts_fstab_add "$DEVICE" "$TS_MOUNTPOINT-subvolid" "auto"
> "subvolid=$NON_DEFAULT_SUBVOLID" +
> +# test bind mount pointing to subvolume sub-directory
> +mkdir -p "$TS_MOUNTPOINT-subvol/bind-mnt"
> +ts_fstab_add "$TS_MOUNTPOINT-subvol/bind-mnt" "$TS_MOUNTPOINT-bind"
> "auto" "bind" +
> +$TS_CMD_MOUNT -a 2>&1 >> $TS_OUTPUT
> +$TS_CMD_MOUNT -a 2>&1 >> $TS_OUTPUT
> +
> +ts_fstab_clean
> +
> +ts_log "Success"
> +ts_finalize
> +
> --
> 2.7.0


