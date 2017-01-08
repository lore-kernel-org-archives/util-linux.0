Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:51339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754925AbdAHV2i (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 8 Jan 2017 16:28:38 -0500
Subject: Re: pull: hwclock 27 changes
To: kerolasa@gmail.com
References: <20161231214107.8658-1-kerolasa@iki.fi>
 <05e4405f-8096-9261-f9f2-d2c6b84675bc@gmx.com>
 <070fc458-ed69-a09c-11cc-42bb50fec888@gmx.com>
 <alpine.LNX.2.20.1701072212010.9096@imuri>
 <CAG27Bk2Kg4MQFKSDwAxM849HJ7AxZWLX1vGL21qO042za=V1pw@mail.gmail.com>
From: J William Piggott <elseifthen@gmx.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-ID: <eaaddf6f-dd4b-cd91-cfec-07d45bb07542@gmx.com>
Date: Sun, 8 Jan 2017 16:21:49 -0500
MIME-Version: 1.0
In-Reply-To: <CAG27Bk2Kg4MQFKSDwAxM849HJ7AxZWLX1vGL21qO042za=V1pw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 01/08/2017 04:39 AM, Sami Kerola wrote:
> On 7 January 2017 at 23:06, Sami Kerola <kerolasa@iki.fi> wrote:
>> On Sat, 7 Jan 2017, J William Piggott wrote:
>>   git://github.com/kerolasa/lelux-utiliteetit.git hwclock-jwp-reviewed
>>
>> that has in almost all changes 'Reviewed-by: J William Piggott
>> <elseifthen@gmx.com>'. Notice also that the latest update is not 100%
>> ready. We have question of --compare open, and 'hwclock: move command-line
>> options to control structure' has issue that is not yet corrected yet.
> 
> hwclock-jwp-reviewed got update:
> 
> -- snip
> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index b41acd450..c3bcc2fa0 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -1245,11 +1245,6 @@ manipulate_clock(const struct hwclock_control
> *ctl, const time_t set_time,
>   adjtime->dirty = TRUE;
>   }
> 
> - if (ctl->noadjfile || (ctl->systz && (ctl->utc || ctl->local_opt))) {
> - /* A little trick to avoid writing the file if we don't have to */
> - adjtime->dirty = FALSE;
> - }
> -
>   if (ctl->show || ctl->get || ctl->adjust || ctl->hctosys
>      || (!ctl->noadjfile && !ctl->systz && !ctl->predict)) {
>   /* data from HW-clock are required */
> @@ -1558,7 +1553,7 @@ int main(int argc, char **argv)
>  {
>   struct hwclock_control ctl = { 0 };
>   struct timeval startup_time;
> - struct adjtime adjtime;
> + struct adjtime adjtime = { 0 };
>   /*
>   * The time we started up, in seconds into the epoch, including
>   * fractions.
> @@ -1839,8 +1834,12 @@ int main(int argc, char **argv)
>   }
>   }
> 
> - if ((rc = read_adjtime(&ctl, &adjtime)) != 0)
> - hwclock_exit(&ctl, rc);
> + if (!ctl.noadjfile && !(ctl.systz && (ctl.utc || ctl.local_opt))) {
> + if ((rc = read_adjtime(&ctl, &adjtime)) != 0)
> + hwclock_exit(&ctl, rc);
> + } else
> + /* avoid writing adjtime file if we don't have to */
> + adjtime.dirty = FALSE;
>   ctl.universal = hw_clock_is_utc(&ctl, adjtime);
>   if (ctl.compare) {
>   if (compare_clock(&ctl))
> -- snip
> 
> that should fix:


Yes, this looks good I think.

The contents of the added if/else statements don't look indented though.

I like your improved comment, you might want to capitalize it and use
a period.

 8< ---- 

