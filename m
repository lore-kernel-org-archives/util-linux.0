Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: some quesion about test_uuidd
Date: Mon, 8 Feb 2016 13:55:22 +0100
Cc: util-linux@vger.kernel.org
References: <201602081146.04421.sweet_f_a@gmx.de> <20160208120848.xno2uesyuyc4y4wh@ws.net.home>
In-Reply-To: <20160208120848.xno2uesyuyc4y4wh@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201602081355.23476.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Monday 08 February 2016, Karel Zak wrote:
> On Mon, Feb 08, 2016 at 11:46:04AM +0100, Ruediger Meier wrote:
> > Hi,
> >
> > since 963f128c we are building test_uuidd in tests/helpers.
> >
> > Where do we use test_uuidd at the moment?
>
> I don't think we use it, it's mostly for manual testing now.
>
> > Because it breakes "configure --disable-libuuid we should guard the
> > test_uuidd build either bei BUILD_LIBUUID or by BUILD_UUIDD. Maybe
> > it should also be moved to misc-utils/ (where uuidd lives) or
> > libuuid/src/ (where test_uuid lives). Opinions?
>
> Yes, misc-utils/test_uuidd.c would be better place for the code.

I will do that.

cu,
Rudi
