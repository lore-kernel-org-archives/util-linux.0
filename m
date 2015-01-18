Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:49539 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbbARVVz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 18 Jan 2015 16:21:55 -0500
Message-ID: <54BC2307.9090806@gmx.com>
Date: Sun, 18 Jan 2015 16:17:59 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH] docs: fix two "maybe be" duplications in program comments
References: <1421614227-5938-1-git-send-email-bensberg@justemail.net>
In-Reply-To: <1421614227-5938-1-git-send-email-bensberg@justemail.net>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 01/18/2015 03:50 PM, Benno Schulenberg wrote: 
>  	if (!tb->is_term)
>  		return 0;
>  
> -	/* reduce columns with extreme fields
> -	 */
> +	/* reduce columns with extreme fields */
>  	if (width > tb->termwidth && extremes) {
>  		DBG(TAB, ul_debugobj(tb, "   reduce width (extreme columns)"));
>

This is a common practice to add some delimiting space between a
comment and the code; just as the the empty line above it does.


> @@ -710,7 +708,7 @@ static int recount_widths(struct libscols_table *tb, struct libscols_buffer *buf
>  		if (width < tb->termwidth && scols_table_is_maxout(tb)) {
>  			DBG(TAB, ul_debugobj(tb, "   enlarge width (max-out)"));
>  
> -			/* try enlarge all columns */
> +			/* try enlarging all columns */
>  			while (width < tb->termwidth) {
>  				scols_reset_iter(&itr, SCOLS_ITER_FORWARD);
>  				while (scols_table_next_column(tb, &itr, &cl) == 0) {
> @@ -735,7 +733,7 @@ static int recount_widths(struct libscols_table *tb, struct libscols_buffer *buf
>  	}
>  
>  	/* bad, we have to reduce output width, this is done in two steps:
> -	 * 1/ reduce columns with a relative width and with truncate flag
> +	 * 1) reduce columns with a relative width and with truncate flag
>  	 * 2) reduce columns with a relative width without truncate flag
>  	 */
>  	trunc_only = 1;
> 
