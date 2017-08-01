Return-Path: elseifthen@gmx.com
Subject: Re: [PATCH 4/8] hwclock: fix RTC read logic
To: Karel Zak <kzak@redhat.com>
References: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
 <5714882c-8ed5-c703-410e-c0dd191051f6@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <78eb8b87-09e8-ca5b-38f9-757e09299c2d@gmx.com>
Date: Tue, 1 Aug 2017 14:42:22 -0400
MIME-Version: 1.0
In-Reply-To: <5714882c-8ed5-c703-410e-c0dd191051f6@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 08/01/2017 09:17 AM, J William Piggott wrote:

 8< ----
> 
> 
> Because the previous fix also ignored the select() branch timeout
> it caused a bogus warning. The chosen workaround for that was to
> only print the select() timeout message in debug mode (this is
> reverted by another patch).

 8< ----

I forgot to mention the problem this caused, which is: the other
functions still exit on a select() timeout ... silently!:

$ hwclock --show
$ hwclock --show --debug
select() to /dev/rtc0 to wait for clock tick timed out...synchronization failed

Not good.
