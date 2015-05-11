Return-Path: util-linux-owner@vger.kernel.org
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:13131 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752021AbbEKB3L (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 10 May 2015 21:29:11 -0400
Date: Mon, 11 May 2015 11:28:35 +1000
From: Dave Chinner <david@fromorbit.com>
To: Ming Lei <ming.lei@canonical.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Kleikamp <dave.kleikamp@oracle.com>, Jens Axboe <axboe@kernel.dk>,
        Zach Brown <zab@zabbo.net>, Maxim Patlasov <mpatlasov@parallels.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH v3 4/4] block: loop: support DIO & AIO
Message-ID: <20150511012835.GA15721@dastard>
References: <1430932106-17451-1-git-send-email-ming.lei@canonical.com>
 <1430932106-17451-5-git-send-email-ming.lei@canonical.com>
 <20150507072400.GC7595@infradead.org>
 <CACVXFVMN9EuPP+m0HWjatrXKufB4qokk7qRYQjhEz87ZjL53iQ@mail.gmail.com>
 <20150507222050.GA16689@dastard>
 <CACVXFVPn_Dys-TNG05taDo0bjuHOi3nL=6NhrNxVzDAZQXR+0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVPn_Dys-TNG05taDo0bjuHOi3nL=6NhrNxVzDAZQXR+0g@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, May 08, 2015 at 12:09:04PM +0800, Ming Lei wrote:
> On Fri, May 8, 2015 at 6:20 AM, Dave Chinner <david@fromorbit.com> wrote:
> > On Thu, May 07, 2015 at 08:32:39PM +0800, Ming Lei wrote:
> >> On Thu, May 7, 2015 at 3:24 PM, Christoph Hellwig <hch@infradead.org> wrote:
> >> >> @@ -441,6 +500,12 @@ static void do_loop_switch(struct loop_device *lo, struct switch_request *p)
> >> >>               mapping->host->i_bdev->bd_block_size : PAGE_SIZE;
> >> >>       lo->old_gfp_mask = mapping_gfp_mask(mapping);
> >> >>       mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
> >> >> +
> >> >> +     lo->support_dio = mapping->a_ops && mapping->a_ops->direct_IO;
> >> >> +     if (lo->support_dio)
> >> >> +             lo->use_aio = true;
> >> >> +     else
> >> >> +             lo->use_aio = false;
> >> >
> >> > We need an explicit userspace op-in for this.  For one direct I/O can't
> >>
> >> Actually this patch is one simplified version, and my old version
> >> has exported two sysfs files(use_aio, use_dio) which can control
> >> if direct IO or AIO is used but only AIO is enabled if DIO is set. Finally
> >> I think it isn't necessary because dio/aio works well from the tests,
> >> and userspace shouldn't care if it is AIO or not if the performance
> >> is good.
> >
> > Performance won't always be good.
> >
> > It looks to me that this has an unbound queue depth for AIO.  What
...
> Loop has been converted to blk-mq, and the current queue depth is
> 128, so there isn't the problem you worried about, is there?

Oh, OK, that's new. I didn't realise this conversion had already
been done.

> >> > handle sub-sector size access and people use the loop device as a
> >> > workaround for that.
> >>
> >> Yes, user can do that, could you explain a bit what the problem is?
> >
> > I have a 4k sector backing device and a 512 byte sector filesystem
> > image. I can't do 512 byte direct IO to the filesystem image, so I
> > can't run tools that handle fs images in files using direct Io on
> > that file. Create a loop device with the filesystem image, and now I
> > can do 512 byte direct IO to the filesystem image, because all that
> > direct IO to the filesystem image is now buffered by the loop
> > device.
> >
> > If the loop device does direct io in this situation, the backing
> > filesystem rejects direct IO from the loop device because it is not
> > sector (4k) sized/aligned. User now swears, shouts and curses you
> > from afar.
> 
> Yes, it is one problem, but looks it can be addressed by adding the
> following in loop_set_fd():
> 
>      if (inode->i_sb->s_bdev)
>             blk_queue_logical_block_size(lo->lo_queue,
>                                            bdev_io_min(inode->i_sb->s_bdev));

How does that address the problem of not being able to do 512 byte
IOs to a loop device that does direct IO to a file hosted on a 4k
sector filesystem?

AFAICT, in that case bdev_io_min(inode->i_sb->s_bdev) will return 4k
because it comes from the backing filesystem, and so the minimum IO
size is still going to be 4k for such configurations...

> > DIO and AIO behaviour needs to be configurable through losetup, and
> > most definitely not the default behaviour.
> 
> Could you share if there are other reasons for making it configurable via
> losetup suppose the above issues can be fixed?

It's not about "fixing issues" - losetup is the tool we use for
configuring loop device behaviour. If a user wants to crete a loop
device with a specific configuration, then that is the tool they
use. You add direct IO for the loop device, that needs to be
configurable because switching to direct IO will significantly
change performance for many workloads loops devices are used for.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
