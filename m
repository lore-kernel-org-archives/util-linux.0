Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34512 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751743AbdFKIgv (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 11 Jun 2017 04:36:51 -0400
Received: by mail-qk0-f178.google.com with SMTP id d14so19750069qkb.1
        for <util-linux@vger.kernel.org>; Sun, 11 Jun 2017 01:36:51 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <968790d0-c49c-538b-d034-ffcda9c20efc@gmx.de>
References: <20170608195215.1702-1-kerolasa@iki.fi> <20170608195215.1702-2-kerolasa@iki.fi>
 <201706091314.08008.sweet_f_a@gmx.de> <968790d0-c49c-538b-d034-ffcda9c20efc@gmx.de>
From: Sami Kerola <kerolasa@iki.fi>
Date: Sun, 11 Jun 2017 09:36:50 +0100
Message-ID: <CAG27Bk3OEBrnGbrD+2tuxu-UGUjQXLB+TrsFLiQRvOtcns8FsQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] misc: fallthrough fixes
To: =?UTF-8?Q?R=C3=BCdiger_Meier?= <sweet_f_a@gmx.de>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 9 June 2017 at 22:10, R=C3=BCdiger Meier <sweet_f_a@gmx.de> wrote:
>
>
> On 06/09/2017 01:14 PM, Ruediger Meier wrote:
>>
>> Hi,
>>
>> This patch looks a bit ugly, for example:
>>
>> ## gcc 4.8.1
>>
>>    CC       text-utils/more-more.o
>> ../text-utils/more.c: In function =E2=80=98command=E2=80=99:
>> ../text-utils/more.c:1273:4: warning: empty declaration [enabled by
>> default]
>>      UL_FALLTHROUGH;
>>
>> ## icc 16.0.0
>>
>> text-utils/more.c(1273): warning #1292: unknown attribute "fallthrough"
>>                          UL_FALLTHROUGH;
>>                          ^
>>
>>> diff --git a/include/c.h b/include/c.h
>>> index a5162b964..8a67b5dfb 100644
>>> --- a/include/c.h
>>> +++ b/include/c.h
>>> @@ -77,6 +77,24 @@
>>>   #endif
>>>     /*
>>> + * Statement Attributes
>>> + */
>>> +#if defined(__clang__)
>>> +# ifndef __has_cpp_attribute
>>> +#  define __has_cpp_attribute(x) 0
>>> +# endif
>>> +# if __has_cpp_attribute(clang::fallthrough)
>>> +#  define UL_FALLTHROUGH [[clang::fallthrough]]
>>> +# else
>>> +#  define UL_FALLTHROUGH /* fall through */
>>> +# endif
>>> +#elif defined(__GNUC__) || defined(__GNUG__)
>>> +# define UL_FALLTHROUGH __attribute__((fallthrough))
>>> +#else
>>> +# define UL_FALLTHROUGH /* FALLTHRU */
>>> +#endif
>>> +
>>> +/*
>
>
> Sorry this was broken. But I've checked now all clang and gcc versions.
> Looks
> like for clang the warning is only enabled when using C++ (clang++). So t=
he
> fallthrough warning appears currently only on gcc>=3D7 and this works to
> disable
> it in a compatible way:
>
> #ifndef __has_cpp_attribute
> # define __has_cpp_attribute(x) 0
> #endif
>
> #if __has_cpp_attribute(fallthrough)
> # define UL_FALLTHROUGH __attribute__((fallthrough))
> #else
> # define UL_FALLTHROUGH /* fall through */
> #endif

Thank you for review Rudi. I had a look of the c.h again and did the
change a little bit differently:

#ifdef __has_cpp_attribute
# if __has_cpp_attribute(deprecated)
#  define UL_FALLTHROUGH __attribute__((fallthrough))
# elif __has_cpp_attribute(clang::fallthrough)
#  define UL_FALLTHROUGH [[clang::fallthrough]]
# endif
#endif
#ifndef UL_FALLTHROUGH
# define UL_FALLTHROUGH /* FALLTHRU */
#endif

The above is now part of my remote branch '2017wk23'.

--=20
Sami Kerola
http://www.iki.fi/kerolasa/
