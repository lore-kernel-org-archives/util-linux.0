Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48184 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756488Ab2CETwb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Mar 2012 14:52:31 -0500
Received: by vcqp1 with SMTP id p1so3717729vcq.19
        for <util-linux@vger.kernel.org>; Mon, 05 Mar 2012 11:52:31 -0800 (PST)
Date: Mon, 5 Mar 2012 14:52:28 -0500
From: Dave Reisner <d@falconindy.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 15/17] include: add asprintf wrapper
Message-ID: <20120305195228.GD838@rampage>
References: <20120305123847.GD486@x2.net.home>
 <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
 <1330976334-10751-16-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330976334-10751-16-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 05, 2012 at 08:38:52PM +0100, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  include/xalloc.h |   11 +++++++++++
>  1 file changed, 11 insertions(+)

maybe add xasprintf to tools/checkxalloc.sh as well?

> diff --git a/include/xalloc.h b/include/xalloc.h
> index feeb114..8c22ff7 100644
> --- a/include/xalloc.h
> +++ b/include/xalloc.h
> @@ -63,4 +63,15 @@ static inline char *xstrdup(const char *str)
>          return ret;
>  }
>  
> +static inline int xasprintf(char **strp, char *fmt, ...)
> +{
> +	int ret;
> +	va_list args;
> +	va_start(args, fmt);
> +	ret = vasprintf(&(*strp), fmt, args);
> +	va_end(args);
> +	if (ret < 0)
> +		err(XALLOC_EXIT_CODE, "cannot allocate string");
> +	return ret;
> +}
>  #endif
> -- 
> 1.7.9.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
