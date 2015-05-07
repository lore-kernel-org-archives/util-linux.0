Return-Path: util-linux-owner@vger.kernel.org
Received: from youngberry.canonical.com ([91.189.89.112]:49080 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbbEGMcm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 7 May 2015 08:32:42 -0400
MIME-Version: 1.0
In-Reply-To: <20150507072400.GC7595@infradead.org>
References: <1430932106-17451-1-git-send-email-ming.lei@canonical.com>
	<1430932106-17451-5-git-send-email-ming.lei@canonical.com>
	<20150507072400.GC7595@infradead.org>
Date: Thu, 7 May 2015 20:32:39 +0800
Message-ID: <CACVXFVMN9EuPP+m0HWjatrXKufB4qokk7qRYQjhEz87ZjL53iQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] block: loop: support DIO & AIO
From: Ming Lei <ming.lei@canonical.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Kleikamp <dave.kleikamp@oracle.com>, Jens Axboe <axboe@kernel.dk>,
        Zach Brown <zab@zabbo.net>, Maxim Patlasov <mpatlasov@parallels.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 7, 2015 at 3:24 PM, Christoph Hellwig <hch@infradead.org> wrote:
>> @@ -441,6 +500,12 @@ static void do_loop_switch(struct loop_device *lo, struct switch_request *p)
>>               mapping->host->i_bdev->bd_block_size : PAGE_SIZE;
>>       lo->old_gfp_mask = mapping_gfp_mask(mapping);
>>       mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
>> +
>> +     lo->support_dio = mapping->a_ops && mapping->a_ops->direct_IO;
>> +     if (lo->support_dio)
>> +             lo->use_aio = true;
>> +     else
>> +             lo->use_aio = false;
>
> We need an explicit userspace op-in for this.  For one direct I/O can't

Actually this patch is one simplified version, and my old version
has exported two sysfs files(use_aio, use_dio) which can control
if direct IO or AIO is used but only AIO is enabled if DIO is set. Finally
I think it isn't necessary because dio/aio works well from the tests,
and userspace shouldn't care if it is AIO or not if the performance
is good.

> handle sub-sector size access and people use the loop device as a
> workaround for that.

Yes, user can do that, could you explain a bit what the problem is?

> Second this doesn't give anyone seeing negative
> results from aio a way to disable it easily.

If there is the requirement, we can export the control interface via
sysfs files easily, but I suggest to not do that from the start for sake
of simplicity.

>
> It think the best way is to require a setup time flag, but enable it to
> on in losetup versions that know about it.

Could you explain a bit why we need losetup involved?

>
>> @@ -761,6 +826,13 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>>       if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
>>               blk_queue_flush(lo->lo_queue, REQ_FLUSH);
>>
>> +     /* use aio if it is possible */
>> +     lo->support_dio = mapping->a_ops && mapping->a_ops->direct_IO;
>> +     if (lo->support_dio)
>> +             lo->use_aio = true;
>> +     else
>> +             lo->use_aio = false;
>
> Please always factor out checks like this insted of duplicating them.

OK, will do that.


Thanks,
Ming
