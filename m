Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755453AbdLTRmp (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 20 Dec 2017 12:42:45 -0500
Date: Wed, 20 Dec 2017 18:42:41 +0100
From: Karel Zak <kzak@redhat.com>
To: Adam Sampson <ats@offog.org>
Cc: util-linux@vger.kernel.org
Subject: Re: v2.32 cal(1)
Message-ID: <20171220174241.7n4szla6vxwv3fum@ws.net.home>
References: <20171219132906.74xm7nm4r3trr4qq@ws.net.home>
 <y2amv2ds6q0.fsf@offog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <y2amv2ds6q0.fsf@offog.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 20, 2017 at 04:29:43PM +0000, Adam Sampson wrote:
> Karel Zak <kzak@redhat.com> writes:
> 
> > The problem is that year 1752 is very specific to British Empire and
> > for example Catholic Europe moved to the Gregorian calendar in year
> > 1582.
> ...
> > * later (after warning in release notes) we can make --gregorian as
> >   the default
> 
> The date of cal's switch is specified in POSIX as 1752, though:
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/cal.html
> (with a note that future versions may make this depend on the locale).

It sounds like too complicated semantic to depend on locale. Don't
also forget that switch from one calendar to another means extra
calculation (for example skip 11 days for British Empire way, etc).

> So if the default is changed, it would be worth noting the deviation
> from POSIX in the man page, and maybe even defaulting to the old

Good point.

> behaviour if POSIXLY_CORRECT is defined, as, e.g., coreutils does for
> other bits of dubious but mandated behaviour.
> 
> I wonder if it might be more helpful just to report an error if cal is
> run for a year prior to 1926 without explicitly specifying which
> calendar to use?

I think we can follow the current default behavior for ever, and just
add --iso/--gregorian for people who care.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
