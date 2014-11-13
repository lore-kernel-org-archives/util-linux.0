Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37655 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932752AbaKMOst (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 13 Nov 2014 09:48:49 -0500
Date: Thu, 13 Nov 2014 15:48:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: kerolasa@gmail.com, Boris Egorov <egorov@linux.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0/6] pull: almost working AddressSanitizer support
Message-ID: <20141113144835.GD6704@x2.net.home>
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
 <5461B803.4050707@linux.com>
 <CAG27Bk1cDZUtAm26VpY5bugUWchzY7cjqfEDQYxdDJMYZo-q1w@mail.gmail.com>
 <alpine.LNX.2.03.1411112236560.23899@iki.fi>
 <20141112142500.GB5530@x2.net.home>
 <CAG27Bk2-c4_AsqCsBd+uBkkcvX0CSJPW+Q2+JndyGts=ZE1rmw@mail.gmail.com>
 <20141112195131.GA3902@vapier.wh0rd.info>
 <alpine.LNX.2.03.1411122044080.18829@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.03.1411122044080.18829@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 12, 2014 at 08:50:01PM +0000, Sami Kerola wrote:
> +/*
> + * UL_ASAN_BLACKLIST is a macro to tell AddressSanitizer (a compile-time
> + * instrumentation shipped with Clang and GCC) to not instrument the
> + * annotated function.  Furthermore, it will prevent the compiler from
> + * inlining the function because inlining currently breaks the
> + * blacklisting mechanism of AddressSanitizer.
> + */
> +#if defined(__has_feature)
> +# if __has_feature(address_sanitizer)
> +#  define UL_ASAN_BLACKLIST __attribute__((no_sanitize_address))
> +# else
> +#  define UL_ASAN_BLACKLIST    /* nothing */
> +# endif
> +#else
> +# define UL_ASAN_BLACKLIST     /* nothing */
> +#endif
> +

it would be better to follow our current manner and use directly
__attribute__ in code than introduce extra layer of macros. All
you need is define empty no_sanitize_address 
if !__has_feature(address_sanitizer).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
