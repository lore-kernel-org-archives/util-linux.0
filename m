Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:49163 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484AbbARVCz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 18 Jan 2015 16:02:55 -0500
Message-ID: <54BC1F79.1030706@gmx.com>
Date: Sun, 18 Jan 2015 16:02:49 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] textual: put option and its description into a single
 translatable string
References: <1421613631-5732-1-git-send-email-bensberg@justemail.net> <1421613631-5732-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1421613631-5732-3-git-send-email-bensberg@justemail.net>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 01/18/2015 03:40 PM, Benno Schulenberg wrote:
> Also improve the description: notime, notq, and nohost are literals,
> not things to be replaced by something else -- so no angular brackets.
> 
> Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
> ---
>  misc-utils/logger.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/misc-utils/logger.c b/misc-utils/logger.c
> index 35caf9d..296f7f0 100644
> --- a/misc-utils/logger.c
> +++ b/misc-utils/logger.c
> @@ -525,8 +525,8 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
>  	fputs(_(" -T, --tcp             use TCP only\n"), out);
>  	fputs(_(" -d, --udp             use UDP only\n"), out);
>  	fputs(_("     --rfc3164         use the obsolete BSD syslog protocol\n"), out);
> -	fputs(_("     --rfc5424[=<notime,notq,nohost>]\n"), out);
> -	fputs(_("                       use the syslog protocol (default)\n"), out);
> +	fputs(_("     --rfc5424[=<cut>] use the syslog protocol (the default);\n"
> +		"                         <cut> can be notime, or notq, and/or nohost\n"), out);

I have never see that done before, it seems confusing.
Isn't the commonly used term 'snip'?



>  	fputs(_(" -u, --socket <socket> write to this Unix socket\n"), out);
>  #ifdef HAVE_LIBSYSTEMD
>  	fputs(_("     --journald[=<file>]  write journald entry\n"), out);
> 
