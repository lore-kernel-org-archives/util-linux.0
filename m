Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53378 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbbBXMem (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Feb 2015 07:34:42 -0500
Date: Tue, 24 Feb 2015 13:34:30 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 02/13] rtcwake: enumerate constant mode strings
Message-ID: <20150224123430.GQ19430@ws.net.home>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
 <1424616139-638-3-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424616139-638-3-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 22, 2015 at 02:42:08PM +0000, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  sys-utils/rtcwake.c | 126 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 78 insertions(+), 48 deletions(-)
> 
> diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
> index 8b5f69c..372e620 100644
> --- a/sys-utils/rtcwake.c
> +++ b/sys-utils/rtcwake.c
> @@ -52,7 +52,37 @@
>  #define RTC_PATH		"/sys/class/rtc/%s/device/power/wakeup"
>  #define SYS_POWER_STATE_PATH	"/sys/power/state"
>  #define DEFAULT_DEVICE		"/dev/rtc0"
> -#define DEFAULT_MODE		"standby"
> +
> +enum rtc_modes {	/* manual page --mode option explains these. */
> +	STANDBY_MODE = 0,
> +	MEM_MODE,
> +	FREEZE_MODE,
> +	DISK_MODE,	/* end of Documentation/power/states.txt modes  */
> +	OFF_MODE,
> +	NO_MODE,
> +	ON_MODE,	/* smaller <- read the code */
> +	DISABLE_MODE,	/* greater <- to understand */
> +	SHOW_MODE,
> +	ERROR_MODE	/* invalid user input */
> +};

Please, don't use ERROR_MODE or so, just return -EINVAL from the
parser.

> +static int get_mode(const char *optarg)
> +{
> +	if (!strcmp(optarg, mode_str[STANDBY_MODE]))
> +		return STANDBY_MODE;
> +	if (!strcmp(optarg, mode_str[MEM_MODE]))
> +		return MEM_MODE;
> +	if (!strcmp(optarg, mode_str[DISK_MODE]))
> +		return DISK_MODE;
> +	if (!strcmp(optarg, mode_str[ON_MODE]))
> +		return ON_MODE;
> +	if (!strcmp(optarg, mode_str[NO_MODE]))
> +		return NO_MODE;
> +	if (!strcmp(optarg, mode_str[OFF_MODE]))
> +		return OFF_MODE;
> +	if (!strcmp(optarg, mode_str[FREEZE_MODE]))
> +		return FREEZE_MODE;
> +	if (!strcmp(optarg, mode_str[DISABLE_MODE]))
> +		return DISABLE_MODE;
> +	if (!strcmp(optarg, mode_str[SHOW_MODE]))
> +		return SHOW_MODE;

 {
    for (i = 0; i < ARRAY_SIZE(mode_str); i++)
         if (strcmp(optarg, mode_str[i])
             return i;

    return -EINVAL;
 }

> -	if (!alarm && !seconds && strcmp(suspend,"disable") &&
> -				  strcmp(suspend,"show")) {
> -
> +	if (!alarm && !seconds && suspend < DISABLE_MODE) {

 this ("<") is pretty fragile, use

         && (suspend != DISABLE_MODE || suspend != SHOW_MODE)

>  		warnx(_("must provide wake time (see -t and -s options)"));
>  		usage(stderr);

...

> -	if (strcmp(suspend, "show") && strcmp(suspend, "disable")) {
> -		if (strcmp(suspend, "no") && strcmp(suspend, "on") &&
> -		    strcmp(suspend, "off") && is_suspend_available(suspend) <= 0) {
> -			errx(EXIT_FAILURE, _("suspend to \"%s\" unavailable"), suspend);
> +	if (suspend < DISABLE_MODE) {
> +		if (suspend < OFF_MODE && is_suspend_available(suspend) <= 0) {
> +			errx(EXIT_FAILURE, _("suspend to \"%s\" unavailable"),
> +			     mode_str[suspend]);
  		}

 the same situation

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
