Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qc0-f175.google.com ([209.85.216.175]:61784 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab3LLTm5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 12 Dec 2013 14:42:57 -0500
Received: by mail-qc0-f175.google.com with SMTP id e9so717785qcy.34
        for <util-linux@vger.kernel.org>; Thu, 12 Dec 2013 11:42:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131212120544.GJ16572@x2.net.home>
References: <52A878C5.6050505@ubuntu.com>
	<20131212120544.GJ16572@x2.net.home>
Date: Thu, 12 Dec 2013 20:42:54 +0100
Message-ID: <CAJfpegvWeEb7Dtk8CMxLO4DB-xSLQMxLxccUPReU0GeQ=9d5MA@mail.gmail.com>
Subject: Re: read only bind mount ignores ready only
From: Miklos Szeredi <miklos@szeredi.hu>
To: Karel Zak <kzak@redhat.com>
Cc: Phillip Susi <psusi@ubuntu.com>, util-linux@vger.kernel.org,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 12, 2013 at 1:05 PM, Karel Zak <kzak@redhat.com> wrote:
>
>  [CC: kernel guys]
>
> On Wed, Dec 11, 2013 at 09:37:57AM -0500, Phillip Susi wrote:
>> It seems that the kernel has a bug where it silently ignores the
>> MS_RDONLY flag when creating a bind mount.  mount issues a warning
>> that the mount point appears to be read-write even though you
>> requested read only.  The reporter suggests a patch to automatically
>> attempt to remount with MS_RDONLY before issuing this warning to work
>> around the kernel bug.  What do you think?
>
> I have it implemented, so
>
>  mount --bind --read-only /mnt /mnt
>
> is interpreted as two requests (two mount(2) calls)
>
>  mount --bind /mnt /mnt
>  mount -o remount,bind,ro /tmp
>
> it works as expected, but it does not work with MS_REC (recursive)
> because kernel currently does not support
>
>   MS_REMOUNT|MS_BIND|MS_REC|...
>
> it means that
>
>   mount --rbind --read-only /mnt /mnt
>
> creates only top-level read-only mountpoint, the rest is unchanged.
>
>
> Miklos would be possible to fix kernel to accept MS_REC for
> MS_REMOUNT|MS_BIND|MS_RDONLY operation? Please.

I really hate the current mount(2) API. It's a gigantic hack, and it's
nearing the end of its life anyway due to flags running out.

So instead of adding more hacks, I think it would be better to think
about adding a couple of syscalls that have clearly defined semantics.

Thanks,
Miklos
