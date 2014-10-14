Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:3554 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343AbaJNJvj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Oct 2014 05:51:39 -0400
Date: Tue, 14 Oct 2014 11:51:31 +0200
From: Karel Zak <kzak@redhat.com>
To: JWP <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 6/7] hwclock: Add --update option
Message-ID: <20141014095131.GN8057@x2.net.home>
References: <5426D4C2.4060403@gmx.com>
 <5426D7F9.4030306@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5426D7F9.4030306@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Sep 27, 2014 at 11:30:01AM -0400, JWP wrote:
> 
> There are cases where we need to refresh the
> timestamps in the adjtime file without updating the
> drift factor.
> 
> For example, with ntpd and an Eleven Minute Mode
> kernel, we need to call systohc at shutdown to
> facilitate drift correction.  With the current
> behavior hwclock will clobber the drift factor to
> near zero, because the Hardware Clock and System
> Clock are synced by Eleven Minute Mode.  What
> actually needs to be done is refresh the adjtime
> file timestamps and not calculate a new drift
> factor.
> 
> Because it is a manual process to craft a good
> Hardware Clock drift factor, that is, there is no
> automated method that will produce a good drift
> factor, this patch changes the default drift

The ideal solution would be to generate event (for udev) in kernel
first time when Eleven Minute Mode modifies HW clock and send info
about the diff between HW and SYS time to userspace. Then it would be
possible to call something like "hwclock --set-drift <number>" from udev
rules. It means 11 minutes after reboot we will have nice usable
drift factor for the next system startup (--hctosys).

> calculation behavior to off, and it is turned on
> by using the --update option. Once we have a good
> drift factor for a given machine we do not want
> anything clobbering it, including an administrator
> forgetting to turn off recalculation. A system
> administrator should make a concious effort in
> telling hwclock with the --update option that
> (s)he wants to recalculate the drift factor.
> Without using the --update option with calibrate
> operations only the timestamps are refreshed in
> the adjtime file. With the --update option the old
> default behavior of refreshing the timestamps and
> updating the drift factor is performed.

The option "--update" seems to generic. It would be better
to use something like "--update-drift".

> +	if (!update) {
> +		/*
> +		 * Because the update option introduced new behavior to hwclock
> +		 * we warn when it is not used. After a reasonable introduction
> +		 * period this could be removed.
> +		 */
> +		warnx(_("--update option is now required to update drift factor."));

I'd like to see something like

   warnx(_("HW clock drift factor not updated by default. "
           "See --update-drift for more details."));

and maybe it should be visible in verbose mode only. All we need is to
inform distro maintainers by ReleaseNotes rather than fill logs by
confusing messages.

>  		rc = manipulate_clock(show, adjust, noadjfile, set, set_time,
>  			      hctosys, systohc, systz, startup_time, utc,
> -			      local_opt, testing, predict, get);
> +			      local_opt, update, testing, predict, get);

 This is why we need refactoring. 15 arguments to function? Grrr..

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
