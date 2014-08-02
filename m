Return-Path: nefelim4ag@gmail.com
MIME-Version: 1.0
In-Reply-To: <20140801103725.GB8805@x2.net.home>
References: <53CAAAB6.6020607@gmail.com> <53D54D4D.5010905@gmail.com> <20140801103725.GB8805@x2.net.home>
From: Timofey Titovets <nefelim4ag@gmail.com>
Date: Sat, 2 Aug 2014 17:22:05 +0300
Message-ID: <CAGqmi74krB7VPrxyX4b+hGOy-89X_sHDr_WVX7hevYdXdQcOSg@mail.gmail.com>
Subject: Re: [RFC] [Patch v2] Created zramctl
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>, Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

(i forget include util-linux to CC)
First of all, big thanks Karel for your great work, you are C wizard =)

2014-08-01 13:37 GMT+03:00 Karel Zak <kzak@redhat.com>:
> On Sun, Jul 27, 2014 at 10:04:45PM +0300, Timofey Titovets wrote:
>> I spend some time and rewrite zramctl for util-linux.
>
>  Thanks! Merged.
>
>> sysfs.h powerful, but i can't understand how working sysfs.h and how i can
>> implement it(?), and i think what my helper function is easier now, than
>> sysfs.h realization
>
>  I have modified your code to use sysfs stuff and to use libsmartcols
>  in better way. So now it's more compatible with another ls-like utils
>  we have in util-linux. For example you can specify output columns by
>  --output, it makes it more friendly for scripts etc.
>
>  # /zramctl
>  NAME       ALGORITHM DISKSIZE DATA COMPR TOTAL STREAMS MOUNTPOINT
>  /dev/zram1               100M  44K  876B   44K         /mnt/test
>  /dev/zram2               123M   4K   78B    4K         [SWAP]
>  /dev/zram3                10M   0B    0B    0B
>
Looks nice, mount point it's cool column, very useful *_*

>  Note that I have kernel 3.14, so things like number of compression
>  streams and compression algorithm are invisible for me (I going to
>  update and test it with new kernel this afternoon).
I test recent build from util-linux git, and all working good (archlinux 3.15.8)
I can't test it on 3.14, but on old kernels, what zramctl say if user
try to setup compression algorithm or threads count?
(may be on old kernel, zramctl must show warning and just ignore -a
and -t option?)

>
>  Anyway, zRam seems like nice project. I'll try to add support to
>  swapon next week. My idea is something like (in fstab):
>
>   /dev/zram0  swap  swap  x-zram.disksize=100M,x-zram.algorithm=lzo,auto
>
>
>  it means use x-* options (we use this notation for another things) to
>  specify zram setting. The controversial thing is that we have to call
>  mkswap from swapon, but it's already supported for swap
>  reinitialization (after system resume or on page size change etc.)
>
>  ... or is it over-engineering?
>
>     Karel
>
Do mkswap in swapon it good feature, i think what it changes can
simplify using zram in swap case, and not only for zram.
As example in gentoo manual for zram
(http://wiki.gentoo.org/wiki/Zram) this changes allow to clean several
lines in code, for sh scripts and udev rules.
Same true as for your idea with fstab.
In several tools, what setup zram as swap it also allow to clean some
part of code.
This is a cool thing, and i vote for this feature.


> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com

--
Best regards,
Timofey.
