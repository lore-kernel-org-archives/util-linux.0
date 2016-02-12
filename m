Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:56552 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668AbcBLP21 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Feb 2016 10:28:27 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: [PATCH] tests: add test for loop option in fstab
Date: Fri, 12 Feb 2016 16:28:19 +0100
Cc: util-linux@vger.kernel.org
References: <56BCE4F4.6020409@suse.cz>
In-Reply-To: <56BCE4F4.6020409@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <201602121628.19968.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 11 February 2016, Stanislav Brabec wrote:
> Add a new fstab tests which check loop mount of the same source
> multiple times in multiple steps.
>
> The test is currently failing, but it should not fail once the
> triggering bug will be fixed.

Will this be fixed quickly? Otherwise we should add
  TS_KNOWN_FAIL="yes"
to the test. Then you would still see it in the build log and test diff 
but it wouldn't bother you with build error.

> Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
> ---
>  tests/expected/mount/fstab-loop |  1 +
>  tests/ts/mount/fstab-loop       | 51
> +++++++++++++++++++++++++++++++++++++++++ 2 files changed, 52
> insertions(+)
>  create mode 100644 tests/expected/mount/fstab-loop
>  create mode 100755 tests/ts/mount/fstab-loop
>
> diff --git a/tests/expected/mount/fstab-loop
> b/tests/expected/mount/fstab-loop new file mode 100644
> index 0000000..3582111
> --- /dev/null
> +++ b/tests/expected/mount/fstab-loop
> @@ -0,0 +1 @@
> +Success
> diff --git a/tests/ts/mount/fstab-loop b/tests/ts/mount/fstab-loop
> new file mode 100755
> index 0000000..3178b95
> --- /dev/null
> +++ b/tests/ts/mount/fstab-loop
> @@ -0,0 +1,51 @@
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
> +TS_DESC="loop (fstab)"
> +
> +. $TS_TOPDIR/functions.sh
> +ts_init "$*"
> +
> +ts_check_test_command "$TS_CMD_MOUNT"
> +ts_check_test_command "$TS_CMD_UMOUNT"
> +
> +ts_skip_nonroot
> +ts_check_losetup
> +ts_check_prog "mkfs.ext3"
> +
> +IMG=$(ts_image_init)
> +
> +mkfs.ext3 $IMG &> /dev/null || ts_die "Cannot make ext3 on $DEVICE"
> +
> +[ -d "$TS_MOUNTPOINT-1" ] || mkdir -p $TS_MOUNTPOINT-1
> +[ -d "$TS_MOUNTPOINT-2" ] || mkdir -p $TS_MOUNTPOINT-2
> +
> +ts_fstab_add "$IMG" "$TS_MOUNTPOINT-1" "ext3" "loop"
> +$TS_CMD_MOUNT -a >> $TS_OUTPUT 2>&1
> +
> +ts_fstab_add "$IMG" "$TS_MOUNTPOINT-2" "ext3" "loop"
> +$TS_CMD_MOUNT -a >> $TS_OUTPUT 2>&1
> +
> +$TS_CMD_UMOUNT "$TS_MOUNTPOINT-1" >> $TS_OUTPUT 2>&1
> +$TS_CMD_UMOUNT "$TS_MOUNTPOINT-2" >> $TS_OUTPUT 2>&1
> +
> +ts_fstab_clean
> +
> +ts_log "Success"
> +ts_finalize
> +
> --
> 2.7.0
