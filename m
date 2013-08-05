Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16718 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754165Ab3HEIoc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 5 Aug 2013 04:44:32 -0400
Date: Mon, 5 Aug 2013 10:44:23 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] mkswap: add run time warning when maximum number of
 pages is exceeded
Message-ID: <20130805084423.GB15105@x2.net.home>
References: <1375610390-3590-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375610390-3590-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 04, 2013 at 10:59:50AM +0100, Sami Kerola wrote:
> The commit f1477c4 mentioned in manual page swap header has a hard limit
> for usable page count, which user will very likely miss unless there is a
> run time warning.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  disk-utils/mkswap.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
> index 71503f4..16e7b1e 100644
> --- a/disk-utils/mkswap.c
> +++ b/disk-utils/mkswap.c
> @@ -556,6 +556,9 @@ main(int argc, char **argv) {
>  			(long)(MIN_GOODPAGES * pagesize/1024));
>  		usage(stderr);
>  	}
> +	if (UINT_MAX < PAGES)
> +		warnx(_("warning: swap area exceeds greatest number of supported pages by %llu"),
> +			PAGES - UINT_MAX);

 I don't think this is necessary... what about the "if (PAGES >
 maxpages)" check in the code?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
