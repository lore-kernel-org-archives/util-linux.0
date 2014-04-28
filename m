Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:14990 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754270AbaD1JCV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Apr 2014 05:02:21 -0400
Date: Mon, 28 Apr 2014 11:02:11 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 10/12] libsmartcols: remove ununsed assignment
Message-ID: <20140428090211.GN2405@x2.net.home>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
 <1398629138-31718-11-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398629138-31718-11-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 27, 2014 at 09:05:36PM +0100, Sami Kerola wrote:
> Value stored to 'rc' is never read.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  libsmartcols/src/table_print.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libsmartcols/src/table_print.c b/libsmartcols/src/table_print.c
> index 2942053..4df587e 100644
> --- a/libsmartcols/src/table_print.c
> +++ b/libsmartcols/src/table_print.c
> @@ -739,7 +739,7 @@ int scols_print_table(struct libscols_table *tb)
>  		return -ENOMEM;
>  
>  	if (!(scols_table_is_raw(tb) || scols_table_is_export(tb)))
> -		rc = recount_widths(tb, buf);
> +		recount_widths(tb, buf);

 It would be better to check 'rc'.

        if (rc)
           goto done;

 or so...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
