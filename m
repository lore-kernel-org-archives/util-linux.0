Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755194AbeCSN3n (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Mar 2018 09:29:43 -0400
Date: Mon, 19 Mar 2018 14:29:39 +0100
From: Karel Zak <kzak@redhat.com>
To: Carlo Caione <carlo@caione.org>
Cc: util-linux@vger.kernel.org, linux@endlessm.com,
        Carlo Caione <carlo@endlessm.com>
Subject: Re: [PATCH] lib/randutils: Do not block on getrandom()
Message-ID: <20180319132939.vaeojajdqmumxk4n@ws.net.home>
References: <20180319103107.14517-1-carlo@caione.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180319103107.14517-1-carlo@caione.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 19, 2018 at 10:31:07AM +0000, Carlo Caione wrote:
> We fix this passing GRND_NONBLOCK to getrandom(). 'sfdisk' will use the
> best entropy it has available and fallback only as necessary.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  lib/randutils.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/randutils.c b/lib/randutils.c
> index e1c4059e1..02c3d9eb0 100644
> --- a/lib/randutils.c
> +++ b/lib/randutils.c
> @@ -36,6 +36,8 @@
>  
>  #if !defined(HAVE_GETRANDOM) && defined(SYS_getrandom)
>  /* libc without function, but we have syscal */
> +#define GRND_NONBLOCK 0x01
> +#define GRND_RANDOM 0x02
>  static int getrandom(void *buf, size_t buflen, unsigned int flags)
>  {
>  	return (syscall(SYS_getrandom, buf, buflen, flags));
> @@ -104,13 +106,15 @@ void random_get_bytes(void *buf, size_t nbytes)
>  		int x;
>  
>  		errno = 0;
> -		x = getrandom(cp, n, 0);
> +		x = getrandom(cp, n, GRND_NONBLOCK);
>  		if (x > 0) {			/* success */
>  		       n -= x;
>  		       cp += x;
>  		       lose_counter = 0;
>  		} else if (errno == ENOSYS)	/* kernel without getrandom() */
>  			break;
> +		else if (errno == EAGAIN)
> +			break;

Applied, but not sure if I like the if-EAGAIN-break there. It will
break in all situations and completely bypass the lose_counter idea.
Maybe it would be better to accept that we will call getrandom() 16x
on systems with uninitialized entropy. (And maybe add xusleep() to the
loop...)

    Karel

>  		else if (lose_counter++ > 16)	/* entropy problem? */
>  			break;
>  	}




> -- 
> 2.14.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
