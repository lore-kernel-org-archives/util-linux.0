Return-Path: elseifthen@gmx.com
Subject: Re: [PATCH] hwclock: remove UTC-0 localization hack
To: kerolasa@gmail.com
References: <20160710200242.2706-1-kerolasa@iki.fi>
 <201607121623.04891.sweet_f_a@gmx.de>
 <CAG27Bk3po26Bsb=E0A1UXDrTrkwPH1pEvqEKXFZ_n4PVOcxt8A@mail.gmail.com>
 <201607122338.40458.sweet_f_a@gmx.de>
 <alpine.LNX.2.20.1607122241300.11890@imuri>
 <20160714100143.gc4ozcmah5i5stgz@ws.net.home>
 <55e0d593-85e7-accc-84bd-c853a9d2951c@gmx.com>
 <CAG27Bk1DOOpwa-T=R0Hxxna+3Cap-6gC+KCcn8C4i_5AD5jd0g@mail.gmail.com>
From: J William Piggott <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, Ruediger Meier <sweet_f_a@gmx.de>,
        util-linux <util-linux@vger.kernel.org>
Message-ID: <74735c3b-a94c-6905-7818-b308d9a63809@gmx.com>
Date: Thu, 28 Jul 2016 15:49:16 -0400
MIME-Version: 1.0
In-Reply-To: <CAG27Bk1DOOpwa-T=R0Hxxna+3Cap-6gC+KCcn8C4i_5AD5jd0g@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 07/27/2016 12:07 PM, Sami Kerola wrote:
> On 15 July 2016 at 19:46, J William Piggott <elseifthen@gmx.com> wrote:
>> On 07/14/2016 06:01 AM, Karel Zak wrote:
>>> On Tue, Jul 12, 2016 at 10:42:33PM +0100, Sami Kerola wrote:
>>>>  lib/portability.c      | 28 ++++++++++++++++++++++++++++
>>>
>>> We already care about portability and we have many fallbacks, so why
>>> we need lib/portability.c now? It would better to use timeutils.c (or
>>> inline function in c.h).
>>
>> What is this projects position on POSIX compatibility? A few comments in
>> the *-ReleaseNotes is all I found in /Documentation. Just curious, because
>> mktime() is and timegm() is not POSIX.
> 
> That is a question to maintainer, but Karel seems to be busy so let me try
> to phrase how I see the things.
> 
> The util-linux project is a dumping ground for various linux specific, and
> other tools.  Some of the tools make are sensible only in context of linux,
> such as dmesg(1) or mkswap(8), while other could technically be compiled on
> other operating environments, more(1) and getopt(1) are examples of later
> category.
> 
> As mentioned in this thread the util-linux is one of the core packages, and
> it is assumed to be found from all sorts of systems.  That in mind the
> portability question has got more to do whether the project works without
> problems with alternative libc implementations.  Ideally the util-linux
> should compile fine on any linux no matter what libc is used.  But please
> notice that some utilities might not get compiled if/when autotools notice
> requirements are not fulfilled.
> 
> In short.  While portability is not a main goal of the project neither it is
> completely neglected either.  Keeping ulibc going is important, making the
> util-linux work with mingw is less important.
> 

Hey Sami,

Thanks for your reply. The position you describe is what I had surmised
as a general statement (with the addition that portability also involves
different hardware architectures). I just wanted to know if Karel had an
official stance specifically on POSIX compliance. POSIX appears to only
be used as an ad hoc reference?
