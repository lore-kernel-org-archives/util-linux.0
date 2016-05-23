Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35113 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbcEWVan (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 23 May 2016 17:30:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id f75so295325wmf.2
        for <util-linux@vger.kernel.org>; Mon, 23 May 2016 14:30:42 -0700 (PDT)
Subject: Re: [PATCH] cal: drop trailing blank line
To: Mike Frysinger <vapier@gentoo.org>, util-linux@vger.kernel.org
References: <1464037332-21996-1-git-send-email-vapier@gentoo.org>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <5743767D.3010904@gmail.com>
Date: Mon, 23 May 2016 16:30:37 -0500
MIME-Version: 1.0
In-Reply-To: <1464037332-21996-1-git-send-email-vapier@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mike Frysinger wrote:
> There's no history to be found behind this, and the comment in the
> code indicates no one else knows, and it makes me angry :).
>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>   misc-utils/cal.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/misc-utils/cal.c b/misc-utils/cal.c
> index 3e20530..479c967 100644
> --- a/misc-utils/cal.c
> +++ b/misc-utils/cal.c
> @@ -767,9 +767,6 @@ static void yearly(const struct cal_control *ctl)
>   		my_putstring("\n\n");
>   	}
>   	monthly(ctl);
> -
> -	/* Is empty line at the end year output really needed? */
> -	my_putstring("\n");
>   }
>
>   /*

Personally I like the blank line. It sets off the cal output from the 
shell prompt making it easier to read.  It is basically adding the 
equivalent of the css property padding-bottom="1em".

I note that if doing a 'cal -y' that there is also a blank line between 
the year and February.  That should stay also.

   -- Bruce Dubbs
      linuxfromscratch.org

