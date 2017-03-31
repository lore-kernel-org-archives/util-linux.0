Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:57534 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932566AbdCaLBp (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 31 Mar 2017 07:01:45 -0400
Subject: Re: [PATCH] test: fix mountpoint device check in libmount/loop
To: util-linux@vger.kernel.org
References: <20170331091925.mpwmxxk4da4lsegr@ws.net.home>
 <1490954986-12713-1-git-send-email-sweet_f_a@gmx.de>
Cc: Stanislav Brabec <sbrabec@suse.cz>
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
Message-ID: <b17d2d6b-e03d-323e-f878-7eb9b1088b7d@gmx.de>
Date: Fri, 31 Mar 2017 13:01:40 +0200
MIME-Version: 1.0
In-Reply-To: <1490954986-12713-1-git-send-email-sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 03/31/2017 12:09 PM, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> This test could fail if the build directory is somehow exoticly
> mounted (shared bind mounts, symlinks).
>
> CC: Stanislav Brabec <sbrabec@suse.cz>
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  tests/ts/libmount/loop | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/tests/ts/libmount/loop b/tests/ts/libmount/loop
> index 452732f..893d902 100755
> --- a/tests/ts/libmount/loop
> +++ b/tests/ts/libmount/loop
> @@ -23,12 +23,24 @@ TS_DESC="losetup-loop"
>  ts_init "$*"
>
>  ts_check_test_command "$TS_CMD_MOUNT"
> +ts_check_test_command "$TS_CMD_FINDMNT"
>  ts_check_test_command "$TS_CMD_LOSETUP"
>
>  ts_skip_nonroot
>  ts_check_losetup
>  ts_check_prog "mkfs.ext3"
>
> +function verify_mount_dev {
> +	local dev=$1
> +	local mp=$2
> +	local dev_mounted=$($TS_CMD_FINDMNT -no SOURCE "$mp")

Regarding your other comments, maybe we should add --mountpoint here.

> +
> +	if test "$dev" != "$dev_mounted" ; then
> +		echo "Mounted incorrect device: have '$dev_mounted', want '$dev'" >&2
> +		return 1
> +	fi
> +}
> +
>  #
>  # file-* tests: Backing file is a regular file
>  #
> @@ -61,10 +73,7 @@ ts_init_subtest "dev-loop"
>  [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
>  LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show $BACKFILE 2>> $TS_OUTPUT )
>  $TS_CMD_MOUNT $LODEV "$TS_MOUNTPOINT" >> $TS_OUTPUT 2>&1
> -MOUNTED_LODEV="$( $TS_CMD_MOUNT | grep "$TS_MOUNTPOINT" | while read LODEV REST ; do echo $LODEV ; done )"
> -if test "$MOUNTED_LODEV" != "$LODEV" ; then
> -    echo "Mounted incorrect device mounts: $MOUNTED_LODEV, wants: $LODEV" >> $TS_OUTPUT
> -fi
> +verify_mount_dev "$LODEV" "$TS_MOUNTPOINT" >> $TS_OUTPUT 2>&1
>  $TS_CMD_UMOUNT "$TS_MOUNTPOINT" >> $TS_OUTPUT 2>&1
>  $TS_CMD_LOSETUP --detach $LODEV >> $TS_OUTPUT 2>&1
>  udevadm settle
> @@ -75,10 +84,7 @@ ts_init_subtest "o-loop-val"
>  [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
>  LODEV=$( $TS_CMD_LOSETUP --find 2>> $TS_OUTPUT )
>  $TS_CMD_MOUNT -oloop=$LODEV "$BACKFILE" "$TS_MOUNTPOINT" >> $TS_OUTPUT 2>&1
> -MOUNTED_LODEV="$( cat /proc/self/mounts |  grep "$TS_MOUNTPOINT" | while read LODEV REST ; do echo $LODEV ; done )"
> -if test "$MOUNTED_LODEV" != "$LODEV" ; then
> -    echo "Mounted incorrect device mounts: $MOUNTED_LODEV, wants: $LODEV" >> $TS_OUTPUT
> -fi
> +verify_mount_dev "$LODEV" "$TS_MOUNTPOINT" >> $TS_OUTPUT 2>&1
>  $TS_CMD_UMOUNT "$TS_MOUNTPOINT" >> $TS_OUTPUT 2>&1
>  udevadm settle
>  ts_log "Success"
> @@ -88,10 +94,7 @@ ts_init_subtest "reuse"
>  [ -d "$TS_MOUNTPOINT" ] || mkdir -p $TS_MOUNTPOINT
>  LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show "$BACKFILE" 2>> $TS_OUTPUT )
>  $TS_CMD_MOUNT "$BACKFILE" "$TS_MOUNTPOINT" >> $TS_OUTPUT 2>&1
> -MOUNTED_LODEV="$( cat /proc/self/mounts |  grep "$TS_MOUNTPOINT" | while read LODEV REST ; do echo $LODEV ; done )"
> -if test "$MOUNTED_LODEV" != "$LODEV" ; then
> -    echo "Mounted incorrect device mounts: $MOUNTED_LODEV, wants: $LODEV" >> $TS_OUTPUT
> -fi
> +verify_mount_dev "$LODEV" "$TS_MOUNTPOINT" >> $TS_OUTPUT 2>&1
>  $TS_CMD_UMOUNT "$TS_MOUNTPOINT" >> $TS_OUTPUT 2>&1
>  $TS_CMD_LOSETUP --detach $LODEV >> $TS_OUTPUT 2>&1
>  udevadm settle
>
