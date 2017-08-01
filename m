Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751607AbdHAJmQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 1 Aug 2017 05:42:16 -0400
Date: Tue, 1 Aug 2017 11:42:12 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 9/9] agetty: fix invalid usage crash
Message-ID: <20170801094212.72yitooyxbnq6o4j@ws.net.home>
References: <20170731195508.11661-1-kerolasa@iki.fi>
 <20170731195508.11661-10-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170731195508.11661-10-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 31, 2017 at 08:55:08PM +0100, Sami Kerola wrote:
> $ agetty
> agetty: not enough arguments: Success
> Segmentation fault (core dumped)
> 
> Reference: 9325dbfd2018b2a3b510617f4aa13777fbbe23c3
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  term-utils/agetty.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/term-utils/agetty.c b/term-utils/agetty.c
> index f06b9fc6e..d9e9548fa 100644
> --- a/term-utils/agetty.c
> +++ b/term-utils/agetty.c
> @@ -803,7 +803,8 @@ static void parse_args(int argc, char **argv, struct options *op)
>  
>  	if (argc < optind + 1) {
>  		log_warn(_("not enough arguments"));
> -		warn(_("not enough arguments"));
> +		warnx(_("not enough arguments"));
> +		errtryhelp(EXIT_FAILURE);
>  	}
>  
>  	/* Accept "tty", "baudrate tty", and "tty baudrate". */
> @@ -812,7 +813,8 @@ static void parse_args(int argc, char **argv, struct options *op)
>  		parse_speeds(op, argv[optind++]);
>  		if (argc < optind + 1) {
>  			log_warn(_("not enough arguments"));
> -			warn(_("not enough arguments"));
> +			warnx(_("not enough arguments"));
> +			exit(EXIT_FAILURE);

what about:

            errx(EXIT_FAILURE, _("not enough arguments"));

   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
