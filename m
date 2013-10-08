Return-Path: util-linux-owner@vger.kernel.org
Received: from host-254-7-12-185.cloudsigma.com ([185.12.7.254]:41420 "EHLO
	kathu.ole32.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755341Ab3JHXW4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Oct 2013 19:22:56 -0400
Message-ID: <525493CA.40207@breezl.com>
Date: Wed, 09 Oct 2013 01:22:50 +0200
From: butter@breezl.com
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org, Phillip Susi <psusi@ubuntu.com>
Subject: Re: losetup -d does not move partition devices
References: <5241BC33.8050700@breezl.com> <20131007113852.GF14360@x2.net.home>
In-Reply-To: <20131007113852.GF14360@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel

Thanks for your detailed explanation. Good to hear I did hit a real
(although already known) issue. Too bad there is no easy fix.

Anyway, one last minor comment: 

Ubuntu 13.04 64bit does not yet support option -P for losetup. So
this must be an older version of util-linux. But then: how do I
determine the version of util-linux installed? The binaries have
no --version option and 'strings /sbin/losetup | egrep '[0-9]' does
not reveal anything useful either. Maybe there is a general version
for util-linux available in another binary? The man page does not
tell. I failed to identify the version number!

Regards
BB.

On 07.10.2013 13:38, Karel Zak wrote:
> On Tue, Sep 24, 2013 at 06:22:11PM +0200, butter@breezl.com wrote:
>> get deleted when you call "losetup -d DEVICE". This causes other programs
>> (like lvmdiskscan -l) to report Input/output errors.
>>
>> Here is how to reproduce the problem:
>>
>> 	LOOPDEV=/dev/loop3
>> 	IMAGEFILE=`pwd`/mydisk.img
>> 	MOUNTPOINT=`pwd`/mnt
>>
>> 	# 1. Create and mount an ext4 partition from a file-based disk image
>> 	dd if=/dev/zero of=$IMAGEFILE bs=1M count=80
>> 	sudo losetup $LOOPDEV $IMAGEFILE
> 
> kernel uses partitions on loop devices conditionally, and here you said
> "I don't care about partitions...". You have to use
> 
>     sudo losetup -P $LOOPDEV $IMAGEFILE
> 
> if you want to force kernel loopdev driver to use partitions.
> 
>> 	sudo parted $LOOPDEV mklabel msdos
>> 	sudo parted $LOOPDEV mkpart primary 2048s    43007s
>> 	sudo mkfs -t ext4 ${LOOPDEV}p1
>> 	mkdir $MOUNTPOINT
>> 	sudo mount ${LOOPDEV}p1 $MOUNTPOINT
>>
>> 	# 2. Unmount again => ERROR: the partition device files are not deleted
>> 	sudo umount $MOUNTPOINT
> 
> mount/umount is completely irrelevant for this issue. The simple way
> to reproduce the problem is:
> 
>          dd if=/dev/zero of=img bs=1M count=80
>          losetup -f img --show
>          parted /dev/loop0 mklabel msdos
>          parted /dev/loop0 mklabel msdos
>          losetup -d /dev/loop0
> 
>          cat /sys/block/loop0/size
>          cat /sys/block/loop0/loop0p1/size
> 
> Anyway, the problem is that parted uses BLKPG_ADD_PARTITION ioctl to create
> /dev/loop0p1, but the loop0 device has been created without PARTSCAN flag 
> (see /sys/block/loop0/loop/partscan). It means that loopdev kernel driver
> does not call BLKRRPART during loop0 cleanup (loop_clr_fd() in kernel code).
> 
> You can remove the partition manually by BLKPG_DEL_PARTITION ioctl:
> 
>     # partx -d /dev/loop0p1
> 
> 
> ... but this all is known issue, Phillip Susi tried to fix this
> disadvantage, but his solution has been reverted (see kernel commit
> c2fccc1c9f7c81700cbac2120a4ad5441dd37004).
> 
> 
>     Karel
> 

