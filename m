Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <55e0d593-85e7-accc-84bd-c853a9d2951c@gmx.com>
References: <20160710200242.2706-1-kerolasa@iki.fi> <201607121623.04891.sweet_f_a@gmx.de>
 <CAG27Bk3po26Bsb=E0A1UXDrTrkwPH1pEvqEKXFZ_n4PVOcxt8A@mail.gmail.com>
 <201607122338.40458.sweet_f_a@gmx.de> <alpine.LNX.2.20.1607122241300.11890@imuri>
 <20160714100143.gc4ozcmah5i5stgz@ws.net.home> <55e0d593-85e7-accc-84bd-c853a9d2951c@gmx.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Wed, 27 Jul 2016 17:07:38 +0100
Message-ID: <CAG27Bk1DOOpwa-T=R0Hxxna+3Cap-6gC+KCcn8C4i_5AD5jd0g@mail.gmail.com>
Subject: Re: [PATCH] hwclock: remove UTC-0 localization hack
To: J William Piggott <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, Ruediger Meier <sweet_f_a@gmx.de>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 15 July 2016 at 19:46, J William Piggott <elseifthen@gmx.com> wrote:
> On 07/14/2016 06:01 AM, Karel Zak wrote:
>> On Tue, Jul 12, 2016 at 10:42:33PM +0100, Sami Kerola wrote:
>>>  lib/portability.c      | 28 ++++++++++++++++++++++++++++
>>
>> We already care about portability and we have many fallbacks, so why
>> we need lib/portability.c now? It would better to use timeutils.c (or
>> inline function in c.h).
>
> What is this projects position on POSIX compatibility? A few comments in
> the *-ReleaseNotes is all I found in /Documentation. Just curious, because
> mktime() is and timegm() is not POSIX.

That is a question to maintainer, but Karel seems to be busy so let me try
to phrase how I see the things.

The util-linux project is a dumping ground for various linux specific, and
other tools.  Some of the tools make are sensible only in context of linux,
such as dmesg(1) or mkswap(8), while other could technically be compiled on
other operating environments, more(1) and getopt(1) are examples of later
category.

As mentioned in this thread the util-linux is one of the core packages, and
it is assumed to be found from all sorts of systems.  That in mind the
portability question has got more to do whether the project works without
problems with alternative libc implementations.  Ideally the util-linux
should compile fine on any linux no matter what libc is used.  But please
notice that some utilities might not get compiled if/when autotools notice
requirements are not fulfilled.

In short.  While portability is not a main goal of the project neither it is
completely neglected either.  Keeping ulibc going is important, making the
util-linux work with mingw is less important.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
