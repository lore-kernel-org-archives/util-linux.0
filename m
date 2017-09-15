Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751213AbdIOLFv (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 15 Sep 2017 07:05:51 -0400
Date: Fri, 15 Sep 2017 13:05:47 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] logger: fix memory leaks [asan]
Message-ID: <20170915110547.7znrzkpd7wf3mmdq@ws.net.home>
References: <20170911195717.817-1-kerolasa@iki.fi>
 <20170911195717.817-3-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170911195717.817-3-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 11, 2017 at 08:57:16PM +0100, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  misc-utils/logger.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/misc-utils/logger.c b/misc-utils/logger.c
> index f6fb350cc..4eba778b9 100644
> --- a/misc-utils/logger.c
> +++ b/misc-utils/logger.c
> @@ -606,25 +606,30 @@ static char *strdup_structured_data(struct structured_data *sd)
>  
>  	xasprintf(&res, "[%s %s]", sd->id,
>  			(tmp = strv_join(sd->params, " ")));
> +	free(sd->id);
> +	strv_free(sd->params);
>  	free(tmp);
>  	return res;
>  }

This is strdup-like function, why do you touch the argument 'sd' ?
It's has to copy and nothing else.

>  static char *strdup_structured_data_list(struct list_head *ls)
>  {
> -	struct list_head *p;
> +	struct list_head *p, *pnext;
>  	char *res = NULL;
>  
> -	list_for_each(p, ls) {
> +	list_for_each_safe(p, pnext, ls) {
>  		struct structured_data *sd = list_entry(p, struct structured_data, sds);
>  		char *one = strdup_structured_data(sd);
>  		char *tmp = res;
>  
> -		if (!one)
> +		if (!one) {
> +			free(tmp);

 tmp contains result from the previous loop

>  			continue;
> +		}
>  		res = strappend(tmp, one);
>  		free(tmp);
>  		free(one);
> +		free(sd);
>  	}

 again, I don't see reason to deallocate 'sd' in strdup-like function.
 It just converts the list to string and nothing else. It's also crazy
 to use free() for linked list member.

 The list contains information specified by user on command line, if
 you deallocate the list then the next attempt to generate a header
 will produce incomplete information.

 All the story seems like free-before-exit. We don't care about it.

 The mem-leaks are bad thing in daemons, libs, libs tests, and
 allocation in loop is dangerous, otherwise for command line utils you
 waste time with this kind of free() calls, because kernel on exit()
 will be faster to remove all the program from memory. 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
