Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751737AbdB1NuI (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 28 Feb 2017 08:50:08 -0500
Date: Tue, 28 Feb 2017 14:39:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] setterm: fix bitfield warning [smatch]
Message-ID: <20170228133952.ymkupqcuyysbuie6@ws.net.home>
References: <20170225173517.16922-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170225173517.16922-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Feb 25, 2017 at 05:35:17PM +0000, Sami Kerola wrote:
> term-utils/setterm.c:179:27: warning: dubious bitfield without explicit
> `signed' or `unsigned'
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  term-utils/setterm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/term-utils/setterm.c b/term-utils/setterm.c
> index 1cf59957b..8e969c2b3 100644
> --- a/term-utils/setterm.c
> +++ b/term-utils/setterm.c
> @@ -176,7 +176,7 @@ struct setterm_control {
>  	int opt_rt_len;		/* regular tab length */
>  	int opt_tb_array[TABS_MAX + 1];	/* array for tab list */
>  	/* colors */
> -	int opt_fo_color:4, opt_ba_color:4, opt_ul_color:4, opt_hb_color:4;
> +	unsigned int opt_fo_color:4, opt_ba_color:4, opt_ul_color:4, opt_hb_color:4;

Often and stupid bug, good catch.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
