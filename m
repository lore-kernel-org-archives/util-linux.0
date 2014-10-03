Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:55370 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbaJCUXf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 3 Oct 2014 16:23:35 -0400
Received: by mail-wi0-f174.google.com with SMTP id cc10so8355795wib.1
        for <util-linux@vger.kernel.org>; Fri, 03 Oct 2014 13:23:34 -0700 (PDT)
Message-ID: <542F065C.2080505@gmail.com>
Date: Fri, 03 Oct 2014 22:26:04 +0200
From: Francis Moreau <francis.moro@gmail.com>
MIME-Version: 1.0
To: "Dale R. Worley" <worley@alum.mit.edu>, util-linux@vger.kernel.org
Subject: Re: losetup on a image file containing (GPT) partition doesn't create
 partition devices
References: <542E7000.3040309@gmail.com> <201410031429.s93ET4wu014728@hobgoblin.ariadne.com> <201410031958.s93JwTuY026155@hobgoblin.ariadne.com>
In-Reply-To: <201410031958.s93JwTuY026155@hobgoblin.ariadne.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10/03/2014 09:58 PM, Dale R. Worley wrote:
>> From: worley@alum.mit.edu (Dale R. Worley)
> 
>> Then I detached the loopback device, re-attached it, and this time,
>> the partition devices were *not* created, and /var/log/messages did
>> not have the "loop0: p1 p2" message.
>>
>> Given that the message starts "kernel:", I suspect that the udev
>> behavior is triggered by the kernel detecting the partition table, and
>> that is not happening.  So it looks like it's a kernel bug.
> 
> I tried that again, after updating to kernel 3.14.19-100.fc19.x86_64,
> and it worked this time.

Well I'm already running 3.14.18, and the problem is still present but
not systematic.

Here's a script which should trigger the problem:

-----
while :; do

    losetup -P /dev/loop0 disk.raw ||
    exit

    test -e /dev/loop0p1 || {
        echo "missing loop partition"
        losetup -d /dev/loop0
        break
    }
    echo -n "losetup worked: "
    ls /dev/loop0*

    losetup -d /dev/loop0 ||
    exit

    sleep 1
done
----

After looking at the kernel code, the kernel can silently fail to scan
the partition table. This can happen if another process is already using
the device and I think udev is the process that can interfere with
'losetup -P'.

What do you think ?

thanks.
