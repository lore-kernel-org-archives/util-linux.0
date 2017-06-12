Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qt0-f177.google.com ([209.85.216.177]:34834 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752386AbdFLVyj (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 12 Jun 2017 17:54:39 -0400
Received: by mail-qt0-f177.google.com with SMTP id w1so144638316qtg.2
        for <util-linux@vger.kernel.org>; Mon, 12 Jun 2017 14:54:38 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <55d88bf2-3c67-4d79-984e-b16d6b835702@gmx.de>
References: <20170608195215.1702-1-kerolasa@iki.fi> <20170608195215.1702-2-kerolasa@iki.fi>
 <201706091314.08008.sweet_f_a@gmx.de> <968790d0-c49c-538b-d034-ffcda9c20efc@gmx.de>
 <CAG27Bk3OEBrnGbrD+2tuxu-UGUjQXLB+TrsFLiQRvOtcns8FsQ@mail.gmail.com> <55d88bf2-3c67-4d79-984e-b16d6b835702@gmx.de>
From: Sami Kerola <kerolasa@iki.fi>
Date: Mon, 12 Jun 2017 22:54:32 +0100
Message-ID: <CAG27Bk03PW7GWHdm5G0Xcu1LXbAXwebQyyvk3HoHx7hP8e-Bgg@mail.gmail.com>
Subject: Re: [PATCH 01/11] misc: fallthrough fixes
To: =?UTF-8?Q?R=C3=BCdiger_Meier?= <sweet_f_a@gmx.de>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 12 June 2017 at 09:40, R=C3=BCdiger Meier <sweet_f_a@gmx.de> wrote:
> On 06/11/2017 10:36 AM, Sami Kerola wrote:
>>
>> On 9 June 2017 at 22:10, R=C3=BCdiger Meier <sweet_f_a@gmx.de> wrote:
>
>
>>> Sorry this was broken. But I've checked now all clang and gcc versions.
>>> Looks
>>> like for clang the warning is only enabled when using C++ (clang++). So
>>> the
>>> fallthrough warning appears currently only on gcc>=3D7 and this works t=
o
>>> disable
>>> it in a compatible way:
>>>
>>> #ifndef __has_cpp_attribute
>>> # define __has_cpp_attribute(x) 0
>>> #endif
>>>
>>> #if __has_cpp_attribute(fallthrough)
>>> # define UL_FALLTHROUGH __attribute__((fallthrough))
>>> #else
>>> # define UL_FALLTHROUGH /* fall through */
>>> #endif
>>
>>
>> Thank you for review Rudi. I had a look of the c.h again and did the
>> change a little bit differently:
>>
>> #ifdef __has_cpp_attribute
>> # if __has_cpp_attribute(deprecated)
>
>
> Is this a typoo? s/deprecated/fallthrough

Hi Rudi,

Yes, it was a typo. Fixed in following.

https://github.com/kerolasa/lelux-utiliteetit/commit/aa1ed6ac309a2bd6f0c537=
1a3117618074e7634a

>> #  define UL_FALLTHROUGH __attribute__((fallthrough))
>> # elif __has_cpp_attribute(clang::fallthrough)
>> #  define UL_FALLTHROUGH [[clang::fallthrough]]
>
>
> I still wonder. Have you really seen such a fallthrough warning from clan=
g?
> I've even tried with explicit -Wimplicit-fallthrough but could not get on=
e.
>
> As far as I understood these namespaced "clang::" attributes are for C++
> only.
>
> man clang:
>    Non-standard C++11 Attributes
>        Clang's non-standard C++11 attributes live in the clang attribute
> namespace
>
> So IMO it makes no sense to use clang::fallthrough for C code.

Removed in same commit. Strange enough I'm pretty sure that attribute
worked.

>> # endif
>> #endif
>> #ifndef UL_FALLTHROUGH
>> # define UL_FALLTHROUGH /* FALLTHRU */
>> #endif
>
>
> BTW just for cosmetics. Maybe we should rename UL_FALLTHROUGH to
> __ul_fallthrough
> like we have already __ul_calloc_size. IMO it would look more obvious to =
the
> reader.

I don't have strong opinion about that, changed to one you proposed.

> Also I would use it without semicolon because some compilers may complain
> about
> useless ";" statements.

Semicolon is removed. Whether this will fool various indent tools is someth=
ing
to be seen.

--=20
Sami Kerola
http://www.iki.fi/kerolasa/
