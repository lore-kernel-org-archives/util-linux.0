Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:44165 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755410AbaKURJf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 21 Nov 2014 12:09:35 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1Xrri9-0003Qz-Qp
	for util-linux@vger.kernel.org; Fri, 21 Nov 2014 18:09:33 +0100
Received: from barriere.frankfurter-softwarefabrik.de ([217.11.197.1])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 21 Nov 2014 18:09:33 +0100
Received: from lvml by barriere.frankfurter-softwarefabrik.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 21 Nov 2014 18:09:33 +0100
To: util-linux@vger.kernel.org
From: Lutz Vieweg <lvml@5t9.de>
Subject: fstrim on newly created filesystem tries to discard data beyond the
 last sector of a device
Date: Fri, 21 Nov 2014 18:09:17 +0100
Message-ID: <m4nrjt$ghs$1@ger.gmane.org>
References: <m3qnrg$5gc$1@ger.gmane.org> <m4f77a$ivg$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
In-Reply-To: <m4f77a$ivg$1@ger.gmane.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I'm experiencing a 100% reproduceable misbehaviour of
fstrim, which seems to put data integrity on stake:

Whenever I use "fstrim" on a just newly "mkfs.xfs"ed
filesystem on a newly installed SSD (Crucial_CT1024M550SSD1,
firmware MU01), I get (after some activity on the device)
this error message:
 > fitrim ioctl failed: input/output error

Looking into the dmesg output reveals:
 > [1039455.530947] sd 0:0:1:0: [sdb]
 > [1039455.533192] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
 > [1039455.535369] sd 0:0:1:0: [sdb]
 > [1039455.537521] Sense Key : Illegal Request [current]
 > [1039455.539684] Info fld=0x772cdab0
 > [1039455.541802] sd 0:0:1:0: [sdb]
 > [1039455.543877] Add. Sense: Logical block address out of range
 > [1039455.545966] sd 0:0:1:0: [sdb] CDB:
 > [1039455.548008] Unmap/Read sub-channel: 42 00 00 00 00 00 00 00 18 00
 > [1039455.550080] end_request: critical target error, dev sdb, sector 1999428272

(I bought 4 of the same SSD model, and the error occurs the same with
the other exemplars, so I can assume this is not some hardware issue.)

The "Logical block address out of range" error says no less than that
fstrim issued a fitrim ioctl that was asking the device to discard the
content of sectors well beyond the boundaries of the device. If it
wasn't for the "end of the physical device" making the SSD return an error,
if instead there was another partition behind a filesystem to trim, then
valuable, live data would have been discarded.

I've tried the same with ext4 instead of XFS, and the very same
error occurs, just with a slightly different sector being named
by the dmesg error output:
 > [710565.947608] end_request: critical target error, dev sdb, sector 2000158720


Here's a list of properties of the system that might be
relevant for the issue:

According to smartctl, the capacity of this SSD is:
 > User Capacity:    1,024,209,543,168 bytes [1.02 TB]
 > Sector Sizes:     512 bytes logical, 4096 bytes physical

And cat /proc/partitions tells:
 >    major minor  #blocks  name
 >    8       16 1000204632 sdb

Kernel is mainline linux-3.17.1

fstrim --version says:
 > fstrim from util-linux 2.23.2

Distribution is CentOS 7.

mkfs.xfs -V says:
 > mkfs.xfs version 3.2.0-alpha2
rpm -qif /usr/sbin/mkfs.xfs
> Name        : xfsprogs
> Version     : 3.2.0
> Release     : 0.10.alpha2.el7

(Should I be concerned that CentOS 7 comes with a mkfs.xfs
version having an -alpha2 suffix?)

The filesystem is created with:
> mkfs.xfs -l lazy-count=1 -f /dev/sdb
> meta-data=/dev/sdb               isize=256    agcount=4, agsize=62512790 blks
>          =                       sectsz=4096  attr=2, projid32bit=1
>          =                       crc=0
> data     =                       bsize=4096   blocks=250051158, imaxpct=25
>          =                       sunit=0      swidth=0 blks
> naming   =version 2              bsize=4096   ascii-ci=0 ftype=0
> log      =internal log           bsize=4096   blocks=122095, version=2
>          =                       sectsz=4096  sunit=1 blks, lazy-count=1
> realtime =none                   extsz=4096   blocks=0, rtextents=0

The filesystem is mounted with:
> mount /dev/sdb /mnt/PFexp1

fstrim was started this way:
> > fstrim -v /mnt/PFexp1
> fstrim: /mnt/PFexp1: FITRIM ioctl failed: Input/output error

The relevant strace output of the above fstrim command:
> stat("/mnt/PFexp1", {st_mode=S_IFDIR|0755, st_size=6, ...}) = 0
> open("/mnt/PFexp1", O_RDONLY)           = 3
> ioctl(3, FITRIM, 0x7fff0733a4c0)        = -1 EIO (Input/output error)

Any idea why that happenes?
Do we need to fear a loss of data when using fstrim in general?

Regards,

Lutz Vieweg

