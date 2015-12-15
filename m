Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52519 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933241AbbLONd2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Dec 2015 08:33:28 -0500
Date: Tue, 15 Dec 2015 14:33:26 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: sfdisk, re-eading partition table fails
Message-ID: <20151215133326.GH2353@ws.net.home>
References: <201512141311.59328.sweet_f_a@gmx.de>
 <20151215102408.GG2353@ws.net.home>
 <201512151326.33633.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201512151326.33633.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 15, 2015 at 01:26:33PM +0100, Ruediger Meier wrote:
> > > Seems that the problem is because of the first BLKRRPART ioctl call
> > > in sfdisk.c function is_device_used(). Maybe it cause udev or
> > > whatever to open the device and then the real BLKRRPART in
> > > write_changes() fails.
> >
> > but the device has to be already partitioned, on disk without
> > partitions BLKRRPART (and is_device_used()) does not generate any
> > events (try "udevadm monitor").
> 
> Yes I had checked that. This explains why only the resize/move/etc
> tests fail.
> 
> > > Removing the first BLKRRPART ioctl (or sleeping about 50ms after
> > > the first one) "fixes" the issue.
> >
> > The is_device_used() in the sfdisk is nothing elegant,
> 
> But how else could we check whether a device is in use?

maybe open(O_EXCL), but it works for the device only. The BLKRRPART
ioctl fails when any partition is also in use (mounted or so).

And note that the current code in sfdisk does not provide any
exclusive access to the disk, it just verifies that the disk is not
used in time you call BLKRRPART.

For fdisk and sfdisk we do not check if device is in use.

We already use libudev in util-liux, maybe add "udevadm monitor"
functionality to sfdisk is not so bad idea, or (ideally) we need 
something less aggressive than BLKRRPART.

> > maybe 
> > we can use --noreread sfdisk command line option in the tests.
> 
> I have such patch already for testing.
> 
> > Anyway, it would be nice to have some in-sfdisk solution, because our
> > users who use fdisk in scripts may be affected by the same problem.
>
> Yes. Now since I know about these problems I find the default case
> without --no-reread a bit dangerous. After using sfdisk one should
> always check if re-reading was successful before doing things with an
> outdated partition table. Some weeks ago I've made such a mistake and
> it was real disaster.
> 
> An option like --return-error-if-re-read-fails could be useful. Or do
> we have a command with tells us whether kernel partition table
> matches the disk? 

This is interesting idea, it would be nice to have command to compare
stuff from /sys ("size" and "start" device attributes) with on-disk
partition table. Not sure if something like this belongs to fdisk-like 
program, maybe "partx" would be better for this functionality.

> BTW what happend to
>  -R, --re-read     make the kernel reread the partition table
> ?

 we have "blockdev --rereadpt"

> Also IMO interesting, this commit message from GNU parted:
> ------------- 
> commit 1223b9fc07859cb619c80dc057bd05458f9b5669
> Author: Jim Meyering <meyering@redhat.com>
> Date:   Fri Apr 30 11:45:51 2010 +0200
> 
>     libparted: remove now-worse-than-useless _kernel_reread_part_table
> 
>     Now that we're using BLKPG properly, there's no point in using the
>     less-functional BLKRRPART ioctl to make the kernel reread the partition
>     table.
>     More importantly, this function would fail when any partition is in
>     use, in spite of our having carefully vetted them via BLKPG ioctls.
>     * libparted/arch/linux.c (_kernel_reread_part_table): Remove function.
>     (linux_disk_commit): Don't call it.
> -------------
> 
> I think partprobe can re-read a partition table partly (if not all affected
> partitions are in use.)

Yes, parted tries to be smart and it updates only affected partitions.

I guess there is still many situations when it's good idea to call
BLKRRPART, for example if you change in-PT stored partition attributes
(UUID, flags, etc.), reorder partitions, etc. The BLKPG ioctls has
been introduced to support partitions add/del/resize.

But I think BLKRRPART-after-write is not so big problem for sfdisk.
The problem is the initial BLKRRPART.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
