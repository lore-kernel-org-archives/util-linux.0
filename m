Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:42955 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbbCAMXf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Mar 2015 07:23:35 -0500
Received: by wesw62 with SMTP id w62so28311207wes.9
        for <util-linux@vger.kernel.org>; Sun, 01 Mar 2015 04:23:34 -0800 (PST)
Date: Sun, 1 Mar 2015 12:23:33 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 02/13] rtcwake: enumerate constant mode strings
In-Reply-To: <20150224123430.GQ19430@ws.net.home>
Message-ID: <alpine.LNX.2.03.1503011220510.822@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi> <1424616139-638-3-git-send-email-kerolasa@iki.fi> <20150224123430.GQ19430@ws.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 24 Feb 2015, Karel Zak wrote:

> On Sun, Feb 22, 2015 at 02:42:08PM +0000, Sami Kerola wrote:
> > Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> > ---
> >  sys-utils/rtcwake.c | 126 ++++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 78 insertions(+), 48 deletions(-)
> > 
> > diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
> > index 8b5f69c..372e620 100644
> > --- a/sys-utils/rtcwake.c
> > +++ b/sys-utils/rtcwake.c
> > @@ -52,7 +52,37 @@
> >  #define RTC_PATH		"/sys/class/rtc/%s/device/power/wakeup"
> >  #define SYS_POWER_STATE_PATH	"/sys/power/state"
> >  #define DEFAULT_DEVICE		"/dev/rtc0"
> > -#define DEFAULT_MODE		"standby"
> > +
> > +enum rtc_modes {	/* manual page --mode option explains these. */
> > +	STANDBY_MODE = 0,
> > +	MEM_MODE,
> > +	FREEZE_MODE,
> > +	DISK_MODE,	/* end of Documentation/power/states.txt modes  */
> > +	OFF_MODE,
> > +	NO_MODE,
> > +	ON_MODE,	/* smaller <- read the code */
> > +	DISABLE_MODE,	/* greater <- to understand */
> > +	SHOW_MODE,
> > +	ERROR_MODE	/* invalid user input */
> > +};
> 
> Please, don't use ERROR_MODE or so, just return -EINVAL from the
> parser.
> 
> > +static int get_mode(const char *optarg)
> > +{
> > +	if (!strcmp(optarg, mode_str[STANDBY_MODE]))
> > +		return STANDBY_MODE;
> > +	if (!strcmp(optarg, mode_str[MEM_MODE]))
> > +		return MEM_MODE;
> > +	if (!strcmp(optarg, mode_str[DISK_MODE]))
> > +		return DISK_MODE;
> > +	if (!strcmp(optarg, mode_str[ON_MODE]))
> > +		return ON_MODE;
> > +	if (!strcmp(optarg, mode_str[NO_MODE]))
> > +		return NO_MODE;
> > +	if (!strcmp(optarg, mode_str[OFF_MODE]))
> > +		return OFF_MODE;
> > +	if (!strcmp(optarg, mode_str[FREEZE_MODE]))
> > +		return FREEZE_MODE;
> > +	if (!strcmp(optarg, mode_str[DISABLE_MODE]))
> > +		return DISABLE_MODE;
> > +	if (!strcmp(optarg, mode_str[SHOW_MODE]))
> > +		return SHOW_MODE;
> 
>  {
>     for (i = 0; i < ARRAY_SIZE(mode_str); i++)
>          if (strcmp(optarg, mode_str[i])
>              return i;
> 
>     return -EINVAL;
>  }
> 
> > -	if (!alarm && !seconds && strcmp(suspend,"disable") &&
> > -				  strcmp(suspend,"show")) {
> > -
> > +	if (!alarm && !seconds && suspend < DISABLE_MODE) {
> 
>  this ("<") is pretty fragile, use
> 
>          && (suspend != DISABLE_MODE || suspend != SHOW_MODE)
> 
> >  		warnx(_("must provide wake time (see -t and -s options)"));
> >  		usage(stderr);
> 
> ...
> 
> > -	if (strcmp(suspend, "show") && strcmp(suspend, "disable")) {
> > -		if (strcmp(suspend, "no") && strcmp(suspend, "on") &&
> > -		    strcmp(suspend, "off") && is_suspend_available(suspend) <= 0) {
> > -			errx(EXIT_FAILURE, _("suspend to \"%s\" unavailable"), suspend);
> > +	if (suspend < DISABLE_MODE) {
> > +		if (suspend < OFF_MODE && is_suspend_available(suspend) <= 0) {
> > +			errx(EXIT_FAILURE, _("suspend to \"%s\" unavailable"),
> > +			     mode_str[suspend]);
>   		}
> 
>  the same situation

Thanks Karel,

The get_mode() is simplified, and places where order of enum mattered 
(fragile) are made to be explicit what modes are/aren't allowed.

https://github.com/kerolasa/lelux-utiliteetit/commit/bfdcfc8177bc9b7c724ee0adc779083a01b13399

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
