Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37387 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933925AbcBQKye (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 17 Feb 2016 05:54:34 -0500
Date: Wed, 17 Feb 2016 11:54:32 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org, Ruediger Meier <ruediger.meier@ga-group.nl>,
        Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH 1/1] hwclock.c, hwclock.8.in: new --show format
Message-ID: <20160217105432.vo2r3eks3ho26v7m@ws.net.home>
References: <56BD2A87.30009@gmx.com>
 <56BD2BE8.3030501@gmx.com>
 <20160216102941.r2ttlt6y2kv4pnem@ws.net.home>
 <56C3D4BF.5030608@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56C3D4BF.5030608@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 16, 2016 at 09:02:39PM -0500, J William Piggott wrote:
> 
> On 02/16/2016 05:29 AM, Karel Zak wrote:
> > On Thu, Feb 11, 2016 at 07:48:40PM -0500, J William Piggott wrote:
> >> -		lt = localtime(&hwctime.tv_sec);
> >> -		strftime(ctime_now, sizeof(ctime_now), format, lt);
> >> -		printf(_("%s and %06d microseconds\n"), ctime_now, (int)hwctime.tv_usec);
> >> +		struct tm lt;
> >> +		int zhour, zmin;
> >> +
> >> +		lt = *localtime(&hwctime.tv_sec);
> >> +		zhour = - timezone / 60 / 60;
> >> +		zmin = abs(timezone / 60 % 60);
> >> +		printf(_("%4d-%.2d-%.2d %02d:%02d:%02d.%06d%+02d:%02d\n"),
> >> +		       lt.tm_year + 1900, lt.tm_mon + 1, lt.tm_mday, lt.tm_hour,
> >> +		       lt.tm_min, lt.tm_sec, (int)hwctime.tv_usec, zhour, zmin);
> > 
> > Some notes:
> > 
> > * what's wrong with strftime? 
> 
> Why use resources on strftime when 8601 prints directly?
> 
> While it can do other formatting, I see strftime's main purpose as
> converting tm numbers into strings like: January, Monday, etc.

 It does more things for you, see lt.tm_year + 1900, lt.tm_mon + 1,
 calculation of the time zone hours, timezone minutes...

> > Anyway, it would be really nice to have a function for this purpose in
> > lib/timeutils.c to avoid duplication and creativity :-) Something like:
> > 
> > 
> >     strtime_iso_8601(char buf, size_t bufsz, struct tm tm, struct timeval frac, int flags);
> > 
> > where flags are
> > 
> >     enum {
> >          ISO_8601_TIMEZONE   = (1 << 1)
> >          ISO_8601_USEC       = (1 << 2)
> >          ...
> >     };
> > 
> > then we can use this function in lslogins, dmesg, hwclock, last,
> > logger, ... etc.  I can also imagine:
> > 
> >     strtime_short_ctime()
> >     strtime_ctime()           (ctime without \n)
> > 
> > Comments?
> 
> Also, perhaps all the above only using something similar to coreutil's
> fprintftime, so it prints directly using less resources.
 
Well, things don't end after commit. Someone has to maintain it for
years and for example now we have many places where we produces the
same time format. So, I'd like to keep it on one place and minimize
differences in formatting.

I'll merge your patch and cleanup the things later...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
