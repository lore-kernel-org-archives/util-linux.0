Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ig0-f177.google.com ([209.85.213.177]:32938 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbbKJGFk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 10 Nov 2015 01:05:40 -0500
Received: by igvi2 with SMTP id i2so91147964igv.0
        for <util-linux@vger.kernel.org>; Mon, 09 Nov 2015 22:05:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151109114613.GV19508@ws.net.home>
References: <1446856818-26532-1-git-send-email-tom.leiming@gmail.com>
	<20151109102931.GU19508@ws.net.home>
	<CACVXFVOGZzGtpPBbVfYDd1=3rcZ__x-ggkvtQMx9T0+VJYfSrw@mail.gmail.com>
	<20151109114613.GV19508@ws.net.home>
Date: Tue, 10 Nov 2015 14:05:39 +0800
Message-ID: <CACVXFVPRBwe3H101=cUVG6CsDT3z-WvAX_wOanaNa+HbTdfoUw@mail.gmail.com>
Subject: Re: [PATCH 0/2] losetup: support direct-IO to backing file
From: Ming Lei <tom.leiming@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 9, 2015 at 7:46 PM, Karel Zak <kzak@redhat.com> wrote:
> On Mon, Nov 09, 2015 at 07:29:21PM +0800, Ming Lei wrote:
>> > It's fine to use --direct-io as toggle, but it would be nice to
>> > support it also when initialize the device.
>>
>> OK, looks a good idea, but we still need to support the standalone
>> command for direct-io for the case of 'mount -o loop'.
>
> Sure, I understand this use-case. I have talked bout loop_set_fd(),
> maybe all we need is:
>
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 423f4ca..22642a0 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -925,7 +925,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>
>         set_device_ro(bdev, (lo_flags & LO_FLAGS_READ_ONLY) != 0);
>
> -       lo->use_dio = false;
> +       lo->use_dio = (lo_flags & LO_FLAGS_DIRECT_IO);
>         lo->lo_blocksize = lo_blocksize;
>         lo->lo_device = bdev;
>         lo->lo_flags = lo_flags;

I don't think this change is doable because lo_flags is always started
as zero from loop_set_fd().

>
>
> then we can a little bit modify your losetup.c patches and support
> --direct-io also for A_CREATE.

That makes sense, and I will submit V1 to support creating one device
with direct io.

thanks,
Ming

>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Ming Lei
