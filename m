Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13384 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753485Ab1JJK7s (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Oct 2011 06:59:48 -0400
Date: Mon, 10 Oct 2011 12:59:45 +0200
From: Karel Zak <kzak@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/6] lscpu: change column names back to mixed case
Message-ID: <20111010105945.GA17242@nb.net.home>
References: <1318237184-6616-1-git-send-email-heiko.carstens@de.ibm.com> <1318237184-6616-4-git-send-email-heiko.carstens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318237184-6616-4-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 10, 2011 at 10:59:41AM +0200, Heiko Carstens wrote:
> Commit b9d18bc3 "lscpu: add column names to --help" changed all column names
> to upper case only and printed the column names for the parsable output in
> lower case.

This is bug. Sorry.

> However current behaviour was that for the parsable output the column names
> were printed in mixed case. The change might break existing other tools and
> breaks also the util-linux internal lscpu tests.
> So revert part of the above commit and restore the old behaviour.

It would be better to fix the code (upper case for the first letter)
than revert the patch.

I think that we want to use the same concept for column names in all
utils (findmnt, lsblk, ...) where we use upper case in help, man pages
and all outputs. 

The old parsable output is exception, the new -e output should be
compatible with the rest of util-linux.

I will fix it. Thanks.

    Karel

> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
>  sys-utils/lscpu.c |   31 ++++++++++++++-----------------
>  1 files changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
> index 7c8cb13..63facc3 100644
> --- a/sys-utils/lscpu.c
> +++ b/sys-utils/lscpu.c
> @@ -224,15 +224,15 @@ enum {
>  static const char *colnames[] =
>  {
>  	[COL_CPU] = "CPU",
> -	[COL_CORE] = "CORE",
> -	[COL_SOCKET] = "SOCKET",
> -	[COL_NODE] = "NODE",
> -	[COL_BOOK] = "BOOK",
> -	[COL_CACHE] = "CACHE",
> -	[COL_POLARIZATION] = "POLARIZATION",
> -	[COL_ADDRESS] = "ADDRESS",
> -	[COL_CONFIGURED] = "CONFIGURED",
> -	[COL_ONLINE] = "ONLINE",
> +	[COL_CORE] = "Core",
> +	[COL_SOCKET] = "Socket",
> +	[COL_NODE] = "Node",
> +	[COL_BOOK] = "Book",
> +	[COL_CACHE] = "Cache",
> +	[COL_POLARIZATION] = "Polarization",
> +	[COL_ADDRESS] = "Address",
> +	[COL_CONFIGURED] = "Configured",
> +	[COL_ONLINE] = "Online",
>  };
>  
>  
> @@ -937,8 +937,6 @@ print_parsable(struct lscpu_desc *desc, int cols[], int ncols,
>  
>  	fputs("# ", stdout);
>  	for (i = 0; i < ncols; i++) {
> -		char *p;
> -
>  		if (cols[i] == COL_CACHE) {
>  			if (mod->compat && !desc->ncaches)
>  				continue;
> @@ -948,11 +946,7 @@ print_parsable(struct lscpu_desc *desc, int cols[], int ncols,
>  		if (i > 0)
>  			putchar(',');
>  
> -		p = data = get_cell_header(desc, cols[i],
> -					   mod, buf, sizeof(buf));
> -		while (p && *p != '\0')
> -			*p++ = tolower((unsigned int) *p);
> -
> +		data = get_cell_header(desc, cols[i], mod, buf, sizeof(buf));
>  		fputs(data && *data ? data : "", stdout);
>  	}
>  	putchar('\n');
> @@ -1000,7 +994,10 @@ print_readable(struct lscpu_desc *desc, int cols[], int ncols,
>  		 err(EXIT_FAILURE, _("failed to initialize output table"));
>  
>  	for (i = 0; i < ncols; i++) {
> -		data = get_cell_header(desc, cols[i], mod, buf, sizeof(buf));
> +		char *p = data = get_cell_header(desc, cols[i],
> +						 mod, buf, sizeof(buf));
> +		while (p && *p != '\0')
> +			*p++ = toupper((unsigned int) *p);
>  		tt_define_column(tt, xstrdup(data), 0, 0);
>  	}
>  
> -- 
> 1.7.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
