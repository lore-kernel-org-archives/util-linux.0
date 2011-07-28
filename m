Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:19066 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754540Ab1G1Wod (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 28 Jul 2011 18:44:33 -0400
Date: Fri, 29 Jul 2011 00:44:30 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [git pull] miscellaneous compiler warning fixes etc
Message-ID: <20110728224430.GB24754@nb.net.home>
References: <CAG27Bk1-X+eqrVwP7cfZp-9-aCBwPtnYYBRJGi7wBt2-zaOMjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk1-X+eqrVwP7cfZp-9-aCBwPtnYYBRJGi7wBt2-zaOMjA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 28, 2011 at 11:33:42PM +0200, Sami Kerola wrote:
> -	iter->done = 1;
> +	iter->done |= 1;

 Why we need this change? IMHO it's unnecessary. "A bit-field is
 interpreted as a signed or unsigned integer type consisting of the
 specified number of bits." (C99)

 [...]

> -	while((i = getopt_long(argc, argv, "+abfiphmoRrvV", longopts, NULL)) != -1)
> +	shortopts = get_shortopts("+", longopts);
> +	while((i = getopt_long(argc, argv, shortopts, longopts, NULL)) != -1)
>  	{
>  		int ret = EXIT_FAILURE;
> 
> @@ -227,11 +275,11 @@ int main(int argc, char **argv)
>  		case 'a':
>  			all_tasks = 1;
>  			break;
> -		case 'b':
>  #ifdef SCHED_BATCH
> +		case 'b':
>  			policy = SCHED_BATCH;
> -#endif
>  			break;
> +#endif
>  		case 'f':
>  			policy = SCHED_FIFO;
>  			break;
> @@ -240,11 +288,11 @@ int main(int argc, char **argv)
>  			policy_flag |= SCHED_RESET_ON_FORK;
>  			break;
>  #endif
> -		case 'i':
>  #ifdef SCHED_IDLE
> +		case 'i':
>  			policy = SCHED_IDLE;
> -#endif
>  			break;
> +#endif
>  		case 'm':
>  			show_min_max();
>  			return EXIT_SUCCESS;
> @@ -271,6 +319,7 @@ int main(int argc, char **argv)
>  			show_usage(ret);
>  		}
>  	}
> +	free(shortopts);

 Hmm... I don't like this patch. 

 Command line options are our API, and the API should be stable
 independently on supported features. The #ifdef for command 
 line options suck...

 Note that SCHED_RESET_ON_FORK should be fixed and -R should be
 silently ignored (now whole "case SCHED_RESET_ON_FORK:" is #ifdefed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
