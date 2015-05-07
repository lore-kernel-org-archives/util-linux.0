Return-Path: linux-kernel-owner@vger.kernel.org
Date: Thu, 7 May 2015 00:24:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@canonical.com>
Cc: linux-kernel@vger.kernel.org, Dave Kleikamp <dave.kleikamp@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Zach Brown <zab@zabbo.net>,
        Christoph Hellwig <hch@infradead.org>,
        Maxim Patlasov <mpatlasov@parallels.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH v3 4/4] block: loop: support DIO & AIO
Message-ID: <20150507072400.GC7595@infradead.org>
References: <1430932106-17451-1-git-send-email-ming.lei@canonical.com>
 <1430932106-17451-5-git-send-email-ming.lei@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430932106-17451-5-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> @@ -441,6 +500,12 @@ static void do_loop_switch(struct loop_device *lo, struct switch_request *p)
>  		mapping->host->i_bdev->bd_block_size : PAGE_SIZE;
>  	lo->old_gfp_mask = mapping_gfp_mask(mapping);
>  	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
> +
> +	lo->support_dio = mapping->a_ops && mapping->a_ops->direct_IO;
> +	if (lo->support_dio)
> +		lo->use_aio = true;
> +	else
> +		lo->use_aio = false;

We need an explicit userspace op-in for this.  For one direct I/O can't
handle sub-sector size access and people use the loop device as a
workaround for that.  Second this doesn't give anyone seeing negative
results from aio a way to disable it easily.

It think the best way is to require a setup time flag, but enable it to
on in losetup versions that know about it.

> @@ -761,6 +826,13 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>  	if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
>  		blk_queue_flush(lo->lo_queue, REQ_FLUSH);
>  
> +	/* use aio if it is possible */
> +	lo->support_dio = mapping->a_ops && mapping->a_ops->direct_IO;
> +	if (lo->support_dio)
> +		lo->use_aio = true;
> +	else
> +		lo->use_aio = false;

Please always factor out checks like this insted of duplicating them.

