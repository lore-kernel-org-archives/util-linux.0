Return-Path: util-linux-owner@vger.kernel.org
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:60928
	"EHLO qmta01.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752765AbaIATlP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 1 Sep 2014 15:41:15 -0400
Date: Mon, 1 Sep 2014 15:41:12 -0400
Message-Id: <201409011941.s81JfCZf004329@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: Francis Moreau <francis.moro@gmail.com>
CC: util-linux@vger.kernel.org
In-reply-to: <54049344.4010502@gmail.com> (francis.moro@gmail.com)
Subject: Re: Weird behaviour with lsblk and freshly created loop device
References: <54049344.4010502@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: Francis Moreau <francis.moro@gmail.com>

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

It looks like the process of determining the partitions is
asynchronous, and is not assured of being completed when losetup
returns.

What happens when you add -P to losetup?  The manual page (for Fedora
19) says "force kernel to scan partition table on newly created loop
device", which suggests that the partition scan will be completed by
the time losetup returns.

Dale
