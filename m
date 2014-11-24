Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35362 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752225AbaKXMZd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 24 Nov 2014 07:25:33 -0500
Date: Mon, 24 Nov 2014 13:25:17 +0100 (CET)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
To: Lutz Vieweg <lvml@5t9.de>
cc: linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: fstrim on newly created filesystem tries to discard data beyond
 the last sector of a device
In-Reply-To: <m4nrjt$ghs$1@ger.gmane.org>
Message-ID: <alpine.LFD.2.00.1411241259280.10657@localhost.localdomain>
References: <m3qnrg$5gc$1@ger.gmane.org> <m4f77a$ivg$1@ger.gmane.org> <m4nrjt$ghs$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, 21 Nov 2014, Lutz Vieweg wrote:

> Date: Fri, 21 Nov 2014 18:09:17 +0100
> From: Lutz Vieweg <lvml@5t9.de>
> To: linux-fsdevel@vger.kernel.org
> Cc: util-linux@vger.kernel.org, linux-xfs@oss.sgi.com
> Subject: fstrim on newly created filesystem tries to discard data beyond the
>     last sector of a device
> 
> I'm experiencing a 100% reproduceable misbehaviour of
> fstrim, which seems to put data integrity on stake:
> 
> Whenever I use "fstrim" on a just newly "mkfs.xfs"ed
> filesystem on a newly installed SSD (Crucial_CT1024M550SSD1,
> firmware MU01), I get (after some activity on the device)
> this error message:
> > fitrim ioctl failed: input/output error
> 
> Looking into the dmesg output reveals:
> > [1039455.530947] sd 0:0:1:0: [sdb]
> > [1039455.533192] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> > [1039455.535369] sd 0:0:1:0: [sdb]
> > [1039455.537521] Sense Key : Illegal Request [current]
> > [1039455.539684] Info fld=0x772cdab0
> > [1039455.541802] sd 0:0:1:0: [sdb]
> > [1039455.543877] Add. Sense: Logical block address out of range
> > [1039455.545966] sd 0:0:1:0: [sdb] CDB:
> > [1039455.548008] Unmap/Read sub-channel: 42 00 00 00 00 00 00 00 18 00
> > [1039455.550080] end_request: critical target error, dev sdb, sector
> 1999428272

This is very odd. So the file system will send discard requests for
the free data ranges of the file system (not outside), but there
might be a bug somewhere in there, however I've never seen it so
far with any SSD, or other discard capable devices.

Can you please try to reproduce the problem with the loop device ?

# truncate -s1T /path/to/new/file
# losetup --show -f /path/to/new/file
(this will print out the new loop device for example /dev/loop0)

# mkfs.ext4 /dev/loop0
# mount /dev/loop0 /mount/point
# fstrim -v /mount/point

Can you see any errors or will it succeed ?

Now another thing to try is rule out the file system entirely. Can
you try to run blkdiscard on the ssd device directly ?

# blkdiscard /dev/sdb
# sync
# blkdiscard /dev/sdb

Why twice ? Because I've seen the devices behaving weirdly after it
receives bunch of discard commands and mkfs itself will attempt to
discard the device before it creates the file system on top of it.

Mentioning that, can you try to reproduce you problem with turning
mkfs discard off ?

mkfs.ext4 -E nodiscard ...
mkfs.xfs -K ...

Does it make any difference ?

> 
> (I bought 4 of the same SSD model, and the error occurs the same with
> the other exemplars, so I can assume this is not some hardware issue.)

So this might very well be a firmware issue because you have 4
identical devices.

Now looking at the sector that seems to be "out of range" seems to
be actually well in range of the file system. From the mkfs.xfs
output I can see that the file system has 250051158 blocks of 4096
Bytes which is 1024209543168 Bytes. Now the sector mentioned in that
error output is 1999428272 which is (1999428272 * 512 =
1023707275264) which is in range of the file system. According the
data from /proc/partitions it is also true for the entire device.

I can see that the device reports 4096 physical sector size so it
might be that there is a bug regarding 4k physical sector size
somewhere in block layer or a driver ?

> 
> The "Logical block address out of range" error says no less than that
> fstrim issued a fitrim ioctl that was asking the device to discard the
> content of sectors well beyond the boundaries of the device. If it
> wasn't for the "end of the physical device" making the SSD return an error,
> if instead there was another partition behind a filesystem to trim, then
> valuable, live data would have been discarded.
> 
> I've tried the same with ext4 instead of XFS, and the very same
> error occurs, just with a slightly different sector being named
> by the dmesg error output:
> > [710565.947608] end_request: critical target error, dev sdb, sector
> 2000158720
> 
> 
> Here's a list of properties of the system that might be
> relevant for the issue:
> 
> According to smartctl, the capacity of this SSD is:
> > User Capacity:    1,024,209,543,168 bytes [1.02 TB]
> > Sector Sizes:     512 bytes logical, 4096 bytes physical
> 
> And cat /proc/partitions tells:
> >    major minor  #blocks  name
> >    8       16 1000204632 sdb
> 
> Kernel is mainline linux-3.17.1
> 
> fstrim --version says:
> > fstrim from util-linux 2.23.2
> 
> Distribution is CentOS 7.
> 
> mkfs.xfs -V says:
> > mkfs.xfs version 3.2.0-alpha2
> rpm -qif /usr/sbin/mkfs.xfs
> > Name        : xfsprogs
> > Version     : 3.2.0
> > Release     : 0.10.alpha2.el7
> 
> (Should I be concerned that CentOS 7 comes with a mkfs.xfs
> version having an -alpha2 suffix?)
> 
> The filesystem is created with:
> > mkfs.xfs -l lazy-count=1 -f /dev/sdb
> > meta-data=/dev/sdb               isize=256    agcount=4, agsize=62512790
> > blks
> >          =                       sectsz=4096  attr=2, projid32bit=1
> >          =                       crc=0
> > data     =                       bsize=4096   blocks=250051158, imaxpct=25
> >          =                       sunit=0      swidth=0 blks
> > naming   =version 2              bsize=4096   ascii-ci=0 ftype=0
> > log      =internal log           bsize=4096   blocks=122095, version=2
> >          =                       sectsz=4096  sunit=1 blks, lazy-count=1
> > realtime =none                   extsz=4096   blocks=0, rtextents=0
> 
> The filesystem is mounted with:
> > mount /dev/sdb /mnt/PFexp1
> 
> fstrim was started this way:
> > > fstrim -v /mnt/PFexp1
> > fstrim: /mnt/PFexp1: FITRIM ioctl failed: Input/output error
> 
> The relevant strace output of the above fstrim command:
> > stat("/mnt/PFexp1", {st_mode=S_IFDIR|0755, st_size=6, ...}) = 0
> > open("/mnt/PFexp1", O_RDONLY)           = 3
> > ioctl(3, FITRIM, 0x7fff0733a4c0)        = -1 EIO (Input/output error)
> 
> Any idea why that happenes?
> Do we need to fear a loss of data when using fstrim in general?

No you definitely should not be. While some bugs might appear we
have extensive test cases to catch that. In fact while there has
been several bugs in the file system fstrim implementation AFAIK it
was never data loss scenario. And so far I do not believe this is
the case here either, but we'll have to investigate first.

Thanks!
-Lukas

> 
> Regards,
> 
> Lutz Vieweg
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
