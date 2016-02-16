Return-Path: util-linux-owner@vger.kernel.org
Received: from hotei.ga-group.nl ([148.251.146.68]:60293 "EHLO
	hotei.ga-group.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755854AbcBPUVN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 16 Feb 2016 15:21:13 -0500
From: Ruediger Meier <ruediger.meier@ga-group.nl>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 1/1] hwclock.c, hwclock.8.in: new --show format
Date: Tue, 16 Feb 2016 21:13:42 +0100
Cc: J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org,
        Sami Kerola <kerolasa@iki.fi>
References: <56BD2A87.30009@gmx.com> <56BD2BE8.3030501@gmx.com> <20160216102941.r2ttlt6y2kv4pnem@ws.net.home>
In-Reply-To: <20160216102941.r2ttlt6y2kv4pnem@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201602162113.42838.ruediger.meier@ga-group.nl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 16 February 2016, Karel Zak wrote:
> On Thu, Feb 11, 2016 at 07:48:40PM -0500, J William Piggott wrote:
> > -		lt = localtime(&hwctime.tv_sec);
> > -		strftime(ctime_now, sizeof(ctime_now), format, lt);
> > -		printf(_("%s and %06d microseconds\n"), ctime_now,
> > (int)hwctime.tv_usec); +		struct tm lt;
> > +		int zhour, zmin;
> > +
> > +		lt = *localtime(&hwctime.tv_sec);
> > +		zhour = - timezone / 60 / 60;
> > +		zmin = abs(timezone / 60 % 60);
> > +		printf(_("%4d-%.2d-%.2d %02d:%02d:%02d.%06d%+02d:%02d\n"),
> > +		       lt.tm_year + 1900, lt.tm_mon + 1, lt.tm_mday, lt.tm_hour,
> > +		       lt.tm_min, lt.tm_sec, (int)hwctime.tv_usec, zhour, zmin);
>
> Some notes:
>
> * what's wrong with strftime?

For me strftime always "sounds" locale and system dependent. If we don't 
want to use locale anyways then I would prefer printf to make this 
clear for the reader.

On the other hand if someone knows that our choosen ISO style is 
portable and locale independent implemented in any system's strftime, 
ok to use strftime then.

> * We already use ISO time in util-linux and we use time designator
> 'T' (separator between date and time).

I know that "T" is the best compromise. Anyways for humans I try to use 
space if possible. It simply looks better. IMO more important is that 
any parser code would accept space as well as 'T'.

> * tv_usec is "long"
>
> * fraction separator is decimal mark, either a comma or a dot, but
>   with a preference for a comma according to ISO 8601:2004
>   (wikipedia).
>
>   -- we already use comma in util-linux, exception is logger where I
>   see dot :-(

Where do we use comma? Usually I would prefer dot (for decimal fractions 
of seconds). I guess most people use dot and would be confused about 
comma. Existing software may more likely not accept comma. Like this 
example
https://github.com/moment/moment/issues/2580

> Anyway, it would be really nice to have a function for this purpose
> in lib/timeutils.c to avoid duplication and creativity :-) Something
> like:
>
>
>     strtime_iso_8601(char buf, size_t bufsz, struct tm tm, struct
> timeval frac, int flags);
>
> where flags are
>
>     enum {
>          ISO_8601_TIMEZONE   = (1 << 1)
>          ISO_8601_USEC       = (1 << 2)
>          ...
>     };
>
> then we can use this function in lslogins, dmesg, hwclock, last,
> logger, ... etc.  I can also imagine:
>
>     strtime_short_ctime()
>     strtime_ctime()           (ctime without \n)
>
> Comments?
>
>     Karel


