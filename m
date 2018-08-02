Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbeHBKld (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 2 Aug 2018 06:41:33 -0400
Date: Thu, 2 Aug 2018 10:51:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] mesg: do not print 'ttyname failed' message unless
 --verbose requested
Message-ID: <20180802085117.vwbtc7kwkcphhelv@ws.net.home>
References: <20180801212644.1652-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180801212644.1652-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 01, 2018 at 10:26:44PM +0100, Sami Kerola wrote:
> Lots of people are confused why mesg(1) is priting this message.  Usual
> cause seems to be an uninteractive shell trying to turn running 'mesg n'
> from a /root/.profile where command invocation is by default on debian based
> systems.  This might be rare case when failing silently is better.
> 
> Reference: https://www.google.com/search?q=mesg+ttyname+failed
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  term-utils/mesg.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/term-utils/mesg.c b/term-utils/mesg.c
> index 8714ad1aa..7c4e390bb 100644
> --- a/term-utils/mesg.c
> +++ b/term-utils/mesg.c
> @@ -121,8 +121,11 @@ int main(int argc, char *argv[])
>  	argc -= optind;
>  	argv += optind;
>  
> -	if ((tty = ttyname(STDERR_FILENO)) == NULL)
> -		err(MESG_EXIT_FAILURE, _("ttyname failed"));
> +	if ((tty = ttyname(STDERR_FILENO)) == NULL) {
> +		if (verbose == TRUE)
> +			err(MESG_EXIT_FAILURE, _("ttyname failed"));
> +		exit(MESG_EXIT_FAILURE);
> +	}

What about:

if (isatty(STDERR_FILENO)) {
    if (verbose)
        warnx(_("no tty"));
    exit(MESG_EXIT_FAILURE);
}

tty = ttyname(STDERR_FILENO);
if (!tty)
   ... the current code ...


   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
