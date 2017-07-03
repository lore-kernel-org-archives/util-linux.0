Return-Path: util-linux-owner@vger.kernel.org
Received: from hotei.ga-group.nl ([138.201.147.219]:42376 "EHLO
        hotei.ga-group.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753202AbdGCIvg (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 3 Jul 2017 04:51:36 -0400
From: Ruediger Meier <ruediger.meier@ga-group.nl>
To: J William Piggott <elseifthen@gmx.com>
Subject: Re: [PATCH 3/5] hwclock: final usage() strings slice
Date: Mon, 3 Jul 2017 10:51:27 +0200
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com> <40df38f4-6bf5-1959-74af-6ee481b88a12@gmx.com>
In-Reply-To: <40df38f4-6bf5-1959-74af-6ee481b88a12@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <201707031051.27992.ruediger.meier@ga-group.nl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sunday 02 July 2017, J William Piggott wrote:
> 
> Signed-off-by: J William Piggott <elseifthen@gmx.com>
> ---
>  sys-utils/hwclock.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index eeb68e7..19d7652 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -1238,7 +1238,8 @@ usage(const struct hwclock_control *ctl)
>  #endif
>  	puts(_("     --update-drift   update the RTC drift factor"));
>  	printf(_(
> -	       "     --noadjfile      do not use %1$s\n"
> +	       "     --noadjfile      do not use %1$s\n"), _PATH_ADJTIME);
> +	printf(_(
>  	       "     --adjfile <file> use an alternate file to %1$s\n"), _PATH_ADJTIME);
>  	puts(_("     --test           dry run; use -D to view what would have happened"));
>  	puts(_(" -D, --debug          use debug mode"));

What about




> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

What about the mentioned whitespaces for puts() to get printf
on one line? 

  puts(  _("     --update-drift   update the RTC drift factor"));
  printf(_("     --noadjfile      do not use %1$s\n"), _PATH_ADJTIME);
  printf(_("     --adjfile <file> use an alternate file to %1$s\n"), _PATH_ADJTIME);
  puts(  _("     --test           dry run; use -D to view what would have happened"));
  puts(  _(" -D, --debug          use debug mode"));

cu,
Rudi
