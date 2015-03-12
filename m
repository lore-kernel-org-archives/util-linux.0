Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43424 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338AbbCLLFf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Mar 2015 07:05:35 -0400
Date: Thu, 12 Mar 2015 12:05:28 +0100
From: Karel Zak <kzak@redhat.com>
To: Petr Gajdos <pgajdos@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: prevent cal segfault
Message-ID: <20150312110528.GA4637@ws.net.home>
References: <20150312084639.GC9756@laura.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150312084639.GC9756@laura.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 12, 2015 at 09:46:39AM +0100, Petr Gajdos wrote:
> cal utility segfaults in putp() when setupterm() fails as cal
> insufficiently checks for setupterm() failure.
> 
> $ TERM= cal
> Segmentation fault

I'm not able to reproduce this problem. Anyway you're right that the
current code is pretty fragile and ignore setupterm() return code is
bad idea.

I have applied a little bit different patch, please test it in your
environment. The patch is also in stable/v2.26 (for v2.26.1).

https://github.com/karelzak/util-linux/commit/2a4b073e8b2d34dfadd8306f7d71957687923bdd


Note that I have doubts we really need so many fallbacks in cal(1)
code. IMHO it would be enough to support two ways: ncurses or just
without any extra terminal support (so stdio.h only). I'll probably 
cleanup this for v2.27 to make the code more maintainable. 

> --- misc-utils/cal.c.orig	2014-08-26 16:48:45.132654654 +0200
> +++ misc-utils/cal.c	2015-03-11 14:16:06.075064939 +0100
> @@ -81,14 +81,22 @@
>  # endif
>  # include <term.h>
>  
> -static void my_setupterm(const char *term, int fildes, int *errret)
> +#if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW) || defined(HAVE_LIBTERMCAP)
> +static const char	*term="";
> +#endif

This seems incorrect, you have moved "#if defined" into another "#if".

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
