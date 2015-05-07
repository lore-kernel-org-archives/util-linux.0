Return-Path: linux-kernel-owner@vger.kernel.org
Date: Fri, 8 May 2015 08:20:50 +1000
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
Message-ID: <20150507222050.GA16689@dastard>
References: <1430932106-17451-1-git-send-email-ming.lei@canonical.com>
 <1430932106-17451-5-git-send-email-ming.lei@canonical.com>
 <20150507072400.GC7595@infradead.org>
 <CACVXFVMN9EuPP+m0HWjatrXKufB4qokk7qRYQjhEz87ZjL53iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVMN9EuPP+m0HWjatrXKufB4qokk7qRYQjhEz87ZjL53iQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 07, 2015 at 08:32:39PM +0800, Ming Lei wrote:
> On Thu, May 7, 2015 at 3:24 PM, Christoph Hellwig <hch@infradead.org> wrote:
> >> @@ -441,6 +500,12 @@ static void do_loop_switch(struct loop_device *lo, struct switch_request *p)
> >>               mapping->host->i_bdev->bd_block_size : PAGE_SIZE;
> >>       lo->old_gfp_mask = mapping_gfp_mask(mapping);
> >>       mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
> >> +
> >> +     lo->support_dio = mapping->a_ops && mapping->a_ops->direct_IO;
> >> +     if (lo->support_dio)
> >> +             lo->use_aio = true;
> >> +     else
> >> +             lo->use_aio = false;
> >
> > We need an explicit userspace op-in for this.  For one direct I/O can't
> 
> Actually this patch is one simplified version, and my old version
> has exported two sysfs files(use_aio, use_dio) which can control
> if direct IO or AIO is used but only AIO is enabled if DIO is set. Finally
> I think it isn't necessary because dio/aio works well from the tests,
> and userspace shouldn't care if it is AIO or not if the performance
> is good.

Performance won't always be good.

It looks to me that this has an unbound queue depth for AIO.  What
throttles the amount of IO userspace can throw at an aio-enabled
loop device? If it's unbound, then userspace can throw gigabytes of
random write at the loop device and rather thanbe throttled at 128
outstanding IOs, the queue will just keep growing. That will have
adverse affects on dirty memory throttling, memory reclaim
algorithms, read and write latency, etc.

I suspect that if we are going to make the loop device use AIO, it
will needs a proper queue depth limit (i.e.
/sys/block/loop0/queue/nr_requests) enforced to avoid this sort of
problem...

> > handle sub-sector size access and people use the loop device as a
> > workaround for that.
> 
> Yes, user can do that, could you explain a bit what the problem is?

I have a 4k sector backing device and a 512 byte sector filesystem
image. I can't do 512 byte direct IO to the filesystem image, so I
can't run tools that handle fs images in files using direct Io on
that file. Create a loop device with the filesystem image, and now I
can do 512 byte direct IO to the filesystem image, because all that
direct IO to the filesystem image is now buffered by the loop
device.

If the loop device does direct io in this situation, the backing
filesystem rejects direct IO from the loop device because it is not
sector (4k) sized/aligned. User now swears, shouts and curses you
from afar.

DIO and AIO behaviour needs to be configurable through losetup, and
most definitely not the default behaviour.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
