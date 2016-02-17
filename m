Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:52568 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964967AbcBQCVG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Feb 2016 21:21:06 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: J William Piggott <elseifthen@gmx.com>
Subject: Re: [PATCH 1/1] hwclock.c, hwclock.8.in: new --show format
Date: Wed, 17 Feb 2016 03:20:51 +0100
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        Sami Kerola <kerolasa@iki.fi>
References: <56BD2A87.30009@gmx.com> <20160216102941.r2ttlt6y2kv4pnem@ws.net.home> <56C3D4BF.5030608@gmx.com>
In-Reply-To: <56C3D4BF.5030608@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201602170320.51509.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 17 February 2016, J William Piggott wrote:
> On 02/16/2016 05:29 AM, Karel Zak wrote:
> > On Thu, Feb 11, 2016 at 07:48:40PM -0500, J William Piggott wrote:
> >> -		lt = localtime(&hwctime.tv_sec);
> >> -		strftime(ctime_now, sizeof(ctime_now), format, lt);
> >> -		printf(_("%s and %06d microseconds\n"), ctime_now,
> >> (int)hwctime.tv_usec); +		struct tm lt;
> >> +		int zhour, zmin;
> >> +
> >> +		lt = *localtime(&hwctime.tv_sec);
> >> +		zhour = - timezone / 60 / 60;
> >> +		zmin = abs(timezone / 60 % 60);
> >> +		printf(_("%4d-%.2d-%.2d %02d:%02d:%02d.%06d%+02d:%02d\n"),
> >> +		       lt.tm_year + 1900, lt.tm_mon + 1, lt.tm_mday,
> >> lt.tm_hour, +		       lt.tm_min, lt.tm_sec, (int)hwctime.tv_usec,
> >> zhour, zmin);
> >
> > Some notes:
> >
> > * what's wrong with strftime?
>
> Why use resources on strftime when 8601 prints directly?
>
> While it can do other formatting, I see strftime's main purpose as
> converting tm numbers into strings like: January, Monday, etc.
>
> > * We already use ISO time in util-linux and we use time designator
> > 'T' (separator between date and time).
>
> I chose to use the optional space as a compromise between machine
> friendly and human friendly, this is commonly done I think.
>
> > * tv_usec is "long"
>
> Fixed: I followed the example from the recent commit c211401 (for
> code consistency, which is why I originally used the int cast), and
> cast it to long; although I do not understand why as it is already
> long. All that needed to be done was to change the conversion length
> modifier and drop the cast.

It's not long on all systems, e.g.__darwin_suseconds_t is int. Casting 
to long seems to be the way to avoid warnings everywhere.

> PULL:
>
>   git@github.com:jwpi/util-linux.git 020716
>
> for you to fetch changes up to 
e05ac5aae00913e7a999c96a7bb731dc1d09cc5c:
> > * fraction separator is decimal mark, either a comma or a dot, but
> >   with a preference for a comma according to ISO 8601:2004
> >   (wikipedia).
> >
> >   -- we already use comma in util-linux, exception is logger where
> > I see dot :-(
>
> I actually modeled the format after:
>
> date --rfc-3339=ns
> 2016-02-16 20:13:25.601508440-05:00
>
> 3339 is a subset of 8601 that requires using a period for the radix
> point. As I said previously, I chose this as a compromise between
> machine and human readability. As it is output to tty by default, I
> thought doing so might mitigate any push back against the format
> change.
>
> I am not strongly opposed to using 'T' as the date-time delimiter or
> comma as the radix point. I just think 'space' and 'period' are a
> commonly used compromise.
>
> > Anyway, it would be really nice to have a function for this purpose
> > in lib/timeutils.c to avoid duplication and creativity :-)
> > Something like:
> >
> >
> >     strtime_iso_8601(char buf, size_t bufsz, struct tm tm, struct
> > timeval frac, int flags);
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
> Also, perhaps all the above only using something similar to
> coreutil's fprintftime, so it prints directly using less resources.
>
> >     Karel
>
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
