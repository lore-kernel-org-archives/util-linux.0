Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57897 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754566AbcBPK3o (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Feb 2016 05:29:44 -0500
Date: Tue, 16 Feb 2016 11:29:41 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org, Ruediger Meier <ruediger.meier@ga-group.nl>,
        Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH 1/1] hwclock.c, hwclock.8.in: new --show format
Message-ID: <20160216102941.r2ttlt6y2kv4pnem@ws.net.home>
References: <56BD2A87.30009@gmx.com>
 <56BD2BE8.3030501@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56BD2BE8.3030501@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 11, 2016 at 07:48:40PM -0500, J William Piggott wrote:
> -		lt = localtime(&hwctime.tv_sec);
> -		strftime(ctime_now, sizeof(ctime_now), format, lt);
> -		printf(_("%s and %06d microseconds\n"), ctime_now, (int)hwctime.tv_usec);
> +		struct tm lt;
> +		int zhour, zmin;
> +
> +		lt = *localtime(&hwctime.tv_sec);
> +		zhour = - timezone / 60 / 60;
> +		zmin = abs(timezone / 60 % 60);
> +		printf(_("%4d-%.2d-%.2d %02d:%02d:%02d.%06d%+02d:%02d\n"),
> +		       lt.tm_year + 1900, lt.tm_mon + 1, lt.tm_mday, lt.tm_hour,
> +		       lt.tm_min, lt.tm_sec, (int)hwctime.tv_usec, zhour, zmin);

Some notes:

* what's wrong with strftime? 

* We already use ISO time in util-linux and we use time designator 'T' (separator
  between date and time).

* tv_usec is "long"

* fraction separator is decimal mark, either a comma or a dot, but
  with a preference for a comma according to ISO 8601:2004
  (wikipedia).

  -- we already use comma in util-linux, exception is logger where I
  see dot :-(


Anyway, it would be really nice to have a function for this purpose in
lib/timeutils.c to avoid duplication and creativity :-) Something like:


    strtime_iso_8601(char buf, size_t bufsz, struct tm tm, struct timeval frac, int flags);

where flags are

    enum {
         ISO_8601_TIMEZONE   = (1 << 1)
         ISO_8601_USEC       = (1 << 2)
         ...
    };

then we can use this function in lslogins, dmesg, hwclock, last,
logger, ... etc.  I can also imagine:

    strtime_short_ctime()
    strtime_ctime()           (ctime without \n)

Comments?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
