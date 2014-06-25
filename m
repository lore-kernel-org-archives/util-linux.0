Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f178.google.com ([209.85.217.178]:59444 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbaFYE5K (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jun 2014 00:57:10 -0400
Received: by mail-lb0-f178.google.com with SMTP id 10so1432365lbg.37
        for <util-linux@vger.kernel.org>; Tue, 24 Jun 2014 21:57:08 -0700 (PDT)
Message-ID: <53AA56A0.2070308@gmail.com>
Date: Wed, 25 Jun 2014 10:57:04 +0600
From: "Alexander E. Patrakov" <patrakov@gmail.com>
MIME-Version: 1.0
To: Minchan Kim <minchan@kernel.org>
CC: Kai Krakow <hurikhan77@gmail.com>, systemd-devel@lists.freedesktop.org,
        kay@vrfy.org, Nitin Gupta <ngupta@vflare.org>, pacho@gentoo.org,
        util-linux@vger.kernel.org
Subject: Re: [systemd-devel] systemd-213: regression with zram
References: <53953D5C.1080004@gmail.com> <i8pg6b-mg8.ln1@hurikhan77.spdns.de> <5395BE60.70309@gmail.com> <pd8h6b-ufa.ln1@hurikhan77.spdns.de> <5395FF3A.9050407@gmail.com> <20140624062209.GA10661@gmail.com> <53A91C0A.2020807@gmail.com> <20140624065816.GA11030@gmail.com> <20140624074958.GB11030@gmail.com> <20140625003645.GC11030@gmail.com>
In-Reply-To: <20140625003645.GC11030@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

25.06.2014 06:36, Minchan Kim wrote:
> Could you test this patch? It passed my test.
> Thanks!
>
>  From 4ab4931c3fa7e6527e3a849d5e4c4f727143e66c Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Wed, 25 Jun 2014 09:20:24 +0900
> Subject: [PATCH] zram: revalidate disk after capacity change
>
> Alexander reported mkswap on /dev/zram0 is failed if other process
> is opening the block device file.
>
> Step is as follows,
>
> 0. Reset the unused zram device.
> 1. Use a program that opens /dev/zram0 with O_RDWR and sleeps until killed.
> 2. While that program sleeps, echo the correct value to /sys/block/zram0/disksize.
> 3. Verify (e.g. in /proc/partitions) that the disk size is applied correctly. It is.
> 4. While that program still sleeps, attempt to mkswap /dev/zram0. This fails:
> result: mkswap: error: swap area needs to be at least 40 KiB
>
> When I investigated, the size get by ioctl(fd, BLKGETSIZE64) on mkswap
> to get a size of blockdev was zero although zram0 has right size
> by 2.
>
> The reason is zram didn't revalidate disk after changing capacity
> so that size of blockdev's inode is not uptodate until all of file is close.
>
> This patch should fix the problem.
>
> Reported-by: Alexander E. Patrakov <patrakov@gmail.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Tested-by: Alexander E. Patrakov <patrakov@gmail.com>

It indeed fixes the problem.

> ---
>   drivers/block/zram/zram_drv.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 48eccb350180..089e72cd37be 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -622,8 +622,10 @@ static void zram_reset_device(struct zram *zram, bool reset_capacity)
>   	memset(&zram->stats, 0, sizeof(zram->stats));
>
>   	zram->disksize = 0;
> -	if (reset_capacity)
> +	if (reset_capacity) {
>   		set_capacity(zram->disk, 0);
> +		revalidate_disk(zram->disk);
> +	}
>   	up_write(&zram->init_lock);
>   }
>
> @@ -664,6 +666,7 @@ static ssize_t disksize_store(struct device *dev,
>   	zram->comp = comp;
>   	zram->disksize = disksize;
>   	set_capacity(zram->disk, zram->disksize >> SECTOR_SHIFT);
> +	revalidate_disk(zram->disk);
>   	up_write(&zram->init_lock);
>   	return len;
>
>

-- 
Alexander E. Patrakov
