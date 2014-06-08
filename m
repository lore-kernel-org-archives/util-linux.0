Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qa0-f46.google.com ([209.85.216.46]:62323 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbaFHNof (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Jun 2014 09:44:35 -0400
Received: by mail-qa0-f46.google.com with SMTP id i13so327067qae.19
        for <util-linux@vger.kernel.org>; Sun, 08 Jun 2014 06:44:35 -0700 (PDT)
Date: Sun, 8 Jun 2014 09:44:33 -0400
From: Dave Reisner <d@falconindy.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Tobias Klausmann <klausman@schwarzvogel.de>
Subject: Re: [PATCH] libfdisk: fix bsd_translate_fstype() for alpha
Message-ID: <20140608134433.GC2336@rampage>
References: <20140608104251.GA72528@skade.schwarzvogel.de>
 <1402234368-17174-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402234368-17174-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 08, 2014 at 03:32:48PM +0200, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> Reported-by: Tobias Klausmann <klausman@schwarzvogel.de>
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  libfdisk/src/bsd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/libfdisk/src/bsd.c b/libfdisk/src/bsd.c
> index a81afd2..df0fc13 100644
> --- a/libfdisk/src/bsd.c
> +++ b/libfdisk/src/bsd.c
> @@ -773,8 +773,10 @@ static int bsd_translate_fstype (int linux_type)
>  	case 0x06: /* DOS 16-bit >=32M */
>  	case 0xe1: /* DOS access       */
>  	case 0xe3: /* DOS R/O          */
> +#if !defined (__alpha__)
>  	case 0xf2: /* DOS secondary    */
>  		return BSD_FS_MSDOS;
> +#endif

What would be the harm on defining this for platforms which don't
include it? Why is a partition type excluded from this architecture?

>  	case 0x07: /* OS/2 HPFS        */
>  		return BSD_FS_HPFS;
>  	default:
> -- 
> 1.8.4.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
