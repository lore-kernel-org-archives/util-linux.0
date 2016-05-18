Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.magicbluesmoke.com ([82.195.144.49]:60892 "EHLO
	mail.magicbluesmoke.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbcERNMy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 18 May 2016 09:12:54 -0400
Subject: Re: cal(1) year formatting
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20160518125100.gqvcbbfx23tti6re@ws.net.home>
From: =?UTF-8?Q?P=c3=a1draig_Brady?= <P@draigBrady.com>
Message-ID: <573C6891.1070009@draigBrady.com>
Date: Wed, 18 May 2016 14:05:21 +0100
MIME-Version: 1.0
In-Reply-To: <20160518125100.gqvcbbfx23tti6re@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 18/05/16 13:51, Karel Zak wrote:
>
>   See the patch below. I have no strong opinion about it, any
>   objection?
>
>      Karel
>
>
>>From e671a62ef8574b16cd6acbfd04dc35c514b184e5 Mon Sep 17 00:00:00 2001
> From: Karel Zak <kzak@redhat.com>
> Date: Wed, 18 May 2016 14:43:20 +0200
> Subject: [PATCH] cal: use %04d for year
>
> It seems that people are crazy enough to assume that "cal 16" is the
> year 2016, rather than 16 (2000 years ago).
>
> This patch makes it more clear as the output is 0016.
>
> Addresses: https://github.com/karelzak/util-linux/issues/320
> Signed-off-by: Karel Zak <kzak@redhat.com>
> ---
>   misc-utils/cal.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/misc-utils/cal.c b/misc-utils/cal.c
> index 2a53b89..3e20530 100644
> --- a/misc-utils/cal.c
> +++ b/misc-utils/cal.c
> @@ -516,7 +516,7 @@ static void headers_init(struct cal_control *ctl)
>   	char tmp[FMT_ST_CHARS];
>   	int year_len;
>
> -	year_len = snprintf(tmp, sizeof(tmp), "%d", ctl->req.year);
> +	year_len = snprintf(tmp, sizeof(tmp), "%04d", ctl->req.year);
>
>   	if (year_len < 0 || (size_t)year_len >= sizeof(tmp)) {
>   		/* XXX impossible error */
> @@ -612,13 +612,13 @@ static void cal_output_header(struct cal_month *month, const struct cal_control
>   		if (!ctl->header_year) {
>   			my_putstring("\n");
>   			for (i = month; i; i = i->next) {
> -				sprintf(out, _("%d"), i->year);
> +				sprintf(out, _("%04d"), i->year);
>   				center(out, ctl->week_width - 1, i->next == NULL ? 0 : ctl->gutter_width);
>   			}
>   		}
>   	} else {
>   		for (i = month; i; i = i->next) {
> -			sprintf(out, _("%s %d"), ctl->full_month[i->month - 1], i->year);
> +			sprintf(out, _("%s %04d"), ctl->full_month[i->month - 1], i->year);
>   			center(out, ctl->week_width - 1, i->next == NULL ? 0 : ctl->gutter_width);
>   		}
>   	}
> @@ -762,7 +762,7 @@ static void yearly(const struct cal_control *ctl)
>   		year_width--;
>
>   	if (ctl->header_year) {
> -		sprintf(out, "%d", ctl->req.year);
> +		sprintf(out, "%04d", ctl->req.year);
>   		center(out, year_width, 0);
>   		my_putstring("\n\n");
>   	}
>

more upsides than downsides so +1 from me
