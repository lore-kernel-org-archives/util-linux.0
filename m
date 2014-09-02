Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:61782 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbaIBGwA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Sep 2014 02:52:00 -0400
Received: by mail-wi0-f181.google.com with SMTP id e4so7190191wiv.8
        for <util-linux@vger.kernel.org>; Mon, 01 Sep 2014 23:51:58 -0700 (PDT)
Message-ID: <540569A3.8090904@gmail.com>
Date: Tue, 02 Sep 2014 08:54:27 +0200
From: Francis Moreau <francis.moro@gmail.com>
MIME-Version: 1.0
To: "Dale R. Worley" <worley@alum.mit.edu>
CC: util-linux@vger.kernel.org
Subject: Re: Weird behaviour with lsblk and freshly created loop device
References: <54049344.4010502@gmail.com> <201409011941.s81JfCZf004329@hobgoblin.ariadne.com>
In-Reply-To: <201409011941.s81JfCZf004329@hobgoblin.ariadne.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 09/01/2014 09:41 PM, Dale R. Worley wrote:
>> From: Francis Moreau <francis.moro@gmail.com>
> 
>> Right after associating a loop device with a disk image file, I'm using
>> lsblk to retrieve some info about the partitions.
>>
>> If I'm doing this as root:
>>
>>   $ losetup /dev/loop0 /tmp/installer-disks/disk0.img && lsblk -n --raw
>> --paths -o NAME,PARTTYPE /dev/loop0 && losetup -d /dev/loop0
>>
>> then the output is missing the parttypes:
>>
>>   /dev/loop0
>>   /dev/loop0p1
>>   /dev/loop0p2
>>
>> However adding a sleep or 'udevadm settle' after setting the loop device
>> the parttypes are correctly showed:
> 
> It looks like the process of determining the partitions is
> asynchronous, and is not assured of being completed when losetup
> returns.

Still lsblk lists the partitions.

I'm not sure how lsblk works. It seems that it relies on udev to get
certain information, parttype is an example but doesn't for listing
partitions of  block devices.

That seems to make the whole process racy.

If this is correct, I'm wondering why lsblk relies on udev to retrieve
block device metadata. Can't it find them out directly from the kernel ?

> 
> What happens when you add -P to losetup?  The manual page (for Fedora
> 19) says "force kernel to scan partition table on newly created loop
> device", which suggests that the partition scan will be completed by
> the time losetup returns.

Adding -P doesn't help. Actually the kernel correctly detected the
partitions embedded in the loop device. But udev hasn't handled the
associeted events yet when lsblk is called.

Thanks
