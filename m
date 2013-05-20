Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36830 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755936Ab3ETLPj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 20 May 2013 07:15:39 -0400
Date: Mon, 20 May 2013 13:15:23 +0200
From: Karel Zak <kzak@redhat.com>
To: Bertrand Jacquin <beber@meleeweb.net>
Cc: util-linux@vger.kernel.org
Subject: Re: sfdisk 2.20.1 --no-reread do BLKRRPART
Message-ID: <20130520111523.GB19935@x2.net.home>
References: <20120216201617.GD7482@lemonhead.scabb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120216201617.GD7482@lemonhead.scabb>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Sorry for the delay :-)

On Thu, Feb 16, 2012 at 09:16:18PM +0100, Bertrand Jacquin wrote:
> When creating partitions on a destination that is not a block device,
> sfdisk do a BLKRRPART ioctl even when --no-reread option is used, but
> looking at documentation --no-reread only apply to the beginning
> process.
> 
> Would it be fine to extend that to the complete process ?

 Not sure, but I think it should be enough to don't call BLKRRPART
 ioctl for non-block devices.

>   dd if=/dev/zero of=/tmp/disk.img bs=1024 count=4032
>   strace -fF -s 1024 -e trace=ioctl \
>     sfdisk --no-reread -C2 -H32 -S63 -q -f \
>       /tmp/disk.img << EOF
> unit: sectors
> 
> part1 : start= 63, size= 3969, Id=83
> part2 : start= 4032, size= 98784, Id=83
> part3 : start= 102816, size= 22176, Id=83
> part4 : start= 124992, size= 0, Id=83
> EOF

...

> Re-reading the partition table ...
> ioctl(3, BLKRRPART, 0)                  = -1 ENOTTY (Inappropriate ioctl for device)
> BLKRRPART: Inappropriate ioctl for device

 This use case (disk images partitioning) should be fixed in the git
 tree.

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
