Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57976 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751671Ab1KWLI6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 23 Nov 2011 06:08:58 -0500
Date: Wed, 23 Nov 2011 12:08:51 +0100
From: Karel Zak <kzak@redhat.com>
To: Dennis Jensen <dennis.h.jensen@siemens.com>, Werner Fink <werner@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: map NL to CR-NL on output in initial termios
	settings
Message-ID: <20111123110851.GA516@nb.net.home>
References: <1321437290.29540.75.camel@djensen-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321437290.29540.75.camel@djensen-laptop>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[CC: to Werner Fink]

On Wed, Nov 16, 2011 at 10:54:50AM +0100, Dennis Jensen wrote:
> This fixes situations where messages "scroll horizontally", making

Do you mean /etc/issue and prompt strings? The terminal end-of-line
should be detected in get_logname() and then the proper flags should
be set in termio_final().

> them unreadable, because agetty has opened and initialized the
> terminal.
> 
> From: Jacoby Hickerson <hickersonjl@gmail.com>
> Signed-off-by: Dennis Jensen <dennis.h.jensen@siemens.com>
> ---
>  term-utils/agetty.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/term-utils/agetty.c b/term-utils/agetty.c
> index 041e1f7..27edac5 100644
> --- a/term-utils/agetty.c
> +++ b/term-utils/agetty.c
> @@ -1091,7 +1091,8 @@ static void termio_init(struct options *op, struct termios *tp)
>  #else
>  	tp->c_iflag = 0;
>  #endif
> -	tp->c_lflag = tp->c_oflag = 0;
> +	tp->c_lflag = 0;
> +	tp->c_oflag = OPOST | ONLCR;

Is it correct to always set ONLCR? Would be better to follow the
current (kernel) setting? I mean:

  tp->c_oflag = (tp->c_oflag & POST) | (tp->c_oflag & ONLCR);

Can you try it?

We use ONLCR for virtual consoles, but for serial lines it depends on
user's input (usersname string).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
