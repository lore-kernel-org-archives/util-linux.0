Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47978 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961Ab3JRJgV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 18 Oct 2013 05:36:21 -0400
Date: Fri, 18 Oct 2013 11:36:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: blkid doesn't find lvm pv when boot loader installed
Message-ID: <20131018093617.GC15115@x2.net.home>
References: <525821B6.9010304@ubuntu.com>
 <20131014135953.GG28914@x2.net.home>
 <525C0743.9020706@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <525C0743.9020706@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 14, 2013 at 11:01:23AM -0400, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 10/14/2013 9:59 AM, Karel Zak wrote:
> > Yes, unfortunately this is currently unsupported scenario.
> > 
> > The libblkid checks for collision between LVM and
> > filesystems/partition tables to avoid very common situations when
> > users use whole-disks previously used by LVM in new setups with
> > partition tables.
> 
> Isn't mdadm in the same boat?  i.e. you have a partitioned single
> disk, and decided to turn it into a raid1.  Now the partition table is
> still there and valid, but should be ignored in favor of the raid
> superblock.

 Yes, and with raids it's more complicated because if the raid1
 superblock is at the end of the device and the raid device is partitioned
 then there is a partition table at the begin as well as raid
 superblock at the end and all is valid and wanted :-) 
 
 (So in these cases we have to parse PT and raid superblock to check
 if the PT is within raid or vice versa.. nasty.. fortunately the
 current Linux raid default is superblock at the begin of the device.)

> > So.. libblkid assumes that there is only LVM header within first
> > 8K of the device, because pvcreate wipes this area (try pvcreate
> > again and it will silently erase your grub!). If there is anything
> > else then the previously detected LVM is ignored.
> > 
> > Yes, it's really not perfect solution, but do we have any better 
> > solution? Maybe it would be enough to improve the blkid partition 
> > table parser to not interpret the boot loader with empty PT as a 
> > valid PT. Not sure.
> 
> I started thinking along those lines, but it doesn't cover the above
> mentioned raid1 case.

 libblkid cover both cases 

> I'm now leaning towards thinking that any partition tool that doesn't
> wipe the existing signatures is broken

 fdisk currently wipes the first sector only, the problem is that we
 have to somehow live with boot loaders or partitioned raids etc.
 
 IMHO it is more important to wipe devices in mkfs-like programs where
 anything else than the FS/LVM/etc is unexpected.

 Now when I'm thinking about it ... maybe it would be good idea to add
 to fdisk a warning to inform users that there is not only the new 
 partition table but also anything else.

> and that's what needs fixed
> rather than trying to work around it in blkid.

 Well, we don't control all the programs and the problem is that users
 have already partitioned/LVM disks with obsolete superblocks/PT for
 years, when we ported all the stuff to udev then it was visible and
 reported as regressions...

 BTW, libblkid provides API to wipe devices

       fd = open(devname, O_RDWR|O_CLOEXEC);
       blkid_probe_set_device(pr, fd, 0, 0);
 
       blkid_probe_enable_partitions(pr, 1);
       blkid_probe_enable_superblocks(pr, 1);
       blkid_probe_set_superblocks_flags(pr, BLKID_SUBLKS_MAGIC);
 
       while (blkid_do_probe(pr) == 0)
           blkid_do_wipe(pr, FALSE);
 
 
 ...to wipe all from the device, nice is that it removes only magic
 strings, so you don't lost data if you make a mistake (wipefs(8)
 backup the magic strings too).

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
