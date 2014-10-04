Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:59949 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbaJDTdB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 4 Oct 2014 15:33:01 -0400
Received: by mail-wg0-f45.google.com with SMTP id m15so3871379wgh.16
        for <util-linux@vger.kernel.org>; Sat, 04 Oct 2014 12:33:00 -0700 (PDT)
Message-ID: <54304C03.6020309@gmail.com>
Date: Sat, 04 Oct 2014 21:35:31 +0200
From: Francis Moreau <francis.moro@gmail.com>
MIME-Version: 1.0
To: "Dale R. Worley" <worley@alum.mit.edu>, util-linux@vger.kernel.org
Subject: Re: losetup on a image file containing (GPT) partition doesn't create
 partition devices
References: <542E7000.3040309@gmail.com> <201410031429.s93ET4wu014728@hobgoblin.ariadne.com> <201410031958.s93JwTuY026155@hobgoblin.ariadne.com> <542F065C.2080505@gmail.com>
In-Reply-To: <542F065C.2080505@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10/03/2014 10:26 PM, Francis Moreau wrote:
> On 10/03/2014 09:58 PM, Dale R. Worley wrote:
>>> From: worley@alum.mit.edu (Dale R. Worley)
>>
>>> Then I detached the loopback device, re-attached it, and this time,
>>> the partition devices were *not* created, and /var/log/messages did
>>> not have the "loop0: p1 p2" message.
>>>
>>> Given that the message starts "kernel:", I suspect that the udev
>>> behavior is triggered by the kernel detecting the partition table, and
>>> that is not happening.  So it looks like it's a kernel bug.
>>
>> I tried that again, after updating to kernel 3.14.19-100.fc19.x86_64,
>> and it worked this time.
> 
> Well I'm already running 3.14.18, and the problem is still present but
> not systematic.
> 
> Here's a script which should trigger the problem:
> 
> -----
> while :; do
> 
>     losetup -P /dev/loop0 disk.raw ||
>     exit
> 
>     test -e /dev/loop0p1 || {
>         echo "missing loop partition"
>         losetup -d /dev/loop0
>         break
>     }
>     echo -n "losetup worked: "
>     ls /dev/loop0*
> 
>     losetup -d /dev/loop0 ||
>     exit
> 
>     sleep 1
> done
> ----
> 
> After looking at the kernel code, the kernel can silently fail to scan
> the partition table. This can happen if another process is already using
> the device and I think udev is the process that can interfere with
> 'losetup -P'.
> 
> What do you think ?

Ok, so IMHO I think that losetup(8) should issue its own
ioctl(BLKRRPART) and shouldn't rely on the kernel during the loop setup
since it can fail silently. This way it can check the return value of
ioctl() and moght choose to do it again in case the return value is -EBUSY.

Or indicates in the man page that the -P can fail silently.

Thanks

