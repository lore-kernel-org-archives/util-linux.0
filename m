Return-Path: peter@cordes.ca
Date: Fri, 12 Jan 2018 07:50:00 -0400
To: Karel Zak <kzak@redhat.com>
Cc: halfdog <me@halfdog.net>, util-linux@vger.kernel.org
Subject: Re: util-linux mount/unmount ASLR bypass via environment variable
Message-id: <20180112115000.GF29852@cordes.ca>
References: <820-1515696719.436169@jYEA.ctRK.4WZD>
 <20180112101559.rm2k4qbhi7kyufma@ws.net.home>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <20180112101559.rm2k4qbhi7kyufma@ws.net.home>
From: Peter Cordes <peter@cordes.ca>
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 12, 2018 at 11:15:59AM +0100, Karel Zak wrote:
> Good point. Fixed, now for SUIDs it's without the addresses:
>
> $ LIBMOUNT_DEBUG=all mount
> 18622: libmount:      CXT: ----> allocate [RESTRICTED]
> 18622: libmount:      TAB: alloc
> ...

Would it be useful to warn that addresses are being hidden?  People
might not realize they're missing out on that when debugging.

Especially relevant if the addresses are useful for bug reports,
rather than just for use with a local debugger or something.
(In that case people probably run sudo gdb mount rather than attaching
to a running SUID mount process.)

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
