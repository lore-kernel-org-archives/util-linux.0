Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51107 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbaESJwi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 19 May 2014 05:52:38 -0400
Date: Mon, 19 May 2014 11:52:26 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 09/17] setterm: remove devfs and /dev/vcsa0 support
Message-ID: <20140519095226.GI26357@x2.net.home>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
 <1400421941-14244-10-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400421941-14244-10-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 18, 2014 at 03:05:33PM +0100, Sami Kerola wrote:
> The devfs files /dev/vcc/a* does not need to be supported, and vcsa0 has
> not existed in years if ever.
> 
> Reference: http://lwn.net/Articles/65197/
> Reference: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devices.txt?id=14186fea0cb06bc43181ce239efe0df6f1af260a#n260
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  bash-completion/setterm |  2 +-
>  term-utils/setterm.c    | 26 +++++++-------------------
>  2 files changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/bash-completion/setterm b/bash-completion/setterm
> index a7ef6eb..f47debf 100644
> --- a/bash-completion/setterm
> +++ b/bash-completion/setterm
> @@ -40,7 +40,7 @@ _setterm_module()
>  			;;
>  		'-dump'|'-append')
>  			local NUM_CONS
> -			NUM_CONS=(/sys/class/tty/*)
> +			NUM_CONS=(/dev/vcsa?*)
>  			COMPREPLY=( $(compgen -W "{1..${#NUM_CONS[*]}}" -- $cur) )
>  			return 0
>  			;;
> diff --git a/term-utils/setterm.c b/term-utils/setterm.c
> index d889db4..3a02347 100644
> --- a/term-utils/setterm.c
> +++ b/term-utils/setterm.c
> @@ -724,31 +724,18 @@ static void show_tabs(void)
>  
>  static void __attribute__((__noreturn__)) read_error(struct setterm_control *ctl)
>  {
> -	if (ctl->opt_sn_num != 0)
> -		errx(EXIT_DUMPFILE, _("Couldn't read %s"), ctl->in_device);
> -	else
> -		errx(EXIT_DUMPFILE, _("Couldn't read neither /dev/vcsa0 nor /dev/vcsa"));
> +	err(EXIT_DUMPFILE, _("Couldn't read %s"), ctl->in_device);
>  }

 Sooo.. do we really need read_error()? ;-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
