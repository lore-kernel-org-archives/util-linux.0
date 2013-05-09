Return-Path: util-linux-owner@vger.kernel.org
Received: from atl4mhob10.myregisteredsite.com ([209.17.115.48]:42855 "EHLO
	atl4mhob10.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754149Ab3EIQBs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 9 May 2013 12:01:48 -0400
Received: from mailpod1.hostingplatform.com ([10.30.71.114])
	by atl4mhob10.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id r49G1lwj024554
	for <util-linux@vger.kernel.org>; Thu, 9 May 2013 12:01:47 -0400
Message-ID: <518BC86D.2050702@chinilu.com>
Date: Thu, 09 May 2013 09:01:49 -0700
From: George Mitchell <george@chinilu.com>
Reply-To: george@chinilu.com
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: umount and findmnt commands not working with btrfs labels ...
References: <51882EA5.9080805@chinilu.com> <20130507094835.GB7086@x2.net.home> <51891448.5010804@chinilu.com> <20130509094226.GD17527@x2.net.home>
In-Reply-To: <20130509094226.GD17527@x2.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 05/09/2013 02:42 AM, Karel Zak wrote:
> On Tue, May 07, 2013 at 07:48:40AM -0700, George Mitchell wrote:
>> problem.  Is there a different debug statement I can use with findmnt?  What
>   LIBMOUNT_DEBUG=  for libmount
>   LIBBLKID_DEBUG=  for libblkid
>
>   We usually use /dev/disk/by-label and by-uuid/ to convert LABELs and
>   UUIDs to device names. These symlinks are maintained by udevd and
>   created according to result from
>
>     blkid -o udev -p <device>
>
>   the duplicate LABELs are ignored, there is only one LABEL of course.
>
>> fix or whether I will need to redo this with each reboot?  Also you did your
>> testing with a simple one partition btrfs volume.  My system involves up to
>   I had two independent partitions, each initialized by mkfs.btrfs.
>
>> five partitions in a single RAID 1 volume.  My boot volume is spread over
>> two partitions.  I am wondering if that could have something to do with it?
>> In any case, here is what I come up with using the same debug prefix with
>> findmnt.
>   Ah, do you mean btrfs raid? For example:
>
>     mkfs.btrfs --data raid1 --label FOO /dev/sdd1 /dev/sdd2
>
>   then the LABEL and UUID is really duplicate.
>
>
>   Anyway, the right way how to umount any filesystem is to specify the
>   filesystem by mountpoint, for example
>
>     umount /mnt
>
>   this is the way how Linux umount(2) syscall works, because everything
>   else is unreliable. Don't forget that you can mount the same filesystem
>   on more places and sometimes filesystem != device (e.g. btrfs), etc.
>
>   The umount-by-device is marked in the umount(8) man page as obsolete.
>   It seems I have to add a note about RAIDs too.
>
>> Using findmnt on MAGEIA3BTR-BOOT produces the following.  It appears to find
>> the mount point and then print the result:
>>
>> [root@localhost ghmitch]# LIBMOUNT_DEBUG=0xffff findmnt
>> LABEL=MAGEIA3BTR-BOOT
> [...]
>> However, when I do the same operation with MAGEIA3BTR, it DOES seem to find
>> the mount point (4814: libmount:    CACHE: [0x861c8a0]: add entry [ 1]
>> (tag): /dev/sdd1: LABEL).  The problem is, that is NOT the mount point.  The
>> mount point is /dev/sde1.
>   It seems that we need a note about duplicate LABELs to the man page ;-)
>
>   Note, for Linux RAID (mdadm(8)) we're able to detect that the
>   filesystem is within a raid member device (e.g. /dev/sda<N>) and the
>   device is reported as RAID member, the filesystem is ignored. The
>   filesystem is visible only on the final raid device (e.g /dev/md0).
>
>   It means that the duplicate filesystems (RAID1 members) are invisible.
>
>
>   I guess something like this is unnecessary for btrfs, because you can
>   mount arbitrary btrfs raid member (device) as btrfs kernel code is
>   able to find the next raid members and compose the final array.
>
>> Here is my blkid which will give you an overview of the partitions involved.
>> NOTE that with btrfs there are often multiple partitions with the same LABEL
>> and UUID, but only ONE of those will be the mount point and that mount point
>> can change at any time to one of the OTHER partitions sharing the same
>> label.  If umount OR findmnt happen to get the wrong mountpoint even with
>> the right label, things are not going to work out:
>   So I don't see a bug. All what we need is to more explicitly explain
>   to users that conversion from <device|uuid|label> to <mountpoint> is
>   not reliable, because the same device could be mounted on more places
>   or the mountpoint could be connected to more devices.
>
>> /dev/sda5: LABEL="MAGEIA3BTR-BOOT" UUID="63f13151-dd34-45e1-b40d-7ed7d0d0ec4a" UUID_SUB="978f5c02-5e11-4df4-8f72-4ff6d09e58ff" TYPE="btrfs"
>> /dev/sdb5: LABEL="MAGEIA3BTR-BOOT" UUID="63f13151-dd34-45e1-b40d-7ed7d0d0ec4a" UUID_SUB="0587a676-8bad-4d61-a8af-0e262d997ba7" TYPE="btrfs"
>   Yes, I see.
>
>      Karel
>
>
Karel,  Your answer left me really frustrated, but after rethinking the 
whole thing, I am left wondering if this whole issue, including the 
broader issue of what should appear on the mount table in the first 
place, would be better addressed by the btrfs group simply abstracting 
the mount point like software raid has always done and handling all the 
details internally within btrfs.  I already have seen applications that 
didn't understand btrfs partitions were in use and bad things could 
result from that.  It would be nice if btrfs would just lock all of 
these partitions out and represent them collectively to the broader 
system as /dev/mntX or whatever.  That would surely greatly simplify 
things for everybody.  I am going broach that idea on the btrfs list.  
Thanks so much for taking the time to discuss this with me.  It is much 
appreciated even though at the time I was not so happy with some of your 
answers.  - George
