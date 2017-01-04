Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965015AbdADLG3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 4 Jan 2017 06:06:29 -0500
Date: Wed, 4 Jan 2017 12:06:27 +0100
From: Karel Zak <kzak@redhat.com>
To: The Flying Rapist <impeccableenglish@gmail.com>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>,
        The Flying Rapist <admin@nosuck.org>
Subject: Re: [PATCH] col: backspacing widechars
Message-ID: <20170104110627.gwd2spbznfw4lssg@ws.net.home>
References: <20161228093620.5528-1-ImpeccableEnglish@gmail.com>
 <CAG27Bk1eCMakhnbcmQZpYVvcYF2K+eYSekaQQFxUU5UPXfa2gA@mail.gmail.com>
 <20161228204237.GA29001@creation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161228204237.GA29001@creation>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 28, 2016 at 03:42:37PM -0500, The Flying Rapist wrote:
> On 2016年12月28日 14時55分, Sami Kerola wrote:
> > May I remind howto-contribute[1] tells 'using your real name (sorry,
> > no pseudonyms
> > or anonymous contributions.)'
> 
> I apologize.  I missed that part of howto-contribute.txt.  Please accept the following.
> 
> From: Grady Martin <admin@nosuck.org>

Thanks.

> 
> Until now, backspace characters have not accounted for characters of widths other than one.  This single line amends that.
> ---
> text-utils/col.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/text-utils/col.c b/text-utils/col.c
> index 9b0e23058..c63b46fee 100644
> --- a/text-utils/col.c
> +++ b/text-utils/col.c
> @@ -248,7 +248,7 @@ int main(int argc, char **argv)
>                        case BS:                /* can't go back further */
>                                if (cur_col == 0)
>                                        continue;
> -                               --cur_col;
> +                               cur_col -= c->c_width;
>                                continue;

Where the c->c_width is initialized? It seems 'c' may be uninitialized
or points for wrong char. What happen if I press BS more than once? Is
'c' initialized for the right char?  

I'm asking because I'm not sure, the code seems strange at the first
glance.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
