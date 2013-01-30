Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44099 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734Ab3A3PBK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 30 Jan 2013 10:01:10 -0500
Date: Wed, 30 Jan 2013 16:01:00 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] dmesg: fix typo
Message-ID: <20130130150100.GG3741@x2.net.home>
References: <1359214946-13515-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359214946-13515-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jan 26, 2013 at 03:42:26PM +0000, Sami Kerola wrote:
> My mistake in commit fbbc4c88d5273c46db065594493261eb9bb1a2c4.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  sys-utils/dmesg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
> index a307d84..48c121f 100644
> --- a/sys-utils/dmesg.c
> +++ b/sys-utils/dmesg.c
> @@ -236,7 +236,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
>  		fprintf(stderr, " %7s - %s\n",
>  			level_names[i].name,
>  			_(level_names[i].help));
> -	fputc(USAGE_SEPARATOR, out);
> +	fputs(USAGE_SEPARATOR, out);

 Ah.. already fixed ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
