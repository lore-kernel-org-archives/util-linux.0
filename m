Return-Path: francis.moro@gmail.com
Message-ID: <54056BD1.1080205@gmail.com>
Date: Tue, 02 Sep 2014 09:03:45 +0200
From: Francis Moreau <francis.moro@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: Weird behaviour with lsblk and freshly created loop device
References: <54049344.4010502@gmail.com> <20140901175609.GA21325@x2.net.home>
In-Reply-To: <20140901175609.GA21325@x2.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>

On 09/01/2014 07:56 PM, Karel Zak wrote:
> On Mon, Sep 01, 2014 at 05:39:48PM +0200, Francis Moreau wrote:
>> Hello,
>>
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
>>
>>    $ losetup /dev/loop0 /tmp/installer-disks/disk0.img && udevadm settle
>> && lsblk -n --raw --paths -o NAME,PARTTYPE /dev/loop0 && losetup -d
>> /dev/loop0
>>   /dev/loop0
>>   /dev/loop0p1 0657fd6d-a4ab-43c4-84e5-0933c84b4f4f
>>   /dev/loop0p2 4f68bce3-e8cd-4db1-96e7-fbcaf984b709
>>
>> Could anybody tell me if that's expected ?
> 
>  Sure, lsblk reads the information from udev db.
> 
>  You can compile --without-udev, the it will use libblkid only.
>  
>  Maybe  we can add something like "lsblk --no-udev" to bypass udev 
>  without recompilation, but is it really necessary? 

It seems that lsblk uses udev to get some block device metadata and asks
some others to the kernel. If so, it makes the whole process racy
because udev might not have handled the events sent by the kernel yet.

I'm not sure why udev is used by default in the first place, what are
the benefits ? Using libblkid, at least by default seems the right thing
to do.

Otherwise maybe lsblk should do the equivalent of 'udevadm settle' to
handle correctly freshly created devices ?

Thanks.
