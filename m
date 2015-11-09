Return-Path: tom.leiming@gmail.com
MIME-Version: 1.0
In-Reply-To: <20151109102931.GU19508@ws.net.home>
References: <1446856818-26532-1-git-send-email-tom.leiming@gmail.com>
	<20151109102931.GU19508@ws.net.home>
Date: Mon, 9 Nov 2015 19:29:21 +0800
Message-ID: <CACVXFVOGZzGtpPBbVfYDd1=3rcZ__x-ggkvtQMx9T0+VJYfSrw@mail.gmail.com>
Subject: Re: [PATCH 0/2] losetup: support direct-IO to backing file
From: Ming Lei <tom.leiming@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 9, 2015 at 6:29 PM, Karel Zak <kzak@redhat.com> wrote:
> On Sat, Nov 07, 2015 at 08:40:16AM +0800, Ming Lei wrote:
>> The loop direct I/O patches[1] have been merged to linus kernel tree
>> and will be released in v4.4.
>>
>> So the two patches provide interfaces for using direct IO/AIO
>> in losetup.
>
> Thanks!
>
>>  include/loopdev.h   |  4 ++++
>>  lib/loopdev.c       | 40 ++++++++++++++++++++++++++++++++++++++++
>>  sys-utils/losetup.c | 30 +++++++++++++++++++++++++++---
>>  3 files changed, 71 insertions(+), 3 deletions(-)
>>
>> [1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=bc07c10a3603a5ab3ef01ba42b3d41f9ac63d1b6
>
> If I read correctly the kernel code than LO_FLAGS_DIRECT_IO is not
> possible to use when initialize loop device by LOOP_SET_FD ioctl. I
> need extra LOOP_SET_DIRECT_IO ioctl. Why?
>
> Why kernel function loop_set_fd() does not initialize lo->use_dio
> according to "lo_flags & LO_FLAGS_DIRECT_IO" as we use for another
> loopdev stuff? See for example LO_FLAGS_PARTSCAN. Would be possible
> to improve kernel a little bit?

One case we need to support is 'mount -o loop', which is a bit different
with PARTSCAN.

>
>
> Now you have to use two commands (ioctls):
>
>  # losetup /dev/loop0 file.img
>  # losetup --direct-io 1 /dev/loop0
>
> It's fine to use --direct-io as toggle, but it would be nice to
> support it also when initialize the device.

OK, looks a good idea, but we still need to support the standalone
command for direct-io for the case of 'mount -o loop'.

>
>     Karel
>
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com



-- 
Ming Lei
