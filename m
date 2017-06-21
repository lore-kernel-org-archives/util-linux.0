Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55040 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752685AbdFUJ0v (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 05:26:51 -0400
Date: Wed, 21 Jun 2017 11:26:47 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 11/12] hwclock: remove unused usage() FILE argument
Message-ID: <20170621092647.b7zgmeeqflfmc2mt@ws.net.home>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
 <ce8ce9d6-d266-12da-8e7e-c41e6a185714@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ce8ce9d6-d266-12da-8e7e-c41e6a185714@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 18, 2017 at 08:49:49PM -0400, J William Piggott wrote:
> 
> Signed-off-by: J William Piggott <elseifthen@gmx.com>
> ---
>  sys-utils/hwclock.c | 74 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index 7d69b7a..636d36a 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -1200,49 +1200,49 @@ static void out_version(void)
>  }
>  
>  static void __attribute__((__noreturn__))
> -usage(const struct hwclock_control *ctl, FILE *out)
> +usage(const struct hwclock_control *ctl)
>  {
> -	fputs(USAGE_HEADER, out);
> -	fputs(_(" hwclock [function] [option...]\n"), out);
> -
> -	fputs(USAGE_SEPARATOR, out);
> -	fputs(_(" Query or set the RTC (Real Time Clock / Hardware Clock)\n"), out);
> -
> -	fputs(USAGE_FUNCTIONS, out);
> -	fputs(_(" -r, --show           display the RTC time\n"), out);
> -	fputs(_("     --get            display drift corrected RTC time\n"), out);
> -	fputs(_("     --set            set the RTC according to --date\n"), out);
> -	fputs(_(" -s, --hctosys        set the system time from the RTC\n"), out);
> -	fputs(_(" -w, --systohc        set the RTC from the system time\n"), out);
> -	fputs(_("     --systz          send timescale configurations to the kernel\n"), out);
> -	fputs(_("     --adjust         adjust the RTC to account for systematic drift\n"), out);
> +	fputs(USAGE_HEADER, stdout);
> +	puts(_(" hwclock [function] [option...]"));
> +
> +	fputs(USAGE_SEPARATOR, stdout);
> +	puts(_(" Query or set the RTC (Real Time Clock / Hardware Clock)"));
            ^
We don't use this space here. Fixed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
