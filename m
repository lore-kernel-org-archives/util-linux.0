Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:57916 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751957AbdFLIlB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 12 Jun 2017 04:41:01 -0400
Subject: Re: [PATCH 01/11] misc: fallthrough fixes
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
References: <20170608195215.1702-1-kerolasa@iki.fi>
 <20170608195215.1702-2-kerolasa@iki.fi> <201706091314.08008.sweet_f_a@gmx.de>
 <968790d0-c49c-538b-d034-ffcda9c20efc@gmx.de>
 <CAG27Bk3OEBrnGbrD+2tuxu-UGUjQXLB+TrsFLiQRvOtcns8FsQ@mail.gmail.com>
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
Message-ID: <55d88bf2-3c67-4d79-984e-b16d6b835702@gmx.de>
Date: Mon, 12 Jun 2017 10:40:58 +0200
MIME-Version: 1.0
In-Reply-To: <CAG27Bk3OEBrnGbrD+2tuxu-UGUjQXLB+TrsFLiQRvOtcns8FsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Sami,

On 06/11/2017 10:36 AM, Sami Kerola wrote:
> On 9 June 2017 at 22:10, Rüdiger Meier <sweet_f_a@gmx.de> wrote:

>> Sorry this was broken. But I've checked now all clang and gcc versions.
>> Looks
>> like for clang the warning is only enabled when using C++ (clang++). So the
>> fallthrough warning appears currently only on gcc>=7 and this works to
>> disable
>> it in a compatible way:
>>
>> #ifndef __has_cpp_attribute
>> # define __has_cpp_attribute(x) 0
>> #endif
>>
>> #if __has_cpp_attribute(fallthrough)
>> # define UL_FALLTHROUGH __attribute__((fallthrough))
>> #else
>> # define UL_FALLTHROUGH /* fall through */
>> #endif
> 
> Thank you for review Rudi. I had a look of the c.h again and did the
> change a little bit differently:
> 
> #ifdef __has_cpp_attribute
> # if __has_cpp_attribute(deprecated)

Is this a typoo? s/deprecated/fallthrough

> #  define UL_FALLTHROUGH __attribute__((fallthrough))
> # elif __has_cpp_attribute(clang::fallthrough)
> #  define UL_FALLTHROUGH [[clang::fallthrough]]

I still wonder. Have you really seen such a fallthrough warning from clang?
I've even tried with explicit -Wimplicit-fallthrough but could not get one.

As far as I understood these namespaced "clang::" attributes are for C++ only.

man clang:
    Non-standard C++11 Attributes
        Clang's non-standard C++11 attributes live in the clang attribute namespace

So IMO it makes no sense to use clang::fallthrough for C code.

> # endif
> #endif
> #ifndef UL_FALLTHROUGH
> # define UL_FALLTHROUGH /* FALLTHRU */
> #endif

BTW just for cosmetics. Maybe we should rename UL_FALLTHROUGH to __ul_fallthrough
like we have already __ul_calloc_size. IMO it would look more obvious to the reader.
Also I would use it without semicolon because some compilers may complain about
useless ";" statements.

cu,
Rudi

> The above is now part of my remote branch '2017wk23'.
> 
