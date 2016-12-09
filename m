Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752625AbcLINPD (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 9 Dec 2016 08:15:03 -0500
Date: Fri, 9 Dec 2016 14:15:01 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lib/randutils: use getrandom(2) when it is available
Message-ID: <20161209131501.5vmmx6jbg7qnz6f3@ws.net.home>
References: <20161204091259.12651-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161204091259.12651-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 04, 2016 at 09:12:59AM +0000, Sami Kerola wrote:
> +AC_CHECK_FUNCS([getrandom], [], [
> +	AS_IF([UL_CHECK_SYSCALL([getrandom])
> +	  test "$ul_cv_syscall_getrandom" = SYS_getrandom],
> +		[AC_DEFINE([SYSTEM_GETRANDOM], [1],
> +			[Define if getrandom syscall is missing from libc])
> +	])
> +])

I have doubts we need SYSTEM_GETRANDOM macro:

Why not like in another utils (see sched utils for example):

#ifndef HAVE_FALLOCATE
# include <sys/syscall.h>
#else
# include <linux/random.h>
#endif

/* usable kernel-headers, but old glibc-headers */
#if defined (__linux__) && !defined(SYS_getrandom) && defined(__NR_getrandom)
# define SYS_getrandom __NR_getrandom
#endif

/* libc without function, but we have syscal */
#if !defined(HAVE_GETRANDOM) && defined(SYS_getrandom)
static int getrandom(void *buf, size_t buflen, unsigned int flags)
{
    return (syscall(SYS_getrandom, buf, buflen, flags));
}
#define HAVE_GETRANDOM
#endif


>  /*
>   * Generate a stream of random nbytes into buf.
>   * Use /dev/urandom if possible, and if not,
> @@ -72,10 +87,19 @@ int random_get_fd(void)
>   */
>  void random_get_bytes(void *buf, size_t nbytes)
>  {
> -	size_t i, n = nbytes;
> +	size_t i;
> +	unsigned char *cp = (unsigned char *)buf;
> +
> +#if defined(SYSTEM_GETRANDOM) || defined(HAVE_GETRANDOM)

#ifdef HAVE_GETRANDOM

>  const char *random_tell_source(void)
>  {
> +#if defined(SYSTEM_GETRANDOM)
> +	return _("syscall(SYS_getrandom) function");
> +#elif defined(HAVE_GETRANDOM)
> +	return _("libc getrandom() function");
> +#else

seems like overkill :-)

#ifdef HAVE_GETRANDOM
    return _("getrandom function");
#else
    ...


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
