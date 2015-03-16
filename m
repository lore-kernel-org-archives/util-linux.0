Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40324 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753770AbbCPKt4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Mar 2015 06:49:56 -0400
Date: Mon, 16 Mar 2015 11:49:54 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Rainer Gerhards <rgerhards@adiscon.com>
Subject: Re: [PATCH 5/8] logger: fix rfc5424 format crash
Message-ID: <20150316104954.GE28925@ws.net.home>
References: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
 <1426424094-25451-6-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426424094-25451-6-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 15, 2015 at 12:54:51PM +0000, Sami Kerola wrote:
> $ logger --rfc5424=notq message
> Segmentation fault (core dumped)

Not sure if Rainer is subscribed to the list, so please keep him in CC.

> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  misc-utils/logger.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/misc-utils/logger.c b/misc-utils/logger.c
> index 838d225..b007377 100644
> --- a/misc-utils/logger.c
> +++ b/misc-utils/logger.c
> @@ -476,7 +476,8 @@ static void syslog_rfc5424_header(struct logger_ctl *const ctl)
>  #endif
>  			xasprintf(&structured_data,
>  				 "[timeQuality tzKnown=\"1\" isSynced=\"0\"]");
> -	}
> +	} else
> +		structured_data = xstrdup("");

RFC5424:

    STRUCTURED-DATA = NILVALUE / 1*SD-ELEMENT

    NILVALUE        = "-"


... so I guess "" is bad idea. I'll fix it before commit.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
