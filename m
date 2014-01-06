Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33026 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757028AbaAFXVE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Jan 2014 18:21:04 -0500
Received: by mail-pd0-f177.google.com with SMTP id q10so18660758pdj.22
        for <util-linux@vger.kernel.org>; Mon, 06 Jan 2014 15:21:04 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20140106130832.GF31045@x2.net.home>
References: <201312222142.44536.vapier@gentoo.org>
	<20140106123040.GA31045@x2.net.home>
	<CAG27Bk0wpvkoRxL1G4Yd6AE8J9L6tCZzeeYr6qX_KDn+MCwYew@mail.gmail.com>
	<20140106130832.GF31045@x2.net.home>
Date: Mon, 6 Jan 2014 23:21:03 +0000
Message-ID: <CAG27Bk1ROQ51LMyx=qjxasgX4MLBKy=_NiQZkcHbdhkMRzoC5A@mail.gmail.com>
Subject: Re: tests: cal/bigyear only works on 64bit (sizeof(long) == 8) systems
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Mike Frysinger <vapier@gentoo.org>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 6 January 2014 13:08, Karel Zak <kzak@redhat.com> wrote:
> On Mon, Jan 06, 2014 at 12:55:08PM +0000, Sami Kerola wrote:
>> Year was left signed because someone said it might be interesting to
>> know pre-year-zero outputs. After a bit research the pre-zero year
>> calendars are theoretical construct, mostly because agreement in
>
> but the code is:
>
>     #define SMALLEST_YEAR           1
>
>     if (ctl.req.year < SMALLEST_YEAR)
>           errx(EXIT_FAILURE,  _("illegal year value: use positive integer"));

Hi Karel,

That is correct right now. If negative years are allowed to be used
I'm sure bug reports will follow. The leap year printouts are
obviously wrong.

>> Meanwhile the big year test is clearly broken. I recon there should be
>> a version for various sizes of INT_MAX tests, and depending how large
>> values are supported by system corresponding tests are ran.
>
>  INT_MAX is the same everywhere, all you need is to remove arch
>  specific "long" from the code and use strtos32_or_err() to parse the
>  year number.
>
>  (Well, I guess that 2147483647 years is enough :-)

Use of 32 bit int is indeed the easiest fix, and I'm all in favor of
cutting the cal output there.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
