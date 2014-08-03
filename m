Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.17.24]:56481 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbaHCXYs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Aug 2014 19:24:48 -0400
Message-ID: <53DEC4B2.6020806@bernhard-voelker.de>
Date: Mon, 04 Aug 2014 01:24:34 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 8/8] zramctl: allow use of --algorithm and --streams alone
References: <1407107290-5806-1-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1407107290-5806-1-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08/04/2014 01:08 AM, Sami Kerola wrote:
> Earlier the --algorithm and --streams had to be combined with --size.  To
> user requirement to combine with --size was indirectly told using
> following message.

Sorry, I can't parse this. What do you mean?

> $ zramctl --stream 3 zram3
> zramctl: options --algorithm, --find and --streams are mutually exclusive
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  sys-utils/zramctl.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
> index afbc0e8..43b7dcb 100644
> --- a/sys-utils/zramctl.c
> +++ b/sys-utils/zramctl.c
> @@ -388,7 +388,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
>  	fputs(_("     --raw                 use raw status output format\n"), out);
>  	fputs(_(" -r, --reset               reset all specified devices\n"), out);
>  	fputs(_(" -s, --size <size>         device size\n"), out);
> -	fputs(_(" -t, --streams <number>    number of compressoin streams\n\n"), out);
> +	fputs(_(" -t, --streams <number>    number of compressoin streams\n"), out);

s/compressoin/compression/

Have a nice day,
Berny
