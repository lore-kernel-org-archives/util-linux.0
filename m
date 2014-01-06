Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:64020 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbaAFNIg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 6 Jan 2014 08:08:36 -0500
Date: Mon, 6 Jan 2014 14:08:32 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Mike Frysinger <vapier@gentoo.org>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: tests: cal/bigyear only works on 64bit (sizeof(long) == 8)
 systems
Message-ID: <20140106130832.GF31045@x2.net.home>
References: <201312222142.44536.vapier@gentoo.org>
 <20140106123040.GA31045@x2.net.home>
 <CAG27Bk0wpvkoRxL1G4Yd6AE8J9L6tCZzeeYr6qX_KDn+MCwYew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0wpvkoRxL1G4Yd6AE8J9L6tCZzeeYr6qX_KDn+MCwYew@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 06, 2014 at 12:55:08PM +0000, Sami Kerola wrote:
> On 6 January 2014 12:30, Karel Zak <kzak@redhat.com> wrote:
> > On Sun, Dec 22, 2013 at 09:42:43PM -0500, Mike Frysinger wrote:
> >> that's a signed long type, so on 32bit systems, you get:
> >>           cal: Year 1234567890123456789       ...cal: illegal year value:
> >>
> >> should the test detect the sizeof(long) and then calculate a number that is
> >> smaller than that ?
> >
> >  It would be better to keep cal(1) arch insensitive.
> >
> >  Sami, why we need so huge year numbers and why the number is signed?
> >  I guess it would be enough to  use "unsigned int" (UINT_MAX is 4294967295).
> 
> Hi Mike & Karel,
> 
> Year was left signed because someone said it might be interesting to
> know pre-year-zero outputs. After a bit research the pre-zero year
> calendars are theoretical construct, mostly because agreement in

but the code is:

    #define SMALLEST_YEAR           1

    if (ctl.req.year < SMALLEST_YEAR)
          errx(EXIT_FAILURE,  _("illegal year value: use positive integer"));

> western world is not more than couple hundred years old. That means
> pre-zero calendar could only be considered as a what a modern western
> people think the calendar should have looked. Whether that is
> valuable, interesting, useful, etc is a different question.
> 
> Meanwhile the big year test is clearly broken. I recon there should be
> a version for various sizes of INT_MAX tests, and depending how large
> values are supported by system corresponding tests are ran.

 INT_MAX is the same everywhere, all you need is to remove arch
 specific "long" from the code and use strtos32_or_err() to parse the
 year number.
 
 (Well, I guess that 2147483647 years is enough :-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
