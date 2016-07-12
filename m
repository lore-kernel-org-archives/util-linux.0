Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:62989 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912AbcGLVit (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Jul 2016 17:38:49 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: kerolasa@gmail.com
Subject: Re: [PATCH] hwclock: remove UTC-0 localization hack
Date: Tue, 12 Jul 2016 23:38:40 +0200
Cc: J William Piggott <elseifthen@gmx.com>,
        "util-linux" <util-linux@vger.kernel.org>
References: <20160710200242.2706-1-kerolasa@iki.fi> <201607121623.04891.sweet_f_a@gmx.de> <CAG27Bk3po26Bsb=E0A1UXDrTrkwPH1pEvqEKXFZ_n4PVOcxt8A@mail.gmail.com>
In-Reply-To: <CAG27Bk3po26Bsb=E0A1UXDrTrkwPH1pEvqEKXFZ_n4PVOcxt8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201607122338.40458.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 12 July 2016, Sami Kerola wrote:
> On 12 July 2016 at 15:23, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> > On Tuesday 12 July 2016, Sami Kerola wrote:
> >> On 11 July 2016 at 21:23, J William Piggott <elseifthen@gmx.com>
> >
> > wrote:
> >> > We use mktime(3) for portability.
> >> >
> >> > http://www.gnu.org/software/libc/manual/html_mono/libc.html#inde
> >> >x-t imegm
> >> >
> >> > Portability note: mktime is essentially universally available.
> >> > timegm is rather rare. For the most portable conversion from a
> >> > UTC broken-down time to a simple time, set the TZ environment
> >> > variable to UTC, call mktime, then set TZ back.
> >>
> >> I don't think hwclock(8) is portable. It has ioctl(2) calls, and
> >> such.
> >
> > But there are non-gnu libc's for Linux.
>
> Fair point, but can you name one that does not have timegm().
>
> https://github.com/cloudius-systems/musl/blob/master/src/time/timegm.
>c https://github.com/ensc/dietlibc/blob/master/libugly/timegm.c
> http://www.uclibc-ng.org/browser/uclibc-ng/libc/misc/time/timegm.c?or
>der=name


Yep, also musl has timegm. But at least it's good that William reminded 
us to check that! :)

cu,
Rudi
