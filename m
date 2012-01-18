Return-Path: kay.sievers@vrfy.org
MIME-Version: 1.0
In-Reply-To: <20120118121301.GA2371@x2.net.home>
References: <4F16279F.3040100@yahoo.com.ar> <20120118121301.GA2371@x2.net.home>
From: Kay Sievers <kay.sievers@vrfy.org>
Date: Wed, 18 Jan 2012 13:51:57 +0100
Message-ID: <CAPXgP12ex2UyeCgQYX65v893N28CTr6d=hF8822mPiEZ-+wEZA@mail.gmail.com>
Subject: Re: Buffer I/O error, with latest losetup on first run
To: Karel Zak <kzak@redhat.com>
Cc: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 18, 2012 at 13:13, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Jan 17, 2012 at 10:59:59PM -0300, Gerardo Exequiel Pozzi wrote:
>> Using (losetup from util-linux 2.20.620-4360-dirty) and Linux-3.2.1.
>>
>> Using losetup as first time, if loop module is not loaded, losetup -f
>> file-equal-or-below-1MiB I get: "Buffer I/O error on device loop0, logical
>> block 0" (sometimes get one message, or two or three, ...)
>
> It does not sound like userspace problem, I guess that the message comes
> from kernel (dmesg). It would be also nice to have strace output.
>
>>
>> Can be reproducible again if loop module is unloaded then execute losetup.
>> Does not happen if module is loaded previously to losetup.
>> Happens independently if /dev/loop0 exists or not.
>>
>> Does not happen with losetup from 2.20 under the same conditions.
>
> The new losetup uses /dev/loop-control to get the new free loop device.
>
> Kay, any idea?

No really. Accessing /dev/loop-control should block losetup, and
synchronously load the look.ko module, before doing any further
operation in losetup.

Kay
