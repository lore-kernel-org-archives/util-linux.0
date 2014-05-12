Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13923 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559AbaELMFW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 May 2014 08:05:22 -0400
Date: Mon, 12 May 2014 14:05:11 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/12] term-utils: avoid error message string length
 couting errors
Message-ID: <20140512120511.GF8951@x2.net.home>
References: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
 <1399836409-7769-7-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399836409-7769-7-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 11, 2014 at 08:26:44PM +0100, Sami Kerola wrote:
> diff --git a/term-utils/ttymsg.c b/term-utils/ttymsg.c
> index fb2614f..3a2565d 100644
> --- a/term-utils/ttymsg.c
> +++ b/term-utils/ttymsg.c
> @@ -58,6 +58,8 @@
>  #include "pathnames.h"
>  #include "ttymsg.h"
>  
> +enum { ERR_BUFLEN = MAXNAMLEN + 1024 };

 Please, don't use enum in this way, just

    #define ERR_BUFLEN  ...

>  	if (strlen(line) + sizeof(_PATH_DEV) + 1 > sizeof(device)) {
>  		sprintf(errbuf, _("excessively long line arg"));
> -		return (errbuf);
> +		return errbuf;
>  	}

 I have fixed the code to use snprintf() everywhere and to check
 snprintf() return code, that's better than the crazy strlen()+...
 check. 
 
 libc is smart enough to help us.

> +		errbuf[ERR_BUFLEN] = 0;

 Are you sure? :-)

 Fixed and merged.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
