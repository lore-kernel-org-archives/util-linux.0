Return-Path: bruce.dubbs@gmail.com
Message-ID: <5665A178.5050601@gmail.com>
Date: Mon, 07 Dec 2015 09:10:48 -0600
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>, David Wilson <dw@botanicus.net>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] Add mount -P to hide pseudo filesystems
References: <20151206042923.GA6570@k3> <20151207113409.GC2353@ws.net.home>
In-Reply-To: <20151207113409.GC2353@ws.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Sun, Dec 06, 2015 at 04:29:23AM +0000, David Wilson wrote:
>> This is just shorthand for an increasingly necessary yet cumbersome and
>> error-prone "grep -v" pipe. The alternative was to extend -t to accept
>> "nopseudofs", but that is tougher on the fingers.
>
>   I don't plan to improve mount(8) list output in any way to duplicate
>   findmnt(8). Please, let's use (and improve) findmnt(8). Thanks.
>
>   Anyway,
>
>       --real
>       --net
>       --pseudo
>
>   sounds good for findmnt. Look forward for a patch :-)

Is it possible to detect --bind in findmnt?

   -- Bruce
