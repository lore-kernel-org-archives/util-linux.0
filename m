Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60777 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755151AbcA2LbN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 29 Jan 2016 06:31:13 -0500
Date: Fri, 29 Jan 2016 12:31:10 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: test sfdisk, optimal_iosize
Message-ID: <20160129113110.o76pvon3wormblgd@ws.net.home>
References: <201601291131.29201.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201601291131.29201.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 29, 2016 at 11:31:28AM +0100, Ruediger Meier wrote:
> Hi,
> 
> I've got some test failures like
> 
> --- /home/abuild/rpmbuild/BUILD/util-linux-2.27.git247.4c01c/tests/expected/sfdisk/dos-activate
> +++ /home/abuild/rpmbuild/BUILD/util-linux-2.27.git247.4c01c/tests/output/sfdisk/dos-activate
> @@ -6,7 +6,7 @@
>  Disk <removed>: 50 MiB, 52428800 bytes, 102400 sectors
>  Units: sectors of 1 * 512 = 512 bytes
>  Sector size (logical/physical): 512 bytes / 4096 bytes
> -I/O size (minimum/optimal): 4096 bytes / 32768 bytes
> +I/O size (minimum/optimal): 4096 bytes / 64 bytes

Very very strange. It seems like the number is in sectors (64 * 512 =
32768) rather than in bytes.

>  Disklabel type: dos
>  Disk identifier: <removed>
> 
> 
> optimal < minimum ... is this a bug?
> 
> Where does this optimal iosize come from, scsi_debug module?
> Is there a commandline tool to get this iosize, maybe blkid?

 cat /sys/block/sda/queue/{optimal,minimum}_io_size
 cat /sys/block/sda/queue/{physical,logical}_block_size

The optimal IO size is often 0 (in /sys) in this case libfdisk
fallback to minimal IO size.

Try 
    LIBFDISK_DEBUG=all fdisk -l /dev/sda

you will see something like:

8694: libfdisk:      CXT: [0x560e0bba9050]: /dev/sda: discovering topology...
8694: libfdisk:      CXT: [0x560e0bba9050]: initialize libblkid prober
8694: libfdisk:      CXT: [0x560e0bba9050]: result: log/phy sector size: 512/512
8694: libfdisk:      CXT: [0x560e0bba9050]: result: fdisk/optimal/minimal io: 512/0/512
8694: libfdisk:      CXT: [0x560e0bba9050]: /dev/sda: discovering geometry...
8694: libfdisk:      CXT: [0x560e0bba9050]: total sectors: 468862128 (ioctl=468862128)
8694: libfdisk:      CXT: [0x560e0bba9050]: result: C/H/S: 29185/255/63

  Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
