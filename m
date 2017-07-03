Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: J William Piggott <elseifthen@gmx.com>
Subject: Re: [PATCH 2/5] hwclock: usage() use program_invocation_short_name
Date: Mon, 3 Jul 2017 10:46:45 +0200
Cc: Karel Zak <kzak@redhat.com>,
 util-linux@vger.kernel.org
References: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com> <d0d5b0b9-184d-7733-3116-406c9033d927@gmx.com>
In-Reply-To: <d0d5b0b9-184d-7733-3116-406c9033d927@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <201707031046.45954.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Sunday 02 July 2017, J William Piggott wrote:
> 
> Signed-off-by: J William Piggott <elseifthen@gmx.com>
> ---
>  sys-utils/hwclock.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index 8b1e2f3..eeb68e7 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -1203,7 +1203,7 @@ static void __attribute__((__noreturn__))
>  usage(const struct hwclock_control *ctl)
>  {
>  	fputs(USAGE_HEADER, stdout);
> -	puts(_(" hwclock [function] [option...]"));
> +	printf(_(" %s [function] [option...]\n"), program_invocation_short_name);
>  
>  	fputs(USAGE_SEPARATOR, stdout);
>  	puts(_("Query or set the RTC (Real Time Clock / Hardware Clock)"));
> @@ -1222,8 +1222,10 @@ usage(const struct hwclock_control *ctl)
>  #endif
>  	puts(_("     --predict        predict the drifted RTC time according to --date"));
>  	fputs(USAGE_OPTIONS, stdout);
> -	puts(_(" -u, --utc            inform hwclock the RTC timescale is UTC"));
> -	puts(_(" -l, --localtime      inform hwclock the RTC timescale is Local"));
> +	printf(_(
> +	       " -u, --utc            inform %s the RTC timescale is UTC\n"), program_invocation_short_name);
> +	printf(_(
> +	       " -l, --localtime      inform %s the RTC timescale is Local\n"), program_invocation_short_name);
>  #ifdef __linux__
>  	printf(_(
>  	       " -f, --rtc <file>     use an alternate file to %1$s\n"), _PATH_RTC_DEV);

I'm not sure if this makes really sense. I wouldn't overuse the program
name in general. And in this case I would rather remove the reduntant
term "inform hwclock" as *all* options "inform hwclock" about something. 

cu,
Rudi
