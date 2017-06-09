Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:53820 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751527AbdFILOU (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 9 Jun 2017 07:14:20 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH 01/11] misc: fallthrough fixes
Date: Fri, 9 Jun 2017 13:14:07 +0200
Cc: util-linux@vger.kernel.org
References: <20170608195215.1702-1-kerolasa@iki.fi> <20170608195215.1702-2-kerolasa@iki.fi>
In-Reply-To: <20170608195215.1702-2-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201706091314.08008.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

This patch looks a bit ugly, for example:

## gcc 4.8.1

  CC       text-utils/more-more.o
../text-utils/more.c: In function ‘command’:
../text-utils/more.c:1273:4: warning: empty declaration [enabled by 
default]
    UL_FALLTHROUGH;

## icc 16.0.0

text-utils/more.c(1273): warning #1292: unknown attribute "fallthrough"
                        UL_FALLTHROUGH;
                        ^

> diff --git a/include/c.h b/include/c.h
> index a5162b964..8a67b5dfb 100644
> --- a/include/c.h
> +++ b/include/c.h
> @@ -77,6 +77,24 @@
>  #endif
>  
>  /*
> + * Statement Attributes
> + */
> +#if defined(__clang__)
> +# ifndef __has_cpp_attribute
> +#  define __has_cpp_attribute(x) 0
> +# endif
> +# if __has_cpp_attribute(clang::fallthrough)
> +#  define UL_FALLTHROUGH [[clang::fallthrough]]
> +# else
> +#  define UL_FALLTHROUGH /* fall through */
> +# endif
> +#elif defined(__GNUC__) || defined(__GNUG__)
> +# define UL_FALLTHROUGH __attribute__((fallthrough))
> +#else
> +# define UL_FALLTHROUGH /* FALLTHRU */
> +#endif
> +
> +/*

Maybe just simplify like this:

#ifndef __has_attribute
  #define __has_attribute(x) 0
#endif

#if __has_cpp_attribute(fallthrough)
# define UL_FALLTHROUGH [[fallthrough]]
#else
# define UL_FALLTHROUGH /* fall through */
#endif

The attribute works without "clang::" prefix on recent gcc and clang, 
and maybe icc in future.

Otherwise we could check for the attribute in configure, using 
autoconf-archive
  AX_GCC_FUNC_ATTRIBUTE(fallthrough)
https://www.gnu.org/software/autoconf-archive/ax_gcc_func_attribute.html

cu,
Rudi
