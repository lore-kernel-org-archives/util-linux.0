Return-Path: tom.leiming@gmail.com
MIME-Version: 1.0
In-Reply-To: <20151110114004.GX19508@ws.net.home>
References: <1446856818-26532-1-git-send-email-tom.leiming@gmail.com>
	<20151109102931.GU19508@ws.net.home>
	<CACVXFVOGZzGtpPBbVfYDd1=3rcZ__x-ggkvtQMx9T0+VJYfSrw@mail.gmail.com>
	<20151109114613.GV19508@ws.net.home>
	<CACVXFVPRBwe3H101=cUVG6CsDT3z-WvAX_wOanaNa+HbTdfoUw@mail.gmail.com>
	<20151110114004.GX19508@ws.net.home>
Date: Tue, 10 Nov 2015 23:20:58 +0800
Message-ID: <CACVXFVMGoAhz0RAqc57UV_5qsi_OLxtVB4fGd0DRKuWd8-mRjQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] losetup: support direct-IO to backing file
From: Ming Lei <tom.leiming@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 10, 2015 at 7:40 PM, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Nov 10, 2015 at 02:05:39PM +0800, Ming Lei wrote:
>> On Mon, Nov 9, 2015 at 7:46 PM, Karel Zak <kzak@redhat.com> wrote:
>> > On Mon, Nov 09, 2015 at 07:29:21PM +0800, Ming Lei wrote:
>> >> > It's fine to use --direct-io as toggle, but it would be nice to
>> >> > support it also when initialize the device.
>> >>
>> >> OK, looks a good idea, but we still need to support the standalone
>> >> command for direct-io for the case of 'mount -o loop'.
>> >
>> > Sure, I understand this use-case. I have talked bout loop_set_fd(),
>> > maybe all we need is:
>> >
>> >
>> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> > index 423f4ca..22642a0 100644
>> > --- a/drivers/block/loop.c
>> > +++ b/drivers/block/loop.c
>> > @@ -925,7 +925,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>> >
>> >         set_device_ro(bdev, (lo_flags & LO_FLAGS_READ_ONLY) != 0);
>> >
>> > -       lo->use_dio = false;
>> > +       lo->use_dio = (lo_flags & LO_FLAGS_DIRECT_IO);
>> >         lo->lo_blocksize = lo_blocksize;
>> >         lo->lo_device = bdev;
>> >         lo->lo_flags = lo_flags;
>>
>> I don't think this change is doable because lo_flags is always started
>> as zero from loop_set_fd().
>
>  Sorry, wrong function -- should be loop_set_status() where we can
>  modify lo->lo_flags by info->lo_flags. It's already used for
>  LO_FLAGS_AUTOCLEAR and LO_FLAGS_PARTSCAN.

Yes, that might work, but I am opt to use LOOP_SET_DIRECT_IO cmd
because set_status is already too fat and it is always safe to use one
specific cmd for chaning direct-io.

Also there have been bugs in set_status() already and it is always difficult to
change things together/atomaticaly especially, for example:

     - changing lo->transfer may cause oops
     - partial change in case of failure from figuring size
     - for direct-io, it may fail too, so it may introduce more
trouble to set_status
     for handling the failure.

Thanks,
Ming Lei
