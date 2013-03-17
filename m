Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53603 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756360Ab3CQOSl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 17 Mar 2013 10:18:41 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 06F03A5077
	for <util-linux@vger.kernel.org>; Sun, 17 Mar 2013 15:18:40 +0100 (CET)
Message-ID: <5145D0B4.1070207@suse.com>
Date: Sun, 17 Mar 2013 10:18:28 -0400
From: Jeff Mahoney <jeffm@suse.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] loopdev: sync capacity after setting it
References: <51438CF9.7020707@suse.com>
In-Reply-To: <51438CF9.7020707@suse.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 03/15/2013 05:04 PM, Jeff Mahoney wrote:
> I recently tried to mount an hfsplus file system from an image file with
> a partition table by using the loop offset and sizelimit options to specify
> the location of the file system.
>
> hfsplus stores some metadata at a set offset from the end of the partition,
> so it's sensitive to the device size reported by the kernel.
>
> It worked with this:
> # losetup -r -o 32k --sizelimit=102400000 <loopdev> <imagefile>
> # mount -r -t hfsplus <loopdev> <mountpoint>
>
> But failed with this:
> # mount -r -oloop,offset=32k,sizelimit=102400000 <imagefile> <mountpoint>
>
> # losetup -a
> /dev/loop0: [0089]:2 (<imagefile>), offset 32768, sizelimit 102400000
> /dev/loop1: [0089]:2 (<imagefile>), offset 32768, sizelimit 102400000
>
> /proc/partitions shows the correct number of blocks to match the sizelimit.
>
> But if I set a breakpoint in mount before the mount syscall, I could see:
> # blockdev --getsize64 /dev/loop[01]
> 102400000
> 102432768
>
> The kernel loop driver will set the gendisk capacity of the device at
> LOOP_SET_STATUS64 but won't sync it to the block device until one of two
> conditions are met: All open file descriptors referring to the device are
> closed (and it will sync when re-opened) or if the LOOP_SET_CAPACITY ioctl
> is called to sync it. Since mount opens the device and passes it directly
> to the mount syscall after LOOP_SET_STATUS64 without closing and reopening
> it, the sizelimit argument is effectively ignroed. The capacity needs to
> be synced immediately for it to work as expected.
>
> This patch adds the LOOP_SET_CAPACITY call to loopctx_setup_device since
> the device isn't yet released to the user, so it's safe to sync the capacity
> immediately.

It turns out this ioctl wasn't introduced until 2.6.30. I'll fix that up 
and resend tomorrow.

-Jeff


> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>   lib/loopdev.c |   12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> --- a/lib/loopdev.c
> +++ b/lib/loopdev.c
> @@ -1105,6 +1105,18 @@ int loopcxt_setup_device(struct loopdev_
>   		goto err;
>   	}
>
> +	/*
> +	 * mount passes the file descriptor without closing it, so
> +	 * the capacity isn't updated automatically. File systems
> +	 * won't see the new size if it's not the full size of
> +	 * the backing file.
> +	 */
> +	if ((lc->info.lo_offset || lc->info.lo_sizelimit) &&
> +	    ioctl(dev_fd, LOOP_SET_CAPACITY, 0)) {
> +		DBG(lc, loopdev_debug("LOOP_SET_CAPACITY failed: %m"));
> +		goto err;
> +	}
> +
>   	DBG(lc, loopdev_debug("setup: LOOP_SET_STATUS64: OK"));
>
>   	memset(&lc->info, 0, sizeof(lc->info));
>


-- 
Jeff Mahoney
SUSE Labs
