Return-Path: util-linux-owner@vger.kernel.org
Received: from mta04.eastlink.ca ([24.224.136.10]:45528 "EHLO
        mta04.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030613AbeBPPzH (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 16 Feb 2018 10:55:07 -0500
Received: from emgw02.eastlink.ca ([71.7.199.174])
 by mta04.eastlink.ca (Oracle Communications Messaging Server 7.0.5.37.0 64bit
 (built Jan 25 2016)) with ESMTP id <0P4800BL8WU8ZV41@mta04.eastlink.ca> for
 util-linux@vger.kernel.org; Fri, 16 Feb 2018 11:55:06 -0400 (AST)
Date: Fri, 16 Feb 2018 11:55:05 -0400
To: Theodore Ts'o <tytso@mit.edu>
Cc: util-linux@vger.kernel.org, Hornseth_Brenan@bah.com
Subject: Re: [PATCH] fsck: use xasprintf to avoid buffer overruns with an
        insane fs type
Message-id: <20180216155505.GL9479@cordes.ca>
References: <20180215200508.1466-1-tytso@mit.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <20180215200508.1466-1-tytso@mit.edu>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 15, 2018 at 03:05:08PM -0500, Theodore Ts'o wrote:
> This prevents a crash when running the command:
> 
> fsck -t AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA /dev/sda
> 
> Reported-by: Hornseth_Brenan@bah.com
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  disk-utils/fsck.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
> index 58fd8ac59..8a07bc272 100644
> --- a/disk-utils/fsck.c
> +++ b/disk-utils/fsck.c
> @@ -544,20 +544,20 @@ static char *find_fsck(const char *type)
>  {
>  	char *s;
>  	const char *tpl;
> -	static char prog[256];
> +	static char *prog = NULL;

 You're allocating / freeing every time it's used, so it shouldn't be
static anymore.

It might be easier to just use snprintf to truncate long strings,
instead of introducing dynamic allocation which requires explicit
freeing.  OTOH xasprintf makes it re-entrant / thread-safe, at the
cost of forcing the caller to care about memory management.  (And at
the cost of efficiency: prog is allocated / freed inside the loop.)

>  	char *p = xstrdup(fsck_path);
>  
>  	/* Are we looking for a program or just a type? */
>  	tpl = (strncmp(type, "fsck.", 5) ? "%s/fsck.%s" : "%s/%s");
>  
>  	for(s = strtok(p, ":"); s; s = strtok(NULL, ":")) {
> -		sprintf(prog, tpl, s, type);
> +		xasprintf(&prog, tpl, s, type);
>  		if (access(prog, X_OK) == 0)
>  			break;
> +		free(prog); prog = NULL;
>  	}
>  	free(p);
> -
> -	return(s ? prog : NULL);
> +	return(prog);
>  }


-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
