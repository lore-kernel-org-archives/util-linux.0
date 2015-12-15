Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:56518 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753736AbbLOM0o (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Dec 2015 07:26:44 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: sfdisk, re-eading partition table fails
Date: Tue, 15 Dec 2015 13:26:33 +0100
Cc: util-linux@vger.kernel.org
References: <201512141311.59328.sweet_f_a@gmx.de> <20151215102408.GG2353@ws.net.home>
In-Reply-To: <20151215102408.GG2353@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201512151326.33633.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 15 December 2015, Karel Zak wrote:
> On Mon, Dec 14, 2015 at 01:11:59PM +0100, Ruediger Meier wrote:
> > our test suite shows that many sfdisk tests fail sometimes to
> > "Re-read partition table" at the end. I was able to find some
> > systems where I could re-produce the problem using the script
> > below.
>
> Yes, the problem is probably udev, and "udevadm settle" is not always
> enough.

I don't see any problem with "udevadm settle" between our sfdisk
commands. Looks like we would need "udevadm settle" within sfdisk.

> > Seems that the problem is because of the first BLKRRPART ioctl call
> > in sfdisk.c function is_device_used(). Maybe it cause udev or
> > whatever to open the device and then the real BLKRRPART in
> > write_changes() fails.
>
> but the device has to be already partitioned, on disk without
> partitions BLKRRPART (and is_device_used()) does not generate any
> events (try "udevadm monitor").

Yes I had checked that. This explains why only the resize/move/etc
tests fail.

> > Removing the first BLKRRPART ioctl (or sleeping about 50ms after
> > the first one) "fixes" the issue.
>
> The is_device_used() in the sfdisk is nothing elegant,

But how else could we check whether a device is in use?

> maybe 
> we can use --noreread sfdisk command line option in the tests.

I have such patch already for testing.

> Anyway, it would be nice to have some in-sfdisk solution, because our
> users who use fdisk in scripts may be affected by the same problem.

Yes. Now since I know about these problems I find the default case
without --no-reread a bit dangerous. After using sfdisk one should
always check if re-reading was successful before doing things with an
outdated partition table. Some weeks ago I've made such a mistake and
it was real disaster.

An option like --return-error-if-re-read-fails could be useful. Or do
we have a command with tells us whether kernel partition table
matches the disk? 

BTW what happend to
 -R, --re-read     make the kernel reread the partition table
?

Also IMO interesting, this commit message from GNU parted:
------------- 
commit 1223b9fc07859cb619c80dc057bd05458f9b5669
Author: Jim Meyering <meyering@redhat.com>
Date:   Fri Apr 30 11:45:51 2010 +0200

    libparted: remove now-worse-than-useless _kernel_reread_part_table

    Now that we're using BLKPG properly, there's no point in using the
    less-functional BLKRRPART ioctl to make the kernel reread the partition
    table.
    More importantly, this function would fail when any partition is in
    use, in spite of our having carefully vetted them via BLKPG ioctls.
    * libparted/arch/linux.c (_kernel_reread_part_table): Remove function.
    (linux_disk_commit): Don't call it.
-------------

I think partprobe can re-read a partition table partly (if not all affected
partitions are in use.)


cu,
Rudi


