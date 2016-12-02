Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755829AbcLBMTG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 2 Dec 2016 07:19:06 -0500
Date: Fri, 2 Dec 2016 13:19:04 +0100
From: Karel Zak <kzak@redhat.com>
To: Constantine Kharlamov <hi-angel@ya.ru>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: sfdisk: -X option doesn't work
Message-ID: <20161202121904.gqkjkhwg2tsemtry@ws.net.home>
References: <5303721479553110@web15g.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5303721479553110@web15g.yandex.ru>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Nov 19, 2016 at 01:58:30PM +0300, Constantine Kharlamov wrote:
> I've a disk that been GPT-formatted before, but now there's just MBR:
> 
> 	$ sudo sfdisk -l /dev/sdc     
> 	Disk /dev/sdc: 14.9 GiB, 16025444352 bytes, 31299696 sectors
> 	Units: sectors of 1 * 512 = 512 bytes
> 	Sector size (logical/physical): 512 bytes / 512 bytes
> 	I/O size (minimum/optimal): 512 bytes / 512 bytes
> 	Disklabel type: dos
> 	Disk identifier: 0x79215d34
> 
> 	Device     Boot Start      End  Sectors  Size Id Type
> 	/dev/sdc1        2048 31299695 31297648 14.9G 83 Linux
> 
> Fine, but magically, both "/dev/disk/by-label/" and lsblk shows
> names/labels that been there before the disk reformatted into MBR!

/dev/disk/by-label, LABEL and UUID are *filesystem* identifiers. The
filesystem (partition content) and partition table are two independent
things.

If the partition (after conversion from GPT to MBR) starts still on
the same offset that the filesystem is still valid and identifiers
still visible for the system.

> 
> 	$ sudo lsblk -o name,mountpoint,label,size,uuid /dev/sdc
> 	NAME   MOUNTPOINT LABEL               SIZE UUID
> 	sdc               Ubuntu 15.10 amd64 14.9G 2015-10-21-16-17-40-00
> 	└─sdc1            Ubuntu 15.10 amd64 14.9G 502229b0-6d02-46ee-8fd1-b3321f11e53f
> 
> It causes errors with grub-install like "Attempting to install GRUB
> to a disk with multiple partition labels.  This is not supported
> yet..". 

You can try wipefs(8) to see what is on the sdc and sdc1. (BTW, the LABEL
for sdc seems strange.)

And you can use wipefs to remove obsolete GPT signature if there is
still for example backup GPT label. (Be careful, you can lost data on
the disk, don't use wipefs -a)

> So I want to just remove those names. But "sgdisk" sees that GPT
> table is invalid, and tries to reconstruct it from MBR, whilst I'd
> need to force it into thinking like it is valid, so that it see the
> damn names.
> 
> Thankfully, there's sfdisk with -X option:

-X overrides default (MBR) or the current label type when you create
a new partition table, it has no effect for --list.

fdisk provides --type <name> that forces the util to use (e.g. print)
specified label, for example:

  fdisk --list --type dos /dev/sdc

> 	$ sudo sfdisk -lX gpt /dev/sdc 
> 	Disk /dev/sdc: 14.9 GiB, 16025444352 bytes, 31299696 sectors
> 	Units: sectors of 1 * 512 = 512 bytes
> 	Sector size (logical/physical): 512 bytes / 512 bytes
> 	I/O size (minimum/optimal): 512 bytes / 512 bytes
> 	Disklabel type: dos
> 	Disk identifier: 0x79215d34
> 
> 	Device     Boot Start      End  Sectors  Size Id Type
> 	/dev/sdc1        2048 31299695 31297648 14.9G 83 Linux
> 
> It worked… Or not? "Disklabel" says "dos", and most importantly, I see no partition names.

It is not partition name, but filesystem identifier. sfdisk does not
list this stuff. (See cfdisk, it reads filesystem stuff.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
