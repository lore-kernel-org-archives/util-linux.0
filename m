Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:11744 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbaESKCe (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 19 May 2014 06:02:34 -0400
Date: Mon, 19 May 2014 12:02:24 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 13/17] setterm: tell user when options does not effect
Message-ID: <20140519100224.GK26357@x2.net.home>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
 <1400421941-14244-14-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400421941-14244-14-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 18, 2014 at 03:05:37PM +0100, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  term-utils/setterm.c | 83 ++++++++++++++++++++++++++++------------------------
>  1 file changed, 45 insertions(+), 38 deletions(-)
> 
> diff --git a/term-utils/setterm.c b/term-utils/setterm.c
> index f1ed862..2a0162e 100644
> --- a/term-utils/setterm.c
> +++ b/term-utils/setterm.c
> @@ -792,6 +792,17 @@ static void screendump(struct setterm_control *ctl)
>  	return;
>  }
>  
> +/* Some options are applicable when terminal is virtual console. */
> +static int vc_only(struct setterm_control *ctl, const char *err)
> +{
> +	if (!ctl->vcterm) {
> +		if (err)
> +			warnx(_("terminal %s does not support %s"),
> +			      ctl->opt_te_terminal_name, err);
> +	}
> +	return ctl->vcterm;
> +}
> +
>  static void perform_sequence(struct setterm_control *ctl)
>  {
>  	int result;
> @@ -812,49 +823,45 @@ static void perform_sequence(struct setterm_control *ctl)
>  			putp(ti_entry("civis"));
>  	}
>  
> -	/* -linewrap [on|off]. Vc only (vt102) */
> -	if (ctl->opt_linewrap && ctl->vcterm)
> +	/* -linewrap [on|off]. */
> +	if (ctl->opt_linewrap && vc_only(ctl, "-linewrap"))
>  		fputs(ctl->opt_li_on ? "\033[?7h" : "\033[?7l", stdout);
>  
> -	/* -repeat [on|off]. Vc only (vt102) */
> -	if (ctl->opt_repeat && ctl->vcterm)
> +	/* -repeat [on|off]. */
> +	if (ctl->opt_repeat && vc_only(ctl, "-repeat"))

 Please use complete long options in error messages ("--repeat" rather 
 than "-repeat").

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
