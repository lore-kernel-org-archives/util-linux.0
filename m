Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44233 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbaIAR4R (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 1 Sep 2014 13:56:17 -0400
Date: Mon, 1 Sep 2014 19:56:09 +0200
From: Karel Zak <kzak@redhat.com>
To: Francis Moreau <francis.moro@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Weird behaviour with lsblk and freshly created loop device
Message-ID: <20140901175609.GA21325@x2.net.home>
References: <54049344.4010502@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54049344.4010502@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 01, 2014 at 05:39:48PM +0200, Francis Moreau wrote:
> Hello,
> 
> Right after associating a loop device with a disk image file, I'm using
> lsblk to retrieve some info about the partitions.
> 
> If I'm doing this as root:
> 
>   $ losetup /dev/loop0 /tmp/installer-disks/disk0.img && lsblk -n --raw
> --paths -o NAME,PARTTYPE /dev/loop0 && losetup -d /dev/loop0
> 
> then the output is missing the parttypes:
> 
>   /dev/loop0
>   /dev/loop0p1
>   /dev/loop0p2
> 
> However adding a sleep or 'udevadm settle' after setting the loop device
> the parttypes are correctly showed:
> 
>    $ losetup /dev/loop0 /tmp/installer-disks/disk0.img && udevadm settle
> && lsblk -n --raw --paths -o NAME,PARTTYPE /dev/loop0 && losetup -d
> /dev/loop0
>   /dev/loop0
>   /dev/loop0p1 0657fd6d-a4ab-43c4-84e5-0933c84b4f4f
>   /dev/loop0p2 4f68bce3-e8cd-4db1-96e7-fbcaf984b709
> 
> Could anybody tell me if that's expected ?

 Sure, lsblk reads the information from udev db.

 You can compile --without-udev, the it will use libblkid only.
 
 Maybe  we can add something like "lsblk --no-udev" to bypass udev 
 without recompilation, but is it really necessary? 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
