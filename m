Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:51017 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751561AbdFIVKT (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 9 Jun 2017 17:10:19 -0400
Subject: Re: [PATCH 01/11] misc: fallthrough fixes
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
References: <20170608195215.1702-1-kerolasa@iki.fi>
 <20170608195215.1702-2-kerolasa@iki.fi> <201706091314.08008.sweet_f_a@gmx.de>
Message-ID: <968790d0-c49c-538b-d034-ffcda9c20efc@gmx.de>
Date: Fri, 9 Jun 2017 23:10:09 +0200
MIME-Version: 1.0
In-Reply-To: <201706091314.08008.sweet_f_a@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 06/09/2017 01:14 PM, Ruediger Meier wrote:
> Hi,
> 
> This patch looks a bit ugly, for example:
> 
> ## gcc 4.8.1
> 
>    CC       text-utils/more-more.o
> ../text-utils/more.c: In function ‘command’:
> ../text-utils/more.c:1273:4: warning: empty declaration [enabled by
> default]
>      UL_FALLTHROUGH;
> 
> ## icc 16.0.0
> 
> text-utils/more.c(1273): warning #1292: unknown attribute "fallthrough"
>                          UL_FALLTHROUGH;
>                          ^
> 
>> diff --git a/include/c.h b/include/c.h
>> index a5162b964..8a67b5dfb 100644
>> --- a/include/c.h
>> +++ b/include/c.h
>> @@ -77,6 +77,24 @@
>>   #endif
>>   
>>   /*
>> + * Statement Attributes
>> + */
>> +#if defined(__clang__)
>> +# ifndef __has_cpp_attribute
>> +#  define __has_cpp_attribute(x) 0
>> +# endif
>> +# if __has_cpp_attribute(clang::fallthrough)
>> +#  define UL_FALLTHROUGH [[clang::fallthrough]]
>> +# else
>> +#  define UL_FALLTHROUGH /* fall through */
>> +# endif
>> +#elif defined(__GNUC__) || defined(__GNUG__)
>> +# define UL_FALLTHROUGH __attribute__((fallthrough))
>> +#else
>> +# define UL_FALLTHROUGH /* FALLTHRU */
>> +#endif
>> +
>> +/*

Sorry this was broken. But I've checked now all clang and gcc versions. Looks
like for clang the warning is only enabled when using C++ (clang++). So the
fallthrough warning appears currently only on gcc>=7 and this works to disable
it in a compatible way:

#ifndef __has_cpp_attribute
# define __has_cpp_attribute(x) 0
#endif

#if __has_cpp_attribute(fallthrough)
# define UL_FALLTHROUGH __attribute__((fallthrough))
#else
# define UL_FALLTHROUGH /* fall through */
#endif


> Maybe just simplify like this:
> 
> #ifndef __has_attribute
>    #define __has_attribute(x) 0
> #endif
> 
> #if __has_cpp_attribute(fallthrough)
> # define UL_FALLTHROUGH [[fallthrough]]
> #else
> # define UL_FALLTHROUGH /* fall through */
> #endif
> 
> The attribute works without "clang::" prefix on recent gcc and clang,
> and maybe icc in future.
> 
> Otherwise we could check for the attribute in configure, using
> autoconf-archive
>    AX_GCC_FUNC_ATTRIBUTE(fallthrough)
> https://www.gnu.org/software/autoconf-archive/ax_gcc_func_attribute.html
> 
> cu,
> Rudi
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
